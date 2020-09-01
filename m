Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29B5C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 11:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9041B20767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 11:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dpyoAxpp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BLyLx/rj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgIAL7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 07:59:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39610 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgIALtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:49:36 -0400
Date:   Tue, 01 Sep 2020 11:48:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960888;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4HNpBAv9JX5N0pVmM5MRhlxRxkukNmZW4s9cCYdSkaI=;
        b=dpyoAxppVun632I5kW6gpCN+5tqnuHA4NzSlykcuwUQujZEfh6L2X8Dm50cX3rT1O0x2fc
        7ktRHF0e9m4eN90/Zb/dBBc8ck2/JQ2t9y4tOTjymahhPbsOScySf1XV9Mtkn5Py553cwq
        76yVkpnTHcvJdCf7Auvs9fiasrufa39xBhRPNHk/vv0uFPgucb2NCiyQmPm4ZAFoyNZM9K
        htXkICC/DcX6OJTO18T2IYq7OI+MYuCyD4lRr8iJjFl+yKagW3jkwm+4bRwOz/mUc4qJFn
        90MURysx5RXNsJZ2q7vCMWzh7M7EKeuvnmusv50X3AnFUN0vx2iPV+9TndEaZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960888;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4HNpBAv9JX5N0pVmM5MRhlxRxkukNmZW4s9cCYdSkaI=;
        b=BLyLx/rjO8DMo7pCluzYeMPV3edAxdIwrk/T4sSYSF/wtFmeJn1+JLBdaeHejdmILq3YG8
        WdWk7+NWabpOjSAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/static_call] module: Properly propagate
 MODULE_STATE_COMING failure
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, Jessica Yu <jeyu@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200818135804.444372853@infradead.org>
References: <20200818135804.444372853@infradead.org>
MIME-Version: 1.0
Message-ID: <159896088820.20229.8665357366832877434.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/static_call branch of tip:

Commit-ID:     59cc8e0a906ea23190922e5e0252e5b5a60d70c2
Gitweb:        https://git.kernel.org/tip/59cc8e0a906ea23190922e5e0252e5b5a60d70c2
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 18 Aug 2020 15:57:38 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 09:58:04 +02:00

module: Properly propagate MODULE_STATE_COMING failure

Now that notifiers got unbroken; use the proper interface to handle
notifier errors and propagate them.

There were already MODULE_STATE_COMING notifiers that failed; notably:

 - jump_label_module_notifier()
 - tracepoint_module_notify()
 - bpf_event_notify()

By propagating this error, we fix those users.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Jessica Yu <jeyu@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20200818135804.444372853@infradead.org
---
 kernel/module.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 1c5cff3..3c465cf 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3792,9 +3792,13 @@ static int prepare_coming_module(struct module *mod)
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
