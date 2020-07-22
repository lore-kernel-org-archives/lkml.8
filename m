Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B244CC433F7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90EDC2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595425500;
	bh=pVSFwe9WAZVAYOyGMf4RoJKSgLIxFtnJSZePlHiqGrc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=b+4d7NScpqtQH+oIyfQGzgtJR5I78WpxbaB0j1oU45pNzp2z9+fg9i3sZ6GSqzrZW
	 Fde5e4YNSEjUbxpmhZrLOTwNt7to9ZB0e6CngttC7WoGYXfvsKjX8pav6hk673ZksV
	 mjazrw7zniE16rqidyUQkNz6EgCrcRPiZjdCTQQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732572AbgGVNo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 09:44:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732519AbgGVNo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 09:44:58 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68C3F20729;
        Wed, 22 Jul 2020 13:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595425497;
        bh=pVSFwe9WAZVAYOyGMf4RoJKSgLIxFtnJSZePlHiqGrc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=aj7wifMJfNbiBNwUUX2VmkAaWR0SwxE8gSVwzMPBjgS5ZE4GhOYPkj9XdYQb458W4
         ODeEz2ALjG7X0k65ysMGcjDZLAQLG6ZABxg5JxU8MYfDcIN6crzhCU68m9wgXhqJ/T
         02VWjAHj/4iK9Hx8i+f5FtUjURcJxAH8Nxe6AC8g=
Date:   Wed, 22 Jul 2020 14:44:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     festevam@gmail.com, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, shengjiu.wang@nxp.com
In-Reply-To: <20200720072046.8152-1-daniel.baluta@oss.nxp.com>
References: <20200720072046.8152-1-daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH 0/7] SOF IMX fixes
Message-Id: <159542547441.19620.1737685462805157717.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 10:20:39 +0300, Daniel Baluta wrote:
> This patchseries contains a couple of SOF IMX fixes
> found during our first IMX SOF release.
> 
> Daniel Baluta (7):
>   ASoC: SOF: define INFO_ flags in dsp_ops for imx8
>   ASoC: SOF: imx: Use ARRAY_SIZE instead of hardcoded value
>   ASoC: SOF: imx8: Fix ESAI DAI driver name for i.MX8/iMX8X
>   ASoC: SOF: imx8m: Fix SAI DAI driver for i.MX8M
>   ASoC: SOF: imx8: Add SAI dai driver for i.MX/i.MX8X
>   ASoC: SOF: topology: Update SAI config bclk/fsync rate
>   ASoC: SOF: pcm: Update rate/channels for SAI/ESAI DAIs
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/7] ASoC: SOF: define INFO_ flags in dsp_ops for imx8
      commit: 45b7262174dcc2ca62e23220219eee1462dcada9
[2/7] ASoC: SOF: imx: Use ARRAY_SIZE instead of hardcoded value
      commit: beaa7bd10dce348b033aff3f466ab1a78b33fed3
[3/7] ASoC: SOF: imx8: Fix ESAI DAI driver name for i.MX8/iMX8X
      commit: bcba2c9d62f391cd2cd6acb7f658d47bfb10e8b9
[4/7] ASoC: SOF: imx8m: Fix SAI DAI driver for i.MX8M
      commit: f23a8e9402f899e3555ac8aff3d3d050adafe39e
[5/7] ASoC: SOF: imx8: Add SAI dai driver for i.MX/i.MX8X
      commit: 68f56f618c3fbc4b1af0428f715f952cdada7a54
[6/7] ASoC: SOF: topology: Update SAI config bclk/fsync rate
      commit: 72bb9564fd97cd4f6dec88c8363acc3ab642673f
[7/7] ASoC: SOF: pcm: Update rate/channels for SAI/ESAI DAIs
      commit: 51b0243aefaa554ca57817562da8eb269280d4ae

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
