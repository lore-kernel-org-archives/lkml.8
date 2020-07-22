Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C182C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 00:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EDAD2077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 00:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595379424;
	bh=LI9NjXKtPYnT9ESNFxpH/NeSTaxYRhwryItg9StDoQM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=jX/vXDL3QbaAtvTRhx4zWKLWPUyXNr2jV2PoMgO2t8L6p20ds6yxO/jWaqW3Fnuo+
	 72j2eD2amz2jat744F98rorpTcF6yjfxyleNB2wZIiOEcXmyBZSWqcoRPELppUyhd5
	 GiQUTWaohirRtvvAIAFiekpDEs1J/0v9h7qvV5W8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbgGVA5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 20:57:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbgGVA5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 20:57:03 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0629C20771;
        Wed, 22 Jul 2020 00:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595379422;
        bh=LI9NjXKtPYnT9ESNFxpH/NeSTaxYRhwryItg9StDoQM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=nMP8D02Vmf1m1HLB/JTz7Mh1RIoyd8sZIAWdzNw80tVsutGXKcTRWktWgprOXArFi
         55JU7Lqzmu4TeMVZ4IxRg8gkdLk9T/f1GNMvbXPQd5Cl2X3CGX+7QjxoT3OvUqXAi2
         2X+0QyJdFGymAGzXxa/mKYTwddUSFXNngfkX1R2s=
Date:   Wed, 22 Jul 2020 01:56:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     kuninori.morimoto.gx@renesas.com, tiwai@suse.com,
        robh+dt@kernel.org, perex@perex.cz,
        Sameer Pujar <spujar@nvidia.com>, lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org, nicoleotsuka@gmail.com,
        sharadg@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        atalambedu@nvidia.com, linux-tegra@vger.kernel.org,
        mkumard@nvidia.com, alsa-devel@alsa-project.org,
        dramesh@nvidia.com, nwartikar@nvidia.com, digetx@gmail.com,
        viswanathl@nvidia.com, swarren@nvidia.com, rlokhande@nvidia.com
In-Reply-To: <1595134890-16470-1-git-send-email-spujar@nvidia.com>
References: <1595134890-16470-1-git-send-email-spujar@nvidia.com>
Subject: Re: [PATCH v5 00/11] Add ASoC AHUB components for Tegra210 and later
Message-Id: <159537940424.49432.12585025490958205269.b4-ty@kernel.org>
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

[1/1] ASoC: tegra: Add Tegra210 based ADMAIF driver
      commit: f74028e159bb8e1de840d945af344bf93b59ada2

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
