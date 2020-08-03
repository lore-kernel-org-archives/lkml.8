Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DB4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32BF52076C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596470001;
	bh=71RlaA/oiOsU/NlJe6OnT3n6w5fGruNHnxupVgtHzpo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=Ia162YpBXQ6kx2STyoRsbJA2s9q3PYlQgPZXMTg/2wqUoPPlckwd0zFdNoOYpXuJG
	 H4QOyqBclTdr7pn3WSf2EHV8nzFlbDDDtBw+gU8jYSoDrYYVXCqkkTtfEmVnHa5wY0
	 VttIjhNE0irl569s+FMQf+1f+TDiBgM+elOGjn70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgHCPxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:53:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbgHCPxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:53:18 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 022F9207FB;
        Mon,  3 Aug 2020 15:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596469997;
        bh=71RlaA/oiOsU/NlJe6OnT3n6w5fGruNHnxupVgtHzpo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=moKWxM3xpeRrjeXk6CUkXrvSHLqb/VSX+FXHYEaMMAfbVUtzmdhMHoG8ih6UPR5qB
         YJYRB+Rdqz0HmOrLrDc3R9mVhch76uktHkMaBXb/PM5+axJhMt19P0E7XlVbET2ygX
         BH8raNtY4SBNeGozRAbbUOz2PwrWLFsTySbDXLO8=
Date:   Mon, 03 Aug 2020 16:52:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>
In-Reply-To: <20200802032509.305425-1-axel.lin@ingics.com>
References: <20200802032509.305425-1-axel.lin@ingics.com>
Subject: Re: [PATCH] regulator: cros-ec-regulator: Add NULL test for devm_kmemdup call
Message-Id: <159646997224.2690.10343483112359968082.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Aug 2020 11:25:09 +0800, Axel Lin wrote:
> Fix possible NULL pointer dereference.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: cros-ec-regulator: Add NULL test for devm_kmemdup call
      commit: 3eccc72b0c3462a6047aa0f85c50263a0a58b001

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
