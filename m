Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19489C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E70CD206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587480219;
	bh=5e3Om0tNq5AkjbiSTQR8U7jUZzgzErPBUb1379XOKSw=;
	h=Date:From:To:In-Reply-To:References:Subject:List-ID:From;
	b=fZq9hmPIm5StjB44oJE01ELL4pYFiLrkdTe1fbj+ItRiAnj3Kk7lk5J6IG83Gjinh
	 s+asvTSaOBz3DG3b4LzSEbTLDNjSVKGw+kgjm9+pV4m+Z39hXAR6QLh51B+I9D71r0
	 Vxk6lhnkR6hJQvFoCfrUJe4/AihH1kMPpLMOelZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgDUOnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:43:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729257AbgDUOnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:43:35 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC497206A2;
        Tue, 21 Apr 2020 14:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587480214;
        bh=5e3Om0tNq5AkjbiSTQR8U7jUZzgzErPBUb1379XOKSw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ZSG5SzUn9vFXbtZ+C9VMvFYVgu4YyuOoDliCn6TS/Cz6F7+oxLJDxg5s5JJgBCNLk
         8YZC2rCVpT7hOlSgGe25cevaZqbaJQnBscgywTE6WRSIo+fGVj2OpHX025f6qbKB9c
         imvlx2FOW4JPEYO4MoLx+ezeqYoeHe1KIM6ReJek=
Date:   Tue, 21 Apr 2020 15:43:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     tglx@linutronix.de, patches@opensource.cirrus.com, info@metux.net,
        ckeepax@opensource.wolfsonmicro.com, allison@lohutok.net,
        alsa-devel@alsa-project.org, kstewart@linuxfoundation.org,
        perex@perex.cz, Shengjiu Wang <shengjiu.wang@nxp.com>,
        lgirdwood@gmail.com, tiwai@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <1587468525-27514-1-git-send-email-shengjiu.wang@nxp.com>
References: <1587468525-27514-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: wm8960: Fix wrong clock after suspend & resume
Message-Id: <158748021184.7424.16056997508827972639.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Apr 2020 19:28:45 +0800, Shengjiu Wang wrote:
> After suspend & resume, wm8960_hw_params may be called when
> bias_level is not SND_SOC_BIAS_ON, then wm8960_configure_clocking
> is not called. But if sample rate is changed at that time, then
> the output clock rate will be not correct.
> 
> So judgement of bias_level is SND_SOC_BIAS_ON in wm8960_hw_params
> is not necessary and it causes above issue.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

Thanks!

[1/1] ASoC: wm8960: Fix wrong clock after suspend & resume
      commit: 1e060a453c8604311fb45ae2f84f67ed673329b4

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
