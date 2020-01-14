Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F52C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A48C222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579018166;
	bh=VRJMnUlsoIYQaKMaQAY/tcd6eEft1LLaHLXOyKEdGXE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=2iQoPBeMo626ISvOT987ITgJ1zXLE5g1nvZ4dyZgv3AHO2D9QXbGXlrkEPh8c8+Lk
	 yzQQCnGR9/qpUpIQePq2wvTJsat7puuPjWnaUOX20PN43hKm/aC8jTUF8yaJW3qMD9
	 6AaOIAH6JAu2hKAUdx1qshZav0BPvwRPNiQthcME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgANQJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 11:09:24 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37508 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbgANQJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=FtjWDnF1Kar+1LXTdsMn9cWyX+PRtDjdGAMpdHfwvE8=; b=jiEvTaqdwpuW
        W8ZkPAlaLTiEgNqB77n1RVV7SsDhjNmfDziA2hpK3fdwMzr11UdxaphfK+85J3WYToBOyQVvwh9Vo
        W5+aIuf3vhXASqQ9TYSM3ZyB2fEFwKmPwUoYeHZzGPNA6rDBYgQHqSSPkHo1MHgf6TU/iJXPGI5M4
        rzn80=;
Received: from fw-tnat-cam7.arm.com ([217.140.106.55] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1irOkq-0001Yd-40; Tue, 14 Jan 2020 16:09:20 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id C77ECD02C77; Tue, 14 Jan 2020 16:09:19 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mantas Pucka <mantas@8devices.com>,
        Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: vqmmc-ipq4019: Trivial clean up" to the regulator tree
In-Reply-To: <20200114065847.31667-2-axel.lin@ingics.com>
Message-Id: <applied-20200114065847.31667-2-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Date:   Tue, 14 Jan 2020 16:09:19 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: vqmmc-ipq4019: Trivial clean up

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.6

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

From f72c5835509109715a8d8f0d98fddef089b3a4d8 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 14 Jan 2020 14:58:47 +0800
Subject: [PATCH] regulator: vqmmc-ipq4019: Trivial clean up

A few trivial clean up:
* Make ipq4019_regulator_voltage_ops and vmmc_regulator const
* Make ipq4019_vmmcq_regmap_config static
* Use regulator_map_voltage_ascend

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Link: https://lore.kernel.org/r/20200114065847.31667-2-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/vqmmc-ipq4019-regulator.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/vqmmc-ipq4019-regulator.c b/drivers/regulator/vqmmc-ipq4019-regulator.c
index 42a2368e9ef7..685b585b39a1 100644
--- a/drivers/regulator/vqmmc-ipq4019-regulator.c
+++ b/drivers/regulator/vqmmc-ipq4019-regulator.c
@@ -18,13 +18,14 @@ static const unsigned int ipq4019_vmmc_voltages[] = {
 	1500000, 1800000, 2500000, 3000000,
 };
 
-static struct regulator_ops ipq4019_regulator_voltage_ops = {
+static const struct regulator_ops ipq4019_regulator_voltage_ops = {
 	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_ascend,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 };
 
-static struct regulator_desc vmmc_regulator = {
+static const struct regulator_desc vmmc_regulator = {
 	.name		= "vmmcq",
 	.ops		= &ipq4019_regulator_voltage_ops,
 	.type		= REGULATOR_VOLTAGE,
@@ -35,7 +36,7 @@ static struct regulator_desc vmmc_regulator = {
 	.vsel_mask	= 0x3,
 };
 
-const struct regmap_config ipq4019_vmmcq_regmap_config = {
+static const struct regmap_config ipq4019_vmmcq_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
 	.val_bits	= 32,
-- 
2.20.1

