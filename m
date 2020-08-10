Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9F6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F153E22CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597087888;
	bh=Bkk7uSPyPlKR0GzH9CuZpxOaO+KfwSErAJhcc2HJeWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FTd6PYcJfAWGO4QTZuljSlAWQLbg3AhhiSAm+qaGVSky1wyhRWiZkNz4D0uqD7hHo
	 54A1UBXKLqKzPK8x7fU/JrI/ekN41c7D5vDn4UeVWpDPyXyVq+/Yjvn4KlEZdS7f84
	 0MLeu+otA/BdNcQYhhMf6GVeUbkZ2/Xbr3VH74KI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgHJTb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:31:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728836AbgHJTKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:10:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12081221E2;
        Mon, 10 Aug 2020 19:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597086609;
        bh=Bkk7uSPyPlKR0GzH9CuZpxOaO+KfwSErAJhcc2HJeWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=npuTQ4O9wUiF5gdZjsC7rY/3AvM9K/cUJnkwB2Urpxs/Y65ra+wHOSSyXXre4jz8l
         r/hyB8GUKNy45u1iwWn2NYmfH3zKzxfP+GaQV1xUKquhFhUoTnexoA0ZhuaTRfAHPq
         5T0crfrHr82yrHYhHwPCLvk8+pffORNq1zU1WTVk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     shirley her <shirley.her@bayhubtech.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 51/64] mmc: sdhci-pci-o2micro: Bug fix for O2 host controller Seabird1
Date:   Mon, 10 Aug 2020 15:08:46 -0400
Message-Id: <20200810190859.3793319-51-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810190859.3793319-1-sashal@kernel.org>
References: <20200810190859.3793319-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index e2a846885902f..ed3c605fcf0c4 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -561,6 +561,12 @@ static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
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

