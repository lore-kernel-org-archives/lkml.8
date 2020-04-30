Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD250C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F3AD2074A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588256592;
	bh=1HClZEGzBCelyiF4UCiysAh2V+7CymCp62XvWZhTejI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=lzrF+zRAfWM8ZFZ4JFSNUqdhLhrrAXnIxo6eSZu9LJtXthdnns0Oe2a6NdvsFZaD0
	 h2XhP5t/VhgsnTRWQqnzRw25ms9Q17Mu6R3OAOEnOIHUtxS9m2cb6sGtAZIvla8v5c
	 obtsrkMxiOUnBGp+ebyRO9VA9qydUDtDcC2TaO/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgD3OXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:23:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbgD3OXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:23:11 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A289206D9;
        Thu, 30 Apr 2020 14:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588256590;
        bh=1HClZEGzBCelyiF4UCiysAh2V+7CymCp62XvWZhTejI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=gedCp9tmqY8eh7DVTv182Mud5AMXOiuPAW8Yo6T1q3Y5+WRDBu6B9FdBZDuelhaWP
         asHr4ZM5RPtdZFDgDTZNRgo0gpf1idsZzfHbO0w159eSWZj78wWU3gmWNMR0hk8jkJ
         A7VJm9RD2RkCR4KOC1LcL3lbIhxLfYu59uCBLEEY=
Date:   Thu, 30 Apr 2020 15:23:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Haojian Zhuang <haojian.zhuang@gmail.com>,
        Shobhit Srivastava <shobhit.srivastava@intel.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Mack <daniel@zonque.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20200427163238.1.Ib1faaabe236e37ea73be9b8dcc6aa034cb3c8804@changeid>
References: <20200427163238.1.Ib1faaabe236e37ea73be9b8dcc6aa034cb3c8804@changeid>
Subject: Re: [PATCH] spi: pxa2xx: Apply CS clk quirk to BXT
Message-Id: <158825658830.42351.13459280823066625982.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020 16:32:48 -0700, Evan Green wrote:
> With a couple allies at Intel, and much badgering, I got confirmation
> from Intel that at least BXT suffers from the same SPI chip-select
> issue as Cannonlake (and beyond). The issue being that after going
> through runtime suspend/resume, toggling the chip-select line without
> also sending data does nothing.
> 
> Add the quirk to BXT to briefly toggle dynamic clock gating off and
> on, forcing the fabric to wake up enough to notice the CS register
> change.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.8

Thanks!

[1/1] spi: pxa2xx: Apply CS clk quirk to BXT
      commit: 6eefaee4f2d366a389da0eb95e524ba82bf358c4

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
