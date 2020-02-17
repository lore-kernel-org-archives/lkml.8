Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EFEC7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 11:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF9120725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 11:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W3P0OcO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgBQLzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 06:55:49 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41603 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgBQLzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 06:55:48 -0500
Received: by mail-qt1-f195.google.com with SMTP id l21so11778538qtr.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 03:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lY87+KOEZ6dGuNkZONRFyrPUlCbu+gnrKXQE8dlGuE4=;
        b=W3P0OcO2TvK2z/0LRMWHw4+JB1JA4XDZks9OBu2hNQT0Q2fQEKktTQQsjT6ePg+9T+
         +ZgTVszIjaKtSk1VRvlhNfK/vj4JTKYDNTs7uz8h5qgddPvOVhoix4UcFUc15Mxm54q/
         XCi0HTe9cUTOYMnmdLrJDyXXS8STOWkT6EINE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lY87+KOEZ6dGuNkZONRFyrPUlCbu+gnrKXQE8dlGuE4=;
        b=KdSLTrmb2t0bvy3gaGhLAomxyoaaPcBI0BsACLyAizW3eT+mtItVzQs9zSEon93fmW
         mHLdIaYnTs7+PzY52sb/lES5ZuomJIJplGbs5ojA7kK10SP69/v7igzuHvF971M8b/AV
         cD/B7LpqmxTdwyvm6BFq2bXxXRbJMWSbP9OD0Q+LmluS261Np2kjyyKhZup6y0tld8d3
         4kvZ2V3/m0RrsDyYTjDW3u+d1X18D0qmpnJrQs7nKN7L+s1vwODdQBtJ6Nan+awN0tWE
         SV8CSSMUT5gnx/VyiqOEzMNTKMsLX8hTYXBxWGyttyqYLPA/8EEQ/dNlGdlzfkVTez38
         LLhw==
X-Gm-Message-State: APjAAAW5BP5AgKwTH1ocx0jYbfbpRwl77DLXkI9qJ4mjwlRBLybliWDz
        eacMZY2+eOieQYjIhxkUebQhIh+Bm4Znx646+VzKRg==
X-Google-Smtp-Source: APXvYqxXaOqF5RRBCXB80/95e7xeSGrR7pmCNocEcu0xOUXI3fgjJxuQ9h/mlMMoIKtHtT+m3VHnkUsDG4t42Tr1goI=
X-Received: by 2002:ac8:3946:: with SMTP id t6mr12871326qtb.278.1581940546729;
 Mon, 17 Feb 2020 03:55:46 -0800 (PST)
MIME-Version: 1.0
References: <77c1e557-4941-3806-2933-6c3583576390@infradead.org> <20200203174937.GA18628@roeck-us.net>
In-Reply-To: <20200203174937.GA18628@roeck-us.net>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 17 Feb 2020 19:55:36 +0800
Message-ID: <CANMq1KB28PZhrh4VKurN+oXrQx4xdM31sfk82_j09CQa5Ek8mA@mail.gmail.com>
Subject: Re: [PATCH -next] watchdog: fix mtk_wdt.c RESET_CONTROLLER build error
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 4, 2020 at 1:49 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, Feb 03, 2020 at 08:10:29AM -0800, Randy Dunlap wrote:
> > From: Randy Dunlap <rdunlap@infradead.org>
> >
> > Fix build error when CONFIG_RESET_CONTROLLER is not set by
> > selecting RESET_CONTROLLER.
> >
> > ld: drivers/watchdog/mtk_wdt.o: in function `mtk_wdt_probe':
> > mtk_wdt.c:(.text+0x3ec): undefined reference to `devm_reset_controller_register'
> >
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Matthias Brugger <matthias.bgg@gmail.com>
> > Cc: linux-watchdog@vger.kernel.org
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Wim: Can you please help pick this patch? This seems necessary.

I'd also add this to the commit message:
Fixes: c254e103082b74e ("watchdog: mtk_wdt: mt8183: Add reset controller")

Thanks!


> > ---
> >  drivers/watchdog/Kconfig |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > --- linux-next-20200203.orig/drivers/watchdog/Kconfig
> > +++ linux-next-20200203/drivers/watchdog/Kconfig
> > @@ -841,6 +841,7 @@ config MEDIATEK_WATCHDOG
> >       tristate "Mediatek SoCs watchdog support"
> >       depends on ARCH_MEDIATEK || COMPILE_TEST
> >       select WATCHDOG_CORE
> > +     select RESET_CONTROLLER
> >       help
> >         Say Y here to include support for the watchdog timer
> >         in Mediatek SoCs.
> >
> >
