Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9479C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EFD5204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598276558;
	bh=kQqPOp5ZCYfc0mhvDYZD0wZbCw7iw9QkX4jllZTFUSI=;
	h=Date:From:To:In-Reply-To:References:Subject:List-ID:From;
	b=u+I8/0Y9QaQy9H1R+j9PvgNyBossq4CAlHGrUPFYlPkd4v7ggFJOPG6L1wLyQ8/1D
	 SCElMj6PcPhF68h2m6xKJx38bR2TQ3Yj6mpvHeYXO7Ef/JgfQPCZS8n6+blJI9mNGk
	 4mbUEHik/ibzo+DJ/pQmDRfWXoRP7WH9rwxtyAm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgHXNmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:42:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbgHXNcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 09:32:11 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D4F721775;
        Mon, 24 Aug 2020 13:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598275931;
        bh=kQqPOp5ZCYfc0mhvDYZD0wZbCw7iw9QkX4jllZTFUSI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=eCklyBpBial1yRqp01SYpxNYkhwfj/NIYL96JuW77mjEGx35i2/NZPCwfnryUfF1D
         fbmxsdpz8xFmdyUTemS9FlsbzZel+3JWmtqVjpKOWN+rOD/tilQ/2/lPtxuUT1wDgz
         Y+9T6EyLbOgrJdWqXdJfR04934FWBFLCDkeOXFII=
Date:   Mon, 24 Aug 2020 14:31:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, perex@perex.cz
In-Reply-To: <1598190877-9213-1-git-send-email-shengjiu.wang@nxp.com>
References: <1598190877-9213-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: ak5558: Add power supply property
Message-Id: <159827589162.47809.9128717521868705111.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Aug 2020 21:54:36 +0800, Shengjiu Wang wrote:
> AVDD-supply is for Analog power supply
> DVDD-supply is for Digital power supply

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: ak5558: Add power supply property
      commit: 5edc8c4fe019b920ae9bd1e3413d66f6e8adf29b
[2/2] ASoC: ak5558: Add regulator support
      commit: 2ff6d5a108c6b7c07d1093c38e0def015edd325d

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
