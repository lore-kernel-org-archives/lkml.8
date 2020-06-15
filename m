Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5990CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CE7A207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592264461;
	bh=wmMrTJlDcXeeLr5UjbU5+uAWskHZyXjosJMgpE4Z/Ys=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=UCPCBrNaPZKZPRVNkq5Jc5ElJuF01HESPYnwT8YODPRcdVtEygts4oY/zaGyYz2Sd
	 52ezLhR8yp9nTKieD9ZtBmhRrHPhcxqQ7OGMnv79IzCIcF0eHjGLrYMSVjSpGV7KPP
	 cL81sB/5hXptineUQg2kTcSnEJZ0Wz6khN28hYZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgFOXk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgFOXk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:40:56 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3B46208C7;
        Mon, 15 Jun 2020 23:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592264456;
        bh=wmMrTJlDcXeeLr5UjbU5+uAWskHZyXjosJMgpE4Z/Ys=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=FMytGS/l9Q7rfRAWWuUJCjK4MdsYQ2tN5IbvduDrZtNhidlx8yhZFOPzGNUGHL5GW
         v9X3c71oALhFIQgqNdVKcPZ89EWHihH25poCzcxKLBrGUYKbqvAn3F1mFvdoO5iYbY
         0icsalBe+CJcIfNBdvnAOTaxIYIvjfkZiwZSGleI=
Date:   Tue, 16 Jun 2020 00:40:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>, lgirdwood@gmail.com,
        matthias.bgg@gmail.com, tiwai@suse.com, hariprasad.kelam@gmail.com
Cc:     tzungbi@google.com, howie.huang@mediatek.com,
        linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <1591353222-18576-1-git-send-email-jiaxin.yu@mediatek.com>
References: <1591353222-18576-1-git-send-email-jiaxin.yu@mediatek.com>
Subject: Re: [PATCH v2 0/2] ASoC: mediatek: mt6358: support DMIC one-wire mode
Message-Id: <159226439189.27409.5559737025420657238.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jun 2020 18:33:40 +0800, Jiaxin Yu wrote:
> v2 changes:
> 	1. Uses a DT property to select DMIC mode instead of a mixer control.
> 
> v1 changes:
> 	1. Uses a mixer control to select DMIC mode.
> 	2. patchwork list:
> 		https://patchwork.kernel.org/patch/11578309
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: mediatek: mt6358: support DMIC one-wire mode
      commit: c46fc800948c2d0afb548ca12453b837aa1ac880
[2/2] ASoC: dt-bindings: mediatek: mt6358: add dmic-mode property
      commit: 6323f13b4d927f52f339f7122676de0b0d1da3c3

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
