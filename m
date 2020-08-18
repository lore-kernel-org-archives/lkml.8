Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B442C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3825B20855
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597769991;
	bh=ak6+QCL5n29G4GLWbvhUOxpo7V6NC6tHUrZDrPnF8Pc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=2CL0RGoQjR+Kh4p8jWbhlqJb7UC3S0KxAtagyegE23yWY6WgXT2HsZqacvTN6ZO5t
	 PvPiBbYUYckMJriJS1e+i4UhAiUddbjjvxTLUy94eWbBoyPFXcnPm9rK0ULNF1bVxw
	 KHJG5SBLZDoJiotjRXOckkF43pDS9g7IhDHtbh9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgHRQ5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:57:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728434AbgHRQ4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:56:17 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D82F920825;
        Tue, 18 Aug 2020 16:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597769776;
        bh=ak6+QCL5n29G4GLWbvhUOxpo7V6NC6tHUrZDrPnF8Pc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Q4zuPDC4Obrg7RPGEUput1lScWOndJrBqR+KVJcVRXyS42FLRHADsncbSCT2jMp4r
         1seJ867b9hUM6uZ2/rwGB7e/pzCLsdtgx5NmkHrPnrNbAz5Y3wX6pYIfbKGjsv1yWL
         R6LGyEqG4l9fZGzun99/SOoEWm0UcbzElnd+SLi4=
Date:   Tue, 18 Aug 2020 17:55:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org, Yong Zhi <yong.zhi@intel.com>,
        Support Opensource <support.opensource@diasemi.com>,
        alsa-devel@alsa-project.org
In-Reply-To: <cover.1597164865.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1597164865.git.Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH 0/3] ASoC: da7219: Reorganise device/codec level probe/remove
Message-Id: <159776961932.56094.1814239239605160041.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Aug 2020 17:57:22 +0100, Adam Thomson wrote:
> This patch set reorganises and fixes device and codec level probe/remove
> handling within the driver, to allow clean probe and remove at the codec level.
> 
> This set relates to an issue raised by Yong Zhi where a codec level re-probe
> would fail due to clks still being registered from the previous instantiation.
> In addition some improvements around regulator handling and soft reset have
> also been included.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: da7219: Move required devm_* allocations to device level code
      commit: 21f279f34c212e82f0330697394840898908f7a6
[2/3] ASoC: da7219: Move soft reset handling to codec level probe
      commit: aa5b18d1c29023b315073661b74c67f91bf2f27c
[3/3] ASoC: da7219: Fix clock handling around codec level probe
      commit: 78013a1cf2971684775f6956d5666237ac53a1aa

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
