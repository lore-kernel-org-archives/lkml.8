Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6960CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BC03208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595535591;
	bh=RbLhyF8VmUxPARdbjTpY75MIQJTxGEkWc+pLG9Iw87s=;
	h=Date:From:To:In-Reply-To:References:Subject:List-ID:From;
	b=bIPEPDuFoKeNWl33sKVxdbL1BA4OQxSlZ+BV/EQRWv/8q1pC65h8ATwALCnMS3ucO
	 VuheFQeuXxiBg5/LL0txokBMJZ/Kaj7+cP9AvyvcSKUbFf6OZMUeTtas9Y/sjQ+Mvj
	 cK2c5eie3g4MNbNzf+u5bZSPrBi4SZqZTJf2NhiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgGWUTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:19:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgGWUTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:19:49 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B035620792;
        Thu, 23 Jul 2020 20:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595535589;
        bh=RbLhyF8VmUxPARdbjTpY75MIQJTxGEkWc+pLG9Iw87s=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=uo7E/Tfd8suvWNQuLxz+Lkd99dI+N0SIg/3w2xsXNTM9hCi97ZChUGKMnTR8aSI55
         b7VGhER6VhwdVlrWVhis6PE1lxQ5MYi6f5Vo4HxTcQHFFC8d2eh0f45+zm+hMLjZPC
         /TtZc6QL7ziUNCG14mISAdJtdae9qvPLheQszmqY=
Date:   Thu, 23 Jul 2020 21:19:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
In-Reply-To: <e74c690c-c7f8-fd42-e461-4f33571df4ef@infradead.org>
References: <e74c690c-c7f8-fd42-e461-4f33571df4ef@infradead.org>
Subject: Re: [PATCH -next] ASoC: ti: fix SND_SOC_J721E_EVM warnings & errors
Message-Id: <159553557414.41908.11173564334335807148.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 11:32:21 -0700, Randy Dunlap wrote:
> SND_SOC_J721E_EVM should not select SND_SOC_PCM3168A_I2C when I2C
> is not enabled. That causes build errors, so make this driver's
> symbol depend on I2C.
> 
> WARNING: unmet direct dependencies detected for SND_SOC_PCM3168A_I2C
>   Depends on [n]: SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && I2C [=n]
>   Selected by [m]:
>   - SND_SOC_J721E_EVM [=m] && SOUND [=m] && !UML && SND [=m] && SND_SOC [=m] && (DMA_OMAP [=y] || TI_EDMA [=m] || TI_K3_UDMA [=n] || COMPILE_TEST [=y]) && (ARCH_K3_J721E_SOC [=n] || COMPILE_TEST [=y])
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: fix SND_SOC_J721E_EVM warnings & errors
      commit: 83249952ffab43b82487c1c497f1b49324c602d4

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
