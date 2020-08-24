Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6AAC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6F2D204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598276538;
	bh=227dtBv6s+osOfbFZGxhSmc7Pp+0HyhRJcvJKsfk/9g=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=sQpY8Ncjnfu3xD8mSW6lNsX8q8uc281lsZBEeSR5IPRtIuWIerkYoZ1FJoH6u7t/T
	 vgu2oEiXb3fOtnIVW1qYamLMRPDWB97GbJMyx5KU1j/Vgz1uFuRREGPp7odFaReXhu
	 OXKUqDB7VAjrTl5SCPvtOO4vObHMs4uU09l7Xac0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgHXNmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:42:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbgHXNcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 09:32:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8482D21741;
        Mon, 24 Aug 2020 13:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598275936;
        bh=227dtBv6s+osOfbFZGxhSmc7Pp+0HyhRJcvJKsfk/9g=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Z25Zek48M4ObQQW2U6XdS3pJxww3Z1DSNLI8UqjLpwPj7TjLcv9jq/hDBS7TZxXBz
         PwAYzNfPyBe7m3m7hAflDuszz4SPdFZt8uk3/1PvneCwtIgK1oHyPtIOcu5ZXXkRIh
         +gvrqVF80qrTRsXNt3NvpKlh9BukPWX9YazDowiE=
Date:   Mon, 24 Aug 2020 14:31:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Xiubo.Lee@gmail.com, tiwai@suse.com, timur@kernel.org,
        alsa-devel@alsa-project.org, festevam@gmail.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com,
        perex@perex.cz, nicoleotsuka@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1598255887-1391-1-git-send-email-shengjiu.wang@nxp.com>
References: <1598255887-1391-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH RESEND] ASoC: fsl_sai: Add -EPROBE_DEFER check for regmap init
Message-Id: <159827589162.47809.7720594849042451325.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Aug 2020 15:58:07 +0800, Shengjiu Wang wrote:
> Regmap initialization may return -EPROBE_DEFER for clock
> may not be ready, so check -EPROBE_DEFER error type before
> start another Regmap initialization.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Add -EPROBE_DEFER check for regmap init
      commit: c1e47e8919da525c803d1557a30e44441db1e5ee

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
