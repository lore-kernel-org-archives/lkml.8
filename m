Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66542C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33BB7214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859639;
	bh=Q3mESUXUhBBdKU3NQ32ZC/6o2RFPDyned+9barBgp4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nyiwu5vogdTNtm9UQ1hKbeEnsj9skPmlXtMHZeufJu8a0JNYFHSgR29+ibvxQOxL8
	 p8Mn54SvGol1AwWZZQqctN3NMXHULqXlc33+tkI0ifvlE3ZF2rPgWicLpeRzYLDYOP
	 frmyxmxG7Etq9C0ZGEvxLttyQ6IzIYJ+Lj4ZKi5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388333AbgAXJx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:53:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:56826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730133AbgAXJx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:53:56 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38482214AF;
        Fri, 24 Jan 2020 09:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859635;
        bh=Q3mESUXUhBBdKU3NQ32ZC/6o2RFPDyned+9barBgp4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O83l7aT064PHYmlWfhKXb56FeWGgrJFs+ZDuGNaiGqfCltodk3OZujjMeyi4LtUDg
         TAnr4KMPvxpIBjf9smTMXPDoOCTrV5tmZsxoxIrsdSE6QjKI6PNiqAZgD3RQau1waH
         q72a6H58FLEfDmiFGDAwjasW1mbZzrGyizdWNe9I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 129/343] mmc: sdhci-brcmstb: handle mmc_of_parse() errors during probe
Date:   Fri, 24 Jan 2020 10:29:07 +0100
Message-Id: <20200124092936.940069625@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Wahren <stefan.wahren@i2se.com>

[ Upstream commit 1e20186e706da8446f9435f2924cd65ab1397e73 ]

We need to handle mmc_of_parse() errors during probe otherwise the
MMC driver could start without proper initialization (e.g. power sequence).

Fixes: 476bf3d62d5c ("mmc: sdhci-brcmstb: Add driver for Broadcom BRCMSTB SoCs")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-brcmstb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 552bddc5096ce..1cd10356fc14f 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -55,7 +55,9 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	}
 
 	sdhci_get_of_property(pdev);
-	mmc_of_parse(host->mmc);
+	res = mmc_of_parse(host->mmc);
+	if (res)
+		goto err;
 
 	/*
 	 * Supply the existing CAPS, but clear the UHS modes. This
-- 
2.20.1



