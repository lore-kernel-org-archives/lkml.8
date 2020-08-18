Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0365C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFB7720829
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597769819;
	bh=/wLU2CDdRv6SSSUVf9PLh6PRAK0Mxi2PgY4Zys9S4aU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=p9Nax7t0d2xfa04iBhggpKkZX0v9bIRQodSK21XVmWnxRYi2W1a5GoDGvy7xdPJLO
	 J8xUnzL0qZyRLGliNXwfI/xIecZ/dHx4pUau5MpIvfwCcRvpzKRlUOF2mEjuo/UmOM
	 KlxgWKeJwzd/vv7ijlcj17ASYkRKxJj69ZpmOMcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgHRQ44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:56:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728463AbgHRQ4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:56:11 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B603B20829;
        Tue, 18 Aug 2020 16:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597769771;
        bh=/wLU2CDdRv6SSSUVf9PLh6PRAK0Mxi2PgY4Zys9S4aU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=J39oCvdRk1AZdO4sOeWt7Y98pvyzVuNk1J2c51gTPDEMSRWBXFLmttCW3tDRINPl+
         uAWizb9IPpu5jFYbbzQH3Ptlo/Z+1Fa7HD4T0WqiRGhC/2S9EKMT7NNCDPwLsuTRFk
         Q4HjoJ3PJrbOhKOuCdjYAFpRXyk78ucHdegOBBko=
Date:   Tue, 18 Aug 2020 17:55:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     ckeepax@opensource.cirrus.com,
        pierre-louis.bossart@linux.intel.com, vkoul@kernel.org,
        tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20200727093806.17089-1-srinivas.kandagatla@linaro.org>
References: <20200727093806.17089-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 00/10] ASoC: qdsp6: add gapless compressed audio support
Message-Id: <159776961930.56094.14674636616850967795.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jul 2020 10:37:56 +0100, Srinivas Kandagatla wrote:
> This patchset adds gapless compressed audio support on q6asm.
> Gapless on q6asm is implemented using 2 streams in a single q6asm session.
> 
> First few patches such as stream id per each command, gapless flags
> and silence meta data are for preparedness for adding gapless support.
> Last patch implements copy callback to allow finer control over buffer offsets,
> specially in partial drain cases.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/10] ASoC: q6asm: rename misleading session id variable
        commit: 99b7db5f6d4090e98eee79cefc8521fdf4f46ad8
[02/10] ASoC: q6asm: make commands specific to streams
        commit: 789e3b6c5238448a6dcfc9bc998dfe3ea9d87150
[03/10] ASoC: q6asm: use flags directly from q6asm-dai
        commit: e0c078a8da333eb45745d1c5e4b72f0314b8b742
[04/10] ASoC: q6asm: add length to write command token
        commit: 50d4e2146cdd48fcc1cd748dfb06dd0fc486eb26
[05/10] ASoC: q6asm: add support to remove intial and trailing silence
        commit: 39376129783168c51981bd2c195a1d10ae63104f
[06/10] ASoC: q6asm: add support to gapless flag in q6asm open
        commit: 983b8864f6033336e619a5936a02aea3026c5742
[07/10] ASoC: q6asm-dai: add next track metadata support
        commit: 135bd5ea190f3e31d2289da98a53d28e1be5b6bf
[08/10] ASoC: q6asm-dai: prepare set params to accept profile change
        commit: 5b39363e54ccca8fee700e5cc6acf42a80ff1de3
[09/10] ASoC: q6asm-dai: add gapless support
        commit: ee941a338ad67dfd852826eec381d8584edf29f2
[10/10] ASoC: q6asm-dai: add support to copy callback
        commit: a08cd56a45245ea422d77e7ee5ce20d5f21f5b5d

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
