Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FF3C47258
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EC1E21924
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s0zqCEop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgEAUbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 16:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgEAUbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 16:31:42 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FA5C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 13:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=iXfBC10z2guuYoMIFO27yM0olz1TLRsDuJVoFNKxfeg=; b=s0zqCEop0L9n8zRx8urcabu+oz
        XkpAJDWMkgqZQee9TMnxoQg9l13GMW+me44JE4l5cRJzk1g2ZIaoe+ovs9FfqSZrm2Kjb45aDuLFR
        MXFxG9V8mvwg/hJZEm3NZZgYUxImx8QEYU7TMOKqpi3066+Ze5HJKqdWxhT9PV6nTwZcYjaM1dUE9
        PElTPQczP0g8XFPeZ4qHWpLKJHRHKOFsRgXicOL2JLaaNtZRthwJuzIE0vvybJ0jY7Fj48V/3uZzz
        mZ1MyK0QWNDHzsErzYQbQB5oM7Ab3yqItx73o4+xWjweA8z03pzBw+Z2mAbAx3Ic7QifPtevvB4N1
        bkRkni/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUcJL-0007R2-L9; Fri, 01 May 2020 20:31:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D2A3B30377D;
        Fri,  1 May 2020 22:31:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B7E0525BAEC04; Fri,  1 May 2020 22:31:00 +0200 (CEST)
Message-Id: <20200501202943.951742836@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 01 May 2020 22:28:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, Miroslav Benes <mbenes@suse.cz>,
        Jessica Yu <jeyu@kernel.org>
Subject: [PATCH v4 03/18] module: Properly propagate MODULE_STATE_COMING failure
References: <20200501202849.647891881@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that notifiers got unbroken; use the proper interface to handle
notifier errors and propagate them.

There were already MODULE_STATE_COMING notifiers that failed; notably:

 - jump_label_module_notifier()
 - tracepoint_module_notify()
 - bpf_event_notify()

By propagating this error, we fix those users.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Jessica Yu <jeyu@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 kernel/module.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3751,9 +3751,13 @@ static int prepare_coming_module(struct
 	if (err)
 		return err;
 
-	blocking_notifier_call_chain(&module_notify_list,
-				     MODULE_STATE_COMING, mod);
-	return 0;
+	err = blocking_notifier_call_chain_robust(&module_notify_list,
+			MODULE_STATE_COMING, MODULE_STATE_GOING, mod);
+	err = notifier_to_errno(err);
+	if (err)
+		klp_module_going(mod);
+
+	return err;
 }
 
 static int unknown_module_param_cb(char *param, char *val, const char *modname,


