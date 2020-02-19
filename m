Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A454C34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6905E207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UTz22aO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgBSCUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:20:40 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44552 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgBSCUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:20:39 -0500
Received: by mail-oi1-f193.google.com with SMTP id d62so22265212oia.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 18:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YYT6YZNCZsYRqHQEeWZi0Rtcai+ljMyFoBbjqMKSqxc=;
        b=UTz22aO9BW7ldKype5PMjKYgkdUXWZkCahIJ+RyHZG91H2zi2kNtgjOZDbZPuQjQfc
         /+4xIEr0CUk3JlchuehDeffQM5JKU85Hj+IOgrbEgRK6z9jBhpA87CFwmUbUwcnNZ0c+
         p1/wGJ4HmKnzMxuj1pfJuKceL84ivttiu1R0mQP19Dq4ml8/vJYbL6/o2Z6cMEWQRtHZ
         oiZ61kilcOkjq8KONZU8aWVeLkWoIJZoUj4Qz0B77fPjrJAw2sfd0f09a/rdPYGJOcaC
         WpssdrebShKO6EY3OEevPWjqtZ2QE32GaLiTQZsErZwKzKVRnm20oPRuTruQwoleCxC7
         m/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YYT6YZNCZsYRqHQEeWZi0Rtcai+ljMyFoBbjqMKSqxc=;
        b=WcRyAFsZ04mcb88qbvqPkCfIRMcEVhWbiUFXe2Ms/OQO3ioLbGLet+Z+ztbX+OB2Dd
         /jsDODMXlIVBpGyVEzasdAX/zMmalwwTyp5DZT4rnqM2U4UKynTExpwF/veHE4X1wFx+
         vY1WbGyg2S4nXJImZAx7Xf+ZW62PCwhP2vc8g05NfVBIk3Ro5U0X2n2DE58HKA/hIb5E
         HbTFcDSDdG0nn6uMBG22vUnOx04k9qGMeYn/d36KEpPC2yuBSnbAGBM9rFHQnUg97S6v
         xEQ7IlHFif09E8ZvTWCHX8IH2xAdEdftn+0yy/D7wQ8cSiH2XYo4PNqywpkIcsU0AIB1
         6Txw==
X-Gm-Message-State: APjAAAX9D5dOl3HVzBpKC2IgIngtsKgIXvNY+6wj7xv+zjFdZwWAIgxE
        jBHQkNHzwsSlbzXGAwlyO2jlbxXYoZrc4leYU64rjA==
X-Google-Smtp-Source: APXvYqyeq/1kr3UBsc2WTXKqbpQPEbbZqh8CMPINGqnKFEYX7pqqyj+Fk04yGXb+vCdmnpYvqdU5qlh8vlrkIUN0YVY=
X-Received: by 2002:aca:4789:: with SMTP id u131mr3091991oia.43.1582078838922;
 Tue, 18 Feb 2020 18:20:38 -0800 (PST)
MIME-Version: 1.0
References: <20200111052125.238212-1-saravanak@google.com>
In-Reply-To: <20200111052125.238212-1-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 18 Feb 2020 18:20:03 -0800
Message-ID: <CAGETcx-y8j21tCude5oxU3NbEmb91f_m1dWJa0wUALkA40pwfA@mail.gmail.com>
Subject: Re: [PATCH v1] clocksource: Avoid creating dead devices
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 9:21 PM Saravana Kannan <saravanak@google.com> wrote:
>
> Timer initialization is done during early boot way before the driver
> core starts processing devices and drivers. Timers initialized during
> this early boot period don't really need or use a struct device.
>
> However, for timers represented as device tree nodes, the struct devices
> are still created and sit around unused and wasting memory. This change
> avoid this by marking the device tree nodes as "populated" if the
> corresponding timer is successfully initialized.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/clocksource/timer-probe.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/clocksource/timer-probe.c b/drivers/clocksource/timer-probe.c
> index ee9574da53c0..a10f28d750a9 100644
> --- a/drivers/clocksource/timer-probe.c
> +++ b/drivers/clocksource/timer-probe.c
> @@ -27,8 +27,10 @@ void __init timer_probe(void)
>
>                 init_func_ret = match->data;
>
> +               of_node_set_flag(np, OF_POPULATED);
>                 ret = init_func_ret(np);
>                 if (ret) {
> +                       of_node_clear_flag(np, OF_POPULATED);
>                         if (ret != -EPROBE_DEFER)
>                                 pr_err("Failed to initialize '%pOF': %d\n", np,
>                                        ret);
> --
> 2.25.0.rc1.283.g88dfdc4193-goog

Gentle reminder.

-Saravana
