Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87675C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B75A2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592443519;
	bh=EYH7/kEgNRJTHJX5SU2E60AicyWDr58tlgaXuyLRoIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q/YZdP8wBM9+auwOGyqGE7qbfFpuf2XSspC/nowVusMEkE7G4IWKYffrbQnc972uy
	 +cn9D9rzSGYKUHFe0xmUSuthosHaNYaGTVR+3YhYCHGxJD51jtzK7CVEbVrbnKjJuo
	 mSkBRKMWwHULEDwnS29xb8YvBgnn7MUGP20nzg0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731401AbgFRBZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728705AbgFRBWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:22:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BD8121D79;
        Thu, 18 Jun 2020 01:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443330;
        bh=EYH7/kEgNRJTHJX5SU2E60AicyWDr58tlgaXuyLRoIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DSbE8PuXex5GKGlqP87wkxayRc6iDZhTG15uSsNgHAOD71+2OdyNCRgYkdZBK1ER9
         +8gKRfscZNQxXozSlW5rZ4Dt02cGis4GSyMJUEhGZsb8dwbjYEiwQ0YYDdYGcZD7ue
         PMO+b3hfDyD44tXGb16sHEdv40hqhaSKz+QGGuqo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 262/266] nvme-pci: use simple suspend when a HMB is enabled
Date:   Wed, 17 Jun 2020 21:16:27 -0400
Message-Id: <20200618011631.604574-262-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index cd64ddb129e5..acbdf21b76ed 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2962,9 +2962,15 @@ static int nvme_suspend(struct device *dev)
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

