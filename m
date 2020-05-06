Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53526C38A2A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26CEA20936
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588776927;
	bh=isIdZF9p24otwVPsTZCE2r3D2THbHvuIvaL0GltlSnQ=;
	h=Date:From:To:In-Reply-To:References:Subject:List-ID:From;
	b=XEfrTNIKr3BKzryfTbep6jKVeelw43qtPLMrRAxWRV0D1kS8GMOQ4J5SM0X9r4Kdh
	 Ck8p6kBtfg+Ou+N7/tAtKnLTPKMTZKmyrIYd8cw5jBLMsnGDuapLxg3XWBYY6MqdmK
	 Wx0UjDHnW9COY26KjR+Qg6TVfY09WQi/AJnr1PzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbgEFOz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 10:55:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729078AbgEFOzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 10:55:24 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E8A2208D5;
        Wed,  6 May 2020 14:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588776924;
        bh=isIdZF9p24otwVPsTZCE2r3D2THbHvuIvaL0GltlSnQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=YR210sp9BEQh2sFZzNof2wGB/EXSQkTrVmU28B3+Si1/YT0FJlCS26SvhMZ/pda39
         M9OYQ+cLita8hrLJxvEYsiNRX3ey/qv6fK+g5vHlNY1M3jxZctOiFU7Yy64fcqxbM3
         +4KcobyLVRN3GRlXArVrQWMwUj1ttMdHUCVmICsY=
Date:   Wed, 06 May 2020 15:55:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Yan <yanaijie@huawei.com>
In-Reply-To: <20200506061911.19923-1-yanaijie@huawei.com>
References: <20200506061911.19923-1-yanaijie@huawei.com>
Subject: Re: [PATCH] spi: a3700: make a3700_spi_init() return void
Message-Id: <158877692139.14713.2399115526239890758.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 May 2020 14:19:11 +0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> drivers/spi/spi-armada-3700.c:283:8-11: Unneeded variable: "ret". Return
> "0" on line 315
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.8

Thanks!

[1/1] spi: a3700: make a3700_spi_init() return void
      commit: 5b684514af9052fdbaa60895620f75928a134196

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
