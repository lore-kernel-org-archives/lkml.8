Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92247C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FB9820773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593013132;
	bh=wZJ1/+acFpJabks7yCB6ctOsug0yieFf7S7HuybhsRo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=RuY/BDNQ2H6HRGu2eHaS1IAVm+OjAunfAn+qQmKksHDDhee7cFyICDKmV8YPk22Yy
	 kVJmAha1hzNTqC3owAA10KwTJs9OzRq6eGtCqnYJkuY8/teoouy+yBybrjojfRXgSX
	 PaYPj0Li9FAolMb9hnHQR9sNbz6I90cbHX7Ucguk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404427AbgFXPiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:38:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390702AbgFXPit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:38:49 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F5202076E;
        Wed, 24 Jun 2020 15:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593013129;
        bh=wZJ1/+acFpJabks7yCB6ctOsug0yieFf7S7HuybhsRo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=vICosB4at+4m6aITuoo0w40lfyEodCZFgND/yRbq36arOa/j0DxEqzyx3vSYuWGHM
         bsGYxzzFBZ7igZgHpP9rSKTyrTpV8bLkBRzgklcZwO66SQGn4Iw/So0dKroVdb5IO8
         vGmk9ejgqG7CDYz0WHEWIdCEd9+5puDyszEZtfxE=
Date:   Wed, 24 Jun 2020 16:38:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        linux-spi@vger.kernel.org
Cc:     trix@redhat.com, russell.h.weight@intel.com, hao.wu@intel.com,
        matthew.gerlach@linux.intel.com
In-Reply-To: <1592962286-25752-1-git-send-email-yilun.xu@intel.com>
References: <1592962286-25752-1-git-send-email-yilun.xu@intel.com>
Subject: Re: [PATCH 0/2] Some fixes for spi-altera
Message-Id: <159301312738.33627.5358287024947647572.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020 09:31:24 +0800, Xu Yilun wrote:
> Two fixes for indirect access support patchset.
> 
> Xu Yilun (2):
>   spi: altera: fix driver matching failure of the device ID "spi_altera"
>   spi: altera: fix module autoload
> 
>  drivers/spi/spi-altera.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: altera: fix driver matching failure of the device ID "spi_altera"
      commit: de5fd9cb6a3f89a1ac8f27883d029f823112243f
[2/2] spi: altera: fix module autoload
      commit: 1ac6f21a948b45a49737a5eff6b4dae9f37a8dc0

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
