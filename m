Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342FBC38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 02:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1069821841
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 02:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FQVf+DFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgDQCGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 22:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728954AbgDQCGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 22:06:47 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ABDC061A41
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 19:06:46 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id c138so329813pfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 19:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Hfdx7uDJvgrGkRYQDhx6DARmHevGcYuM4GwFr74akkA=;
        b=FQVf+DFnRHPeQ/SGO5Hw0smu9KCNhym996v6AIV/dsuwaWRyhQrYQwMlpB1zt0+nX/
         BSOYTHaqkFX/m3b9KlZPcrLzLGvOlmcJROEVN5Y5MvozAx1dvDjYDESncXlfAe105qfx
         onkTOTzapOUqP3I+4socEd8Os145UAQyxt7/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Hfdx7uDJvgrGkRYQDhx6DARmHevGcYuM4GwFr74akkA=;
        b=ahZY0GNWIj9nS23cwfZtOLFgHnvQKIwP9lE09O9PQzPjmnjB8Wtx7+x0syg/DpaMj/
         Q1mc+kI4I+dYgNwTkC3WmpKP9Ho7KVD2BA3/VFevcLOWWW2b+5O7QExEnVRvu+VVwIYO
         /hzYZCaKdNd68wH78g16IT+G27CSYgQTunalCyYEH/8er4jXPk0pSS+iqPEHDxnk7YCa
         6uN5eGV2S2EwL0gXVdWSpysROaYloPW0+63amalFSsQh47KSjeBl+/b7FZeGVW6kycVm
         l7EgB5dTQb09paSBVASM8cACh51ao5wLEqq69TLb0qN6IoTuAOnzAPGOHIJhCBPeBUWG
         9CLg==
X-Gm-Message-State: AGi0Pua2OfadgzOSRoqP/AOdf2TGVGYTC/xABJnZMW32x5xIXx10Gk/k
        uulW1bRC7bCC1bRCScxCSUxq6w==
X-Google-Smtp-Source: APiQypIAm+eOkLnh9jfVGsJPFCRSE3u2oQZAeMT8zXL+p+ToKv0aaogvmqJScYekjpJ7CEwbwJZhCw==
X-Received: by 2002:a63:2cce:: with SMTP id s197mr761627pgs.184.1587089205194;
        Thu, 16 Apr 2020 19:06:45 -0700 (PDT)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id t5sm365532pjo.19.2020.04.16.19.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 19:06:44 -0700 (PDT)
Date:   Thu, 16 Apr 2020 19:06:41 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     =?utf-8?Q?Micha=C5=82?= Stanek <mst@semihalf.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, stanekm@google.com,
        stable@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>,
        levinale@chromium.org, andriy.shevchenko@linux.intel.com,
        Linus Walleij <linus.walleij@linaro.org>,
        bgolaszewski@baylibre.com, rafael.j.wysocki@intel.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] pinctrl: cherryview: Add quirk with custom translation
 of ACPI GPIO numbers
Message-ID: <20200417020641.GA145784@google.com>
References: <20200205194804.1647-1-mst@semihalf.com>
 <20200206083149.GK2667@lahna.fi.intel.com>
 <CAMiGqYi2rVAc=hepkY-4S1U_3dJdbR4pOoB0f8tbBL4pzWLdxA@mail.gmail.com>
 <20200207075654.GB2667@lahna.fi.intel.com>
 <CAMiGqYjmd2edUezEXsX4JBSyOozzks1Pu8miPEviGsx=x59nZQ@mail.gmail.com>
 <20200210101414.GN2667@lahna.fi.intel.com>
 <CAMiGqYiYp=aSgW-4ro5ceUEaB7g0XhepFg+HZgfPvtvQL9Z1jA@mail.gmail.com>
 <20200310144913.GY2540@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200310144913.GY2540@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mika,

I'm following along with attempts to "fix" our user space to paper over
this issue, and I think some of this conversation missed the mark.
(Sorry for jumping in late.)

On Tue, Mar 10, 2020 at 04:49:13PM +0200, Mika Westerberg wrote:
> On Tue, Mar 10, 2020 at 03:12:00PM +0100, Michał Stanek wrote:
> > On Mon, Feb 10, 2020 at 11:14 AM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > > On Sat, Feb 08, 2020 at 07:43:24PM +0100, Michał Stanek wrote:
> > > > > >
> > > > > > Hi Mika,
> > > > > >
> > > > > > The previous patches from Dmitry handled IRQ numbering, here we have a
> > > > > > similar issue with GPIO to pin translation - hardcoded values in FW
> > > > > > which do not agree with the (non-consecutive) numbering in newer
> > > > > > kernels.
> > > > >
> > > > > Hmm, so instead of passing GpioIo/GpioInt resources to devices the
> > > > > firmware uses some hard-coded Linux GPIO numbering scheme? Would you
> > > > > able to share the exact firmware description where this happens?
> > > >
> > > > Actually it is a GPIO offset in ACPI tables for Braswell that was
> > > > hardcoded in the old firmware to match the previous (consecutive)
> > > > Linux GPIO numbering.
> > >
> > > Can you share the ACPI tables and point me to the GPIO that is using
> > > Linux number?
> > 
> > I think this is the one:
> > https://chromium-review.googlesource.com/c/chromiumos/third_party/coreboot/%2B/286534/2/src/mainboard/google/cyan/acpi/chromeos.asl
> > 
> > On Kefka the sysfs GPIO number for wpsw_cur was gpio392 before the
> > translation change occurred in Linux.
> 
> But that table does not seem to have any GPIO numbers in it.

Actually, it's encoding pin numbers, not GPIO numbers. The 0x10016 (or
now, 0x10013) is encoding a bank offset (0x10000) and pin number (0x16
or 0x13). The actual pin numbers is 0x16, I believe, but someone decided
to subtract 3, because the Linux numbering used to be contiguous,
skipping over the hole between 11 and 15.

So no, nobody was hard-coding gpiochip numbers -- we were hard-coding
the contiguous pin number (relative to the bank). Now that commit
03c4749dd6c7ff94 ("gpio / ACPI: Drop unnecessary ACPI GPIO to Linux GPIO
translation") made those non-contiguous, we're kinda screwed -- we have
to guess (based on the kernel version number) whether pin numbers
(within a single bank!) are contiguous or not.

> > > This is something that should be fixed in userspace. Using global Linux
> > > GPIO or IRQ numbers is fragile and source of issues like this.

To be clear, we're not hard-coding global <anything> numbers in user
space.

> > > in case of sysfs, you can
> > > find the base of the chip

We're doing that.

> > > and then user relative numbering against it or
> > > switch

^^ This is the problem. The *bank-relative* numbers changed.

> > > Both cases the GPIO number are relative against the GPIO chip so
> > > they work even if global Linux GPIO numbering changes.
> > 
> > I analyzed crossystem source code and it looks like it is doing
> > exactly what you're saying without any hardcoded assumptions.

^^ Exactly.

> > With the newer kernel the gpiochip%d number is different so crossystem
> > ends up reading the wrong pin.
> 
> Hmm, so gpiochipX is also not considered a stable number. It is based on
> ARCH_NR_GPIOS which may change. So if the userspace is relaying certain GPIO
> chip is always gpichip200 for example then it is wrong.

If you just read the last sentence from Michal, you get the wrong
picture. There's no hard-coding of gpiochipX numbers going on. We only
had the pin offsets "hardcoded" (in ACPI), and the kernel driver
unilaterally changed from a contiguous mapping to a non-contiguous
mapping.

How do you recommend determining (both pre- and
post-commit-03c4749dd6c7ff94) whether pin 22 is at offset 22, vs. offset
19?

Brian
