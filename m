Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD7AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B356207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592400647;
	bh=yqPhqEFGOGGnf8tKs0A9o2GYo4CEG0qvZht6TK9uQRk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=fjKoGdtYCvIWMmbHzn6tMIghL4wUpt7ZOGRBH8FBFcmg1Y1TUl5gpM3MvNfcA2dWi
	 hHJLEro+uUA+tQaqNvqUldB320VUarO4AFYA7TGc6dYopWVnvgcB2PU5y9bBKjPp1q
	 Lnx8B3EBVCQBwz35vpB7VW0p8ro3MBkx4djJ3Kxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgFQNaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 09:30:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgFQNap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 09:30:45 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F26DD2080D;
        Wed, 17 Jun 2020 13:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592400645;
        bh=yqPhqEFGOGGnf8tKs0A9o2GYo4CEG0qvZht6TK9uQRk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=xScVLiM4utiA2ijBBxaLGjDzdmBjZPDtyufiTw9HFMGHgIjPQluNDgj2DFGvw+pYo
         N8nxi/imPtpCa7rZp+UhzFPRJ5WLLYGglf8qZBwDPSj1IApRb4QfEm+xJoHTuAnbRT
         MQBOSJFe6KPMaImD7l+tKBDnU2IWxM+KrQ1FgZQE=
Date:   Wed, 17 Jun 2020 14:30:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, tiwai@suse.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        devicetree@vger.kernel.org, festevam@gmail.com, timur@kernel.org,
        perex@perex.cz
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <feda3bb02296455d43aeebb7575918d9b28e1a3f.1592376770.git.shengjiu.wang@nxp.com>
References: <feda3bb02296455d43aeebb7575918d9b28e1a3f.1592376770.git.shengjiu.wang@nxp.com>
Subject: Re: [PATCH v3 1/2] ASoC: bindings: fsl_spdif: Add new compatible string for imx6sx
Message-Id: <159240063808.19287.10407096002593271687.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jun 2020 14:58:00 +0800, Shengjiu Wang wrote:
> Add new compatible string "fsl,imx6sx-spdif" in the binding document.
> And add compatible string "fsl,vf610-spdif" which was missed before.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: bindings: fsl_spdif: Add new compatible string for imx6sx
      commit: 632108afda6aa1d380e05f1eaa25463047fd00b3
[2/2] ASoC: fsl_spdif: Add support for imx6sx platform
      commit: f61b9273c347980f570d1f9cecb867a7835c613d

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
