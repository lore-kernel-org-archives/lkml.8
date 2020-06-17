Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C88C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA2CE2089D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592412524;
	bh=jKmBqGMw//TDq5d1AN61mPbBQRkBy3ivxqxYjKASoVA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=PxNwfX70YNGLI5KtGg1NuaaIEnTUsefxpVy+d6GHkFamO1RdAFk+VCbzG+ho17erv
	 OdyMZXmAc5ILxIvkH4irs3DDczL815KS/6sAKlMW2FLWDMfWzFc/q/aYVxrQVuaHk9
	 rvO8nGVUNzdXdnHBsLnBap8oir1Nu2DAKStbujUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgFQQsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:48:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbgFQQsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:48:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1632E21532;
        Wed, 17 Jun 2020 16:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592412518;
        bh=jKmBqGMw//TDq5d1AN61mPbBQRkBy3ivxqxYjKASoVA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=yp2qLscaYNDIVwrFhkLWX2B5HzhY7YccM3l+pUBHKnUwKRVEcmVTgaWk7CnhvqLmY
         OnhO4lTymyuSDYGW5bY2oCVivdPCCj4uYbJgD04NYyI3gietIFrORHzxhKWFfkLdMW
         psKHjNOdVbiAqyDAwnD8ITA/AJ/kJy5UKyjUm8Yk=
Date:   Wed, 17 Jun 2020 17:48:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org
In-Reply-To: <20200617155047.1187256-1-jbrunet@baylibre.com>
References: <20200617155047.1187256-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] ASoC: meson: imply acodec glue on axg sound card
Message-Id: <159241251642.14602.5400773312595061016.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jun 2020 17:50:47 +0200, Jerome Brunet wrote:
> When axg card driver support is enabled, lets enable the related
> internal DAC glue by default.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: imply acodec glue on axg sound card
      commit: e50186e1dae67e070d4725b1f0b35b131969141d

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
