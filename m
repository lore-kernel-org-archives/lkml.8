Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01FDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 778552077D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590771086;
	bh=8hJyhwyGGs/0tKnBqIAqpCQeA1UaPiuW2q/Yba8rG2A=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=kOoXhsgocmAOvmn6AXs474P5DEI3zQ61y4E1TWxHXtG4zYPWKZUbg5mhepxlsE1YZ
	 male9TWlrnaEx3HAew8aFnv7y0Gl2EkJVVYjWd3dSI3qMcs0kXdoHi9vQl6KNB7hek
	 umjpNkhrneBlraTcebYLbvqqrbIFIIcyuW4OvsWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgE2Qv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 12:51:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbgE2QvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 12:51:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FD032075A;
        Fri, 29 May 2020 16:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590771084;
        bh=8hJyhwyGGs/0tKnBqIAqpCQeA1UaPiuW2q/Yba8rG2A=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=xTh6HGyQlX4zqwbUrNz3iAsu6j6fKl+92as/zI12pq54MScl2Ktl8fu8CGKmQCdb2
         VQk1U53m8s0saNnDXaHJgcUFZ+V9ko7YAFCzOl9D1v+ztOuu+p/9fCRGqtpg+XlbXP
         FnUOJmDlzVpC+yu9ph8me/CTVidt5YGREPmixYXU=
Date:   Fri, 29 May 2020 17:51:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>, lgirdwood@gmail.com, perex@perex.cz,
        robh@kernel.org, tiwai@suse.com
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200528144711.18065-1-dmurphy@ti.com>
References: <20200528144711.18065-1-dmurphy@ti.com>
Subject: Re: [PATCH] dt-bindings: sound: tlv320adcx140: Fix dt-binding-check issue
Message-Id: <159077105220.28617.4274589938858936015.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 09:47:11 -0500, Dan Murphy wrote:
> Fix dt-binding-check issue
> 
> ti,gpi-config:0:0: 4 is greater than the maximum of 1
> ti,gpi-config:0:1: 5 is greater than the maximum of 1
> ti,gpi-config:0:2: 6 is greater than the maximum of 1
> ti,gpi-config:0:3: 7 is greater than the maximum of 1

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tlv320adcx140: Fix dt-binding-check issue
      commit: c8b47d63ad8755780b6b70dbe57ab8333bcc4a0f

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
