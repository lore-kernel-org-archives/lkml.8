Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88885C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4869D206B5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599585865;
	bh=CydX4Uf6mYj5NA3L5lJM8lBHuUJHDrjKYXI2i6uM+fA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=D3K/nSlVPBmUaWA6Ma/2BTG4kgFXu9AWTXi1QA9KX5hfGH7r2qPJLsM19OUUzND21
	 QSd5uKeLpeab7GxX4X53f6dBpXHpqPFMCGXWIEvBHUXr6d7kjXyPHq6tCCacSu9/50
	 zC1Fi5DxaLZFTdRSPp2YY52R+zdi5a+Gj8rPTXbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbgIHRYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:24:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:56906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731783AbgIHRVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:21:35 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 404B520768;
        Tue,  8 Sep 2020 17:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599585694;
        bh=CydX4Uf6mYj5NA3L5lJM8lBHuUJHDrjKYXI2i6uM+fA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=mcVDkvKtyJuAL98Ebhp9/5sJ+dgFDUg5/1tRHdl0VQUkSTFivNemF+i+m3QcLlXEu
         qJ22/E76u5+v8M7Ww/EE2F/pQiCELf5asWk9h9FwNE0+cO5ruwlpdtAkr/xsxyjsEy
         X0lic3RidTuUopbVPmUuCzIE95qPElAeHxMNrlWA=
Date:   Tue, 08 Sep 2020 18:20:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, dmurphy@ti.com,
        Camel Guo <camel.guo@axis.com>, tiwai@suse.com
Cc:     Camel Guo <camelg@axis.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel@axis.com
In-Reply-To: <20200908083521.14105-1-camel.guo@axis.com>
References: <20200908083521.14105-1-camel.guo@axis.com>
Subject: Re: [PATCH 1/2] ASoC: tlv320adcx140: Avoid accessing invalid gpio_reset
Message-Id: <159958562064.16576.7853800514030717096.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Sep 2020 10:35:20 +0200, Camel Guo wrote:
> When gpio_reset is not well defined in devicetree, the
> adcx140->gpio_reset is an error code instead of NULL. In this case,
> adcx140->gpio_reset should not be used by adcx140_reset. This commit
> sets it NULL to avoid accessing an invalid variable.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tlv320adcx140: Wake up codec before accessing register
      commit: 1a5ce48fd667128e369fdc7fb87e21539aed21b5

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
