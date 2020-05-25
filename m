Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E75C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A779220888
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590418632;
	bh=lNQnpMwKOSsceTf5wn8YZ0Kyu+yOL0dohR21xmwWsI0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=CSNnzP00Fl6T24n8MGJUA1WfeOnldNeoX/ORinYD7kkAs6/LTAYI0jLQSfY7r75km
	 INnMAXk+vJ2G7YTUbb0sbciBHHHEei/yBY57lpI11GQ4J4dK4RBso2N+/CSeJPOGXR
	 Mf1KLMMtalEXR4LE8akEVEHU4yenRYwsUzj4/cR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404057AbgEYO5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:57:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404013AbgEYO5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:57:11 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B68CC20890;
        Mon, 25 May 2020 14:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590418631;
        bh=lNQnpMwKOSsceTf5wn8YZ0Kyu+yOL0dohR21xmwWsI0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=J5NUkowxAWg9OxdwePf3UF19YTawnWizamkm7d6fmxY2wta0uJBJI6eSNgo6MDmHM
         FalRaOQw1DgxDia/roPZviZdXE794l6vKEsjY93Oy50RE5K/IkFAFI1tJVvw+PZXjI
         YgDzeBFLncu4YxWAVZiqhkjamNT9N/AXKNbWA1E0=
Date:   Mon, 25 May 2020 15:57:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Xiubo.Lee@gmail.com, Shengjiu Wang <shengjiu.wang@nxp.com>,
        lgirdwood@gmail.com, festevam@gmail.com, timur@kernel.org,
        perex@perex.cz, alsa-devel@alsa-project.org,
        nicoleotsuka@gmail.com, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1590141444-28668-1-git-send-email-shengjiu.wang@nxp.com>
References: <1590141444-28668-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_asrc: Merge suspend/resume function to runtime_suspend/resume
Message-Id: <159041861696.1370.11311962714558356940.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 May 2020 17:57:24 +0800, Shengjiu Wang wrote:
> With dedicated power domain for asrc, power can be disabled after
> probe and pm runtime suspend, then the value of all registers need to
> be restored in pm runtime resume. So we can merge suspend/resume function
> to runtime_suspend/resume function and enable regcache only in end of
> probe.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_asrc: Merge suspend/resume function to runtime_suspend/resume
      commit: 393dc21d0f25e8fcde8baca78b8a38afe61db2a7

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
