Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA93C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 133732086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595535606;
	bh=vCjA4xAHthSGepbuGA6kdiCjzE3kR6rTvpa8c9jbL9U=;
	h=Date:From:To:In-Reply-To:References:Subject:List-ID:From;
	b=nLYphxzCFaIwdO5ZRVzIcHnlehtbA/eEHCPJsq8P/gxvIy4sKScv9FyfQsCJZ+arV
	 Lrpq3OiPR6co5vPm/vzQOaIP8/Q4P6TFDVpRuCVzhTJmV4oGOStBdyVtzlaau/u6kd
	 5iVW4vZZS64RQFfnN3ffRRqgxzDwLPETUom+64ow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgGWUUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:20:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgGWUUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:20:04 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C120B207BB;
        Thu, 23 Jul 2020 20:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595535604;
        bh=vCjA4xAHthSGepbuGA6kdiCjzE3kR6rTvpa8c9jbL9U=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=c4fbNaJIGSCpqPBYzahcz+q7OorgPf3XhLcT9Cf3ysLkbI/UkuixZWdP94r2NxfJ8
         AiGV9IST2KNScmeLrkuz4/g1HmvfRaknpW5rooZXF4iRII7URZfnkBXL1t0xbazEzT
         Yp4NhqPFz5180ezkGShvyX2xNhHX6gWVmyAF6krk=
Date:   Thu, 23 Jul 2020 21:19:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        alsa-devel@alsa-project.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        peter.ujfalusi@ti.com
In-Reply-To: <20200718110857.11520-1-grandmaster@al2klimov.de>
References: <20200718110857.11520-1-grandmaster@al2klimov.de>
Subject: Re: [PATCH] ASoC: ti: Replace HTTP links with HTTPS ones
Message-Id: <159553557415.41908.3344593909115840356.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jul 2020 13:08:57 +0200, Alexander A. Klimov wrote:
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

[1/1] ASoC: ti: Replace HTTP links with HTTPS ones
      commit: f68440508deac56a715a0b48c375f557e10692ac

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
