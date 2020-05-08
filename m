Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E61C47255
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 17:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27A5424957
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 17:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588958037;
	bh=2G7srv8QrbkntTvxqeiKKYnpK/jz7R9pDDnxxb52HGw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=O0BdU0O1GTdoLdnEX6pNSNVs2Va5fAX1d6B+nD0t/Ww3We3n6qx2n4rZxrE48vA1Z
	 JJMrnx4/ME9xRXrzd4Ty9CIGDHr9AZ4WkXe+fvo3YVvTujsNdzlUYtH8kx6Q1mrIIN
	 W/y+SlQpQWByeCTJwE4eYa+hJdr+v6mgFl4mZ+4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgEHRN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 13:13:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727980AbgEHRNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 13:13:55 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00233206D3;
        Fri,  8 May 2020 17:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588958034;
        bh=2G7srv8QrbkntTvxqeiKKYnpK/jz7R9pDDnxxb52HGw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=00z39Ig3iL+CaHgCx/kRZSYdarjnn8r9fuomdvrPbBDoP1yx0iiXsjCyz/5/227vN
         YlzXEeDn0VKNCZaGVSPZbqOFGwPOrpLSbrnMZTcMKYKhdfcPoccSFBJ6ImCdTpI1VC
         KJCRHPkGiRuLpkhfxkiGC+2nG0umx1Arz5xf1GJ4=
Date:   Fri, 08 May 2020 18:13:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mazziesaccount@gmail.com
Cc:     sre@kernel.org, linux-pm@vger.kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <cover.1588829892.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1588829892.git.matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v11 00/11] Support ROHM BD99954 charger IC
Message-Id: <158895800278.30774.16313316692034624719.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020 09:03:06 +0300, Matti Vaittinen wrote:
> Sorry folks for excessive amount of emails. I am resending this once
> more (I already resent v10 and v11 has no changes but was just rebased)
> because I am afraid the previous version did not reach Mark. If this is
> true - I am the one to blame. I see I sent original v10 to all other
> recipients and lists - except the LKML. So perhaps it evaded Mark's
> email filters. And the resend was also sent with the same message-id as
> original v10 so even though it did include the LKML it might still have
> gone unnoticed. I send this version to limited audience as it has no
> changes compared to original v10 - and it already has pretty much all
> the acks.
> 
> [...]

Applied to

   local tree regulator/for-5.7

Thanks!

[1/3] lib: add linear ranges helpers
      (no commit info)
[2/3] lib/test_linear_ranges: add a test for the 'linear_ranges'
      (no commit info)
[3/3] regulator: use linear_ranges helper
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
