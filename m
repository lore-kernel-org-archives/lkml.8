Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C97C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D8CA21556
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592578328;
	bh=ROXJ/dCfl2QDTiLF5kuqW9IcXc8XrfktjT2CXamAzmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L/X1/MnM2htwng3QudNJBdqfksaZc+Lkzb3loARhYAtNKhRBRV7TtOKSvg0BybYCT
	 n0yqkmeMnW5+mxlhc27UY6bhEhU13sUVJP9ztrx19FSLPbguRXAtq8Nl75NLpEq0s3
	 3rOKYvRLd3XJXKf9/0y66oc8rZDXOy5x7TS+fe+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389529AbgFSOwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:52:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389402AbgFSOvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:51:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCA4421919;
        Fri, 19 Jun 2020 14:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578298;
        bh=ROXJ/dCfl2QDTiLF5kuqW9IcXc8XrfktjT2CXamAzmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z9EzPOsuf/qDT05cF0kOkMaUvhlFvCkd0+rhMpyMyYpFYg5mIEvb6FdS7O+DeDlvb
         J/cuGu2hgm98IImbAOd0ZA+xHOfht80TuZVleKvt8a5IRsqKvzzrCg7q0sMtJMHn3Y
         CzXvkM8kNJEUhk+a+bv0/oCDPzum41Nc4jQ4elaQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 129/190] PCI: Dont disable decoding when mmio_always_on is set
Date:   Fri, 19 Jun 2020 16:32:54 +0200
Message-Id: <20200619141640.072874226@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141633.446429600@linuxfoundation.org>
References: <20200619141633.446429600@linuxfoundation.org>
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
index e23bfd9845b1..92c3abe0b2b9 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1446,7 +1446,7 @@ int pci_setup_device(struct pci_dev *dev)
 	/* device class may be changed after fixup */
 	class = dev->class >> 8;
 
-	if (dev->non_compliant_bars) {
+	if (dev->non_compliant_bars && !dev->mmio_always_on) {
 		pci_read_config_word(dev, PCI_COMMAND, &cmd);
 		if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
 			dev_info(&dev->dev, "device has non-compliant BARs; disabling IO/MEM decoding\n");
-- 
2.25.1



