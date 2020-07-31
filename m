Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBF1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B71C208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OdVtZirS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ickxYHOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732415AbgGaJXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:23:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56344 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732294AbgGaJW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:59 -0400
Date:   Fri, 31 Jul 2020 09:22:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187377;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=n45tXQtk9gACvW83Q2OYZpK0lXR88cuRw4dUM/hytfs=;
        b=OdVtZirS07vuYbYNbHNFeGIbu0Hn+IjaYf4p0/+q05I4cWhUz8ad+NSzOGZ7kVMQaZkXcO
        x1J6qD5oIwG5BlMbhLKTnY0XVJnA3sBb6HYAv5KV2e9ENNJzQMytRNVJJQVlep+ifzv+aM
        xbQK8Ve+AWrv843nXVfHGq88mwihIwGodKd425cOz20Pe5ErhSOBsKr76R9+F3d9EiLZdy
        ZNAeGyjg3hZVvFTgzQKwjjI6MT5JGpTBmfeRZk7wMrx2oRpTrabvcWA+9Ni0AaH2L1sZu7
        fKQC5NuC+2l6YaqDNCp6FDkoVbCcEQ429h3MFnjFdn5+9RUC7U8Zp7YFiei48w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187377;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=n45tXQtk9gACvW83Q2OYZpK0lXR88cuRw4dUM/hytfs=;
        b=ickxYHOCufrKdyb00o8PDHdyiM1ASYCzEk3RYZcvIolrtxsm0+6nXPKRFUPAI4bzVzFrZ/
        Iqqw1Iqfqu9oaLAQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] doc: Document rcuperf's module parameters
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618737657.4006.5408066836721192390.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     847dd70aa971a67b4dfdb8f131428dfb90d88714
Gitweb:        https://git.kernel.org/tip/847dd70aa971a67b4dfdb8f131428dfb90d88714
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 29 May 2020 14:24:03 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:45 -07:00

doc: Document rcuperf's module parameters

This commit adds documentation for the rcuperf module parameters.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 36 ++++++++++++++++-
 1 file changed, 36 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb95fad..20cd00b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4407,6 +4407,42 @@
 			      reboot_cpu is s[mp]#### with #### being the processor
 					to be used for rebooting.
 
+	refperf.holdoff= [KNL]
+			Set test-start holdoff period.  The purpose of
+			this parameter is to delay the start of the
+			test until boot completes in order to avoid
+			interference.
+
+	refperf.loops= [KNL]
+			Set the number of loops over the synchronization
+			primitive under test.  Increasing this number
+			reduces noise due to loop start/end overhead,
+			but the default has already reduced the per-pass
+			noise to a handful of picoseconds on ca. 2020
+			x86 laptops.
+
+	refperf.nreaders= [KNL]
+			Set number of readers.  The default value of -1
+			selects N, where N is roughly 75% of the number
+			of CPUs.  A value of zero is an interesting choice.
+
+	refperf.nruns= [KNL]
+			Set number of runs, each of which is dumped onto
+			the console log.
+
+	refperf.readdelay= [KNL]
+			Set the read-side critical-section duration,
+			measured in microseconds.
+
+	refperf.shutdown= [KNL]
+			Shut down the system at the end of the performance
+			test.  This defaults to 1 (shut it down) when
+			rcuperf is built into the kernel and to 0 (leave
+			it running) when rcuperf is built as a module.
+
+	refperf.verbose= [KNL]
+			Enable additional printk() statements.
+
 	relax_domain_level=
 			[KNL, SMP] Set scheduler's default relax_domain_level.
 			See Documentation/admin-guide/cgroup-v1/cpusets.rst.
