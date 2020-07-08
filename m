Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8286C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76DE9207C4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594227605;
	bh=gVx9pVBglCab/+yLWlvOgqkrNnTRyxFbapbMdcE2/84=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=J1E2dTUWbtGf50F8sYU5VdEN5jI2MI2VPgoyTdNibNXgn0SQLPOgOLJwJOMNlP+si
	 bFG+OTcy75vNW88x2Ctc7l08Ut0+3NyTHCB0j7xtKtZAb3ZZ2dtzY1z6vaRYllPJUg
	 2ZQVn6fwRYQv0XG0WsKLD5ZpE8PUoxO/XvheDIjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbgGHRAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgGHRAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:00:03 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5351206F6;
        Wed,  8 Jul 2020 17:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594227603;
        bh=gVx9pVBglCab/+yLWlvOgqkrNnTRyxFbapbMdcE2/84=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=r1xftyc4XBLnqgFAm47wKCJjzgHiMo2YDG17d6p5WP85qZyR8cRYULcnEMcxg1+Rn
         ylEUUpsdz/NluoZ0/RB1zuEW0oP7wct5Mev0BJ/e0Lh1p5nrheDfUJxwhwAoaL1lqW
         /4PJD3XiLBN0keLx2oOmPMfEtbfn5369HPDKSQR8=
Date:   Wed, 08 Jul 2020 17:59:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     tiwai@suse.com, ckeepax@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com
In-Reply-To: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 00/11] ASoC: qdsp6: add gapless compressed audio support
Message-Id: <159422758801.28431.9889241714368615225.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jul 2020 17:36:30 +0100, Srinivas Kandagatla wrote:
> This patchset adds gapless compressed audio support on q6asm.
> Gapless on q6asm is implemented using 2 streams in a single asm session.
> 
> First few patches are enhacements done to q6asm interface to allow
> stream id per each command, gapless flags and silence meta data.
> Along with this there are few trivial changes which I thought are necessary!
> Last patch implements copy callback to allow finer control over buffer offsets,
> specially in partial drain cases.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: q6asm: add command opcode to timeout error report
      commit: b6198097b84abcbf9d098ddf5887fe62f9da2e3c
[2/2] ASoC: qdsp6: use dev_err instead of pr_err
      commit: 0579ece8f4de9956ea7087c63f55663ea79283bc

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
