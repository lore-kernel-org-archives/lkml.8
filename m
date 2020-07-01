Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164B2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D03BF20780
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593642180;
	bh=qR6b0seueX1BWelGymIepBrH7Jm0QvYZYSibZfidNYw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=VosyZW4CfaSu5Pi8pYTEk7Sd3jipcvVXHLF6ZMf5RQF7XYL6JhNh27zJuIeT4RHGk
	 JPwld0qsr5vJkWHOTwF1AgYbw3Bi0RLR+pK4BxYt9DaACjYVUPg8Hvx/Oiw6vKr3lP
	 h0uLNiJGg/RBNEx3ZCeWdXC0XRHUW8ihwPgrYHBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgGAWW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 18:22:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbgGAWW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 18:22:58 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3347207E8;
        Wed,  1 Jul 2020 22:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593642178;
        bh=qR6b0seueX1BWelGymIepBrH7Jm0QvYZYSibZfidNYw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ybfuOJs9Vmbfe4ObII/sYSTuo+YClxTRqYIrdBxAyiM0aJd4f3dszsnJI5I2cS56c
         Io6TIbicvRPVE0epumlQ9rhyFeaw+fmO7gcxFUwM8n8nrDNpcxmYhwms3XbZeiEbPF
         OSZG1Xp5CZASNqiARSsBmmzvNZ6MkkU0192ooJp0=
Date:   Wed, 01 Jul 2020 23:22:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, alsa-devel@alsa-project.org, tiwai@suse.com,
        Xiubo.Lee@gmail.com, timur@kernel.org, festevam@gmail.com,
        nicoleotsuka@gmail.com, Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1593412953-10897-1-git-send-email-shengjiu.wang@nxp.com>
References: <1593412953-10897-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Refine regcache usage with pm runtime
Message-Id: <159364215573.10630.10167601683932305726.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020 14:42:33 +0800, Shengjiu Wang wrote:
> When there is dedicated power domain bound with device, after probing
> the power will be disabled, then registers are not accessible in
> fsl_sai_dai_probe(), so regcache only need to be enabled in end of
> probe() and regcache_mark_dirty should be moved to pm runtime resume
> callback function.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Refine regcache usage with pm runtime
      commit: d8d702e19e997cf3f172487e0659d0e68aa5ede5

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
