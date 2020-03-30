Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D510C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2579820733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgC3N01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:26:27 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37723 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgC3N00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 09:26:26 -0400
Received: by mail-ot1-f68.google.com with SMTP id g23so17981233otq.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 06:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NK4ETR7h2edWFKiQ1WzWdNw8sGuMYLfo1c3p4uLGozI=;
        b=sKYnl+suvvYUGE+mxVX3LcMFyr/+uSMIG5N9hvbNPzs8OT0p5H/pYSlKt2GAr5wWDE
         5tLumkMCtyAbheevQ6CClsrYRJS6R+4490XxsvPgj/jA2qclhfUj9HgIYwe6fz9B33HU
         rjfrzW+oAzbM1OMf2abQPBMg9h7RSF1E+Xlk97DCV2YQ/uqwntw/0X9itDs/PV49/T1n
         UI29LEDyW0cbHuTc26W9E/WnCnr4ToZ1rb2/ve29BlvJ/eB+oEuqTaCo55arsIYxWoDK
         fHgcqbdltct5IrsEJvSvguzg9N92wtfo4WkfKGjsUdqpTAfLgbPbiZu7UMEZKJqwDrj6
         Vbew==
X-Gm-Message-State: ANhLgQ3X/V0AxV9kygp4wfcfI2MoCTpXpLwDZnOIp66AfUPdcwg09rwJ
        UdBUAO8IxHH6FIEmcjJ8FcR7/uwVWPC4D+xGiHg=
X-Google-Smtp-Source: ADFU+vspmd6FgQRzY75mmHLE00G7QQN4fvOcUyWvTRJqUvDnUVb96bbPOReg1BhlLNLzqui/pzN4yh80h39enaa6iWs=
X-Received: by 2002:a9d:7590:: with SMTP id s16mr9083819otk.250.1585574786026;
 Mon, 30 Mar 2020 06:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200330085854.19774-1-geert@linux-m68k.org> <CAHp75Vc1gW2FnRpTNm6uu4gY3bSmccSkCFkAKqYraLincK29yA@mail.gmail.com>
In-Reply-To: <CAHp75Vc1gW2FnRpTNm6uu4gY3bSmccSkCFkAKqYraLincK29yA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 30 Mar 2020 15:26:15 +0200
Message-ID: <CAMuHMdXDBtOo_deXsmX=zA9_va0O5j8XydxoigmS35+Tj7xDDA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.6
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Mar 30, 2020 at 3:08 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Mar 30, 2020 at 12:00 PM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > Below is the list of build error/warning regressions/improvements in
> > v5.6[1] compared to v5.5[2].
>
> >   + /kisskb/src/include/linux/dev_printk.h: warning: format '%zu' expects argument of type 'size_t', but argument 8 has type 'unsigned int' [-Wformat=]:  => 232:23
>
> This is interesting... I checked all dev_WARN_ONCE() and didn't find an issue.

arcv2/axs103_smp_defconfig

It's probably due to a broken configuration for the arc toolchain.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
