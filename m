Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F0CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32F91207DE
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597769856;
	bh=zOU4Pdp1V5FeOhpAv/v6/unjQwdDYx6ZaaOnFF7Mnmg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=BuRGowKSdZq9zMkCr+SJEsttXzyj92T5ZWGjPwLiibfZpui++/E0X/A7qo2j3bF+c
	 raTUhosSJUWP7FXg0owMnLehLwtS9oKmj/PKJaAKICeY/Ta96nf5szrZMUGYG+Pnxs
	 Mlbm/jTp4szf1+8FVnvzSV+vgcK81GR+DZ2ir8Q8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgHRQ5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:57:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728494AbgHRQ4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:56:23 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F76820829;
        Tue, 18 Aug 2020 16:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597769781;
        bh=zOU4Pdp1V5FeOhpAv/v6/unjQwdDYx6ZaaOnFF7Mnmg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=FLldg7pSy4wgyeihdoPTQ4O5HGunk6EmATkRuxHotsyw0cABy8TN6Nvk3OJmoMU7p
         q+KQZAw/MlneDDdhqVMozzxpj+4+fW6gt8XO4T5CHAtuzTRnxmpz3SWOt7xmNzpDJX
         ymRu3IJMKjyoFaI27eGSJHWbxUBq4v2sYuHZCO6w=
Date:   Tue, 18 Aug 2020 17:55:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>,
        Colin King <colin.king@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20200817224706.6139-1-colin.king@canonical.com>
References: <20200817224706.6139-1-colin.king@canonical.com>
Subject: Re: [PATCH] sound: remove duplicate "the the" phrase in Kconfig text
Message-Id: <159776961933.56094.6016392996060777072.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Aug 2020 23:47:06 +0100, Colin King wrote:
> There are a couple of occurrences of "the the" in the Kconfig
> text. Fix these.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] sound: remove duplicate "the the" phrase in Kconfig text
      commit: 466a806a7d2beffa6a79d61dbabac8a48685c3e2

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
