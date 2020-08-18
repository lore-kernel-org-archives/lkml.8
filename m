Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EA6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE0AB207DE
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="de/bJLOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgHROOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbgHROMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:12:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9F2C06134A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=iXfBC10z2guuYoMIFO27yM0olz1TLRsDuJVoFNKxfeg=; b=de/bJLOKjjdP/1TNw+7Z6hbvqM
        6wEsPuYTH82KtYLUC02FrWiUs8dqrofAz+ry/i1tr6hlC8yM0GYcMGf5l9BoOpVg3jJgHpK4BUw/O
        JIAVP/BYrG6Rfb5hgaKKdVBd0hBhMuPJEm1o/hAbgf7KSX0F/46Ey+ZYFJ/MDg5ZIAOVJ8+kdDBA6
        oeu3eWZycb0blnlyTgjQfpIXWdVx2Jg3w9fWrRZn6BrD5KfnxQWEj9pmI4EkrAJDZD5HX9a5FPgdP
        WKCdvl0QA5suVJiebJNk+PGKJFrgz6O8zV5AJjEO9afVC6n8h5kSiiIxqPN1+W39ZJAOFJgvib5/9
        Cy+9HEdQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k82LI-0006Uz-Vz; Tue, 18 Aug 2020 14:12:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BDB8B305DD1;
        Tue, 18 Aug 2020 16:11:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9FC8F23D42C02; Tue, 18 Aug 2020 16:11:59 +0200 (CEST)
Message-ID: <20200818135804.444372853@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 18 Aug 2020 15:57:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, linux@rasmusvillemoes.dk,
        Miroslav Benes <mbenes@suse.cz>, Jessica Yu <jeyu@kernel.org>
Subject: [PATCH v7 03/18] module: Properly propagate MODULE_STATE_COMING failure
References: <20200818135735.948368560@infradead.org>
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


