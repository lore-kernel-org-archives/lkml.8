Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C526DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 917252075A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590771078;
	bh=509pJFb+h4EzxXQ9huxUCMGnV93J5bxttZJZDwp+jKo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=rjzuQFIk8P+OXH3HG7ajbenbiSPLvnbflNaJEm6640iNtstQsN5a7WMWwm9BhAgSm
	 iClxiXIlU7WgoCzhsVEDh8goNRxzdagQEjfZZ5U2IsVpxQD1g3ccfme4el2H8ug3cU
	 IrLPKTMwxgMYgN61z+32DfNfFHw2lFeCJqefGb3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgE2QvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 12:51:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgE2QvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 12:51:17 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CB66207BC;
        Fri, 29 May 2020 16:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590771076;
        bh=509pJFb+h4EzxXQ9huxUCMGnV93J5bxttZJZDwp+jKo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=JvBnWf2+Uk8diKibDr9y6lSOSG/X/cJ4gdmVD5Gx7MIDMJiPoaIACDxzeYRtJQJ+9
         nzq6oe000/AbHB7p/WalQfrAl7J2e47miz7jqatUBA3xUWb2D6Iywzo596DjMp5vSW
         mSw5gTMIug/XgSsduNUIB0VNNah3z8JhFH3W7FGw=
Date:   Fri, 29 May 2020 17:51:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xin Tan <tanxin.ctf@gmail.com>
In-Reply-To: <1590415966-52416-1-git-send-email-xiyuyang19@fudan.edu.cn>
References: <1590415966-52416-1-git-send-email-xiyuyang19@fudan.edu.cn>
Subject: Re: [PATCH] ASoC: fsl_asrc_dma: Fix dma_chan leak when config DMA channel failed
Message-Id: <159077105220.28617.9185476806800586420.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 May 2020 22:12:46 +0800, Xiyu Yang wrote:
> fsl_asrc_dma_hw_params() invokes dma_request_channel() or
> fsl_asrc_get_dma_channel(), which returns a reference of the specified
> dma_chan object to "pair->dma_chan[dir]" with increased refcnt.
> 
> The reference counting issue happens in one exception handling path of
> fsl_asrc_dma_hw_params(). When config DMA channel failed for Back-End,
> the function forgets to decrease the refcnt increased by
> dma_request_channel() or fsl_asrc_get_dma_channel(), causing a refcnt
> leak.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_asrc_dma: Fix dma_chan leak when config DMA channel failed
      commit: 36124fb19f1ae68a500cd76a76d40c6e81bee346

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
