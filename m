Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC46C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340CA20719
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSr/ue53"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgCWViA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:38:00 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41279 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgCWVh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 17:37:59 -0400
Received: by mail-pl1-f194.google.com with SMTP id t16so6482130plr.8;
        Mon, 23 Mar 2020 14:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iJcyGgdbI2EGB6zjsKH8V4xB/4P6cs5iNkudkZUW0jc=;
        b=eSr/ue53UYoQ1OUKAXgebp8Qql0hSDrCnLBN7zfsbUwhSfzmxtZ/FpyTBcYq5HkKqr
         ZVna6+utNW/gfjI7943WOjhdQY97Hxicomo1hMsBm23cJkW4Y+hQYYDevCZarb6zWfK8
         23Z6VJlX/5RsxyBFZR8HB/tguks1Yzlr+wnSP6FwYw+HnsuJP/BHFcfQs4Lg4w9n82U2
         vBO2wEV8pgX05eMyA2x3N3+VcsN/R0mylmdGZ7z8Fecd3+0Phde9ztqeIVZr1WPI8Iyv
         NJXHF3I/smWYJWzx0TmsBShlTtG5zc3g/p7WZzZXrD7VSElAEWPPqfYLGlWLBbr8Kury
         VpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iJcyGgdbI2EGB6zjsKH8V4xB/4P6cs5iNkudkZUW0jc=;
        b=sfpQmrc+3GzOlyTFMYe2yRtLCDU8baswJcQJ7ggD5SKc23jcA2X3CL1MJaw2az9pdi
         m8n7ESJrks+WBslwta77xgaF7TiJBfhAViR2GqQVC8eiaSAfS1gZAmP11oy4i5DWgcTa
         eEg9jEb+lLaHGB3Gu9nC0VwGCV+YYOCjwpyG/Cjfz7b3anZIh74+zW6WQaeePu9sD8lu
         HIwB6vul08VX3ZKebp8X8jGDCuNe523VKDnGQR4gp9Hznw3WaTqDc761fH8tL/PHUagG
         tD0DTGLIrss1L4MJpB8yr7Z+9QDPJA014InqHseCqxslLGmsFMtpNoGRmbDL6eCSfIYX
         xRdg==
X-Gm-Message-State: ANhLgQ0h+DEvxNvNCeE6TVMgsEuiYPs1pvhrjkzO8lhf9P5r/XPraLst
        5yEnabcTvRvbE5qlmHf3PLD89l5PEOEOHwsvkYk=
X-Google-Smtp-Source: ADFU+vv0dq33PWMTaRhZor8Qmw9f48Vz9VFpo3YBlCjeIM4Q+u1oRXWRX5SR/5bMsSyScApJQ+R0kVDbTIyPPiiTCtU=
X-Received: by 2002:a17:902:54f:: with SMTP id 73mr23309249plf.255.1584999477664;
 Mon, 23 Mar 2020 14:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200306132505.8D3B88030795@mail.baikalelectronics.ru>
 <20200323180632.14119-1-Sergey.Semin@baikalelectronics.ru>
 <20200323180632.14119-6-Sergey.Semin@baikalelectronics.ru>
 <20200323183837.GV1922688@smile.fi.intel.com> <20200323192558.ph75ifdhibxwnkie@ubsrv2.baikal.int>
In-Reply-To: <20200323192558.ph75ifdhibxwnkie@ubsrv2.baikal.int>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 23 Mar 2020 23:37:46 +0200
Message-ID: <CAHp75VcxJJ+GaLk7Rn5WveopZc76DkJA-dnB84QTpGfWdAbULA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] gpio: dwapb: Add debounce reference clock support
To:     Sergey Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Allison Randal <allison@lohutok.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 9:28 PM Sergey Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
> On Mon, Mar 23, 2020 at 08:38:37PM +0200, Andy Shevchenko wrote:
> > On Mon, Mar 23, 2020 at 09:06:31PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> > > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > >
> > > Aside from the APB reference clock DW GPIO controller can have a
> > > dedicated clock connected to setup a debounce time interval for
> > > GPIO-based IRQs. Since this functionality is optional the corresponding
> > > clock source is also optional. Due to this lets handle the debounce
> > > clock in the same way as it has been developed for the APB reference
> > > clock, but using the bulk request/enable-disable methods.
> >
> > > +   if (err) {
> > > +           dev_err(gpio->dev, "Cannot reenable APB/Debounce clocks\n");
> > > +           return err;
> > > +   }
> >
> > Yeah, this should be a separate change.
> >
>
> Linus didn't think it was necessary in v1.

Ah, okay!

> > Otherwise looks good.



-- 
With Best Regards,
Andy Shevchenko
