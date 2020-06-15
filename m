Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1A9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C006120739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592233558;
	bh=zPiwW2ddojRxptWmrxHVSWKri79W0j8jIOBtmNYk3g8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=SOHwDu3P/PgZgtI07nWPn+lpblRGm7nRaBf25EbGaxXcnnzqUwY8tbOjzfq4hEuZj
	 ewtEeliSIii/JtALioUOmQnH4gD7QEnyarGQprCkS1MmFbFiAJkZTfe4OSBEEWxyAx
	 U7HrNc0dPe1aTvlta8Pq/7usIIwVYhWmWQGYkDzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbgFOPF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:05:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730836AbgFOPFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:05:48 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6350D2074D;
        Mon, 15 Jun 2020 15:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592233547;
        bh=zPiwW2ddojRxptWmrxHVSWKri79W0j8jIOBtmNYk3g8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=TKaRawTVR+cp+9/iub94hwHc0uK5Hl1JUkY07rJcNPdOQ7A5nU0Nxpr0m3/RiKV8v
         mPYH2HEDBa60a1Fdy9uq2oExYyionykWuFwo1No0EBF51Tns0HrcEVBCa1A6w/d5b4
         InecRH3V0m3grK3lmaq9wYVmA2UqJcwsTOsgM/uw=
Date:   Mon, 15 Jun 2020 16:05:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        sound-open-firmware@alsa-project.org,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
In-Reply-To: <1591959048-15813-1-git-send-email-brent.lu@intel.com>
References: <1591959048-15813-1-git-send-email-brent.lu@intel.com>
Subject: Re: [PATCH v3] ASoC: SOF: Intel: hda: Clear RIRB status before reading WP
Message-Id: <159223353043.8967.4528383001962229795.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jun 2020 18:50:48 +0800, Brent Lu wrote:
> Port commit 6d011d5057ff ("ALSA: hda: Clear RIRB status before reading
> WP") from legacy HDA driver to fix the get response timeout issue.
> Current SOF driver does not suffer from this issue because sync write
> is enabled in hda_init. The issue will come back if the sync write is
> disabled for some reason.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Intel: hda: Clear RIRB status before reading WP
      commit: 40e2c465894e5b79b49f55d9574dbcda4ac0f08f

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
