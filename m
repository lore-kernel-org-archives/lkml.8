Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F208BC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB55324955
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615821;
	bh=RxKI3HmtbFCU5whBuk1UGXWl7irueBTgvhGXEXqY8l4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z9rkQ4cK7Mi857pUbCg2d8x34x1fW3rFoCJXxQ0bGzSmNx68u0nJqQoivKD/nxU3y
	 jBDx7rgC7g5Pjnzv6YQI/Bsv19wePrW2hZ78JXLrw2pVkxGUKi3HA2UZyo/u+Zbzvq
	 5WFAfL2dFOnKe4ngvrGJn07e5ySDQ72Ca/nNVmlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732064AbgEDSKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:10:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731867AbgEDSFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:05:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 671E72073E;
        Mon,  4 May 2020 18:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615535;
        bh=RxKI3HmtbFCU5whBuk1UGXWl7irueBTgvhGXEXqY8l4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FzdSwzzlpq2pfABJ64QMmI9cMHLJcaUTowKAuyUsCD20AZ6GYw8KOWf/Qfg5pG0Nq
         dspHsSRLK106GeY0dJyuxyd4IT9zFZGzyU+kaWz0A6fpB+7IPLEEpye1PBqE1Quypb
         pIRdhKy/QKkleN2eHj7QaVOTMHmZ319/UlOXTtHw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.6 20/73] mmc: meson-mx-sdio: Set MMC_CAP_WAIT_WHILE_BUSY
Date:   Mon,  4 May 2020 19:57:23 +0200
Message-Id: <20200504165505.460694614@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165501.781878940@linuxfoundation.org>
References: <20200504165501.781878940@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

commit e53b868b3cf5beeaa2f851ec6740112bf4d6a8cb upstream.

The Meson SDIO controller uses the DAT0 lane for hardware busy
detection. Set MMC_CAP_WAIT_WHILE_BUSY accordingly. This fixes
the following error observed with Linux 5.7 (pre-rc-1):
  mmc1: Card stuck being busy! __mmc_poll_for_busy
  blk_update_request: I/O error, dev mmcblk1, sector 17111080 op
   0x3:(DISCARD) flags 0x0 phys_seg 1 prio class 0

Fixes: ed80a13bb4c4c9 ("mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8 and Meson8b SoCs")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200416183513.993763-2-martin.blumenstingl@googlemail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/meson-mx-sdio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -570,7 +570,7 @@ static int meson_mx_mmc_add_host(struct
 	mmc->f_max = clk_round_rate(host->cfg_div_clk,
 				    clk_get_rate(host->parent_clk));
 
-	mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
+	mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY;
 	mmc->ops = &meson_mx_mmc_ops;
 
 	ret = mmc_of_parse(mmc);


