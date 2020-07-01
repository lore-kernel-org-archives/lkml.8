Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50E6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70D1020853
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593642175;
	bh=OFrydZJeoFPPEIsSLHrZKo0VwyTkGxBPs8O02wurO8c=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=VTGihIw8Qf0NrnG7759wNlZF0NfTnKSzw4FmtjVu4yanQT2nZzjr5ceHcnhtDALRB
	 iJSwdqn/oEXfuV4o+mOfvMDpyFpkg7hnYlnciMRJTRpv5+184XIRgELy433YXIRfNP
	 cN+QX4OQf76ZzzEcGv8ArBFUL7A/oTCkN7jzUPs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgGAWWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 18:22:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbgGAWWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 18:22:53 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FECC20780;
        Wed,  1 Jul 2020 22:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593642173;
        bh=OFrydZJeoFPPEIsSLHrZKo0VwyTkGxBPs8O02wurO8c=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=GZmWkYxOPzNNwVuxMoom4aqXVWovfXQu5bh8J4JDJXzgKkCGB4x2B/cruDd3rb6vZ
         xnwKuwmSM6EhpXr62i0t+39R4R8UXTplPBFXdE33qXlH3/OFzBeXTNL+2al91kXXH8
         W0YzNqLrr9zyF0wdf0ojuL+uoUnTuE/7ZIoykru0=
Date:   Wed, 01 Jul 2020 23:22:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        Heiko Stuebner <heiko@sntech.de>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>
In-Reply-To: <20200630091615.4020059-1-yuhsuan@chromium.org>
References: <20200630091615.4020059-1-yuhsuan@chromium.org>
Subject: Re: [PATCH] ASoC: rockchip: add format and rate constraints on rk3399
Message-Id: <159364215573.10630.1998520137231805857.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020 17:16:15 +0800, Yu-Hsuan Hsu wrote:
> S8 and S24 formats does not work on this machine driver so force to use
> S16_LE instead.
> 
> In addition, add constraint to limit the max value of rate because the
> rate higher than 96000(172000, 192000) is not stable either.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rockchip: add format and rate constraints on rk3399
      commit: 1eb96c198aff13162de4857e19f9488d59c4acb1

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
