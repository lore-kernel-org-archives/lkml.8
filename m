Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09226C8300A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB69E2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588179832;
	bh=7jC9IDuFARUTSjXTY+0/VvRprFL9zCdJIskFeQ3UjIc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=cga12T0bkEKBC6zEYSCLcurZeWzbd+gaZME2hG9Mk3uvCQfVBXNidKzx2N3KohPFN
	 Lo/SKu1A2dHp8ayPs19gDNsSGH1UhDM/cSh1682Etpu9/MrSK40f2Kccz7DAfjrFbh
	 rQ5ZlgzT8gkCLbBRpYgbFy8dsbbxjzWStIJGmazg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgD2RDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:03:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgD2RDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:03:47 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6387920B80;
        Wed, 29 Apr 2020 17:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588179826;
        bh=7jC9IDuFARUTSjXTY+0/VvRprFL9zCdJIskFeQ3UjIc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Xt40PtfYySz0xeIL+8IivMPM0lRD3l7gpSEYrvsExi31y37cjrYA4+1YQDXT+l2YA
         tC4cTzIHqVc3UWA8EyOlUUIRGwkLmq7qTk3CZUvmKayYQMG+rumNEdZ4Hy9sqQP2Ph
         wY20WMpsdwnL8CZdqmlMtd3GjEGTumGkgSU+ZUj0=
Date:   Wed, 29 Apr 2020 18:03:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87sghovzwb.wl-kuninori.morimoto.gx@renesas.com>
References: <87sghovzwb.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH v4] ASoC: dt-bindings: simple-card: switch to yaml base Documentation
Message-Id: <158817982434.15847.3216748804713168341.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 Apr 2020 09:00:04 +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch switches from .txt base to .yaml base Document.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: dt-bindings: simple-card: switch to yaml base Documentation
      commit: 79149fb835d762493db6b8b545527069d592d51b

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
