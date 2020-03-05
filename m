Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589A3C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A72220848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583419003;
	bh=MzDZD+FfIKQou6Nwtg8kdu9u+L3j+ISOEDIAbyK8Jyk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=JarOmgdKV/HPW/sqh01A6Fyl20Feos0nnoC0ZKp8eg3UEcL9pOWlm16ifXhYtdMgg
	 2/stFxPbPAtPkiE7vVARiTBUP6napBXpfm0u9a2h1rOUMHCK1y2xKAA/X/jOzv+zEz
	 WaAtLKx5ZpPztg2yhpPcALPeb/QluhBZ1wbtpox0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCEOgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 09:36:41 -0500
Received: from foss.arm.com ([217.140.110.172]:49180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbgCEOgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 09:36:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB6DD4B2;
        Thu,  5 Mar 2020 06:36:39 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D5073F534;
        Thu,  5 Mar 2020 06:36:39 -0800 (PST)
Date:   Thu, 05 Mar 2020 14:36:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     broonie@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, robh+dt@kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Applied "dt-bindings: spi: spi-rockchip: add description for rk3328" to the spi tree
In-Reply-To:  <20200304184203.9548-3-jbx6244@gmail.com>
Message-Id:  <applied-20200304184203.9548-3-jbx6244@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: spi: spi-rockchip: add description for rk3328

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

From 6ac12131699b4ec1d8f339e40528bdd474542075 Mon Sep 17 00:00:00 2001
From: Johan Jonker <jbx6244@gmail.com>
Date: Wed, 4 Mar 2020 19:42:03 +0100
Subject: [PATCH] dt-bindings: spi: spi-rockchip: add description for rk3328

The description below is already in use for rk3328.dtsi,
but was somehow never added to a document, so add
"rockchip,rk3328-spi", "rockchip,rk3066-spi"
for spi nodes on a rk3328 platform to spi-rockchip.yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20200304184203.9548-3-jbx6244@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
index 456896e2d514..81ad4b761502 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
@@ -30,6 +30,7 @@ properties:
             - rockchip,rk3188-spi
             - rockchip,rk3288-spi
             - rockchip,rk3308-spi
+            - rockchip,rk3328-spi
             - rockchip,rk3368-spi
             - rockchip,rk3399-spi
           - const: rockchip,rk3066-spi
-- 
2.20.1

