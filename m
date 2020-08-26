Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E96C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F14B32080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598446613;
	bh=lof5WMJd2SD3b9kftLog8IIHEfylBdQfeE4ha9mqSAo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=MzfNYRTt4YH929+KotTrllztk0UfiwR1dhozkvFLE4MhXPryuQHQ/DFAGOzReXkPT
	 mrzwpdGfR6DNkk/gp5Xp5dN0Xc8rQkz+ItiUgTukXyVwWgdC/aCXc5sGFZDcZmKva5
	 KWWVEF1j1YIY1BIfTmXYKiSJhjljdZr/6VJDIN04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbgHZM4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:56:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729588AbgHZM4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:56:36 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 738AB20B1F;
        Wed, 26 Aug 2020 12:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598446596;
        bh=lof5WMJd2SD3b9kftLog8IIHEfylBdQfeE4ha9mqSAo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=BRNO5cOWHM0Njv6O9w51yVtTEFZvsoEl3ZjZXW9pxDChZ6/+NvTVq0O5vsD0KTdz0
         1NfT1accHfptuB3CFsUuJATPeoupIfYmHfOMqwfeeYxJ1rGmsOe4BfLJQ+EYPA8Ayf
         4lEXoIIOiQKKBnS5cIg73MSh3KwlfEsW8zp0SBRU=
Date:   Wed, 26 Aug 2020 13:55:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, Gene Chen <gene.chen.richtek@gmail.com>,
        matthias.bgg@gmail.com
Cc:     linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
In-Reply-To: <1597910022-22617-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1597910022-22617-1-git-send-email-gene.chen.richtek@gmail.com>
Subject: Re: [PATCH v3 0/2] regulator: mt6360: Add support for MT6360 regulator
Message-Id: <159844655479.37260.15995868190523968540.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 15:53:40 +0800, Gene Chen wrote:
> This patch series add MT6360 regulator support contains driver and binding document
> 
> Gene Chen (2)
>   regulator: mt6360: Add support for MT6360 regulator
>   regulator: mt6360: Add DT binding documentation
> 
>  Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml |  109 ++
>  drivers/regulator/Kconfig                                         |    9
>  drivers/regulator/Makefile                                        |    1
>  drivers/regulator/mt6360-regulator.c                              |  458 ++++++++++
>  include/dt-bindings/regulator/mediatek,mt6360-regulator.h         |   16
>  5 files changed, 593 insertions(+)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: mt6360: Add support for MT6360 regulator
      commit: d321571d5e4c2d5511b75e6cf1a910e0a0c2a2e9
[2/2] regulator: mt6360: Add DT binding documentation
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
