Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AD1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6331F20707
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943164;
	bh=c3D9IJ41MsusLeTMRh0YH9A/48jMQYCr5ECatNOuTpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NTguDUO+7HkBgqtecn0ul+jdTydbFLzSTYSphTQUVISKJHsS7y14im2a1NjZOKL3e
	 67GAnUBS24s2BlTA9+642GWw9dxEzXc+5sLajnl/1nEVapJGuikPDs83sf3vR+LteR
	 jqPTglX/yehUOL4LVIE9yhKZgVPoXRvwznHQNgvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388634AbgFWUMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:12:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388958AbgFWUMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:12:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4596420707;
        Tue, 23 Jun 2020 20:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943138;
        bh=c3D9IJ41MsusLeTMRh0YH9A/48jMQYCr5ECatNOuTpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=usDmFIWMZxfpkSvMwM0gSOP6VQ9GvfZN4vnfQGL8k8VoWiaEydqCzoh82CkT6dkkw
         zRIkNjuXhVO+Of93B001rTdNNznbGQi6rWzquoeNB0tYvU18KvYicM503I6vLUDEmt
         P29FKMiqn4D/8lKR9bNTl9USZMLqxcU9p8PwkCbU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Souptick Joarder <jrdr.linux@gmail.com>,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 234/477] fpga: dfl: afu: Corrected error handling levels
Date:   Tue, 23 Jun 2020 21:53:51 +0200
Message-Id: <20200623195418.634165969@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Souptick Joarder <jrdr.linux@gmail.com>

[ Upstream commit c9d7e3da1f3c4cf5dddfc5d7ce4d76d013aba1cc ]

Corrected error handling goto sequnece. Level put_pages should
be called when pinned pages >= 0 && pinned != npages. Level
free_pages should be called when pinned pages < 0.

Fixes: fa8dda1edef9 ("fpga: dfl: afu: add DFL_FPGA_PORT_DMA_MAP/UNMAP ioctls support")
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Acked-by: Wu Hao <hao.wu@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Link: https://lore.kernel.org/r/1589825991-3545-1-git-send-email-jrdr.linux@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/fpga/dfl-afu-dma-region.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
index 62f924489db59..5942343a5d6ea 100644
--- a/drivers/fpga/dfl-afu-dma-region.c
+++ b/drivers/fpga/dfl-afu-dma-region.c
@@ -61,10 +61,10 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
 				     region->pages);
 	if (pinned < 0) {
 		ret = pinned;
-		goto put_pages;
+		goto free_pages;
 	} else if (pinned != npages) {
 		ret = -EFAULT;
-		goto free_pages;
+		goto put_pages;
 	}
 
 	dev_dbg(dev, "%d pages pinned\n", pinned);
-- 
2.25.1



