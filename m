Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0430CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D392920773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593013120;
	bh=k66UnNbdyPj+LwX7I2nsf9Uvi/hIVtOAiKbZmkacQPs=;
	h=Date:From:To:In-Reply-To:References:Subject:List-ID:From;
	b=mns7BwX+J1U0F0WdZO/nyXMCxYfifkVi2Cai/v9fQFKgOsAlY9rDONibD9H+AM170
	 plry9as2FpxgHkkrXNjo/VZxE13FyEoWd7QU35bVZVY9hlD2tseqBypv5rYXSc2bye
	 93A412H8h/v8iRIaHs/PyT7ATU6B7hOk29HjFPLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404399AbgFXPij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:38:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403781AbgFXPii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:38:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 738D7206FA;
        Wed, 24 Jun 2020 15:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593013118;
        bh=k66UnNbdyPj+LwX7I2nsf9Uvi/hIVtOAiKbZmkacQPs=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=SjlcCYhbgYzIzfrM1ot62LZQoDUuGcOKV41ckwqgbdgvZsFRh3GPT84jLdJBra0lb
         zJlkt6b1uDO+GHMVO8rziQOOOcvfX5UDYws3hVF+hkjIEBtu7pamSSr8uFwNBFX1Gi
         5OrmjQYl8pc+GTzBPfWWL1Ul1ZEboAmIwOX7ZrCc=
Date:   Wed, 24 Jun 2020 16:38:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     nicoleotsuka@gmail.com, festevam@gmail.com,
        linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
        Xiubo.Lee@gmail.com, lgirdwood@gmail.com, timur@kernel.org,
        tiwai@suse.com, perex@perex.cz,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1592895167-30483-1-git-send-email-shengjiu.wang@nxp.com>
References: <1592895167-30483-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 1/2] ASoC: fsl-asoc-card: Add WM8524 support
Message-Id: <159301311578.33465.8345204179048045259.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020 14:52:46 +0800, Shengjiu Wang wrote:
> WM8524 only supports playback mode, and only works at
> slave mode.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: fsl-asoc-card: Add WM8524 support
      commit: 3cd990267401fc7d0b222fc81f637e75e46967e0
[2/2] ASoC: bindings: fsl-asoc-card: Add compatible string for wm8524
      commit: 3b3372fa65bab619f99bcfe272e92fb6faa07219

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
