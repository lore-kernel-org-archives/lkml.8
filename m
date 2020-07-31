Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9BBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A304E22B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cfrkpNES";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a0/TOL09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732679AbgGaJ2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:28:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56344 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732312AbgGaJXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:01 -0400
Date:   Fri, 31 Jul 2020 09:22:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187379;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=f7ChyWmzjtGHWTBJqykJAkMe3qM+j7lvLMPgG+XZM64=;
        b=cfrkpNESbPISCUjCkPgJRIrRK9lMp3r0HwAFwp9sh7EQVwKaA1ro1+vmgVlMuJstfw3jt3
        0Ch2HrnApxW021XMfUNWarkxQDOlJHsbHM5uNHmoFAIBAEWHBcgZhpGatIi5UT3aikohps
        aftvLIBdtILA2ipfTpv9qRxJxe1sLoKr35X/YPkINFa6bHcepxLmFkdFi0s3pCdh3xkfu6
        EOmkVdTB0S6K3oIyjYU0mlU3n/rhggNWpBvb+FPHevwUOM5S/wQIPB6Ko2Lbh5f+n2r0uo
        ErBAIlbsd7jSVe7JIIDfduvi96sv1HvFcfCSM/GxDRVHktjKTLx6ZmhhgdmIww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187379;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=f7ChyWmzjtGHWTBJqykJAkMe3qM+j7lvLMPgG+XZM64=;
        b=a0/TOL09Pzwxcdn7JZNZJ5jIq2B4sYmLO4sm7kJiy4fFwuIfcOV+euGeottLoUNiO5kxll
        iGr9SXTHlnQ85qBg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refperf: Output per-experiment data points
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618737921.4006.4069593394527425749.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     9d1914d34cebe111a23ab1670633900fd770cec3
Gitweb:        https://git.kernel.org/tip/9d1914d34cebe111a23ab1670633900fd770cec3
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 26 May 2020 15:30:09 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:45 -07:00

refperf: Output per-experiment data points

Currently, it is necessary to manually edit the console output to see
anything more than statistics, and sometimes the statistics can indicate
outliers that need more investigation.  This commit therefore dumps out
the per-experiment measurements, sorted in ascending order, just before
dumping out the statistics.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh
index 0660f3f..0e29cfd 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-refperf.sh
@@ -59,6 +59,10 @@ END {
 		medianvalue = (readertimes[medianidx - 1] + readertimes[medianidx]) / 2;
 	else
 		medianvalue = readertimes[medianidx];
+	points = "Points:";
+	for (i = 1; i <= newNR; i++)
+		points = points " " readertimes[i];
+	print points;
 	print "Average reader duration: " sum / newNR " nanoseconds";
 	print "Minimum reader duration: " readertimes[1];
 	print "Median reader duration: " medianvalue;
