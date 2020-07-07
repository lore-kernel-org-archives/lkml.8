Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68B8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA7B120738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594131433;
	bh=Bkr1sJE6MHpMBdzGYUrae/nUqd3maLrYPUOVhB4MWYs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=vd80baG6UGKKe59sNLIbeh0Ow7AOJ4vLYsNZ0wfaNxEyFvVcmbkkpjfMTDge1RCML
	 G2WYR8qXF1JM8rRIwLCVYID91cNDlWyHFpuqMR6R6KMTCJtCkDFxA1xA3h7rCcaz14
	 IIAG+NZhtUGQbruDV/5hGnRgOft9nKJ2UF+1WO3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgGGORM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:17:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728067AbgGGORJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:17:09 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B72A5206E2;
        Tue,  7 Jul 2020 14:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594131429;
        bh=Bkr1sJE6MHpMBdzGYUrae/nUqd3maLrYPUOVhB4MWYs=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ZJKICZoQrSbQqf5SOF8X8qh1ZY9PMow61xgUmYYc6dGWS+YBDxm8gvfWEIceRxhRI
         ix35QjXVhtOrKFUhATS8QUBJ0EU3P8OueIXNguNQFSsQ2FIP8B3f0ejhHbm5VRUGdC
         lklgqccDf54snCmsiLqm4m9BNC+XwM/Oaoj0GTtc=
Date:   Tue, 07 Jul 2020 15:17:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        kernel@collabora.com
In-Reply-To: <20200626164623.87894-1-sebastian.reichel@collabora.com>
References: <AM6PR10MB2263094DD176499308EC8B2A80B80@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM> <20200626164623.87894-1-sebastian.reichel@collabora.com>
Subject: Re: [PATCHv4] ASoC: da7213: add default clock handling
Message-Id: <159413142466.34737.7602523074048381134.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jun 2020 18:46:23 +0200, Sebastian Reichel wrote:
> This adds default clock/PLL configuration to the driver
> for usage with generic drivers like simple-card for usage
> with a fixed rate clock.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: da7213: add default clock handling
      commit: 5146b6a92c1194674f21def93d7025c97ed6977f

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
