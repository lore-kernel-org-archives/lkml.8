Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6822CA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F7920714
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589301894;
	bh=1i3bwdP3qH8GL31OW8KAm4DxndksTpqoE8zFSopWcMc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=s6Y6VC0aRtB/AXBZXgNZkAfIA+W5jQvoNDBtVPbc3HlLsOIJxSFPPe3Deesxxz1WZ
	 6aUuwVToU25q2u6s94ITjkVBny7jG6b4GWczoUH39sqNsg+s4YnLXdB4/NLF5yp2vz
	 QA7IKFoNPjVVSHLBFCECtam9hJjS6g1wH1WvmQQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgELQox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 12:44:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgELQox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:44:53 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E1C7206B9;
        Tue, 12 May 2020 16:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589301893;
        bh=1i3bwdP3qH8GL31OW8KAm4DxndksTpqoE8zFSopWcMc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=il9NS0u0KRJ7JB6nZSJZQVpBrhCjjB4iLPgS02kNrFl/vf8vgOyhhL/fM/aun67xj
         XhRGlhf+Gfb60KSVuv1IJmbMrVQjE+NxI3rOgg7idnZoox3oYVPQQnERAXGvJaY71T
         FDyKObrTzmBWtg4341NJwn1a4ING2TOeAZ3I2SFE=
Date:   Tue, 12 May 2020 17:44:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200511174647.GA17318@embeddedor>
References: <20200511174647.GA17318@embeddedor>
Subject: Re: [PATCH RESEND] ASoC: Intel: Skylake: Replace zero-length array with flexible-array
Message-Id: <158930188455.55827.14390851374340231617.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 May 2020 12:46:47 -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: Intel: Skylake: Replace zero-length array with flexible-array
      commit: 936b9df7a5c00db92088b3c51316d5f551ee5b2c

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
