Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2093C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6903207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592582643;
	bh=OFSmEOpw7XL/3upg6rxCi50S6LgPyI7pNBP+vW5EA5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qfCO1bto9KOWroKFPQe32OlE3MI8zdMpMclxtPIeAza8coGguiQALqZfRUI1jVE5C
	 FcDIiQnSlwPeHgG3S3NErp/xMb/s3ws/Qytzl9msHMa0pIOxbfexlFj2uJRaHptr2H
	 UNgpicpTTBVfMu/8oeHe/UyEGVLiVmtS+z/pvqpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391448AbgFSPLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:11:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403788AbgFSPKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:10:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 759B9206FA;
        Fri, 19 Jun 2020 15:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579451;
        bh=OFSmEOpw7XL/3upg6rxCi50S6LgPyI7pNBP+vW5EA5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v/03ozNYArhQjGMDTT6dB22JLFTU8svBZzZpXtP/VYqYIhEuFQg6oQWk7BuR1osrL
         dn8nGh9SGuaHOpHaP8iAMD0PxKV0WMENJUU3mDH3Y3z+LTswbZWtemUUk0lDOckIze
         0+9Mga/0kp6UwVt4gGXvJ6TndHQ1UIx8/JGPTi3U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 140/261] mmc: sdhci-msm: Set SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 quirk
Date:   Fri, 19 Jun 2020 16:32:31 +0200
Message-Id: <20200619141656.574156309@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141649.878808811@linuxfoundation.org>
References: <20200619141649.878808811@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>

[ Upstream commit d863cb03fb2aac07f017b2a1d923cdbc35021280 ]

sdhci-msm can support auto cmd12.
So enable SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 quirk.

Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/1587363626-20413-3-git-send-email-vbadigan@codeaurora.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-msm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 8b2a6a362c60..84cffdef264b 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1742,7 +1742,9 @@ static const struct sdhci_ops sdhci_msm_ops = {
 static const struct sdhci_pltfm_data sdhci_msm_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
 		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
-		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
+		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
+
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 	.ops = &sdhci_msm_ops,
 };
-- 
2.25.1



