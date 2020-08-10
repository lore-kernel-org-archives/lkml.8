Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E1FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 711E120774
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597085893;
	bh=6ZZ9G3SM7GPTdhIrNRHxeMljHgSvDpjiR2vpNrzWIy8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=uKhR3el8qShE0vSmlPdM7l5Atdn7dAJH2v6U49apptttzVMGpwsKn0f+zEmQu9Tpg
	 KEh/D1NOub3jgZx/8RDEfAOZxbeF/zCa8LQ/1YH6toeFyTtVvsf9n2g4v9TOuE4shs
	 qcOa75jF1zV4baStenR3/EptA8o6IwlyfbiDUhQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgHJS6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 14:58:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbgHJS6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 14:58:11 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C66B21775;
        Mon, 10 Aug 2020 18:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597085891;
        bh=6ZZ9G3SM7GPTdhIrNRHxeMljHgSvDpjiR2vpNrzWIy8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=wLbN9m9h0cjrOvQEEKFw9roG57w01qqZHmq8pxJHWSslbicO+nHh2c8Jk6vCcSNSF
         eCUwzF6OvIpRRrAnu0V2rT37AOv1ptkTNt8RuqGs4I/1YcKGk6SRYiPK1B7J8DhTip
         kwdlWwJxYdOHS6D5lEpjU5seCLlBhul3LvxsdOAs=
Date:   Mon, 10 Aug 2020 19:57:44 +0100
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
In-Reply-To: <20200806101451.7918-1-Vishnuvardhanrao.Ravulapati@amd.com>
References: <20200806101451.7918-1-Vishnuvardhanrao.Ravulapati@amd.com>
Subject: Re: [PATCH] ASoC: amd: Replacing component->name with codec_dai->name
Message-Id: <159708585777.21544.6227920009595743582.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Aug 2020 15:44:12 +0530, Ravulapati Vishnu vardhan rao wrote:
> Replacing string compare with codec_dai->name instead of comparing with
> codec_dai->component->name in hw_params.

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
