Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986A6C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65C54208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588933740;
	bh=y46FFfqka43lOmkCt/b+5w/rxyZk6SrdMTEQ9yjSkX4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=euUSCipYvgJ4zyYfPPSG4qlRUh53uXaOtBT5Tb1hKYourXHexkdWrgjGHXFA9cdxm
	 xLG54bLy/bmrA6BMJPR6pnOKA6CCH1gB/mF3v8Sk+7MMdl4jvuTQbFizelUgs1cfAY
	 w8igvdszdFodJsBNA3Ytq26qEIyP9XiyiGPZ0WH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgEHK27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 06:28:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgEHK27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 06:28:59 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 657CD20708;
        Fri,  8 May 2020 10:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588933738;
        bh=y46FFfqka43lOmkCt/b+5w/rxyZk6SrdMTEQ9yjSkX4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=mkRtTBNk8qRsDmU3XrxOh7J+KgBGPBp9nNsxYCpdDVMLuLjCdp1ty1yMmV80Ojg4N
         M5Lrws/8wH9M6ySCccn9cJvPRBf2lNkAN8CFamWsrA2A1P10WtiSrl3wXZG/C4Qv5Z
         25vWRQiGJmvL0sa+ZumR0jPFXQYqLAbsQBs33MRs=
Date:   Fri, 08 May 2020 11:28:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     pierre-louis.bossart@linux.intel.com,
        YueHaibing <yuehaibing@huawei.com>, joe@perches.com,
        kai.vehmanen@linux.intel.com, daniel.baluta@nxp.com,
        ranjani.sridharan@linux.intel.com, perex@perex.cz,
        lgirdwood@gmail.com, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        sound-open-firmware@alsa-project.org
In-Reply-To: <20200507072735.16588-1-yuehaibing@huawei.com>
References: <20200507031911.38644-1-yuehaibing@huawei.com> <20200507072735.16588-1-yuehaibing@huawei.com>
Subject: Re: [PATCH v2 -next] ASoC: SOF: Intel: Fix unused variable warning
Message-Id: <158893373629.42817.5382594504318611584.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020 15:27:35 +0800, YueHaibing wrote:
> When CONFIG_SND_SOC_SOF_BAYTRAIL is not set, gcc warns:
> 
> sound/soc/sof/intel/byt.c:85:41: warning: ‘cht_debugfs’ defined but not used [-Wunused-const-variable=]
>  static const struct snd_sof_debugfs_map cht_debugfs[] = {
>                                          ^~~~~~~~~~~
> Move the variable inside #ifdef
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: SOF: Intel: Fix unused variable warning
      commit: 28d4adc4257cd2e119df17aa7e9d18cdf607f23d

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
