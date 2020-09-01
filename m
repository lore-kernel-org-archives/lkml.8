Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E640C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE2B208CA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598971874;
	bh=ZXbib2oV5w0YlPIh/haYE+UDUt9otm2EZ8ObPawlcOA=;
	h=Date:From:To:In-Reply-To:References:Subject:List-ID:From;
	b=p4Sg/4w5rEMdv7LZO39C7ASoHY8OSv/rcDQIKMvJwISTLBvVnslGS8RIF1sN7vkXZ
	 /aUdeRazhBR1m3836ismvq+dkOLh9NBZiq+Q2gJpzfP5Xt/KrsYJQQRBUHsQqZS0L/
	 kABEdYePn/z71Ld8NVOCK0eCfRiXsg6MFg087aOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgIAOvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:51:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728506AbgIAOup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:50:45 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8501D206EB;
        Tue,  1 Sep 2020 14:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598971845;
        bh=ZXbib2oV5w0YlPIh/haYE+UDUt9otm2EZ8ObPawlcOA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=KZootyeLyjib4y1qrCcS/xBceUm4FEua8DQgAHaJjhfgX7+u4D16kmrSqqBLGSh3D
         bXvX0dlfHef/j/SyplsIQ7kz5odClVmMG4A4FO32MhAVMV93T4XPS4awe9d1XoK0E3
         xGl01/tUrNUkhhuiPc+dXN/6wxzxOnBRZAlkG43M=
Date:   Tue, 01 Sep 2020 15:50:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>,
        devicetree@vger.kernel.org
In-Reply-To: <20200830112633.6732-1-krzk@kernel.org>
References: <20200830112633.6732-1-krzk@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: sound: midas-audio: Correct parsing sound-dai phandles
Message-Id: <159897179515.47719.6003518135515395142.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Aug 2020 13:26:32 +0200, Krzysztof Kozlowski wrote:
> The "sound-dai" property has cells therefore phandle-array should be
> used, even if it is just one phandle.  This fixes dtbs_check warnings
> like:
> 
>   arch/arm/boot/dts/exynos4412-trats2.dt.yaml: sound: cpu:sound-dai:0:1: missing phandle tag in 0
>   arch/arm/boot/dts/exynos4412-trats2.dt.yaml: sound: cpu:sound-dai:0: [158, 0] is too long

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: midas-audio: Correct parsing sound-dai phandles
      commit: 3e7ba1c0432ef9a792b9c77d36f78037626303b0
[2/2] ASoC: odroid: Use unevaluatedProperties
      commit: a57307ca6b661e16f9435a25f376ac277c3de697

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
