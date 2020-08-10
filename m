Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAF4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B462121775
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597085887;
	bh=6m89LwQymWWFKzojkQXn5VU1SIsbMwB2ToiCTgefcOg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=ZOcTfA64+JI8VvhQj/fJHI0eHvMyfDLvmzexInRhPIt3tKSFAwpZ94J9gJtxzDd4z
	 w3f0XWSd1PTtePJwW9iE6KX2//Q8TnpdEEU8pRFAcE4WkRCrrWp4ZW+SB0XIn0CjJJ
	 qx4vJUxyWSpgYwuoDe7z6m5HsSKK8TsavwzU1pwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgHJS6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 14:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbgHJS6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 14:58:05 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F05B20774;
        Mon, 10 Aug 2020 18:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597085885;
        bh=6m89LwQymWWFKzojkQXn5VU1SIsbMwB2ToiCTgefcOg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=iCRGvQp0JpqOcRY8Zbn+14+sbysIa5JFLuj6tIFI91EyDNlHfXrlXjdJnm+ikLMkM
         nxV6TCsTpAXijpwLWlDhJSco5IGw9aHJ0neIwG5zt5gyWQO12ByufFW/iZOYTmf/xO
         WaddxDHTlbY1bnyttvvWkLPV1TlBYOjsdB9WfbM0=
Date:   Mon, 10 Aug 2020 19:57:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <20200807161046.17932-1-Vishnuvardhanrao.Ravulapati@amd.com>
References: <20200807161046.17932-1-Vishnuvardhanrao.Ravulapati@amd.com>
Subject: Re: [PATCH] ASoC: amd: Replacing component->name with codec_dai->name.
Message-Id: <159708585778.21544.6105226494365103572.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Aug 2020 21:40:17 +0530, Ravulapati Vishnu vardhan rao wrote:
> Replacing string compare with "codec_dai->name" instead of comparing with
> "codec_dai->component->name" in hw_params because,
> Here the component name for codec RT1015 is "i2c-10EC5682:00"
> and will never be "rt1015-aif1" as it is codec-dai->name.
> So, strcmp() always compares and fails to set the
> sysclk,pll,bratio for expected codec-dai="rt1015-aif1".

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: Replacing component->name with codec_dai->name.
      commit: ea7dc097826b06a9746a2e74c2d6e78d35c98088

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
