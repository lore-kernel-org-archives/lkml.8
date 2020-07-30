Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F59C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FAE72083B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596148103;
	bh=oCtQbMc0yIjwTyoUHceGAsyCS/EgZDfLbcmV5WPOPq0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=VWm5/VmJIq1atTxWhNhSoNoameYkVe8ZcziPxJ8x3GbZAhHwdvy2FPxlW7menNj4a
	 JESccCPVfu0SmemPWjB0OIcpi5nIVXwZ/x0lmTiSEGR99QthsvNtVjbaMUSr61W7YL
	 59+GzlvAH0hPVOTfboX5aa1dMr6JJQC7mPFnDRpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbgG3W2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:28:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730399AbgG3W2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 18:28:21 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23CBD20829;
        Thu, 30 Jul 2020 22:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596148100;
        bh=oCtQbMc0yIjwTyoUHceGAsyCS/EgZDfLbcmV5WPOPq0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=WzaL/zUJErKB3SDcOhK2ZY2fXDqKFTF5FjgwwZn6aP1IpBFKKvuCcgIiZVnarVC5k
         K3PjnyLsLJJtnuTmWVgq3kb2WjdUC5p26skGiZX5BmQpXsgswCRAwA7VrJam5ojv37
         EuoKoYOjT06TXuX+cxfnzVDVi10I4G5TwNlYRUh4=
Date:   Thu, 30 Jul 2020 23:28:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200729154456.1983396-1-jbrunet@baylibre.com>
References: <20200729154456.1983396-1-jbrunet@baylibre.com>
Subject: Re: [PATCH 0/4] ASoC: meson: tdm fixes
Message-Id: <159614804534.1473.9918282900203412134.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jul 2020 17:44:52 +0200, Jerome Brunet wrote:
> This patcheset is collection of fixes for the TDM input and output the
> axg audio architecture. Its fixes:
>  - slave mode format setting
>  - g12 and sm1 skew offset
>  - tdm clock inversion
>  - standard daifmt props names which don't require a specific prefix
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: meson: axg-tdm-interface: fix link fmt setup
      commit: 6878ba91ce84f7a07887a0615af70f969508839f
[2/4] ASoC: meson: axg-tdmin: fix g12a skew
      commit: 80a254394fcfe55450b0351da298ca7231889219
[3/4] ASoC: meson: axg-tdm-formatters: fix sclk inversion
      commit: 0d3f01dcdc234001f979a0af0b6b31cb9f25b6c1
[4/4] ASoC: meson: cards: remove DT_PREFIX for standard daifmt properties
      commit: e44815a295a50027a9953f3ef62827d14631b96b

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
