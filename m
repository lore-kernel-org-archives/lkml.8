Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D7EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD81E20786
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597769807;
	bh=kWZIADp0fbyfmlx1mMs190XGGSwSELp1BU6+YcV3YmI=;
	h=Date:From:To:In-Reply-To:References:Subject:List-ID:From;
	b=cFHDfpwCIIvx3F/nOpeS5rHfuBJ3UfbPBHK/t1o/nQD5das1NT0N1Ye9uMWH4YDG3
	 x8+8VhPPcvyBmkF16CaS3RGqXKJBbwarMvbbPIZOFkVACvQ4pHiamjJ62RRIlHVuMe
	 d57SKxUgM0W0lJikg7Gj9xYbNB4xkzf0ybz7f2nA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgHRQ4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:56:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728454AbgHRQzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:55:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C32C207D3;
        Tue, 18 Aug 2020 16:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597769751;
        bh=kWZIADp0fbyfmlx1mMs190XGGSwSELp1BU6+YcV3YmI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=uR9TA7jfh5MpSxsGF3Mqvhc3Fsc5jKlT8kz8nhAYvI6PhpdUCgS/WaisC3yk2A5tT
         ROtFHmSaDLjq5evfNlKoE4nSZ/exNXuKAxwZTp/GF+e+2d88toPBiXijAfHlQddONU
         Pj1/FYuHr5KtL9DjoOhvs/2C1+75NXErvmwFnvm0=
Date:   Tue, 18 Aug 2020 17:55:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     festevam@gmail.com, Xiubo.Lee@gmail.com, tiwai@suse.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>, timur@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        nicoleotsuka@gmail.com, linuxppc-dev@lists.ozlabs.org,
        alsa-devel@alsa-project.org, perex@perex.cz
In-Reply-To: <20200805063413.4610-1-shengjiu.wang@nxp.com>
References: <20200805063413.4610-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v3 0/3] refine and clean code for synchronous mode
Message-Id: <159776961930.56094.11883381459081946963.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Aug 2020 14:34:10 +0800, Shengjiu Wang wrote:
> refine and clean code for synchronous mode
> 
> Shengjiu Wang (3):
>   ASoC: fsl_sai: Refine enable/disable TE/RE sequence in trigger()
>   ASoC: fsl_sai: Drop TMR/RMR settings for synchronous mode
>   ASoC: fsl_sai: Replace synchronous check with fsl_sai_dir_is_synced
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: fsl_sai: Refine enable/disable TE/RE sequence in trigger()
      commit: 94741eba63c23b0f1527b0ae0125e6b553bde10e
[2/3] ASoC: fsl_sai: Drop TMR/RMR settings for synchronous mode
      commit: 7b3bee091ec375777ade2a37e4b0c9319f92de27
[3/3] ASoC: fsl_sai: Replace synchronous check with fsl_sai_dir_is_synced
      commit: 9355a7b1896f6fadcbd63d199d1f343bf2e4fed8

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
