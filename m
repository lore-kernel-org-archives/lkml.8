Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910EFC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6286E20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587389823;
	bh=qSLyEMdFkBck+mljMG13xzjAvLPCpubntm0n35wtzGs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=v1pMaRtG8VUWLsC34a4r12vGKmeGwvyj0Y6RPvqgnhA78SHO5I2PKXVgA5loP9bFY
	 3NniHvibF8Cmbu3cHrdmAIMTSHJ8UY2NNkapoyrNJvvsZQfY5w//MVNOCSIKmqkNqD
	 gQsefyP94o/s8l6OaT77sPste+7bgMO5QQqd/OhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgDTNhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:37:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgDTNhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:37:02 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EA2320857;
        Mon, 20 Apr 2020 13:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587389822;
        bh=qSLyEMdFkBck+mljMG13xzjAvLPCpubntm0n35wtzGs=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=X8saqD15vVDUMhQNyFjal0htzRh6HLHdz+2WF0LiYC0e9/L7Lf320pqnRVNfBAyyJ
         KmaacoKfXa27AZGbOcLheP898y5RcrH24Pg9NdnUeDSDBKfSSxCaSZXQi7CM1yCVVO
         skWB4SL1hP1YiR6uMzDMxifWAlT7lxllurGLp9W4=
Date:   Mon, 20 Apr 2020 14:36:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20200420114511.450560-1-jbrunet@baylibre.com>
References: <20200420114511.450560-1-jbrunet@baylibre.com>
Subject: Re: [PATCH 0/2] ASoC: meson: fix codec-to-codec link setup
Message-Id: <158738981360.28730.10303799966440949108.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Apr 2020 13:45:09 +0200, Jerome Brunet wrote:
> This patchset fixes the problem reported by Marc in this thread [0]
> The problem was due to an error in the meson card drivers which had
> the "no_pcm" dai_link property set on codec-to-codec links
> 
> [0]: https://lore.kernel.org/r/20200417122732.GC5315@sirena.org.uk
> 
> Jerome Brunet (2):
>   ASoC: meson: axg-card: fix codec-to-codec link setup
>   ASoC: meson: gx-card: fix codec-to-codec link setup
> 
> [...]

Applied to

	broonie/sound.git for-5.7

Thanks!

[1/2] ASoC: meson: axg-card: fix codec-to-codec link setup
      commit: 1164284270779e1865cc2046a2a01b58a1e858a9
[2/2] ASoC: meson: gx-card: fix codec-to-codec link setup
      commit: de911b4e683f9c28a063bb62991f2db206c38ba4

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
