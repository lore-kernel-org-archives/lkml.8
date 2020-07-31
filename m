Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AC8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 993EC22B3F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596221693;
	bh=cPENTsFz9NF34PUPiqsjoOUpv0lIovNmL4NJV2As9rY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=G+BzfX3j2wRFwnBI/6b+Iq0c4XeW14sv31gLjB4jtECT4/MAviFpktlQKSpNNbuIX
	 3x0d2eYY/u8C5ekdjW6SP9kpJpYa3On+Y8N2QcRy/mBoP+FU52dmNk9d2DZacNRggs
	 Son9SgykQtTrKjZEKpWju35hfljUd0FJXTlHLOMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387797AbgGaSyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 14:54:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:53142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgGaSyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 14:54:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADF682076B;
        Fri, 31 Jul 2020 18:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596221691;
        bh=cPENTsFz9NF34PUPiqsjoOUpv0lIovNmL4NJV2As9rY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=1CXslw7ZcjA8wGEp6WkGIj4fIERNm2rwKBELVJ8SoffTqg3wy2yhUKxHu4BmH/YWF
         strMAr2J0tsImHVpgIxZw3tYlf2aOW46AzBlKyL0Qr5D3CHhbiQuZI4b0t4O4XOpXs
         XnWNKOaRj278/QBTtKXqPMH4gWUbQ+6Ns9iH/C9s=
Date:   Fri, 31 Jul 2020 19:54:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     alsa-devel@alsa-project.org, Kevin Hilman <khilman@baylibre.com>,
        zhangn1985@outlook.com, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
In-Reply-To: <20200731120603.2243261-1-jbrunet@baylibre.com>
References: <20200731120603.2243261-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] ASoC: meson: cards: deal dpcm flag change
Message-Id: <159622167150.22822.13397652809932065449.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jul 2020 14:06:03 +0200, Jerome Brunet wrote:
> Commit b73287f0b074 ("ASoC: soc-pcm: dpcm: fix playback/capture checks")
> changed the meaning of dpcm_playback/dpcm_capture and now requires the
> CPU DAI BE to aligned with those flags.
> 
> This broke all Amlogic cards with uni-directional backends (All gx and
> most axg cards).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: cards: deal dpcm flag change
      commit: da3f23fde9d7b4a7e0ca9a9a096cec3104df1b82

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
