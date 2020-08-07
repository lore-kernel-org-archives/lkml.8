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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D422C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BC8321744
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kO42LXhm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgHGHpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHGHpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:45:18 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEB8C061574;
        Fri,  7 Aug 2020 00:45:18 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id x69so969265qkb.1;
        Fri, 07 Aug 2020 00:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c/a2s0M/cmgPOYNVrZ8egXbswjf81aCWAk/0fMmNfE8=;
        b=kO42LXhmn4pYDCAupLsIqhd3W/9yIWhblj2fAaSYnorORrC22QSH7wCRTtIAtRp61f
         UiLZQZt7XWDqegDlW0HgVyWeVd2KNZAmvQu5RznrV6eGxZqhqpsY5V4il3lhV9gQ+lyU
         RHPnsXqL4CLMKzHegs2yqjIm0za83TTzl5E4awfqjsw5y2E4zPLkTFECoQClMF9sYcyx
         2vrczl/FQ52s+H9gB5h+ppbwhuSlqO4HX5qJUyE4puALHAOL4rkUsUT8Ihxdy7Du+/2o
         HaZgPZNE2mI9ZwF0Pqxr5gHOHUR9b0TjROEEnSK2/z+mNot2e2wPXaSCkqXuvzw1mQQe
         nLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c/a2s0M/cmgPOYNVrZ8egXbswjf81aCWAk/0fMmNfE8=;
        b=RzbRqyevJmG/E6aCZjna5sBsoppu+7jyNy1PEj0gUovj/gQTxcUsCaB1XNt3MqKZ/8
         eq7ELSjueV9DHXgzIiktxPOP1ZzSse9Cf+QLQjN8bjLiIaA3H4+o0TqQ4D+Pyqddbuts
         CRkNQHUlYHkAEHoqxkVQJDmNikMfAJFdlUvBV5hpUZ2NIBPkJ42ZN9oE6cNme+Gf/VGe
         9tBiqVVy/xc1JG32uDeZP6MSXNBYJQrcwYyrK+hbbr5NpAHVk4MHCoVgh9nBugeqEkrV
         O3zeqJKqRWlJIVXfi9lyWWNob2h0o8o8J6qMITU2sasH9EuvDgwTMQ3A9OIw/Nl+Ztel
         P3IQ==
X-Gm-Message-State: AOAM530ZSliM3RU8n2twgWUVggGo+4D6e1iYzZBlTam4nJuqNh+Hz7bZ
        +KHm8I9sS2bw51FUnjbH/IkyNQ3f
X-Google-Smtp-Source: ABdhPJxgRruBEY1TanvBWcYJyj4TBD6PetZE3u6UWXGQ8+84IqAskDKMJUqo7J0FJJdj+SXJp2jmCA==
X-Received: by 2002:a37:8107:: with SMTP id c7mr12490629qkd.22.1596786317997;
        Fri, 07 Aug 2020 00:45:17 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id n184sm6285200qkn.49.2020.08.07.00.45.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2020 00:45:17 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1404427C0054;
        Fri,  7 Aug 2020 03:45:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 07 Aug 2020 03:45:17 -0400
X-ME-Sender: <xms:jAYtX6RU6ZOb--qsPMLZU-O4HxM8uDuoDb0sR4FkQ-ONQzwnNzljCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedugdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppeduudegrdekhedrudektddrvdduheenucevlhhushhtvghrufhiiigvpe
    dvnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnpe
    epfhhigihmvgdrnhgrmhgvsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:jAYtX_x9iiMg6MWcADBzRxzc90V77BHMyia74-AXwljb-hCCytrk1g>
    <xmx:jAYtX31k2DJl_kCSxyF35gyJOygnfZzF_xplmrFYQRI-XLw_-yQbvA>
    <xmx:jAYtX2CDil48FS88ZUaIWjRjw3amr1-TCAkVIA5Cxwz3guZTifr-Ng>
    <xmx:jQYtXzc7a7hCg4v_8QbfAS1r7udkqCp3gKs0XXf1lR-DMoGgx_pvsw>
Received: from localhost (unknown [114.85.180.215])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3E51230600B4;
        Fri,  7 Aug 2020 03:45:14 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v7 12/19] lockdep: Add recursive read locks into dependency graph
Date:   Fri,  7 Aug 2020 15:42:31 +0800
Message-Id: <20200807074238.1632519-13-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200807074238.1632519-1-boqun.feng@gmail.com>
References: <20200807074238.1632519-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have all the fundamental to handle recursive read locks, we now
add them into the dependency graph.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/lockdep.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 040509667798..867199c4b85d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2808,16 +2808,6 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	if (!check_irq_usage(curr, prev, next))
 		return 0;
 
-	/*
-	 * For recursive read-locks we do all the dependency checks,
-	 * but we dont store read-triggered dependencies (only
-	 * write-triggered dependencies). This ensures that only the
-	 * write-side dependencies matter, and that if for example a
-	 * write-lock never takes any other locks, then the reads are
-	 * equivalent to a NOP.
-	 */
-	if (next->read == 2 || prev->read == 2)
-		return 1;
 	/*
 	 * Is the <prev> -> <next> dependency already present?
 	 *
@@ -2935,13 +2925,8 @@ check_prevs_add(struct task_struct *curr, struct held_lock *next)
 		u16 distance = curr->lockdep_depth - depth + 1;
 		hlock = curr->held_locks + depth - 1;
 
-		/*
-		 * Only non-recursive-read entries get new dependencies
-		 * added:
-		 */
-		if (hlock->read != 2 && hlock->check) {
-			int ret = check_prev_add(curr, hlock, next, distance,
-						 &trace);
+		if (hlock->check) {
+			int ret = check_prev_add(curr, hlock, next, distance, &trace);
 			if (!ret)
 				return 0;
 
-- 
2.28.0

