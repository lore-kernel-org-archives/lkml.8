Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1FDC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4037E222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579018219;
	bh=A90sykEAk91mWH2786YAg/dnutUo+VuFQjegQ9OTRaU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=eNN2arPHVik+pSAYnxBXXMpRXUvZMiYRF7Uz0BckPoAL9CKfzyes+yQ46IhS+SpP1
	 KPPGoDzxwwn4g2rHVOXZOUk4Fa7OJOP+5rYvqKROyWmDbLdzGEtK/4/HX//UDe6VK8
	 39HVfWJJKzAcoi9KjpuncQykWEOlrfYqBjCP/94w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbgANQKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 11:10:17 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37512 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbgANQJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=dxOH+M7gS9ZRsnyVhrWwBGhTEmsCg5fPIzt8wRWSCxE=; b=lZRN/UqBLxez
        hGGE16rR/Gw/s7hU3TswScmUuMoPdjxsLDTLpt0IIFCK6zzHWgc7bD2kVwv3poREp4Tvf7jrHeguA
        mesaJXftv68PB2uJXvNv+zV6w2RTHn5K6Hgu0P4wpgiN7fBDgJ5M+obPXd84Bc8x5coHQ1EKhExoE
        YhguY=;
Received: from fw-tnat-cam7.arm.com ([217.140.106.55] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1irOkq-0001Yi-8B; Tue, 14 Jan 2020 16:09:20 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id E9452D02C7B; Tue, 14 Jan 2020 16:09:19 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mantas Pucka <mantas@8devices.com>,
        Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: vqmmc-ipq4019: Remove ipq4019_regulator_remove" to the regulator tree
In-Reply-To: <20200114065847.31667-1-axel.lin@ingics.com>
Message-Id: <applied-20200114065847.31667-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Date:   Tue, 14 Jan 2020 16:09:19 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: vqmmc-ipq4019: Remove ipq4019_regulator_remove

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

From d47e4f978f2a2c0ffce543e58d30a00d1f850727 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 14 Jan 2020 14:58:46 +0800
Subject: [PATCH] regulator: vqmmc-ipq4019: Remove ipq4019_regulator_remove

This driver is using devm_regulator_register() so no need to call
regulator_unregister() in ipq4019_regulator_remove().

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Link: https://lore.kernel.org/r/20200114065847.31667-1-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/vqmmc-ipq4019-regulator.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/regulator/vqmmc-ipq4019-regulator.c b/drivers/regulator/vqmmc-ipq4019-regulator.c
index dae16094d3a2..42a2368e9ef7 100644
--- a/drivers/regulator/vqmmc-ipq4019-regulator.c
+++ b/drivers/regulator/vqmmc-ipq4019-regulator.c
@@ -81,15 +81,6 @@ static int ipq4019_regulator_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ipq4019_regulator_remove(struct platform_device *pdev)
-{
-	struct regulator_dev *rdev = platform_get_drvdata(pdev);
-
-	regulator_unregister(rdev);
-
-	return 0;
-}
-
 static const struct of_device_id regulator_ipq4019_of_match[] = {
 	{ .compatible = "qcom,vqmmc-ipq4019-regulator", },
 	{},
@@ -97,7 +88,6 @@ static const struct of_device_id regulator_ipq4019_of_match[] = {
 
 static struct platform_driver ipq4019_regulator_driver = {
 	.probe = ipq4019_regulator_probe,
-	.remove = ipq4019_regulator_remove,
 	.driver = {
 		.name = "vqmmc-ipq4019-regulator",
 		.owner = THIS_MODULE,
-- 
2.20.1

