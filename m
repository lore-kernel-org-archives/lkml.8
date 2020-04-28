Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149BEC83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DABDE206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588088456;
	bh=UwOEbjuqqZnNh4bPD15G3mJ8BwNUK3zuC+NFaXG/Wis=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=iX6946JMfMaTJeZEI9+O9gLOxb5PNtjNXTtMNi/R+qRKpgbYilDNmRe+nfwE4c3JR
	 t46UcTfyq07WVq03bfImYBqO5Oca+U+J4AEW/SEEmeKxqYwFdTEjLZdqBhUPMkSola
	 WkBtWQpHFMBCK80MdD3ymGoCyiTRsg8FSLo+DqCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgD1Pk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 11:40:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728133AbgD1Pk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:40:56 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22D4D206C0;
        Tue, 28 Apr 2020 15:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588088455;
        bh=UwOEbjuqqZnNh4bPD15G3mJ8BwNUK3zuC+NFaXG/Wis=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=w3N52jYR2mcAMUn0+EKOk0EMrIElOdRAwiiSyJI3ihKNop9LbAETyeJVJzf0O97gm
         1bIO0GPYRulEi2FuLf242QJnLmxgxbkvwVdT0FY7y4iZcDJSXK2M47h/HVfqb0VtML
         1OAfpVXA5yM7Bmk6uCMQEhe26h848wq4NdrJOyuA=
Date:   Tue, 28 Apr 2020 16:40:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, Dan Murphy <dmurphy@ti.com>, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        stable@vger.kernel.org
In-Reply-To: <20200427203608.7031-1-dmurphy@ti.com>
References: <20200427203608.7031-1-dmurphy@ti.com>
Subject: Re: [PATCH] ASoC: tlv320adcx140: Fix mic gain registers
Message-Id: <158808845301.38316.11380096383404552191.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020 15:36:08 -0500, Dan Murphy wrote:
> Fix the mic gain registers for channels 2-4.
> The incorret register was being set as it was touching the CH1 config
> registers.
> 
> Fixes: 37bde5acf040 ("ASoC: tlv320adcx140: Add the tlv320adcx140 codec driver family")
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> Cc: stable@vger.kernel.org
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

Thanks!

[1/1] ASoC: tlv320adcx140: Fix mic gain registers
      commit: be8499c48f115b912f5747c420f66a5e2c31defe

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
