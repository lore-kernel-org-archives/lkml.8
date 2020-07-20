Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8451C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B562222CB1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595255913;
	bh=ojeKwU/anC+K6WiUwmutMl94xrosd3vZOyL4uXwrhGs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=V4OySXvCETajEF8PrA+lO0Zw5ph/E7kj+PutGiPwDhYV8botwGDDRZtqgmNjMLTrL
	 HL+qwZlI4Ef/9pvULptP3GTm6+hGNAaQqllUsm0pMSRsRzewD+0FOhGBi0M9TF6BRb
	 JbgJb6cfgumOH2E18brUpem6c8yZbsRPZ5+mFelU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgGTOic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:38:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTOib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:38:31 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2383C22B4D;
        Mon, 20 Jul 2020 14:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595255911;
        bh=ojeKwU/anC+K6WiUwmutMl94xrosd3vZOyL4uXwrhGs=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=z65breQuAB2vMfjTUQvXAql+nZLs88eKrgoN1X/Jn/J8Pq231icqSbm0KjmsNmRtg
         hIvBuUiHe7soq0PlefALErIm0OzDY/frr0LRdyWHWU9N1wjBLFHLeA5CkqalKqAG4f
         kHzqePeY3KGd21QezPN8+7UnxHu2YG85gHSzNkKg=
Date:   Mon, 20 Jul 2020 15:38:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20200719003307.21403-1-rdunlap@infradead.org>
References: <20200719003307.21403-1-rdunlap@infradead.org>
Subject: Re: [PATCH] ASoC: soc-dai.h: drop a duplicated word
Message-Id: <159525589435.6792.14774617062559072369.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jul 2020 17:33:07 -0700, Randy Dunlap wrote:
> Drop the repeated word "be" in a comment.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-dai.h: drop a duplicated word
      commit: fc926a7c818c97e98c5c2db1cb910523df0419e5

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
