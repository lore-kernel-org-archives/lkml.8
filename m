Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A7DC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF222468E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844735;
	bh=3aUHtr5VhDOf2LoeEAfUA4zom+D6IHvYST6XzR/+4/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b6iYgaKHZV/9rYgzipg/RU1Vl/QSubA/114UlxUZT8K6oCCXlPIuhrHA2798z1Nho
	 tvGrer+16qwWBmNiJOiCGrjEc/zhMO7qHRpkTStgUBOX+mXt7JiIwzl14eK3qtu9OF
	 MLjjjplvB36LpV4RYNQ5Kf/ve261VgW4w4POCQlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgCJMwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:52:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729005AbgCJMwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:52:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 245C420674;
        Tue, 10 Mar 2020 12:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844728;
        bh=3aUHtr5VhDOf2LoeEAfUA4zom+D6IHvYST6XzR/+4/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ijPcdLVMJG0ZobxjpfL4TQOpXmdox8thgFFjWDa0uHnQByqVMmQQgR0py691balDA
         UAZs2ErWTsfqqUaTkwK10Ee2ZJf0tUPPi5eQIIGqaR+HxGNBh21fOL0Lcxyz7Sc/yD
         MzbVt8v1zu37p2Pkxx8AaJeUcCehJOGz4lchLyyE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Simon Han <z.han@kunbus.com>,
        Lukas Wunner <lukas@wunner.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.4 096/168] spi: spidev: Fix CS polarity if GPIO descriptors are used
Date:   Tue, 10 Mar 2020 13:39:02 +0100
Message-Id: <20200310123645.084722622@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>

commit 138c9c32f090894614899eca15e0bb7279f59865 upstream.

Commit f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs")
amended of_spi_parse_dt() to always set SPI_CS_HIGH for SPI slaves whose
Chip Select is defined by a "cs-gpios" devicetree property.

This change broke userspace applications which issue an SPI_IOC_WR_MODE
ioctl() to an spidev:  Chip Select polarity will be incorrect unless the
application is changed to set SPI_CS_HIGH.  And once changed, it will be
incompatible with kernels not containing the commit.

Fix by setting SPI_CS_HIGH in spidev_ioctl() (under the same conditions
as in of_spi_parse_dt()).

Fixes: f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs")
Reported-by: Simon Han <z.han@kunbus.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/fca3ba7cdc930cd36854666ceac4fbcf01b89028.1582027457.git.lukas@wunner.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org # v5.1+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spidev.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -394,6 +394,7 @@ spidev_ioctl(struct file *filp, unsigned
 		else
 			retval = get_user(tmp, (u32 __user *)arg);
 		if (retval == 0) {
+			struct spi_controller *ctlr = spi->controller;
 			u32	save = spi->mode;
 
 			if (tmp & ~SPI_MODE_MASK) {
@@ -401,6 +402,10 @@ spidev_ioctl(struct file *filp, unsigned
 				break;
 			}
 
+			if (ctlr->use_gpio_descriptors && ctlr->cs_gpiods &&
+			    ctlr->cs_gpiods[spi->chip_select])
+				tmp |= SPI_CS_HIGH;
+
 			tmp |= spi->mode & ~SPI_MODE_MASK;
 			spi->mode = (u16)tmp;
 			retval = spi_setup(spi);


