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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEE2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3456B221E5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uqRDp1KI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgHGHqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgHGHp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:45:57 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41669C061574;
        Fri,  7 Aug 2020 00:45:57 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v22so655143qtq.8;
        Fri, 07 Aug 2020 00:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EHg5gQL7O9H3weXw7HumbisNzK8ZK1pZS93c4xfkxlw=;
        b=uqRDp1KIdnjSSjtURugjUs7jkmnhxCRyrgfRIIZf1YYf/7ZfupoiudHXsjSreOhhuc
         U8jJjKe/4ED7VQ1QlcKM0N+c6wuXWdbG3n7evxSilXOEnx3YohBiJNaFkz6Sf378rjOJ
         QUmJ8wIy4lV4Q+p72A4PzfWBqe3YFjrawnqzaOB7G8RpKecVZKgM0mn09TnnFRDkcQNR
         9+5QZOs1lunqu1PGB2f6fybQV+syDzCPEHA2DhVowKfc0yUCWvFGeAktDL64suYKLVj8
         pZ79ehd/o+xD55aJ8VHvC4Ok6QmpFh/ZY6bvkT8X/D6KYropzSelBS462edLarB4pJA4
         nikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EHg5gQL7O9H3weXw7HumbisNzK8ZK1pZS93c4xfkxlw=;
        b=W57DO/j6IHTyl8hVUYnilT7lzxC5jblmkNLYXmksQJfaAhq1uMqrsP+pjHxwcyYVe6
         YVSw6P2ioQt6H8ollFEla18BENh/eD7VPjcWV7JcBQ3CDMbX6r/7DvoAXt1O21EHStPt
         njOC4/zl8WbJM2xm6TrnpdHGl4edJQNaWlyhcfCO85eQfRm4mHBgAm6XciCAce+rnKVZ
         5b7c+AYuU02AgiV194YwOLkQh0CL2r+ZjwzEuLvPPSpotvGFWkzASLQrej+a2DMfzHB5
         xHZRCszJhrVj/WbWQhsWutRdwK6/MMgOYHkLbRXNT5wcgbhzcNFQJt4lgYKEVQHZNQae
         sSHg==
X-Gm-Message-State: AOAM530OmCk0X1HtlPdHwKADmcy0bSzDNS38RIm/YrJ+eoJxhcbrcTcH
        pN7BmByo4b75DkYZg8O5pkA=
X-Google-Smtp-Source: ABdhPJwY1AX/Fv/EgjsxEtaqA6v1Uve/wyfVkvlK0t858bI04DX2OWrsx5mE1bs5Vf/bYdK+2a/Gxw==
X-Received: by 2002:aed:36aa:: with SMTP id f39mr13334366qtb.297.1596786356574;
        Fri, 07 Aug 2020 00:45:56 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id a67sm6388744qkd.40.2020.08.07.00.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2020 00:45:56 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id B92B027C0054;
        Fri,  7 Aug 2020 03:45:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 07 Aug 2020 03:45:55 -0400
X-ME-Sender: <xms:swYtX6FKbO5nD5m6fW_eQO-lYf1NyIjYDmUJiE8WOsqKbvvRbc3L0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedugdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppeduudegrdekhedrudektddrvdduheenucevlhhushhtvghrufhiiigvpe
    ehnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnpe
    epfhhigihmvgdrnhgrmhgvsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:swYtX7WIioF3CT8tgFMeD-eAZ9xtJ61uVj1Rz8fktwUQOKOA9j6BAA>
    <xmx:swYtX0IrC5NZOf1iJRbRa1aw-HZShrFyAIcF2xcXj7AkoF_K8LQ2Gw>
    <xmx:swYtX0EjWgYlA2VRkNbe1wQP9g9CGqPPi2rDpVMyFqgHSCMPAnQzYA>
    <xmx:swYtX-xWu_YncJDfiZInBntq51c-WNQcrRdwnLZ7I-AKihHPLMuLbw>
Received: from localhost (unknown [114.85.180.215])
        by mail.messagingengine.com (Postfix) with ESMTPA id E90363060067;
        Fri,  7 Aug 2020 03:45:53 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v7 15/19] lockdep/selftest: Unleash irq_read_recursion2 and add more
Date:   Fri,  7 Aug 2020 15:42:34 +0800
Message-Id: <20200807074238.1632519-16-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200807074238.1632519-1-boqun.feng@gmail.com>
References: <20200807074238.1632519-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now since we can handle recursive read related irq inversion deadlocks
correctly, uncomment the irq_read_recursion2 and add more testcases.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 lib/locking-selftest.c | 59 +++++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 12 deletions(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 002d1ec09852..f65a658cc9e3 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1053,20 +1053,28 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_inversion_soft_wlock)
 #define E3()				\
 					\
 	IRQ_ENTER();			\
-	RL(A);				\
+	LOCK(A);			\
 	L(B);				\
 	U(B);				\
-	RU(A);				\
+	UNLOCK(A);			\
 	IRQ_EXIT();
 
 /*
- * Generate 12 testcases:
+ * Generate 24 testcases:
  */
 #include "locking-selftest-hardirq.h"
-GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_hard)
+#include "locking-selftest-rlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_hard_rlock)
+
+#include "locking-selftest-wlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_hard_wlock)
 
 #include "locking-selftest-softirq.h"
-GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_soft)
+#include "locking-selftest-rlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_soft_rlock)
+
+#include "locking-selftest-wlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_soft_wlock)
 
 #undef E1
 #undef E2
@@ -1080,8 +1088,8 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_soft)
 					\
 	IRQ_DISABLE();			\
 	L(B);				\
-	WL(A);				\
-	WU(A);				\
+	LOCK(A);			\
+	UNLOCK(A);			\
 	U(B);				\
 	IRQ_ENABLE();
 
@@ -1098,13 +1106,21 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion_soft)
 	IRQ_EXIT();
 
 /*
- * Generate 12 testcases:
+ * Generate 24 testcases:
  */
 #include "locking-selftest-hardirq.h"
-// GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_hard)
+#include "locking-selftest-rlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_hard_rlock)
+
+#include "locking-selftest-wlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_hard_wlock)
 
 #include "locking-selftest-softirq.h"
-// GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_soft)
+#include "locking-selftest-rlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_soft_rlock)
+
+#include "locking-selftest-wlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_soft_wlock)
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define I_SPINLOCK(x)	lockdep_reset_lock(&lock_##x.dep_map)
@@ -1257,6 +1273,25 @@ static inline void print_testname(const char *testname)
 	dotest(name##_rlock_##nr, SUCCESS, LOCKTYPE_RWLOCK);	\
 	pr_cont("\n");
 
+#define DO_TESTCASE_2RW(desc, name, nr)				\
+	print_testname(desc"/"#nr);				\
+	pr_cont("      |");					\
+	dotest(name##_wlock_##nr, FAILURE, LOCKTYPE_RWLOCK);	\
+	dotest(name##_rlock_##nr, SUCCESS, LOCKTYPE_RWLOCK);	\
+	pr_cont("\n");
+
+#define DO_TESTCASE_2x2RW(desc, name, nr)			\
+	DO_TESTCASE_2RW("hard-"desc, name##_hard, nr)		\
+	DO_TESTCASE_2RW("soft-"desc, name##_soft, nr)		\
+
+#define DO_TESTCASE_6x2x2RW(desc, name)				\
+	DO_TESTCASE_2x2RW(desc, name, 123);			\
+	DO_TESTCASE_2x2RW(desc, name, 132);			\
+	DO_TESTCASE_2x2RW(desc, name, 213);			\
+	DO_TESTCASE_2x2RW(desc, name, 231);			\
+	DO_TESTCASE_2x2RW(desc, name, 312);			\
+	DO_TESTCASE_2x2RW(desc, name, 321);
+
 #define DO_TESTCASE_6(desc, name)				\
 	print_testname(desc);					\
 	dotest(name##_spin, FAILURE, LOCKTYPE_SPIN);		\
@@ -2121,8 +2156,8 @@ void locking_selftest(void)
 	DO_TESTCASE_6x6("safe-A + unsafe-B #2", irqsafe4);
 	DO_TESTCASE_6x6RW("irq lock-inversion", irq_inversion);
 
-	DO_TESTCASE_6x2("irq read-recursion", irq_read_recursion);
-//	DO_TESTCASE_6x2B("irq read-recursion #2", irq_read_recursion2);
+	DO_TESTCASE_6x2x2RW("irq read-recursion", irq_read_recursion);
+	DO_TESTCASE_6x2x2RW("irq read-recursion #2", irq_read_recursion2);
 
 	ww_tests();
 
-- 
2.28.0

