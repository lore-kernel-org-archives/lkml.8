Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953D7C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6438F206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598971916;
	bh=O1Qz4ZXdiSaMhdkg5TpGlUwTcP3HAsCwly/VMEgw7ew=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=DDCo/6P+X5HxIvCc79C5ceFdvbigH+yJ+adUhjiLmwMOp3UTrdzkIvrfYQsFp34JY
	 fuzww1+z4JxLUue09yGAlN44uuHmrOOsg/eeJAbaXHGFg255+B68uV9+nvlKxiXmNK
	 QfAMtYIIt/P92TA8iPwfHzMxrHqVkIyIGqftf6sE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgIAOu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:50:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728696AbgIAOuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:50:35 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39BE3208CA;
        Tue,  1 Sep 2020 14:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598971834;
        bh=O1Qz4ZXdiSaMhdkg5TpGlUwTcP3HAsCwly/VMEgw7ew=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=JNxv2gi5h2pJ4LyuMGOS3XexhJ1U1bx0g0nYlodhdK7d4MKxAJXnlWuKy2rwWZr/2
         JeyCYsFx2NMzZVRzUNT3Sas8HmqL4kuekDflfnj64gSMpRqNzN0QNoQD360x+TZEvS
         0hLvK7uJnHp/C4HFcC9FB6HH9Nl8vBbFCNwgzm8s=
Date:   Tue, 01 Sep 2020 15:49:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>, lgirdwood@gmail.com
Cc:     patches@opensource.cirrus.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com
In-Reply-To: <20200827173357.31891-1-s.nawrocki@samsung.com>
References: <CGME20200827173411eucas1p1283200677c5e077c5e07af938934eb5d@eucas1p1.samsung.com> <20200827173357.31891-1-s.nawrocki@samsung.com>
Subject: Re: [PATCH 1/2] ASoC: wm8994: Skip setting of the WM8994_MICBIAS register for WM1811
Message-Id: <159897179514.47719.11338166675649379991.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Aug 2020 19:33:56 +0200, Sylwester Nawrocki wrote:
> The WM8994_MICBIAS register is not available in the WM1811 CODEC so skip
> initialization of that register for that device.
> This suppresses an error during boot:
> "wm8994-codec: ASoC: error at snd_soc_component_update_bits on wm8994-codec"

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: wm8994: Skip setting of the WM8994_MICBIAS register for WM1811
      commit: 811c5494436789e7149487c06e0602b507ce274b
[2/2] ASoC: wm8994: Ensure the device is resumed in wm89xx_mic_detect functions
      commit: f5a2cda4f1db89776b64c4f0f2c2ac609527ac70

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
