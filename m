Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEFEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F6BC208C7
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593795870;
	bh=jFYeb20LhmdHTlXpr2EpdLAiiLFCeRDiaHW9R0RWB5c=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=ABqCdcaYXIWYDvWzh8dV+YGQSmMamlVXqLY5UIgyZtneOJEBVO1McjYteIU3T/4d4
	 OHwSkgaG8W3n4uviTjOrncdg+NkxDs9sUq3KRzCTMSPEIDL+x6zZQOnq65gvDhc/rN
	 T35m2CaTyCUa23xIy0XFX0A/+okP6b4f+Pf+Byvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgGCRE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:04:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgGCRE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:04:28 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC069208C7;
        Fri,  3 Jul 2020 17:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593795868;
        bh=jFYeb20LhmdHTlXpr2EpdLAiiLFCeRDiaHW9R0RWB5c=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Sr6VFQNBO1Zx0IKJ4gv+qzEGpP/wQNpf3CZjf4UgOyWXLLc8fEh6YdEzc0bsBacHd
         nVL2KcxDh7S5+aF//GeykjaRLweg+8OiaK1EqEMhWuVtfP3F+e1TnRIU4IujgUyCH/
         DpeWkuj8hcWi44L8BtfAzBSTup30gFNV0k0xumKU=
Date:   Fri, 03 Jul 2020 18:04:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christoph Fritz <chf.fritz@googlemail.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
In-Reply-To: <20200702210846.31659-1-chf.fritz@googlemail.com>
References: <20200702210846.31659-1-chf.fritz@googlemail.com>
Subject: Re: [PATCH v2 0/2] regulator: Add FAN53880 support
Message-Id: <159379586604.55985.7900728432610745163.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jul 2020 23:08:44 +0200, Christoph Fritz wrote:
> This patchset adds a regulator driver with dt-bindings documentation in
> the new yaml format for a power management IC from Fairchild (now ON
> Semiconductor) named FAN53880.
> 
> The chip was found on a camera sensor board which will get a v4lsubdev
> driver in the future.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: fan53880: Add initial support
      commit: e6dea51e2d41679d37a81d0b1247c039092af46b
[2/2] dt-bindings: regulator: Document bindings for fan53880
      commit: 643ddb618a5fd1819e790e86be85ae50c2c4abc4

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
