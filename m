Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1C6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30A412088E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593795844;
	bh=6qbXbqZcal6qUM8m7y1H835971AOT3MG+/JeJM4Mvvo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=f05BKqZw3UWLRbic8UsSOR1tpttdbhmR9B3pNFkTpqD0OJQSDCvgeINontnBrMt6r
	 xPTbPJE9krznMivltPXt+vWiqN7Sdfwa96bZ/wFyMknbBvW1aMz+iJruyNsyLzc8VJ
	 /ABd1kwGXznptjP2xVtUgf1aDj16ASGvRRwLlwm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgGCREC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:04:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgGCREB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:04:01 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDB8220B80;
        Fri,  3 Jul 2020 17:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593795841;
        bh=6qbXbqZcal6qUM8m7y1H835971AOT3MG+/JeJM4Mvvo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=kL89XxMCD1uP1P9nfTCwFTRCu7eRiXWQYekGDxRPBArb+k7sr1jh9+gY3jlLl7K+q
         l3n9qQ4RV6nf2VcW3ZugUBQElUI2uF7AHQuci4M1KqhABFD3TXliGf6tCH/v3b4zU/
         QVPfD/x5ctycONXovCHTF3GnPm3gHfGY9hS8kCh0=
Date:   Fri, 03 Jul 2020 18:03:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Hulk Robot <hulkci@huawei.com>, kernel-janitors@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200703030910.75047-1-weiyongjun1@huawei.com>
References: <20200703030910.75047-1-weiyongjun1@huawei.com>
Subject: Re: [PATCH -next] ASoC: ti: j721e-evm: Fix missing unlock on error in j721e_audio_hw_params()
Message-Id: <159379581381.55795.18016494611644548015.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jul 2020 03:09:10 +0000, Wei Yongjun wrote:
> Add the missing unlock before return from function j721e_audio_hw_params()
> in the error handling case.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: j721e-evm: Fix missing unlock on error in j721e_audio_hw_params()
      commit: 59b44649a8f2380dfbf282db9922ef863c8812a6

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
