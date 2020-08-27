Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDF3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 21:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D30720825
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 21:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgH0VZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 17:25:47 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40185 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgH0VZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 17:25:45 -0400
Received: by mail-lf1-f67.google.com with SMTP id j15so3706278lfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 14:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xbw0XMQIxQp3SFjhDOnpVzdj9Xjf2+nKdm+xYrgHGgo=;
        b=FOwDL0dCf7vSSIb/HMot23++RxNuj/KHjI4dyn2gBFLf3heKR8ZBlfYcPQu7bXEUDM
         nGWESIdNuKfumWufCG08wdSGqT3E6iQ2qdgDVgQg+NQUNSQsclTddQbd2sk2YdENHOgf
         MCXymE+7PmURl+n/mKbW47Q9C125OokCaGslvVnonwJPKpy7kbGlj3cnsn6SE9mDSvrX
         8NcLr770M7DeEc80YZyjiHFh/w2+DGx5YUvUMxBxLoXEA53Bx5loKOdyHxx9L1XyukSB
         WtsqEZnuICbNPciC7DxPyrwBK5mbGDQ4DGXKsSq/91H8pm4abh3eKYIZvG+qldFkWj+6
         QlkA==
X-Gm-Message-State: AOAM533ukd+QAPuUXFuOc5RMjvsny9mPHquTZ9eqaVtfqq0+6CYYQfSA
        qPg7MqrDugRQcBeH0x1evz84L6b1vlg=
X-Google-Smtp-Source: ABdhPJzkQAUqJeQCrQeHGhUjnNDSoErmr9ZbQtgPwYtjSjHHh2wdGMrysS94ZDyrdEDuQwG70rGzFA==
X-Received: by 2002:a05:6512:31c2:: with SMTP id j2mr10999275lfe.85.1598563543454;
        Thu, 27 Aug 2020 14:25:43 -0700 (PDT)
Received: from localhost.localdomain ([213.87.147.111])
        by smtp.googlemail.com with ESMTPSA id n29sm803427lfi.9.2020.08.27.14.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 14:25:42 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Jan Kara <jack@suse.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2] udf: Use kvzalloc() in udf_sb_alloc_bitmap()
Date:   Fri, 28 Aug 2020 00:25:30 +0300
Message-Id: <20200827212530.48013-1-efremov@linux.com>
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
 fs/udf/super.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 1c42f544096d..bdf51bea54f3 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1010,14 +1010,9 @@ static struct udf_bitmap *udf_sb_alloc_bitmap(struct super_block *sb, u32 index)
 	int size;
 
 	nr_groups = udf_compute_nr_groups(sb, index);
-	size = sizeof(struct udf_bitmap) +
-		(sizeof(struct buffer_head *) * nr_groups);
-
-	if (size <= PAGE_SIZE)
-		bitmap = kzalloc(size, GFP_KERNEL);
-	else
-		bitmap = vzalloc(size); /* TODO: get rid of vzalloc */
+	size = struct_size(bitmap, s_block_bitmap, nr_groups);
 
+	bitmap = kvzalloc(size, GFP_KERNEL);
 	if (!bitmap)
 		return NULL;
 
-- 
2.26.2

