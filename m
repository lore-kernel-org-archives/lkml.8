Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF65C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CE1D207D8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593112322;
	bh=Wq5qLv42hAbYbM3KVFBmYg7DH+Sc+FTD5uuJlgNEbE0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=CrYxrbrRHanILHosK9X6QL63dMiynOGaD2DxcNpBNbd4FxMYz6b2ae1i/PM6QsPwd
	 teLx76vmzQJpUMrdicqaLVfi6MTsnKlio6JCDORYiSzKDWcKJ/QgWFSIcCahUVeLXo
	 4UhfL0SaNUM+i6g9/T4pDoYym2GzyL5PbvytZs7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405388AbgFYTMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:12:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390330AbgFYTMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:12:00 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 438472075A;
        Thu, 25 Jun 2020 19:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593112319;
        bh=Wq5qLv42hAbYbM3KVFBmYg7DH+Sc+FTD5uuJlgNEbE0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=kOv4k4cKrUDBv/davGtLqjHBm3p2BBy/BHnIsQdY+11N5h47jw4atb66G8jlsFiSG
         MUkjX8FFFZAq1wLlUkvsBPuaPb/2RmauGuNroLw8sQZQgCzNqWZxkqI9VsAT7toY9O
         +dcZKwpnIt1OWSCgC6KXUQHQGwUjdoi7pNbT9odI=
Date:   Thu, 25 Jun 2020 20:11:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, perex@perex.cz, Dan Murphy <dmurphy@ti.com>,
        lgirdwood@gmail.com
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200624174932.9604-1-dmurphy@ti.com>
References: <20200624174932.9604-1-dmurphy@ti.com>
Subject: Re: [PATCH v6 0/7] TAS2562 issue fixes and slot programming
Message-Id: <159311231750.10637.10437779790730548951.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020 12:49:25 -0500, Dan Murphy wrote:
> This series fixes issues tih the shut-down gpio device tree allocation and a
> code format issue found.
> 
> While working on a project slot programming for the tx and rx paths needed to be
> enabled.  In addition the vsense slot programming needed to be configurable and
> not directly a simpler adder to the isense slot.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: tas2562: Fix shut-down gpio property
      commit: 6f81e520b2906258a063f09b8d1dd9d0cc6a3172
[2/6] ASoC: tas2562: Update shutdown GPIO property
      commit: bc07b54459cbb3a572a78b5c200ff79ef11b8158
[3/6] ASoC: tas2562: Fix format issue for extra space before a comma
      commit: c8294da2ed0be726bb87019eba3a6367c7f1c922
[4/6] ASoC: tas2562: Add rx and tx slot programming
      (no commit info)
[5/6] dt-bindings: tas2562: Add voltage sense slot property
      (no commit info)
[6/6] ASoC: tas2562: Add voltage sense slot configuration
      (no commit info)

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
