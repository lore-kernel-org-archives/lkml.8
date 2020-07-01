Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944E0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6674620870
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593642197;
	bh=iBVt2dwznSpdfmmrhuLy36t4zhkGrZ4KkwP1ObWLwFo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=YiybGPpUYi+wxvJE3gSZZXOHHnoBQW4oCorrKkkxB3/lFPhPaqcSUpQ0vL2l4CzYu
	 O5D5BfnV5B88R8HIwy32RRfdzUm/dXoBlSzxGEJAsEu0m3mMfKnMocBeybZbXUSwyS
	 GdinlhrpsnZtzHfzKQCmJcwtBVGWN3asecnCxp7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgGAWXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 18:23:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727853AbgGAWXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 18:23:13 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9088B20780;
        Wed,  1 Jul 2020 22:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593642193;
        bh=iBVt2dwznSpdfmmrhuLy36t4zhkGrZ4KkwP1ObWLwFo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Qi8FUN2t7oJIPqDlFCPvwtll5bCHtiC2BJGAlQPLp5YTJrOVkgxgOOxyiNbnpkVko
         soEGHQdBhGkpxL3Mm7Sase+VI2iuESiJzsyqrWhUf4HcRFTwH4SFxfRhRrHNFEMqXP
         wQmyzoSIKMbdZMsdjyC7hHMXaagIgMsXW20uz1H4=
Date:   Wed, 01 Jul 2020 23:23:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Brent Lu <brent.lu@intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Mac Chiang <mac.chiang@intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Naveen Manohar <naveen.m@intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Jason Yan <yanaijie@huawei.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Libin Yang <libin.yang@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Amery Song <chao.song@intel.com>
In-Reply-To: <1593596211-28344-1-git-send-email-brent.lu@intel.com>
References: <1593596211-28344-1-git-send-email-brent.lu@intel.com>
Subject: Re: [PATCH v2] ASoC: Intel: bxt-da7219-max98357a: support MAX98390 speaker amp
Message-Id: <159364215575.10630.52868424630898408.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jul 2020 17:36:51 +0800, Brent Lu wrote:
> Support MAX98390 speaker amplifier on cometlake platform. Driver now
> detects amplifier type in the probe function and installs corresponding
> controls and DAPM widgets/routes in the late_probe function.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: bxt-da7219-max98357a: support MAX98390 speaker amp
      commit: e1435a1feb18e198155d16d3d6b500d46e0625c0

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
