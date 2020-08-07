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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0260BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D513C206B5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKvMDNMv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgHGHoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHGHoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:44:15 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E405C061574;
        Fri,  7 Aug 2020 00:44:15 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id o2so350051qvk.6;
        Fri, 07 Aug 2020 00:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3+1fWHbkdaGHYygOOf8xwbmOtZS2ROsz4CEXdGfhYo4=;
        b=qKvMDNMvEGctcqC5jP2vqETvKABQqP1uYAIj3LJiYQsqqvj9uZSgKON0gAmUq9lcSv
         E4IzuP7bof6/uN7P+A2TLHUN9cQBsELOpUdZaJYuDHikGUfPNSsxwyafnu6c756KtRru
         lEvQa/1Sc8nbgAGyM8crPlMHrNJBUQ4h1qLqCf6Jb4dCp75Zb5dpwc3NnQ8mpAKRoEBb
         Ykbgao601Fw3EkZTftxQg8bI1g/x/zfOBn9dQ+mNlfL/aBuLwwOzkO/w8ZdW2rVKs+2X
         93Mold0qwjRarikGCfUvamCLm6bB+WAiox5VxC1naizKTuIj8Ou7U/lhmwEZvGXgjozV
         Qjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3+1fWHbkdaGHYygOOf8xwbmOtZS2ROsz4CEXdGfhYo4=;
        b=sdnC0gODQP8LcE1YOjOR27rWRzETe3u4F4FIzYnnAV19hoo7nTtiaA/7dmnWrtv4FF
         tsBuRQ4wghCheBTn7L9tmuQDW7k6ObCKb1SN6UDR7roG7RNPXGLNRx9FjohuMjJ6iJer
         6UQw6p+7ZHTL+SaplTMpK7uID/HSb+5EZo9WRSpXsTseoMqJc5iFmpPELT37BZN8E8Jo
         XuGFIMfeUWdoMBOqekvoYOVdsrauD3XoAF148ucu8s9YWjMv01x+2tHjxSq+iUKY+OJE
         jSIz/2ogswiLUlSgMTmRET8RYDjDgY+xYmWgSliISkghEC/t+Ec3DJQul28d8mT4GKux
         RYCQ==
X-Gm-Message-State: AOAM532zRf5k7dU1OIKV4hAE9uIblTbGgl3XnFJ0PcI8+Orse9VOTlPP
        wXcp7zKAgl7Fnj4T+sRRgDM=
X-Google-Smtp-Source: ABdhPJwZ0msUSVnPdmI58jRKmEDcszKnrK+9J+KVMFkV3SdPvmb2+ykvQNzuoyV95m+UCz31NkNYyw==
X-Received: by 2002:a05:6214:11a8:: with SMTP id u8mr11787261qvv.88.1596786253927;
        Fri, 07 Aug 2020 00:44:13 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id y14sm7165327qtc.84.2020.08.07.00.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2020 00:44:13 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1923427C0054;
        Fri,  7 Aug 2020 03:44:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 07 Aug 2020 03:44:13 -0400
X-ME-Sender: <xms:TAYtX7ZEvessZv72XkVsdvfU_9vqiln07QrHOOE_YSgDGWi2Xu1Fzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedugdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppeduudegrdekhedrudektddrvdduheenucevlhhushhtvghrufhiiigvpe
    egnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnpe
    epfhhigihmvgdrnhgrmhgvsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:TAYtX6bhD9-rOjmENV3Jkuy9l0GdPHMrDRY8R9NMpa8a-OPsvk0Yjg>
    <xmx:TAYtX9-P5i71VVqjDpv0_8oUi_k8DP3CbgaIJhpmzsOv3VhmNcUrZg>
    <xmx:TAYtXxoI5WXYRB9zbNgb65zOpCO0485zn-hRF0rkiE3TEGGalOSpKA>
    <xmx:TQYtX_ko0WfLiEDpZv3r-qA04j2wFjiCXwhQGhU40XmsNhmvkSx3Ow>
Received: from localhost (unknown [114.85.180.215])
        by mail.messagingengine.com (Postfix) with ESMTPA id CCF2730600B4;
        Fri,  7 Aug 2020 03:43:59 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v7 06/19] lockdep: Introduce lock_list::dep
Date:   Fri,  7 Aug 2020 15:42:25 +0800
Message-Id: <20200807074238.1632519-7-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200807074238.1632519-1-boqun.feng@gmail.com>
References: <20200807074238.1632519-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To add recursive read locks into the dependency graph, we need to store
the types of dependencies for the BFS later. There are four types of
dependencies:

*	Exclusive -> Non-recursive dependencies: EN
	e.g. write_lock(prev) held and try to acquire write_lock(next)
	or non-recursive read_lock(next), which can be represented as
	"prev -(EN)-> next"

*	Shared -> Non-recursive dependencies: SN
	e.g. read_lock(prev) held and try to acquire write_lock(next) or
	non-recursive read_lock(next), which can be represented as
	"prev -(SN)-> next"

*	Exclusive -> Recursive dependencies: ER
	e.g. write_lock(prev) held and try to acquire recursive
	read_lock(next), which can be represented as "prev -(ER)-> next"

*	Shared -> Recursive dependencies: SR
	e.g. read_lock(prev) held and try to acquire recursive
	read_lock(next), which can be represented as "prev -(SR)-> next"

So we use 4 bits for the presence of each type in lock_list::dep. Helper
functions and macros are also introduced to convert a pair of locks into
lock_list::dep bit and maintain the addition of different types of
dependencies.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/lockdep.h  |  2 +
 kernel/locking/lockdep.c | 92 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index b85973515f84..6ca0315d92c4 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -213,6 +213,8 @@ struct lock_list {
 	struct lock_class		*links_to;
 	const struct lock_trace		*trace;
 	u16				distance;
+	/* bitmap of different dependencies from head to this */
+	u8				dep;
 
 	/*
 	 * The parent field is used to implement breadth-first search, and the
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 699e9039a9b3..edf0cc261e8e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1320,7 +1320,7 @@ static struct lock_list *alloc_list_entry(void)
  */
 static int add_lock_to_list(struct lock_class *this,
 			    struct lock_class *links_to, struct list_head *head,
-			    unsigned long ip, u16 distance,
+			    unsigned long ip, u16 distance, u8 dep,
 			    const struct lock_trace *trace)
 {
 	struct lock_list *entry;
@@ -1334,6 +1334,7 @@ static int add_lock_to_list(struct lock_class *this,
 
 	entry->class = this;
 	entry->links_to = links_to;
+	entry->dep = dep;
 	entry->distance = distance;
 	entry->trace = trace;
 	/*
@@ -1498,6 +1499,57 @@ static inline bool bfs_error(enum bfs_result res)
 	return res < 0;
 }
 
+/*
+ * DEP_*_BIT in lock_list::dep
+ *
+ * For dependency @prev -> @next:
+ *
+ *   SR: @prev is shared reader (->read != 0) and @next is recursive reader
+ *       (->read == 2)
+ *   ER: @prev is exclusive locker (->read == 0) and @next is recursive reader
+ *   SN: @prev is shared reader and @next is non-recursive locker (->read != 2)
+ *   EN: @prev is exclusive locker and @next is non-recursive locker
+ *
+ * Note that we define the value of DEP_*_BITs so that:
+ *   bit0 is prev->read == 0
+ *   bit1 is next->read != 2
+ */
+#define DEP_SR_BIT (0 + (0 << 1)) /* 0 */
+#define DEP_ER_BIT (1 + (0 << 1)) /* 1 */
+#define DEP_SN_BIT (0 + (1 << 1)) /* 2 */
+#define DEP_EN_BIT (1 + (1 << 1)) /* 3 */
+
+#define DEP_SR_MASK (1U << (DEP_SR_BIT))
+#define DEP_ER_MASK (1U << (DEP_ER_BIT))
+#define DEP_SN_MASK (1U << (DEP_SN_BIT))
+#define DEP_EN_MASK (1U << (DEP_EN_BIT))
+
+static inline unsigned int
+__calc_dep_bit(struct held_lock *prev, struct held_lock *next)
+{
+	return (prev->read == 0) + ((next->read != 2) << 1);
+}
+
+static inline u8 calc_dep(struct held_lock *prev, struct held_lock *next)
+{
+	return 1U << __calc_dep_bit(prev, next);
+}
+
+/*
+ * calculate the dep_bit for backwards edges. We care about whether @prev is
+ * shared and whether @next is recursive.
+ */
+static inline unsigned int
+__calc_dep_bitb(struct held_lock *prev, struct held_lock *next)
+{
+	return (next->read != 2) + ((prev->read == 0) << 1);
+}
+
+static inline u8 calc_depb(struct held_lock *prev, struct held_lock *next)
+{
+	return 1U << __calc_dep_bitb(prev, next);
+}
+
 /*
  * Forward- or backward-dependency search, used for both circular dependency
  * checking and hardirq-unsafe/softirq-unsafe checking.
@@ -2552,7 +2604,35 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 		if (entry->class == hlock_class(next)) {
 			if (distance == 1)
 				entry->distance = 1;
-			return 1;
+			entry->dep |= calc_dep(prev, next);
+
+			/*
+			 * Also, update the reverse dependency in @next's
+			 * ->locks_before list.
+			 *
+			 *  Here we reuse @entry as the cursor, which is fine
+			 *  because we won't go to the next iteration of the
+			 *  outer loop:
+			 *
+			 *  For normal cases, we return in the inner loop.
+			 *
+			 *  If we fail to return, we have inconsistency, i.e.
+			 *  <prev>::locks_after contains <next> while
+			 *  <next>::locks_before doesn't contain <prev>. In
+			 *  that case, we return after the inner and indicate
+			 *  something is wrong.
+			 */
+			list_for_each_entry(entry, &hlock_class(next)->locks_before, entry) {
+				if (entry->class == hlock_class(prev)) {
+					if (distance == 1)
+						entry->distance = 1;
+					entry->dep |= calc_depb(prev, next);
+					return 1;
+				}
+			}
+
+			/* <prev> is not found in <next>::locks_before */
+			return 0;
 		}
 	}
 
@@ -2579,14 +2659,18 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	 */
 	ret = add_lock_to_list(hlock_class(next), hlock_class(prev),
 			       &hlock_class(prev)->locks_after,
-			       next->acquire_ip, distance, *trace);
+			       next->acquire_ip, distance,
+			       calc_dep(prev, next),
+			       *trace);
 
 	if (!ret)
 		return 0;
 
 	ret = add_lock_to_list(hlock_class(prev), hlock_class(next),
 			       &hlock_class(next)->locks_before,
-			       next->acquire_ip, distance, *trace);
+			       next->acquire_ip, distance,
+			       calc_depb(prev, next),
+			       *trace);
 	if (!ret)
 		return 0;
 
-- 
2.28.0

