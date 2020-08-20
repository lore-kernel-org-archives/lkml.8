Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D503C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4498B207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597928028;
	bh=Q1zIU5SuzkyJ10BIgp1gFKULbwqkncB9RaWdhQ0CRdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FeK0zZL2U0x3bjbQIh+9TvEOrLRKd7HxsxKtL843Lydvr1eums1YpF7sg1hgspL/S
	 h3d0esv9zNWnuVgqBP7yiRTWgXFbC8+EMfC+NUW2Vd8YatSTyXLlW9T1KUIp/4HL/L
	 P/nrjLKsCQXnveZPQf9EH71irfTVrMURohuSpmT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbgHTMxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:53:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729249AbgHTJne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:43:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A986D2173E;
        Thu, 20 Aug 2020 09:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916614;
        bh=Q1zIU5SuzkyJ10BIgp1gFKULbwqkncB9RaWdhQ0CRdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=So6NMa8ZxFqKMKebBIftKfBOvYTDoAz0PS9tY9fJ7JaWduZUFawuM62PM3FE8NmB0
         h77dt8MMEJGAP93tpIj1TN6OuwD8a9hdgnlJZtX3UAPK6XGJ9+2OXEYd5536zwmx9H
         swymllT0D4yoyS/RMBLH/XtG1ep5G9+T0ruZo8k0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Song Liu <songliubraving@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 160/204] md-cluster: Fix potential error pointer dereference in resize_bitmaps()
Date:   Thu, 20 Aug 2020 11:20:57 +0200
Message-Id: <20200820091614.213819693@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit e8abe1de43dac658dacbd04a4543e0c988a8d386 ]

The error handling calls md_bitmap_free(bitmap) which checks for NULL
but will Oops if we pass an error pointer.  Let's set "bitmap" to NULL
on this error path.

Fixes: afd756286083 ("md-cluster/raid10: resize all the bitmaps before start reshape")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md-cluster.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
index 73fd50e779754..d50737ec40394 100644
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -1139,6 +1139,7 @@ static int resize_bitmaps(struct mddev *mddev, sector_t newsize, sector_t oldsiz
 		bitmap = get_bitmap_from_slot(mddev, i);
 		if (IS_ERR(bitmap)) {
 			pr_err("can't get bitmap from slot %d\n", i);
+			bitmap = NULL;
 			goto out;
 		}
 		counts = &bitmap->counts;
-- 
2.25.1



