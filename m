Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE68C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7518E2145D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BGahHi6r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgICILP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgICILH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:11:07 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF55C061258
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 01:10:55 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id y3so1268552vsn.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 01:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2vKxy+BrmTM4erbpnPuK1egVjffH6omXH5GzoO/2vE8=;
        b=BGahHi6rbzLUYAczxpoLOJeX76V5ePq6YWfzkIwa5saJL7xUSVSICFCjkHep3epSJu
         rj+jUuLnHYK32M8oSkW8+gX+3ldm76XAHBm8ucUvrdnKGglYNa8HHMNqFlbogIUcaI5C
         Z6mB9DQo/5HjX8TIrJ2syEftgA4yQiLeMWsrlVPiSP5j/0WyJ8PymoCJ9t4j6+cIPlZa
         3WUJJDOAAlQlq/jZGMpLJM7nkpB29yPtyG5zqbB9yGNGQp3bHkZbUs9sosiPXKECiMiv
         qf9fXJiTMt+Pk0ox4OVvfUoSGijk9thIg1ULv6G0vF1x9q5e3mhfcikygDNoODWOpTxC
         sEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2vKxy+BrmTM4erbpnPuK1egVjffH6omXH5GzoO/2vE8=;
        b=ip1QBULBs/0SSqUZAgWNNX1RMougcCCpKYIbgxOeKm6X99nm7WPT8sTN52XvCVFrpe
         jZiYgwd46sQE32tNfiGCGc5tYsGXOPX8L1SDxa+O2eEo3+yt9EARKkCdu0m9TkqQGobQ
         0pzXJincaJ+guQnDZOq3xkamOO1wYzBVS1rGhgCbsr1PSgYz0x665JESyJTsRUhDHwfP
         qPZaqw/14tqHKMCnwPVA6JwDHuRA68Af3JPWT48tssA3PWMMb8AOZ3IU4rDB+lzOffOG
         ifOyX1hywth6TbrdgKbn7FeOBiTrVDRjgDEy9xg75mG8OiVVs85EL2Xmd/PU6LAxYLSc
         JiDA==
X-Gm-Message-State: AOAM530VmexX1+o49x6zjwjnrZbknpC9qTPVx1bcqycHwVV70+r/o2Cb
        sap3tB/3n4IZT3t3ZUS32UrrRdrkRtbWknrI6EVRGw==
X-Google-Smtp-Source: ABdhPJxfYTnSYJGxu7eCAxgLLa9ss8++NvwiXEVkjxbE5o6nKhbHft/MCQxM3aY3B+PhB/1QvL5Twv2LkkutkBBczpQ=
X-Received: by 2002:a67:f947:: with SMTP id u7mr841916vsq.135.1599120654486;
 Thu, 03 Sep 2020 01:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200902164303.1.I5e598a25222b4534c0083b61dbfa4e0e76f66171@changeid>
In-Reply-To: <20200902164303.1.I5e598a25222b4534c0083b61dbfa4e0e76f66171@changeid>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Sep 2020 10:10:17 +0200
Message-ID: <CAPDyKFoyKjKhwKGtLMtEyDSeSiBU6wasc=jt6c=sHnhN8jqqjg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-msm: Prefer asynchronous probe
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Sep 2020 at 01:43, Douglas Anderson <dianders@chromium.org> wrote:
>
> Turning on initcall debug on one system showed this:
>   initcall sdhci_msm_driver_init+0x0/0x28 returned 0 after 34782 usecs
>
> The lion's share of this time (~33 ms) was in mmc_power_up().  This
> shouldn't be terribly surprising since there are a few calls to delay
> based on "power_delay_ms" and the default delay there is 10 ms.
>
> Because we haven't specified that we'd prefer asynchronous probe for
> this driver then we'll wait for this driver to finish before we start
> probes for more drivers.  While 33 ms doesn't sound like tons, every
> little bit counts.
>
> There should be little problem with turning on asynchronous probe for
> this driver.  It's already possible that previous drivers may have
> turned on asynchronous probe so we might already have other things
> (that probed before us) probing at the same time we are anyway.  This
> driver isn't really providing resources (clocks, regulators, etc) that
> other drivers need to probe and even if it was they should be handling
> -EPROBE_DEFER.
>
> Let's turn this on and get a bit of boot speed back.

Thanks for a very well written commit message!

Indeed, I am sure many mmc host drivers could benefit from a similar
change. At least regular platform drivers and amba drivers are pretty
sure to work, but who knows.

>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/sdhci-msm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index d4c02884cca8..9dd0dbb65382 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2542,6 +2542,7 @@ static struct platform_driver sdhci_msm_driver = {
>                    .name = "sdhci_msm",
>                    .of_match_table = sdhci_msm_dt_match,
>                    .pm = &sdhci_msm_pm_ops,
> +                  .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>         },
>  };
>
> --
> 2.28.0.402.g5ffc5be6b7-goog
>
