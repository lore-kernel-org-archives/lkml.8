Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB43C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 12:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2020220663
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 12:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587989210;
	bh=1m16fC0Omj/UN4RkPHjzbywpoiVoVofm7ryYwBegEAM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=e8l2TeaWanU6P1Tf1HP4Y1i+PK6gMBXiRJqSPBj3Tqomx3bMdOvv8KK/xOlotWjzw
	 9tQhY7+xdZPwR30G3pSj0EpwyhOrOz7oAvmdK/L0qViftvyDeBwcz6AD0f98iwWCBJ
	 1ND5IsmNn/Wi19csBaMCEOX9StX87ZYuntU4iKG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgD0MGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 08:06:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgD0MGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 08:06:48 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2234020656;
        Mon, 27 Apr 2020 12:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587989208;
        bh=1m16fC0Omj/UN4RkPHjzbywpoiVoVofm7ryYwBegEAM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=jN69zCDJKrqExjNLOR8Cbwymi5eN2AbzM0CHbDsx9suR47QUg2Kmq/xQtMCIrmouI
         A0hNeOLjfGU7p+9Tp0NrRed2toBUVtjjfiYffuiLdgIthDizhLhHZmoi3knnz3ly0/
         orJbiLE9HH6OSI5kbYpwwJT2Cu+9wth6kcm+Lu0A=
Date:   Mon, 27 Apr 2020 13:06:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     festevam@gmail.com, Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com,
        timur@kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
        alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <a8f2ad955aac9e52587beedc1133b3efbe746895.1587968824.git.shengjiu.wang@nxp.com>
References: <a8f2ad955aac9e52587beedc1133b3efbe746895.1587968824.git.shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: fsl_esai: Disable exception interrupt before scheduling tasklet
Message-Id: <158798920600.35547.13024845856873705018.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020 14:23:21 +0800, Shengjiu Wang wrote:
> Disable exception interrupt before scheduling tasklet, otherwise if
> the tasklet isn't handled immediately, there will be endless xrun
> interrupt.
> 
> Fixes: 7ccafa2b3879 ("ASoC: fsl_esai: recover the channel swap after xrun")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

Thanks!

[1/1] ASoC: fsl_esai: Disable exception interrupt before scheduling tasklet
      commit: 1fecbb71fe0e46b886f84e3b6decca6643c3af6d

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
