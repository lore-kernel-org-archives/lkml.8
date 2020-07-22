Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702FCC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 00:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CBA420792
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 00:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595379430;
	bh=koNxJKTh7G56Ng1o3vV6ECm51Ywis8J9Y2mpLAnScC0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=rtNQnmD7Jkoq6MbS/Up4lmU50FyYxyY/ciDUcP5/K0WllApcesVQ2WnuJEKIIw5+2
	 5LVHbrHw8hUTR2hmrH3UgjMct2AgPz/DRS7f0cHanCgmpipLAjmw25gJY3EJ41Vy8e
	 5l6VXBCzVxJ1I4AqqMMzNtSamKxlEsnqgi8iv/gc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbgGVA5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 20:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731561AbgGVA5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 20:57:07 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E71F92077D;
        Wed, 22 Jul 2020 00:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595379427;
        bh=koNxJKTh7G56Ng1o3vV6ECm51Ywis8J9Y2mpLAnScC0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=kSPbLo1MeunulSDuATEGZ9Rl/xynpCbOnuzduchnnmu1aFgmpoVmCDaOcg+e6MWBK
         ilxgF+sDkwH98LChixBoRvMZTWDmQkyaJ8sr6l7Swr9vd4lzvl3iLg285tewLv9lUn
         IBx7raMYhsrxp/g/IJJ2MwqUQeyPXybIutWIKnlE=
Date:   Wed, 22 Jul 2020 01:56:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     robh@kernel.org, tiwai@suse.com, perex@perex.cz,
        shifu0704@thundersoft.com, Dan Murphy <dmurphy@ti.com>,
        lgirdwood@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20200612171342.25364-1-dmurphy@ti.com>
References: <20200612171342.25364-1-dmurphy@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: tas2770: Convert tas2770 binding to yaml
Message-Id: <159537940423.49432.13949737957627950066.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jun 2020 12:13:41 -0500, Dan Murphy wrote:
> Convert the tas2770 binding to yaml format.
> Add in the reset-gpio to the binding as it is in the code but not
> documented in the binding.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] dt-bindings: tas2770: Convert tas2770 binding to yaml
      (no commit info)
[2/2] ASoC: tas2770: Fix reset gpio property name
      commit: 58b868f51d6e38146e44cb09fcd92b5fc35d83bc

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
