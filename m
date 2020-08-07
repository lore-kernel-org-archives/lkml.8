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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3830C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C342D221E5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GX52DsY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgHGHrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgHGHrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:47:07 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8353C061574;
        Fri,  7 Aug 2020 00:47:07 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id t23so674315qto.3;
        Fri, 07 Aug 2020 00:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5TVRRrTJtmZdv6+6tRsGQqVeebKVn7+NZ1W0hZ5IlAc=;
        b=GX52DsY3qIAl6y7VYvZNA6C7+CF8Xc3SkbYXO3RM+3EFn4rXFViWvcOewgLYU6HbgJ
         uicchdrQfbyspVtdT10EeV4W8n+6haTvofNa82//gqanhTFomVEAVU4T/alV4608b+dX
         otbPCb9DcyZmLDmLkBsmJkskovHimQ1QjCepmsy+EXDPmN2fL9s67X/gZ4+gMtNG9A6O
         kUtUtx3msIyeyZ6g3s4M+bTnsvofYUqWXpyKhlsouAcvLjNUhUfu8/Ry2/kBZosN+M37
         N9GHzHB9yIb0Exc9hAhp1uPeR1PEGsfw4I4Tc456rqCAeMchNYQH+7WBvZ0ljkj30cOD
         87nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5TVRRrTJtmZdv6+6tRsGQqVeebKVn7+NZ1W0hZ5IlAc=;
        b=kGhVlZUq6KCpSdlh+DfnPPZFeI3abnFDfoUjJrBKTa6RpeiCfUsveDYcmMXr92BJsk
         z/laPbORoydqQ6Lo8e9IcE6e672Z6wyJrbkoopgXNigisTTPkOErPKWJxsH71Y2dU4In
         lEpQBYy0FzRlm0Px+uOV2PDDEkAQ9GP6mBVCMy8ZUwMj9Gs0vM1yfna+yK6AKuKL1k5U
         tHNt89CrvS1xUx9IdDVvQJK368mtUAX84DYTbdreB8jNZsolJIAvgwz90Iwr+OBw4scp
         t1OnEURZkNSKfSHE33TNDzNlzf0ianNVcbIuAZyoUH0lw5biQNld5NIkjkyKSzHIIv5K
         xgNg==
X-Gm-Message-State: AOAM5309HYln3Rr+HRfhkc3d1phx/qVz1Hg/xqxK7VfxggmYTpu13rRk
        FE4BxK25EPTj9ss0OPUivBQ=
X-Google-Smtp-Source: ABdhPJyq8IpG6jqFOXfhqXITDu6hadTHPSLs5omqd3OJpjos7mlE6qfsk6BKCaRwuMsOlQCpn0JsQQ==
X-Received: by 2002:ac8:4e39:: with SMTP id d25mr12571151qtw.208.1596786427051;
        Fri, 07 Aug 2020 00:47:07 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id d26sm7289401qtc.51.2020.08.07.00.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2020 00:47:06 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 3DC7F27C0054;
        Fri,  7 Aug 2020 03:47:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 07 Aug 2020 03:47:06 -0400
X-ME-Sender: <xms:-gYtX9YT703LbnsjkMNhxcE_tidta9S-Fc9Gyq5M0L-n9TcETf9MMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedugdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppeduudegrdekhedrudektddrvdduheenucevlhhushhtvghrufhiiigvpe
    elnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnpe
    epfhhigihmvgdrnhgrmhgvsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:-gYtX0bS2x83-RSowex01dVlIBoNsjKSYFwKMCxzniyZeAlTMnEUmA>
    <xmx:-gYtX__Da5PD3g5dbsjPBlONZxOTOVqMmxEdNwI3YW8qQ-nrvd-tmQ>
    <xmx:-gYtX7r58KykQ2R6970LAqm7ZOgOCwznZKlQ3myLNMHDmWMYCYxg7g>
    <xmx:-gYtXxkjqkaKfFLBQJBrMadKDn8xam-jfd13U6ELLkpfbJ1HpCWdgw>
Received: from localhost (unknown [114.85.180.215])
        by mail.messagingengine.com (Postfix) with ESMTPA id 32BF730600B2;
        Fri,  7 Aug 2020 03:47:04 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v7 19/19] lockdep/selftest: Introduce recursion3
Date:   Fri,  7 Aug 2020 15:42:38 +0800
Message-Id: <20200807074238.1632519-20-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200807074238.1632519-1-boqun.feng@gmail.com>
References: <20200807074238.1632519-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a test case shows that USED_IN_*_READ and ENABLE_*_READ can cause
deadlock too.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 lib/locking-selftest.c | 55 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 17f8f6f37165..a899b3f0e2e5 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1249,6 +1249,60 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_soft_rlock)
 #include "locking-selftest-wlock.h"
 GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion2_soft_wlock)
 
+#undef E1
+#undef E2
+#undef E3
+/*
+ * read-lock / write-lock recursion that is unsafe.
+ *
+ * A is a ENABLED_*_READ lock
+ * B is a USED_IN_*_READ lock
+ *
+ * read_lock(A);
+ *			write_lock(B);
+ * <interrupt>
+ * read_lock(B);
+ * 			write_lock(A); // if this one is read_lock(), no deadlock
+ */
+
+#define E1()				\
+					\
+	IRQ_DISABLE();			\
+	WL(B);				\
+	LOCK(A);			\
+	UNLOCK(A);			\
+	WU(B);				\
+	IRQ_ENABLE();
+
+#define E2()				\
+					\
+	RL(A);				\
+	RU(A);				\
+
+#define E3()				\
+					\
+	IRQ_ENTER();			\
+	RL(B);				\
+	RU(B);				\
+	IRQ_EXIT();
+
+/*
+ * Generate 24 testcases:
+ */
+#include "locking-selftest-hardirq.h"
+#include "locking-selftest-rlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_hard_rlock)
+
+#include "locking-selftest-wlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_hard_wlock)
+
+#include "locking-selftest-softirq.h"
+#include "locking-selftest-rlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_soft_rlock)
+
+#include "locking-selftest-wlock.h"
+GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_soft_wlock)
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define I_SPINLOCK(x)	lockdep_reset_lock(&lock_##x.dep_map)
 # define I_RWLOCK(x)	lockdep_reset_lock(&rwlock_##x.dep_map)
@@ -2413,6 +2467,7 @@ void locking_selftest(void)
 
 	DO_TESTCASE_6x2x2RW("irq read-recursion", irq_read_recursion);
 	DO_TESTCASE_6x2x2RW("irq read-recursion #2", irq_read_recursion2);
+	DO_TESTCASE_6x2x2RW("irq read-recursion #3", irq_read_recursion3);
 
 	ww_tests();
 
-- 
2.28.0

