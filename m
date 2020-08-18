Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E91C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 04:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 380A020706
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 04:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzErDCnd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgHREXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 00:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgHREXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 00:23:38 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1278C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 21:23:37 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f10so8605766plj.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 21:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MjCY8rpgvZIeePV2ZEI1OaZrnaoZS1f7YHPkOunmzDc=;
        b=JzErDCndyn4Rs/n2yd72DenQUw5racpwxvZ1Ai1HpU3yj7zIG2QnNfnHu43RR+Cg+w
         V3zlNo08arB101kV9OHzc1RnEm7y6wcZ8p7iXNgIr1n6pJLLBqRBZUonNisA4LMrFNC0
         P/EIToB8UUqqOp1IAzZkBG6Sj4ODm0xNLVVOKgLfZhp37P6GV9BU4XEWg1g5n5fiZRZl
         7PHN8olAJXN1cE2cw68ylMEgpuSzn5IKMPQ8JdVxlVdmifPDEv5e7KPl6sXtC7r23mbA
         unHDZmfHu6EbnjNY4cJddVzM9WJoNIZE6I72vvIIAo2raZWYhJAJXgF2SaL9I7LfmWNH
         Xpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MjCY8rpgvZIeePV2ZEI1OaZrnaoZS1f7YHPkOunmzDc=;
        b=UGem407/c5jumcsY5uunMqIoXyAPTdCQhmOubdjLnSMrEOLzmT6Dh9GBBp3ZdLuv1f
         Yoftx66YxDiISub4563HjyV6vgD2ew8MDzh1SKY8wgnN3inRah6DFFpBmKdOoreIFF1Q
         pbJ5cfZX/kuzq4fsEGjsOycd+u6uSkc4Rlf3DucPXAnyILgMsGgizFAtXlf8hr1hEYBR
         yrVhbgRRg/EkJjy4JaiEVldLGMd9maiJqRcn3hNz1Ylc/rxfrL/Yask9ueitT+ykw7zc
         5zE00Dcie+kIoA3VsZgo/VyD7cmSTHlLoCrBWrzy3b//H1UZ6R41fbm8SKYJ7GR5mxXf
         q+iQ==
X-Gm-Message-State: AOAM533CCoBkXHJLX2LhMfUHG/xllJs6BoQ5ThaYDXKc/3dSbfdpa+gO
        mX2/3mMCrrmyL9zD5jbiuY0=
X-Google-Smtp-Source: ABdhPJy46eUmLUGChVfbGRKdcZHHpjR7Pc2RNX+ASKQP3uknc0mEbY3nkewlaClqzNjO8hXMRV4xhg==
X-Received: by 2002:a17:902:7293:: with SMTP id d19mr14270101pll.303.1597724617198;
        Mon, 17 Aug 2020 21:23:37 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.172.185.173])
        by smtp.gmail.com with ESMTPSA id s6sm19622206pjn.48.2020.08.17.21.23.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Aug 2020 21:23:36 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [RFC PATCH] xen/gntdev.c: Convert get_user_pages*() to pin_user_pages*()
Date:   Tue, 18 Aug 2020 10:02:20 +0530
Message-Id: <1597725140-8310-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 2019, we introduced pin_user_pages*() and now we are converting
get_user_pages*() to the new API as appropriate. [1] & [2] could
be referred for more information. This is case 5 as per document [1].

[1] Documentation/core-api/pin_user_pages.rst

[2] "Explicit pinning of user-space pages":
        https://lwn.net/Articles/807108/

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>
---
 drivers/xen/gntdev.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 64a9025a..e480509 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -730,7 +730,7 @@ static int gntdev_get_page(struct gntdev_copy_batch *batch, void __user *virt,
 	unsigned long xen_pfn;
 	int ret;
 
-	ret = get_user_pages_fast(addr, 1, writeable ? FOLL_WRITE : 0, &page);
+	ret = pin_user_pages_fast(addr, 1, writeable ? FOLL_WRITE : 0, &page);
 	if (ret < 0)
 		return ret;
 
@@ -744,10 +744,7 @@ static int gntdev_get_page(struct gntdev_copy_batch *batch, void __user *virt,
 
 static void gntdev_put_pages(struct gntdev_copy_batch *batch)
 {
-	unsigned int i;
-
-	for (i = 0; i < batch->nr_pages; i++)
-		put_page(batch->pages[i]);
+	unpin_user_pages(batch->pages, batch->nr_pages);
 	batch->nr_pages = 0;
 }
 
-- 
1.9.1

