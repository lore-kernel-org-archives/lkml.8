Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE37C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CAAE20706
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593013137;
	bh=rBEexD3kTqqrn1V3KiC3V5YnC5CMLc93o+STib2A0o8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=MJmLnpgjU61h96UVli4khKDY/FzIi+cxtXqELGnvw/KM5JIzdcc3ylfxGd/UzUr74
	 BaK2TGixpUPMkVz6ZASSnbqolGCoLB0vPLKro7qrmFhUxXw5OGdmB8JbXA7F2JS0hW
	 xcgkGUv0ysD1VtrgvZYKAq/H7UuQTgWEEnFzY1Qs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404458AbgFXPiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:38:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404108AbgFXPiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:38:55 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 110E820773;
        Wed, 24 Jun 2020 15:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593013134;
        bh=rBEexD3kTqqrn1V3KiC3V5YnC5CMLc93o+STib2A0o8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=1Q5LTRk2uO7+yNluGySNEd2FFBod7tDPbYkFmsf1WDoyvWzSrsnwnxY5//ZTuMuZK
         MY2EcQ/Aq/YUqXfzhyYvBo69iXVjccfbY4D3LrAElkTP0ZJQKxWkPtoxmKz4Y6elEF
         x9MVRox+QPHkZAvuMEl7LZRMnT+ZZoUV6ugbVBOM=
Date:   Wed, 24 Jun 2020 16:38:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     matthias.schiffer@ew.tq-group.com, shawnguo@kernel.org,
        Robin Gong <yibin.gong@nxp.com>, s.hauer@pengutronix.de,
        robin.murphy@arm.com, festevam@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, kernel@pengutronix.de, linux-imx@nxp.com
In-Reply-To: <1592347329-28363-1-git-send-email-yibin.gong@nxp.com>
References: <1592347329-28363-1-git-send-email-yibin.gong@nxp.com>
Subject: Re: [PATCH v2 0/2] introduce fallback to pio in spi core
Message-Id: <159301312738.33627.16633087934814581680.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jun 2020 06:42:07 +0800, Robin Gong wrote:
> Introudce fallback pio way at spi core level so that the tx/rx buffer
> mapped by spi core for dma could be unmap and fallback pio again. Hence no
> need the below patch where 'dma_sync_sg_for_devic' to sync fresh data back
> into 'device' memory and sync to 'cpu' again in spi core.
> https://www.spinics.net/lists/arm-kernel/msg812236.html
> 
> If you want to use this fallback feature, please set xfer->error with
> SPI_TRANS_FAIL_NO_START in case dma transfer failed(but no any data push
> into spi bus yet) in spi client driver and add 'master->fallback' checking
> in your can_dma() to ensure spi core can fallback to pio next time.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: introduce fallback to pio
      commit: 809b1b04df898b6d182069146231a3cbf5f2d9cc
[2/2] spi: imx: add fallback feature
      commit: 7a908832ace7543ca996303928bfed7190dd2cdd

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
