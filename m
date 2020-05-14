Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F90DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2D7A206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589475933;
	bh=HwjC0mdEpvRNfNDbCJoWOZLsIFufbVD8D3rudxfe4kU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=BWc3IaKRrv2mgr/iFypD4Fa9cIU0t7YHU/EX56vX7kMUVPnKiiqMKoOC0/IwGbvSZ
	 GvZxZV4dWL7u4NZYavDChqQCJ5lRT/RbdvLXl6gV4WJ35Hgs2UP+hgVlxhToBQbZ1N
	 BrA5NTfmfbWYbIfJDQCHT+4Apz/JibKU2/SBHFNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgENRFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 13:05:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgENRFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 13:05:31 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FFBB206D8;
        Thu, 14 May 2020 17:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589475931;
        bh=HwjC0mdEpvRNfNDbCJoWOZLsIFufbVD8D3rudxfe4kU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=zvXKgrNaAp32PZfFs9VQf/nQ7ByZSBe3Ae03TO+khlKVpIC4iaO9jb5IgyPVu75Nl
         jkYdPhh7ADAoWxClOF3x29zKbi67UV1NgDUxbscmNnJMkBqiH4+6jplbSUyygnv1vx
         GgV6nnjdV4AWUnfgBBMPelbjfwak7zi4IfTfXmWg=
Date:   Thu, 14 May 2020 18:05:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, tiwai@suse.com, Dan Murphy <dmurphy@ti.com>,
        perex@perex.cz
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20200514123338.20392-1-dmurphy@ti.com>
References: <20200514123338.20392-1-dmurphy@ti.com>
Subject: Re: [PATCH v3 1/3] ASoC: tlv320adcx140: Add controls for PDM clk
Message-Id: <158947592846.11145.11012655309437023343.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 May 2020 07:33:36 -0500, Dan Murphy wrote:
> Add ALSA controls to configure the PDM clocks.
> The clocks need to be configurable to accommodate various microphones
> that use clocks for low power/low resolution modes to high power/high
> resolution modes.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/3] ASoC: tlv320adcx140: Add controls for PDM clk
      commit: 7cfa610205d95357f9eface292dc70fce7571f65
[2/3] ASoC: tlv320adcx140: Add device tree property for PDM edges
      commit: 75b0adbb0806a141b0b5f074cd6bd58bb9870c0d
[3/3] ASoC: tlv320adcx140: Configure PDM sampling edge
      commit: 79fc48e41e39d7a98c5f8ae37f613d7ff9953c86

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
