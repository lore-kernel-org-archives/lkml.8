Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6126C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95DAC2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595858205;
	bh=cBvIlk8E7YyVn2XdywDqzcNs5DbT2ue8zeBexCna5m4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=pk0BLY6Y0ezlnklSL3PsC3TYZnUzyl35e8ZuA74IV9cTn+RMeFSFerjNz83fFm2dP
	 h8l87VHbFdCvpP9gBFarIML5Zv+SAUUVjJ+W9i16gSCj6PK1HESfn/HKk95K6PM1uC
	 hA9kZvsbitx+si+ptHjJh4AfZyY2tzBm9o+t8Xa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbgG0N4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:56:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbgG0N4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:56:44 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3544C2070A;
        Mon, 27 Jul 2020 13:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595858203;
        bh=cBvIlk8E7YyVn2XdywDqzcNs5DbT2ue8zeBexCna5m4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Y+bJfa4adDdnpO8PDjy2Ft7KiIPYz4+ozECo+qj/uza0GXPzxqwIb/3xciGRxp4zx
         p+9j8yuQHkzD1fVfLLtRFp+MnIi3axDHCmQwgRpDkLm7ac3wGCbPD28ZjoXAX+Rugh
         bgzJjnAELOI/fQ2jXRbgtV3QPnPomJXCKi0HDsf4=
Date:   Mon, 27 Jul 2020 14:56:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20200724195600.11798-1-akshu.agrawal@amd.com>
References: <20200724195600.11798-1-akshu.agrawal@amd.com>
Subject: Re: [PATCH] ASoC: AMD: Restore PME_EN state at Power On
Message-Id: <159585818664.22279.12791067726810170753.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jul 2020 01:25:52 +0530, Akshu Agrawal wrote:
> PME_EN state needs to restored to the value set by fmw.
> For the devices which are not using I2S wake event which gets
> enabled by PME_EN bit, keeping PME_EN enabled burns considerable amount
> of power as it blocks low power state.
> For the devices using I2S wake event, PME_EN gets enabled in fmw and the
> state should be maintained after ACP Power On.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: AMD: Restore PME_EN state at Power On
      commit: 1255296cf0233780b7b9af90f374983fbcdef7bb

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
