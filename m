Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A78C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8308E207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580222862;
	bh=5/K6SHCog96gytpaRzoA5Md8TPdzdJG0oCOM+mKE9O0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zNT73bZ3zGgZ01UbtYApNDVFoRHLSshFKdKJkk5+n74mLlGgY3PKw6M0vM66+XAT8
	 nkURWjfLQXD3+PJNCyZ5EYK9TnpnyVuFzpurotFNhI7YQjAChpGZgIhFrCqox4xK59
	 yoWzhA+EgIBz12aK+2L7hqPDyR1c5JI8gMpDZ5pI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgA1Orl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:47:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:50128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727105AbgA1ODY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:03:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1CBF2468E;
        Tue, 28 Jan 2020 14:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220204;
        bh=5/K6SHCog96gytpaRzoA5Md8TPdzdJG0oCOM+mKE9O0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mEXY+AZ8sTPJfXg2p3pyVNtvTwdDaEtrkt6BJsO3sdpWnW2Pqa942RyGoDc08BL0J
         Nsd5baRh6GndRBWzDuupUJOoJUo43L5bzcC70gb56tD+X9ycezsbq/pvSSeP1hxE0y
         ZcHzyUuewGyuQz8G9OJIH+M8tQKiVYL4aaXDVOuo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Thierry Reding <treding@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.4 058/104] mmc: tegra: fix SDR50 tuning override
Date:   Tue, 28 Jan 2020 15:00:19 +0100
Message-Id: <20200128135825.632206424@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135817.238524998@linuxfoundation.org>
References: <20200128135817.238524998@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

commit f571389c0b015e76f91c697c4c1700aba860d34f upstream.

Commit 7ad2ed1dfcbe inadvertently mixed up a quirk flag's name and
broke SDR50 tuning override. Use correct NVQUIRK_ name.

Fixes: 7ad2ed1dfcbe ("mmc: tegra: enable UHS-I modes")
Cc: <stable@vger.kernel.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Tested-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Link: https://lore.kernel.org/r/9aff1d859935e59edd81e4939e40d6c55e0b55f6.1578390388.git.mirq-linux@rere.qmqm.pl
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-tegra.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -386,7 +386,7 @@ static void tegra_sdhci_reset(struct sdh
 			misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_DDR50;
 		if (soc_data->nvquirks & NVQUIRK_ENABLE_SDR104)
 			misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDR104;
-		if (soc_data->nvquirks & SDHCI_MISC_CTRL_ENABLE_SDR50)
+		if (soc_data->nvquirks & NVQUIRK_ENABLE_SDR50)
 			clk_ctrl |= SDHCI_CLOCK_CTRL_SDR50_TUNING_OVERRIDE;
 	}
 


