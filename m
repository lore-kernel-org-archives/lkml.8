Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EB4C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC5E20866
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 14:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583850670;
	bh=XMWV75O2Zkt4YBpOL4uDhU20tdFVtc+FahDUU7MWURQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=ztsqvR2mdDrrqjDrOVCYXFVOQV7ccNt8HDpRjLfMHVpl/8xd/1924qacsuVAGfp1K
	 QfwXf3buLq2U4gv8MxuNawTNGLn6Tzs39fKqqy6b/Gj3JA1t66n7HuZaiK3oA/hQrj
	 VbWbJrLrNXD34Qbg+QtNtoIM5IvNgwLk8cUQ5BhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgCJObK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 10:31:10 -0400
Received: from foss.arm.com ([217.140.110.172]:37794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbgCJObJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:31:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 778C830E;
        Tue, 10 Mar 2020 07:31:09 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E90CB3F6CF;
        Tue, 10 Mar 2020 07:31:08 -0700 (PDT)
Date:   Tue, 10 Mar 2020 14:31:07 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: update the structure documentation" to the spi tree
In-Reply-To:  <1583774179-30736-1-git-send-email-hqjagain@gmail.com>
Message-Id:  <applied-1583774179-30736-1-git-send-email-hqjagain@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: update the structure documentation

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 7a86a419ff62c69f91544ea95f4ae6ef83880dcc Mon Sep 17 00:00:00 2001
From: Qiujun Huang <hqjagain@gmail.com>
Date: Tue, 10 Mar 2020 01:16:19 +0800
Subject: [PATCH] spi: update the structure documentation

some members were not described in documentation.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Link: https://lore.kernel.org/r/1583774179-30736-1-git-send-email-hqjagain@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/spi/spi.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 87105272879b..38286de779e3 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -135,6 +135,8 @@ extern int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer);
  * @modalias: Name of the driver to use with this device, or an alias
  *	for that name.  This appears in the sysfs "modalias" attribute
  *	for driver coldplugging, and in uevents used for hotplugging
+ * @driver_override: If the name of a driver is written to this attribute, then
+ *	the device will bind to the named driver and only the named driver.
  * @cs_gpio: LEGACY: gpio number of the chipselect line (optional, -ENOENT when
  *	not using a GPIO line) use cs_gpiod in new drivers by opting in on
  *	the spi_master.
@@ -443,6 +445,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *	@spi_transfer->ptp_sts_word_post were transmitted.
  *	If the driver does not set this, the SPI core takes the snapshot as
  *	close to the driver hand-over as possible.
+ * @irq_flags: Interrupt enable state during PTP system timestamping
  *
  * Each SPI controller can communicate with one or more @spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
-- 
2.20.1

