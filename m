Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC237C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A8902184D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731838AbgEKU70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730938AbgEKU7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:23 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01861C061A0C;
        Mon, 11 May 2020 13:59:23 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWD-0005hJ-IV; Mon, 11 May 2020 22:59:21 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CFCD31C04CC;
        Mon, 11 May 2020 22:59:19 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:19 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Make kvm-recheck-rcu.sh handle truncated lines
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923075976.390.10325972666334241466.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     b3578186b28da4ed5d0852ec69c13a7bce15b5fd
Gitweb:        https://git.kernel.org/tip/b3578186b28da4ed5d0852ec69c13a7bce15b5fd
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 14 Feb 2020 14:43:44 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:05:13 -07:00

rcutorture: Make kvm-recheck-rcu.sh handle truncated lines

System hangs or killed rcutorture guest OSes can result in truncated
"Reader Pipe:" lines, which can in turn result in false-positive
reader-batch near-miss warnings.  This commit therefore adjusts the
reader-batch checks to account for possible line truncation.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh | 16 ++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
index 9d9a416..1706cd4 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
@@ -41,7 +41,21 @@ else
 		title="$title ($ngpsps/s)"
 	fi
 	echo $title $stopstate $fwdprog
-	nclosecalls=`grep --binary-files=text 'torture: Reader Batch' $i/console.log | tail -1 | awk '{for (i=NF-8;i<=NF;i++) sum+=$i; } END {print sum}'`
+	nclosecalls=`grep --binary-files=text 'torture: Reader Batch' $i/console.log | tail -1 | \
+		awk -v sum=0 '
+		{
+			for (i = 0; i <= NF; i++) {
+				sum += $i;
+				if ($i ~ /Batch:/) {
+					sum = 0;
+					i = i + 2;
+				}
+			}
+		}
+
+		END {
+			print sum
+		}'`
 	if test -z "$nclosecalls"
 	then
 		exit 0
