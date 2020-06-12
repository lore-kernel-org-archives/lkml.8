Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2C9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1D4520835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591970364;
	bh=/paGLZXjNZwv4cu9NeQZJYmkh1IILKin50L8Gsjh0Mw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=0yQh+hIIbjKeP7LA2oeHgUP99vqQO84pb0wmSYMnpiT2WqDoXEv46xBzqudJLZhs1
	 oD3NCLOMCpVp+29D9x8AYbYyREv+cIh1sLW/AZNyvPSlq4ocb64hAfqlwAjx4NPtfr
	 sMdp+5RMqzQd0wk4/St+cKe5BqmiBOhNVoRfeBuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgFLN7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:59:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgFLN7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:59:11 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21FA920792;
        Fri, 12 Jun 2020 13:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591970350;
        bh=/paGLZXjNZwv4cu9NeQZJYmkh1IILKin50L8Gsjh0Mw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=oDVRGzMWXpZPgmjD/xkWZQnmgGBe2dS32b9buloWTVHA9xcrd97jxZ3rIGFAA75GB
         c9fXxXJy71M6OQmbyZH8p8vU2uj075ZjE5YI2Vdk8vvlFSv8zmrum0HSfOnC5K45a1
         cA7FzxtF3NQcYHg+QXy7BDdaxi7nma4mSbMESFS8=
Date:   Fri, 12 Jun 2020 14:59:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     mazziesaccount@gmail.com,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20200612090225.GA3243@localhost.localdomain>
References: <20200612090225.GA3243@localhost.localdomain>
Subject: Re: [PATCH] regulator: Fix pickable ranges mapping
Message-Id: <159197034771.51045.2520556217003939769.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jun 2020 12:23:17 +0300, Matti Vaittinen wrote:
> Pickable ranges mapping function never used range min selector. Thus
> existing drivers broke when proper linear_ranges functionality was taken
> in use. Fix this for now just by ignoring the minimum selector.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Fix pickable ranges mapping
      commit: 92919679d31721381e3c376488477efe49b915f3

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
