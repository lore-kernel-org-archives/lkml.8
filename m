Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1CEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0943320B80
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592581503;
	bh=9ys1xBFDNMN3Zfx1f8ojZ9OcYMAvbWAV2H7WG3ATJA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RTYB1hmSTi8GnbFeIQp83I4DwbVpUuKInikBd0f/bG2Uk8tCpxvYu1XeN1bRgdGnW
	 vVdI/LdbY5agoiJolh97epemLCLzZHIB64u4nanJ58+ExFhhHl/yuMuh+/75b2m2Nd
	 Y/4DLfV+pVVKCfAl3YVhO8jbu8AWRsu7zuvK3Fq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393300AbgFSP1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:27:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404292AbgFSP0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:26:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B54F217D8;
        Fri, 19 Jun 2020 15:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580373;
        bh=9ys1xBFDNMN3Zfx1f8ojZ9OcYMAvbWAV2H7WG3ATJA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LugbtoDEGJoxA+7zjxtXXMZ4PpzI2B9+s3uyxWA5/tufL7KXk2yq3KxLMWv3AeiK0
         M06Be3w3P0WT+aW7GP5YakSH4lfaR3yDSqnE8RoK++NFhqIvv/qZ/bqT60oGzpmi6n
         CvdY5RW/hOqJQYvliaFTrZESFqfE8QEAtmiffzXE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 225/376] PCI: Dont disable decoding when mmio_always_on is set
Date:   Fri, 19 Jun 2020 16:32:23 +0200
Message-Id: <20200619141720.967290851@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

[ Upstream commit b6caa1d8c80cb71b6162cb1f1ec13aa655026c9f ]

Don't disable MEM/IO decoding when a device have both non_compliant_bars
and mmio_always_on.

That would allow us quirk devices with junk in BARs but can't disable
their decoding.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Acked-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 77b8a145c39b..d9c2c3301a8a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1822,7 +1822,7 @@ int pci_setup_device(struct pci_dev *dev)
 	/* Device class may be changed after fixup */
 	class = dev->class >> 8;
 
-	if (dev->non_compliant_bars) {
+	if (dev->non_compliant_bars && !dev->mmio_always_on) {
 		pci_read_config_word(dev, PCI_COMMAND, &cmd);
 		if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
 			pci_info(dev, "device has non-compliant BARs; disabling IO/MEM decoding\n");
-- 
2.25.1



