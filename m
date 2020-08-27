Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA48C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C25B42080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgH0PUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:20:08 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39954 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbgH0PTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:19:40 -0400
Received: by mail-lf1-f67.google.com with SMTP id j15so3132258lfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 08:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z6/z4dguDMh+ABkWifThvX32BTWJHF5U97fIrS4wAJo=;
        b=ZoPsX8AaXi+bLfG/pVGWaigErI95PMNuwzPuAeXdNbEn4sevrx+FLOt2ZF+9IJp6LM
         QH7HKoxUKdfJCwIyiRyedRdPzIrQb2w86MEmggjYO04WETIxuDNS4vytPNqXYYKc6OTS
         1lPubIusJc5DAxzInOrR+TGU7bNXVRJ0RRSfKZcsY/bxFOLrrJvlXK+cWk+dCMY9117A
         iodg7MztE9yVN+oHtEShLlK7qdVI91vl5yE15ZXq+7d7RBOQB3nUTfOxdnxCOF14RozR
         rSEAYmG/BKZPU4/lpy5izt3lAybuLA5Exx9R/PZBjZvlgkY7akk2a3MwJJQWx/FlXwXT
         E07A==
X-Gm-Message-State: AOAM5319IPQa7KOekFCaUqPu2CeCpKdN7asTdAMzBq0+xtx0fXTq8jc3
        BY7hVCk8Bvag/Ax45ogg7ZqKDyvRYeM=
X-Google-Smtp-Source: ABdhPJyEGZiYkNuZgInzBxT5OnFpV3pZGTXBvPOYEdQG78zh/dhrG4dqnLTMyH9HpZDTEfB37l07ZA==
X-Received: by 2002:ac2:5150:: with SMTP id q16mr10125211lfd.73.1598541578750;
        Thu, 27 Aug 2020 08:19:38 -0700 (PDT)
Received: from localhost.localdomain ([213.87.147.111])
        by smtp.googlemail.com with ESMTPSA id j16sm538092ljg.31.2020.08.27.08.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 08:19:38 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Jan Kara <jack@suse.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] udf: Use kvzalloc() in udf_sb_alloc_bitmap()
Date:   Thu, 27 Aug 2020 18:19:23 +0300
Message-Id: <20200827151923.40067-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvzalloc() in udf_sb_alloc_bitmap() instead of open-coding it.

Signed-off-by: Denis Efremov <efremov@linux.com>
---

I'm not sure about TODO comment, through.

 fs/udf/super.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 1c42f544096d..c7cd15219b7c 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1013,10 +1013,7 @@ static struct udf_bitmap *udf_sb_alloc_bitmap(struct super_block *sb, u32 index)
 	size = sizeof(struct udf_bitmap) +
 		(sizeof(struct buffer_head *) * nr_groups);
 
-	if (size <= PAGE_SIZE)
-		bitmap = kzalloc(size, GFP_KERNEL);
-	else
-		bitmap = vzalloc(size); /* TODO: get rid of vzalloc */
+	bitmap = kvzalloc(size, GFP_KERNEL);
 
 	if (!bitmap)
 		return NULL;
-- 
2.26.2

