Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF23C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79BA32076D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586875649;
	bh=8l8qvAdkG3irVaNUvMR5e7sGi6NgrQ7nNnMN7lU+Ypw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=iCJ4SfZ0lt8f3Au+wb/8UjMtfJN4EzKlUKv1eoSfX/vxMoN716G6HgZAQFlHHrEQb
	 suCtK7aR3VyxOf7E41oTla9VeqcRHwuT+OvTc22KHM+yjefXvcylXdzcv6pu2Sv5Bm
	 dqwaugwdlyNpii72nET/LBuYajr0h6XyL8kF4HkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404902AbgDNOrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:47:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404752AbgDNOrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:47:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 726D820CC7;
        Tue, 14 Apr 2020 14:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586875636;
        bh=8l8qvAdkG3irVaNUvMR5e7sGi6NgrQ7nNnMN7lU+Ypw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=H5dFdqx6nIDqdZkcysqi+odJ4NkyCs6vNMSeVV+Gp6uXhKAvOresbwHMCiOV10NID
         X6vS2GogFkMfGhAVMdNlI6D6dS9ZCwIT5krpEM7YboD1DmfrH4Z/ph8xasLiKshilH
         A5c5Xi2LenPDrv/r9hHEOkbV/a9rcY5TFv3NUvRo=
Date:   Tue, 14 Apr 2020 15:47:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: tegra-wm8903: Document new nvidia, headset property" to the asoc tree
In-Reply-To:  <20200330204011.18465-2-digetx@gmail.com>
Message-Id:  <applied-20200330204011.18465-2-digetx@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tegra-wm8903: Document new nvidia, headset property

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 8240fe6c91b884b5f1f861a8c22721d6ea4c53c9 Mon Sep 17 00:00:00 2001
From: Dmitry Osipenko <digetx@gmail.com>
Date: Mon, 30 Mar 2020 23:40:10 +0300
Subject: [PATCH] ASoC: tegra-wm8903: Document new nvidia, headset property

Some devices have a 4-pin headset jack instead of 3-pin microphone jack.
The new boolean nvidia,headset property tells that the Mic Jack represents
the state of a headset microphone. This additional hardware description is
needed because microphone detection procedure differs in a case of a 4-pin
jack from a 3-pin jack.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Link: https://lore.kernel.org/r/20200330204011.18465-2-digetx@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
index a8f2b0c56c79..bbd581a8c5bc 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
@@ -29,6 +29,7 @@ Optional properties:
 - nvidia,hp-det-gpios : The GPIO that detect headphones are plugged in
 - nvidia,int-mic-en-gpios : The GPIO that enables the internal microphone
 - nvidia,ext-mic-en-gpios : The GPIO that enables the external microphone
+- nvidia,headset : The Mic Jack represents state of the headset microphone pin
 
 Example:
 
-- 
2.20.1

