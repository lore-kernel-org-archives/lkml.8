Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D65C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89471207DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597769750;
	bh=jKm2t81NtYjV40fRviXCJZukNmdxkXqUVLGa7N1IAnM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=PzgyiybLitdxZyXkPPQuFMhmJ6N6qdVRzmTcZeE7oe1YFQwJG4GdNMfM+xLOE2YB6
	 uxdheLc/uNRTRAxOi9HMuiE7tTEQYEQXSTZ34wNjsPrKs2rGzUAqOC51p28pGgyJmq
	 b6ZvFcFdRpQFn1W84oVuGAUZdTUoSC3hn/ld0NJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgHRQzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:55:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbgHRQzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:55:01 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 700B5207DA;
        Tue, 18 Aug 2020 16:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597769701;
        bh=jKm2t81NtYjV40fRviXCJZukNmdxkXqUVLGa7N1IAnM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=bHQOeTXib9+XN32Hhfn7nLtuMO3JpGzdl/Q5SxvbeXE627jk6OBNcSszTdCEGnVEj
         MqlZ/gkWly6tf5+Ro715BYsnt5sphihRvsMnBt2ncDpL+J5PFCmBOt+bv1Jrq4GvHr
         hKQ39ZsBjXJCt5MbN5Q4njHaNUYYYgqxbJ+8B0os=
Date:   Tue, 18 Aug 2020 17:54:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     Vinod Koul <vkoul@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20200813084112.26205-1-dinghao.liu@zju.edu.cn>
References: <20200813084112.26205-1-dinghao.liu@zju.edu.cn>
Subject: Re: [PATCH] [v2] ASoC: intel: Fix memleak in sst_media_open
Message-Id: <159776961932.56094.14732357136908133614.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Aug 2020 16:41:10 +0800, Dinghao Liu wrote:
> When power_up_sst() fails, stream needs to be freed
> just like when try_module_get() fails. However, current
> code is returning directly and ends up leaking memory.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: intel: Fix memleak in sst_media_open
      commit: 062fa09f44f4fb3776a23184d5d296b0c8872eb9

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
