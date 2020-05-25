Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0561C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 918842089D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590418645;
	bh=xv7x59AoctvLsjyArJKKMotK6vJa0TElIvyKjP6jGP4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=gASYo3XYKjK9jwnFf6SbyyOYfTYXQJ8e0iIFiGlI3dmmbs0h9553bYE7e8oTlnYRS
	 CybMlKDdxBnFWPEZ3bVHATqiBZzPqt3IF+kst7yoZ8Rxdv0UJzzEM3YBn6lDBP2bxg
	 7ryjwceBvCaEBwTrw11+29HtGyw3jaJx+0TK9KYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404080AbgEYO5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:57:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404004AbgEYO5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:57:23 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B3CD20890;
        Mon, 25 May 2020 14:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590418643;
        bh=xv7x59AoctvLsjyArJKKMotK6vJa0TElIvyKjP6jGP4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Vt8IWFBMCLjX7YmfudACYHN6YkW0RjJpqgJvENaS7c5aEw29p6ZZk3RbUWC5/sUTM
         W0kL4PGYN3Yfjsa1p+kOX3PLGuw6Berq1xpEYkBhnH32um3c5Js0Xnp3yNsa9NDPw9
         S+yCeM8jYheAPvYy/g539gCH+E2VbaJCsC4CL+GQ=
Date:   Mon, 25 May 2020 15:57:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Xiubo.Lee@gmail.com, lgirdwood@gmail.com,
        Tang Bin <tangbin@cmss.chinamobile.com>, festevam@gmail.com,
        timur@kernel.org, perex@perex.cz, nicoleotsuka@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
In-Reply-To: <20200513111408.11452-1-tangbin@cmss.chinamobile.com>
References: <20200513111408.11452-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: fsl: imx-audmix: Fix unused assignment to variable 'ret'
Message-Id: <159041861697.1370.3156349238499561936.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 19:14:08 +0800, Tang Bin wrote:
> Omit unused initialized value, because 'ret' will be assigined
> by the function snd_soc_component_read().

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: imx-audmix: Fix unused assignment to variable 'ret'
      commit: 085c02d355ac585184ef4f00eb333cd86f6add80

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
