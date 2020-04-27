Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED05CC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C10F62072D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587992955;
	bh=F2J5+tCyCW2blznWC3DoSWefBae/flCTMt9vpZT3jpQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=ikOq4xbQD2Tn4hKwCz4SRDnDBCPI7FsnNw6aT4ZHlV3O2+LxS+I+rkcCJnfvd16f5
	 WMQpqsA+EtE3piEcGo5Oe0wHj17IzkbvlxZ0UZOpiif8HD2aChRsJhI7o179EA3xs1
	 Ln8TRhqQL+3Av5sJ+q7i+T3kgzbU5NUaprkie1os=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgD0NJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 09:09:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgD0NJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 09:09:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 643F22074F;
        Mon, 27 Apr 2020 13:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587992953;
        bh=F2J5+tCyCW2blznWC3DoSWefBae/flCTMt9vpZT3jpQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=TGwGFnbhgQsP++okUZdhRpPetk91J/pmzJ3IZb7o7KWrWLNaye1tT9g9iFKbb6HOP
         R5Mz+EMS9WZ7ajlO028s1+ZYpR1BABPxXrJI7jV5I2HqBFQPiUdJXuMna/DYWGF0NI
         2/8/qwkasN9awJw28hjtggcP5QFH8Wi/l08yoROs=
Date:   Mon, 27 Apr 2020 14:09:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, timur@kernel.org, alsa-devel@alsa-project.org,
        tiwai@suse.com, festevam@gmail.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>, Xiubo.Lee@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <d23c939f1c9eeb3fce34b6c34d44e2d6156f663a.1587799355.git.shengjiu.wang@nxp.com>
References: <d23c939f1c9eeb3fce34b6c34d44e2d6156f663a.1587799355.git.shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: fsl_easrc: Check for null pointer before dereferencing "ctx" in fsl_easrc_hw_free()
Message-Id: <158799293953.30174.7045413410563193676.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Apr 2020 15:19:29 +0800, Shengjiu Wang wrote:
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
