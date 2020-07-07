Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F607C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FC5920771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594131473;
	bh=pve5QprljZ4UYpaZLR9H+cQw5sf2yLulSSnup7LqVq4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=kbfD0dsi47v4RxLXGo1l8IBf0DH7KIgUf0JeOB/8HoImT4IVD+RlPRg4acf7sRWH/
	 cqR3DEc4KpGecyZe6/h3XwXz5QXLJwdlOBxPFCJ6931dL+Dna/B0F1qQk5NUkKtytq
	 mdshmhfLqjLoBMzpSVyyUrmWptvablQtMXP4aZ34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgGGORw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:17:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbgGGORw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:17:52 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04C1520771;
        Tue,  7 Jul 2020 14:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594131471;
        bh=pve5QprljZ4UYpaZLR9H+cQw5sf2yLulSSnup7LqVq4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=v94pGfnpkt+1iWcdy7HEv8hILl70AgmCSFhrQtwKguzL7jcIqUIL5Y6IUkBPwejWt
         ScKC/u6TYYhseFcnsSnNWy/VvkjLp8lFP7ZEqgih4agghenABndSt+oiIfl5UdsxOR
         oX4gKT6hXJWiridoPY47IYULindd3ubEA0aZ/jh8=
Date:   Tue, 07 Jul 2020 15:17:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-spi@vger.kernel.org, ctheegal@codeaurora.org,
        akashast@codeaurora.org, mkshah@codeaurora.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        georgi.djakov@linaro.org, swboyd@chromium.org,
        linux-arm-msm@vger.kernel.org
In-Reply-To: <20200702004509.2333554-1-dianders@chromium.org>
References: <20200702004509.2333554-1-dianders@chromium.org>
Subject: Re: [PATCH 0/3] spi: spi-geni-qcom: Avoid a bunch of per-transfer overhead
Message-Id: <159413146696.34997.14314538342841889757.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jul 2020 17:45:06 -0700, Douglas Anderson wrote:
> This series tries to reduce a whole bunch of overhead in each SPI
> transfer.  Much of this overhead is new with the recent interconnect
> changes, but even without those changes we still had some overhead
> that we could avoid.  Let's avoid all of it.
> 
> These changes are atop the Qualcomm tree to avoid merge conflicts.  If
> they look good, the most expedient way to land them is probably to get
> Ack's from Mark and land then via the Qualcomm tree.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: spi-geni-qcom: Avoid clock setting if not needed
      (no commit info)
[2/3] spi: spi-geni-qcom: Set an autosuspend delay of 250 ms
      commit: e99f0b6ef2679b0abeefcd7bd148cd65651c7857
[3/3] spi: spi-geni-qcom: Get rid of most overhead in prepare_message()
      (no commit info)

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
