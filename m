Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50003C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E9C921582
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592427979;
	bh=PxleSRdzxhbBNA5Z6VGYwX4pwZygLkPhy8QDrAX3jCk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=gLSInnDR3Zahyk9emHCs9kp0BGAchutM4lKOfZJ0G2vteVVPJ3mPMm8FTO5BOvXEa
	 CqxWK7KXMmzszSwoGRdXFdGFfiysglEE1gKrpUhOEue6gkPno/8KPIuOBoM5N3C2UW
	 8l7UAA7LRH2Jb5O2Zt3NT/cTb7FFR84J5cKBIwm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgFQVGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:06:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbgFQVGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:06:15 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F8CE2186A;
        Wed, 17 Jun 2020 21:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592427975;
        bh=PxleSRdzxhbBNA5Z6VGYwX4pwZygLkPhy8QDrAX3jCk=;
        h=Date:From:To:Cc:Subject:From;
        b=zBAD2pPyr5zueEtIkpdCXgi7IRAM+MnOtTEf0cFRMdnBMiDG6HfNpnK76KbKhg5rY
         nL9uhthDQKlT/UphVgxG81qqyn4Q9UCBABeqek8Om/jsddbJ0cGZyPSl1rCKFPUmoD
         2bKIGoBBqDcN4Wm5z+YGkK1H4c1f34HUfl1WHbbc=
Date:   Wed, 17 Jun 2020 16:11:35 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Zhou Wang <wangzhou1@hisilicon.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] dmaengine: hisilicon: Use struct_size() in
 devm_kzalloc()
Message-ID: <20200617211135.GA8660@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/dma/hisi_dma.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
index ed3619266a48..e1a958ae7925 100644
--- a/drivers/dma/hisi_dma.c
+++ b/drivers/dma/hisi_dma.c
@@ -511,7 +511,6 @@ static int hisi_dma_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct device *dev = &pdev->dev;
 	struct hisi_dma_dev *hdma_dev;
 	struct dma_device *dma_dev;
-	size_t dev_size;
 	int ret;
 
 	ret = pcim_enable_device(pdev);
@@ -534,9 +533,7 @@ static int hisi_dma_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		return ret;
 
-	dev_size = sizeof(struct hisi_dma_chan) * HISI_DMA_CHAN_NUM +
-		   sizeof(*hdma_dev);
-	hdma_dev = devm_kzalloc(dev, dev_size, GFP_KERNEL);
+	hdma_dev = devm_kzalloc(dev, struct_size(hdma_dev, chan, HISI_DMA_CHAN_NUM), GFP_KERNEL);
 	if (!hdma_dev)
 		return -EINVAL;
 
-- 
2.27.0

