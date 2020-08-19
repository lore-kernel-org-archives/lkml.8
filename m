Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C07EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40C1520738
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597839375;
	bh=ecmZFbmjBgtZFzBQbq7gL6gCy7ddk1819UscZzDFstI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=ulhzwdgtnxDhlKfq8IggEetxJ5lgzbLjwmQUZZfacDENSVvyz5K/+uBuo8Ad2q9Qm
	 bUDNTrKoLKuhW96A/8eHwXQDXCNPStSsA5jSFZTdFHgDhR1LpUFiBkD/0XC4AZbCKu
	 E1Ft6S78ErZMT3ICOSyaLwsA9ehmr3gxiVoKx3tg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgHSMQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:16:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbgHSMQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:16:07 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24871206FA;
        Wed, 19 Aug 2020 12:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597839366;
        bh=ecmZFbmjBgtZFzBQbq7gL6gCy7ddk1819UscZzDFstI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=hbtL9rqc+f0ahjMfQ7jdq544edl5NKyL0HrVpeIQ9L/wztWBedr3Kzxl3MW+n+jbJ
         47R4RlyxN3ixMxTBnVwL6hmxczc+XgEy4MTUOsst5+ZzP0TJT5ylvR3UnMVpBaVfvi
         sGojJEHs2v72klVNkInXRY+K/7AM9YQIKlufeccs=
Date:   Wed, 19 Aug 2020 13:15:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Samuel Holland <samuel@sholland.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Chen-Yu Tsai <wens@csie.org>
In-Reply-To: <20200819034038.46418-1-samuel@sholland.org>
References: <20200819113405.55582925@canb.auug.org.au> <20200819034038.46418-1-samuel@sholland.org>
Subject: Re: [PATCH] ASoC: sun8i-codec: Hook up component probe function
Message-Id: <159783932454.55025.7710161905600832608.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020 22:40:38 -0500, Samuel Holland wrote:
> Due to a mistake made while reordering patches, commit 90cac932976e
> ("ASoC: sun8i-codec: Fix DAPM to match the hardware topology") added
> the sun8i_codec_component_probe function without referencing it from
> the component definition. Add the reference so the probe function gets
> called as expected.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sun8i-codec: Hook up component probe function
      commit: ed7f0fbc9dca0961ac9a713c778319b7f24315ae

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
