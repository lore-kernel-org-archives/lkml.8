Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F399C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DA4820882
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597769990;
	bh=C7CLmTRDuo1Am8syaTB05mD0CZGXECeviyZKIGQlC74=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=wXbsqLLrxlBiPFFy8EFew0SvsQnGPMrX3a+/kN1ZVupvaUClYwUvD7wjiRdiOj4P+
	 UXeThg0vJ8h7re8nmQx7M9QEiYEJ7XQOV7+RnMU5HFXKJSFfw5Ras7Qnxckx8NpPNB
	 ZrjjMFSTXVMx/chcI+qDlE8GVDkb47izr1he263s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgHRQ53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:57:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbgHRQ4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:56:32 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68DD320866;
        Tue, 18 Aug 2020 16:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597769792;
        bh=C7CLmTRDuo1Am8syaTB05mD0CZGXECeviyZKIGQlC74=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=h18P64vx+aVCi4pv8eAKhyxO1PkGkHFKn5RNVAac/fhL7R/GKtWYVATBX34ba5zo7
         renVjb9DJSvESmFX4JBjVeaGOOm3HfqCHeGi0/df0EE8Vfddf9pUkJoF80zunS7RFf
         emsK3u1UEJR6WRSvIOEhy6N57I72ojLbx80eXIpE=
Date:   Tue, 18 Aug 2020 17:56:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>,
        Oder Chiou <oder_chiou@realtek.com>
Cc:     Shuming Fan <shumingf@realtek.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20200804000531.920688-1-swboyd@chromium.org>
References: <20200804000531.920688-1-swboyd@chromium.org>
Subject: Re: [PATCH 0/3] ASoC: rt5682: Use clk APIs better
Message-Id: <159776961931.56094.13706014566883693653.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Aug 2020 17:05:28 -0700, Stephen Boyd wrote:
> This patch series drops a printk message down to dev_dbg() because it
> was noisy and then migrates this driver to use clk_hw based APIs instead
> of clk based APIs because this device is a clk provider, not a clk
> consumer. I've only lightly tested the last two patches but I don't have
> all combinations of clks for this device.
> 
> Cc: Cheng-Yi Chiang <cychiang@chromium.org>
> Cc: Shuming Fan <shumingf@realtek.com>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: rt5682: Use dev_dbg() in rt5682_clk_check()
      commit: 0b95aa8e8afa4bcd49c8fa36404e2deb02a947ed
[2/3] ASoC: rt5682: Drop usage of __clk_get_name()
      commit: edbd24ea1e5c72980b37ae2d271696b05274d509
[3/3] ASoC: rt5682: Use clk_hw based APIs for registration
      commit: 653bdab267bd8dbce9cbd16bec843ca9d20a8450

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
