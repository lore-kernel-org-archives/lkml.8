Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E39C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69A6920825
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596469994;
	bh=OWnDWHU1nzLolfdwMe0Fa5jUjJmt5+xy6CpjufWsnfQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=MVtcvhE2xgW/5ePVS5C1YsdNpTDidnujpTCJQ9bXb19RIgfW6URq3W/mMxsmjCZ7O
	 HidWdcvkqKnRYmL+DEqLGsxj8vxqv3Xaviz+n4iysLSGY4aBqweKHvU9SlObB73WZn
	 ChCe8Fl5B0X2k2EKCgKp0YQkb8lPh6OAUYv9h6GU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgHCPxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:53:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbgHCPxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:53:13 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF1FD207DF;
        Mon,  3 Aug 2020 15:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596469992;
        bh=OWnDWHU1nzLolfdwMe0Fa5jUjJmt5+xy6CpjufWsnfQ=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Po5A1vzq3VziCr7L2CLivyi0NO2JNMPTLL80UxtgiFfLqJbHTsxPiS4qy8DsGlugP
         uxvVM+85z9YZOpuMYQ2qF1FS/mnpmDsOqdlxIr4c3hpxJV587Nr4VhZWmk+tnQTRW5
         4zs19PW1tQT9lYBUXRi+ojUKqpiletGC7xDiZKAU=
Date:   Mon, 03 Aug 2020 16:52:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20200729130839.10a9bf88@xhacker>
References: <20200729130839.10a9bf88@xhacker>
Subject: Re: [PATCH v2 0/4] regulator: mp886x: two features and dt json convert
Message-Id: <159646997224.2690.15922098911001927310.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jul 2020 13:08:39 +0800, Jisheng Zhang wrote:
> This is to improve the mp886x regulator driver support.
> patch1 implments .set_ramp_delay
> patch2 and patch3 support the switch freq setting
> patch4 converts dt binding to json-schema
> 
> Since v2:
>   - put any schema conversions at the end of the series as Mark
>     suggested.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: mp886x: implement set_ramp_delay
      commit: 0eddcf0267f913cb6336af64cadaf5acf6b19b7b
[2/3] regulator: mp886x: support mps,switch-frequency
      commit: b4b85af052f434bc3be5ee18462164986618feb1
[3/3] regulator: mp886x: support setting switch freq
      commit: ee6ad5a24575071b66bd37ffb2d8747a64fcb45f

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
