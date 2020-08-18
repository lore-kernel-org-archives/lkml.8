Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC42C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852EC20829
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597769706;
	bh=3vbm55O2sXgcIvXGhZRQabLgIImj+oFTn5mSUu/7Agw=;
	h=Date:From:To:In-Reply-To:References:Subject:List-ID:From;
	b=VFe1+1O0RNKsDUS+r7dzWKOopUJ/ea7bLYVgu3Zt3VgJX/ttYD2X3ogmQnQFNA7hu
	 YdUwnXThcngby86RuGqxWmh5kISfumPmhLAqlnlEb/+C48glLuji02/dhtIHfrYPRi
	 WiXU5wLNWKna1prYG65lhqr7pLVcZUIJHZgbze9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgHRQzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:35432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbgHRQyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:54:35 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6523207D3;
        Tue, 18 Aug 2020 16:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597769675;
        bh=3vbm55O2sXgcIvXGhZRQabLgIImj+oFTn5mSUu/7Agw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Hd8yj2Z4AZnjkkZfNcW76gJD1StQ0Hd498Lrh2p0s3HytUpyS9vBhtC0Hkx1oj+KM
         IOhlAnOWEf0qRJZ5I5H9B/xQOTLqe7baPNC2DDKpqx0Cxc5f3lEm/D63e6/yzYs8Vx
         wnW+amRKnMUbil8RaF824efxXqqyaLSdP05mlc2o=
Date:   Tue, 18 Aug 2020 17:54:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     festevam@gmail.com, Xiubo.Lee@gmail.com, tiwai@suse.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>, timur@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        nicoleotsuka@gmail.com, linuxppc-dev@lists.ozlabs.org,
        alsa-devel@alsa-project.org, perex@perex.cz
In-Reply-To: <1597047103-6863-1-git-send-email-shengjiu.wang@nxp.com>
References: <1597047103-6863-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: fsl-asoc-card: Get "extal" clock rate by clk_get_rate
Message-Id: <159776961931.56094.3057738370364224756.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Aug 2020 16:11:43 +0800, Shengjiu Wang wrote:
> On some platform(.e.g. i.MX8QM MEK), the "extal" clock is different
> with the mclk of codec, then the clock rate is also different.
> So it is better to get clock rate of "extal" rate by clk_get_rate,
> don't reuse the clock rate of mclk.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl-asoc-card: Get "extal" clock rate by clk_get_rate
      commit: a8fd5ca8016948a611bff62b0990ade9e1f8e83c

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
