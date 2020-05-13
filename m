Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18442C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC39720722
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kf3uoBcY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390766AbgEMTmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 15:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387616AbgEMTmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 15:42:37 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D13DC061A0C;
        Wed, 13 May 2020 12:42:37 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id w6so944948ilg.1;
        Wed, 13 May 2020 12:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uINUBH0b67t7eYaVdOESIaSo4GsnVh3MgDPLeaDlYvQ=;
        b=kf3uoBcYAc8ZC02QIDPCZgxdfnLlHom1piA05+woOCC7646WUcvJ+cpVUT/csrQsC/
         K/Q/ItYqAVNA+MvlSbTTSylkjRMbx5p2+XF/xfpHae7fMmWKefe6OzozeTVXKtXARI8R
         4jHdVNe1kTp+adyHo8sPZ5i5SYQZGdfp6OlGTwxGZmHbJOCMCz+3pfsBawlydtRcD1oA
         Jssx4Bxz9oR1XBNMmzjPvnH4ymFhXKDluPKwv9pY179jlyO0xqcRB3Uam2qOVlF90jE7
         v7zbAt2fz9Ud/2LaJgZ3pyWdymGut2f6EK1CcME0HM539KjbhJWqgYT6bBfuRfCv2Pak
         12vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uINUBH0b67t7eYaVdOESIaSo4GsnVh3MgDPLeaDlYvQ=;
        b=FPAdI3qSGkxJT8MdLWlf7JR7Y8PWtLmaCNnQEMACiT6GwyQ/alkTlle4kMBZTF5Q5T
         /QJXSdMU9IB1/7lDhGQCLDdu+m4L/XApOJmxqjzIfAfZEOlPdtPlAWhGvaTK4KdbIT9d
         rmamaQ66Qs5pIiVYyq+UlCCjb/Z1T9vStQqOq3RkPq5Ww4qsNqxMhgcId/7EG2mQBMnB
         lQTZaPmCV4YClRmDrRl3BWvswpMAvO1+m6ElS3qtGFc5BssmrvvgwcVkPaSEXuOBnGtb
         nyNn6RFr3tg5ww+qvhvSOokP+65FF4/WqcXQXS1AxD4wtc0faRc1zvZ5maswPdRuTRs/
         Z+Dg==
X-Gm-Message-State: AOAM530qBWYzaHJmGYm3mWgX/vrTkrSzD0hayblrXwUeuT0GZZ/1+m5o
        qqVTvuDF/DRN/3KOq8kE6mSDWUqcGDuhDet/uW+/Jstn
X-Google-Smtp-Source: ABdhPJxTm1xgroYc2W51c5QCs9n6y0TBHp/24L3n0o5XMr5msuOmG19W+7cwoNcXSsf3jT3rkp/YlZAYEsp+LWW0+VU=
X-Received: by 2002:a92:6c0b:: with SMTP id h11mr1024982ilc.158.1589398956864;
 Wed, 13 May 2020 12:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200512150019.25903-1-alcooperx@gmail.com> <20200512150019.25903-2-alcooperx@gmail.com>
 <20200513122613.GA1023594@kroah.com> <7acc2a4c-caab-11e7-7b3f-4176f19c58cf@gmail.com>
 <20200513162723.GF1362525@kroah.com> <38ff034d-a84c-2309-a8d5-f344930d9a31@gmail.com>
 <20200513170505.GB1369204@kroah.com> <20200513173920.GA2862@rowland.harvard.edu>
 <c0642cf4-1436-aec4-96fd-355a897f6418@gmail.com>
In-Reply-To: <c0642cf4-1436-aec4-96fd-355a897f6418@gmail.com>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Wed, 13 May 2020 15:42:25 -0400
Message-ID: <CAOGqxeU=LjAmAYR9wGeKZo_eLj+ehkrANTM+04E7xWNAp82EJA@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] usb: xhci: Change the XHCI link order in the Makefile
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
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

On Wed, May 13, 2020 at 1:46 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 5/13/2020 10:39 AM, Alan Stern wrote:
> > On Wed, May 13, 2020 at 07:05:05PM +0200, Greg Kroah-Hartman wrote:
> >> On Wed, May 13, 2020 at 09:31:11AM -0700, Florian Fainelli wrote:
> >>>
> >>>
> >>> On 5/13/2020 9:27 AM, Greg Kroah-Hartman wrote:
> >>>> On Wed, May 13, 2020 at 08:08:07AM -0700, Florian Fainelli wrote:
> >>>>>
> >>>>>
> >>>>> On 5/13/2020 5:26 AM, Greg Kroah-Hartman wrote:
> >>>>>> On Tue, May 12, 2020 at 11:00:15AM -0400, Al Cooper wrote:
> >>>>>>> Some BRCMSTB USB chips have an XHCI, EHCI and OHCI controller
> >>>>>>> on the same port where XHCI handles 3.0 devices, EHCI handles 2.0
> >>>>>>> devices and OHCI handles <2.0 devices. Currently the Makefile
> >>>>>>> has XHCI linking at the bottom which will result in the XHIC driver
> >>>>>>> initalizing after the EHCI and OHCI drivers and any installed 3.0
> >>>>>>> device will be seen as a 2.0 device. Moving the XHCI linking
> >>>>>>> above the EHCI and OHCI linking fixes the issue.
> >>>>>>
> >>>>>> What happens if all of these are modules and they are loaded in a
> >>>>>> different order?  This makefile change will not help with that, you need
> >>>>>> to have logic in the code in order to properly coordinate this type of
> >>>>>> mess, sorry.
> >>>>>
> >>>>> I believe we should be using module soft dependencies to instruct the
> >>>>> module loaders to load the modules in the correct order, so something
> >>>>> like this would do (not tested) for xhci-plat-hcd.c:
> >>>>>
> >>>>> MODULE_SOFTDEP("post: ehci-hcd ohci-hcd");
> >>>>>
> >>>>> and I am not sure whether we need to add the opposite for ehci-hcd and
> >>>>> ohci-hcd:
> >>>>>
> >>>>> MODULE_SOFTDEP("pre: xhci-plat-hcd");
> >>>>
> >>>> That's a nice start, but what happens if that isn't honored?  This
> >>>> really needs to work properly for any order as you never can guarantee
> >>>> module/driver loading order in a system of modules.
> >>>
> >>> I also suggested that device links may help, though I am not sure. What
> >>> do you suggest to be done?
> >>
> >> No idea.  device links will help if you defer the probe properly until
> >> you see the proper drivers binding correctly.
> >
> > I suspect that in general there is no way to do this properly.
> >
> > We can't modify ehci-hcd and ohci-hcd to make them wait.  In fact, for
> > all they know, xhci-hcd will _never_ be loaded.
> >
> > One thing that might be possible (although not all platforms may support
> > it) is if xhci-hcd could somehow disconnect all devices attached to a
> > peer port when it starts up.  But that would be disruptive to any
> > devices that aren't USB-3.
> >
> > We faced a very similar ordering problem between ehci-hcd and
> > [ou]hci-hcd many years ago, and we never found a good solution.
> > We did arrange the link order so that ehci-hcd precedes the others, and
> > we added a warning message to ehci-hcd which gets printed if the module
> > initialization routine runs after [ou]hci-hcd is loaded.  Also, there
> > are MODULE_SOFTDEP lines in ohci-pci.c and uhci-pci.c.
>
> Given that these modules are used on specific SoC platforms, where we
> usually provide a reference implementation of user space and kernel
> space and documentation, it seems to me that the MODULE_SOFTDEP(),
> despite being a hint and best effort from user space module loaders is
> probably acceptable.
> --
> Florian

What I found in the past is that things work. For example if the ehci
driver starts first, the USB device will come up as a 2.0 device and
when the XHCI driver comes up the device will switch to 3.0. I've see
the same thing happen if OHCI starts before EHCI. It's just that there
are some poorly behaved USB devices that have trouble with this.

Al
