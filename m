Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73078C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49CF822B47
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597088011;
	bh=xVNJuHkAildX0xCTS4AHRtF9UgkFpucBy56ZAeDRSXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tHH3FTNvgcgHvAeWCpw/P9cCeUMX6mayN7VH1bVk3Z457m/tkNaraOnEDz2MVK/61
	 kGJYuD9E3ggVsgmpYw4yjXrXp6WpuYIEHuF3hZsq/jrkVIKW+szryLXXWOw8paYfWr
	 v7alm7B8BVtqyucjrcyWT7odM1UcXg0MQCPbd4fY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgHJTJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:09:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbgHJTJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:09:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 804F322B45;
        Mon, 10 Aug 2020 19:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597086556;
        bh=xVNJuHkAildX0xCTS4AHRtF9UgkFpucBy56ZAeDRSXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jjBweOYd+EOcNdn1G1er77BjvKtiexXiz8uU3doAIPh17Yi15c4qTG+GQQ4eprb6W
         284mz00Q68UpeeGJXHIbn8cJN4MBel+GHWnNlqiCAAnfJxq5v/HCM1v0ynKclETtH9
         AhrLKpIhvt2ioZOnoy5FLYdr/WyzWOUJZeED29B4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Evgeny Novikov <novikov@ispras.ru>,
        Antonino Daplas <adaplas@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <sashal@kernel.org>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.8 12/64] video: fbdev: savage: fix memory leak on error handling path in probe
Date:   Mon, 10 Aug 2020 15:08:07 -0400
Message-Id: <20200810190859.3793319-12-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810190859.3793319-1-sashal@kernel.org>
References: <20200810190859.3793319-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeny Novikov <novikov@ispras.ru>

[ Upstream commit e8d35898a78e34fc854ed9680bc3f9caedab08cd ]

savagefb_probe() calls savage_init_fb_info() that can successfully
allocate memory for info->pixmap.addr but then fail when
fb_alloc_cmap() fails. savagefb_probe() goes to label failed_init and
does not free allocated memory. It is not valid to go to label
failed_mmio since savage_init_fb_info() can fail during memory
allocation as well. So, the patch free allocated memory on the error
handling path in savage_init_fb_info() itself.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
Cc: Antonino Daplas <adaplas@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200619162136.9010-1-novikov@ispras.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/savage/savagefb_driver.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
index 3c8ae87f0ea7d..3fd87aeb6c798 100644
--- a/drivers/video/fbdev/savage/savagefb_driver.c
+++ b/drivers/video/fbdev/savage/savagefb_driver.c
@@ -2157,6 +2157,8 @@ static int savage_init_fb_info(struct fb_info *info, struct pci_dev *dev,
 			info->flags |= FBINFO_HWACCEL_COPYAREA |
 				       FBINFO_HWACCEL_FILLRECT |
 				       FBINFO_HWACCEL_IMAGEBLIT;
+		else
+			kfree(info->pixmap.addr);
 	}
 #endif
 	return err;
-- 
2.25.1

