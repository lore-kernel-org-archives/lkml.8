Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9773BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7115B2081A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591970361;
	bh=OIe/GJsPvDod9bI6gR/O7C4Glg5HxnNaq1KplU6e9No=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=d8ZuJIPBIfZ8AYxylwzeTbCxvFI/kZjyoHK8TXeJcuv+ZxkhmR3uJLO1mwOrsXUBV
	 RVfbq0GF59/MFyezXC8MHs2FS+VkBYl3grqKwsgGOMk4y0vtwYEm+oIZUsfxKv5irO
	 o0bGNTuU6gFxsDcD5ft8SIdmmqKH4EVpM1xxeg3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgFLN7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:59:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgFLN7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:59:18 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E6EE20792;
        Fri, 12 Jun 2020 13:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591970358;
        bh=OIe/GJsPvDod9bI6gR/O7C4Glg5HxnNaq1KplU6e9No=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Iy0g0W8w80q/rEoIkpX6xnQlE87Hu2csdHN3Hoj0P9+fUKqWVo2yDAryJyBrTqTDa
         izbRDUSZ5+ctSc4Y2mlOA+CCfpWHQAVkPjGmIUo5H2Ce+e8cCbP56wgDJel0nRqWye
         V9VO4RCc6x5AvQcMr7LrRdN180eNNLW6h+t0i4Xs=
Date:   Fri, 12 Jun 2020 14:59:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Martin Fuzzey <martin.fuzzey@flowbird.group>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1591959073-16792-1-git-send-email-martin.fuzzey@flowbird.group>
References: <1591959073-16792-1-git-send-email-martin.fuzzey@flowbird.group>
Subject: Re: [PATCH] regulator: da9063: fix LDO9 suspend and warning.
Message-Id: <159197034771.51045.5035619932153977133.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jun 2020 12:50:33 +0200, Martin Fuzzey wrote:
> Commit 99f75ce66619 ("regulator: da9063: fix suspend") converted
> the regulators to use a common (corrected) suspend bit setting but
> one of regulators (LDO9) slipped through the crack.
> 
> 
> This means that the original problem was not fixed for LDO9 and
> also leads to a warning found by the test robot.
> 	da9063-regulator.c:515:3: warning: initialized field overwritten
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: da9063: fix LDO9 suspend and warning.
      commit: d7442ba13d62de9afc4e57344a676f9f4623dcaa

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
