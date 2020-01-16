Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B755C33CB7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002B82073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579198324;
	bh=IvhLZl9OwsezdqO6p8i8hAjb0pJmYjgbg9Le9zB7u1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TZFm06gMuKjqnFUPIZLLLCsYt+11O30NT/QqTxJM1wg9RWPuW8d0rNoQdiLmLx92w
	 0MdJOWpg8KYt57CII6BSpNuJvrQ3m9n/PoZJ6Yuzxw74WT5ysQKZt/v+5HPoVMvBK+
	 f3rxj0N70o/EUL644iIAHdlKJVoNyAKBsTV9xV1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405336AbgAPRhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:37:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:52318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405325AbgAPRhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:37:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E7C9246D3;
        Thu, 16 Jan 2020 17:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196232;
        bh=IvhLZl9OwsezdqO6p8i8hAjb0pJmYjgbg9Le9zB7u1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ifpo52l9xi6gsIDcBKiGbASWl1LlAf6CFwuRfS0HzzrNfmEsRifkrF/lzFm75b3iB
         RoIoPvYcDOqd1FOGaOEgDyX/CrDrfKFRogFowrN2+Wen/SPV5VbdUHmDr1QsDdax0H
         o0XzdPh7ysi06K19Zuz6m26kOUehx0NgCJYx4g2w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 063/251] fbdev: chipsfb: remove set but not used variable 'size'
Date:   Thu, 16 Jan 2020 12:33:32 -0500
Message-Id: <20200116173641.22137-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
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
index 59abdc6a97f6..314b7eceb81c 100644
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

