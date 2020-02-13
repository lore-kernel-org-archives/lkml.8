Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B187C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D90820873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581600755;
	bh=FSop/MJPA2CnwJmV2tVANpVmiTHpp/pkpUyb/F1khfs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=xOSKBVLQjZJwuTXtTK17h2/fSZ+DYri8k/5sce1Qs7z/g/76d3tOCLZ5zBmuvicxJ
	 vuLl+Y7HQ1Vp/S3IoW9OLT7UyEt6pV37ImwEd59Y4WFfd4QT1GH9aS1uGrRb1F0JRQ
	 yZ2Y1c5AXMFfLMRunviJ4dgmREF9LSBQLRvjctUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgBMNce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:32:34 -0500
Received: from foss.arm.com ([217.140.110.172]:46702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729588AbgBMNcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:32:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FEFC1FB;
        Thu, 13 Feb 2020 05:32:33 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14AE33F6CF;
        Thu, 13 Feb 2020 05:32:32 -0800 (PST)
Date:   Thu, 13 Feb 2020 13:32:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spidev_test: Check input_tx and input_file first after parse options" to the spi tree
In-Reply-To: <1581567368-8055-2-git-send-email-yangtiezhu@loongson.cn>
Message-Id: <applied-1581567368-8055-2-git-send-email-yangtiezhu@loongson.cn>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spidev_test: Check input_tx and input_file first after parse options

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.7

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

From 1f3c36328a487059beebd1f7be042e3b7abf7d34 Mon Sep 17 00:00:00 2001
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Thu, 13 Feb 2020 12:16:06 +0800
Subject: [PATCH] spi: spidev_test: Check input_tx and input_file first after
 parse options

It is better to check input_tx and input_file first after parse options.
Otherwise, it will do some useless operations when both -p and --input
are selected.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/1581567368-8055-2-git-send-email-yangtiezhu@loongson.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/spi/spidev_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 113b1e1d62ca..5866178cdcc9 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -404,6 +404,9 @@ int main(int argc, char *argv[])
 
 	parse_opts(argc, argv);
 
+	if (input_tx && input_file)
+		pabort("only one of -p and --input may be selected");
+
 	fd = open(device, O_RDWR);
 	if (fd < 0)
 		pabort("can't open device");
@@ -445,9 +448,6 @@ int main(int argc, char *argv[])
 	printf("bits per word: %d\n", bits);
 	printf("max speed: %d Hz (%d KHz)\n", speed, speed/1000);
 
-	if (input_tx && input_file)
-		pabort("only one of -p and --input may be selected");
-
 	if (input_tx)
 		transfer_escaped_string(fd, input_tx);
 	else if (input_file)
-- 
2.20.1

