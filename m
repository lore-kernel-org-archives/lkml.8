Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19607C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D35207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592264443;
	bh=UCuNGIhPR9O81kZqqZNtYkyqwE2c7AbQ3pLUmqDtC2E=;
	h=Date:From:To:In-Reply-To:References:Subject:List-ID:From;
	b=N2H5YOchYxe8XYXiIAHoYUV4rNluCe5awbDoAodkm+wyOfJwDdyPPONfHj3sB0KiL
	 pl6XapLx921yspa1x2zuROkVqYsK3HqGPq0c2TUnrPa67XFFY9hOHY0zMka2T7n6Bx
	 kj16VPln6wkdeCgougkjFRbbAaPNvcU+qD+bKJkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgFOXkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:40:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:52636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgFOXkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:40:41 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C335F20714;
        Mon, 15 Jun 2020 23:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592264441;
        bh=UCuNGIhPR9O81kZqqZNtYkyqwE2c7AbQ3pLUmqDtC2E=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=xYgDpm4b6P+rMt7X/JcKnMx4xF2685o4FLheJeZKIUN423xk0rRBcLB/yQYTxCYws
         7FQ7xREdjd6o9Kj1ORo045npGxRlwizz6Ocm5Fm1xj9svCjH205nusuzPo88uKW1i9
         ShjsauaYQRDGBK8S0B8x8UF9e7yxUV1MGLhqVnjc=
Date:   Tue, 16 Jun 2020 00:40:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, tglx@linutronix.de, perex@perex.cz,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        ckeepax@opensource.cirrus.com, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com, info@metux.net,
        devicetree@vger.kernel.org, allison@lohutok.net
In-Reply-To: <1591180013-12416-1-git-send-email-shengjiu.wang@nxp.com>
References: <1591180013-12416-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 1/2] ASoC: bindings: wm8960: Add property for headphone detection
Message-Id: <159226439190.27409.8588782902296111256.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jun 2020 18:26:52 +0800, Shengjiu Wang wrote:
> Add two properties for headphone detection.
> 
> wlf,hp-cfg: A list of headphone jack detect configuration register values
> wlf,gpio-cfg: A list of GPIO configuration register values

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: bindings: wm8960: Add property for headphone detection
      commit: 6f1519a0ff5f1281c4c4d325d6f563a3ed208f7e
[2/2] ASoC: wm8960: Support headphone jack detection function
      commit: c9015a1723373f2c8f8ac994f59470f4fb852623

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
