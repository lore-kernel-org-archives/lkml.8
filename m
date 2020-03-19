Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BFCC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801A6206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584624099;
	bh=GgYsmtbAqbaM/v6kQegw9vNUHsEfuEm0vNWEM9YQB6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wanL2Wv0U2A1wMvbTPoCcGTbhjWp8X4a/vgAGHZMEQTGfLBkiVhVsCsI9irfSxufi
	 EeoG6UC8xPAaSiOH0WPOVBmyCLNZ4lWdkIFiwQGwsnKutBjTzY2mJxULPrOMaSWaj+
	 npNEyYJPu6Lwu8vCElOCsgsiK7CoPqU3x3or6rj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbgCSNVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:21:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730121AbgCSNVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:21:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EC8F206D7;
        Thu, 19 Mar 2020 13:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584624094;
        bh=GgYsmtbAqbaM/v6kQegw9vNUHsEfuEm0vNWEM9YQB6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HXoEUaLL5+MP1wf/Ym0zIlHOsTD3NWh2DvSey5aYdbciJHKabjYYfp+iAfytZkwyc
         AhkPJopRBcuHFnroEC7U9kG/S89COd0Apwr7NWQbg0oICG642DF8dWhAR0yxtqjvG5
         ccC8crsM180AF/n8S7zVSeVZAJgbXogyyqkJAHkA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Faiz Abbas <faiz_abbas@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 35/48] mmc: sdhci-omap: Fix Tuning procedure for temperatures < -20C
Date:   Thu, 19 Mar 2020 14:04:17 +0100
Message-Id: <20200319123913.982249573@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123902.941451241@linuxfoundation.org>
References: <20200319123902.941451241@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Faiz Abbas <faiz_abbas@ti.com>

[ Upstream commit feb40824d78eac5e48f56498dca941754dff33d7 ]

According to the App note[1] detailing the tuning algorithm, for
temperatures < -20C, the initial tuning value should be min(largest value
in LPW - 24, ceil(13/16 ratio of LPW)). The largest value in LPW is
(max_window + 4 * (max_len - 1)) and not (max_window + 4 * max_len) itself.
Fix this implementation.

[1] http://www.ti.com/lit/an/spraca9b/spraca9b.pdf

Fixes: 961de0a856e3 ("mmc: sdhci-omap: Workaround errata regarding SDR104/HS200 tuning failures (i929)")
Cc: stable@vger.kernel.org
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 833e13cabd2a8..05ade7a2dd243 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -387,7 +387,7 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	 * on temperature
 	 */
 	if (temperature < -20000)
-		phase_delay = min(max_window + 4 * max_len - 24,
+		phase_delay = min(max_window + 4 * (max_len - 1) - 24,
 				  max_window +
 				  DIV_ROUND_UP(13 * max_len, 16) * 4);
 	else if (temperature < 20000)
-- 
2.20.1



