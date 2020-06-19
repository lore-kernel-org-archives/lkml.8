Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCD4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4102F218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580463;
	bh=visR2GzS82Czu+PdROK70BFR08p8B1g7m9a3U/pQoW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GRlP/kj20UEsa9JaUcA1gTOeiT2CvNurBHwJznCV/fBoMLawfgst/aoj06uKRHQU6
	 XPgjjwh/HfukAuhMioMCjgCBJiUw4y5cKVO1StH4xKl5ofPT+35uJ3FwdQI/Le0mAm
	 zjiBhZphXvY2pZFPNDAghch87q9gvmG0E9X5RWTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393587AbgFSP1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:27:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404297AbgFSP0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:26:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 674D121556;
        Fri, 19 Jun 2020 15:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580384;
        bh=visR2GzS82Czu+PdROK70BFR08p8B1g7m9a3U/pQoW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=14suN9QFb95044e0IC+tK5ZCZzdr7gTbAJ8ISOPVZhucKW25nb+Hz/5OOOyDDU7hn
         IMyhEuE/FDFlHO2hYKEK2g8EEkvkExS7q/RdTqc0vra/ZyBZsok0wxFEzBVYEiEJTT
         Tv238yoUJ68TyQ+4fg7INdtWcs5nZr5VDGRF9zRY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 229/376] mmc: sdhci-msm: Set SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 quirk
Date:   Fri, 19 Jun 2020 16:32:27 +0200
Message-Id: <20200619141721.161229517@linuxfoundation.org>
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
index 87de46b6ed07..9ec733403027 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1888,7 +1888,9 @@ static const struct sdhci_ops sdhci_msm_ops = {
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



