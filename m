Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49185C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16C8420866
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597769791;
	bh=8qiooKqbIY5buvznR0kFH1lZk03u/d1h4s6h+UzWh+w=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=yrG2upzU41xsod4UlKXrHQZLphAK9hwlC81kSbq8ayF9E6nUEUYjN6Q3U9LuCGB8l
	 Fbov1MLsBzdtGqGUNojulDRgVMoY9pf+dG33ons4uRCU9HxtEynSgfZamOyi/be+NQ
	 B7bsbZ28b4kdFuCZChR/IHtIdxQkHDEOCyVyQC9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgHRQ41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:56:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbgHRQyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:54:20 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF618207DA;
        Tue, 18 Aug 2020 16:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597769660;
        bh=8qiooKqbIY5buvznR0kFH1lZk03u/d1h4s6h+UzWh+w=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=KzyrYJRY/SUg2zTX0I7Qe3AjmpADPvAFy1Ho9yYgcUAqTKntd0HBNEZiVYlRCoGho
         vL4oHNfjuIkQLJ76ShY6jXtC1fgVx0Gw/55CcmOFxiKmczA+8OpEhbfaOLnonsnGyy
         Xxd/GkdFHy1e3XFPP7dS+jt7CBKR99x5qoG23YYE=
Date:   Tue, 18 Aug 2020 17:53:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     robh@kernel.org, tiwai@suse.com, lgirdwood@gmail.com,
        Dan Murphy <dmurphy@ti.com>, perex@perex.cz
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200817172151.26564-1-dmurphy@ti.com>
References: <20200817172151.26564-1-dmurphy@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: tas2562: Remove tas2562 text file
Message-Id: <159776961933.56094.16343409470039919349.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Aug 2020 12:21:50 -0500, Dan Murphy wrote:
> Remove the tas2562 text file as the tas2562.yaml is now available.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] dt-bindings: tas2562: Remove tas2562 text file
      commit: b1e78c9fcca83d3666bc149ba8ecc1e472759359
[2/2] dt-bindings: tas2562: Add device specification links
      commit: da9afe50ae2aac72d1b213d028d4e865c7ea9ba3

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
