Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1270CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 675F5207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="M3sbcxko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgE2NrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 09:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgE2Nq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 09:46:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9558CC08C5C6
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 06:46:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j16so3667447wrb.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 06:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2feAhHAwXbblRf6aR70XXk307dTrGyg2hsYoYW15HqQ=;
        b=M3sbcxkoAFe+/wx9TM3LgjCJcp7/QaR9t55qyb9/4CW+VKtz73dTS7qjhnQltvBfnD
         Xfyyir8ZHlF/xyxxpzEr0Fugk1nMFBWttrlOyhCcW6XX0y96QbmpUO8SP/8HXw8qWzqC
         sv+tT49eNS4q57kXwZha0Nn9okTGnhV2xCWeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2feAhHAwXbblRf6aR70XXk307dTrGyg2hsYoYW15HqQ=;
        b=sXqV0XS/xmRaOiHMIFC7YeAgu6OYNvlrYGBU6cEeb2DSr5y1b16tEENQIAfO2OeEYa
         OTrBocqADZmpFgE8pHdHbumUmMETId398f4DlHZk4MW/jRgtJIu2eYfY/L4947R1/wG6
         AmeNe6zjL4G73faXKwkE79cRsT4vcmhSL4FnawZ2kxZzLrO7nhnfufDRrSr0iT27+r1r
         QM81/z+/4m/eAPEuFxSzak/jIHehlzQyiOngHNXqO38v1Mth+VwKw1uRwF6rh1ESdgOD
         ydtskQ1q6TOF+DajmGgZQhBON2WyMlc7drQyBoBlNfDzT7xjPJHSZmoGJlx5Lw2ybSxZ
         ZDjw==
X-Gm-Message-State: AOAM531iFNvrqyB1fPG5YcJRbaufGd/BnCzo+gNk8oPoXRvwG+KK47T1
        tSSe5SOBMbWixWzGKwsaA/z+orNscs8/75qLNVoeAg==
X-Google-Smtp-Source: ABdhPJxgNKlBm36G2VzQoFtIKG8ZOjeZZMsJ+sGlJmWxn5vo3dzKyHKlYEPs/ZjiXNefW+vvFT64uJFLyI1hwMXuduA=
X-Received: by 2002:a5d:4286:: with SMTP id k6mr8441633wrq.140.1590760018185;
 Fri, 29 May 2020 06:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAOf5uw=DU4KdLXt=VEU+Uv3+W3jUMXE393FO3_v2smScR6Xf-Q@mail.gmail.com>
 <20200529133107.y65eta5btvgpk6pu@linutronix.de>
In-Reply-To: <20200529133107.y65eta5btvgpk6pu@linutronix.de>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Fri, 29 May 2020 15:46:46 +0200
Message-ID: <CAOf5uwmQnX8SNOxD71mwcxc5Q4hKXo1VqnMbaSArNg0SmE5dqA@mail.gmail.com>
Subject: Re: linux-rt stall on imx6dl on patch-5.4.22-rt13.patch
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Fri, May 29, 2020 at 3:31 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2020-05-29 10:08:01 [+0200], Michael Nazzareno Trimarchi wrote:
> > Hi all
> Hi,
>
> > I get this stack trace
> > echo 3 > /proc/sys/vm/drop_caches chrt -f 99 sysbench --test=cpu --num-threads=2
> >
> > First of all, I need to know that if it is a valid use case because
> > was raised by the testing team and
> > how can I start and where to take a look at it
>
> Assuming that there is a `;' in front of `chrt' then I wouldn't be
> surprised. You are basically keeping two CPUs busy with sysbench at RT
> priority and then wondering why the system isn't making any progress. If
> it wouldn't be for the RT throttler, you might not even see any output
> and box hardware would appear be dead.

No, I'm not surprised but my answer to them was not enough. Right now
they are executing some bench.

Best
Michael
>
> > Best Regards
> > Michael
> >
> > [  161.709260] 001: sh (480): drop_caches: 3
> > [  180.234358] 001: sched: RT throttling activated
> > [  180.283363] 001: fec 2188000.ethernet eth0: MDIO read timeout
> > [  180.283406] 001: ------------[ cut here ]------------
> > [  180.283416] 001: WARNING: CPU: 1 PID: 133 at
> > drivers/net/phy/phy.c:716 phy_er
> >
> >                                                ror+0x24/0x64
> > [  180.283460] 001: Modules linked in:
> > [  180.283473] 001: CPU: 1 PID: 133 Comm: kworker/1:2 Tainted: G
> >  W
>
> This is hard to read. Especially later in that mail. In future please
> try to not cut the lines.
>
> Sebastian



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
