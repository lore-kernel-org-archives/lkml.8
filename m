Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A27CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6AD1207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592323584;
	bh=sOxhzpmmDRjatJXqcSrLLVy74KxqIyRrFovwlWN37Lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mFA0kG2pXtIYLYlTkpKbBzPuNukE0q6VHTzkLbmhZm2qPY9Y7pNqYN6wIB77f6Hpa
	 wRa0pzjVIzDOChUErYl4NYRyT9/ByLq+Z4q3etrHP08bu0V2e4kETCXoWBHTy9ZpSB
	 ruxL+heUsvGqOBUjch3R9+P7uMoM9SWudYDEz7Bw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732518AbgFPQGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:06:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732360AbgFPPsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:48:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA41B20776;
        Tue, 16 Jun 2020 15:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322491;
        bh=sOxhzpmmDRjatJXqcSrLLVy74KxqIyRrFovwlWN37Lc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SxUnijn1Z4bKrSY3m2/sitFtLUrbZsgxLcYghTAbXBo98IXJY/iGcjS1ybZfmZu4I
         33cP5nBprKqM6dy5RlopDvWxwwlmucLTPgfBnsYT4x9yqM9wcvzcHq2AO+nzftBJ23
         M+SupOJMHWmFgvCR1UdKO55Fff3RSiMLPjui96+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.7 151/163] mmc: sdhci-of-at91: fix CALCR register being rewritten
Date:   Tue, 16 Jun 2020 17:35:25 +0200
Message-Id: <20200616153114.038248740@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.849127260@linuxfoundation.org>
References: <20200616153106.849127260@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

commit dbdea70f71d672c12bc4454e7c258a8f78194d74 upstream.

When enabling calibration at reset, the CALCR register was completely
rewritten. This may cause certain bits being deleted unintentedly.
Fix by issuing a read-modify-write operation.

Fixes: 727d836a375a ("mmc: sdhci-of-at91: add DT property to enable calibration on full reset")
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Link: https://lore.kernel.org/r/20200527105659.142560-1-eugen.hristev@microchip.com
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-of-at91.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -120,9 +120,12 @@ static void sdhci_at91_reset(struct sdhc
 	    || mmc_gpio_get_cd(host->mmc) >= 0)
 		sdhci_at91_set_force_card_detect(host);
 
-	if (priv->cal_always_on && (mask & SDHCI_RESET_ALL))
-		sdhci_writel(host, SDMMC_CALCR_ALWYSON | SDMMC_CALCR_EN,
+	if (priv->cal_always_on && (mask & SDHCI_RESET_ALL)) {
+		u32 calcr = sdhci_readl(host, SDMMC_CALCR);
+
+		sdhci_writel(host, calcr | SDMMC_CALCR_ALWYSON | SDMMC_CALCR_EN,
 			     SDMMC_CALCR);
+	}
 }
 
 static const struct sdhci_ops sdhci_at91_sama5d2_ops = {


