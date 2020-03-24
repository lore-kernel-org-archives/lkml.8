Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF363C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837C620788
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RQ16tyMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgCXOY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:24:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36240 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbgCXOYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=BilAV98/xyLJ3rbbbATq+anaMYfZWr9rp+kix4JP/Vc=; b=RQ16tyMhg3v/DXDAtMI7QGZpKI
        E6D5YHlLu4jXeF2ogb56sXdPbd52pw/bGOStKLkgXZxt7kRQAgNY3C4jFTDPXitvXOMSfo3cY4RZ7
        1qVdE/DpB7mLllNVKgpSk6D5m3lVb/tkKt5Pk8k3ScaR64a8Q0JuRDBGnUvl2DH07OUYH/dPMJ+8t
        XveGudeDx5jckhtCl0OucQ0yULa3odzlFZpTsZRDnWJFXAs065yTjwtCFS2uz9PCNxRCqYW7N8Jl6
        k1SdP6bmQcK10VmATcpwZMDfa6Gem7z2vH9Z2iSPfX0COndo5Kji4cCFR1jwTE2XhXubPpeZ59/7V
        qqMS7MIg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGkTt-0001fd-KH; Tue, 24 Mar 2020 14:24:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0F19F307444;
        Tue, 24 Mar 2020 15:24:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id ED5BF286C13B0; Tue, 24 Mar 2020 15:24:34 +0100 (CET)
Message-Id: <20200324142245.445253190@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 14:56:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, jeyu@kernel.org
Subject: [RESEND][PATCH v3 03/17] module: Properly propagate MODULE_STATE_COMING failure
References: <20200324135603.483964896@infradead.org>
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
Cc: jeyu@kernel.org
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


