Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9717BC54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 659002075E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589279303;
	bh=zpiNmb4UCtavZMNo6BKDHyMlep5F58zW98wc3jsNU58=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=Twl4xlmz68dlMGZA+EEi3EeXDYR94wOBQPYLOjit9b9xBGwybwT/K1rKorQiKj0Ys
	 pIdnfqJ4edD3zvTPkIUboi2x1RlSfXBpNGA5/VtBVeKXwIaygGqdBdsgf8xrwlHU9/
	 LId86P1E1utsUnb7Zz9bwpp1I924q+I+1CuAF+gY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgELK2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 06:28:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728416AbgELK2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 06:28:22 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36D03206A3;
        Tue, 12 May 2020 10:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589279301;
        bh=zpiNmb4UCtavZMNo6BKDHyMlep5F58zW98wc3jsNU58=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ihzpMPLAN81AlB25/9+LOE8ebLXxL9p8Pg4XBABQl/FDbwirChiSg0NqiDbyUICtM
         CGM3YqXUwIwt0UNR/9lK5dRG+l4pBg5YaLuyq113Cjw8m0Y1V1cZAX+J0g7yVWJ43j
         y8SHmOZ37Vf+QufDa9IByqy9+ylQ/+DwQk6gn05c=
Date:   Tue, 12 May 2020 11:28:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
In-Reply-To: <1587720562-15293-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1587720562-15293-1-git-send-email-hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH v2] dt-bindings: spi: Convert UniPhier SPI controller to json-schema
Message-Id: <158927929911.28665.8593031021251686663.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020 18:29:22 +0900, Kunihiko Hayashi wrote:
> Convert UniPhier SPI controller binding to DT schema format.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.8

Thanks!

[1/1] spi: Convert UniPhier SPI controller to json-schema
      commit: 5483ef03e075c1625c66ba728b55ef67f7cb3ed1

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
