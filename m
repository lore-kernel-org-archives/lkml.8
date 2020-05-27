Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8061FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AA3D212CC
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590591510;
	bh=kDy9pO4LzmtkB5iN/9Ch9VxCGoXaCAw5htQMHM1X4BE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=P9uOdznwrwg5tvZbhB2uzmx9ORQ8XPhVBXbLXbZvYMbwngl0CsjVs6KBAcfduHT4y
	 +XRWlCT2f2GxiD3ehUdhn0yMu1vznAZB8eckF0QAx/mD/bDw68xoPFEEvK93fTNws3
	 kpje5phTPlyA1I9xVuc+0IVS4y4ZC/dX01smOUiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389475AbgE0O63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:58:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389378AbgE0O63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:58:29 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BCF42100A;
        Wed, 27 May 2020 14:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590591508;
        bh=kDy9pO4LzmtkB5iN/9Ch9VxCGoXaCAw5htQMHM1X4BE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=JLb9Di3hNPhp2su7hddjGhB4TV632CaznWN8N3mBXK1BsFuX3T/QGyaONLhRFlyqc
         al+homf9kTkUecOs20h5s4pckYqwNvI+E63cZZBUwvaWKr4l++hTw2QkXiQz4ZlxXG
         5mt83VCzt+EVZ0RtPuZcNfw541gyHs5X9pHdalt4=
Date:   Wed, 27 May 2020 15:58:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>
In-Reply-To: <20200527084610.4790-1-dinghao.liu@zju.edu.cn>
References: <20200527084610.4790-1-dinghao.liu@zju.edu.cn>
Subject: Re: [PATCH] ASoC: img-spdif-out: Fix runtime PM imbalance on error
Message-Id: <159059147353.50918.4160762882932440054.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 May 2020 16:46:08 +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> the call returns an error code. Thus a pairing decrement is needed
> on the error handling path to keep the counter balanced.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: img-spdif-out: Fix runtime PM imbalance on error
      commit: 9ad61b5c804090022444719d1f16e1029e002430

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
