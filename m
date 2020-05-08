Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D8BC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 17:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD6812184D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 17:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588960342;
	bh=EDs/lYMTR6duIghKPZbNYHj/6gUoXDqvRRCEyYxbEkI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-ID:From;
	b=UKLZ9n2/fDMUY/5DUDZrF4p7Gp5ndqeU1bj01rkmwDllm7A3ldwqY4Vxmj6RvvBaV
	 B+0mupuO5THH0ONG88HnnVpwUh2ug0Tb4MvEWb3/qHXjKgNOwpCjbPyMRGidsLSIU+
	 ZblknDiTXaXOAX7pma+hS0G6lPpACprw1au8NmK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgEHRwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 13:52:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbgEHRwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 13:52:21 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01225214D8;
        Fri,  8 May 2020 17:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588960341;
        bh=EDs/lYMTR6duIghKPZbNYHj/6gUoXDqvRRCEyYxbEkI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=xtFHQ65M8//3Kdj9pvdEYPBRc65XqqD98KyVRpHIl5iSz5KGl1sXzJuONIQKV7kCh
         xaPdSp4CQ5M6gseF88Y8cuya23MlgOMfVkFjj9tlpVWh5/Q1wo+SNF4KLhkTdk5fsR
         JoMPvJrGnsLwtGyBYtp3OkLUkmK9ZBUaYWA1aDgc=
Date:   Fri, 08 May 2020 18:52:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <20200507213405.1869430-1-arnd@arndb.de>
References: <20200507213405.1869430-1-arnd@arndb.de>
Subject: Re: [PATCH] ASoC: cros_ec_codec: allocate shash_desc dynamically
Message-Id: <158896033901.2700.3513138380933416589.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020 23:33:51 +0200, Arnd Bergmann wrote:
> The wov_hotword_model_put() function has multiple large variables on
> its stack, the largest of which is the result of SHASH_DESC_ON_STACK().
> In total, this exceeds the warning limit for 32-bit architectures:
> 
> sound/soc/codecs/cros_ec_codec.c:776:12: error: stack frame size of 1152 bytes in function 'wov_hotword_model_put' [-Werror,-Wframe-larger-than=]
> 
> The function already has a dynamic crypto_alloc_shash() allocation, so
> using kmalloc() for the descriptor is correct as well and does not
> introduce any additional failure scenarios. With this, the stack usage
> of wov_hotword_model_put() gets reduced to 480 bytes in my test
> configuration.

Applied to

   local tree asoc/for-5.7

Thanks!

[1/1] ASoC: cros_ec_codec: allocate shash_desc dynamically
      (no commit info)

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
