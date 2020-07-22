Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D88DC433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 00:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8510208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 00:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595379435;
	bh=ixbCeX47fIGI9Saa2Wc+hbWi7zHZVD3equCOUqRHMbI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=tynwpsYQA/JGwMW62zCHcI/cCWtuQLcTlcImttu2eY8xkjC8XQnisPaSH6G5c8ABg
	 V9G3LaH+El3QnEOPLA/6uN8N+5i0knigm/Cu71S2UvsI9AgGKXC+P08rwywKeMk6Te
	 qj1W7AJmj2P1o++kEmPtbfPuArHjOBJSGHqfjDYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbgGVA5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 20:57:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731561AbgGVA5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 20:57:12 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F243D20792;
        Wed, 22 Jul 2020 00:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595379432;
        bh=ixbCeX47fIGI9Saa2Wc+hbWi7zHZVD3equCOUqRHMbI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=IejbyqoiNK7Luy4TAyeeNNy7rPXl8xiL0ZdWgT1hijD3gJTwstjjH5P78lak6wDZS
         Fu8wufz5ryTGUOOyWf9zraOO3TI2ICHYjVQmflFC/uvRmll/wyjDaEdiZvPvIGcC93
         xQD4+WuhqBY2X0HBtP8FRpD1LiQFMe8u1GZJhpVI=
Date:   Wed, 22 Jul 2020 01:56:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, perex@perex.cz, Dan Murphy <dmurphy@ti.com>,
        lgirdwood@gmail.com
Cc:     alsa-devel@alsa-project.org, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20200720181202.31000-1-dmurphy@ti.com>
References: <20200720181202.31000-1-dmurphy@ti.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: tas2770: Convert tas2770 binding to yaml
Message-Id: <159537940424.49432.10532525399520468723.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 13:12:01 -0500, Dan Murphy wrote:
> Convert the tas2770 binding to yaml format.
> Add in the reset-gpio to the binding as it is in the code but not
> documented in the binding.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: tas2770: Convert tas2770 binding to yaml
      commit: ad0ddbb9ba3d5216bf3035db6684c1507c90b93b
[2/2] ASoC: tas2770: Fix reset gpio property name
      commit: 58b868f51d6e38146e44cb09fcd92b5fc35d83bc

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
