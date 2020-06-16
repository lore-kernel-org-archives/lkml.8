Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4918AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D19D20C56
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592321955;
	bh=yJiFaOZloGB2NSKpB3spvtmWAhuXPh/vE7PAJDTvQoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RD4oMnD0J4+WV145ZMbERDfphq7zXdlR/QbG86WwVdCZAv/crtjlDq5/m/w8iYLFn
	 MSnDePxihYhJnU/D6tMfe7e36LLpLUlx+k/6crb2GD/bJi0l9fX2BNQB/2Yn1IQ6gs
	 o9vFK/tH4Vb9kdfr7JWf/2OyBmJCQvNxuihO9zwk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbgFPPjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:39:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730792AbgFPPjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:39:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05652214DB;
        Tue, 16 Jun 2020 15:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592321943;
        bh=yJiFaOZloGB2NSKpB3spvtmWAhuXPh/vE7PAJDTvQoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VhF/tcrl0b7o//1PUgjmVfehQyfGVn4emMX9+ifDo6Pmlc+CVeEjQb9qGxg+YS7UG
         1q8/zcSv5Zz7alGuspgyLR/oPPLilFz9ljbnYnHc2FAx6v275pmnZww4x3OWgFFw4V
         ncp+yhAwSz6s8MirkJ1JPrO7jQTnJJDc87BAcPjU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.4 074/134] spi: bcm2835aux: Fix controller unregister order
Date:   Tue, 16 Jun 2020 17:34:18 +0200
Message-Id: <20200616153104.324625090@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153100.633279950@linuxfoundation.org>
References: <20200616153100.633279950@linuxfoundation.org>
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
@@ -569,7 +569,7 @@ static int bcm2835aux_spi_probe(struct p
 		goto out_clk_disable;
 	}
 
-	err = devm_spi_register_master(&pdev->dev, master);
+	err = spi_register_master(master);
 	if (err) {
 		dev_err(&pdev->dev, "could not register SPI master: %d\n", err);
 		goto out_clk_disable;
@@ -593,6 +593,8 @@ static int bcm2835aux_spi_remove(struct
 
 	bcm2835aux_debugfs_remove(bs);
 
+	spi_unregister_master(master);
+
 	bcm2835aux_spi_reset_hw(bs);
 
 	/* disable the HW block by releasing the clock */


