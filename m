Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBA6C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BE5D2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588177600;
	bh=+ZFmSTfRlzLSqIImDH7J+JHuq7zyyWHC0ptJUMmXft0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=nkJ5mRs1o2A0EnoZkYP2l3RqO7Fg963o2vmxfgjlDQjwEwwL4Gz1C8ILwFPq6kBC0
	 h4m/B7DZrpbNv/TYnfguNxJh24vqC3L8iwJvE0FBSdtoAnn2MeDxKwenoalWO4Hh0u
	 Qf3wpIHl9viRgFEjMH2PYhpGInLA93q/tSp9uu28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgD2Q0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:26:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgD2Q0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 12:26:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10CFF2076B;
        Wed, 29 Apr 2020 16:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588177598;
        bh=+ZFmSTfRlzLSqIImDH7J+JHuq7zyyWHC0ptJUMmXft0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=jNtwpDlN2/yGU87aQZnyuN1IH98wv1CpRVpBC4Uwt/70lA0qwy5OTnoe2aHRSBp1D
         h8Ozoh62f6XvG7IfwUZLY8MseaEy1tb57+jJf+GZoEy6PcVaUQdJlvbxcCr3Rrl35A
         vXmxiQ+oXRTxE74U6ugksHMR6+IwBMln6lqNHRR8=
Date:   Wed, 29 Apr 2020 17:26:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        kbuild test robot <lkp@intel.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Richard Fitzgerald <rf@opensource.wolfsonmicro.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <20200428214642.3925004-1-arnd@arndb.de>
References: <20200428214642.3925004-1-arnd@arndb.de>
Subject: Re: [PATCH] ASoC: rt5682: fix I2C/Soundwire dependencies
Message-Id: <158817756638.27768.13590393174406922978.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 23:46:14 +0200, Arnd Bergmann wrote:
> If one of the two is a loadable module, the combined driver must
> not be built-in:
> 
> aarch64-linux-ld: sound/soc/codecs/rt5682.o: in function `rt5682_sdw_hw_free':
> rt5682.c:(.text+0xb34): undefined reference to `sdw_stream_remove_slave'
> aarch64-linux-ld: sound/soc/codecs/rt5682.o: in function `rt5682_sdw_hw_params':
> rt5682.c:(.text+0xe78): undefined reference to `sdw_stream_add_slave'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: rt5682: fix I2C/Soundwire dependencies
      commit: fd443a20c2f0950f3c31765a08f7dd49b3bc69cb

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
