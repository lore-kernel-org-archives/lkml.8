Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B0EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B07F20826
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589820104;
	bh=PN662x2FXq4LngDAMLKyKEfjxr8CebC7aeVbnQ+z7zY=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=Bq6MTNariL+JvENQzzdpRX6o8k/ieqWRW5X9vIzNEN3gSLVs0cHHbOchZ8bthOKSj
	 XXxS3MoSIeKAQsWNBk8GCyAgbw8osIeMt0ePafFDBcki+zcP4S7vbNyz5V257+CM2k
	 wlHGlb4GEwCFkMx7zafZb4LyAHbSozQzf0sxnKoc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgERQln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 12:41:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgERQln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 12:41:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1555B20809;
        Mon, 18 May 2020 16:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589820102;
        bh=PN662x2FXq4LngDAMLKyKEfjxr8CebC7aeVbnQ+z7zY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=l+4qkJjCp67DAy+fPTZ8QNF6+A7B/bCsiTWILZTN8pJFQHsjUkRs0AS1GOSkUbWgd
         JhnzfjSQdOGdaih33NiDHyzEIk4g2+t9DatDlYVP4aU/DuP0pz88w5VzmH+tkUuV1X
         8CedUrDt+v8yTlwWClZQFbDVCEJ/vpeK5OvAXXuI=
Date:   Mon, 18 May 2020 17:41:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        kernel@collabora.com, alsa-devel@alsa-project.org
In-Reply-To: <20200511132544.82364-1-sebastian.reichel@collabora.com>
References: <20200511132544.82364-1-sebastian.reichel@collabora.com>
Subject: Re: [PATCHv3 0/5] ASoC: da7213: support for usage with simple-card
Message-Id: <158982005876.28736.9440768140715468375.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 May 2020 15:25:39 +0200, Sebastian Reichel wrote:
> This extends the da7213 driver to be used with simple-audio-card in
> combination with a fixed clock. Here is a snippet of the downstream
> board's DT, that is supposed to be supported by this patchset.
> 
> ---------------------------------------------------------------------
> / {
> 	sound {
> 		compatible = "simple-audio-card";
> 		simple-audio-card,name = "audio-card";
> 		simple-audio-card,format = "i2s";
> 		simple-audio-card,bitclock-master = <&dailink_master>;
> 		simple-audio-card,frame-master = <&dailink_master>;
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/5] ASoC: da7213: Add da7212 DT compatible
      commit: 95579eaf98f17b97dc174bb31d71902b5895bd85
[2/5] ASoC: da7213: Add regulator support
      commit: b2a378816d0f6780a5500f4322e5b2542d41532d
[3/5] ASoC: da7213: move set_sysclk to codec level
      commit: 9c5c258438b23cacc4971b94d808ba8af9c5931c
[4/5] ASoC: da7213: move set_pll to codec level
      commit: f7a8ae295ca8e96e287f497506b49b1f4b47deb4
[5/5] ASoC: da7213: add default clock handling
      (no commit info)

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
