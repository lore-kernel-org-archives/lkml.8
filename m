Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8563BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 13:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 626C622D72
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 13:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596030760;
	bh=olcPQYLRhZ6J89WgrrA4eEkN7VMmNsAbPiHflKRaWSw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=Idi+rtmr7ricMI+WwKNTPXXvh99N0gpqQAq+MPEohjV/rAC5kozZUGj5KShh/DKdQ
	 5Gn2jjTazQsnzWHs+au+Cc/ZuezXCfBDa4tltATvOoB80Bt1vwp0EwKFVOxnN6egw2
	 mq2MmMb1DeTwM4UOj6eMiHy524HPQkfEEICrlwJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgG2Nwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 09:52:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgG2Nwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 09:52:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C902122D37;
        Wed, 29 Jul 2020 13:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596030758;
        bh=olcPQYLRhZ6J89WgrrA4eEkN7VMmNsAbPiHflKRaWSw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=aIkjo0IxD6Tl6LoSB4teA8rDDrjPOIBXOOpiVpSrpbRXdtrXJJdBzmxAH3SrUVPgR
         iEuUay9sqUuis43Q43X0M332jVmgwOKsCAnccfgKrWrhCfm80uYmI4cgwTLzGwqExd
         88eH6H8D9rCeow13arEyI8R67G0LuYWRblsVGeo8=
Date:   Wed, 29 Jul 2020 14:52:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20200728160833.24130-1-dmurphy@ti.com>
References: <20200728160833.24130-1-dmurphy@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: tlv320adcx140: Add GPO config and drive config
Message-Id: <159603073224.46331.10451608793293246650.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020 11:08:32 -0500, Dan Murphy wrote:
> Add properties for configuring the General Purpose Outputs (GPO). The
> GPOs. There are 2 settings for each GPO, configuration and the output drive
> type.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] dt-bindings: tlv320adcx140: Add GPO config and drive config
      commit: 63b0383f3c1c32d7ff958bf3a58c58a84cbd7450
[2/2] ASoC: tlv320adcx140: Add GPO configuration and drive output config
      commit: 6617cff6a05e7e7a679499cb1d5cd2d3bc6390c3

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
