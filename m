Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AACC3404C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4E422B48
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 23:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PZbm8bKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgBRXVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 18:21:50 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42097 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbgBRXVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 18:21:49 -0500
Received: by mail-ot1-f65.google.com with SMTP id 66so21309454otd.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 15:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qZJ5sy9EEUi9bug4wmXj8jM2aJaQXXTpwRiWKESLnzU=;
        b=PZbm8bKph8Jdx+grgVEWTO7UDtijaJLrtyF36mI5UZ1MzV0qv1ByxPnrwdQjeFufog
         g+0TQvQXIiNCQIFnio2gLjFYcMUDRyK6Auy1xNa8oDjg8lD2G519s7+5gWRQTkLqcCEw
         uyzan1wdR7UPSSElZl+21fMmayooLXRzzu7Byao1rd4VaHzSuMyFI9hHdFHqzFxoocjP
         Cz5saQmYlRRe0ZkPI55oY+jIUU35k2XHObETrcS0BCVI7REAyDn0YymULPCWJvTnXQWl
         +q0pIUz/hUTR1/rkDIrLV95A0YKCz0+uH7X5TOD/SRHOLiYk5p7mFMvRQRMb/+nFud6B
         5jxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qZJ5sy9EEUi9bug4wmXj8jM2aJaQXXTpwRiWKESLnzU=;
        b=EyapbhAMmQYe8hyfGplyDrnHacQ5eDxPsiNMk7sgAX7SmFtRWXO80Swy66+z+r+L8p
         IvnN3JdFnWMfRZqduO1yqnQAEOOzAixMh8IN7qCJJyCIjB5MdOtpEgXpXQiKlRms2+yI
         7kQ59AJAHXVM9l6JnRG49jSggZktwdrTpf2Y5cHvvBQxK0ZF9gEvqB+Yo5S8QY7ihsYj
         iTmrEXE2Hrxow/5NdaOiY4wxOXYdGaqDYHsAudLpoWcGYKi1hfvRY5SUF0rWRxcxy/ID
         ECiAX2Gx/VtOi5AMuEadU3u3bYmD8PooqkkANWMiA+LwowISZJKewrNg3r1kzFct00ZH
         jtGg==
X-Gm-Message-State: APjAAAU+O5ITpE5J9ym46PqGtIizGk08/JSJtJUq8nydLYlwgL4QHZI1
        5489igKVLGeyglzyf7qzAorjy2ObJ5/HU+WSvnLVng==
X-Google-Smtp-Source: APXvYqyjzBiyM8od+H9rUkwgiGfJWSxgCwepGjcqFR9huyWsnI/5DKW5vEodUdTTHs4qDgmTCmUwIGtmtfJbcxAjBX4=
X-Received: by 2002:a9d:7d93:: with SMTP id j19mr18386395otn.102.1582068108579;
 Tue, 18 Feb 2020 15:21:48 -0800 (PST)
MIME-Version: 1.0
References: <20200218220748.54823-1-john.stultz@linaro.org> <CAL_JsqK5eVCuKiy2R_=5cyEBFM=YvMODqDYrmJxLPyN-Em-++g@mail.gmail.com>
In-Reply-To: <CAL_JsqK5eVCuKiy2R_=5cyEBFM=YvMODqDYrmJxLPyN-Em-++g@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 18 Feb 2020 15:21:37 -0800
Message-ID: <CALAqxLUTNq-Dg5Nd4PozCUx3K0hnVEJYmNnkpnGWGhph8vNr8w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] driver core: Rework logic in __driver_deferred_probe_check_state
 to allow EPROBE_DEFER to be returned for longer
To:     Rob Herring <robh@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 2:51 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Feb 18, 2020 at 4:07 PM John Stultz <john.stultz@linaro.org> wrote:
> >
> > Due to commit e01afc3250255 ("PM / Domains: Stop deferring probe
> > at the end of initcall"), along with commit 25b4e70dcce9
> > ("driver core: allow stopping deferred probe after init") after
> > late_initcall, drivers will stop getting EPROBE_DEFER, and
> > instead see an error causing the driver to fail to load.
> >
> > That change causes trouble when trying to use many clk drivers
> > as modules, as the clk modules may not load until much later
> > after init has started. If a dependent driver loads and gets an
> > error instead of EPROBE_DEFER, it won't try to reload later when
> > the dependency is met, and will thus fail to load.
> >
> > This patch reworks some of the logic in
> > __driver_deferred_probe_check_state() so that if the
> > deferred_probe_timeout value is set, we will return EPROBE_DEFER
> > until that timeout expires, which may be after initcalls_done
> > is set to true.
> >
> > Specifically, on db845c, this change (when combined with booting
> > using deferred_probe_timeout=30) allows us to set SDM_GPUCC_845,
> > QCOM_CLK_RPMH and COMMON_CLK_QCOM as modules and get a working
> > system, where as without it the display will fail to load.
>
> I would change the default for deferred_probe_timeout to 30 and then
> regulator code can rely on that.

That is exactly what I do in the following patch! Let me know if you
have further suggestions for it.

> Curious, why 30 sec is fine now when
> you originally had 2 min? I'd just pick what you think is best. I
> doubt Mark had any extensive experiments to come up with 30sec.

I had two minutes initially as, due to other delays I still have to
chase, booting all the way to UI on the db845c can sometimes take
almost a minute. So it was just a rough safety estimate. But in v2, I
tested with the 30 second time used by the regulator code, and that
seemed to work ok.

As long as 30 seconds is working well, I'm ok with it for now (and it
can be overrided via boot arg). Though from past experience with
enterprise distros running on servers with tons of disks (which might
take many minutes to initialize), I'd suspect its likely some
environments may need much longer.

thanks
-john
