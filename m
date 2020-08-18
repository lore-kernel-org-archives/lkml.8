Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250ABC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2A0B207DE
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597769734;
	bh=t1w93QEWEvokEoid6tjADACw7yv3h5hScfp7S15qTw0=;
	h=Date:From:To:In-Reply-To:References:Subject:List-ID:From;
	b=J4/mguueJS0bWb4WbwzNvqORiqAgSJlLXmGS1BGB1hH8f7zeso2e18xWO4n8RZk0B
	 tiDhIB1MqHnN/wFN7CYG/3+GuYSFGa2DuSc2tySocStHyrFMwrRAtUctPjthhwUVUN
	 IvgeHFBWkbmKdHVZ/XGpi5ip7cwYnX2nCZEFyihE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgHRQzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:55:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728402AbgHRQyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:54:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71D75207DE;
        Tue, 18 Aug 2020 16:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597769686;
        bh=t1w93QEWEvokEoid6tjADACw7yv3h5hScfp7S15qTw0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=fSLh9If/Ej7d50L2+kP020JW5koexmx3Wgwi7oFFgA/HvjWAbO+PMNqDzTKhdVvgD
         OnoH2ly/oAupxb/psXSyQOy5itdHs5nGtq4NanH74VSQUBuyV8Xtx5nG5DzL2BMopT
         53hV3JIV3hn0alEDgC7kF+BNSGCX6l4o3FzGgZbs=
Date:   Tue, 18 Aug 2020 17:54:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     devicetree@vger.kernel.org, tiwai@suse.com, robh+dt@kernel.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        perex@perex.cz
In-Reply-To: <1597397561-2426-1-git-send-email-shengjiu.wang@nxp.com>
References: <1597397561-2426-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: ak4458: Add power supply property
Message-Id: <159776961933.56094.7304762190784166895.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020 17:32:40 +0800, Shengjiu Wang wrote:
> AVDD-supply is for Analog power supply
> DVDD-supply is for Digital power supply

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: ak4458: Add power supply property
      commit: 617a156f2ebae841bcd64ee5a21d0e12b5d733ab
[2/2] ASoC: ak4458: Add regulator support
      commit: 7e3096e8f823682c20e033113ec32dd590364774

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
