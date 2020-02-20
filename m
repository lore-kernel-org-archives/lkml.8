Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1928CC11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BC624673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fet/hAJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgBTSjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:39:44 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38114 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgBTSjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 13:39:44 -0500
Received: by mail-lj1-f196.google.com with SMTP id w1so5303824ljh.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 10:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3vyjS+sSAn3HYPmeF1oEJkpsll37OiGUssC+8/K51/4=;
        b=Fet/hAJhRQDtnDP9fg9J/Du5q7cM5Im1hzXwBAPqhu2dstZav58Aai8qQzGCEwopyz
         zMPwaJnL1eR877ocln94AJ6Vpjh7ddFYahar/44+bdmjT5tB438dLnZx/xywAczqBiRD
         igdNTNKR8Yze1Wl0UJPDmfdxu8eYKckGOqDfW1iOhhdPbn9kZv2BE5LoO8eTcyv+QrtC
         tp2Tk4EuXHgorJDZ12DDHBsZ/lLGCqO41vga0yBfiQ5fxGgLuueeB6V5eAtnz6q2uYTm
         QLlKStRRGLoPj2IWAXDSFUIG7hc2LlcmmjwAnXRUrNDn3nczFFgFAa04qDglWe+mey4t
         C+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3vyjS+sSAn3HYPmeF1oEJkpsll37OiGUssC+8/K51/4=;
        b=QgOgodfhMG08Pab/hHVXDHlVaBTHKw959S3R73cg7bOttEA43S5YPYtpnrfUGzzukt
         kkfX3h6NzO5bYe9ZPxbGkq8PV5aAIyG6e/q3zSnDssvZtFculjrGb52BgbgnKTuJYCoN
         V0qh0oE9jJmDVeH4Mu30z8DBPXk4Jxmd0N42ZNrsUr5KS8boj65wtB4SndOEN6zZOnoc
         q1Udj1HeUTF2/wi//wugxR6Sopv0hLXnpvfgesYXQWNWg7tZP9PbMTFcLa4C1wATCn7V
         dHblas3PPbHnbjMo/ZxTZPc2T3Z9suHN54xBP7v18HdD5Aw4NW+2a2MRioJvnaY1f6qB
         AXEQ==
X-Gm-Message-State: APjAAAWQn8zFL8UIm2/t8F5FNL/aObQKVXDiCP3AMBqfKikSMWlvbDJq
        N1hx7kzPMOsGF9CvB3v1d4LSNeDPWXrvu+pLPKfdTw==
X-Google-Smtp-Source: APXvYqys1CrHuhdls6fUzfaBKFoB6DGlWqs1OzjbcuZBdCWN4qR+/3UHYv/iiSDM7pzKg5S+L4o+VvdSv2sjVcwdDUo=
X-Received: by 2002:a2e:94c8:: with SMTP id r8mr19894589ljh.28.1582223979390;
 Thu, 20 Feb 2020 10:39:39 -0800 (PST)
MIME-Version: 1.0
References: <20200220074637.7578-1-njoshi1@lenovo.com> <CAHp75VcJmEOu1-b7F2UAsv=Gujb=pPLzjz2ye9t4=Q68+ors-w@mail.gmail.com>
 <HK2PR0302MB25937E2946BF38583B3A905DBD130@HK2PR0302MB2593.apcprd03.prod.outlook.com>
In-Reply-To: <HK2PR0302MB25937E2946BF38583B3A905DBD130@HK2PR0302MB2593.apcprd03.prod.outlook.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Thu, 20 Feb 2020 10:39:02 -0800
Message-ID: <CACK8Z6GwuOnJUUscriGwKWGBp5PFKyuqUkFYC8tEXa0UEuEZww@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] thinkpad_acpi: Add sysfs entry for
 lcdshadow feature
To:     Mark Pearson <mpearson@lenovo.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nitin Joshi <nitjoshi@gmail.com>,
        Mat King <mathewk@google.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thinkpad-acpi devel ML <ibm-acpi-devel@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Nitin Joshi1 <njoshi1@lenovo.com>,
        Benjamin Berg <bberg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, Feb 20, 2020 at 7:14 AM Mark Pearson <mpearson@lenovo.com> wrote:
>
> Hi Andy
>
> > -----Original Message-----
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Thursday, February 20, 2020 5:43 AM
> >
> > On Thu, Feb 20, 2020 at 9:48 AM Nitin Joshi <nitjoshi@gmail.com> wrote:
> > >
> > >   This feature is supported on some Thinkpad products like T490s, Thi=
nkpad
> > >   X1 yoga 4th Gen etc . The lcdshadow feature can be enabled and disa=
bled
> > >   when user press "Fn" + "D" key. Currently, no user feedback is give=
n for
> > >   this action. Adding as sysfs entry allows userspace to show an On S=
creen
> > >   Display whenever the setting changes.
> > >
> > >   Summary of changes is mentioned below :
> > >
> > >  - Added TP_HKEY_EV_LCDSHADOW_CHANGED for consistency inside the
> > driver
> > >  - Added unmapped LCDSHADOW to keymap
> > >  - Added lcdshadow_get function to read value using ACPI
> > >  - Added lcdshadow_refresh function to re-read value and send notific=
ation
> > >  - Added sysfs group creation to tpaci_lcdshadow_init
> > >  - Added lcdshadow_exit to remove sysfs group again
> > >  - Implemented lcdshadow_enable_show/lcdshadow_enable_store
> > >  - Added handler to tpacpi_driver_event to update refresh lcdshadow
> > >  - Explicitly call tpacpi_driver_event for extended keyset
> >
> > Adding custom PrivacyGuard support to this driver was my mistake,
> > There is a discussion [1] how to do this in generic way to cover other
> > possible users.
> > I Cc this to people from that discussion.
> >
> > [1]: https://lore.kernel.org/dri-
> > devel/CAL_quvRknSSVvXN3q_Se0hrziw2oTNS3ENNoeHYhvciCRq9Yww@mail
> > .gmail.com/
> >
> Thanks for the pointer to that thread - really useful and interesting, we=
 weren't aware there was an ongoing exercise to do this.
>
> I work with Nitin as part of the Linux team at Lenovo. We're trying to ge=
t more directly and actively involved in the open source community to impro=
ve the Linux experience on Lenovo devices and of course want to make sure w=
e contribute the right way. We're all still pretty new so pointers and help=
 are very much appreciated (we've been getting some great support from the =
distros to get us started).
>
> For this particular issue what is the best way to contribute and get invo=
lved? We'd like to make it so ePrivacy can be used more easily from Linux. =
I agree a more generic way of controlling it would be good.
> I looked at the proposed patch from Rajat (https://lkml.org/lkml/2019/10/=
22/967) - it seems like a good solution to me. We can help with testing tha=
t on our platforms if that would be useful.

Thanks you, just so that you know, the latest patchset is at:
https://lkml.org/lkml/2019/12/20/794

It would be great to get some additional testing if possible. I can
send a sample ACPI (for our platform) in case it helps.

>
> I need to understand how we connect that implementation with the ACPI con=
trols we have (as I believe what we have are thinkpad specific and not to a=
 drm spec; we need to confirm that). We also have the ACPI events that noti=
fy if ePrivacy was changed by the hotkeys and that seems like something tha=
t should be done in thinkpad_acpi.c and not the drm code.

Not sure if the two need to be connected somehow (or if handling the
event is actually not important and polling is acceptable)?

So there was some brief discussion about this on my patches - but
atleast on  the platforms I have seen, there was no way to change the
privacy screen out of software / kernel control. Essentially, if there
are hotkeys, they would send an input event to the kernel, who'd send
them to userspace, who'd use the DRM method to toggle the privacy
screen. Thus the current version of the patch only supports
controlling the privacy screen via set() method. The get() method just
returns the cached value.I hope that works for you.

Jani, I'm waiting on your inputs here
https://lkml.org/lkml/2020/1/24/1932 in order to send the next
iteration of my patch. Can you please let me know if you have any
comments.

Thanks & Best Regards,

Rajat

>
> As a note Nitin has been working with the Red Hat folk and is looking at =
the user space aspect of this (in particularl gnome settings) as well.
>
> Thanks
> Mark Pearson
