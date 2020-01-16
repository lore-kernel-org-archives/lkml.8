Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F14CC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213662468C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195495;
	bh=bT5/2MJcIpgpjY2eppwjDB2SlZlU7x8jPy5Cpzfz2y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lPkLFusPQN57Rbrgf/K2CfIn+iXjoagtJuc9wLZrC4sGBqcSdskbrT2cQ55QyYCuQ
	 Yy/6cwcZEJQr/Gr1KPG9WeYIUSRNF2L8xcjJRTBVj9VgFtRfDF5ZCfLjKdN6y+mpIm
	 EUG6yzG+3m2C06b556JYb594QLuFs9W5dD5V2uGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403841AbgAPRYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:24:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:59780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391372AbgAPRYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:24:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DC4F246B6;
        Thu, 16 Jan 2020 17:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195485;
        bh=bT5/2MJcIpgpjY2eppwjDB2SlZlU7x8jPy5Cpzfz2y0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tbIMTR+vhKyZHfSjrBTXqBOVMoqnGPKR9DQbBtv/w0p8VKoNcw5OpxJPl7p5YUfwu
         Mg9kBKQq4wwTEnSQgE6v5FF++rUVqKX4gjh2lAxgPLE8xZ9XpsGfgu19AofTFWiNWt
         fkXTeNxgg/tMNZCJUsfU45mnMZFbhtDTD4Qtz8fo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 089/371] fbdev: chipsfb: remove set but not used variable 'size'
Date:   Thu, 16 Jan 2020 12:19:21 -0500
Message-Id: <20200116172403.18149-32-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 8e71fa5e4d86bedfd26df85381d65d6b4c860020 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/video/fbdev/chipsfb.c: In function 'chipsfb_pci_init':
drivers/video/fbdev/chipsfb.c:352:22: warning:
 variable 'size' set but not used [-Wunused-but-set-variable]

Fixes: 8c8709334cec ("[PATCH] ppc32: Remove CONFIG_PMAC_PBOOK").
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
[b.zolnierkie: minor commit summary and description fixups]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/chipsfb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/chipsfb.c b/drivers/video/fbdev/chipsfb.c
index f103665cad43..f9b366d17587 100644
--- a/drivers/video/fbdev/chipsfb.c
+++ b/drivers/video/fbdev/chipsfb.c
@@ -350,7 +350,7 @@ static void init_chips(struct fb_info *p, unsigned long addr)
 static int chipsfb_pci_init(struct pci_dev *dp, const struct pci_device_id *ent)
 {
 	struct fb_info *p;
-	unsigned long addr, size;
+	unsigned long addr;
 	unsigned short cmd;
 	int rc = -ENODEV;
 
@@ -362,7 +362,6 @@ static int chipsfb_pci_init(struct pci_dev *dp, const struct pci_device_id *ent)
 	if ((dp->resource[0].flags & IORESOURCE_MEM) == 0)
 		goto err_disable;
 	addr = pci_resource_start(dp, 0);
-	size = pci_resource_len(dp, 0);
 	if (addr == 0)
 		goto err_disable;
 
-- 
2.20.1

