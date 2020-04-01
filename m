Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B77C2BA18
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4611020658
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758911;
	bh=6B6gsOsroByCB4gAqU47ZGkVGZ7MK8jRlweiG6hb5Aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T7KBqkTEqgHErHPAihXbuhpltArdj2syy69gLbkJ8YkcLeMv8WUgyUhggQ2tOfVxw
	 JP+FUpGL9g2V/Y1rov2XnHJ4WFHghsenernQFTHXWXAgn4K5aD7vcwQlWahKzRVBp7
	 NqJUpjwDjGhtWTM5oNLzFrGSk3M7pC0w9Osbj5mk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388085AbgDAQfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:35:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387563AbgDAQfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:35:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65481206F8;
        Wed,  1 Apr 2020 16:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758907;
        bh=6B6gsOsroByCB4gAqU47ZGkVGZ7MK8jRlweiG6hb5Aw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lv8jQ1StV+KMYCdTGCx32onuSRSG5O8q4Wlc1bh+J61qJaqF2A+bccBOJQFnZDAlU
         BlDe9UHB2o2Z9VisDeVnAM7MMbl5vhL4rMAxS4PuvGlow9c/XTULS+zGh+AVbWiG06
         iR2tninU9fGeBw6b8+EmQxpNvbTyUBenFS2o/pnQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.9 019/102] mmc: sdhci-of-at91: fix cd-gpios for SAMA5D2
Date:   Wed,  1 Apr 2020 18:17:22 +0200
Message-Id: <20200401161536.146584536@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161530.451355388@linuxfoundation.org>
References: <20200401161530.451355388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

commit 53dd0a7cd65edc83b0c243d1c08377c8b876b2ee upstream.

SAMA5D2x doesn't drive CMD line if GPIO is used as CD line (at least
SAMA5D27 doesn't). Fix this by forcing card-detect in the module
if module-controlled CD is not used.

Fixed commit addresses the problem only for non-removable cards. This
amends it to also cover gpio-cd case.

Cc: stable@vger.kernel.org
Fixes: 7a1e3f143176 ("mmc: sdhci-of-at91: force card detect value for non removable devices")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/8d10950d9940468577daef4772b82a071b204716.1584290561.git.mirq-linux@rere.qmqm.pl
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-of-at91.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -126,7 +126,8 @@ static void sdhci_at91_reset(struct sdhc
 {
 	sdhci_reset(host, mask);
 
-	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
+	if ((host->mmc->caps & MMC_CAP_NONREMOVABLE)
+	    || mmc_gpio_get_cd(host->mmc) >= 0)
 		sdhci_at91_set_force_card_detect(host);
 }
 
@@ -354,8 +355,11 @@ static int sdhci_at91_probe(struct platf
 	 * detection procedure using the SDMCC_CD signal is bypassed.
 	 * This bit is reset when a software reset for all command is performed
 	 * so we need to implement our own reset function to set back this bit.
+	 *
+	 * WA: SAMA5D2 doesn't drive CMD if using CD GPIO line.
 	 */
-	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
+	if ((host->mmc->caps & MMC_CAP_NONREMOVABLE)
+	    || mmc_gpio_get_cd(host->mmc) >= 0)
 		sdhci_at91_set_force_card_detect(host);
 
 	pm_runtime_put_autosuspend(&pdev->dev);


