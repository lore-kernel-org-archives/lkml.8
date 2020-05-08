Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1C5C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06B572070B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgEHNqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727882AbgEHNqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:46:34 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99653C05BD0B;
        Fri,  8 May 2020 06:46:34 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX3Kh-0001kY-Fp; Fri, 08 May 2020 15:46:31 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 21E331C0475;
        Fri,  8 May 2020 15:46:31 +0200 (CEST)
Date:   Fri, 08 May 2020 13:46:31 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] checkpatch: Warn about data_race() without comment
Cc:     Will Deacon <will@kernel.org>, Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894559107.8414.10179815229224016471.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     5099a722e9727fe9a93fac51e961735f40e5b6c8
Gitweb:        https://git.kernel.org/tip/5099a722e9727fe9a93fac51e961735f40e5b6c8
Author:        Marco Elver <elver@google.com>
AuthorDate:    Wed, 01 Apr 2020 12:17:14 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 May 2020 10:54:58 -07:00

checkpatch: Warn about data_race() without comment

Warn about applications of data_race() without a comment, to encourage
documenting the reasoning behind why it was deemed safe.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 scripts/checkpatch.pl | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a63380c..48bb950 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5833,6 +5833,14 @@ sub process {
 			}
 		}
 
+# check for data_race without a comment.
+		if ($line =~ /\bdata_race\s*\(/) {
+			if (!ctx_has_comment($first_line, $linenr)) {
+				WARN("DATA_RACE",
+				     "data_race without comment\n" . $herecurr);
+			}
+		}
+
 # check for smp_read_barrier_depends and read_barrier_depends
 		if (!$file && $line =~ /\b(smp_|)read_barrier_depends\s*\(/) {
 			WARN("READ_BARRIER_DEPENDS",
