Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39155C433F2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20F69207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbgG1W5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:57:40 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45944 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729937AbgG1W5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:57:30 -0400
Received: by mail-qk1-f195.google.com with SMTP id u64so20414198qka.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zGrAc382g2MbcGesk1KGEJOXCh/rORh/jxXTBYyLCoc=;
        b=klitusfgth6p6XAJQJeGXrqPyrSFVHRyAHARVFzFRyl7AWSIu3URLdcdF1YSCZ6j/N
         9sZkIxemWsDiX3nRpwho21imiSgI8uEMQYfd6lAKtY25kLeJIBN35md4QLur/FyYdYSm
         In1s1sfYdFDcM0C7m7/m6Ay1FNOP818YDMEh0Bgx8HC94w5uTzfLnISPv8g/H4iawStN
         jfD5tLyaM6aLl4NZk4ho5ovsB3T76RHfLyr5fjT4+he1709HgT58HXabzv7xhkLdpaTM
         qKLzxMEpk1+I5c6MB2AW9l1FCpGkQNvj5dHzdqDWsYmUmKeTTqPrESiX2NwNdbnU8iBR
         gP2Q==
X-Gm-Message-State: AOAM531iztM+F24GafmTihkwxP2JOnqw2gXXdmGlo6cUxFi9e+fnvSlq
        gqloFl8NHJifqQd7WYuUWb8=
X-Google-Smtp-Source: ABdhPJy9svQ6mpU6e1PKthqAjEiwv4oBTY5wUOPuLW13XekmBrmSNhlMW4rWROI+t88hOYctjnpdWg==
X-Received: by 2002:a37:4884:: with SMTP id v126mr29006721qka.118.1595977049163;
        Tue, 28 Jul 2020 15:57:29 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o187sm88118qkd.112.2020.07.28.15.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 15:57:28 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/21] x86/kaslr: Eliminate start_orig from __process_mem_region
Date:   Tue, 28 Jul 2020 18:57:08 -0400
Message-Id: <20200728225722.67457-8-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727230801.3468620-1-nivedita@alum.mit.edu>
References: <20200727230801.3468620-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the region.size within the loop, which removes the need for
start_orig.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/kaslr.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index f2454eef5790..e978c3508814 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -623,7 +623,7 @@ static void __process_mem_region(struct mem_vector *entry,
 				 unsigned long image_size)
 {
 	struct mem_vector region, overlap;
-	unsigned long start_orig, end;
+	unsigned long end;
 
 	/* Ignore entries entirely below our minimum. */
 	if (entry->start + entry->size < minimum)
@@ -635,12 +635,9 @@ static void __process_mem_region(struct mem_vector *entry,
 		return;
 
 	region.start = entry->start;
-	region.size = end - entry->start;
 
 	/* Give up if slot area array is full. */
 	while (slot_area_index < MAX_SLOT_AREA) {
-		start_orig = region.start;
-
 		/* Potentially raise address to minimum location. */
 		if (region.start < minimum)
 			region.start = minimum;
@@ -653,7 +650,7 @@ static void __process_mem_region(struct mem_vector *entry,
 			return;
 
 		/* Reduce size by any delta from the original address. */
-		region.size -= region.start - start_orig;
+		region.size = end - region.start;
 
 		/* Return if region can't contain decompressed kernel */
 		if (region.size < image_size)
@@ -679,7 +676,6 @@ static void __process_mem_region(struct mem_vector *entry,
 			return;
 
 		/* Clip off the overlapping region and start over. */
-		region.size -= overlap.start - region.start + overlap.size;
 		region.start = overlap.start + overlap.size;
 	}
 }
-- 
2.26.2

