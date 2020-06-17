Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DB2C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90EA021532
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592400652;
	bh=h59fElqc1jeHbztqEARrRAX1SSJF4qJsEPNo7Yvqo98=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=MyyJzZS91LmXPaCXxVAOrzKOi1N5CkJpB+7cSzLg36tc+DfiREvQuSJyA5WRbgdin
	 F7miobBsNeTZhH0FimxGu6Xi8Z4+VaYHEl/FmXLbUnRa0OYb4pTtv1UmqKtoYJTRic
	 +iCojmdUywijSmh6GEHLn5IpZvvtZpR4Y6XPlifQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgFQNav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 09:30:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgFQNau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 09:30:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC9EC20853;
        Wed, 17 Jun 2020 13:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592400650;
        bh=h59fElqc1jeHbztqEARrRAX1SSJF4qJsEPNo7Yvqo98=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=uKf6Z44ycUVkHYFYbemkXBrdIXw4kYDV891C4aMKMaQ2t5lkj7DlMSa0f2vTf2Fgw
         3mFUoCan86WrGy/RdL2X3EAEGH0d4VEWY6kgNW1X/89XRRHzUelHuw1mWAiRlYzp0Z
         1T2SCvXo4ky6/MK4Cfmom25jgL/sVjzWatyCuNi4=
Date:   Wed, 17 Jun 2020 14:30:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, tiwai@suse.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        devicetree@vger.kernel.org, festevam@gmail.com, timur@kernel.org,
        perex@perex.cz
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <2185a3ec866bc59f82d93b73d1a732a896fd8f48.1592369271.git.shengjiu.wang@nxp.com>
References: <2185a3ec866bc59f82d93b73d1a732a896fd8f48.1592369271.git.shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2 1/2] ASoC: bindings: fsl-asoc-card: Add compatible string for MQS
Message-Id: <159240063808.19287.9726215695470911719.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jun 2020 12:48:24 +0800, Shengjiu Wang wrote:
> Add compatible string "fsl,imx-audio-mqs" for MQS, and move
> "audio-routing" property to be optional for MQS doesn't need
> such property.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: bindings: fsl-asoc-card: Add compatible string for MQS
      commit: 56d6663d41f982542097775a3a8a6a1b867fe608
[2/2] ASoC: fsl-asoc-card: Add MQS support
      commit: 039652a5b965404aee1fa8f61017f822668f41d4

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
