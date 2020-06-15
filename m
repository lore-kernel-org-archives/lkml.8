Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC319C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9CA920739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARSthNo3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgFOWTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgFOWTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:19:06 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D5CC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:19:05 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id m25so10325283vsp.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r9T7k1DpPFTY/gAD5b6MEb9oHnKklfAWLgEYHIDgzf0=;
        b=ARSthNo3qKbcMSHrOKeeWC4s+yNkZz9S1UbIt1WGKeODX5s69r5L5uSsoRuhcRobJN
         Xj/Xqk+norC+HRQUaNtFFSzzpLlDGWLoiCGIG8belx4tZTOHTmOWO3KyhG55PsCyo78l
         BOc8VvFbjNWSv0dAxz6W1DZo3IWtoKJj8pmBC1bQ13laz7a2BhtLrt0NuIgsKWVvKVI4
         PuMFjEszl5teVPOZypEKgh60EpvkWUDFZrHyghbXOgFpxCgNwlFe3x/0p38CxgBadiC/
         Xn+4v2ouT8LgYI2JX5xP2KovVOoZVW7YpVcOuO4bjCBRaGBKQ9tPGG2pf02zrtM5A62i
         Y2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r9T7k1DpPFTY/gAD5b6MEb9oHnKklfAWLgEYHIDgzf0=;
        b=ufKJ4WEnWixGn3A2GRMEFTl5HGoH2Mnjud2Ft4UMMxtMjxl/O6r9PYuhUXalKCyz1H
         eiagwkB41IH0aIlXiLDfaelRTXx9y+dJANUhuwVBE5P+sCKe3e9M2eHsqMXvo+rkOcuG
         Up8LKURXo3fr+9QARYD/Jl6BhAtEntXnoJAgU9FtN8QqS9eWwbNyVAe4zXqcYQe30YTB
         c9L6GG6B5hmewtqgiqF0unegVYoKk+bBMRRviWuM+yDhOqI6NahNhAJoatkj1cdnjylU
         sJwRsAnIepEYkLCOUZ+oVJYo9TeDXlZ1W/hMMed2GrU1Zg0aiDDQ9XZqLwK5+yn4uyDU
         CGQQ==
X-Gm-Message-State: AOAM533Q8L3FR5F3jrV/rm3pMOACo8OdbVfrRylqWRzEwnBBX169XheX
        ODxOFSLQCf5eqxsMem+zThvPSctp6upBsWaoUiY=
X-Google-Smtp-Source: ABdhPJxc//Rmt+6lw+UJCTnqtvocCC/v7PiZuZB0+sopLg9uyknCBc0IboBTC1S2jba9JDzayMa0+Yx33OFN66c17YE=
X-Received: by 2002:a67:3211:: with SMTP id y17mr22659348vsy.56.1592259544861;
 Mon, 15 Jun 2020 15:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-24-jim.cromie@gmail.com> <20200614060501.GB2608744@kroah.com>
In-Reply-To: <20200614060501.GB2608744@kroah.com>
From:   jim.cromie@gmail.com
Date:   Mon, 15 Jun 2020 16:18:38 -0600
Message-ID: <CAJfuBxyAYU+cE+JpE+T6+k0YhqG3pyk2ShPruX4A9yCTeKX3Jg@mail.gmail.com>
Subject: Re: [PATCH v2 23/24] kset-example: add pr_debug()s for easy
 visibility of its operation
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 14, 2020 at 12:05 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Jun 13, 2020 at 09:57:37AM -0600, Jim Cromie wrote:
> > put pr_debug()s into most functions, to easily see code operate when
> > module is loaded and used.
> >
> >   #> dmesg -w &
> >   #> modprobe kset-example dyndbg=+pfml
> >   #> cat /sys/kernel/kset-example/*/*
> > ---

> >  static int __init example_init(void)
> >  {
> > +     pr_debug("called");
>
> Why???  If you want to do something like this, use ftrace, that is what
> it is for.
>
> thanks,
>
> greg k-h


mostly I needed an easy place to try out pr_debug_n  in the next patch.
if that next patch seems like a good anti-pattern for pr_debug_n use/misuse,
then I could combine the 2, and add a 'dont do this, use ftrace' comment too.
or not, of course.
