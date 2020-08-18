Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B15C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80C1E207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597769938;
	bh=k3QM3tL7QIkWGlgH9bNck/rLCTsVvUQC5OXfv05XMqk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=nfvdYv2FaXwWCC2DxmCMSw0TFEY9vkrHsWOD0yQsyu6G9uSii4uBqgUa+LNxpnujE
	 92nzcVYSadrB9bg7844/zfkmj3Icw+It4ht+oTkyZYoiwD6/mPQgY8Q886IEjoFcJA
	 +17MGNNwl73eVUMaBTqO1B+48RMrrFV6dy1TKFcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgHRQ65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:58:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728586AbgHRQ5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:57:41 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D717020786;
        Tue, 18 Aug 2020 16:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597769861;
        bh=k3QM3tL7QIkWGlgH9bNck/rLCTsVvUQC5OXfv05XMqk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=gfRzH3byQqxZ4MK7/S26FIIvrdGEPdegRQLaLMrRdl273my/WhO6pxqHwaxW2YkYo
         OL/fnbEoiww9U2DR/xJFSoiwpB6XpzXgiZuMuRDlfnUyDbhVj6MJ05Cfclbly/woKL
         mXcHlEPyB2/2SB3lyTkCd6otIQsNSghuazyuUN9M=
Date:   Tue, 18 Aug 2020 17:57:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200802175007.703995-1-christophe.jaillet@wanadoo.fr>
References: <20200802175007.703995-1-christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] spi: a3700: Remove a useless memset
Message-Id: <159776983046.56565.184336045961597730.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Aug 2020 19:50:07 +0200, Christophe JAILLET wrote:
> Memory allocated by 'spi_alloc_master()' is already zeroed.
> Remove a redundant memset.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: a3700: Remove a useless memset
      commit: 2494174e04e7f4e58d1363adb13c0ae23b64d37c

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
