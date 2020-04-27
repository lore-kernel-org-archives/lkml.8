Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCB6C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DACA520735
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587992949;
	bh=pB4iFyAh9VaSFr6AV9fX9xSoxAlH6RoVnNZL7aR2xwQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=vd9WdsmR5bnrGVkaJt7qEsYQQ/V32G5VHwZvfS+T18tAv9viWjH+RQ0bwghw7emeB
	 25m+ovAxLCJNz+eJ27YIqCuS9S5vW1ViryeCx4FdD+EJ+xBw0hq6Ukkq8Tw71jRNFM
	 JVVS8VkyKOysNOeiXrcDcxv6c3aSaunNjc7UH6yw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgD0NJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 09:09:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgD0NJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 09:09:08 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89E21206E2;
        Mon, 27 Apr 2020 13:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587992948;
        bh=pB4iFyAh9VaSFr6AV9fX9xSoxAlH6RoVnNZL7aR2xwQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=dXYMY5LRP9lCqOlKe+8ZzEqIF6K5e4ylgXZsWft2JC5j+3SY17/h2MjQwmIqigQs0
         hpCpul3RZ5cz1g7kDs3LmLWOL9z0rNntSuybiYLbf+lRlIgB9HQws/eEgkxl8CP4sW
         8NzzFmglg2U3O0z50QKwMbekeI8BXysCPdik3Stk=
Date:   Mon, 27 Apr 2020 14:09:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>, perex@perex.cz,
        tiwai@suse.com, lgirdwood@gmail.com
Cc:     Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20200427091520.12412-1-tangbin@cmss.chinamobile.com>
References: <20200427091520.12412-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: hisilicon: Use the defined variable to clean code
Message-Id: <158799293954.30174.17557167078734797875.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020 17:15:20 +0800, Tang Bin wrote:
> Use the defined variable "dev" to make the code cleaner.
> 
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  sound/soc/hisilicon/hi6210-i2s.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: hisilicon: Use the defined variable to clean code
      commit: 77060f4f71dfb08309f461766d2e7453ce68aa76

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
