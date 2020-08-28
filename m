Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D68C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C69A72086A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598626277;
	bh=tYgV+FBYe1Z6jN+MAv7hfYtP2hXvmNwxY+Gt1pXHABI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=1KwcHlcEWBtcLnwVbDKA93I1KXAGLKw2D0IfOJyl6lGMIe5q5VnAVw50mj6913epF
	 lHjTa3e+C95gkKbK4hZavmeuoOwSFgkMBp84EEDt2Ux6CMdX7QXuUVyJnqA7C5+sAF
	 ByiPUgyHh/fJCjDrdnjZvioOGHaQ4hXMuzG4zYAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgH1OvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:51:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgH1OvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:51:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4417420848;
        Fri, 28 Aug 2020 14:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598626275;
        bh=tYgV+FBYe1Z6jN+MAv7hfYtP2hXvmNwxY+Gt1pXHABI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Fm4UIVpPsATiFzzlVYRYNdoZ6ROoTuq4/1WSb1YxgMGinj0LSzfoqVLfypYTKOvTp
         OSR265HcdMgWAFSS7sjBj5ZUfeEElwft/BRMMlE7/mQAFlJiMcBrYiAgI8yOv8dldQ
         MNzAXpN0JGtgDwZiEHh/QTIlWr6DLobJ2OYTTsdI=
Date:   Fri, 28 Aug 2020 15:50:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>, lgirdwood@gmail.com, perex@perex.cz,
        robh@kernel.org, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
In-Reply-To: <20200828112855.10112-1-dmurphy@ti.com>
References: <20200828112855.10112-1-dmurphy@ti.com>
Subject: Re: [PATCH] ASoC: tlv320adcx140: Add digital mic channel enable routing
Message-Id: <159862623263.40815.9298257186480426843.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020 06:28:55 -0500, Dan Murphy wrote:
> Add the audio routing map to enable the digital mic paths when the
> analog mic paths are not enabled.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tlv320adcx140: Add digital mic channel enable routing
      commit: ece2a74c5913d244e13c42c61ca2e162932fa3b4

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
