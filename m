Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DADC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 18:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9269E2098B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 18:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598637885;
	bh=frjSPFJ+75o4QdoDtU1nI4HxnaQxhFcRXTKiq6ZSpg8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=VBgDe0hodvMAFsFroWhpGMb3n7kluG5cYpXeHU3z11NpB+psGzV1RuVV+Rdn2QqR1
	 U06ixNt+1WtMa+osbLOqUiiI+OiPzb6UB2aR4UftvFUhW29kiMVrSaO6azVH6Qz44L
	 HeJ14Nuxzm7gAkhR3O6COa3tJ7K+fA6Rco+lDQbM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgH1SEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 14:04:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgH1SEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 14:04:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B06E20936;
        Fri, 28 Aug 2020 18:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598637882;
        bh=frjSPFJ+75o4QdoDtU1nI4HxnaQxhFcRXTKiq6ZSpg8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=nVnAVtK6fs7r+1K5wDFx9R1apyIw853o9edYRooJ1u6l/v7NEn6wMK50EbnHrsF90
         twOiHIeb288j343Rjyd/YK9IKCRJoPmgkoQPPPLhaIvyHKFsNXcoR6GeF2jfowH93T
         CjCbHWbMgnKONJ4XFnQcBZsGAvKgyF1ckLcDR40Q=
Date:   Fri, 28 Aug 2020 19:04:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Nicolas Belin <nbelin@baylibre.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200828151438.350974-1-jbrunet@baylibre.com>
References: <20200828151438.350974-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] ASoC: meson: axg-toddr: fix channel order on g12 platforms
Message-Id: <159863784461.17371.15318009139642856704.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020 17:14:38 +0200, Jerome Brunet wrote:
> On g12 and following platforms, The first channel of record with more than
> 2 channels ends being placed randomly on an even channel of the output.
> 
> On these SoCs, a bit was added to force the first channel to be placed at
> the beginning of the output. Apparently the behavior if the bit is not set
> is not easily predictable. According to the documentation, this bit is not
> present on the axg series.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: axg-toddr: fix channel order on g12 platforms
      commit: 9c4b205a20f483d8a5d1208cfec33e339347d4bd

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
