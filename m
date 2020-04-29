Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E62C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 707C92085B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588177606;
	bh=RgPmeUZllXtirgmPRnh3nwQ41QJGEdm8EDdeOOZDzrw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=bbZzo0neIleKH6T0zEjl1JDv+qWDXLcw0esWmpx/U3t0M8qf2mgKddoLybgUSkZtw
	 xVijDISxWV4TdATS2O2Ru3CKQMsXLmx+Tdtg+3S9h3bd/i4hOf32xQpf2DbDFF8+pM
	 5Qv9FonjoWCLpQqlGHJHmN45UQmBiXiMoUrqrkkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgD2Q0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:26:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgD2Q0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 12:26:44 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0465020787;
        Wed, 29 Apr 2020 16:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588177604;
        bh=RgPmeUZllXtirgmPRnh3nwQ41QJGEdm8EDdeOOZDzrw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=g7ATxj0SrrWjJMZGiZ95dLJiaRR8ZWhv29KHHXqp5w/HNIL+8QZDBvI3KWFJjJ5t5
         e3PeziQYim2SczDKhMpkbBX89HuyUd7slp/oGTxTr0/lcJ3UV0ufBqp1F6RbuEuV3R
         eYInyzTdM+BkMiPllU+7soEeVT+Csl+k3Wdu8+94=
Date:   Wed, 29 Apr 2020 17:26:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.wolfsonmicro.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <20200428212721.2877627-1-arnd@arndb.de>
References: <20200428212721.2877627-1-arnd@arndb.de>
Subject: Re: [PATCH] ASoC: codecs: wm97xx: fix ac97 dependency
Message-Id: <158817756638.27768.14951334654894863306.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 23:26:59 +0200, Arnd Bergmann wrote:
> A recent build fix got the dependency slightly wrong, breaking
> builds with CONFIG_AC97_BUS_NEW:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_WM9713
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_AC97_BUS [=n]
>   Selected by [m]:
>   - SND_SOC_ZYLONITE [=m] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_PXA2XX_SOC [=m] && MACH_ZYLONITE [=y] && AC97_BUS [=n]=n
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: codecs: wm97xx: fix ac97 dependency
      commit: ee2cbe06935bfa58f1fe07dc2a2283945f4b97dc

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
