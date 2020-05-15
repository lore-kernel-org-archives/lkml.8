Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C95C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C20E7206D4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xa/ToNKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgEOMDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 08:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgEOMDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 08:03:11 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D3CC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 05:03:09 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x27so1485692lfg.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 05:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EQ+MSLCM1FfK9aeAp+m5Aux8g42PMTCx+zx8TzWAujU=;
        b=xa/ToNKhDgoNnwHQ4aUO++Zmfp93IQTCpctnvYKOZTbKBjg4xMYYskVBTSvr6nAvHB
         nSvIi9FkaPBtSTQ8y4plyLib2B0RhtLzqYFSD23tagBV9eqEGUReK2mo0tGa04bkpH6F
         kx89QudofULMU8FOht++19CTimQ6s1VSdFX6FSM0rppyILJa27wxE0+p5ybtCfqDM9aw
         WTT0vmim8nrF7cL1Gg9TlQ2CGoMYrzR9vp6XWSwcJJ/wkDLgKalGQRbshmbEsLVKmBh9
         9QOFJhDh4wlFTH0i3xmcIe6+CC4xM1YhY6RCVFN9JYlrzO/p9qVwmIDDkTl2PHUAC841
         dkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EQ+MSLCM1FfK9aeAp+m5Aux8g42PMTCx+zx8TzWAujU=;
        b=dVxwfxvMX2gxO3qGNsCNKpnbf85Spgqb+/glmKYtBRxNiXDQrz8Yt+Tcg4y4tv+GRk
         BcwOF07HY4RPgUzr0YYW5yuGR55+Pw29HEa0VDUlWZ16XNJKC1OlOBmzbfoX4HY60057
         E+YJdV9e43vCaLHpemMMSXgnKzzAJwykx/4NtHg0LCLvL6UstydDG1k/nOiFcmM4YqTB
         e8Vvin8OF6WD7mm49ZgQy/cYC+PdWBAZUxati4fBw3ReRhH9MTahtbDRCZguq6YzZyM9
         DM4dWeJjn2pI+GzifGW2WZCA4+H5DPPKprJydekYwrX341/0jbPi8vYVwQ84u9vs7R+n
         tCGg==
X-Gm-Message-State: AOAM533eHnH7gDgmsoSPWBqs9qZ36jmKzk435ffQPb86EZJ7VdQ7GyLa
        CDmI4Wh8SDteE94/r75Vc9c5g27ruQXYQoOdrYviEg==
X-Google-Smtp-Source: ABdhPJxhjqyZuPv0g6tGQeX8avCQMuPxQ1puafxoJ2BIH6FH5f31nNyevbuV+JgQFuHftu6ozilQnnji5MzHoFv4e2U=
X-Received: by 2002:ac2:4293:: with SMTP id m19mr2245484lfh.204.1589544187846;
 Fri, 15 May 2020 05:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <1589273314-12060-1-git-send-email-sumit.garg@linaro.org>
 <20200512142533.ta4uejwmq5gchtlx@holly.lan> <CAFA6WYOV7oPbYE=9fXueYMacb5wv0r9T6F8tmECt-Eafe-fctw@mail.gmail.com>
 <20200514084230.GO17734@linux-b0ei> <CAFA6WYPSsgdAB-wJC0e2YkVkW0XsqQsu5wrn4iB4M-cwvS7z2g@mail.gmail.com>
 <20200515085021.GS17734@linux-b0ei> <20200515103308.GD42471@jagdpanzerIV.localdomain>
In-Reply-To: <20200515103308.GD42471@jagdpanzerIV.localdomain>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 15 May 2020 17:32:56 +0530
Message-ID: <CAFA6WYOBsimP1j8Fwq4OcePEug4MGoaY3wTTTVydHtTphZ-FTw@mail.gmail.com>
Subject: Re: [PATCH] printk/kdb: Redirect printk messages into kdb in any context
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On Fri, 15 May 2020 at 16:03, Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> On (20/05/15 10:50), Petr Mladek wrote:
> > kdb is able to stop kernel even in NMI context where printk() is redirected
> > to the printk_safe() lockless variant. Move the check and redirect to kdb
> > even in this case.
>
> Can I please have some context what problem does this solve?

You can find the problem description here [1] which leads to this fix.

> I can see that vkdb_printf() calls into console drivers:
>
>         for_each_console(c) {
>                 c->write(c, cp, retlen - (cp - kdb_buffer));
>                 touch_nmi_watchdog();
>         }
>
> Is this guaranteed that we never execute this path from NMI?

Yes the above code could run in NMI context but it will only run after
we stop the kernel (drop into debugger) and on a single CPU at a time.
AFAIK, we drop into the debugger either via sysrq or during
oops_in_progress. So I think it should be a lockless entry into the
console driver for write operations.

TBH, it's very much possible that I may miss some aspect. So please
feel free to correct me.

[1] https://lkml.org/lkml/2020/5/12/213

-Sumit

> If so, can this please be added to the commit message? A more
> detailed commit message will help a lot.
>
>         -ss
