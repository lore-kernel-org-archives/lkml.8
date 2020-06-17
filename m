Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF148C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B4A420882
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592400675;
	bh=Yrztuz9ss1JEyzxZFF5ooU4M0q3ngs+arYrIpm6e7Xc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=znCTIbe5oH3esmfRx3Iqh9F+owg8/cOkR5saw8p1h1UUJxbPg/ZVCmfOETpohgIDh
	 Kp+ZO85R/G3ru3kosg2hTzdkZBU4AzzIKLhc40EXTt+lPBWKv51PC9Xj5UFYXFtm6P
	 m2gc68QOHKgB+fpO380agc/8jPJgVMGqt0vvHtx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgFQNbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 09:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgFQNbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 09:31:13 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 675DF207E8;
        Wed, 17 Jun 2020 13:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592400672;
        bh=Yrztuz9ss1JEyzxZFF5ooU4M0q3ngs+arYrIpm6e7Xc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=bIqxN4xUykm3IEHS25CVNFIBUx6gWacOpy/eCd1RTBwaOXcKUG8Iz390Y6AyhfgUV
         z0aSSPKhiphwcXVXM244AQwFq51JEKjun6NumaC962lxSrcwDRgFIue2pIK+IoWBD2
         uThNmfZkWwzugDpuyCHWE3iOIh6DObfcABjIkC4c=
Date:   Wed, 17 Jun 2020 14:31:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        "patrice.chotard@st.com" <patrice.chotard@st.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, mcoquelin.stm32@gmail.com,
        linux-stm32@st-md-mailman.stormreply.com
In-Reply-To: <20200616113035.4514-1-patrice.chotard@st.com>
References: <20200616113035.4514-1-patrice.chotard@st.com>
Subject: Re: spi: stm32-qspi: Fix error path in case of -EPROBE_DEFER
Message-Id: <159240067072.19521.18133995970522150258.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 13:30:35 +0200, patrice.chotard@st.com wrote:
> In case of -EPROBE_DEFER, stm32_qspi_release() was called
> in any case which unregistered driver from pm_runtime framework
> even if it has not been registered yet to it. This leads to:
> 
> stm32-qspi 58003000.spi: can't setup spi0.0, status -13
> spi_master spi0: spi_device register error /soc/spi@58003000/mx66l51235l@0
> spi_master spi0: Failed to create SPI device for /soc/spi@58003000/mx66l51235l@0
> stm32-qspi 58003000.spi: can't setup spi0.1, status -13
> spi_master spi0: spi_device register error /soc/spi@58003000/mx66l51235l@1
> spi_master spi0: Failed to create SPI device for /soc/spi@58003000/mx66l51235l@1
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32-qspi: Fix error path in case of -EPROBE_DEFER
      commit: 35700e221b18fa53401e5f315be90af9e0bbcdca

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
