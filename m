Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19386C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0A2A20786
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597769797;
	bh=Lq5bTC7AVJ/pYnGclAdQT8NAAoDP3wzNT792XtYvGt0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=BMrxfD1pKPD3E7fKPjOA3HuCbsOxyufWT/pOLajvEzMshVZtAgafinQwbkp4tDPbD
	 JKV5hXeNZqIeF81ROhqFfN4RizHlmdTPF3/nOmJoatE0iht/o75yrPo38RrlOiB2Bf
	 jLXD0Vf75ic/9YVDLdqM7qb+5BeakOQXucpcvhAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgHRQ4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:56:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbgHRQzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:55:06 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 614992080C;
        Tue, 18 Aug 2020 16:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597769705;
        bh=Lq5bTC7AVJ/pYnGclAdQT8NAAoDP3wzNT792XtYvGt0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=h/eLPdVztqPYvz3i0FiVZLoQieZTQHUlSF5VBt31kdMLlPUsF0foMPJT+pW3mciwv
         iwjaa5lUSNBU0N618cwC1CROiRlDQw/zR7cPf2xd6V8KIjbRB3JSOlzoSTB923xYVR
         LlyexTLnrCIyyz3L5u1utaL16rFXugaXP/Xm3GlM=
Date:   Tue, 18 Aug 2020 17:54:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     john.stultz@linaro.org, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20200811103452.20448-1-srinivas.kandagatla@linaro.org>
References: <20200811103452.20448-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: msm8916-wcd-analog: fix register Interrupt offset
Message-Id: <159776961933.56094.9052363191985703080.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Aug 2020 11:34:52 +0100, Srinivas Kandagatla wrote:
> For some reason interrupt set and clear register offsets are
> not set correctly.
> This patch corrects them!

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: msm8916-wcd-analog: fix register Interrupt offset
      commit: ff69c97ef84c9f7795adb49e9f07c9adcdd0c288

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
