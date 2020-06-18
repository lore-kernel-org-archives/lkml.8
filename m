Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7B3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C53CA206E2
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592447967;
	bh=tSkrvnMpksnJQhC64AZxp0y0YhNgOq7eJDfG0aV9Ngs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mn5TWuKlpK58hE+hllanGzhdsBei/Mhcg3yCAGsV7j8nVlhmlLYrJJ+YHp+MGfEqH
	 0Gncbj/zvBhJ98mkCFOPHm8yZnJEEwqKhw28LHsB8BFZ5Q/pYE7vZAIdvWDQFaMyCA
	 7E4CgcoX9hAkl/ROFWZ3mZ3e7bBKvEiHdSNtLV6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgFRBNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:13:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728847AbgFRBMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:12:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0B1E21924;
        Thu, 18 Jun 2020 01:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442724;
        bh=tSkrvnMpksnJQhC64AZxp0y0YhNgOq7eJDfG0aV9Ngs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YcRGsN56A8Ustpk3K5nxRYuyhwyI5psnJ1B1rarHSykTDwVWOUAh2dzVfPLX60Ac2
         SVytTJGkciqdki3jNLAUagPDxhlbZ16CC//CJSUMeYWPj0fc1nRUphCNhsqn/3lw5f
         BLrnHP6D0rJd25SW2h8tEzB6XYeWvxrj4PP+yJdE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 182/388] PCI: brcmstb: Assert fundamental reset on initialization
Date:   Wed, 17 Jun 2020 21:04:39 -0400
Message-Id: <20200618010805.600873-182-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

[ Upstream commit 22e21e51ce755399fd42055a3f668ee4af370881 ]

While preparing the driver for upstream this detail was missed.

If not asserted during the initialization process, devices connected on
the bus will not be made aware of the internal reset happening. This,
potentially resulting in unexpected behavior.

Link: https://lore.kernel.org/r/20200507172020.18000-1-nsaenzjulienne@suse.de
Fixes: c0452137034b ("PCI: brcmstb: Add Broadcom STB PCIe host controller driver")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-brcmstb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index c9ecc4d639c1..2297910bf6e4 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -697,6 +697,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 
 	/* Reset the bridge */
 	brcm_pcie_bridge_sw_init_set(pcie, 1);
+	brcm_pcie_perst_set(pcie, 1);
 
 	usleep_range(100, 200);
 
-- 
2.25.1

