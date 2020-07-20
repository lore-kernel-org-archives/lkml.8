Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB40C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B799206F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="Po6qusc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbgGTTVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 15:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbgGTTVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 15:21:36 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA95C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 12:21:35 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 22so585002wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 12:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=drjVrz0HKTqiToPN//uGoymbbNQ2vz3ohN8cWfYssWg=;
        b=Po6qusc4mrfN07bDoys3gc5YNjQ7WwJ5lRNemTfMTH5LCzYhvbsUwIPf36T5CvV5VO
         MyCmnvPST4Z9WwTqFlB80J2oLlnka8OEM4V6p6+f5+7o8RhobGmpspYFoxRPZnfJkNn+
         3nRF7Pth4CCVRTWmoDHdr2P6VOhwHMSN2UqZRpSkm+ra7sAHZmNKB1NPm1NPWXOooKYn
         +afbM6DSoYNR9aIX6J5XTHj7jmkh4VhYlU0AFYbJReG5gunawA6raqfYBVtoFYQ5NXFV
         24W8cpeQJ1+35kxDi1Pb/BWGibmbRdfek3YTPA6vM4c6/FnbFapDn3LY4b6jgGwv7E3G
         M3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=drjVrz0HKTqiToPN//uGoymbbNQ2vz3ohN8cWfYssWg=;
        b=krgKSvTq7xKN2ZVwXd9J3hgfACE5+kCae8E+MSygPn0LCqOYd0arCyoVzAg34VYrQO
         a6R97Y+WgQDhRCJ0jHcxNLfB0ye18TFJ9DzJAyXubWsyaeQZGRHdyTmwaBVjh9OXdEoA
         fUOweuLIAsmG9g6fLkFUMDc5AIDB9lui2EnKmlhFsI/cmJRlBJAQaKtEhGSAOjKvLm7O
         Pc/XKYdlIXzLRT4FT2ZTY90iJnNaCoF6iYCDDv1Jri14bpXpXPMI611BGjBIiHz0S8EF
         Md1CKp4WpzuOsdwLl03KZoXmeOp4fQYMuBhetO+i19xGnulORrKichCJ5jJYJgAe/PYK
         IRLA==
X-Gm-Message-State: AOAM530oY9hFgqJ8e+120TqK6OCgHH/p6eWXSy+9PgSi9d3PeISom7ry
        9psup5cipQAdWBhVkwHZZaCX/A==
X-Google-Smtp-Source: ABdhPJx1amXkvtsBfSgruslRd3KssogIQVO5s9XZ5d18x4zAavO+ESaxDVGpN5zxwpvV+6mZtkYQ4g==
X-Received: by 2002:a7b:c3d0:: with SMTP id t16mr742229wmj.117.1595272894524;
        Mon, 20 Jul 2020 12:21:34 -0700 (PDT)
Received: from x1 (50.red-80-27-209.dynamicip.rima-tde.net. [80.27.209.50])
        by smtp.gmail.com with ESMTPSA id w14sm34110232wrt.55.2020.07.20.12.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 12:21:33 -0700 (PDT)
Date:   Mon, 20 Jul 2020 21:21:30 +0200
From:   Drew Fustini <drew@beagleboard.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH] pinctrl: core: print gpio in pins debugfs file
Message-ID: <20200720192130.GA1964904@x1>
References: <20200718154908.1816031-1-drew@beagleboard.org>
 <CACRpkdapJj5Q3MBKrJkd3CBeJJDuuS-Cj6D=Gk67uyt4O_Oj-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdapJj5Q3MBKrJkd3CBeJJDuuS-Cj6D=Gk67uyt4O_Oj-A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 04:26:21PM +0200, Linus Walleij wrote:
> Hi Drew,
> 
> thanks for this patch, we're going the right direction here
> and creating things that are generically useful.
> 
> On Sat, Jul 18, 2020 at 5:53 PM Drew Fustini <drew@beagleboard.org> wrote:
> 
> > pin 103 (PIN103) GPIO-113 44e1099c 00000027 pinctrl-single
> > pin 104 (PIN104) GPIO-114 44e109a0 0000002c pinctrl-single
> (...)
> 
> Uh oh, that is the global GPIO number that we want to get
> rid of.
> 
> > +               gpio_num = 0;
> > +               list_for_each_entry(range, &pctldev->gpio_ranges, node) {
> > +                       if ((pin >= range->pin_base) &&
> > +                           (pin < (range->pin_base + range->npins)))
> > +                               gpio_num = range->base + (pin - range->pin_base);
> 
> There should be a break; here should it not?

Yes, good point. 

> > +               }
> > +
> > +               if (gpio_num > 0)
> > +                       seq_printf(s, "GPIO-%u ", gpio_num);
> 
> Can we print the gpio_chip name and offset instead?
> I want to discourage the world from thinking about these
> global GPIO numbers.
> 
> You can fetch the gpio_chip for the range pretty easily
> with
> 
> struct gpio_chip *chip = gpio_to_chip(gpio_num);
> 
> Also notice that this code needs to be
> #ifdef CONFIG_GPIOLIB somehow
> (maybe IS_ENABLED() works) because there
> are pin controllers in use without gpiolib believe it
> or not.
> 
> Yours,
> Linus Walleij

I've just posted a v2 [0] which makes sure the gpio information is only
if CONFIG_GPIOLIB.

I had a hard time finding line offset so I printed the line name
instead.  I would appreciate it if you could point me in the right place
to get the offset as that is cleaner in the 'pins' output.

thanks,
drew

[0] https://lore.kernel.org/linux-omap/20200720191740.1974132-1-drew@beagleboard.org/
