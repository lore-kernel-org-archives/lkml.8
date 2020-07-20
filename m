Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75687C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51EC222CB2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595255933;
	bh=+auK55a4lJcssKkr7Cej4IkQyyeqOsJrBcmvKvm9b2M=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=B3m+D1MlVx9pQRNugZ95xuXudez8woM/iCJ+1AS+b3k/2bAVJBdZ+fC4w6925Xd7L
	 pcWt03NYFWtNBWIABrxi9Q4I/e/QeFcxjVdG/7vsrUqHeXa86z6EpTTNhptULOAmKU
	 X/9irz1XcGg2k1EZmcFbcezR1TtJ2jYKyGd+D4yg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgGTOiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:38:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:32964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTOiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:38:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 094DE22B4D;
        Mon, 20 Jul 2020 14:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595255931;
        bh=+auK55a4lJcssKkr7Cej4IkQyyeqOsJrBcmvKvm9b2M=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=djWD4X4Lcf415yldlZd+jRvzOVMBSvuXUMPmz7QKB4+OdKYT2tTvgTyT/Op9SM/qB
         4zVGFRCxneiDRsodjXiqU21i23Yz27pU+LkJa3x/H5gov5QpmAycTYG1hVe3t8bRae
         ONCNYfColjJ4PrOpldU9g6tpwEjnfz56ZrXjdfF8=
Date:   Mon, 20 Jul 2020 15:38:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20200717215500.GA13910@embeddedor>
References: <20200717215500.GA13910@embeddedor>
Subject: Re: [PATCH][next] ASoC: Intel: Skylake: Avoid the use of one-element array
Message-Id: <159525589434.6792.8045971060889896063.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020 16:55:00 -0500, Gustavo A. R. Silva wrote:
> One-element arrays are being deprecated[1]. Replace the one-element
> array with a simple value type 'u8 reserved'[2], once it seems this
> is just a placeholder for alignment.
> 
> [1] https://github.com/KSPP/linux/issues/79
> [2] https://github.com/KSPP/linux/issues/86

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: Skylake: Avoid the use of one-element array
      commit: 23f8d964f15a21991a166f0d1a7cf3cf8e4bfc9b

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
