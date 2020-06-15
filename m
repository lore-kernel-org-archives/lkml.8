Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAF7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 277052080D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592264396;
	bh=SQlV530bPjjPvR30LwWFKM4Pz8BNs9PTNsVr0NiaVwM=;
	h=Date:From:To:In-Reply-To:References:Subject:List-ID:From;
	b=sbMv/hjp9KL1KjWyysDrWJBnQV7bvF0+RItnAWy9kALGHzaRdUkEjS1r2jkyyAqcZ
	 m+N4rud5jlP/4/h3VZKNLKzTQMIJuSOB05hX1mEekxzDWt0/hdmm4DRfe9w8kSJUzf
	 7KnAVcB8B+moaAjZ4BJH3OBR2cssfYbjiDIBnf6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgFOXjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:39:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbgFOXjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:39:54 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90444207D3;
        Mon, 15 Jun 2020 23:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592264394;
        bh=SQlV530bPjjPvR30LwWFKM4Pz8BNs9PTNsVr0NiaVwM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=zFMg8y0fAGwftTta/tytvxkoiu9LWJZQt1Qfg9MninHiG2+X1yuLl/CnsNkDBry9J
         PSKKJ3QnS0PpaLn2+rxYSm2kyHLM8q91kW+0ymlwCEPSv5DkSEuXdRd50Kyy/QBgZe
         3ex/l52wIPcCBJSyu5J/IxAhaX2iCTVbkRS7QAwA=
Date:   Tue, 16 Jun 2020 00:39:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     robh+dt@kernel.org, s.nawrocki@samsung.com, perex@perex.cz,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        sbkim73@samsung.com, Jonathan Bakker <xc-racer2@live.ca>,
        krzk@kernel.org, linux-kernel@vger.kernel.org, tiwai@suse.com,
        devicetree@vger.kernel.org
In-Reply-To: <BN6PR04MB066019A8783D22F1C4A588B7A39F0@BN6PR04MB0660.namprd04.prod.outlook.com>
References: <20200614202411.27843-1-xc-racer2@live.ca> <BN6PR04MB066019A8783D22F1C4A588B7A39F0@BN6PR04MB0660.namprd04.prod.outlook.com>
Subject: Re: [PATCH 1/3] dt-bindings: sound: Document wm8994 endpoints
Message-Id: <159226439190.27409.3267651095489204522.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jun 2020 13:24:09 -0700, Jonathan Bakker wrote:
> The wm8994 exposes several inputs and outputs that can be used by
> machine drivers in their routing.  Add them to the documention so
> they don't have been duplicated in any machine drivers bindings.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: Document wm8994 endpoints
      commit: 3f2ec71cb8f5c9605b5d45918ceefcde9b97b672
[2/3] ASoC: Add bindings for Samsung Aries audio complex
      commit: 14ebd62c12dc89a0087bf86e79548ee9a6d93625
[3/3] ASoC: samsung: Add driver for Aries boards
      commit: 7a3a7671fa6c7e90aff5f4242add2a40587b85ef

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
