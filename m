Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03146C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF80720656
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjYH/wpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgHXVSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXVSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 17:18:05 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241DAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 14:18:05 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k20so205332wmi.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 14:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yiV+vzdyB3s6YbQkrMsMF6TiTuCWxljtAH/bA0Yrt6Y=;
        b=gjYH/wpWKMioC0eGcvQc05dxvRGL5hWJNXBr3j0UD3/e7mruv0JSrpM1DONoWc0u7h
         P4XYm55ZCpKPDShld2EGof5Djhj6y7sZNLJJyh/55du83ljAddZ06BvSVgwyQGGW9ivZ
         fHgk7x81TPBhOpbp2FJe6ZuIE/u2DPM6838tJ2Q5+ym/tkFif0Bii65EVIufcAZLLK9l
         HfSbGyA3OaIIz6O8n9EYzcTGE4on0XIPlHcUC4MQ6I4Vq0qf/wpL/9sADhMMDearjHrv
         o7Y8KrM8neExfMT4D9l+lhiMWPeTqaebNHeas7t8uD5gFevCF5cJ+vufyrPoWX45ifRd
         5HbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yiV+vzdyB3s6YbQkrMsMF6TiTuCWxljtAH/bA0Yrt6Y=;
        b=QohGOTMJKVVwwH+noZzYCsfxI3yznfZYxTm4cKJPKLqSqYuc8JLFEJbsgsCStYPOps
         u4Ug48KjuUrHQvpDJS9yipoEb3iupfvJCvty40m1DR85PgW/q+EYfbLuP4kpnV8uFehx
         ySQ3p5PE4SlKUt8c4xEhOzVQSgaSmkUKwVilNjWbWxq0it2Sbr0tcU1U4ILBb9Jm4sKH
         HvdQrfD62XxQu1h2ja0L7nOgi04GKsgmIW2SEM5C1AfgfmeMuo80H6PgrtfpDLYQyG/j
         y6yRdUfBypOME53STxn+VrpG1AxaQYTAKmr/5PRf7RuyBHGlZbF8TQvVGOb2Wo7HvNnL
         j8lg==
X-Gm-Message-State: AOAM531AmOB1qrsxDl6Jx+bOvYOs5gFr+fk7/nr6dGep3qkwIrHA1Khv
        BRN92SVLXGv/LJGjAakD8Qa1FNyZvrzupmx6
X-Google-Smtp-Source: ABdhPJxdiyRGrM8WX4yk+Jt7XjM8Tmc/sNIFBz6g9hMZ8ra+Aud00qWMMb1R6m8WLgeNy0u4MRLroA==
X-Received: by 2002:a7b:c941:: with SMTP id i1mr1039071wml.73.1598303882684;
        Mon, 24 Aug 2020 14:18:02 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id w1sm1479561wmc.18.2020.08.24.14.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 14:18:02 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
To:     Bob Copeland <me@bobcopeland.com>,
        linux-karma-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Alex Dewar <alex.dewar90@gmail.com>
Subject: [PATCH] fs: omfs: use kmemdup() rather than kmalloc+memcpy
Date:   Mon, 24 Aug 2020 22:17:54 +0100
Message-Id: <20200824211755.597245-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Issue identified with Coccinelle.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 fs/omfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index b76ec6b88ded..8867cefa79cf 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -363,12 +363,11 @@ static int omfs_get_imap(struct super_block *sb)
 		bh = sb_bread(sb, block++);
 		if (!bh)
 			goto nomem_free;
-		*ptr = kmalloc(sb->s_blocksize, GFP_KERNEL);
+		*ptr = kmemdup(bh->b_data, sb->s_blocksize, GFP_KERNEL);
 		if (!*ptr) {
 			brelse(bh);
 			goto nomem_free;
 		}
-		memcpy(*ptr, bh->b_data, sb->s_blocksize);
 		if (count < sb->s_blocksize)
 			memset((void *)*ptr + count, 0xff,
 				sb->s_blocksize - count);
-- 
2.28.0

