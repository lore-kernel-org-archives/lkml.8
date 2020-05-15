Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F95FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C3FA207C4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589541024;
	bh=SLJ8q9ALaDgv+nU5BF1TbEJ2mglM/zXsGZrXaSF5RsM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=l68CF8W0nJ1khJn81lR29GGjC1hkvTiS2Eebwffemw8KPY6JiBTk2DUim4O5UqhD6
	 eJkE4HsYX0DaAka1ACioOQ1PHYwC8pNams19Q9Q+kvVDFXILjP/zMCXFtM1CT7EgFm
	 35X1Gz6KJraxdUKJrQQeWjWalweQ9lScw9doCVis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgEOLKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 07:10:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgEOLKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 07:10:23 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1FDB2074D;
        Fri, 15 May 2020 11:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589541023;
        bh=SLJ8q9ALaDgv+nU5BF1TbEJ2mglM/zXsGZrXaSF5RsM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=2OKpYtBFi78dOyoTHb5nG6B3uf262CEL31o5mUV0yWCV11KTrU1ZGh68tURsMZLib
         s9/tQAYeeTVvOU+AfihLQ5n4Sn3J7DFtrSccZWJdBPJZ0v4wqpp27+tM/KN8INudmv
         se6BD/ZE3sy5SJ/Huo2J2voX/QAxLh2z5RhsNN+s=
Date:   Fri, 15 May 2020 12:10:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     nicoleotsuka@gmail.com, robh+dt@kernel.org, lgirdwood@gmail.com,
        tiwai@suse.com, alsa-devel@alsa-project.org, timur@kernel.org,
        Xiubo.Lee@gmail.com, Shengjiu Wang <shengjiu.wang@nxp.com>,
        perex@perex.cz, festevam@gmail.com, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <cover.1589537601.git.shengjiu.wang@nxp.com>
References: <cover.1589537601.git.shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2 0/2] ASoC: fsl_esai: Add support for imx8qm
Message-Id: <158954102051.28239.13020944644998998751.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 May 2020 18:10:49 +0800, Shengjiu Wang wrote:
> Add support for imx8qm.
> 
> Shengjiu Wang (2):
>   ASoC: fsl_esai: introduce SoC specific data
>   ASoC: fsl_esai: Add new compatible string for imx8qm
> 
> Changes in v2
> - drop the 0002 patch in v1, the dma relate limitation should
>   be done in dma driver, or define a new DMA API for it.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/2] ASoC: fsl_esai: introduce SoC specific data
      commit: 6878e75204e1d0420fd8130bad33f88053ba44de
[2/2] ASoC: fsl_esai: Add new compatible string for imx8qm
      commit: d59628b310a77e616ce2e5857e6ede5bf96c6784

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
