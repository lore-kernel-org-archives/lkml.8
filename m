Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF4EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B3E206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597683185;
	bh=K1hirN2sBpFZcADEX5DOg98QwrA5CvrnN4JSkIwDI64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pxI+ipPeuQjgE6EaCRyWQ+lASpQ7C4jQgIvLNG58HLmIsr5ykgHIWC8RS4gvp2373
	 yG7neE27M4cUjuzSe2rcuyMsQCstcgKnduoVCCuQ4pdZ/YVoWukpF8VEpLIei+Gxqx
	 D52a70k3qFRule0GBS5HghinB/VyxSqWPJPr2fdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389095AbgHQQw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:52:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731033AbgHQQDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:03:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B46D1206FA;
        Mon, 17 Aug 2020 16:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680178;
        bh=K1hirN2sBpFZcADEX5DOg98QwrA5CvrnN4JSkIwDI64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SoEWyVPsje7hKVULu5p0gel6Y+kA1kgBl580r7HfTlynm4dnmPE1qcZo8SgyZnv6y
         8Vc3HjK5wXHGzJvyefb2EiSJbRRGASUjGnUNhqd9k/KmHGeJ3Cmz41OfwlD4aHYQx5
         C7NH+z38Fr76peUYYQf7gEt4EM4SCuphVfUQH+Hc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shirley Her <shirley.her@bayhubtech.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 082/270] mmc: sdhci-pci-o2micro: Bug fix for O2 host controller Seabird1
Date:   Mon, 17 Aug 2020 17:14:43 +0200
Message-Id: <20200817143759.860041110@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: shirley her <shirley.her@bayhubtech.com>

[ Upstream commit cdd2b769789ae1a030e1a26f6c37c5833cabcb34 ]

To fix support for the O2 host controller Seabird1, set the quirk
SDHCI_QUIRK2_PRESET_VALUE_BROKEN and the capability bit MMC_CAP2_NO_SDIO.
Moreover, assign the ->get_cd() callback.

Signed-off-by: Shirley Her <shirley.her@bayhubtech.com>
Link: https://lore.kernel.org/r/20200721011733.8416-1-shirley.her@bayhubtech.com
[Ulf: Updated the commit message]
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index fa8105087d684..41a2394313dd0 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -561,6 +561,12 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 			slot->host->mmc_host_ops.get_cd = sdhci_o2_get_cd;
 		}
 
+		if (chip->pdev->device == PCI_DEVICE_ID_O2_SEABIRD1) {
+			slot->host->mmc_host_ops.get_cd = sdhci_o2_get_cd;
+			host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
+			host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
+		}
+
 		host->mmc_host_ops.execute_tuning = sdhci_o2_execute_tuning;
 
 		if (chip->pdev->device != PCI_DEVICE_ID_O2_FUJIN2)
-- 
2.25.1



