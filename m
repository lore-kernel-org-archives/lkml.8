Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21311C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E92B420899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590591500;
	bh=7nt7f9kH1JqwknAwR7cow5RhBRNUkIwiCI5pxeuJfMU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=wQv409kf/xELr/9L0xDUErE2Ue5FVLWSSJQMumGKy3ge2hLFqzY+EX6q6lsJrl1rv
	 HU/r/s5VDg17381pF7oEMijTIkXb6EKQRrUzCE+8kZpcjnF+9A4gSLl97BuSc9lFxx
	 q4XUJGGyriDsrXhMXtMsVXRbtXSI57Kaw2QVP0mI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389457AbgE0O6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389378AbgE0O6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:58:18 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2EF620C09;
        Wed, 27 May 2020 14:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590591498;
        bh=7nt7f9kH1JqwknAwR7cow5RhBRNUkIwiCI5pxeuJfMU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=nILr3/dqBRQXywLSCiW1dOobDr2JN54eEm4YgnoeHGJQ1lAq/UpU67ZKSFwYe0jTi
         Q/ve9GkzpOUeXZLPnn67itM3pqB0gd9igAqOe+yLKbbqBsUrgSp1+Ev06zNfXXgs05
         /OcTL1YY3zSBoPT71V1YebPuOqkZFx48VSGthckA=
Date:   Wed, 27 May 2020 15:58:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, tiwai@suse.com, Dan Murphy <dmurphy@ti.com>,
        perex@perex.cz
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
In-Reply-To: <20200526200917.10385-1-dmurphy@ti.com>
References: <20200526200917.10385-1-dmurphy@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: sound: tlv320adcx140: Add GPI config property
Message-Id: <159059147354.50918.139552370821784461.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 May 2020 15:09:16 -0500, Dan Murphy wrote:
> Add an array property that configures the General Purpose Input (GPI)
> register.  The device has 4 GPI pins and each pin can be configured in 1
> of 7 different ways.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] dt-bindings: sound: tlv320adcx140: Add GPI config property
      commit: 2465d32bea35d1d56c6cfb08a96ebea3b475d8ec
[2/2] ASoC: tlv320adcx140: Add support for configuring GPI pins
      commit: 3c35e79cead31c3bd79875ae90f9655dc77ad13c

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
