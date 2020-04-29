Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7BDC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 773B320B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588177594;
	bh=OiQXZe6hCW138tYAnRswGeoKdLQ6Hw8I5G+iCYDuqSY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=AdErSDQGRWkd6d3+nO3+K2Wcjf0qegCWOwqLKL0NAXezn42vUM+2j5+xyW+V6qlkZ
	 nHZMyEDk1eTxxxX2kRvHYqJUWeDhlkro/gz7OhP0UvMPEMkkL5koFa+oUUPEnZkl77
	 0VVZNE+Zvt770Xad4aBRJO/5/z6bIgwrNbmgU86g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgD2Q0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:26:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgD2Q0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 12:26:33 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 405D12083B;
        Wed, 29 Apr 2020 16:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588177592;
        bh=OiQXZe6hCW138tYAnRswGeoKdLQ6Hw8I5G+iCYDuqSY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=XNlg6OYIYarsvAQRR1teQRTPiMKRK2f4WIUG3ton2/DuJ1pahK98nRiIBdGX+7ttn
         3b8aVbvslCIEwoVNW3/O7Y+V2L4Yla5Gk1Rm2/ZexSeMggqyXkMuKvDip6ZJlIOHKg
         tJwcEKSNbEdRfOeOg1ixTijn7KIAF2udi1UZgqxk=
Date:   Wed, 29 Apr 2020 17:26:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     nicoleotsuka@gmail.com, festevam@gmail.com,
        alsa-devel@alsa-project.org, tiwai@suse.com, timur@kernel.org,
        Xiubo.Lee@gmail.com, Shengjiu Wang <shengjiu.wang@nxp.com>,
        lgirdwood@gmail.com, perex@perex.cz
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1587731404-29750-1-git-send-email-shengjiu.wang@nxp.com>
References: <1587731404-29750-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_easrc: Check NULL pinter before dereference
Message-Id: <158817756638.27768.6987853594586973570.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020 20:30:04 +0800, Shengjiu Wang wrote:
> The patch 955ac624058f: "ASoC: fsl_easrc: Add EASRC ASoC CPU DAI
> drivers" from Apr 16, 2020, leads to the following Smatch complaint:
> 
> sound/soc/fsl/fsl_easrc.c:1529 fsl_easrc_hw_free()
> warn: variable dereferenced before check 'ctx' (see line 1527)
> 
> sound/soc/fsl/fsl_easrc.c
>   1526          struct fsl_asrc_pair *ctx = runtime->private_data;
>   1527          struct fsl_easrc_ctx_priv *ctx_priv = ctx->private;
>                                                       ^^^^^
> Dereference
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: fsl_easrc: Check for null pointer before dereferencing "ctx" in fsl_easrc_hw_free()
      commit: f3fc1ea011f09156886e8f4beb240ea814f2197a

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
