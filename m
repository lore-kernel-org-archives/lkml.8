Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4ABC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93A012078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592942537;
	bh=KDCZQvqdAi5XGVXy96cscaB4/BKTEoHivnLyELckPd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QTQ/0Qh0U43vvVeUPf+HnX9XVrL1i10pGr601aY2iO7NXO3r5PaJBiaPw1wq8FrOX
	 clPaYTvl7fM7RYaBRUsqeI7JtIhZ8mKp8RznwR4hgXy4qDO20WlXRemdLoLoUx32du
	 rkAt0sbHv13ThWvGkUPu9mU7ydkdk82vBC/fvwcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387547AbgFWUCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:02:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387759AbgFWUCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:02:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7D8520DD4;
        Tue, 23 Jun 2020 20:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942522;
        bh=KDCZQvqdAi5XGVXy96cscaB4/BKTEoHivnLyELckPd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=brGtOzAvunUcv0cVHCp/MVQIZbzdOCGBySvRz9QVBCNLqKuoQOlZMB2eaJuhwBZ0O
         ImTDqlX9Z51qt7BEYfT67KSrvCUJOOdsB0EtcmO03nHrTKbck3hpPrtcGhIr7ypj1d
         V3xLINDElQ8i6GUKe+onhFH/Pxg+OJbPcsWYQ/XQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jim Quinlan <jquinlan@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 030/477] PCI: brcmstb: Fix window register offset from 4 to 8
Date:   Tue, 23 Jun 2020 21:50:27 +0200
Message-Id: <20200623195409.021403046@linuxfoundation.org>
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

From: Jim Quinlan <jquinlan@broadcom.com>

[ Upstream commit 077a4fa92a615a4d0f86eae68d777b9dd5e5a95b ]

The outbound memory window registers were being referenced
with an incorrect stride offset.  This probably wasn't noticed
previously as there was likely only one such window employed.

Link: https://lore.kernel.org/r/20200507201544.43432-3-james.quinlan@broadcom.com
Fixes: c0452137034b ("PCI: brcmstb: Add Broadcom STB PCIe host controller driver")
Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-brcmstb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 6d79d14527a66..c9ecc4d639c19 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -54,11 +54,11 @@
 
 #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO		0x400c
 #define PCIE_MEM_WIN0_LO(win)	\
-		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO + ((win) * 4)
+		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO + ((win) * 8)
 
 #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI		0x4010
 #define PCIE_MEM_WIN0_HI(win)	\
-		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI + ((win) * 4)
+		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI + ((win) * 8)
 
 #define PCIE_MISC_RC_BAR1_CONFIG_LO			0x402c
 #define  PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_MASK		0x1f
-- 
2.25.1



