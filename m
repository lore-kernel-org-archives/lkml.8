Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BBDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE383207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590591482;
	bh=UlnnGaH1loGBWdcS+XPAxuzzJn8SjhbfQG6BtGVkfm8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=FQHcPQrZAopufAF6r7tXlW/AllE8K51/2XypdqDqwJ2+dvbtcV2lT7G3JDpmJ0tFs
	 YkwJaCBQZC06sxCf70KAk2Kwn9KyQ77p9CLgPd2mrEsk5IVIZU3D7V7dNZSUh7NJNm
	 6Ecsl8B5Zlyk6cRF4B0VcF54Kch9IuC6byPPVcL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389426AbgE0O6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:58:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389411AbgE0O6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:58:01 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2A8C20899;
        Wed, 27 May 2020 14:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590591481;
        bh=UlnnGaH1loGBWdcS+XPAxuzzJn8SjhbfQG6BtGVkfm8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=g+O7JhSeyz45eEKyHq2F8s2Hy5XQwPHiLUs5arg3G3apZji0K5+lJ+G5LogaAu6gN
         fWjY9yqH5TksMWSoxKo21r3jF7mMhQOmYc3l4KPgQII8Twso8Vb3VjL4lZac73UZWw
         vsgjH6wWERyguMHpuMO8cqdVk37w8edH05BvxduU=
Date:   Wed, 27 May 2020 15:57:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     Enrico Weigelt <info@metux.net>, linux-kernel@vger.kernel.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        patches@opensource.cirrus.com, Liam Girdwood <lgirdwood@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20200527024625.9937-1-dinghao.liu@zju.edu.cn>
References: <20200527024625.9937-1-dinghao.liu@zju.edu.cn>
Subject: Re: [PATCH] ASoC: wm8962: Fix runtime PM imbalance on error
Message-Id: <159059147353.50918.8954305558972118700.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 May 2020 10:46:22 +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> the call returns an error code. Thus a pairing decrement is needed
> on the error handling path to keep the counter balanced.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8962: Fix runtime PM imbalance on error
      commit: 920bef64cc5fa0e955be357bfc876179729df216

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
