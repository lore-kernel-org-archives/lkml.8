Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44C7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8039C208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TD0wLr1V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R/MiIarF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732200AbgGaJWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732160AbgGaJWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BA2C061574;
        Fri, 31 Jul 2020 02:22:40 -0700 (PDT)
Date:   Fri, 31 Jul 2020 09:22:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187357;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/uZsYkHVT4l3QqFIAVT0CBAkiHxCXbKQJau+svWt4BI=;
        b=TD0wLr1VFx3SCndtUUmMvGPNVZ9Maoyk3qCfM2BhurOSNFjSXXfNaHrzg7778zMuqGZ13d
        wMQHuSm3qxwUkWfZs9JccfBh2hUTURK+9OaoG1DLlxHg3y/KEwsjVFc9aAHtAXTROd9Mfo
        Gn5R3lsb+Je/FT5i8Az+8ZO2bBMOKEiWXOxt61/cqho0yyHHfIa23P/M9eCuMk0WieSv4t
        T3swSR7gpI/jtNUDqEl+PPigPCXZtTE6Eh7VH1tM2EVobQ+aR8+A6rPm6m85/r2wP7MOOP
        8UdTlgKdsXNYfEJDqA+ARMn/rgaEyD6Q0BCEeNAjArex6Az0gVQeGjeLXFm1iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187357;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/uZsYkHVT4l3QqFIAVT0CBAkiHxCXbKQJau+svWt4BI=;
        b=R/MiIarF/mf8Jv3hEtj4+DC+ORKeoe2h9KcZbpK8G/Btqz/tVfKQYDZda4kFgsGFLuq/oe
        3p9C3y2ovx93PWDA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Dump ftrace at shutdown only if requested
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618735684.4006.13046716104227374531.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     2102ad290af06119ccfb56ddc3a0e5011a91537e
Gitweb:        https://git.kernel.org/tip/2102ad290af06119ccfb56ddc3a0e5011a91537e
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 16 Jun 2020 15:38:24 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:01:45 -07:00

torture: Dump ftrace at shutdown only if requested

If there is a large number of torture tests running concurrently,
all of which are dumping large ftrace buffers at shutdown time, the
resulting dumping can take a very long time, particularly on systems
with rotating-rust storage.  This commit therefore adds a default-off
torture.ftrace_dump_at_shutdown module parameter that enables
shutdown-time ftrace-buffer dumping.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 kernel/torture.c                                | 6 +++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a0dcc92..9f11ff8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5096,6 +5096,13 @@
 			Prevent the CPU-hotplug component of torturing
 			until after init has spawned.
 
+	torture.ftrace_dump_at_shutdown= [KNL]
+			Dump the ftrace buffer at torture-test shutdown,
+			even if there were no errors.  This can be a
+			very costly operation when many torture tests
+			are running concurrently, especially on systems
+			with rotating-rust storage.
+
 	tp720=		[HW,PS2]
 
 	tpm_suspend_pcr=[HW,TPM]
diff --git a/kernel/torture.c b/kernel/torture.c
index a1a4148..1061492 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -45,6 +45,9 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
 static bool disable_onoff_at_boot;
 module_param(disable_onoff_at_boot, bool, 0444);
 
+static bool ftrace_dump_at_shutdown;
+module_param(ftrace_dump_at_shutdown, bool, 0444);
+
 static char *torture_type;
 static int verbose;
 
@@ -527,7 +530,8 @@ static int torture_shutdown(void *arg)
 		torture_shutdown_hook();
 	else
 		VERBOSE_TOROUT_STRING("No torture_shutdown_hook(), skipping.");
-	rcu_ftrace_dump(DUMP_ALL);
+	if (ftrace_dump_at_shutdown)
+		rcu_ftrace_dump(DUMP_ALL);
 	kernel_power_off();	/* Shut down the system. */
 	return 0;
 }
