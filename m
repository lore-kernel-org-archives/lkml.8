Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23597C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F164F20663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615756;
	bh=5iJtVUZGNri3ZtPnoanSWCWu45x1GVw3xm+WfvF452w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cSHhKuZaDu708Al2hD6bvV4tfV3BagUJa6Y+Cp8Vg6KQKBAMrWOd5Bz/SpLyC7PnP
	 N/9cclO4/JefMjXJcIhuEWTPBa70lp/7QbumzBDoJmGHnjoMndcYw5M4cflDLg0qy5
	 BPGLSnBAcHzAVRssrRiiZKZ5xy4bd5zLJexGDV3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbgEDSJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:09:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732046AbgEDSGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:06:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02044207DD;
        Mon,  4 May 2020 18:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615613;
        bh=5iJtVUZGNri3ZtPnoanSWCWu45x1GVw3xm+WfvF452w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zJigidKiU2/7pFHE+SDfbzuO35jY8zqGGKLu8MQ1xX0k7JkudTQWYJhz8Ov83TEie
         izucoceROo5xiDoto5BpFw9HWBUcrUAKGc4L3ETuc6BTq2oBW101jJQ4BgkyH4agQ5
         VXqRzsG7zOi2lF+lFbli+B9/Yf1fG59m+KdHQtbI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.6 53/73] dmaengine: hisilicon: Fix build error without PCI_MSI
Date:   Mon,  4 May 2020 19:57:56 +0200
Message-Id: <20200504165509.338062751@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165501.781878940@linuxfoundation.org>
References: <20200504165501.781878940@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

commit ae148b43516d90756ff8255925fb7df142b0c76e upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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


