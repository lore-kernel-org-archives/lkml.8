Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4D9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 250462088E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593795833;
	bh=avVmBYE85HqmZGz24vFbJj580KfAPUe9Qy5+/5Manoc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=QlgjmymvG1srJVBv8T7Suiibw42XUTnvTICMPe0UmP1um6JMEyG3AWQJOaapBU5Mh
	 bwvJX2dMKBP/t5cB277USkN5CQgR2wULbHyKfEv9Eu2Lmm2R31BGgZrZ37372u7aul
	 YMmlaSIReBaMq/9yjSn/PSllFQL1p+z9bf+Bgsas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgGCRDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:03:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbgGCRDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:03:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2B5A20870;
        Fri,  3 Jul 2020 17:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593795831;
        bh=avVmBYE85HqmZGz24vFbJj580KfAPUe9Qy5+/5Manoc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=kAxCMucRahfO2ghUeJK+MEqOP+R0sb8agJKsi5oXJcHuMs4fZ6Ol7ftUCaB5qerV1
         gO7asNnUfNJ9DL/jfAdBrO1MlU6niawzdHr4C2MS9vF84zwDWKMmOdnJK6DQo0eaA3
         qkEHs36FuA9MxZpytVjmfm9EfEzEnd01vTyCN2qI=
Date:   Fri, 03 Jul 2020 18:03:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Colin King <colin.king@canonical.com>,
        Brent Lu <brent.lu@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200702114835.37889-1-colin.king@canonical.com>
References: <20200702114835.37889-1-colin.king@canonical.com>
Subject: Re: [PATCH][next] ASoC: Intel: bxt-da7219-max98357a: return -EINVAL on unrecognized speaker amplifier
Message-Id: <159379581380.55795.4909094479360848314.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jul 2020 12:48:35 +0100, Colin King wrote:
> Currently if the ctx->spkamp is not recognized an error message is
> reported but the code continues to set up the device with uninitialized
> variables such as the number of widgets.  Fix this by returning -EINVAL
> for unrecognized speaker amplifier types.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: bxt-da7219-max98357a: return -EINVAL on unrecognized speaker amplifier
      commit: c950e9fcc79b8fedd3126ede4dcd70add8ea5339

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
