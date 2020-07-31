Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD05C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5135208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VrdBZsZk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5WE72D1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732464AbgGaJ3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:29:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56350 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732168AbgGaJWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:41 -0400
Date:   Fri, 31 Jul 2020 09:22:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187360;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=MWAxGCueX1FQdbJ7JSi9wuo+tqOZpsiCZBaHv5+iEYs=;
        b=VrdBZsZkxl32mq87IbzyFnIxtPZH3yQjeyYkHfiG5VXU9nraQZF/UIQBkFiJJafjBogMlA
        M/2IDf/6c4ZvMfet1t3oHAWMqFkxiUaE1wYlQS2H181mtsJltVn9BSewd6xsbS/BpRoAEU
        NltabNC7Yzq1TyHUrJi2Ys5P8P4QUpfcJ0F0aogAUfdo97Rat6xnqFdVpRocuhI9U5nk8u
        1SSgWkxaUJXsTMqnQHEr0teNrBM2sHBukQ0HW850r7/10Z2L9feILAq23yZbykexZd+uSE
        L3BYGUrzlO1uXWNA+tvXsThN3XFExLVnrHU+lFoR+ufSVfZ58fPpdNJm3PSc1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187360;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=MWAxGCueX1FQdbJ7JSi9wuo+tqOZpsiCZBaHv5+iEYs=;
        b=5WE72D1nxifz/rVRzPXejsUUv+OAYBQubttWVdqw5XbIzuRN63RltgdKqfHGBUyrMllkVM
        DPyJw4cadx67nlBg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Correctly summarize build-only runs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618735949.4006.1360754623608472870.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     6bcaf2a0876633b6a7c5e70ee88801e16280210a
Gitweb:        https://git.kernel.org/tip/6bcaf2a0876633b6a7c5e70ee88801e16280210a
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 16 Jun 2020 10:02:54 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:01:44 -07:00

torture: Correctly summarize build-only runs

Currently, kvm-recheck.sh complains that qemu failed for --buildonly
runs, which is sort of true given that qemu can hardly succeed if not
invoked in the first place.  Nevertheless, this commit swaps the order
of checks in kvm-recheck.sh so that --buildonly runs will be summarized
more straightforwardly.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index 2261aa6..357899c 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -56,15 +56,15 @@ do
 				cat $i/Warnings
 			fi
 		else
-			if test -f "$i/qemu-cmd"
-			then
-				print_bug qemu failed
-				echo "   $i"
-			elif test -f "$i/buildonly"
+			if test -f "$i/buildonly"
 			then
 				echo Build-only run, no boot/test
 				configcheck.sh $i/.config $i/ConfigFragment
 				parse-build.sh $i/Make.out $configfile
+			elif test -f "$i/qemu-cmd"
+			then
+				print_bug qemu failed
+				echo "   $i"
 			else
 				print_bug Build failed
 				echo "   $i"
