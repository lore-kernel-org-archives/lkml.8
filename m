Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF22C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEEC520870
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593795827;
	bh=KsrS7I9qqR/6iPnIWnW3dOayryKjYOf6ZmkkltC24D8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=LFMRwKBqKv9G7zltqlKKMDIe/d88j6Ke5MHNTzQ9sfmtFOUs2SrqyVEz87tNh8GHs
	 t+vqgVVW4azmGXVRZnHVbSdUsvQoJNA210P0ygZ7xXvf0SPyy8UK3DEQAv3saETDj7
	 s9/Tm1dZKq5bVC+3MJav4UyNoAeQRVAp9202VjFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgGCRDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:03:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbgGCRDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:03:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ADB8208E4;
        Fri,  3 Jul 2020 17:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593795826;
        bh=KsrS7I9qqR/6iPnIWnW3dOayryKjYOf6ZmkkltC24D8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=rgwVAHhjCRXbq+7n0OzhHWK+4uc5zj7+YlVT55AjXs2sdV7yoqqdUdLOHIxOxsehm
         006Tf70B4NGnZO7dqN92/JLF8oLFDJM/SdiUAGBS6afpjiCbFuV9lyfRfPN51+GgXm
         vsfNMGBQNL7bCi+4rxkHwAgIwDVJ96roSiej3V3o=
Date:   Fri, 03 Jul 2020 18:03:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, festevam@gmail.com, lgirdwood@gmail.com,
        nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, timur@kernel.org,
        perex@perex.cz, alsa-devel@alsa-project.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1593506876-14599-1-git-send-email-shengjiu.wang@nxp.com>
References: <1593506876-14599-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: fsl_asrc: Add an option to select internal ratio mode
Message-Id: <159379581381.55795.16716505708033817338.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020 16:47:56 +0800, Shengjiu Wang wrote:
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
