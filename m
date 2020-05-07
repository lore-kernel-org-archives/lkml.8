Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551D0C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A35E20575
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588862325;
	bh=VujpZ264NN50hi2Dmy+VET+3Nlfsfe7McoyO1W4r9dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2u8BkNi8GPtXfANT+O8ADXOgEDnGUD27hopUNNzKiG/s20NcnwBMIUxznlh34RtvH
	 LssISM59+mFMk3K9+XRzOZN++UuGvKjMzu+prQLRTHeuZrAWyafCk3rWEgbTCMzSIQ
	 Pi9I8vk94wifFAelPniMn7BKGlXDd0Evn26/x88s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgEGO1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgEGO1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:27:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D44F20870;
        Thu,  7 May 2020 14:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588861650;
        bh=VujpZ264NN50hi2Dmy+VET+3Nlfsfe7McoyO1W4r9dk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iRbLX/xAEYV5M0zozQXFRMAj24y4xM6mV7oZUAA21m2BcXJE3mCvZa4ZB9bMJCNMu
         qbt3bAI/ycV4JuWHb7HE4kaPKNGkWY/AqwNw/xHW5UGgixrxXN1TlRD3OBiOMf4Os3
         KfTj9Rtsept/ZX6EagkZWxFcRaQyBEUfPJgQsL/A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>, Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <sashal@kernel.org>, dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 03/50] dmaengine: hisilicon: Fix build error without PCI_MSI
Date:   Thu,  7 May 2020 10:26:39 -0400
Message-Id: <20200507142726.25751-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200507142726.25751-1-sashal@kernel.org>
References: <20200507142726.25751-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit ae148b43516d90756ff8255925fb7df142b0c76e ]

If PCI_MSI is not set, building fais:

drivers/dma/hisi_dma.c: In function ‘hisi_dma_free_irq_vectors’:
drivers/dma/hisi_dma.c:138:2: error: implicit declaration of function ‘pci_free_irq_vectors’;
 did you mean ‘pci_alloc_irq_vectors’? [-Werror=implicit-function-declaration]
  pci_free_irq_vectors(data);
  ^~~~~~~~~~~~~~~~~~~~

Make HISI_DMA depends on PCI_MSI to fix this.

Fixes: e9f08b65250d ("dmaengine: hisilicon: Add Kunpeng DMA engine support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20200328114133.17560-1-yuehaibing@huawei.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 5142da401db3f..c7e1dfe81d1e6 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -241,7 +241,8 @@ config FSL_RAID
 
 config HISI_DMA
 	tristate "HiSilicon DMA Engine support"
-	depends on ARM64 || (COMPILE_TEST && PCI_MSI)
+	depends on ARM64 || COMPILE_TEST
+	depends on PCI_MSI
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.20.1

