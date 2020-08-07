Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A29CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF02A206B5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lz34vpHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgHGHnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHGHnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:43:53 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B979AC061574;
        Fri,  7 Aug 2020 00:43:52 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id b2so346102qvp.9;
        Fri, 07 Aug 2020 00:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LUzE2cz+TtgYpExlFvy2HYdrMWDloN8RdEEz9paBHTE=;
        b=lz34vpHm4pjOKogJwm1pMOrXHHRPRP2HFLDCvVJFiNIDCeEibNHwS+DHvzz0JomN89
         usSSKX4epe1BpMGN6dKhKgAsHGb1aSXWuHQGxYYZdU/2DI4PLXYl2iX7YRY9IAmTnyfn
         Win4kjWmcEMn73HrhwS2N+TQjjszL2pcUJa7xwW9wSA8cj2aRHgRT+mEdWpphbv4wyXs
         xJTfSTpvY2KlyiuH46FFpm7H4+bNM2jU0nOpMNMPq9z3Lg/SInmFLjeIAqpPySSV3gMi
         cjNRSEXv1fVj6qPg4ozBMj/2fQkSGARcRauqzaEz7RmcEy0ffQmvOE5VxNEs1nyjVYdQ
         K0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LUzE2cz+TtgYpExlFvy2HYdrMWDloN8RdEEz9paBHTE=;
        b=R1l8tdQO141ppAQ8eAHI1rPfdT4pELiYmwwWLXrXrrF3kc2n2DFLAzMf2Le+6QR1as
         oEeuJZgeUBJbmedjsULWGIrK2b9X/5aMhL3CEJETsn5lb5TfuvcT5SreKlEvqleVk6G6
         D1JMUxXa7RTE30S0ml+efBaZ+xqJZCbS2RyE2IFdhNHDhVxz80nWknHiKd/Y+c4kxeai
         SdtmyFJvvDIlcBDcnj6A3Yy9bfUJUMfhQSpZ+lGaVPAokqjIFDA6BqTLs42sm6PQfZbM
         KTVgtrSvL44k3uOz4zCfZtFsIhKodtDEUJ64OjizPuuMcL1W2YnnaK/bNa16qXUXiNkv
         wCOg==
X-Gm-Message-State: AOAM530Faqd33B/N0nttzPnXkAWofwbFsNzC5rSvcvd+K67ow5BqLapg
        tNEhKKDT0hTCIrhsu6IxJ+k8xLbN
X-Google-Smtp-Source: ABdhPJxbXI2pI3g6Sn5iPPlx2lvIQGVtgXjKT+pwWWUzU+2MdyLhttZbVNRk/cNPWU+B86MGINK50Q==
X-Received: by 2002:ad4:4ea7:: with SMTP id ed7mr13694279qvb.8.1596786232076;
        Fri, 07 Aug 2020 00:43:52 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id y26sm6664052qto.75.2020.08.07.00.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2020 00:43:51 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 3F5AE27C0054;
        Fri,  7 Aug 2020 03:43:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 07 Aug 2020 03:43:51 -0400
X-ME-Sender: <xms:NwYtX971kZM8N7nKBntEQEqekdBKfwVzPXFdH6nzG0QtojZ1gdcYlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedugdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppeduudegrdekhedrudektddrvdduheenucevlhhushhtvghrufhiiigvpe
    efnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnpe
    epfhhigihmvgdrnhgrmhgvsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:NwYtX64_qWz8qdzdzSkCyNbfqeBFO_b6gFXZxgpI8fRdINQsGRKoYw>
    <xmx:NwYtX0fJDuOeVX2mWCcv9_GXDLfKke1_jzTk0LlzD-Pl9wDUeEZO5Q>
    <xmx:NwYtX2LpeFpQCL0wb_n8PuCQ8gzj48SmohnZQzfs8Qfr3--QuDAixQ>
    <xmx:NwYtX-Gl6OCqXexpbgVuY56dNPb-LK1HvyvMdk-utYJnODrCbuVQDA>
Received: from localhost (unknown [114.85.180.215])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3E6B230600A9;
        Fri,  7 Aug 2020 03:43:49 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v7 05/19] lockdep: Reduce the size of lock_list::distance
Date:   Fri,  7 Aug 2020 15:42:24 +0800
Message-Id: <20200807074238.1632519-6-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200807074238.1632519-1-boqun.feng@gmail.com>
References: <20200807074238.1632519-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lock_list::distance is always not greater than MAX_LOCK_DEPTH (which
is 48 right now), so a u16 will fit. This patch reduces the size of
lock_list::distance to save space, so that we can introduce other fields
to help detect recursive read lock deadlocks without increasing the size
of lock_list structure.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/lockdep.h  | 2 +-
 kernel/locking/lockdep.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 6b7cb390f19f..b85973515f84 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -212,7 +212,7 @@ struct lock_list {
 	struct lock_class		*class;
 	struct lock_class		*links_to;
 	const struct lock_trace		*trace;
-	int				distance;
+	u16				distance;
 
 	/*
 	 * The parent field is used to implement breadth-first search, and the
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2d9798b71f74..699e9039a9b3 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1320,7 +1320,7 @@ static struct lock_list *alloc_list_entry(void)
  */
 static int add_lock_to_list(struct lock_class *this,
 			    struct lock_class *links_to, struct list_head *head,
-			    unsigned long ip, int distance,
+			    unsigned long ip, u16 distance,
 			    const struct lock_trace *trace)
 {
 	struct lock_list *entry;
@@ -2489,7 +2489,7 @@ check_deadlock(struct task_struct *curr, struct held_lock *next)
  */
 static int
 check_prev_add(struct task_struct *curr, struct held_lock *prev,
-	       struct held_lock *next, int distance,
+	       struct held_lock *next, u16 distance,
 	       struct lock_trace **const trace)
 {
 	struct lock_list *entry;
@@ -2622,7 +2622,7 @@ check_prevs_add(struct task_struct *curr, struct held_lock *next)
 		goto out_bug;
 
 	for (;;) {
-		int distance = curr->lockdep_depth - depth + 1;
+		u16 distance = curr->lockdep_depth - depth + 1;
 		hlock = curr->held_locks + depth - 1;
 
 		/*
-- 
2.28.0

