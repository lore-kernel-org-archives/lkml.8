Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57655C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 274EE206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948247;
	bh=eifDWVPFldsD+PyNHHITs1T5QKTW3hVGnwp/JVTCbCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1hrF+9oRE59jeAo/47RsDteojcc0SnBvoqvM+jlLXRxFAGKhS9HuhrAGnzH7FbLnb
	 XUTmj3xNFTsB2etJ9Ik8mXusJsvQwi9cnBr8ODd4rs2BdD47YKqFvq9RvyU+ELYd0J
	 0RQFDuy1fb/XrkE0Kl1EW8XLY4YkWm39RjXfiXnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388312AbgFWUJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:09:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387940AbgFWUIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:08:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54C1B2078A;
        Tue, 23 Jun 2020 20:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942897;
        bh=eifDWVPFldsD+PyNHHITs1T5QKTW3hVGnwp/JVTCbCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bB9rmNvez3ktTfRUFmAITvXXWo/R5KPM4SM46KQY4aWz3xd588PeCwULXJ3XjhFzR
         p6H3ysTw5pXcVD82hLJyQdWm93cUJqoGpZMc8UQ2+pjbELXwwe0GL1H/1KZkuW+xtP
         V2lTdtD8Fp28Tbi54C1XfuivNsZVhKR/pNX8g1PA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 179/477] PCI: brcmstb: Assert fundamental reset on initialization
Date:   Tue, 23 Jun 2020 21:52:56 +0200
Message-Id: <20200623195416.044902331@linuxfoundation.org>
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
index c9ecc4d639c19..2297910bf6e47 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -697,6 +697,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 
 	/* Reset the bridge */
 	brcm_pcie_bridge_sw_init_set(pcie, 1);
+	brcm_pcie_perst_set(pcie, 1);
 
 	usleep_range(100, 200);
 
-- 
2.25.1



