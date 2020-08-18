Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD0AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E587A20738
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597772403;
	bh=jw0rqgoKOxJjeFzL3PLrNSOLSmVzOndyFsCJBt1RmBE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=EYK1ZW93zbmRIvdHZhkLb9SoZ69ON1P5bKSAadPWIAAfj47Mb4Y/Cw9IapLQKSKcC
	 qU0H2kOulvzOKt2fsytrGnyBvDkSuGx9LRNx5Enj5MNzhk1Is1eKjCG28QBGsOpEv0
	 m+rrFONoOE+afTw2dwDkdmHkAC85GT8fpnHguYWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgHRRkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:40:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgHRRj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:39:58 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ED2D20738;
        Tue, 18 Aug 2020 17:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597772397;
        bh=jw0rqgoKOxJjeFzL3PLrNSOLSmVzOndyFsCJBt1RmBE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=JITDFbdXUSdL3CAO6S6oBsDueJ6T92UpvF2cvgIOiROsih1Att03rFWG8fDHlw8Kr
         5gt3MWB6+E0LwEoKV+J6QXsnwHozg+mfEoWWSvEb1Q5SEj1klVTkoZKaAbgD8OMGnD
         3qc8wxSPdiMVAh95d49Qx9j8IJ2vMKLzaQUYDKLo=
Date:   Tue, 18 Aug 2020 18:39:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     heiko@sntech.de, Johan Jonker <jbx6244@gmail.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        sugar.zhang@rock-chips.com, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org
In-Reply-To: <20200818143727.5882-1-jbx6244@gmail.com>
References: <20200818143727.5882-1-jbx6244@gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: rockchip-spdif: add description for rk3308
Message-Id: <159777235702.24785.2371871958311959848.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020 16:37:26 +0200, Johan Jonker wrote:
> A test with the command below shows that the compatible string
> 
> "rockchip,rk3308-spdif", "rockchip,rk3328-spdif"
> 
> is already in use, but is not added to a document.
> The current fallback string "rockchip,rk3328-spdif" points to a data
> set enum RK_SPDIF_RK3366 in rockchip_spdif.c that is not used both
> in the mainline as in the manufacturer kernel.
> (Of the enum only RK_SPDIF_RK3288 is used.)
> So if the properties don't change we might as well use the first SoC
> in line as fallback string and add the description for rk3308 as:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rockchip-spdif: add description for rk3308
      commit: a8535ae7034e3547f4f7a8c7ca03a6ee72097fb0

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
