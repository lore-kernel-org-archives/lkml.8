Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736FFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 480A72067D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592584715;
	bh=4GDj40YMC236QJ/h4DC1Ce/InFlHhNvYDg8ll0+BQsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fXCOYvWr1ZkLzRcH/8OebJXcOn62KJWyw2JEIUAjEHiI6cngQLjABNMTtFdcO3q2M
	 yJnrEdiCF1q21gPkCMgqryIl5vWuI9KxcWkZHgPuRVMPYD+5/4mYvTWPvg0qKlL69/
	 5Z4K01jz34f6GJXnjbrGKoI58/qIDuNO28ZQJVYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395354AbgFSQid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:38:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388331AbgFSOra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:47:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C93AA2083B;
        Fri, 19 Jun 2020 14:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578050;
        bh=4GDj40YMC236QJ/h4DC1Ce/InFlHhNvYDg8ll0+BQsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tLTdHu87fGE63y+TByck4MnukWtj4tyd2ZsRolaBiQbKOKIYhNINUQPWBnjBs5pxl
         d4rTQHkrlshWXlQ34vVXpqLD0CcMbh0NBhIsXv5BQwTdQN5ts2dOQin+9JNpGToUjE
         lbZiR8duDN5rpHVjxqRbkubl7WmXR4+JV2RGDet0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 032/190] spi: bcm2835aux: Fix controller unregister order
Date:   Fri, 19 Jun 2020 16:31:17 +0200
Message-Id: <20200619141635.147091478@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141633.446429600@linuxfoundation.org>
References: <20200619141633.446429600@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>

commit b9dd3f6d417258ad0beeb292a1bc74200149f15d upstream.

The BCM2835aux SPI driver uses devm_spi_register_master() on bind.
As a consequence, on unbind, __device_release_driver() first invokes
bcm2835aux_spi_remove() before unregistering the SPI controller via
devres_release_all().

This order is incorrect:  bcm2835aux_spi_remove() turns off the SPI
controller, including its interrupts and clock.  The SPI controller
is thus no longer usable.

When the SPI controller is subsequently unregistered, it unbinds all
its slave devices.  If their drivers need to access the SPI bus,
e.g. to quiesce their interrupts, unbinding will fail.

As a rule, devm_spi_register_master() must not be used if the
->remove() hook performs teardown steps which shall be performed
after unbinding of slaves.

Fix by using the non-devm variant spi_register_master().  Note that the
struct spi_master as well as the driver-private data are not freed until
after bcm2835aux_spi_remove() has finished, so accessing them is safe.

Fixes: 1ea29b39f4c8 ("spi: bcm2835aux: add bcm2835 auxiliary spi device driver")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v4.4+
Cc: Martin Sperl <kernel@martin.sperl.org>
Link: https://lore.kernel.org/r/32f27f4d8242e4d75f9a53f7e8f1f77483b08669.1589557526.git.lukas@wunner.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-bcm2835aux.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -485,7 +485,7 @@ static int bcm2835aux_spi_probe(struct p
 		goto out_clk_disable;
 	}
 
-	err = devm_spi_register_master(&pdev->dev, master);
+	err = spi_register_master(master);
 	if (err) {
 		dev_err(&pdev->dev, "could not register SPI master: %d\n", err);
 		goto out_clk_disable;
@@ -505,6 +505,8 @@ static int bcm2835aux_spi_remove(struct
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
 
+	spi_unregister_master(master);
+
 	bcm2835aux_spi_reset_hw(bs);
 
 	/* disable the HW block by releasing the clock */


