Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F2CC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57D6E20857
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587392855;
	bh=IyynnK8UeratkZoR39Dsyukzq1BV8ghVhci6oQBjUb4=;
	h=Date:From:To:In-Reply-To:References:Subject:List-ID:From;
	b=D0GxF+tlPtZYlRTqRj9X5+gDzirnKhsu5Y9ELgfvYz9pYpPxESEZ4ouWkCMa0QDzi
	 R2xhUjbo86Wi/ZrbLhmy5c/wd0slXltAboCxq06LDRzYFcEa4RCogLbb3rUtOOBO/v
	 EdgvxRCoah0CKmepFnIs1FKXCOwCSimPWO2RmPAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbgDTO1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729468AbgDTO1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:27:32 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83A4D21D79;
        Mon, 20 Apr 2020 14:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587392852;
        bh=IyynnK8UeratkZoR39Dsyukzq1BV8ghVhci6oQBjUb4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ch9lIrqr1zDGiwJLRoVegmOQq4icxhS0s3aoRK7NrJ1NUHioZ79cQJCnp+75/ztPe
         64QpOa0eaSQnE1A4PSmMtkl77rhFfdn3A/aDPPVgdz8siIPRKByOFI+K2qi73EF45T
         chjCB23u5KNA19JbQx+VBQfI5mIlXJKOMoLPbIlE=
Date:   Mon, 20 Apr 2020 15:27:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, linux-kernel@vger.kernel.org,
        Jason Yan <yanaijie@huawei.com>, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, srinivas.kandagatla@linaro.org, perex@perex.cz
In-Reply-To: <20200420042833.19116-1-yanaijie@huawei.com>
References: <20200420042833.19116-1-yanaijie@huawei.com>
Subject: Re: [PATCH] ASoC: wcd934x: remove unnecessary comparisons to bool
Message-Id: <158739283775.7647.6482976074027263195.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Apr 2020 12:28:33 +0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> sound/soc/codecs/wcd934x.c:3881:8-17: WARNING: Comparison of 0/1 to bool
> variable
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> 
> [...]

Applied to

	https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

Thanks!

[1/1] ASoC: wcd934x: remove unnecessary comparisons to bool
      commit: 836cca3a2658e9ea2a252ef78a24fdb002a9f5ba

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
