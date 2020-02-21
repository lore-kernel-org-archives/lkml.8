Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6E9C35658
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C6824650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YzgEvcaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgBURTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 12:19:31 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37454 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbgBURTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:19:30 -0500
Received: by mail-ot1-f68.google.com with SMTP id b3so2675078otp.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 09:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aFj7tYI0k/f8j7tYUdpdud7KpLh5j6ouKtsSoqEvszI=;
        b=YzgEvcaOL7wY8aO+jLfgHbjlVU2xxOJSB3+tw4wl4fh5uOdZSBNHo/iltx0MWip/dx
         EmTuDub5yPlgPH3bHf5Zz0dcdgGkjIUEsy71Jt8pUh7yhvxFxNSCOXr/6sOdr2B80kxv
         8Rp2Bs9lxT2sACVW1LTq3mJ1eHtNvRY4dxHL9l6QS2XrYWRcypud1ZZG3AQHWS8FfBNu
         SESXEQZR7Sf5hOVEpl2Y7jZZIzX77sTXqn/o5jSTY6+C3NsxB5EKu5h//4gqTaj3aest
         bhQC3td7VGOiHJJHqbjo3DXgSmmWovjvU9eaomChJmjbNFaN6EImUpYyfFyRsZJx0O8a
         6QoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aFj7tYI0k/f8j7tYUdpdud7KpLh5j6ouKtsSoqEvszI=;
        b=Qc6KkPGwxbBRcudhbBKZJYwV5Ll8bLpDjKZ3/sN+8XVqmUtlwu0/69a6lGtMV+NhwD
         hsHwu3GQiXfwtaRCGTMr3eMPmVk42OqMujsO6ITQB+E2EHlAuwCXh/I3JirLxzWGbsg5
         frPL+HII0v+TlsO5vQ9uui0EdZseprR7EIwmGAZmLkLYJfHOiYqI7sbu+rWa3gxFbuj4
         hRxd/GAWr5Bpfhzph9pT1wWx3IQoJOszvnhqhr2kadp3J2xlxYPh7Na0KHC64OpGvNkP
         NqMT98Mx+DSRDaovMa7keBtJH4SA8cH0K97wceyG4qUWaiBM4V8XKANi85VYx3JZ9kgz
         ZNBA==
X-Gm-Message-State: APjAAAWPPuYg9uOErLGm1DKV6EPYZ33drtRmgs1NPaofKwANnLCoJM2T
        bo+sGG04cnya8knjlDT8PN3TCxQGu3nQyW0aKTB3fwef
X-Google-Smtp-Source: APXvYqxSTtKq6jL9E+diPzBIZDb2QUskTpf2GmcCBEObkgjrpqHE6Zct2GYZmNiSd+PjgI9aUQvm9vp2GioZkW3oYlo=
X-Received: by 2002:a9d:12af:: with SMTP id g44mr16732511otg.332.1582305568936;
 Fri, 21 Feb 2020 09:19:28 -0800 (PST)
MIME-Version: 1.0
References: <20200220050440.45878-1-john.stultz@linaro.org>
 <20200220050440.45878-4-john.stultz@linaro.org> <CACRpkdYVQs0dDT8dn2GzQQXrbXATRi8iqHB41EQBMEwMiEFgzA@mail.gmail.com>
In-Reply-To: <CACRpkdYVQs0dDT8dn2GzQQXrbXATRi8iqHB41EQBMEwMiEFgzA@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 21 Feb 2020 09:19:17 -0800
Message-ID: <CALAqxLVQ1MqEC6Sdm0DcWHQpuWnOMt5NxNrj_v+byeEa1cfang@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] pinctrl: Remove use of driver_deferred_probe_check_state_continue()
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 7:22 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Feb 20, 2020 at 6:05 AM John Stultz <john.stultz@linaro.org> wrote:
>
> > With the earlier sanity fixes to
> > driver_deferred_probe_check_state() it should be usable for the
> > pinctrl logic here.
> >
> > So tweak the logic to use driver_deferred_probe_check_state()
> > instead of driver_deferred_probe_check_state_continue()
> >
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Kevin Hilman <khilman@kernel.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Todd Kjos <tkjos@google.com>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Liam Girdwood <lgirdwood@gmail.com>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Thierry Reding <treding@nvidia.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > Change-Id: If72682e0a7641b33edf56f188fc067c68bbc571e
>
> I sure trust that you know what you're doing here.

Classic mistake. :)

> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> I assume you will merge this through device core?

I guess? I'm going to resend it again as I think its a reasonable
cleanup, but the urgent need for it from me may be solved by
of_devlink Saravana's patch instead.

thanks
-john
