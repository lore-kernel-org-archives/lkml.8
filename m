Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE91C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0529E22CAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYe2VyXl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgHGHqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgHGHqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:46:05 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E142C061574;
        Fri,  7 Aug 2020 00:46:05 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id a19so357755qvy.3;
        Fri, 07 Aug 2020 00:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wi17FMMgE94rR1w5syCb0jJ8vGHETYbbJ/4ifa0mtRQ=;
        b=BYe2VyXlXHY5SJsCzDFzsKf6qFa/Y54TQFErFeh2mz4FG9euUqsPTcOeDmYJzA06yT
         R62vmtQiI4ON68rFy+oUCx9LOf06tGPnmYLxbUDD9Y+azmTB7M6/mMrh5dQLpKQNbszJ
         /3U9vT5bd80CQ8Cm1QapuH+mv6+um9cqyZokL/hxG7v2itGR1diKIlAb+KQwGls4UGjg
         Qrqr2OrOm39h7zgjx+f82dGDICgkSYSuH6TR66MtzYpnOL1N+s56m8WPzoZ8b3trXNDa
         3cZfIthFCNx1EtEMYaiLkYlb8ndnBU+qOV15pJyuCaZdZUQTMXdPLJEnCYRzNUQiA/db
         XWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wi17FMMgE94rR1w5syCb0jJ8vGHETYbbJ/4ifa0mtRQ=;
        b=iyga7l0REtVaOQyYv+lpTLsAmuJRjvikC0KSkTdb3BH43sGg7w5X66qg6XMIP5s3qp
         R/O0x+xuN6zJnD+o90V4qvJ61hjCu3B6sGr/g71mSzJdgelJVCAbJgDlC+Y1YsAS9i4o
         Rf7asbnLosm59x8OYeUdEZ3AdgDxXrPRiL3afy3YGXTHhLWrOjBoXhP7lkBDZFCfehdC
         JuCb1olSEuagQdcXbTE9LcUTmJteqIWTtFC8ddybmxOjFwJ+R3gAjR1TPvG1uKIQVExc
         7Sz67i8s6sxGbVyyh6RUsJdP73gv6JaVyobQ9SOy9Tf3fT9nBNBxxpqCT0JDKpWSxFN2
         cKzA==
X-Gm-Message-State: AOAM533ZFszLBVR2AE2bujwPmuWmfQTTjujZFdsBKGIK8agSuu8qLfFx
        WaDrO9buBCgHSonzJLQrimg=
X-Google-Smtp-Source: ABdhPJyhlMhs2eZd2cWIpzQBQPR7t3AkD+ad+VF5thRHxMGa/r/O5/Dtpq0LnPiHMYjl/Y7Jsat/cA==
X-Received: by 2002:a0c:d64b:: with SMTP id e11mr7312610qvj.169.1596786364140;
        Fri, 07 Aug 2020 00:46:04 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id i30sm7572370qte.30.2020.08.07.00.46.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2020 00:46:03 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 58EB827C0054;
        Fri,  7 Aug 2020 03:46:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 07 Aug 2020 03:46:03 -0400
X-ME-Sender: <xms:uwYtXzaEb8-cDW_qxkZY2wSdJYooEeN5pCR4SJk-tvyvmpLPyENGHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedugdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppeduudegrdekhedrudektddrvdduheenucevlhhushhtvghrufhiiigvpe
    einecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnpe
    epfhhigihmvgdrnhgrmhgvsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:uwYtXybrAYEm0rWLo7W2ecc4rPb7ucHVKds4dneeUmVGL2D3i8ExOg>
    <xmx:uwYtX1-bfVkxM5gFlXqTpGTBBSgNOym2mCEM9yIoDaL-BCUyoqboyw>
    <xmx:uwYtX5rtidbQZEVo8cBbIcU2QIGa0G_TIyDUkZa4L_vM1kEdhzg99Q>
    <xmx:uwYtX3lcEswS8fAfkTvlR64kDm5R4uC5uqi80-p0d9-5jdFz1v2oEw>
Received: from localhost (unknown [114.85.180.215])
        by mail.messagingengine.com (Postfix) with ESMTPA id 575DB3280059;
        Fri,  7 Aug 2020 03:46:01 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v7 16/19] lockdep/selftest: Add more recursive read related test cases
Date:   Fri,  7 Aug 2020 15:42:35 +0800
Message-Id: <20200807074238.1632519-17-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200807074238.1632519-1-boqun.feng@gmail.com>
References: <20200807074238.1632519-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add those four test cases:

1.	X --(ER)--> Y --(ER)--> Z --(ER)--> X is deadlock.

2.	X --(EN)--> Y --(SR)--> Z --(ER)--> X is deadlock.

3.	X --(EN)--> Y --(SR)--> Z --(SN)--> X is not deadlock.

4.	X --(ER)--> Y --(SR)--> Z --(EN)--> X is not deadlock.

Those self testcases are valuable for the development of supporting
recursive read related deadlock detection.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 lib/locking-selftest.c | 161 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index f65a658cc9e3..76c314ab4f03 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1034,6 +1034,133 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_inversion_soft_wlock)
 #undef E2
 #undef E3
 
+/*
+ * write-read / write-read / write-read deadlock even if read is recursive
+ */
+
+#define E1()				\
+					\
+	WL(X1);				\
+	RL(Y1);				\
+	RU(Y1);				\
+	WU(X1);
+
+#define E2()				\
+					\
+	WL(Y1);				\
+	RL(Z1);				\
+	RU(Z1);				\
+	WU(Y1);
+
+#define E3()				\
+					\
+	WL(Z1);				\
+	RL(X1);				\
+	RU(X1);				\
+	WU(Z1);
+
+#include "locking-selftest-rlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(W1R2_W2R3_W3R1)
+
+#undef E1
+#undef E2
+#undef E3
+
+/*
+ * write-write / read-read / write-read deadlock even if read is recursive
+ */
+
+#define E1()				\
+					\
+	WL(X1);				\
+	WL(Y1);				\
+	WU(Y1);				\
+	WU(X1);
+
+#define E2()				\
+					\
+	RL(Y1);				\
+	RL(Z1);				\
+	RU(Z1);				\
+	RU(Y1);
+
+#define E3()				\
+					\
+	WL(Z1);				\
+	RL(X1);				\
+	RU(X1);				\
+	WU(Z1);
+
+#include "locking-selftest-rlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(W1W2_R2R3_W3R1)
+
+#undef E1
+#undef E2
+#undef E3
+
+/*
+ * write-write / read-read / read-write is not deadlock when read is recursive
+ */
+
+#define E1()				\
+					\
+	WL(X1);				\
+	WL(Y1);				\
+	WU(Y1);				\
+	WU(X1);
+
+#define E2()				\
+					\
+	RL(Y1);				\
+	RL(Z1);				\
+	RU(Z1);				\
+	RU(Y1);
+
+#define E3()				\
+					\
+	RL(Z1);				\
+	WL(X1);				\
+	WU(X1);				\
+	RU(Z1);
+
+#include "locking-selftest-rlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(W1R2_R2R3_W3W1)
+
+#undef E1
+#undef E2
+#undef E3
+
+/*
+ * write-read / read-read / write-write is not deadlock when read is recursive
+ */
+
+#define E1()				\
+					\
+	WL(X1);				\
+	RL(Y1);				\
+	RU(Y1);				\
+	WU(X1);
+
+#define E2()				\
+					\
+	RL(Y1);				\
+	RL(Z1);				\
+	RU(Z1);				\
+	RU(Y1);
+
+#define E3()				\
+					\
+	WL(Z1);				\
+	WL(X1);				\
+	WU(X1);				\
+	WU(Z1);
+
+#include "locking-selftest-rlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(W1W2_R2R3_R3W1)
+
+#undef E1
+#undef E2
+#undef E3
 /*
  * read-lock / write-lock recursion that is actually safe.
  */
@@ -1259,6 +1386,19 @@ static inline void print_testname(const char *testname)
 	dotest(name##_##nr, FAILURE, LOCKTYPE_RWLOCK);		\
 	pr_cont("\n");
 
+#define DO_TESTCASE_1RR(desc, name, nr)				\
+	print_testname(desc"/"#nr);				\
+	pr_cont("             |");				\
+	dotest(name##_##nr, SUCCESS, LOCKTYPE_RWLOCK);		\
+	pr_cont("\n");
+
+#define DO_TESTCASE_1RRB(desc, name, nr)			\
+	print_testname(desc"/"#nr);				\
+	pr_cont("             |");				\
+	dotest(name##_##nr, FAILURE, LOCKTYPE_RWLOCK);		\
+	pr_cont("\n");
+
+
 #define DO_TESTCASE_3(desc, name, nr)				\
 	print_testname(desc"/"#nr);				\
 	dotest(name##_spin_##nr, FAILURE, LOCKTYPE_SPIN);	\
@@ -1368,6 +1508,22 @@ static inline void print_testname(const char *testname)
 	DO_TESTCASE_2IB(desc, name, 312);			\
 	DO_TESTCASE_2IB(desc, name, 321);
 
+#define DO_TESTCASE_6x1RR(desc, name)				\
+	DO_TESTCASE_1RR(desc, name, 123);			\
+	DO_TESTCASE_1RR(desc, name, 132);			\
+	DO_TESTCASE_1RR(desc, name, 213);			\
+	DO_TESTCASE_1RR(desc, name, 231);			\
+	DO_TESTCASE_1RR(desc, name, 312);			\
+	DO_TESTCASE_1RR(desc, name, 321);
+
+#define DO_TESTCASE_6x1RRB(desc, name)				\
+	DO_TESTCASE_1RRB(desc, name, 123);			\
+	DO_TESTCASE_1RRB(desc, name, 132);			\
+	DO_TESTCASE_1RRB(desc, name, 213);			\
+	DO_TESTCASE_1RRB(desc, name, 231);			\
+	DO_TESTCASE_1RRB(desc, name, 312);			\
+	DO_TESTCASE_1RRB(desc, name, 321);
+
 #define DO_TESTCASE_6x6(desc, name)				\
 	DO_TESTCASE_6I(desc, name, 123);			\
 	DO_TESTCASE_6I(desc, name, 132);			\
@@ -2144,6 +2300,11 @@ void locking_selftest(void)
 	pr_cont("             |");
 	dotest(rlock_chaincache_ABBA1, FAILURE, LOCKTYPE_RWLOCK);
 
+	DO_TESTCASE_6x1RRB("rlock W1R2/W2R3/W3R1", W1R2_W2R3_W3R1);
+	DO_TESTCASE_6x1RRB("rlock W1W2/R2R3/W3R1", W1W2_R2R3_W3R1);
+	DO_TESTCASE_6x1RR("rlock W1W2/R2R3/R3W1", W1W2_R2R3_R3W1);
+	DO_TESTCASE_6x1RR("rlock W1R2/R2R3/W3W1", W1R2_R2R3_W3W1);
+
 	printk("  --------------------------------------------------------------------------\n");
 
 	/*
-- 
2.28.0

