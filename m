Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB444C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 19:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 992642078A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 19:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598469449;
	bh=0H6AKIRhKk8pjwIpNJ1qeXyffDG7WNeaHBbBTs3CeAw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=jM8WWo6XorWIDt8DnvyUeogi2mMHkURKMGtDw9pDospOJ9VvrRS/N38/budASMCo/
	 4C6QcI+HeuwXFk3Dp0uWqfUeVgkd8KbPn+br3OFy8o/TqI6skvdsOi65Np8NUNEyKv
	 f8oonWjFEPVggmZSEc6XkKuYStYuP/poF6BcwQzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgHZTR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 15:17:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbgHZTRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 15:17:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF71E2078A;
        Wed, 26 Aug 2020 19:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598469436;
        bh=0H6AKIRhKk8pjwIpNJ1qeXyffDG7WNeaHBbBTs3CeAw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ZiCZuNhmWPoftkP1giXAxL3KKv8kxyu8FywRiqwvNgbAk3UiReFw8QWqoRAmQlDXC
         0HdOekZaDZKz40p2MhoYd7/T6UaPa0OKCiHE0OfItmOBdbjEHZT+pmTgm2766hL5xY
         gL+M2Jt3fTHSFKtfPBjD8ZHEKH0dtvQj/8vqXDwQ=
Date:   Wed, 26 Aug 2020 20:16:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rander Wang <rander.wang@linux.intel.com>,
        alsa-devel@alsa-project.org, Naveen Manohar <naveen.m@intel.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Ryan Lee <ryans.lee@maximintegrated.com>,
        Shuming Fan <shumingf@realtek.com>
In-Reply-To: <20200826163340.3249608-1-vkoul@kernel.org>
References: <20200826163340.3249608-1-vkoul@kernel.org>
Subject: Re: [PATCH v2 0/5] ASoC: Fix return check for devm_regmap_init_sdw()
Message-Id: <159846939971.39744.13669389911848588325.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020 22:03:35 +0530, Vinod Koul wrote:
> This series attempts to fix return check for devm_regmap_init_sdw()
> 
> Changes in v2:
>  - Add missing patch for rt711
>  - Add patch for rt700
> 
> Vinod Koul (5):
>   ASoC: max98373: Fix return check for devm_regmap_init_sdw()
>   ASoC: rt1308-sdw: Fix return check for devm_regmap_init_sdw()
>   ASoC: rt711: Fix return check for devm_regmap_init_sdw()
>   ASoC: rt715: Fix return check for devm_regmap_init_sdw()
>   ASoC: rt700: Fix return check for devm_regmap_init_sdw()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: max98373: Fix return check for devm_regmap_init_sdw()
      commit: 6e0c9b5f90978287b5a3d38ee83203d295f375f1
[2/5] ASoC: rt1308-sdw: Fix return check for devm_regmap_init_sdw()
      commit: 344850d93c098e1b17e6f89d5e436893e9762ef3
[3/5] ASoC: rt711: Fix return check for devm_regmap_init_sdw()
      commit: be1a4b2c56db860a220c6f74d461188e5733264a
[4/5] ASoC: rt715: Fix return check for devm_regmap_init_sdw()
      commit: 282eb0b52e3f0399ee48a4cad0d9ffec840b0164
[5/5] ASoC: rt700: Fix return check for devm_regmap_init_sdw()
      commit: db1a4250aef53775ec0094b81454213319cc8c74

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
