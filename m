Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678F6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35DCE20820
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591707286;
	bh=s6DjVd5S/9BMaBHFd1sXcmmcw3hwmnb2raoYKakwRWc=;
	h=Date:From:To:In-Reply-To:References:Subject:List-ID:From;
	b=aGiIS8/kUFRbqdMxK5wAcn85mogGYeDdcZWMDUWBDodpKjvJCHouMEAoFtd8EX5CH
	 xr7KHh2dZV3LCKuu/QmMPa1ANdFM12vPAq4jf94LhWAian/zy+p8CaxRt5wX4cNv7M
	 O54BKnGnKr1aT39Y95yB52S8tZy+OoZEyDZzWmC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgFIMyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 08:54:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728217AbgFIMyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 08:54:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAC30206A4;
        Tue,  9 Jun 2020 12:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591707283;
        bh=s6DjVd5S/9BMaBHFd1sXcmmcw3hwmnb2raoYKakwRWc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=dNl6PiKGvSYn9EtRbIRN37OwxVFkRJ6JigXpcIGgtBn7yFIifpMp+FpXxNWy81CP0
         q/TXS0BDniJk36Hp8ST9U0GWXZkSZUuyb3UreVw0rbKlh8iRijWZ4iAza/1s8Ryruk
         cIEQ4UReD6Qw6TSMUeS7Gr/2vEIR1iZUR3KQ+I40=
Date:   Tue, 09 Jun 2020 13:54:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, trivial@kernel.org, tiwai@suse.com,
        linux-amlogic@lists.infradead.org, lgirdwood@gmail.com,
        jbrunet@baylibre.com, perex@perex.cz, Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20200606153103.GA17905@amd>
References: <20200606153103.GA17905@amd>
Subject: Re: [PATCH] soc/meson: add missing free_irq() in error path
Message-Id: <159170728116.39758.7078171173608119495.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jun 2020 17:31:03 +0200, Pavel Machek wrote:
> free_irq() is missing in case of error, fix that.
> 
> Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>
> 
> diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
> index 2e9b56b29d31..b2e867113226 100644
> --- a/sound/soc/meson/axg-fifo.c
> +++ b/sound/soc/meson/axg-fifo.c
> @@ -249,7 +249,7 @@ int axg_fifo_pcm_open(struct snd_soc_component *component,
>  	/* Enable pclk to access registers and clock the fifo ip */
>  	ret = clk_prepare_enable(fifo->pclk);
>  	if (ret)
> -		return ret;
> +		goto free_irq;
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: add missing free_irq() in error path
      commit: 3b8a299a58b2afce464ae11324b59dcf0f1d10a7

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
