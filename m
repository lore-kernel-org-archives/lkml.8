Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BB6C433EC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67E6220729
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595425491;
	bh=laniH5UgS3DrsXSeVguJDybYLw25gKEKrpalctaeV8A=;
	h=Date:From:To:In-Reply-To:References:Subject:List-ID:From;
	b=Yl7aY8pWCEFKxOBfNfnC3YRJjk8M3MeqFHjEkeXBlajZZecUYo+jyIo0TDgqrJaV0
	 nlIRbhh8Kg4G8EARMNPGVGk1oDgbI1noLr+z1tWNZL4pzW0I1t0bYKgtuTyLCdwS5l
	 KHkipICcbM6u1VECRdxntEpV7G6crm0P/c8mudT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732556AbgGVNou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 09:44:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732544AbgGVNos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 09:44:48 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 349E62071A;
        Wed, 22 Jul 2020 13:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595425487;
        bh=laniH5UgS3DrsXSeVguJDybYLw25gKEKrpalctaeV8A=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=JtEvPKKk9ePwlbsUXe8JIGCNQffTKaHbDfykpD21/3zHX3D3gT0MMTXMr7SBk5bpS
         wQdGbvtpZT0xMqxLYHHRwk4cEyamAcnmxybYuGW04ts+28PbaXmStFP1+WQDJF+09F
         EUmnIcSkI84ICarie4DxC6YUhrDV+O44MfHCfpHw=
Date:   Wed, 22 Jul 2020 14:44:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, shifu0704@thundersoft.com,
        nikita.yoush@cogentembedded.com, rikard.falkeborn@gmail.com,
        devicetree@vger.kernel.org, yuehaibing@huawei.com,
        kuninori.morimoto.gx@renesas.com, corbet@lwn.net,
        cychiang@chromium.org, l.stach@pengutronix.de,
        dinghao.liu@zju.edu.cn, jbrunet@baylibre.com, perex@perex.cz,
        dmurphy@ti.com, linux-doc@vger.kernel.org, afd@ti.com,
        robh+dt@kernel.org, lkp@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, colin.king@canonical.com,
        tiwai@suse.com, "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        alsa-devel@alsa-project.org, keescook@chromium.org,
        tzungbi@google.com, linux-kernel@vger.kernel.org
In-Reply-To: <20200719153822.59788-1-grandmaster@al2klimov.de>
References: <20200719153822.59788-1-grandmaster@al2klimov.de>
Subject: Re: [PATCH for v5.9] ASoC: Replace HTTP links with HTTPS ones
Message-Id: <159542547441.19620.12700618394214218697.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jul 2020 17:38:22 +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Replace HTTP links with HTTPS ones
      commit: 5856d8bd308f9467cefa65d04e184a56a3977559

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
