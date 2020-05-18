Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D7FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0D6D20715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825551;
	bh=lVcD8Iglm5L3dUlMBoeQCYLzsmbVnShCoMIN3gjOd98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hpSPxQVlEukfPJT+hPJ3p09qw/KdUPMKNYEvw26lsYLBHpvev9wPni9UO+Tu0q2Pq
	 dBd7y6l9zZ/9UpQGwCwAY+nvaGIZa7pUlx9AdX9MgRJy6ICJT/aC6CT722lXatT2+M
	 TUEICuIkrGWh4htaqpjy8k3S5DeoRDmfW5janj8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbgERSDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:03:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732636AbgERSDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:03:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D93A2207F5;
        Mon, 18 May 2020 18:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824998;
        bh=lVcD8Iglm5L3dUlMBoeQCYLzsmbVnShCoMIN3gjOd98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=elUqaXpWf1IdypHceBIspo+L+fUJLKmrHh+GOHnj9TN5sFswNbd6X7jCF3WSjna3W
         TPRlT2SdOCnDDFZv6w2+NbvhyHR/waLoP3IqT/hUpR53JoIThG8wsA5yahKyVtIclY
         9rm6UiJ3oR+JgGo7wa0NKx7gcJ/rU2GmligDi+Kg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 089/194] mmc: alcor: Fix a resource leak in the error path for ->probe()
Date:   Mon, 18 May 2020 19:36:19 +0200
Message-Id: <20200518173539.059404611@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
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



