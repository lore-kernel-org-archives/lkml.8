Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005B4C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C669A222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579018164;
	bh=faTRHh+bcvRrhOjGBJd7xe1b1/kzt+dXal4VH2s7aSw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=gqxT0QCYlrrEL4j/rpO5/FhMh86j82Igys2Qi39ataWDGj1zer4YOUBSE9A3Fn+1f
	 GZ++lmGxt+KAEN7NJwYugLx4sVXKODtFfY4nQS0U2qEsG6kWg9TKs4hHfKapac6M5Q
	 eS6sK1jE7yzsferifsIoVhVRNBwuNTuFYMyQegjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgANQJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 11:09:24 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37410 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgANQJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Pq8REMESzpH6q41kFJ7Xdz/mnGbbiWifWQ5pOJY+B+Q=; b=OHnhLjdjRfDE
        kHG9H27H5hJUUcJEp0KyT9sVJyzX6cjHyOJWj4gQGxmIj4whuU4H4uDSeymP86e03vIWog6BZzEaU
        JgmQDDltYrFCLUFhX3chRHWM2fDzk+uSgUkfTIDNTxDCD3qz5p1m6f5NVvHJURx4hjjC3/Kh0W5Kf
        on50A=;
Received: from fw-tnat-cam7.arm.com ([217.140.106.55] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1irOkb-0001Ul-Ic; Tue, 14 Jan 2020 16:09:05 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 40A1AD02C7B; Tue, 14 Jan 2020 16:09:05 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, nicoleotsuka@gmail.com, perex@perex.cz,
        robh+dt@kernel.org, Rob Herring <robh@kernel.org>,
        timur@kernel.org, tiwai@suse.com, Xiubo.Lee@gmail.com
Subject: Applied "ASoC: dt-bindings: fsl_asrc: add compatible string for imx8qm & imx8qxp" to the asoc tree
In-Reply-To: <b9352edb014c1ee8530c0fd8829c2b044b3da649.1575452454.git.shengjiu.wang@nxp.com>
Message-Id: <applied-b9352edb014c1ee8530c0fd8829c2b044b3da649.1575452454.git.shengjiu.wang@nxp.com>
X-Patchwork-Hint: ignore
Date:   Tue, 14 Jan 2020 16:09:05 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: dt-bindings: fsl_asrc: add compatible string for imx8qm & imx8qxp

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.6

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

From 8441f87eadf6d6bba542e7a5bf3888595248d888 Mon Sep 17 00:00:00 2001
From: Shengjiu Wang <shengjiu.wang@nxp.com>
Date: Wed, 4 Dec 2019 20:00:18 +0800
Subject: [PATCH] ASoC: dt-bindings: fsl_asrc: add compatible string for imx8qm
 & imx8qxp

Add compatible string "fsl,imx8qm-asrc" for imx8qm platform,
"fsl,imx8qxp-asrc" for imx8qxp platform.

There are two asrc modules in imx8qm & imx8qxp, the clock mapping is
different for each other, so add new property "fsl,asrc-clk-map"
to distinguish them.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/b9352edb014c1ee8530c0fd8829c2b044b3da649.1575452454.git.shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/fsl,asrc.txt | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
index 1d4d9f938689..cb9a25165503 100644
--- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
@@ -8,7 +8,12 @@ three substreams within totally 10 channels.
 
 Required properties:
 
-  - compatible		: Contains "fsl,imx35-asrc" or "fsl,imx53-asrc".
+  - compatible		: Compatible list, should contain one of the following
+			  compatibles:
+			  "fsl,imx35-asrc",
+			  "fsl,imx53-asrc",
+			  "fsl,imx8qm-asrc",
+			  "fsl,imx8qxp-asrc",
 
   - reg			: Offset and length of the register set for the device.
 
@@ -35,6 +40,11 @@ Required properties:
 
    - fsl,asrc-width	: Defines a mutual sample width used by DPCM Back Ends.
 
+   - fsl,asrc-clk-map   : Defines clock map used in driver. which is required
+			  by imx8qm/imx8qxp platform
+			  <0> - select the map for asrc0 in imx8qm/imx8qxp
+			  <1> - select the map for asrc1 in imx8qm/imx8qxp
+
 Optional properties:
 
    - big-endian		: If this property is absent, the little endian mode
-- 
2.20.1

