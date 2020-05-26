Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A7BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DE9F20787
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590511541;
	bh=tpVtknxI2fe4Xdndl3QNnd25gQD26AlVXEL4rBnl7/c=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=abZ8axYYc2dzlEdxF2y+W+AqBeJmQBLcbq7O+MAIhPvXF5xzRDXjUrixEIAFcbq89
	 07+fqJwKLxfATS1j0dOvd8fV2q0FWtIW7s4B8dOxeMJoRzGQKIkkB9hDojMY0xN+cp
	 vM4IjLxKUu4kpFKsTebdWh2kauoliuC8q0iHhDYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388705AbgEZQpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 12:45:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:60270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388339AbgEZQpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:45:39 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5581320723;
        Tue, 26 May 2020 16:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590511539;
        bh=tpVtknxI2fe4Xdndl3QNnd25gQD26AlVXEL4rBnl7/c=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=O4ZxegteidoiTdgYB6PmPxKiJIKk9C+NZmeGgYD93kSVMxd362MliXNy3FyCmuBLt
         YNUoatGHGkDBw1VQxsq+w9+d5chZRBEPrpYd0Tdxlq7NcJKnootU0jkOYTO5MoG5/g
         zbO8DVXhI0K/TH/DOg8oxsmRwrYK3ycyJGaGZxTs=
Date:   Tue, 26 May 2020 17:45:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, "wu000273@umn.edu" <wu000273@umn.edu>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, tiwai@suse.com,
        kjlu@umn.edu, lsa-devel@alsa-project.org, perex@perex.cz,
        p.zabel@pengutronix.de
In-Reply-To: <20200525055011.31925-1-wu000273@umn.edu>
References: <20200525055011.31925-1-wu000273@umn.edu>
Subject: Re: [PATCH] treewide: fix incomplete error-handling in img_i2s_in_probe.
Message-Id: <159051153752.36309.10697371242123502857.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 May 2020 00:50:11 -0500, wu000273@umn.edu wrote:
> Function "pm_runtime_get_sync()" is not handled by "pm_runtime_put()"
> if "PTR_ERR(rst) == -EPROBE_DEFER". Fix this issue by adding
> "pm_runtime_put()" into this error path.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fix incomplete error-handling in img_i2s_in_probe.
      commit: 25bf943e4e7b47282bd86ae7d39e039217ebb007

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
