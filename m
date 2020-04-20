Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71023C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4669D20857
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587392842;
	bh=iHr1Cn1jxEVva69HoDHFKc/6TcVS4pEiRER0S2RgaRg=;
	h=Date:From:To:In-Reply-To:References:Subject:List-ID:From;
	b=qu5fso41RrcG4/4F+h1fdW2MEDb1l6gpaWUJvW7Y/0QESyEq09mlQY0HJU4PGutVS
	 2rEX2xDMvYgIDoDNdWOjpldLw/4JD+HfMDB0cxktNP0fu+fgcrgkiJMQrWr13nR8E+
	 66CGPfx5+iY/cbD6EofzGB1JSKqbu4iwuJC0Y4k4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbgDTO1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:27:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgDTO1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:27:21 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBD25206DD;
        Mon, 20 Apr 2020 14:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587392840;
        bh=iHr1Cn1jxEVva69HoDHFKc/6TcVS4pEiRER0S2RgaRg=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=yN4WOCrpgTKIeQzG9EZzX1QBBpnnaUJpzjI9jAPMJPHEkDmuniO0zx7hFkhKMpzeY
         efH+aDy3yze63LTFbBY13mL4d0mJENhNQnbeDHVYzP2aXKtQqyQs+NLxZS5canCOzU
         IEXHqG3qX0g+DQmpxZ/wiS1+5DItg6NUbmxkvjNw=
Date:   Mon, 20 Apr 2020 15:27:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, linux-kernel@vger.kernel.org,
        Jason Yan <yanaijie@huawei.com>, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz
In-Reply-To: <20200420042847.19206-1-yanaijie@huawei.com>
References: <20200420042847.19206-1-yanaijie@huawei.com>
Subject: Re: [PATCH] ASoC: wcd9335: remove unneeded semicolon
Message-Id: <158739283776.7647.16702267883187620715.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Apr 2020 12:28:47 +0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> sound/soc/codecs/wcd9335.c:2606:2-3: Unneeded semicolon
> sound/soc/codecs/wcd9335.c:3619:2-3: Unneeded semicolon
> sound/soc/codecs/wcd9335.c:2849:2-3: Unneeded semicolon
> sound/soc/codecs/wcd9335.c:2955:2-3: Unneeded semicolon
> sound/soc/codecs/wcd9335.c:2988:2-3: Unneeded semicolon
> sound/soc/codecs/wcd9335.c:3960:2-3: Unneeded semicolon
> sound/soc/codecs/wcd9335.c:3776:2-3: Unneeded semicolon
> sound/soc/codecs/wcd9335.c:3924:2-3: Unneeded semicolon
> sound/soc/codecs/wcd9335.c:3355:2-3: Unneeded semicolon
> sound/soc/codecs/wcd9335.c:3832:2-3: Unneeded semicolon
> sound/soc/codecs/wcd9335.c:3079:2-3: Unneeded semicolon
> sound/soc/codecs/wcd9335.c:3089:2-3: Unneeded semicolon
> sound/soc/codecs/wcd9335.c:3232:2-3: Unneeded semicolon
> sound/soc/codecs/wcd9335.c:3878:2-3: Unneeded semicolon
> sound/soc/codecs/wcd9335.c:3578:2-3: Unneeded semicolon
> sound/soc/codecs/wcd9335.c:3728:2-3: Unneeded semicolon
> sound/soc/codecs/wcd9335.c:1922:3-4: Unneeded semicolon
> sound/soc/codecs/wcd9335.c:1938:3-4: Unneeded semicolon
> sound/soc/codecs/wcd9335.c:1944:2-3: Unneeded semicolon
> sound/soc/codecs/wcd9335.c:3144:2-3: Unneeded semicolon
> sound/soc/codecs/wcd9335.c:2568:2-3: Unneeded semicolon
> sound/soc/codecs/wcd9335.c:2219:2-3: Unneeded semicolon
> 
> [...]

Applied to

	https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

Thanks!

[1/1] ASoC: wcd9335: remove unneeded semicolon
      commit: 6b6d5043621fff6e71b7501018a4d58a59cf9527

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
