Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F90AC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E119420716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599145344;
	bh=wx3edxGRbnkP+0ghqdokdIw1oQlPriAUWdZG5DLAQ+4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=optll0gUiO4g75QeXggzPGWnouTSuaXmsLq6AFw3009Ps4OecgjWL5I6Y/nN5TDLy
	 2cPFJLQ9P8PcGPcdXA32aC5nIghHDVgZFisnNOLvcKW9zxu7G/HvzVY6WG/Q1C6Rq4
	 xYDrKRGVeuT9M/JukJPOn7CUB5WW0syWwl2twY3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbgICPCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:02:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729066AbgICOFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:05:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6222520758;
        Thu,  3 Sep 2020 13:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599140941;
        bh=wx3edxGRbnkP+0ghqdokdIw1oQlPriAUWdZG5DLAQ+4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=2i4GX0iXPOGtmQ5pAwrqoBAyG80F5eBnZVCT2zJjp/ljVNd0G2yUtiQbCoIrVfjLF
         6nVEBg0M5/P0qMEMAYndtAxt7U18R4YJ+WU68ZbQp5sUVr3y4zzCc/jRkExX2Tw4Zr
         QCF09Okl9ralGJSC0y5PecV3eHAmyNfBfhyys/6s=
Date:   Thu, 03 Sep 2020 14:48:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, tiwai@suse.com, timur@kernel.org,
        festevam@gmail.com, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1599112427-22038-1-git-send-email-shengjiu.wang@nxp.com>
References: <1599112427-22038-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: fsl_sai: Set SAI Channel Mode to Output Mode
Message-Id: <159914089549.45733.5564781801193033736.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Sep 2020 13:53:47 +0800, Shengjiu Wang wrote:
> Transmit data pins will output zero when slots are masked or channels
> are disabled. In CHMOD TDM mode, transmit data pins are tri-stated when
> slots are masked or channels are disabled. When data pins are tri-stated,
> there is noise on some channels when FS clock value is high and data is
> read while fsclk is transitioning from high to low.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Set SAI Channel Mode to Output Mode
      commit: f4c4b1bb2f5a7f034f039c302b56f82344a6dc8c

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
