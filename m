Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F76C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCE7E22CB1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595262513;
	bh=PKJqW285Wyj9VDxoQk/MlK8bcvV3xkLNjAGN/bWGlpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rjM6Ixwep0G3ZxM2vaQy5iw5eIs4Bgi//BApkH3HfBSYlGOnBtySENLK3MXpIZ72e
	 +uU3QNHPwv5m1ENBjXw8eL5iGlgxaJTFNUZihy3KAbQhQNvM3eMkVpbIEFBcd8xda9
	 REoSx3gDOE5d3p5m8zyyGbuZ4uq+CwjdqXWccBw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732230AbgGTP71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732167AbgGTP7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:59:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DFC222CAF;
        Mon, 20 Jul 2020 15:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260755;
        bh=PKJqW285Wyj9VDxoQk/MlK8bcvV3xkLNjAGN/bWGlpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bWMJJGgtQMuG4OCAup9ii3EelFawAYX+akAnjE6PoLNfhooravtpGTs975br2rrtO
         /7o7Vo+A2KIZSl73SSgFY1LiuvfKhjyLu+5toAhlvOw+hqviCQQbQdRQ3k9TTWHIWk
         42boah6oX5xIn6IsX4O57CtmRe9c+ok+taUbAhjY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 084/215] mmc: sdhci: do not enable card detect interrupt for gpio cd type
Date:   Mon, 20 Jul 2020 17:36:06 +0200
Message-Id: <20200720152824.202443009@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

[ Upstream commit e65bb38824711559844ba932132f417bc5a355e2 ]

Except SDHCI_QUIRK_BROKEN_CARD_DETECTION and MMC_CAP_NONREMOVABLE,
we also do not need to handle controller native card detect interrupt
for gpio cd type.
If we wrong enabled the card detect interrupt for gpio case, it will
cause a lot of unexpected card detect interrupts during data transfer
which should not happen.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/1582100563-20555-2-git-send-email-haibo.chen@nxp.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 50514fedbc76f..136f9737713d8 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -152,7 +152,7 @@ static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
 	u32 present;
 
 	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) ||
-	    !mmc_card_is_removable(host->mmc))
+	    !mmc_card_is_removable(host->mmc) || mmc_can_gpio_cd(host->mmc))
 		return;
 
 	if (enable) {
-- 
2.25.1



