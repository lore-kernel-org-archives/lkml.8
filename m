Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40EFC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC5D6208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588933746;
	bh=+akHx3jjMTUUrTW/fRz1G1ZH9BzRzorGdvTbfueVTDg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=oY2cdr2evQBTgsz4KVxHstIcEgY1juWVECX1TJMABDzs1vVCRDZNknLPtE//rl8pX
	 SuX2elmo6mAyleEyTzaTP7wAWLEqFzPFAihIGanxik43Ct7tG/UVFL0xtNp5CeZ8mE
	 gn0Hb1ex3UEs65rIDncFvPMGWsSBXusgOZXrJhTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgEHK3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 06:29:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgEHK3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 06:29:05 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FD0821473;
        Fri,  8 May 2020 10:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588933744;
        bh=+akHx3jjMTUUrTW/fRz1G1ZH9BzRzorGdvTbfueVTDg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=eEmcNYjl5lDnLeQwu75NRApfOp54Aqy37eZGzNCv1Q+Y3bjwlAvsJVrvg8ApQJDmW
         2s9uHnIBnfzBIXzFJGNEB4dGt4R4zsIHfrwDGQCwa38Sb7Mz7es4EK9fHgmcSKTRgw
         62d576YoSGgv/Ebv2bYVzXxzAOT3WKU7WNrsGVM0=
Date:   Fri, 08 May 2020 11:29:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20200507192228.GA16355@embeddedor>
References: <20200507192228.GA16355@embeddedor>
Subject: Re: [PATCH] ASoC: soc-core: Replace zero-length array with flexible-array
Message-Id: <158893373629.42817.8817557428869412992.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020 14:22:28 -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: soc-core: Replace zero-length array with flexible-array
      commit: 2d6201ee1123325c089008570bd5ddea3c5b131a

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
