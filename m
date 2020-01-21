Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51682C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238D024655
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RoqRhv4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgAUXns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 18:43:48 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45105 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgAUXnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 18:43:47 -0500
Received: by mail-vs1-f67.google.com with SMTP id b4so3051239vsa.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 15:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l0cVQTQVrwBuo17vRzasO5aNMV6H7LXc1KjmW4LKTSw=;
        b=RoqRhv4rwOXVE5JdGIscFsks5I/vQLf6eXbS9iIHoneORd9WvL5QmK8qAm8bRfPTHF
         xuejoxBegei6h9YJHMl6gGE3M0wP64c3xeYE0etWkisB+RulWRuGr9uaBujlRGTKxtle
         RH2KWLZJR3Sjv6Vitb5RBTM+ZxYHYACwkk1qU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l0cVQTQVrwBuo17vRzasO5aNMV6H7LXc1KjmW4LKTSw=;
        b=eJExgwsvTSmN/hkPvHEjACM1PDqUhLYpcwgMxJ9svfrj3vfNwwtCCTFo25w588XC6K
         F8vCmjS9DtqjonS1E3mKzrZuCLqFPliU4anK6lGAcyZKYHXPBFDbLvqrozifPDp5VFK/
         ceCQfkMG5H7dDZmH6ELYHwLvyuiW2q96lC/4nxRogZoQcjegZeMDYISvS6yD+9qOjpTW
         MQA+sIxSnsNDu3jMTlvrXSyzNSapGGahR6oPmeu/2vFQJMhLgy9EHsx0w9pOiC3UmyPj
         fsbGzb7KnKUdyQr5cmbc4bckFk5BboTRmyzeARpt3IAKio0q49MrH9PUKvZq3l75fZ9s
         tZmA==
X-Gm-Message-State: APjAAAVaDHK821xg55uMGZwFkdSzNxIbmOlddVzPxb7gfIOCaFqRrFxL
        NKmdkGUPK3+aXQxif+kvHkJ+qzxPflE=
X-Google-Smtp-Source: APXvYqwzu0TNpn/LASPmSQ5AAPGA7U3vtOVjKWCrddYmJzktVhAOiOAA8Ux2uJi77H0cH97MgcRRcw==
X-Received: by 2002:a67:ee13:: with SMTP id f19mr970584vsp.147.1579650226416;
        Tue, 21 Jan 2020 15:43:46 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id h187sm11223297vkb.40.2020.01.21.15.43.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 15:43:45 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id y125so3079692vsb.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 15:43:45 -0800 (PST)
X-Received: by 2002:a67:ec4a:: with SMTP id z10mr894498vso.73.1579650225363;
 Tue, 21 Jan 2020 15:43:45 -0800 (PST)
MIME-Version: 1.0
References: <20200121194811.145644-1-swboyd@chromium.org> <20200121194811.145644-2-swboyd@chromium.org>
In-Reply-To: <20200121194811.145644-2-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 21 Jan 2020 15:43:34 -0800
X-Gmail-Original-Message-ID: <CAD=FV=US=pNU8GFpDR644RxHcDo4et=sEjBDTNJkRBD9gKrMog@mail.gmail.com>
Message-ID: <CAD=FV=US=pNU8GFpDR644RxHcDo4et=sEjBDTNJkRBD9gKrMog@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] alarmtimer: Make alarmtimer platform device child
 of RTC device
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 21, 2020 at 11:48 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> The alarmtimer_suspend() function will fail if an RTC device is on a bus
> such as SPI or i2c and that RTC device registers and probes after
> alarmtimer_init() registers and probes the 'alarmtimer' platform device.
> This is because system wide suspend suspends devices in the reverse
> order of their probe. When alarmtimer_suspend() attempts to program the
> RTC for a wakeup it will try to program an RTC device on a bus that has
> already been suspended.
>
> Let's move the alarmtimer device registration to be when the RTC we use
> for wakeup is registered. Register the 'alarmtimer' platform device as a
> child of the RTC device too, so that we can be guaranteed that the RTC
> device won't be suspended when alarmtimer_suspend() is called.
>
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  kernel/time/alarmtimer.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)

Other than the extra space that you pointed out yourself (which maybe
could be fixed when applying to avoid an extra spin), this looks nice
to me.

With the caveat that I'm not an expert in this part of the code:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
