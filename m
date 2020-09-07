Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D55C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF953215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599501999;
	bh=sNUUOGd+zmw4ssO5Tsq9VNd3B6I/l3WoE9Y4I1kNoGE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=e111V8sgFphXfZ/VaVOGK/zIcT/+CDWsRqUedBmDkrM8TO3OSMtS0sO5Vo2U1AnPu
	 ENy3qX1UjsG1YMS8f5T+3+4kzEmZ1UV+XEuIihJ3XzfmraOgHQqq7BtfRHsUpDPG2I
	 LXDFHQjDPAw+IdPtub9EBu/r3Bb64qunAeuRovxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbgIGSGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:06:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:32882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729588AbgIGSG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 14:06:27 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B994A208C7;
        Mon,  7 Sep 2020 18:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599501987;
        bh=sNUUOGd+zmw4ssO5Tsq9VNd3B6I/l3WoE9Y4I1kNoGE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=nZYioifeQakWCas9N4J/sLJK5DhXwtkJBaeEjG2GsDaYRM2i5awiiAGT7a0efSpwm
         4BZxrWI1tBpbWcVEKU9GIWFuMoULj4n2bkPHkQZ0rxb3ytSYdOgjYinXnqZQuGSzCp
         L5dBjA4ZJWCJkg5XIawmg/HP7q2MmcDSyn9FGC4E=
Date:   Mon, 07 Sep 2020 19:05:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        hui.wang@canonical.com, srinivas.kandagatla@linaro.org,
        tiwai@suse.de, mengdong.lin@intel.com, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, bard.liao@intel.com,
        pierre-louis.bossart@linux.intel.com, gregkh@linuxfoundation.org,
        sanyog.r.kale@intel.com, jank@cadence.com
In-Reply-To: <20200904182854.3944-1-yung-chuan.liao@linux.intel.com>
References: <20200904182854.3944-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH v3 0/3] ASoC: Add sdw stream operations to dailink ops.
Message-Id: <159950192275.52707.7554622112953148730.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Sep 2020 02:28:51 +0800, Bard Liao wrote:
> Sdw stream operation APIs can be called once per stream. Move these
> operations to dailink ops. The linked series is "soundwire: Remove sdw
> stream operations from Intel soundwire dai".
> 
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> 
> Changes in v3:
>  - s/ASOC/ASoC
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: soc-dai: clarify return value for get_sdw_stream()
      commit: d20e834e13ce349c9b901b9dd8b7013e255083e8
[2/3] ASoC: Intel: sof_sdw: add dailink .trigger callback
      commit: ae3a3918edf57bde7651964be04d0807cccae8f2
[3/3] ASoC: Intel: sof_sdw: add dailink .prepare and .hw_free callback
      commit: 06998d49bcac8a9df3341db99c5f81ae4ef51c84

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
