Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96C7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6939208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uSTWzTuq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MUwH1V8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbgGaJ2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:28:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56338 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732229AbgGaJWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:22:47 -0400
Date:   Fri, 31 Jul 2020 09:22:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187366;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=c1nTJxzfdlyR5JTw/77icm0HMbfDF04j5JS9acG0NOs=;
        b=uSTWzTuqRlcRwplU49inB8rQYUld9i6d00/wQwJk0NIWAhkH5+Vplq+PfmRCkh48yItaDu
        J0nkTl3/SS4OX4mApGaO2y5rNZk69riqwhJexVewPyLbFOzbolwIKMkb6cU3g3JGFva8V9
        bTzEUayrj9GKs8rN0A3p0iwvWKoZe3qnQT+eE+KIzw6bwLa5T5K+/rONtYgutt8mFTujjp
        8+eVHAUYykOVn25DzoHyZHF0ldZ1tqXcMZnKtGfjirmNDYR98kXoVwl73/P9l9Q9MlKnrt
        xTFVCiaj6zDdw17swbQzUDyrjYgBBDK67nXnZmx9062bx/mT3G7+srL9CrKxWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187366;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=c1nTJxzfdlyR5JTw/77icm0HMbfDF04j5JS9acG0NOs=;
        b=MUwH1V8Q2aBJ/4WUEci/Qiq+rQ9Tq3JjvfFUYsvY90gMG9PofpdFFXdXLUdbkO86VO8+y1
        Wb112vyBBMX8t7Aw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Handle non-statistic bang-string error messages
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618736606.4006.1828842255788439902.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     59359e4f2a0906920389ec1e33296ac9a19178ba
Gitweb:        https://git.kernel.org/tip/59359e4f2a0906920389ec1e33296ac9a19178ba
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 26 Apr 2020 16:51:56 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:01:44 -07:00

rcutorture: Handle non-statistic bang-string error messages

The current console parsing assumes that console lines containing "!!!"
are statistics lines from which it can parse the number of rcutorture
too-short grace-period failures.  This prints confusing output for
other problems, including memory exhaustion.  This commit therefore
differentiates between these cases and prints an appropriate error string.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/parse-console.sh | 18 ++++++--
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 4bf62d7..1c64ca8 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -44,11 +44,23 @@ then
 		tail -1 |
 		awk '
 		{
-			for (i=NF-8;i<=NF;i++)
+			normalexit = 1;
+			for (i=NF-8;i<=NF;i++) {
+				if (i <= 0 || i !~ /^[0-9]*$/) {
+					bangstring = $0;
+					gsub(/^\[[^]]*] /, "", bangstring);
+					print bangstring;
+					normalexit = 0;
+					exit 0;
+				}
 				sum+=$i;
+			}
 		}
-		END { print sum }'`
-		print_bug $title FAILURE, $nerrs instances
+		END {
+			if (normalexit)
+				print sum " instances"
+		}'`
+		print_bug $title FAILURE, $nerrs
 		exit
 	fi
 
