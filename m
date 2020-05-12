Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1F9C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E68620736
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589279291;
	bh=uUUBbP8EaZMPnIIp30nshyT98I1oZwm7gc2V5X55qwM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=MsDmmGaz6cK7FuMwIDrX85Pq1igEIZIKMYtgCO+XIBOiRxjFWmB0IGwfdTtSYmUm4
	 MszBIIpcL5lN3L5aORS6wWcR9KMBUAF1m86Ori/xNFJwVL2W8jUssNvvPZUWrsyjtN
	 3wn07b6IxmrTUvb+rw0/2zmZL2qRHxo/uj7/9h+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgELK2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 06:28:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729229AbgELK2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 06:28:10 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79873206A3;
        Tue, 12 May 2020 10:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589279290;
        bh=uUUBbP8EaZMPnIIp30nshyT98I1oZwm7gc2V5X55qwM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=gxn8SyvAfBlFzIgPrZCy4c8NABKRXC2ezSM7qka0kxq/wAqzD6aPu0VACynXnIdQj
         JgwLs8oz7XctyGrHluBZ+gUVaGDEvEYytJGQr7DtByCJE/OdNMwKpXpH/Xj8RAiNhm
         hYyRXQzqX3hexI48WFaiCl81HLS1lcBn2naCGnKo=
Date:   Tue, 12 May 2020 11:28:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yongbo Zhang <giraffesnn123@gmail.com>
Cc:     Chen Li <licheng0822@thundersoft.com>, alsa-devel@alsa-project.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200512093003.28332-1-giraffesnn123@gmail.com>
References: <20200511160731.GA3618@sirena.org.uk> <20200512093003.28332-1-giraffesnn123@gmail.com>
Subject: Re: [PATCH v2] SoC: rsnd: add interrupt support for SSI BUSIF buffer
Message-Id: <158927928738.28481.10666315188457403591.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 17:30:03 +0800, Yongbo Zhang wrote:
> SSI BUSIF buffer is possible to overflow or underflow, especially in a
> hypervisor environment. If there is no interrupt support, it will eventually
> lead to errors in pcm data.
> This patch adds overflow and underflow interrupt support for SSI BUSIF buffer.
> 
> Reported-by: Chen Li <licheng0822@thundersoft.com>
> Signed-off-by: Yongbo Zhang <giraffesnn123@gmail.com>
> Tested-by: Chen Li <licheng0822@thundersoft.com>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] SoC: rsnd: add interrupt support for SSI BUSIF buffer
      commit: 66c705d07d784fb6b4622c6e47b6acae357472db

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
