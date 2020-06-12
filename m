Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4021FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 055A020792
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591970347;
	bh=7lLROIKj308gj2dNhR1qP0gVcCU/EHvwMTDRiLNOYnI=;
	h=Date:From:To:In-Reply-To:References:Subject:List-ID:From;
	b=hN8P3UOe2zbYiy5X6cQefavUiHH9QlFx8ERUghlsCG1ZJJN3qLFGeTEnuzrqrTYAa
	 Sbr97ReMpUBCuukBZWpxAXt0h/qQH4c7TNgbiGfgCPH4xtUL1rKwNfwPq4w0S6D2Nj
	 guK9gvclKwq5KIxG8qn3DaPKzVuTbRZUSAdUw6BM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgFLN7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:59:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgFLN7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:59:03 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6AA9206A4;
        Fri, 12 Jun 2020 13:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591970343;
        bh=7lLROIKj308gj2dNhR1qP0gVcCU/EHvwMTDRiLNOYnI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Z9ioPCMuDYl8KiWosYw3x0x+Vd03QskUIPH0bfkOcra/fTIx585gVcevB/XFbO9/H
         c9zURyT4/PlsW9+HY39b2xaPbA7BXwGWsd+BaoScDLcyVhqGtdhEgo2uOm9XDO9XaX
         7A2xgcZPQwYdp9m0/Ban4Q9tL1YmtesLKFgpIZ4o=
Date:   Fri, 12 Jun 2020 14:59:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     nicoleotsuka@gmail.com, Shengjiu Wang <shengjiu.wang@nxp.com>,
        timur@kernel.org, tiwai@suse.com, festevam@gmail.com,
        lars@metafoo.de, Xiubo.Lee@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, perex@perex.cz, lgirdwood@gmail.com,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <cover.1591947428.git.shengjiu.wang@nxp.com>
References: <cover.1591947428.git.shengjiu.wang@nxp.com>
Subject: Re: [RFC PATCH v3 0/4] Reuse the dma channel if available in Back-End
Message-Id: <159197034097.50978.12090792972224185067.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jun 2020 15:37:47 +0800, Shengjiu Wang wrote:
> Reuse the dma channel if available in Back-End
> 
> Shengjiu Wang (4):
>   ASoC: soc-card: export snd_soc_lookup_component_nolocked
>   ASoC: dmaengine_pcm: export soc_component_to_pcm
>   ASoC: fsl_asrc_dma: Reuse the dma channel if available in Back-End
>   ASoC: fsl_asrc_dma: Fix data copying speed issue with EDMA
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: soc-card: export snd_soc_lookup_component_nolocked
      commit: 6fbea6b6a838f9aa941fe53a3637fd8d8aab1eba
[2/4] ASoC: dmaengine_pcm: export soc_component_to_pcm
      commit: a9a21e1eafc94b79502cab8272b392f7f63ef7bb
[3/4] ASoC: fsl_asrc_dma: Reuse the dma channel if available in Back-End
      commit: 706e2c8811585f42612b6cff218ab3adbe63a4ee
[4/4] ASoC: fsl_asrc_dma: Fix data copying speed issue with EDMA
      commit: b287a6d9723c601dd947f1c27d4cc0192e384a5a

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
