Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E1BC433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74F22207F7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgH0WRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 18:17:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46522 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgH0WRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 18:17:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id h19so8196597ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 15:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O0B+Xa7wBPjWNJbvCt+g8d/rKr338hhSqU8XtS/hi/8=;
        b=jZJK+wpyjB3E9qLiRlMS6AiaH7lzcsi5MKgYpKCyUNoCeV/WNrNvc3cHkjAKjUi2XP
         pBjCwL5k8jlpFqM+iabVQC0zxSkV6F5Z19S7QJdNJ/aPyTFaV/NdgWYX21T73qQnvRfX
         9SNx5APE5TGJdFklCOPkG7gfFoC6qarxkln+K9bKMoqX9QWQx4MydQ1U2LC++jfv7lDk
         DxKBaVD79lWpjkJ+4AKIFBJ5oYkS7GXuXWmCq8aZ8qnz+0zshx0p4ITg6P16C0q4k5Fu
         c6EpxJli4h2QCrXgJzzxtkKRFDjEK49oUVY50XSSHejB6tK7OrYKAyEdQEss9ejzXZQv
         BBpQ==
X-Gm-Message-State: AOAM533X9XBhfPnH7UQ01ZFQwW+Nf9AQyRWsU74Faq+tY1X1gyqbKGD6
        nfHSblH46tecxRsgY5WgL3MLN2xWgcs=
X-Google-Smtp-Source: ABdhPJwsW0t+o41Pb+xImqyG9klcFMm+V/ZSpmPzFMMdJCVLccQ73y41Shy9PvOVlfF9vgAZg73rUQ==
X-Received: by 2002:a2e:85d3:: with SMTP id h19mr11410061ljj.363.1598566630142;
        Thu, 27 Aug 2020 15:17:10 -0700 (PDT)
Received: from localhost.localdomain ([213.87.147.111])
        by smtp.googlemail.com with ESMTPSA id r18sm738387ljm.34.2020.08.27.15.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 15:17:09 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Jan Kara <jack@suse.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>
Subject: [PATCH v3] udf: Use kvzalloc() in udf_sb_alloc_bitmap()
Date:   Fri, 28 Aug 2020 01:16:52 +0300
Message-Id: <20200827221652.64660-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200827151923.40067-1-efremov@linux.com>
References: <20200827151923.40067-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvzalloc() in udf_sb_alloc_bitmap() instead of open-coding it.
Size computation wrapped in struct_size() macro to prevent potential
integer overflows.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
Changes in v2:
 - size computation wrapped in struct_size()
Changes in v3:
 - int size dropped

 fs/udf/super.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 1c42f544096d..d9eabbe368ff 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1006,18 +1006,10 @@ int udf_compute_nr_groups(struct super_block *sb, u32 partition)
 static struct udf_bitmap *udf_sb_alloc_bitmap(struct super_block *sb, u32 index)
 {
 	struct udf_bitmap *bitmap;
-	int nr_groups;
-	int size;
-
-	nr_groups = udf_compute_nr_groups(sb, index);
-	size = sizeof(struct udf_bitmap) +
-		(sizeof(struct buffer_head *) * nr_groups);
-
-	if (size <= PAGE_SIZE)
-		bitmap = kzalloc(size, GFP_KERNEL);
-	else
-		bitmap = vzalloc(size); /* TODO: get rid of vzalloc */
+	int nr_groups = udf_compute_nr_groups(sb, index);
 
+	bitmap = kvzalloc(struct_size(bitmap, s_block_bitmap, nr_groups),
+			  GFP_KERNEL);
 	if (!bitmap)
 		return NULL;
 
-- 
2.26.2

