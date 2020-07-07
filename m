Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0C8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6931920786
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594131442;
	bh=zLDKUUlf41eWXCK1+gWKFdhUhVl9kP8CIgS7oLy2LgQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=okzU0n+U13+2m1qGvTZ9RT34qs6rc75gC7QOU3r5w2iP3WcIl5MFQma176/XOYJqv
	 67nzxcx/aHD3Jq3DcOrp7HcRCtH7yRRfXGpFlojEAhUe29QYjFNEcstpwo4I59Lrdv
	 EDM9kdZgl2wBEu6k/ewpPx8VYqfR0wGW+EWArp8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgGGORV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:17:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728067AbgGGORT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:17:19 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 102E9206E2;
        Tue,  7 Jul 2020 14:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594131439;
        bh=zLDKUUlf41eWXCK1+gWKFdhUhVl9kP8CIgS7oLy2LgQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=1Wek/USVv1i9/Nl1ZMFAk2avBAKGHTALhNkHzitHtYxwzH8Hcz7fBE7hExire+9ie
         fmqnV+aK0o+I2VaPduFIO4qT36rbdl2OPHzemUXIuGeqEHHOqhjk35+6L6BJK1QaWb
         B1TLufBEBcHc6Xf75wrhuMbg1ooEs9CeHynR1YXY=
Date:   Tue, 07 Jul 2020 15:17:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     timur@kernel.org, Yi Wang <wang.yi59@zte.com.cn>
Cc:     Liao Pingfang <liao.pingfang@zte.com.cn>,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        perex@perex.cz, festevam@gmail.com, Xiubo.Lee@gmail.com,
        linuxppc-dev@lists.ozlabs.org, lgirdwood@gmail.com,
        wang.liang82@zte.com.cn, alsa-devel@alsa-project.org,
        nicoleotsuka@gmail.com, tiwai@suse.com
In-Reply-To: <1594122467-11615-1-git-send-email-wang.yi59@zte.com.cn>
References: <1594122467-11615-1-git-send-email-wang.yi59@zte.com.cn>
Subject: Re: [PATCH] ASoC: fsl: mpc8610_hpcd: Add missing of_node_put()
Message-Id: <159413142467.34737.7662746319065846773.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jul 2020 19:47:47 +0800, Yi Wang wrote:
> After finishing using device node got from of_find_compatible_node(),
> of_node_put() needs to be called.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: mpc8610_hpcd: Add missing of_node_put()
      commit: a5911ac5790acaf98c929b826b3f7b4a438f9759

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
