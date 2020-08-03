Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9353C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B02B2076C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596469988;
	bh=XeYM1rRZOkWuIGWs2dZo48AiU58GKKjioVDTipaaTp4=;
	h=Date:From:To:In-Reply-To:References:Subject:List-ID:From;
	b=k4wJ3t2apV9rmX8S/syxVvu6Ayqr8NN2kTCBQX/v8MIARB+cNkUo+1RgXdH66udmx
	 Lm+cJ2Bd1d8m8NcptSKXJtLSx3jrUx29pUhTV5EMZ/sOsOb5U6gyhDqbCIykNpa8qg
	 GLdp8BwgiGqMGp4/sKaHaSSvGXVHdjsszG+U1WKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgHCPxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:53:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbgHCPxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:53:08 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 595502072A;
        Mon,  3 Aug 2020 15:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596469986;
        bh=XeYM1rRZOkWuIGWs2dZo48AiU58GKKjioVDTipaaTp4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=GJfBCVCERYczWrzRwIKu61UKHM57s5ntL+rWpDdYN0ZhK3ZstcH3QIQisS6vNUikc
         ke7JZAqeDR34Cqspn0Xa61dQHl+uRVNKPoGzimarFLVS7FQS6p1vKkqLfwVRpoD7NR
         2NdyngBPn5egBEmzDsuwocTAeFvLY8HaNOvRk+p0=
Date:   Mon, 03 Aug 2020 16:52:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        perex@perex.cz, Xiubo.Lee@gmail.com, linuxppc-dev@lists.ozlabs.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>, timur@kernel.org,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1596420811-16690-1-git-send-email-shengjiu.wang@nxp.com>
References: <1596420811-16690-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v3] ASoC: fsl-asoc-card: Remove fsl_asoc_card_set_bias_level function
Message-Id: <159646994087.2524.15435181634413034183.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Aug 2020 10:13:31 +0800, Shengjiu Wang wrote:
> With this case:
> aplay -Dhw:x 16khz.wav 24khz.wav
> There is sound distortion for 24khz.wav. The reason is that setting
> PLL of WM8962 with set_bias_level function, the bias level is not
> changed when 24khz.wav is played, then the PLL won't be reset, the
> clock is not correct, so distortion happens.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl-asoc-card: Remove fsl_asoc_card_set_bias_level function
      commit: f36e8edb95734c03134db628afa25ee23b8e0d95

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
