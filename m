Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93170C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C9EB21527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592411750;
	bh=KsOzPr2BKHtev42Ot9U8rSfD+Tz9IgpBEpcHiLowtOY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=wO+L0HTvk76tZLSREwWD84zqBGcVr4dMcf9/XhtJV4UGhkNInG5ghfsONnw1wF3Ye
	 AjHId0fhqVzKW+pPDFuiEJOkoLAO6bVRhIe7Bc/yQQmUwOHsfIhdutGLkaXIlGpxYC
	 FOjKikqXAQg/uUVNlWP27C74+MvFLnShOg1E8/wA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgFQQft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:35:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbgFQQfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:35:45 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCBCE21527;
        Wed, 17 Jun 2020 16:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592411745;
        bh=KsOzPr2BKHtev42Ot9U8rSfD+Tz9IgpBEpcHiLowtOY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=YSuMA0oTL7EC7wfSuOaYD8yJ+6mpmEwiRRDh1Rdz+c2tbGh2F/wk2+keg+gv0N+h2
         kHehOrbhRtVM2BUEBbRAnuHFlgjJIh0AoYs0EQDGNXOI8B/7uI7Ctf/0hPvwVBG4ER
         BP3ywuIpx0AR41z80L0VVaZ/PnyPQCeeUfiXKMkw=
Date:   Wed, 17 Jun 2020 17:35:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
In-Reply-To: <20200617152129.19655-1-ckeepax@opensource.cirrus.com>
References: <20200617152129.19655-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] regmap: Fix memory leak from regmap_register_patch
Message-Id: <159241174305.13689.2474185985692181953.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jun 2020 16:21:29 +0100, Charles Keepax wrote:
> When a register patch is registered the reg_sequence is copied but the
> memory allocated is never freed. Add a kfree in regmap_exit to clean it
> up.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: Fix memory leak from regmap_register_patch
      commit: 95b2c3ec4cb1689db2389c251d39f64490ba641c

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
