Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE95C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29F98207EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599213870;
	bh=KA8LW7OmlzmLuUoHRv+s+AdmVu8ZMwzNtfZQyvHEiZ8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=kdUghyOJRX/Ke/9kDWKO4cIUi+VPqpX3h8AuxDwxbfKRH3b5uqgkz8gbZ2mMKkcQA
	 ocmY8SzqWE5s+/1DJA6OHayBFsORKUcruHtDtmBJsy6iZzSx/gu40m5o7o9QSoxbpb
	 3eZHXS4eJJcV6TKMrH/dVdaL8/2zY+pnyapi8ZiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbgIDKE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:04:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgIDKEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:04:24 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 817E320791;
        Fri,  4 Sep 2020 10:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599213864;
        bh=KA8LW7OmlzmLuUoHRv+s+AdmVu8ZMwzNtfZQyvHEiZ8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=jZCJkTkSYk/8/vG/dVhc8ZrWVZV18s6iyb/jSsvK0G/8+7Bs5Xo+6pdlvtXoH4dc5
         +9gsLqx+cImtzKcuz6lBYxDHP/XdceWFEF7FCJyUmbhtS4z3N5zxRlgKo2am6SiHYD
         iONXVuEs1KDl4sgZUq7vRkGhjtdA+LIWU4VUYd+o=
Date:   Fri, 04 Sep 2020 11:03:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mazziesaccount@gmail.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-power@fi.rohmeurope.com
In-Reply-To: <cover.1599029334.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1599029334.git.matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH 0/4] Support regulator ON/OFF by PMIC state machine.
Message-Id: <159921382244.42249.7240077218868198055.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Sep 2020 21:37:51 +0300, Matti Vaittinen wrote:
> Support regulator enable/disable via BD718(37/47/50) PMIC state machine.
> 
> The ROHM BD718(37/47/50) PMICs are mainly used for powering i.MX8 based
> systems. On some setups the i.MX8 SoC uses a IO line to suspend the
> system. These PMICs support this via PMIC internal HW state machine
> which can be toggled for example by the PMIC_STBY_REQ IO-pin.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/4] regulator: bd718x7 initialize regulator config only once
      commit: df9db2541a82ec18c474942a93729420d37fac81
[2/4] regulator: bd71837: add property for omitting ON/OFF control
      commit: 4788c692bec76dc33c646a07a4aaf7e2dd60091e
[3/4] regulator: bd71847: add property for omitting ON/OFF control
      commit: 6656d4462c7ac5ca0bc5d5a8a91a8c98f0fd1409
[4/4] regulator: bd718x7 fix regulator states at SUSPEND
      commit: 1d848d681c4d4e148193b699a6e5f222e8621519

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
