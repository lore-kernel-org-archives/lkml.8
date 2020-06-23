Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF832C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9702E2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943470;
	bh=iCr6FK7WZcFVNG4YpLMaetlcE8vEd+d5zMLhFXl1Wuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BLVhuy0PJ/fBOEGwn3FuQMg/xTT7qOcON+cYj+h7Y0ecHpzXFuzwihDn2i5IWYquz
	 QK4CKrVZZrvp1mUpBhdB/y4UD/o9Y2BDqePDHZ8OFT7unnhhs/Iwzc/sPbK8b2s+UC
	 kwPE83w/ylNqRulKSvRZf25bTfTQ0k9at1ubFskc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389593AbgFWURs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:17:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388765AbgFWURm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:17:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEFE72064B;
        Tue, 23 Jun 2020 20:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943462;
        bh=iCr6FK7WZcFVNG4YpLMaetlcE8vEd+d5zMLhFXl1Wuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cZB36OGWDuhAdKEFy/3GCRb0YNe+qQ+eGwqAuplLXyISMrjPQIMmJ5E3wAwLXjx53
         ibMJQPuIfkHx+161OFNadhZDu4eRcGvlyDZs3zyFRATmS3AjTlWW0WLLytko6EtJ5D
         +Ff6vmW+aim99j+ymPU0GOuz4NKDwcfDC1a7vDUc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 371/477] nvme-pci: use simple suspend when a HMB is enabled
Date:   Tue, 23 Jun 2020 21:56:08 +0200
Message-Id: <20200623195425.068153640@linuxfoundation.org>
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit b97120b15ebd3de51325084136d3b9c3cce656d6 ]

While the NVMe specification allows the device to access the host memory
buffer in host DRAM from all power states, hosts will fail access to
DRAM during S3 and similar power states.

Fixes: d916b1be94b6 ("nvme-pci: use host managed power state for suspend")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 076bdd90c9224..4ad629eb3bc66 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2958,9 +2958,15 @@ static int nvme_suspend(struct device *dev)
 	 * the PCI bus layer to put it into D3 in order to take the PCIe link
 	 * down, so as to allow the platform to achieve its minimum low-power
 	 * state (which may not be possible if the link is up).
+	 *
+	 * If a host memory buffer is enabled, shut down the device as the NVMe
+	 * specification allows the device to access the host memory buffer in
+	 * host DRAM from all power states, but hosts will fail access to DRAM
+	 * during S3.
 	 */
 	if (pm_suspend_via_firmware() || !ctrl->npss ||
 	    !pcie_aspm_enabled(pdev) ||
+	    ndev->nr_host_mem_descs ||
 	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
 		return nvme_disable_prepare_reset(ndev, true);
 
-- 
2.25.1



