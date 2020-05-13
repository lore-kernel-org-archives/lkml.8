Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA80C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 280F9205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 16:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589386415;
	bh=FZ1M3OZRM7jW9vqDsr/RzhwezaAUizYn3SALLQyOYSQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=hCf1KgMSG7tv6XGB4zeua9G1tGr448X0gockcGytgsXzzWaxz+Qpi0kuWH/fJtQwL
	 fgWuj1KnDomipdZBYE/gqIZBeGFoECBkOcfwm831sjm9CJ/BKKwzb4eERGaMAqCw8K
	 yO5jaAhix00E05vnqcmbk9WnHgqEMHsCm/hv0jjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389399AbgEMQNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 12:13:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730831AbgEMQNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 12:13:33 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42DA1204EC;
        Wed, 13 May 2020 16:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589386413;
        bh=FZ1M3OZRM7jW9vqDsr/RzhwezaAUizYn3SALLQyOYSQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=xntG21/I7Ay8cOTAJfy7iyCU1UqELUJvsfSS2XB/cjC05nvuQp0mSZAePVM3mXpnn
         C0bU+iTfDiyqtBqHpW1KYEMTH/lMw/KQmpUKqIKC7zK20xtlUeWigXFmt/WrpPNgQn
         9ndkSa4hVk/WU72qg9yg2lKthIPbRHIpPxypHSjc=
Date:   Wed, 13 May 2020 17:13:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        Dan Murphy <dmurphy@ti.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200513142807.11802-1-dmurphy@ti.com>
References: <20200513142807.11802-1-dmurphy@ti.com>
Subject: Re: [PATCH] ASoC: tlv320adcx140: Fix bias config values
Message-Id: <158938641090.28795.1473298461328605544.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 09:28:07 -0500, Dan Murphy wrote:
> The device tree binding declares the ti,mic-bias-source and the
> ti,vref-source properties as u32.  The code reads them as u8 which is
> incorrect.  Since the device tree binding indicates them as u32 the
> conde needs to be updated to read u32.
> 
> In addition the bias source needs to be shifted 4 bits to
> correctly write the register.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

Thanks!

[1/1] ASoC: tlv320adcx140: Fix bias config values
      commit: 0e36f32f6b6c4c86a6bf3d6f0940831691b0a3b0

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
