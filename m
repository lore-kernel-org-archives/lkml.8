Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4AAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79171207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595535639;
	bh=8vVstHmelPurjB9fC/bKrROk2yVRiPsYnXDY9xWfxhw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=Kvdxa7QrFeAQ0dCyRYxourbfJe5w0td4w18J6W6Ux0Z7h2V8qT6ZTaK9KyZECqpYj
	 1ahIk41GuDqN9QgvpCAspBX7HmfLF1SmXNg709AkH9FraOvJUvCtcI+AaGLyQSr1EJ
	 sEilbQMXLz8SRb4u9IFFcwIaoHxDDD7+1fMuOhFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgGWUUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:20:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbgGWUUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:20:37 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B02CA22B47;
        Thu, 23 Jul 2020 20:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595535637;
        bh=8vVstHmelPurjB9fC/bKrROk2yVRiPsYnXDY9xWfxhw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=sczQ0KmG4tQUiep6/dyLHAfEuOKcO5yhRWt5UEqCpDLCjG3cSA+XUOEtbQDUetv/Y
         bQFrxThzdieUyKQNkww4fdKh8pfoHmID7LSMIyCppJ6ZDX0S2IWVMOpBt9ETNnIKz7
         J+8RPoXDPgAv1rrqnyQR4d4CXaxuzEb6SWgktypg=
Date:   Thu, 23 Jul 2020 21:20:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, rdunlap@infradead.org,
        Sameer Pujar <spujar@nvidia.com>, geert@linux-m68k.org,
        tiwai@suse.com, lgirdwood@gmail.com
Cc:     jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        thierry.reding@gmail.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
In-Reply-To: <1595492011-2411-1-git-send-email-spujar@nvidia.com>
References: <1595492011-2411-1-git-send-email-spujar@nvidia.com>
Subject: Re: [PATCH] ASoC: tegra: Fix build error due to 64-by-32 division
Message-Id: <159553557414.41908.1715197837491457325.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 13:43:31 +0530, Sameer Pujar wrote:
> Build errors are seen on 32-bit platforms because of a plain 64-by-32
> division. For example, following build erros were reported.
> 
> "ERROR: modpost: "__udivdi3" [sound/soc/tegra/snd-soc-tegra210-dmic.ko]
>  undefined!"
> "ERROR: modpost: "__divdi3" [sound/soc/tegra/snd-soc-tegra210-dmic.ko]
>  undefined!"
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tegra: Fix build error due to 64-by-32 division
      commit: f9ec176cd684c83a60638123da0b34c7c82f0c74

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
