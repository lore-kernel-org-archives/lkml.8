Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA26BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4AE620838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596148074;
	bh=Oeyh74HxiGgRjXiOD6SLqRmC7a5ZmDzaNWynafKQomk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=UIQrA+YILMOS+CDdI+CHl1nr/vEebonyVb+Xr25Upj2B/eWQCVkIITz6T94rmL1rm
	 Awjnf4IZnbpqX58bCdzyHAeTPEfkZ1jgREPGiTo3fOfl2d3RDHtHroZZWHRinTFQNP
	 C3Dxbnp93L8EH0oR+X32R1VnyBBiDsluQquq3i2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbgG3W1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:27:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728607AbgG3W1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 18:27:52 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB6FD20829;
        Thu, 30 Jul 2020 22:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596148072;
        bh=Oeyh74HxiGgRjXiOD6SLqRmC7a5ZmDzaNWynafKQomk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ccE/9pTaRyjTtAmFUwlMuRSB7ANa3eKAvc7DYlV88u+A7x10Nfzo5tEXoZH6hfuGV
         JvQJ/E27fcZIDVX0HQW0BMi3seBXR2mtpKhdiU3AskCSaHGQD1lzmbwreKbNPuFIKo
         82iSe4NDABQiksP+GPb2voo3/nstn4NaA5L1IC4s=
Date:   Thu, 30 Jul 2020 23:27:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Alexander.Deucher@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20200728160255.31020-2-Vishnuvardhanrao.Ravulapati@amd.com>
References: <20200728160255.31020-1-Vishnuvardhanrao.Ravulapati@amd.com> <20200728160255.31020-2-Vishnuvardhanrao.Ravulapati@amd.com>
Subject: Re: [PATCH v2 1/5] ASoC: amd: Renaming snd-soc-card structure and fields
Message-Id: <159614804535.1473.8457456333395054937.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020 21:32:51 +0530, Ravulapati Vishnu vardhan rao wrote:
> As in future our machine driver supports multiple codecs
> So changing naming convention of snd_soc_card struct and its fields.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: amd: Renaming snd-soc-card structure and fields
      commit: 9c04b5a48fca1facff07f28ba6d87de900238beb
[2/5] ASoC: amd: Passing card structure based on codec
      commit: 0fe4b561f7df6c338c6f4c95ba949fc5abe5c4e5
[3/5] ASoC: amd: Adding support for ALC1015 codec in machine driver
      commit: 414e3cab7d3e60395d23f76acdf95d5d81425b48
[4/5] ASoC: amd: Adding DAI LINK for rt1015 codec
      commit: f7b2651b96717f54d666a61aa3fa0b3d4e79d81a
[5/5] ASoC: amd: Added hw_params support for ALC1015
      commit: c3936ba9e0e4f472221320c33e20be3a8b795616

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
