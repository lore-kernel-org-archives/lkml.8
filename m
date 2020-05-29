Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F37C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21661208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590771122;
	bh=mzOci40rtIUK9rYYmQ5uYKL6pE0DBfPl1LAF+2KhqLM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=l2klViqk5aMJnVvcVwGycKhjoGNcgPW0VWxZ4aiFWAOJVpsEvKdQO7SUfz9xerXRd
	 5llbNiWckYNNUEaWy1+ssVQJ09asBZuU4SWMCGgAWHbtJhjWBtgULIma1PLsNEDJic
	 6AkYXa1dlBzqaOLOloXRQnV3jpE5D4suU2XFMkeM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgE2QwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 12:52:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbgE2QwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 12:52:00 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E08FE2075A;
        Fri, 29 May 2020 16:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590771119;
        bh=mzOci40rtIUK9rYYmQ5uYKL6pE0DBfPl1LAF+2KhqLM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=fe2sO+uxUlnsfNzaIxufOEHLILr9p5shzvCBne9EzQSlICe6Yj5Gjpw1coOMdjG51
         PpRNx74x7Cx4URvl/UTpZwLr0Vp62SdF98BMST7t3tap9EsvFKo/zsGzzKNI9PLRqr
         SMFbTw72HQlpjpSBWgHVV78+qDJbJ6M68RA3ExE4=
Date:   Fri, 29 May 2020 17:51:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Sean Wang <sean.wang@mediatek.com>,
        John Crispin <john@phrozen.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Pedro Tsai <pedro.tsai@mediatek.com>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>
In-Reply-To: <20200528154503.26304-1-brgl@bgdev.pl>
References: <20200528154503.26304-1-brgl@bgdev.pl>
Subject: Re: [PATCH v3 0/2] regmap: provide simple bitops and use them in a driver
Message-Id: <159077110913.28779.5053923375043778782.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 17:45:01 +0200, Bartosz Golaszewski wrote:
> I noticed that oftentimes I use regmap_update_bits() for simple bit
> setting or clearing. In this case the fourth argument is superfluous as
> it's always 0 or equal to the mask argument.
> 
> This series proposes to add simple bit operations for setting, clearing
> and testing specific bits with regmap.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: provide helpers for simple bit operations
      commit: aa2ff9dbaeddabb5ad166db5f9f1a0580a8bbba8

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
