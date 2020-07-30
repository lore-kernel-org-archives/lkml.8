Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660DAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35BB120829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596148082;
	bh=hanNiH5TZaQQDzljGBMxyRT5Fb9dhVIQP7cLm7Gn7EU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=CzL5gUdfRWHqYypheBu3Z09ON8IwkTVvFk1MVIjMZwtvQv4XtdeRHIHxqO1mc8PAV
	 uPvdcHKHGMdJTUKKusoJ6bwQtJvqAEB+16CMHBC5zJ0zz3G/2BFpugHpmDF4uty1dr
	 BakjAI1mwrPKEPENpKiNC7IRO9DJYEkkR6TQNJX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbgG3W2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:28:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728607AbgG3W2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 18:28:00 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83DED20838;
        Thu, 30 Jul 2020 22:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596148080;
        bh=hanNiH5TZaQQDzljGBMxyRT5Fb9dhVIQP7cLm7Gn7EU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=RnZjZySUVVIjDJv5WePEKMOmOPA2H4FKz7pFT/+4TTAyS3LFKfJ4Upp4oKvgG4rjZ
         Gl6JqvRW0fgW9V9HCQIqPN4U9osx66aln762v9IXGikslPyFF/N7HhhtNa6OjD68Ja
         QuMhOk5+0hgX8wD9WdaOA8SPCax8Ql5cvmgBkI8c=
Date:   Thu, 30 Jul 2020 23:27:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        Dan Murphy <dmurphy@ti.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200730142419.28205-1-dmurphy@ti.com>
References: <20200730142419.28205-1-dmurphy@ti.com>
Subject: Re: [PATCH 1/2] ASoC: tlv320adcx140: Fix GPO register start address
Message-Id: <159614804535.1473.15036781071494882878.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jul 2020 09:24:18 -0500, Dan Murphy wrote:
> The header was updated to align with the data sheet to start the GPO_CFG
> at GPO_CFG0.  The code was not updated to the change and therefore the
> GPO_CFG0 register was not written to.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: tlv320adcx140: Fix GPO register start address
      commit: 806a8afedef82c5f156b1c9b1de1205f9abfd21e
[2/2] ASoC: tlv320adcx140: Move device reset to before programming
      commit: 982f4a4134893cd48c466e7a56422d7c65837d10

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
