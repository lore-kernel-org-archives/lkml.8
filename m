Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07182C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9512206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588605816;
	bh=nYWov+IruDojufa6tepP9RWYXQOu0mwZ7m2c2jlmhqk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=n8mkXPXLNaTOchIjtIpmvJAP+tmBwLlanl5lb6BOdo0k1i4kjaFaFFtnMl+mcsAZh
	 GJLf8VWlG1NgwvHm1/NneCVDYQwNrNS8ZDOHFnYGVebDmVdNdcLQa0LFINBrXsV84S
	 vRYI3lG1+H7ZTqOAvHUptWQ6zPP57i5PlwLUZZ48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgEDPXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:23:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728621AbgEDPXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:23:35 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0AAC2054F;
        Mon,  4 May 2020 15:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588605815;
        bh=nYWov+IruDojufa6tepP9RWYXQOu0mwZ7m2c2jlmhqk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=mVm2X4nP9bnzrjt8It4H4M3nur4Pe4jBaWmJsUvL/iahO0mfIqGnTk3OOwft2oNFN
         0YEX/dlvPP4zo/TB64gtcIYKKfZiAjvmiB2Cd2zjACsrSkTthGESVO52s6Bv/ADyh3
         e4xSW8MBIP3aR816suk1N6H7i22XQzk4bCxRYsSs=
Date:   Mon, 04 May 2020 16:23:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, Tang Bin <tangbin@cmss.chinamobile.com>,
        tiwai@suse.com, bgoswami@codeaurora.org, perex@perex.cz,
        plai@codeaurora.org
Cc:     Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200504065947.12172-1-tangbin@cmss.chinamobile.com>
References: <20200504065947.12172-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: qcom: Use the defined variable to simplify code
Message-Id: <158860581280.26857.17210066344105283436.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 May 2020 14:59:47 +0800, Tang Bin wrote:
> Use the defined variable "dev" to make the code cleaner.
> 
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  sound/soc/qcom/lpass-apq8016.c |  9 ++++----
>  sound/soc/qcom/lpass-cpu.c     | 39 ++++++++++++++++------------------
>  2 files changed, 22 insertions(+), 26 deletions(-)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: qcom: Use the defined variable to simplify code
      commit: 952c0e260f8dd44ddb6ff0e260130f1906f7bcf3

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
