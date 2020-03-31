Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588BAC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289EF20714
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sC/tuvIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbgCaWoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:44:39 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45003 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgCaWoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:44:38 -0400
Received: by mail-oi1-f194.google.com with SMTP id v134so20456923oie.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 15:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oJW0QacSKgavphK//RdEV6VhJpOOFLFYB98afgnyXSE=;
        b=sC/tuvIMLhKX+w+1o4Pu8H9xbs/z5VwCsswyG+czxmPWPlogCZEYaGM1HifgkwaES/
         y+XiW/Uzgf/R/KwkXBz1g96m3kGPodS54QM1toaYNMxd5y9YwYwZsM1dy/GZm1Zwc0KG
         PR+dcMuuCA0nNBpVvv+xSYothwciqzr7CXgTvB1/PmksH207TAMkHrHCy6+jMXbXI8xW
         KiD8wg8TRjiOfMq8pxhOIbE0VQqBG7EvqvRRpV+UtiG7hhnfMicOSGXc2Yfy9VYjDPnq
         tAf8l22KURmhH89ADnAAD8R5lVgTl0Q846T7OAD/aTBCuEtnKJ+mprj2kJzlfsJCLGLL
         9QXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oJW0QacSKgavphK//RdEV6VhJpOOFLFYB98afgnyXSE=;
        b=LNGPuDJzX/GknyEkRCv4+bXvgur4ulPK6vo9SCpkCsWFp6DaCnwI2HmBmcpJ2hCZ4E
         R6mSRJ2RAf/qHVSFJSXQ3u93+Bquuoa78kKjKmjc3FQzXKENO/F3GTyWGSbLswQfBDR+
         XQ3mo3n3bPjJf5IZt1qFRSNXTHFP6uB8lfWzhg4tKCi6uhnoJ4zLNRCl1wnCjDsYfFLw
         vr2qAsp8Tr3SQrycV8KIv3osGR7VX6D/TX1IrE94sRIO+r7sUzAnRScNilwBdEwwPhmI
         94TK10dfILpgroR33AVRx7JdVReQoNtZzartEOftWTPTlvCwhS1CzrpK//vD3oCYT+ZU
         KCWQ==
X-Gm-Message-State: AGi0PuY0JRAZw2ClHvRHzrV5RyHBmufK+T5QWarV0mZE6LsIxnJ79gGE
        YgB6MUQzRiAyv0PiprCU7hML67Iw40TgUeLfC2a7qQ==
X-Google-Smtp-Source: APiQypJcT/sHTOiTBIBwChb184pqp2FUmQOI2eoflnaT3jVHlNYMUDCx63ivDS7RcgEvmKUQXrb/wRxsZSBkmCzEF6g=
X-Received: by 2002:aca:5208:: with SMTP id g8mr795387oib.169.1585694678032;
 Tue, 31 Mar 2020 15:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200331214045.2957710-1-thierry.reding@gmail.com>
 <CALAqxLXD78StqLMuaGqHqhSfS9L2FBfNCm6yDyWMZT_7iNX-wQ@mail.gmail.com> <20200331222535.GF2954599@ulmo>
In-Reply-To: <20200331222535.GF2954599@ulmo>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 31 Mar 2020 15:44:25 -0700
Message-ID: <CALAqxLWKP9Y9F+4hEpqfRyPYmQFAvyc1eBSArS1wpO+jeJK9rw@mail.gmail.com>
Subject: Re: [PATCH] clocksource: Add debugfs support
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 3:25 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> On Tue, Mar 31, 2020 at 02:50:47PM -0700, John Stultz wrote:
> > On Tue, Mar 31, 2020 at 2:40 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> > >
> > > From: Thierry Reding <treding@nvidia.com>
> > >
> > > Add a top-level "clocksource" directory to debugfs. For each clocksource
> > > registered with the system, a subdirectory will be added with attributes
> > > that can be queried to obtain information about the clocksource.
> > >
> >
> > Curious, what's the need/planned use for this?  I know in the past
> > folks have tried to get timekeeping internals exported to userland so
> > they could create their own parallel userland timekeeping system,
> > which I worry is a poor idea.
>
> This was meant to be purely for debugging purposes. That is as an easy
> way to check that the code was working and that the counter is properly
> updated.
>
> I certainly wasn't planning on implementing any userland on top of this.
> Well, I guess it could be useful to use these values in test scripts
> perhaps, since one of the clock sources exposed by one of the drivers I
> have been working on is used across Tegra SoCs for hardware
> timestamping. For that it might be interesting to be able to compare
> those timestamp snapshots to something that I can read from userspace
> during testing.

So, other platforms do similar, but utilizing the ktime_get_snapshot()
interface internally so drivers can share that SoC hardware
timestamping logic and export that via driver interfaces in a cleanly
abstracted way to userland, rather than exposing the timekeping
internals.

thanks
-john
