Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058ABC4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8A720870
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgCXJQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:16:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43869 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbgCXJQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:31 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfff-0007u1-E8; Tue, 24 Mar 2020 10:16:27 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 12B3B1C0475;
        Tue, 24 Mar 2020 10:16:27 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:26 -0000
From:   "tip-bot2 for SeongJae Park" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] Documentation/memory-barriers: Fix typos
Cc:     SeongJae Park <sjpark@amazon.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504138676.28353.6448892854421862536.tip-bot2@tip-bot2>
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

Commit-ID:     8149b5cbfa1540cd7542fd4e790a2874afbc5001
Gitweb:        https://git.kernel.org/tip/8149b5cbfa1540cd7542fd4e790a2874afbc5001
Author:        SeongJae Park <sjpark@amazon.de>
AuthorDate:    Fri, 31 Jan 2020 21:52:37 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 27 Feb 2020 07:03:14 -08:00

Documentation/memory-barriers: Fix typos

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/memory-barriers.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 7146da0..e1c355e 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -185,7 +185,7 @@ As a further example, consider this sequence of events:
 	===============	===============
 	{ A == 1, B == 2, C == 3, P == &A, Q == &C }
 	B = 4;		Q = P;
-	P = &B		D = *Q;
+	P = &B;		D = *Q;
 
 There is an obvious data dependency here, as the value loaded into D depends on
 the address retrieved from P by CPU 2.  At the end of the sequence, any of the
@@ -569,7 +569,7 @@ following sequence of events:
 	{ A == 1, B == 2, C == 3, P == &A, Q == &C }
 	B = 4;
 	<write barrier>
-	WRITE_ONCE(P, &B)
+	WRITE_ONCE(P, &B);
 			      Q = READ_ONCE(P);
 			      D = *Q;
 
@@ -1721,7 +1721,7 @@ of optimizations:
      and WRITE_ONCE() are more selective:  With READ_ONCE() and
      WRITE_ONCE(), the compiler need only forget the contents of the
      indicated memory locations, while with barrier() the compiler must
-     discard the value of all memory locations that it has currented
+     discard the value of all memory locations that it has currently
      cached in any machine registers.  Of course, the compiler must also
      respect the order in which the READ_ONCE()s and WRITE_ONCE()s occur,
      though the CPU of course need not do so.
@@ -1833,7 +1833,7 @@ Aside: In the case of data dependencies, the compiler would be expected
 to issue the loads in the correct order (eg. `a[b]` would have to load
 the value of b before loading a[b]), however there is no guarantee in
 the C specification that the compiler may not speculate the value of b
-(eg. is equal to 1) and load a before b (eg. tmp = a[1]; if (b != 1)
+(eg. is equal to 1) and load a[b] before b (eg. tmp = a[1]; if (b != 1)
 tmp = a[b]; ).  There is also the problem of a compiler reloading b after
 having loaded a[b], thus having a newer copy of b than a[b].  A consensus
 has not yet been reached about these problems, however the READ_ONCE()
