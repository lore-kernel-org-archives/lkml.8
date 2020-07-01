Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E03FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3013920853
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593642165;
	bh=cJ/E7eJozKmA8owHe5A5Mzv6L3LI8x9nRfUS77HPINA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=VPPgaFXfyveW5shy5jopeS2gaRXX57l7IV7Xw/TAwFZyhi8Xamst6c/EPI34GUo+m
	 Si/8lZmZo7uM9efpIDVc/f6GiYSZHKr+Zp4/3sU/aFO4CaO4W6Un0mIAVZKFKTF7Hc
	 dX8MvFlp5ae63LZHnDQsry54vemcoCi3Yg2HUz/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgGAWWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 18:22:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbgGAWWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 18:22:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77574207E8;
        Wed,  1 Jul 2020 22:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593642163;
        bh=cJ/E7eJozKmA8owHe5A5Mzv6L3LI8x9nRfUS77HPINA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=eoZetv183/MwvWt4g9XDdVjYYsLTKM3H+xWZ9H88Ciadikq8X5B7IjbZPxke7OytK
         0khhZ0pQ70pTNdYl1Wko3KkJCe4bG+XwA2DNLuFlfOs/+1Oa5euSv4F5l2qhUSjjCZ
         eYZ09tWNMNXg6H1ACS8jpDmejaNm2KrM+ZcGDXSU=
Date:   Wed, 01 Jul 2020 23:22:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        robh+dt@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20200630125843.11561-1-peter.ujfalusi@ti.com>
References: <20200630125843.11561-1-peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 0/3] ASoC: ti: Add support for audio on J721e EVM
Message-Id: <159364215574.10630.2058528286314798186.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020 15:58:40 +0300, Peter Ujfalusi wrote:
> Changes since v3:
> - Fix the single clock source handling and typo
> 
> Changes since v2:
> - DT binding:
>  - use proper (?) patch subject for the binding docuemtn patch
>  - drop pll4 and pll15 from DT - driver should check the rate via
>    clk_get_parent. If it is not available (as it is not currently) then use the
>    match_data provided rates.
>  - add simple explanation for the clocking setup
>  - Use descriptive names for clocks: cpb/ivi-mcasp-auxclk and cpb/ivi-codec-scki
>  - dt_binding_check shows no errors/warnings
> - ASoC machine driver:
>  - Try to read the PLL4/15 rate with clk API (parent of the two clock divider)
>    if it is not available then use the match_data provided numbers.
>  - Support for single PLL setup
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: ti: davinci-mcasp: Specify stream_name for playback/capture
      commit: ef3ab250aad9920fa7fd6280051c92a488109b87
[2/3] ASoC: dt-bindings: Add documentation for TI j721e EVM (CPB and IVI)
      commit: 8142500e7dc0d214e3c7a22788116f71cd84f07b
[3/3] ASoC: ti: Add custom machine driver for j721e EVM (CPB and IVI)
      commit: 6748d05590594837e42dfa975879fb275099f0b2

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
