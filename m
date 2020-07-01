Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAF6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40B732082F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593642160;
	bh=mxx7Gg/ZIeVDV4tXevq1kBD2WMrxAhSo/UjofIGOOwU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=IU933Dj7bNt4mCyjH0NNLDJPqaOlXPBf4kX3NsG1BxgzCT8DG+yQl8Nw4/Wy/rIso
	 j/9zU7IfXNeFknIuW53uUENYd/vFT6BzLlLKdy6uMsY3EYZjpdqaDi6W+MlwEsE8eH
	 4W9fCbqBLcTJVfS90ZrJvR8TfGdbh/wYz0NkI6as=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgGAWWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 18:22:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbgGAWWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 18:22:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D78220780;
        Wed,  1 Jul 2020 22:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593642157;
        bh=mxx7Gg/ZIeVDV4tXevq1kBD2WMrxAhSo/UjofIGOOwU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=04e4khGICYM7F2fV318l7QGiET8eig6XK+gokuFooZFgBJouu8gJBd14/TIBQ+mpv
         UblTZxZI4UIzLu5D+bDdMao2CAFWavi/aJo7FRezwwFJsbLKP9Ot1rvINT9cGhR1eh
         xjrE1pqQI/7VEA7Ht2y6mPk1Zc4zXv7HCyhsAZf4=
Date:   Wed, 01 Jul 2020 23:22:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, alsa-devel@alsa-project.org, tiwai@suse.com,
        Xiubo.Lee@gmail.com, timur@kernel.org, lgirdwood@gmail.com,
        festevam@gmail.com, nicoleotsuka@gmail.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1593525367-23221-1-git-send-email-shengjiu.wang@nxp.com>
References: <1593525367-23221-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v3] ASoC: fsl_asrc: Add an option to select internal ratio mode
Message-Id: <159364215575.10630.16163829958912302210.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020 21:56:07 +0800, Shengjiu Wang wrote:
> The ASRC not only supports ideal ratio mode, but also supports
> internal ratio mode.
> 
> For internal rato mode, the rate of clock source should be divided
> with no remainder by sample rate, otherwise there is sound
> distortion.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_asrc: Add an option to select internal ratio mode
      commit: d0250cf4f2abfbea64ed247230f08f5ae23979f0

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
