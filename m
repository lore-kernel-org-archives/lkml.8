Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724B0C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 17:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49E0E20737
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 17:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586885834;
	bh=72L8S1GjdTxgw7kJVxtKt/iggP0JTDEJsnMcmKTyy2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=Hx0ETa/Oz9d0Wt8omplVzysgZ/9A4vIcV4W1WMcmGh7Oq329nXVGjX1YAf7eYOXCy
	 batsPo7OiFBdgbUnaaQcEMJy0uABWedX6eavXSnTYiAek4nxl+nZNDciBWWXRg4W15
	 IVSrkCewJnwMchwgBpBem8MhSIb9ox9KMY6KPG9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440341AbgDNRhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 13:37:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437002AbgDNRhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 13:37:01 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBBA820737;
        Tue, 14 Apr 2020 17:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586885820;
        bh=72L8S1GjdTxgw7kJVxtKt/iggP0JTDEJsnMcmKTyy2Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Vn5/Kk73w6DJbDFj71d1HJFHa+0CCRnATxdjwV9b/D1GbxFdGZ/FFZqolXVMfS8lL
         PpIJceeEQnR7d7d2rmbVY6C28YQNCE+BHydf2j4LKt/ugFEDtfkXawGREii/Bvrbvp
         8xqkbvmFmOVLcY6Az4jOvThQK2KIA14faPHlkWVo=
Date:   Tue, 14 Apr 2020 18:36:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "spi: remove redundant assignment to variable ms" to the spi tree
In-Reply-To:  <20200410122315.17523-1-colin.king@canonical.com>
Message-Id:  <applied-20200410122315.17523-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: remove redundant assignment to variable ms

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

From 49686df5b874e5ed6249bc622b73ad9a9e71cd99 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 10 Apr 2020 13:23:15 +0100
Subject: [PATCH] spi: remove redundant assignment to variable ms

The variable ms is being initialized with a value that is never read
and it is being updated later with a new value.  The initialization is
redundant and can be removed.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Addresses-Coverity: ("Unused value")
Link: https://lore.kernel.org/r/20200410122315.17523-1-colin.king@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c92c89467e7e..5446b07dcd3a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1075,7 +1075,7 @@ static int spi_transfer_wait(struct spi_controller *ctlr,
 {
 	struct spi_statistics *statm = &ctlr->statistics;
 	struct spi_statistics *stats = &msg->spi->statistics;
-	unsigned long long ms = 1;
+	unsigned long long ms;
 
 	if (spi_controller_is_slave(ctlr)) {
 		if (wait_for_completion_interruptible(&ctlr->xfer_completion)) {
-- 
2.20.1

