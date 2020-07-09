Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE95C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 965232076A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594332040;
	bh=AqnzHMtkycd/r+DqUiRAj0rilhO1VPkem/b8qz1IVFs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=HGHFQhnKlb8RzpI/LEEZtglsl3ZI3I9dp4Djt6XsNtgITd8GJd41BCExeVqawWIii
	 lCtyxN6H2fZqlPw10LHqyY86434fOMamNwJT2R4lrY9d52QKrI7UvNx7Pnk+ae3HOY
	 ifGRQTrinu33p2IpeOpqLGP5ceJGirnGwQG03/hQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgGIWAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 18:00:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgGIWAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 18:00:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F31CA2067D;
        Thu,  9 Jul 2020 22:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594332038;
        bh=AqnzHMtkycd/r+DqUiRAj0rilhO1VPkem/b8qz1IVFs=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=v93DrKHkPzY9X5bhd8xywntKJgEnUuse0gtBqgsT5SDChhK8xRTOyCc0+DQDayzAE
         /X2BmRu23cAlTk6FZ5FJqQS4O4Y5Rc7UOx5Cd8nNO8ni0mPHIpDG+2ssvvn8OOfTlu
         vyunLVCKcAax6505mESwHsfO7FexsQQfEguQidIw=
Date:   Thu, 09 Jul 2020 23:00:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     tiwai@suse.com, ludovic.desroches@microchip.com,
        alexandre.belloni@bootlin.com, lgirdwood@gmail.com,
        nicolas.ferre@microchip.com
In-Reply-To: <20200708101249.2626560-1-codrin.ciubotariu@microchip.com>
References: <20200708101249.2626560-1-codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH v3] ASoC: atmel-classd: remove codec component
Message-Id: <159433200031.57213.7392401769698717985.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jul 2020 13:12:49 +0300, Codrin Ciubotariu wrote:
> The CPU and the codec both are represented now as components, so for
> CLASS-D we are registering two componenets with the same name. Since
> there is no actual codec, we will merge the codec component into the
> CPU one and use a dummy codec instead, for the DAI link.
> As a bonus, debugfs will no longer report an error when will try to
> create entries for both componenets with the same name.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel-classd: remove codec component
      commit: 1dfdbe73ccf95765135b1b1ee8335ea3cb16bca0

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
