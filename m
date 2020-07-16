Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3806C433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F86720899
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594943917;
	bh=zUuaz9UiQ+5YHXpDQYJCKwgXocg46f7UQZ3Q9h4mnY0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=rmm9IMyWLquLJv0xDwKRDchy45oueVwYVGjNPrE9bUQzwSqx6UcDwlzVVvndiYknX
	 /9n68rr695wfaruWtsR19MMySQz99gscTgeC6nbXjYFP86VmmFtSAT11MEPd2g09q0
	 wJSOjqAuQXbWNbCX5yWOc/V6kFnwBeG20hcgWzRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgGPX6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:58:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgGPX6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:58:35 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F027020760;
        Thu, 16 Jul 2020 23:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594943915;
        bh=zUuaz9UiQ+5YHXpDQYJCKwgXocg46f7UQZ3Q9h4mnY0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Sd1/CVDfTymjIA1yqV5kRac6lILU2K6GspDk5BzjzXyYndM0G9cHa/k1Q1FEYoYP/
         UTa47S0yWQEdILX5l1H5Do/RqgD28aYsUDMUGou6TzZQ0ULAh2/KN2ICm2Rc7YGfLc
         XlHOCXYMu6ThHUlR9IKBkKbi6IpFSL/9qSq2TMp0=
Date:   Fri, 17 Jul 2020 00:58:25 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        ludovic.desroches@microchip.com, alexandre.belloni@bootlin.com
In-Reply-To: <20200716043139.565734-1-tudor.ambarus@microchip.com>
References: <20200716043139.565734-1-tudor.ambarus@microchip.com>
Subject: Re: [PATCH] spi: atmel-quadspi: Use optimezed memcpy_fromio()/memcpy_toio()
Message-Id: <159494389042.42455.16402064061390482292.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jul 2020 07:31:39 +0300, Tudor Ambarus wrote:
> Optimezed mem*io operations are defined for LE platforms, use them.
> 
> The ARM and !ARCH_EBSA110 dependencies for COMPILE_TEST were added
> only for the _memcpy_fromio()/_memcpy_toio() functions. Drop these
> dependencies.
> 
> Tested unaligned accesses on both sama5d2 and sam9x60 QSPI controllers
> using SPI NOR flashes, everything works ok. The following performance
> improvement can be seen when running mtd_speedtest:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atmel-quadspi: Use optimezed memcpy_fromio()/memcpy_toio()
      commit: b780c3f38812bce7d7baebe2108738a043d6c4c3

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
