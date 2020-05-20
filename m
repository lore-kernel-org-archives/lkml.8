Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4091C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8093620885
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhdpZu87"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgETR36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 13:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgETR35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:29:57 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7504DC061A0E;
        Wed, 20 May 2020 10:29:57 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id c20so3993170ilk.6;
        Wed, 20 May 2020 10:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lCKrxI913KczzxpGD8MspvMckK47d7d0PM+CY0rASA4=;
        b=GhdpZu87ynUKHPZTE74DUYequ6mBVuZlFskQbMsWDsHRBsNgX7BI5bfIXo3t++G4VT
         SXE8J3DJPHdFMBl8Mbz2wrOS6jKdORWns92jTyer99K5LWficUr7281JpbR/oH8QhPcV
         DF78mx6uLtVzHMtNryCcqax3PBepaWrlw0uelhMgNSpchD4eiRgUTbTh6JigjfsmFYhd
         U32lmrKuOr2S0S/BXmk6Hhtroqxpg39YlWpPDz5su1TRuAG+gok2n5y1eIzG2Ng+Wdg2
         3mdXupA13OSfkJgRvbVFyjyPiOXLzSkGzlC12Ev/7mzoxNUhFCjrLYzAa9jVeaPtzU9b
         rXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lCKrxI913KczzxpGD8MspvMckK47d7d0PM+CY0rASA4=;
        b=Fslui4D9Y0jwrqFVyPMjmCc4z8ZQSt8sweOAxX40bjxlFTAOOBxLUJ7WriFYylmvrX
         tETm3AVarKD5FxF+cJGrIiZLscncDyNToqldbl/eRy1qDPwPLjHpH+EKjkkrtaAi84EM
         TYIHzxdPNpOUlgMMmqGXyfppjAwNjsp17Fnsq5NR5+DwTZCRcbU25MRWGIvgoK0K67gf
         6igz7xT08kEIn0a1GrmUgDrrjilPKyl5J+GPZLt1PsOoY6keorqNtrlP0vzBDaS4oVgd
         vqHPeHqPyXereT+BWwe62Qv5dYcrHtAmFDDffBxJ7wW7B0gpmP9mctKzbMsUlEd1JP4s
         fT6w==
X-Gm-Message-State: AOAM533GqfsGDdF7kdv2sBMOP4PHfZbc5e1dbN/PmKQe8u8m+GlKcxkN
        FJx3gRe4b+XSF9OM7YbzMy0fyHC7ReGiG3oUYgwZmA==
X-Google-Smtp-Source: ABdhPJzfcBOBJ7d1mVkBzgXDAncFAugXgtk1HCXVrZ/grJ5Uhqt7d6f5zF+3XvxztxW/C/jmxn1Ol6Tnd0Owny77vkk=
X-Received: by 2002:a92:914f:: with SMTP id t76mr5043167ild.238.1589995796399;
 Wed, 20 May 2020 10:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200512150019.25903-1-alcooperx@gmail.com> <20200512150019.25903-2-alcooperx@gmail.com>
 <20200513122613.GA1023594@kroah.com> <7acc2a4c-caab-11e7-7b3f-4176f19c58cf@gmail.com>
 <20200513162723.GF1362525@kroah.com> <38ff034d-a84c-2309-a8d5-f344930d9a31@gmail.com>
 <20200513170505.GB1369204@kroah.com> <20200513173920.GA2862@rowland.harvard.edu>
 <c0642cf4-1436-aec4-96fd-355a897f6418@gmail.com> <CAOGqxeU=LjAmAYR9wGeKZo_eLj+ehkrANTM+04E7xWNAp82EJA@mail.gmail.com>
In-Reply-To: <CAOGqxeU=LjAmAYR9wGeKZo_eLj+ehkrANTM+04E7xWNAp82EJA@mail.gmail.com>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Wed, 20 May 2020 13:29:45 -0400
Message-ID: <CAOGqxeV_9LpFudC3VuFPAOmYVYBQGJ+s01HCK2nP6XxpprK2Qw@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] usb: xhci: Change the XHCI link order in the Makefile
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg, Alan,

The other 4 related patches were accepted into usb-next and I just
realized that this one didn't make it. This patch will not fix the
"insmod out of order" issue, but will help our controllers work with
some poorly behaved USB devices when the drivers are builtin.

Thanks
Al

On Wed, May 13, 2020 at 3:42 PM Alan Cooper <alcooperx@gmail.com> wrote:
>
> On Wed, May 13, 2020 at 1:46 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> >
> >
> > On 5/13/2020 10:39 AM, Alan Stern wrote:
> > > On Wed, May 13, 2020 at 07:05:05PM +0200, Greg Kroah-Hartman wrote:
> > >> On Wed, May 13, 2020 at 09:31:11AM -0700, Florian Fainelli wrote:
> > >>>
> > >>>
> > >>> On 5/13/2020 9:27 AM, Greg Kroah-Hartman wrote:
> > >>>> On Wed, May 13, 2020 at 08:08:07AM -0700, Florian Fainelli wrote:
> > >>>>>
> > >>>>>
> > >>>>> On 5/13/2020 5:26 AM, Greg Kroah-Hartman wrote:
> > >>>>>> On Tue, May 12, 2020 at 11:00:15AM -0400, Al Cooper wrote:
> > >>>>>>> Some BRCMSTB USB chips have an XHCI, EHCI and OHCI controller
> > >>>>>>> on the same port where XHCI handles 3.0 devices, EHCI handles 2.0
> > >>>>>>> devices and OHCI handles <2.0 devices. Currently the Makefile
> > >>>>>>> has XHCI linking at the bottom which will result in the XHIC driver
> > >>>>>>> initalizing after the EHCI and OHCI drivers and any installed 3.0
> > >>>>>>> device will be seen as a 2.0 device. Moving the XHCI linking
> > >>>>>>> above the EHCI and OHCI linking fixes the issue.
> > >>>>>>
> > >>>>>> What happens if all of these are modules and they are loaded in a
> > >>>>>> different order?  This makefile change will not help with that, you need
> > >>>>>> to have logic in the code in order to properly coordinate this type of
> > >>>>>> mess, sorry.
> > >>>>>
> > >>>>> I believe we should be using module soft dependencies to instruct the
> > >>>>> module loaders to load the modules in the correct order, so something
> > >>>>> like this would do (not tested) for xhci-plat-hcd.c:
> > >>>>>
> > >>>>> MODULE_SOFTDEP("post: ehci-hcd ohci-hcd");
> > >>>>>
> > >>>>> and I am not sure whether we need to add the opposite for ehci-hcd and
> > >>>>> ohci-hcd:
> > >>>>>
> > >>>>> MODULE_SOFTDEP("pre: xhci-plat-hcd");
> > >>>>
> > >>>> That's a nice start, but what happens if that isn't honored?  This
> > >>>> really needs to work properly for any order as you never can guarantee
> > >>>> module/driver loading order in a system of modules.
> > >>>
> > >>> I also suggested that device links may help, though I am not sure. What
> > >>> do you suggest to be done?
> > >>
> > >> No idea.  device links will help if you defer the probe properly until
> > >> you see the proper drivers binding correctly.
> > >
> > > I suspect that in general there is no way to do this properly.
> > >
> > > We can't modify ehci-hcd and ohci-hcd to make them wait.  In fact, for
> > > all they know, xhci-hcd will _never_ be loaded.
> > >
> > > One thing that might be possible (although not all platforms may support
> > > it) is if xhci-hcd could somehow disconnect all devices attached to a
> > > peer port when it starts up.  But that would be disruptive to any
> > > devices that aren't USB-3.
> > >
> > > We faced a very similar ordering problem between ehci-hcd and
> > > [ou]hci-hcd many years ago, and we never found a good solution.
> > > We did arrange the link order so that ehci-hcd precedes the others, and
> > > we added a warning message to ehci-hcd which gets printed if the module
> > > initialization routine runs after [ou]hci-hcd is loaded.  Also, there
> > > are MODULE_SOFTDEP lines in ohci-pci.c and uhci-pci.c.
> >
> > Given that these modules are used on specific SoC platforms, where we
> > usually provide a reference implementation of user space and kernel
> > space and documentation, it seems to me that the MODULE_SOFTDEP(),
> > despite being a hint and best effort from user space module loaders is
> > probably acceptable.
> > --
> > Florian
>
> What I found in the past is that things work. For example if the ehci
> driver starts first, the USB device will come up as a 2.0 device and
> when the XHCI driver comes up the device will switch to 3.0. I've see
> the same thing happen if OHCI starts before EHCI. It's just that there
> are some poorly behaved USB devices that have trouble with this.
>
> Al
