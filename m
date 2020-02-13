Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FF6C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2A020873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581600750;
	bh=uYQtn9T45Ehm6ODa2eqRXYkuG3We5IcAlEyqbTnrgR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=k1yLf+uBp3FiD4ET0CGBVhk2B8KOvldWcoMQmdYKM7B3NsiGhREbj1GZW9D25rcml
	 O2jvPHMPuR3IujFyOvquRLTexLz0qXvwcgXxfofBdNVPNFbXWgH0DanI23gmCLH86T
	 hSbT8ecdRM+tNmQMZ/ixQLoC+a3NuvTA84HnVzQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbgBMNc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:32:29 -0500
Received: from foss.arm.com ([217.140.110.172]:46690 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729588AbgBMNc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:32:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCC391045;
        Thu, 13 Feb 2020 05:32:28 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6063D3F6CF;
        Thu, 13 Feb 2020 05:32:28 -0800 (PST)
Date:   Thu, 13 Feb 2020 13:32:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spidev_test: Remove the whole "include" directory when make clean" to the spi tree
In-Reply-To: <1581567368-8055-4-git-send-email-yangtiezhu@loongson.cn>
Message-Id: <applied-1581567368-8055-4-git-send-email-yangtiezhu@loongson.cn>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spidev_test: Remove the whole "include" directory when make clean

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

From aea7afd9079f2e43b05790241d748ff0537ec917 Mon Sep 17 00:00:00 2001
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Date: Thu, 13 Feb 2020 12:16:08 +0800
Subject: [PATCH] spi: spidev_test: Remove the whole "include" directory when
 make clean

In the current code, it only removes "include/linux/spi/spidev.h" file
when make clean and there still exists useless "include/linux/spi/"
directory, just remove it.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Link: https://lore.kernel.org/r/1581567368-8055-4-git-send-email-yangtiezhu@loongson.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/spi/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/spi/Makefile b/tools/spi/Makefile
index 5c342e655e55..2249a1546cc1 100644
--- a/tools/spi/Makefile
+++ b/tools/spi/Makefile
@@ -51,7 +51,7 @@ $(OUTPUT)spidev_fdx: $(SPIDEV_FDX_IN)
 
 clean:
 	rm -f $(ALL_PROGRAMS)
-	rm -f $(OUTPUT)include/linux/spi/spidev.h
+	rm -rf $(OUTPUT)include/
 	find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
 
 install: $(ALL_PROGRAMS)
-- 
2.20.1

