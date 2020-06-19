Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC26C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1243E20DD4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592577506;
	bh=jJAuHfsEWXZKFASwgw4Xo+bzhzlKTDQqmMhdwufUCYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OflB081AdqpqHyr+0ku4HmOWExGpkKrVn9IyuwAIsJVB3NGhE4gqWffosj0jGDEC8
	 OZ+xLgkjlOlp+knPFQ08m8fefnLQC7Q7i6zHNLCoZhMZjU5WCQkoeWxZzkqOyqc3kh
	 bQRwZwnSpNy5NOnBFrc+nL2vUOPSP6E3svc3W1Ho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387518AbgFSOiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:38:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733291AbgFSOiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:38:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EA2820CC7;
        Fri, 19 Jun 2020 14:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577488;
        bh=jJAuHfsEWXZKFASwgw4Xo+bzhzlKTDQqmMhdwufUCYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IIghxc5eM0y1e9LKWf/HoEBVt4EkOl49skwXmUD1JWgYph+KONKdYEMpRVU6Wvc7k
         KV1ZhY00XTrYGI+TstYi/Y7DDj19j8O2y7HjMyXAGWUI8o7AwRvznHhsG0IqFwTdue
         QMUTPPXXjUF6cVA9S7spMkbozWGF7pcoknFi8EuE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 031/101] spi: bcm2835: Fix controller unregister order
Date:   Fri, 19 Jun 2020 16:32:20 +0200
Message-Id: <20200619141615.722934389@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141614.001544111@linuxfoundation.org>
References: <20200619141614.001544111@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>

[ Upstream commit 9dd277ff92d06f6aa95b39936ad83981d781f49b ]

The BCM2835 SPI driver uses devm_spi_register_controller() on bind.
As a consequence, on unbind, __device_release_driver() first invokes
bcm2835_spi_remove() before unregistering the SPI controller via
devres_release_all().

This order is incorrect:  bcm2835_spi_remove() tears down the DMA
channels and turns off the SPI controller, including its interrupts
and clock.  The SPI controller is thus no longer usable.

When the SPI controller is subsequently unregistered, it unbinds all
its slave devices.  If their drivers need to access the SPI bus,
e.g. to quiesce their interrupts, unbinding will fail.

As a rule, devm_spi_register_controller() must not be used if the
->remove() hook performs teardown steps which shall be performed
after unbinding of slaves.

Fix by using the non-devm variant spi_register_controller().  Note that
the struct spi_controller as well as the driver-private data are not
freed until after bcm2835_spi_remove() has finished, so accessing them
is safe.

Fixes: 247263dba208 ("spi: bcm2835: use devm_spi_register_master()")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v3.13+
Link: https://lore.kernel.org/r/2397dd70cdbe95e0bc4da2b9fca0f31cb94e5aed.1589557526.git.lukas@wunner.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-bcm2835.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 25daebd6f410..27680b336454 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -798,7 +798,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 		goto out_clk_disable;
 	}
 
-	err = devm_spi_register_master(&pdev->dev, master);
+	err = spi_register_master(master);
 	if (err) {
 		dev_err(&pdev->dev, "could not register SPI master: %d\n", err);
 		goto out_clk_disable;
@@ -818,6 +818,8 @@ static int bcm2835_spi_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
 
+	spi_unregister_master(master);
+
 	/* Clear FIFOs, and disable the HW block */
 	bcm2835_wr(bs, BCM2835_SPI_CS,
 		   BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX);
-- 
2.25.1



