Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C3BC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E4A1207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594395620;
	bh=yBGfKHJWIcCaqiK6pZXuN/WxGy9oTJD39ERpyC3HJZE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=foudOjWLvjInfVua/k1xCvlpqnbUVQVphCxxU92nA8lk7I0g8dKW1xK6Q1ZAJtZJA
	 G3fKVLLUIUkwsU1zNwHCFjz/yZs1huYZYeV0fRpcwPEnX2RogZKeB/cRiKcaOYh8VD
	 Ek9h8RHAu2azzfwWN4n8TzWQhqvaO6bHSvffzJLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgGJPkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbgGJPkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:40:18 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90A1A207DD;
        Fri, 10 Jul 2020 15:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594395618;
        bh=yBGfKHJWIcCaqiK6pZXuN/WxGy9oTJD39ERpyC3HJZE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Rh3B0AA2G23e7cN0TqDiNZ4HGpI6QrwnANwUQheACFHuf8KjlMxr0O4i2mN5/pm//
         qSCl7C95ob72boOGGaEAMR2FyvS4s23I8TtUJ7QjASt7SX4uMog+BDZDYAmj4eDDzj
         M2xJL0gFbZqD/hKdki0w60glq8BhA3fDqQ5JOXXY=
Date:   Fri, 10 Jul 2020 16:40:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        Anson Huang <Anson.Huang@nxp.com>, marex@denx.de,
        devicetree@vger.kernel.org, festevam@gmail.com
Cc:     Linux-imx@nxp.com
In-Reply-To: <1592281575-32708-1-git-send-email-Anson.Huang@nxp.com>
References: <1592281575-32708-1-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH V3 0/3] Convert mxs/imx spi/cspi/lpspi binding to json-schema
Message-Id: <159439561193.49235.7694501887022961004.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 12:26:12 +0800, Anson Huang wrote:
> This patch series converts mxs/imx spi/cspi/lpspi binding to json-schema.
> 
> In fsl-imx-cspi.yaml, also update compatible, remove obsolete properties
> "fsl,spi-num-chipselects" and update the example based on latest DT file;
> 
> In spi-fsl-lpspi.yaml, the original maintainer's email address pandy.gao@nxp.com
> is no longer valid, so I use mine.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] dt-bindings: spi: Convert mxs spi to json-schema
      commit: e013bf2d96528c382f232a6ee068990d63e81a3d
[2/3] dt-bindings: spi: Convert imx cspi to json-schema
      commit: 790739c4417c17b2201bc742a9d5d819ea71799f
[3/3] dt-bindings: spi: Convert imx lpspi to json-schema
      commit: be8faebc2e55b2e5a335b606d11d070d53e78133

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
