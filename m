Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA35C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 11:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B57920738
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 11:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ivbFmx19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgH3LFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 07:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgH3LFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 07:05:17 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C388DC061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 04:05:14 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c15so3170120wrs.11
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 04:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+gapKvtqVL4A5DDW8eESdE7vLROc6PFHC2USxeOexv0=;
        b=ivbFmx19jzkrujZR22GqxHw8+yCLuysq7xSMQ8dBB2CT2t3FfoBKWj4jr8hBQdbEpA
         9KipZlMkP21Kau2w749MNR6EeVd04EEiDEeqsksTPR+XY9z4VO46rGbgny8GlzIP3JQC
         AVCDSR5Y4DodbAVPHQwPNYNJe5JJI/R5M+6H8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+gapKvtqVL4A5DDW8eESdE7vLROc6PFHC2USxeOexv0=;
        b=N+qiGicz3hWKigu3Q/1t4bSSkuyjjtpydCIScKcSaGfwP1t70To3+y8x9YnOyfCYtI
         qHeY4DEEVa/FwjPXoGwkWZDyrggfv+1pSKm4sNG7isDKD5BrDThe4niPZ23K6+IE1/g3
         YTTFMpN67QqB1QnZ6sNTt+s4XfOiArN+JnZThXNYUBkccOxfBYDnTmnppKH4HcTjBXrP
         pLEYqt9WKtN4M2vKXumo8xdpkhFuZ0nIZDEOI6fNBdp930owtAhixdjk8qosfpm2lffX
         tVmZfSnViJ+KxdU/X2MTc6fyAJxmglbZ30pV7+raVdZKEAA0JFYUX5gs4c221hq7e8cM
         /g/A==
X-Gm-Message-State: AOAM5309DNVcDOiFe58Ya1tVXFTkjwxwO4Z87zRHfJVlX70i/bl7e/0G
        HD7hsxBlqPTiNCOsl/1OaXuxBA8BqBdZ9EtgejT2XA==
X-Google-Smtp-Source: ABdhPJz6S7KlVIQ+jF4DcOJClBsVEG+nqn+q+JFI/KzLmRup7UV+T1RYuwmr8EEore1ZJB3BAb+4Rnc+4gTbFVY/PdQ=
X-Received: by 2002:a5d:4ccb:: with SMTP id c11mr6954453wrt.159.1598785508966;
 Sun, 30 Aug 2020 04:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200828162005.1.I4f67f494c4f759b0e5c7f487e040dfdcf16e0876@changeid>
In-Reply-To: <20200828162005.1.I4f67f494c4f759b0e5c7f487e040dfdcf16e0876@changeid>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Sun, 30 Aug 2020 19:04:42 +0800
Message-ID: <CAFv8NwL-s0c_nFWKHmBKgPVeLXwGWdgV+fUtw8MLBJw2D3ox1w@mail.gmail.com>
Subject: Re: [PATCH] ASoC: rt5682: Prefer async probe
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 7:20 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> The probe of rt5682 is pretty slow.  A quick measurement shows that it
> takes ~650 ms on at least one board.  There's no reason to block all
> other drivers waiting for this probe to finish.  Set the flag to allow
> other drivers to probe while we're probing.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> NOTE: I haven't done any analysis of the driver to see _why_ it's so
> slow, only that I have measured it to be slow.  Someone could
> certainly take the time to profile / optimize it, but in any case it
> still won't hurt to be async.


Hi Doug, thank you for the fix.

There are multiple usleep in the probe of rt5682 driver.
The major one is a 300 ms sleep after the regulator turns on.
There are other sleeps for several tens of ms.
>
>
> This is a very safe flag to turn on since:
>
> 1. It's not like our probe order was defined by anything anyway.  When
> we probe is at the whim of when our i2c controller probes and that can
> be any time.
>
> 2. If some other driver needs us then they have to handle the fact
> that we might not have probed yet anyway.


Agree.
soc-core already handled this by returning -EPROBE_DEFER when a
component is not found.
So the machine driver can probe again.
Even in the current behavior, we already see machine driver probe
again when the codec driver is not ready,
so I think adding this async flag will not affect the machine driver.

>
>
> 3. There may be other drivers probing at the same time as us anyway
> because _they_ used async probe.
>
> While I won't say that it's impossible to tickle a bug by turning on
> async probe, I would assert that in almost all cases the bug was
> already there and needed to be fixed anyway.
>
>  sound/soc/codecs/rt5682-i2c.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/soc/codecs/rt5682-i2c.c b/sound/soc/codecs/rt5682-i2c.c
> index 85aba311bdc8..6b4e0eb30c89 100644
> --- a/sound/soc/codecs/rt5682-i2c.c
> +++ b/sound/soc/codecs/rt5682-i2c.c
> @@ -294,6 +294,7 @@ static struct i2c_driver rt5682_i2c_driver = {
>                 .name = "rt5682",
>                 .of_match_table = rt5682_of_match,
>                 .acpi_match_table = rt5682_acpi_match,
> +               .probe_type = PROBE_PREFER_ASYNCHRONOUS,


One thing I am wondering is that there has not been any usage in codec
driver for this.
I think every codec driver can use this, and take the benefit of a
possible faster boot time ?

>
>         },
>         .probe = rt5682_i2c_probe,
>         .shutdown = rt5682_i2c_shutdown,
> --
> 2.28.0.402.g5ffc5be6b7-goog
>
