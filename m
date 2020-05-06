Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2817CC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E60B020936
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588782094;
	bh=6ody89kj779DuishSNc4WgF9or+Kp0PLl0WI/a3+U/A=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=I9xantV8QFbCbEj+g84OfyxMo3G8t3+mgwYgaux2l40Hwe7eqnlWnheFp8wc5alHM
	 U1+XiWf/AgzM+rmjrLOSdRtF1q0TX/4+UTzko6nBTpHEHD6EP7cwSpWoq0kQx+mGQz
	 QLU2yolcTihj/gb1pR9RG00KEBgeog4UFYVaf/is=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbgEFQVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:21:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729251AbgEFQVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:21:32 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E66FC206B9;
        Wed,  6 May 2020 16:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588782092;
        bh=6ody89kj779DuishSNc4WgF9or+Kp0PLl0WI/a3+U/A=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=RGE2eW/Cz9xWNS1o5nnQYukGWNJcSMJfUsYggG+0/vYsv6z34wu6QBkuIkz4wnCf/
         EKrJmh4wz5E6nomgBilmxcDZttODl3Qz7c7Hhd/gbhpfju9+D/v8T+D7ud9S0b4+Go
         medJkHZ+WxBZInnfINiQGI6Jmsr/53YJfggmvroU=
Date:   Wed, 06 May 2020 17:21:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, matthias.bgg@gmail.com,
        Tang Bin <tangbin@cmss.chinamobile.com>, lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org
In-Reply-To: <20200506143009.13368-1-tangbin@cmss.chinamobile.com>
References: <20200506143009.13368-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: mediatek: Fix error handling
Message-Id: <158878208991.2264.6627359892180140797.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 May 2020 22:30:09 +0800, Tang Bin wrote:
> If the function platform_get_irq() failed, the negative value
> returned will not be detected here. So fix error handling in
> mt6797_afe_pcm_dev_probe(). And when get irq failed, the function
> platform_get_irq() logs an error message, so remove redundant
> message here.
> 
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: mediatek: Fix error handling
      commit: adb69968074a22376074aaa7f7971d93636b4332

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
