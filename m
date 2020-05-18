Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE495C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C462920671
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825890;
	bh=lVcD8Iglm5L3dUlMBoeQCYLzsmbVnShCoMIN3gjOd98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p69pRGNpdkLMkKyVMSOb98SGAE7gTUFF6XmCWW4leobsN0V5QRjokIXTohYjVnRKG
	 Rx95K4ndHMFCOLn8pyezs3QL+DsJJ638FdmdiRKJ6MlqQu5K8ZVIydOm86xuMjL7Xu
	 FS64+xbOF9owgmLgbo2FXggqTFVxjWBTzRG2QPPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387714AbgERSSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:18:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731610AbgERR4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:56:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0044520826;
        Mon, 18 May 2020 17:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824577;
        bh=lVcD8Iglm5L3dUlMBoeQCYLzsmbVnShCoMIN3gjOd98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RdbK2iYSf66R+UNsN406tSwf+sJ8nYJ3Rp8hhS5Dt5POz9Gj5tz5GmqxSXeQk+JND
         tdNFN8MI5iCtYU6TEq2IS91/NwQ7ZRQLnDsaCMuai6Q7/N2O4M5YV87kRSP7oVs8Ko
         EN4qaJGfa8V7yEAA0E9wUnX+Zm2IYD2fadEx6DGI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 066/147] mmc: alcor: Fix a resource leak in the error path for ->probe()
Date:   Mon, 18 May 2020 19:36:29 +0200
Message-Id: <20200518173522.255300152@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173513.009514388@linuxfoundation.org>
References: <20200518173513.009514388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 7c277dd2b0ff6a16f1732a66c2c52a29f067163e ]

If devm_request_threaded_irq() fails, the allocated struct mmc_host needs
to be freed via calling mmc_free_host(), so let's do that.

Fixes: c5413ad815a6 ("mmc: add new Alcor Micro Cardreader SD/MMC driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/20200426202355.43055-1-christophe.jaillet@wanadoo.fr
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/alcor.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/alcor.c b/drivers/mmc/host/alcor.c
index 1aee485d56d4c..026ca9194ce5b 100644
--- a/drivers/mmc/host/alcor.c
+++ b/drivers/mmc/host/alcor.c
@@ -1104,7 +1104,7 @@ static int alcor_pci_sdmmc_drv_probe(struct platform_device *pdev)
 
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to get irq for data line\n");
-		return ret;
+		goto free_host;
 	}
 
 	mutex_init(&host->cmd_mutex);
@@ -1116,6 +1116,10 @@ static int alcor_pci_sdmmc_drv_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, host);
 	mmc_add_host(mmc);
 	return 0;
+
+free_host:
+	mmc_free_host(mmc);
+	return ret;
 }
 
 static int alcor_pci_sdmmc_drv_remove(struct platform_device *pdev)
-- 
2.20.1



