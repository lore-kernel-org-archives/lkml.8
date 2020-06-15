Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E63AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34D5F208C7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592264406;
	bh=rX1DHAOnhPtnb7erlFKAIOqjfys/6ZA52aiWMCtZo7Y=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=BeJPlR3kgaFf5nMd8+rg4Utq2AdpYyfPK76FR22JopdqhWNPlqOtlRItqFlvwHIeT
	 nhjSx+uqbhkm7THhCYdN1CyrnAoTkjp8ZUMelOg/+9On4V2VjFOzShpolds+Oq+rL1
	 lBk9HF44AV8hGnLYOYHh3ILYD1KGSzjWBobSx2rI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgFOXkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbgFOXkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:40:04 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C936C207D4;
        Mon, 15 Jun 2020 23:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592264404;
        bh=rX1DHAOnhPtnb7erlFKAIOqjfys/6ZA52aiWMCtZo7Y=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=FwFV+tA4A7kJf7sdhkLV55rcuqeiXqHZVwcYmF4cAIhRt0Kfu+x2/saCCn3WB9xGU
         QyG8nOfMzur/WAPA7hSeOW0URwVB7SIuEb+PnGJgR4WnPNJqq3b+BAa5lrl/ew+H0z
         Uj4+X1can5ZZYawgQ1PAloxnAvFST4rNkCZSojQE=
Date:   Tue, 16 Jun 2020 00:40:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     kjlu@umn.edu, "wu000273@umn.edu" <wu000273@umn.edu>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200614033749.2975-1-wu000273@umn.edu>
References: <20200614033749.2975-1-wu000273@umn.edu>
Subject: Re: [PATCH] ASoC: img: Fix a reference count leak in img_i2s_in_set_fmt
Message-Id: <159226439190.27409.3717160114611875111.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jun 2020 22:37:48 -0500, wu000273@umn.edu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> when it returns an error code, causing incorrect ref count if
> pm_runtime_put_noidle() is not called in error handling paths.
> Thus call pm_runtime_put_noidle() if pm_runtime_get_sync() fails.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: img: Fix a reference count leak in img_i2s_in_set_fmt
      commit: c4c59b95b7f7d4cef5071b151be2dadb33f3287b

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
