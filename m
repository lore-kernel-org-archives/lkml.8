Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82496C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51EA22078E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599501988;
	bh=kQx1n0wiA1AOHZa0bgXD1ERswBDInvHAo+u2PUb7JAM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=wkF/N7qAmMuTlooY+tuuK7Ci9GCUSoXZ0GDqXgNoROt9QDv4phFJkNCYYWJ0h0mLI
	 ssQpE+edYx1tJQFqhNIoUdOvrCFxUt2GR1lFvi3YEnGKwODblMQ3exZCJwtL15x/BF
	 kDBB0Dwy8qlm1z0uFfOf/eQ27edJN2kwOl5m6DMM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbgIGSGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:32804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729588AbgIGSGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 14:06:22 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE49E206B5;
        Mon,  7 Sep 2020 18:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599501982;
        bh=kQx1n0wiA1AOHZa0bgXD1ERswBDInvHAo+u2PUb7JAM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=C5w3wL4XwX/GcnMJRYFWZmdFVKZedCu/emD0LUVm0E3wtFIE6M32A18ibuoHXz+0t
         1Hmow6qLz4DSki7oheINH1Q2NIAH3/4fsYXE+V5At6lLtVRNShWFG42EawIsKf/ykx
         X1J5b6QogdMWHmq7a3WP0shu30xLILZPFQdOn+fU=
Date:   Mon, 07 Sep 2020 19:05:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org
In-Reply-To: <20200831034852.18841-1-samuel@sholland.org>
References: <20200831034852.18841-1-samuel@sholland.org>
Subject: Re: [PATCH 0/9] ASoC: sun8i-codec driver cleanup
Message-Id: <159950192274.52707.8359144994628782541.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Aug 2020 22:48:43 -0500, Samuel Holland wrote:
> Now that the fixes series is merged, here is a series of small cleanups
> to the sun8i-codec driver. These help shorten the patch stack for the
> next series, which will add support for the other two DAIs in this
> codec: AIF2 and AIF3.
> 
> Samuel Holland (9):
>   ASoC: sun8i-codec: Remove extraneous widgets
>   ASoC: sun8i-codec: Fix AIF1 MODCLK widget name
>   ASoC: sun8i-codec: Fix AIF1_ADCDAT_CTRL field names
>   ASoC: sun8i-codec: Fix AIF1_MXR_SRC field names
>   ASoC: sun8i-codec: Fix ADC_DIG_CTRL field name
>   ASoC: sun8i-codec: Fix field bit number indentation
>   ASoC: sun8i-codec: Sort masks in a consistent order
>   ASoC: sun8i-codec: Attach the bus clock to the regmap
>   ASoC: sun8i-codec: Manage module clock via DAPM
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/9] ASoC: sun8i-codec: Remove extraneous widgets
      commit: b8cbb1cab70342756725c1beded6b81031a95762
[2/9] ASoC: sun8i-codec: Fix AIF1 MODCLK widget name
      commit: 2455e37adef39bf7fd12df963b86fa7f313f1ad4
[3/9] ASoC: sun8i-codec: Fix AIF1_ADCDAT_CTRL field names
      commit: fa5c0ca1f90aaadb6539ec6c407221f2ab7b7608
[4/9] ASoC: sun8i-codec: Fix AIF1_MXR_SRC field names
      commit: 0ba95493023de45744962af41ef5ad90bad7d8bb
[5/9] ASoC: sun8i-codec: Fix ADC_DIG_CTRL field name
      commit: 30aff91ec7840fb72daef7ce389a9414e5db4075
[6/9] ASoC: sun8i-codec: Fix field bit number indentation
      commit: fcb7b39ee3d877e4eb79fb2abf15644d1b36285c
[7/9] ASoC: sun8i-codec: Sort masks in a consistent order
      commit: f30ef55c332935c1d7c5f4ae3d084bec8d05712e
[8/9] ASoC: sun8i-codec: Attach the bus clock to the regmap
      commit: efb736fb9eceac6ce335bbaa3d788a05649160b5
[9/9] ASoC: sun8i-codec: Manage module clock via DAPM
      commit: 6b3bb3c82b94521d6d61c1bf7c766c8c3bddacf5

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
