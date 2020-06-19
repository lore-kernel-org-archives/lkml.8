Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EE9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 783C3207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592573342;
	bh=lu3A8dgfddBJOdAh48Om/2tmW8Fdzk+zN7yT4K1Hta0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=opA7AKLVsvIrnSVNBVyMo0QIcxfI9dyv1mXwv9wMiCO4x1oV2CqIdH+kd3qmEePeL
	 G8HLqYKvZwk4sT1K+8bz7AZbKHOSeBdRoR8JZPwRAlzuS/aU7meBXM6UjossRl2uLL
	 Rb8eO54B2gONOljZqimA7nRQ9lE6rZ/oqmOQLWzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732939AbgFSN27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:28:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729134AbgFSN1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:27:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26668207FC;
        Fri, 19 Jun 2020 13:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592573262;
        bh=lu3A8dgfddBJOdAh48Om/2tmW8Fdzk+zN7yT4K1Hta0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=mAoOQ5S2dI0eG+mUTj3k4LYTRCwGkCXuZ0Ed8a8oUVDhRLNiRi1OnOcQhLIEW1R14
         sdRWoDgPRRmdNx43+xX9LgOEzxcHGhUWB0f+rxdQakxaejVm1eGPFQ6fwtnP9yXLyG
         jKCk8ZQjC/AqhcH0w6Hje01KzFQyEuxeWfAvcjZQ=
Date:   Fri, 19 Jun 2020 14:27:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, timur@kernel.org,
        festevam@gmail.com, Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com,
        alsa-devel@alsa-project.org, perex@perex.cz, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <579c0d71e976f34f23f40daa9f1aa06c4baca2f1.1592552389.git.shengjiu.wang@nxp.com>
References: <579c0d71e976f34f23f40daa9f1aa06c4baca2f1.1592552389.git.shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: fsl_spdif: Add pm runtime function
Message-Id: <159257325526.5735.7482602069730796749.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020 15:54:33 +0800, Shengjiu Wang wrote:
> Add pm runtime support and move clock handling there.
> Close the clocks at suspend to reduce the power consumption.
> 
> fsl_spdif_suspend is replaced by pm_runtime_force_suspend.
> fsl_spdif_resume is replaced by pm_runtime_force_resume.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_spdif: Add pm runtime function
      commit: 9cb2b3796e083169b368a7add19faec1750ad998

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
