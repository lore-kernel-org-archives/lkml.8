Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C412EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98E392072F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591620414;
	bh=ZlhD1tJDGs6Xuk/L72mq94VHLVq1v1h4LgiSJwwWzz4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=gGJe30U+emAK7MWm5ozPEbqnSaT818mcw60STsmquFHQw0bOca9Tti+4iPVqFKDm0
	 gB+8U1CViQh/f0D6EE7vFxy2+6JgGGuJ+PXwUT6pQtb0nsbdqXQf+jHAU8GEBZbTFJ
	 tKG4Hlz4kyKazcfkCmZvgdPL2l51WSwSZ5yAruyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgFHMqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:46:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729002AbgFHMqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:46:24 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DB862072F;
        Mon,  8 Jun 2020 12:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591620381;
        bh=ZlhD1tJDGs6Xuk/L72mq94VHLVq1v1h4LgiSJwwWzz4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=KsG2/cPFPIGxQydpcKQ5AGNfDUyyi/dcTPGvm890x/YEXcZVB6g9MQRKEYH6jr/wa
         liuQCFjZqYb96pPlFbQ0mYKCQqJPjykVyG6CiEJJETdgi3pJuHu+p1lNcJReGqFbE0
         BNIye1Qe7Pr73BymGHck5TbGYAIGzhRSteJ+284I=
Date:   Mon, 08 Jun 2020 13:46:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200607093421.22209-1-brgl@bgdev.pl>
References: <20200607093421.22209-1-brgl@bgdev.pl>
Subject: Re: [PATCH] regmap: fix the kerneldoc for regmap_test_bits()
Message-Id: <159162037977.23406.68181793825135924.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jun 2020 11:34:21 +0200, Bartosz Golaszewski wrote:
> The kerneldoc comment for regmap_test_bits() says that it returns -1 on
> regmap_read() failure. This is not true - it will propagate the error
> code returned by regmap_read(). Fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: fix the kerneldoc for regmap_test_bits()
      commit: e680a4098f6404191e0e438a9758715b0bff6d7f

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
