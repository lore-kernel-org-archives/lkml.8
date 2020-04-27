Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6D7C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D1AC2076B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587992973;
	bh=oLAkO5I8sHm5bFau0W6wglLolrcnVrPC69eOGnt+QRI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=XIhUTSPGXUg5VMbB0IeVlSqNf1rEuOJ6Tl8Cwir+2r5iEKcP6RPDJcrVqJ4E2vj+R
	 5rgLnWjRW/qzu7/m4ZlHWAPViK1j2zdWBH0WYLLKW6cNixBBiFFLQpznh+vcEcDDPs
	 ktrY7amISJOUSeevYudMfNCH5wKcbOfZ9+yZLsd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgD0NJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 09:09:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgD0NJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 09:09:31 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C8B92076A;
        Mon, 27 Apr 2020 13:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587992971;
        bh=oLAkO5I8sHm5bFau0W6wglLolrcnVrPC69eOGnt+QRI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=q8QVKDZ2XFWhQVe8XrBElgPdWbNSB/mPsB/EtEAY/fsNZUWHkGoSwNxNgCpFdzXuX
         A77egwRNVRGTk6YcumRlqeC/pd0sFhQsh72VkAG47P+3Tccru9bvrEX+5FvtUSl4iu
         lFCjr8QtrWI+DQzbGYlTHol8cWJjr0ckRxoiVTJI=
Date:   Mon, 27 Apr 2020 14:09:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>, perex@perex.cz,
        tiwai@suse.com, lgirdwood@gmail.com
Cc:     Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20200427091145.4268-1-tangbin@cmss.chinamobile.com>
References: <20200427091145.4268-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: hisilicon: Use IS_ERR() instead of IS_ERR_OR_NULL()
Message-Id: <158799293954.30174.15623611340968433375.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020 17:11:45 +0800, Tang Bin wrote:
> In the function hi6210_i2s_probe(), devm_clk_get() doesn't return NULL.
> Thus use IS_ERR() to validate the return value instead of IS_ERR_OR_NULL().
> 
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  sound/soc/hisilicon/hi6210-i2s.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: hisilicon: Use IS_ERR() instead of IS_ERR_OR_NULL()
      commit: e782ddbb0873d4d96bda890b295130696e0739fc

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
