Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFC5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C614C2098B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592264455;
	bh=lOvmryFJWxVe+rag3gT3bLGVqKZmlDGKv/2fXSTKcXc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=sWY31sBi9kP/dcuW/RTMIx2WfMWPIkpOyJYUKUSYEqENAQTcxEUJRLJGqxtONypz6
	 nQourxF5gFgIJ/5rlTaTIJP3ls78G01mejd9TVNiDoUwMxcERht2PzqTnZNh3WauFS
	 yZCXKhXTzbzlRN42NMsfnmvQgZLSAQJz1fKtvLHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgFOXky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:40:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgFOXkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:40:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE27A207D3;
        Mon, 15 Jun 2020 23:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592264451;
        bh=lOvmryFJWxVe+rag3gT3bLGVqKZmlDGKv/2fXSTKcXc=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=NQdbvAuOSDp9BpJB3wd+YzO8Whu2ZOvFfjfyERBOO3HUkGmb2RvqZEj3g5jbilADU
         Sb/SVegDwxQFs38vOWpYdt2ija6CjFJCIu4f9TqY89OoMwWtF6UBklB1AQrPLoku/t
         rp4OivZxVmkOEo/eHUtmCpv0ovBJjlLmin/2/fqY=
Date:   Tue, 16 Jun 2020 00:40:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     kjlu@umn.edu, "wu000273@umn.edu" <wu000273@umn.edu>
Cc:     Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200614033344.1814-1-wu000273@umn.edu>
References: <20200614033344.1814-1-wu000273@umn.edu>
Subject: Re: [PATCH] ASoC: img-parallel-out: Fix a reference count leak
Message-Id: <159226439190.27409.17076823025937855745.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jun 2020 22:33:43 -0500, wu000273@umn.edu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> when it returns an error code, causing incorrect ref count if
> pm_runtime_put_noidle() is not called in error handling paths.
> Thus call pm_runtime_put_noidle() if pm_runtime_get_sync() fails.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: img-parallel-out: Fix a reference count leak
      commit: 6b9fbb073636906eee9fe4d4c05a4f445b9e2a23

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
