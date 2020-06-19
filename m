Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3583FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 163EF21582
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592577724;
	bh=2UXKeaoTY9tEemee8pXYlcGGA6ln79psZMK4HAdfhLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qV24Y//BjhRguAcwekGNLf1bdDkOd6xP6+/37Te2Z6IqRgFDK7loSNqlDyRfhXRvN
	 PXHThcy2lxESwh8rdQWK5OgM/kGcL473biip5JVLAQ2zPbmlHTVS7CFghmaH063S2Y
	 0x1GMdri5bsGUVHkjN4kHP+4cm19m1mCn69hZsoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388318AbgFSOmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:42:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387511AbgFSOly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:41:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF9AB21548;
        Fri, 19 Jun 2020 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577714;
        bh=2UXKeaoTY9tEemee8pXYlcGGA6ln79psZMK4HAdfhLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C99W6Q9a0q3DkmtZZ1euNwM0Ry1PhTPg0viSBWQnfZeQh53BLgvXheEuqFYgtUG1h
         fX2aE5jZupcBAf0One28hgiqGfpWGhGbLAPPt6cB/cMPkw7OVho3UvTfZyakvEF1Wz
         QnEOSsNyP1KXfKvy3Y5V4DnjKGkfmKh1xHKcupoY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 029/128] spi: dw: fix possible race condition
Date:   Fri, 19 Jun 2020 16:32:03 +0200
Message-Id: <20200619141621.706156204@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141620.148019466@linuxfoundation.org>
References: <20200619141620.148019466@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 66b19d762378785d1568b5650935205edfeb0503 ]

It is possible to get an interrupt as soon as it is requested.  dw_spi_irq
does spi_controller_get_devdata(master) and expects it to be different than
NULL. However, spi_controller_set_devdata() is called after request_irq(),
resulting in the following crash:

CPU 0 Unable to handle kernel paging request at virtual address 00000030, epc == 8058e09c, ra == 8018ff90
[...]
Call Trace:
[<8058e09c>] dw_spi_irq+0x8/0x64
[<8018ff90>] __handle_irq_event_percpu+0x70/0x1d4
[<80190128>] handle_irq_event_percpu+0x34/0x8c
[<801901c4>] handle_irq_event+0x44/0x80
[<801951a8>] handle_level_irq+0xdc/0x194
[<8018f580>] generic_handle_irq+0x38/0x50
[<804c6924>] ocelot_irq_handler+0x104/0x1c0

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-dw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index babf0a337e96..be3ab4006313 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -500,6 +500,8 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	snprintf(dws->name, sizeof(dws->name), "dw_spi%d", dws->bus_num);
 	spin_lock_init(&dws->buf_lock);
 
+	spi_master_set_devdata(master, dws);
+
 	ret = request_irq(dws->irq, dw_spi_irq, IRQF_SHARED, dws->name, master);
 	if (ret < 0) {
 		dev_err(dev, "can not get IRQ\n");
@@ -531,7 +533,6 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 		}
 	}
 
-	spi_master_set_devdata(master, dws);
 	ret = devm_spi_register_master(dev, master);
 	if (ret) {
 		dev_err(&master->dev, "problem registering spi master\n");
-- 
2.25.1



