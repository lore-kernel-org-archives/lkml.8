Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE524C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCFA5208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B3KBwR+V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iKWLMfXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732946AbgGaJ3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:29:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56344 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732154AbgGaJWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:42 -0400
Date:   Fri, 31 Jul 2020 09:22:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187359;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fu66TyA1dYXuLUOCo/8m0OO2+QQ9CFKDHM/TlCFA4ek=;
        b=B3KBwR+Vn85pssKblKC7UZO97O25EgN2OORjrygmYEHzohAjuPVuVeG72tNcQbku2b4Lmu
        5YG8qPUtZVeQXuVyaYx8NyS2yG9RCHyrk82KK9t6zAijvAVQSEGWfj+oIDR8gSdEqPHwaE
        0jL3Mll2XNgKzYtmoaVfwZQJ1gvBGOQSDV+ThwRip33YDdIf6FZHZogI3fHfnIVg//e4Xx
        Q0Iij9IMeJYWuBHOOMYn4UM09EUtCPWWD5bbWB7xMzTHo9yNhyyZ81RxdIrbw6k5VgeYoD
        C9YVbz7fUOEfQzA6GX1Yy9t7qrhMtrFkg7nvRLJSJL7BsnNiGb5h0Q5KaflGUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187359;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fu66TyA1dYXuLUOCo/8m0OO2+QQ9CFKDHM/TlCFA4ek=;
        b=iKWLMfXntdBXq9u+50cmvG/ndPTxxzNSuHql0vREczZsvpfpxCRYpYwBhOOp+QBTwr0iaD
        mAdGhyyA0ge2IPCg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Improve diagnostic for KCSAN-incapable compilers
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618735883.4006.6144823697055482816.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     61b77be09e29e6dc152b1984691e5b1708e8a6ac
Gitweb:        https://git.kernel.org/tip/61b77be09e29e6dc152b1984691e5b1708e8a6ac
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 16 Jun 2020 10:38:57 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:01:45 -07:00

torture: Improve diagnostic for KCSAN-incapable compilers

Using --kcsan when the compiler does not support KCSAN results in this:

:CONFIG_KCSAN=y: improperly set
:CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000: improperly set
:CONFIG_KCSAN_VERBOSE=y: improperly set
:CONFIG_KCSAN_INTERRUPT_WATCHER=y: improperly set
Clean KCSAN run in /home/git/linux-rcu/tools/testing/selftests/rcutorture/res/2020.06.16-09.53.16

This is a bit obtuse, so this commit adds checks resulting in this:

:CONFIG_KCSAN=y: improperly set
:CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000: improperly set
:CONFIG_KCSAN_VERBOSE=y: improperly set
:CONFIG_KCSAN_INTERRUPT_WATCHER=y: improperly set
Compiler or architecture does not support KCSAN!
Did you forget to switch your compiler with --kmake-arg CC=<cc-that-supports-kcsan>?

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Marco Elver <elver@google.com>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh |  9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index 357899c..840a467 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -44,7 +44,8 @@ do
 			then
 				echo QEMU killed
 			fi
-			configcheck.sh $i/.config $i/ConfigFragment
+			configcheck.sh $i/.config $i/ConfigFragment > $T 2>&1
+			cat $T
 			if test -r $i/Make.oldconfig.err
 			then
 				cat $i/Make.oldconfig.err
@@ -73,7 +74,11 @@ do
 	done
 	if test -f "$rd/kcsan.sum"
 	then
-		if test -s "$rd/kcsan.sum"
+		if grep -q CONFIG_KCSAN=y $T
+		then
+			echo "Compiler or architecture does not support KCSAN!"
+			echo Did you forget to switch your compiler with '--kmake-arg CC=<cc-that-supports-kcsan>'?
+		elif test -s "$rd/kcsan.sum"
 		then
 			echo KCSAN summary in $rd/kcsan.sum
 		else
