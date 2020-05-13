Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E37CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01FDA20753
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363668;
	bh=lhC84TnuSoyPmLnCTzbZ8mLnkdWfxi1drnOTtvPdi7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L0JVVEoANGtQyYpD/Xzih9uywbXFRJwwde7ZWHJLKeSqcy9iqt7MfXc47lQVCXPTW
	 3MwOe0bZ46TRw1W/6bWpuZpsSIEYDUpYKYsg3It2T8qyEaZniCJYBxuH2HkBzikyNx
	 iYheIu7FXAZnazY59yv1F3Gw26jyfGTwRuYPynG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388097AbgEMJy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:54:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388087AbgEMJyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:54:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06758206D6;
        Wed, 13 May 2020 09:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363663;
        bh=lhC84TnuSoyPmLnCTzbZ8mLnkdWfxi1drnOTtvPdi7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BPtJ6kyu8Q6mlTnwxKCiFUaffrYfgLpZckg3300euSWEqTaeAZ/cbGCwGnWLcNQBk
         ivIpE5pIdQKg0PfjmlCHI9pC9y+NT2MXjJs+S0X6J9cG4kcIu99qs8EIyyLNW9tLBN
         e4ybNSlLl0EZS+ruf+374WGya/oQF1+9W7NAcV+k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Haibo Chen <haibo.chen@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.6 076/118] driver core: platform: Initialize dma_parms for platform devices
Date:   Wed, 13 May 2020 11:44:55 +0200
Message-Id: <20200513094424.279803489@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094417.618129545@linuxfoundation.org>
References: <20200513094417.618129545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

commit 9495b7e92f716ab2bd6814fab5e97ab4a39adfdd upstream.

It's currently the platform driver's responsibility to initialize the
pointer, dma_parms, for its corresponding struct device. The benefit with
this approach allows us to avoid the initialization and to not waste memory
for the struct device_dma_parameters, as this can be decided on a case by
case basis.

However, it has turned out that this approach is not very practical.  Not
only does it lead to open coding, but also to real errors. In principle
callers of dma_set_max_seg_size() doesn't check the error code, but just
assumes it succeeds.

For these reasons, let's do the initialization from the common platform bus
at the device registration point. This also follows the way the PCI devices
are being managed, see pci_device_add().

Suggested-by: Christoph Hellwig <hch@lst.de>
Cc: <stable@vger.kernel.org>
Tested-by: Haibo Chen <haibo.chen@nxp.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20200422100954.31211-1-ulf.hansson@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/platform.c         |    2 ++
 include/linux/platform_device.h |    1 +
 2 files changed, 3 insertions(+)

--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -361,6 +361,8 @@ struct platform_object {
  */
 static void setup_pdev_dma_masks(struct platform_device *pdev)
 {
+	pdev->dev.dma_parms = &pdev->dma_parms;
+
 	if (!pdev->dev.coherent_dma_mask)
 		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 	if (!pdev->dev.dma_mask) {
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -25,6 +25,7 @@ struct platform_device {
 	bool		id_auto;
 	struct device	dev;
 	u64		platform_dma_mask;
+	struct device_dma_parameters dma_parms;
 	u32		num_resources;
 	struct resource	*resource;
 


