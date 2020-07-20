Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE77C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C66022C9D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595255918;
	bh=EcWTvV7FvjC152CSceUX6DbHmfJye4qaDwlHiHugiZU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=usCtzcrNXkgCFDQh+6Wz+Ja9HX8RjzcmKh//Rqd2uPLSfhrYwi/43FCt3oVCHffDw
	 4CD8wjw7O+h0PmKuIhcCHNN0jE24K/h8+ygZlnf7/nVM0gFmK1NsWJJmOFC533QRkC
	 0i8/0KYP999nXXh79F76qXToGacqfV3vmUzdTZNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgGTOih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:38:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTOih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:38:37 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE9EE22482;
        Mon, 20 Jul 2020 14:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595255916;
        bh=EcWTvV7FvjC152CSceUX6DbHmfJye4qaDwlHiHugiZU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=qcIP39hoNUAdVJQvhVryEPqSGKvUM/CCT0Bl6NtT2kHxXjUmV4Y3iqt8KckyulIt2
         RAIxVA7zlh0CSdmwmNuPVE0vL1qOyord1P2Mu7d56rZlV/0Yh0uXrNR9bD2hfYF8Vf
         jI34YufHG9n7Ss1g6bJtFQWwZqNGUjmQza3rmFZI=
Date:   Mon, 20 Jul 2020 15:38:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        Sameer Pujar <spujar@nvidia.com>,
        kuninori.morimoto.gx@renesas.com, tiwai@suse.com
Cc:     rlokhande@nvidia.com, digetx@gmail.com,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        linux-tegra@vger.kernel.org, swarren@nvidia.com,
        sharadg@nvidia.com, nicoleotsuka@gmail.com, viswanathl@nvidia.com,
        nwartikar@nvidia.com, jonathanh@nvidia.com, atalambedu@nvidia.com,
        mkumard@nvidia.com, dramesh@nvidia.com, alsa-devel@alsa-project.org
In-Reply-To: <1595134890-16470-1-git-send-email-spujar@nvidia.com>
References: <1595134890-16470-1-git-send-email-spujar@nvidia.com>
Subject: Re: [PATCH v5 00/11] Add ASoC AHUB components for Tegra210 and later
Message-Id: <159525589435.6792.708136378511410418.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jul 2020 10:31:19 +0530, Sameer Pujar wrote:
> Overview
> ========
> Audio Processing Engine (APE) comprises of Audio DMA (ADMA) and Audio
> Hub (AHUB) unit. AHUB is a collection of hardware accelerators for audio
> pre-processing and post-processing. It also includes a programmable full
> crossbar for routing audio data across these accelerators.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: dt-bindings: tegra: Add DT bindings for Tegra210
      commit: 665308c0b44a37339b9b3368f1dd61eb66acde87
[2/6] ASoC: tegra: Add support for CIF programming
      commit: 1c3b89fb7e4a78ddcd627e3f218a216e2136ae9b
[3/6] ASoC: tegra: Add Tegra210 based DMIC driver
      commit: 8c8ff982e9e2b2eb9255fc393f938915b0ddc127
[4/6] ASoC: tegra: Add Tegra210 based I2S driver
      commit: c0bfa98349d1796fe754dfac7f7f505bb60dcd83
[5/6] ASoC: tegra: Add Tegra210 based AHUB driver
      commit: 16e1bcc2caf446fa3e1daa040b59fd6f6272a766
[6/6] ASoC: tegra: Add Tegra186 based DSPK driver
      commit: 327ef64702668bb754eeea80ce402454d7a1302a

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
