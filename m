Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5BCC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74D7620663
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbgEVSmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 14:42:19 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:55263 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730810AbgEVSmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 14:42:19 -0400
Received: from mail-qv1-f51.google.com ([209.85.219.51]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MfYgC-1j5JiK2vuq-00fwui for <linux-kernel@vger.kernel.org>; Fri, 22 May
 2020 20:42:16 +0200
Received: by mail-qv1-f51.google.com with SMTP id z5so5210874qvw.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 11:42:16 -0700 (PDT)
X-Gm-Message-State: AOAM533bbV0Vk2jRSSeEoVApKW4XVFeUDvGG28Cc8YqedEseFEmrHeFm
        +AeKruSqdsV4yLx/MRNWLMFm+KNrG3iLD1bZIAQ=
X-Google-Smtp-Source: ABdhPJzFVnkf+PvpPEzApe1Xh6QwmCJUxAiArf1NkHnRleJW+eTmbotFp5kg3dtkbzDv0h+b8Lx2AAmQGRf7PAZOxxQ=
X-Received: by 2002:a05:6214:370:: with SMTP id t16mr5130521qvu.197.1590172935518;
 Fri, 22 May 2020 11:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200522124951.35776-1-sudeep.holla@arm.com> <20200522124951.35776-3-sudeep.holla@arm.com>
 <CAK8P3a1t6BrB_Gti138VDRbmaiR_TjwR9d6qMstLBFDWxZ1kjQ@mail.gmail.com> <20200522165422.GA18810@bogus>
In-Reply-To: <20200522165422.GA18810@bogus>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 May 2020 20:41:59 +0200
X-Gmail-Original-Message-ID: <CAK8P3a33_5q1bNRrt+4sQ55QKrN12rOkuzmPH0BDujbug1RTyA@mail.gmail.com>
Message-ID: <CAK8P3a33_5q1bNRrt+4sQ55QKrN12rOkuzmPH0BDujbug1RTyA@mail.gmail.com>
Subject: Re: [PATCH 2/2] firmware: smccc: Add ARCH_SOC_ID support
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        harb@amperecomputing.com, Jose.Marinho@arm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Francois Ozog <francois.ozog@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:IPhmcgVpBkEjJKlvdGP1qrY1bvXDIHYiVy6nluDtEuhzU2Ox7n6
 IYYTvAJ6MvLzuJhsCMbCaTTH2dbw0yv0hYURLnaJZj5FyxrTTYvz6UsLsj593Ij8jHNaqkY
 p15C+GlQiVVsHhpfESdENTBEaBaZDRwhHpU6edCTtC+tjI5tHMCwExIktZRB8puGIllxbrO
 +l91yppNgNkshZv/v6hLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:af7NnydQjGo=:4XGkQSSM5vQTxYreAQ1FC+
 WlS1y8/MPGgociZQ7VT0Xai2C6IvvVElY5Oj/ow3f/Rh7QYjDxM75i6KM8zgREMbf841CAzos
 xONVTtWxDORjDXSbzSYvMFcWj/+j2klk5m54WMXlLVQcwikM7yBp5rzw8BuO0IdOpX9ocYbzH
 dh62A2xSp41aG1yNeFwdpZOiWHl7qq2BAr53YkvpzSmS6+WoPsHflRNGbyxovq/8uhm3PDzMr
 eiT38b0DumrKMEbgLjYllpQe27lhouIrumTY0/u+QtDCNHrHtEEAkdxp58SQqXkT/SrKB3df0
 Kw7CJbS8V89UL+NR0wykCj6RXUpLTnbDgxjTyZmVYgprm4kevqOeHVPkiXgm4x/GtPifruFIO
 QKOgTtgl9sR43sBIU3/pNhqbT/DJpAmx5vDy/V0YDJZsjs2m0DgMUrV0MaKKVG8jUDkZCgLpQ
 JIGsaE4yI70bwoEAOQcXaxDB6LRb9y6EYRY8RBnRz0UVl5wCW0jzUW0fl19Djl7zL1FWlMqau
 PwXPpGplKG+wHgF8DZ4+QLTfhEidfJ7+TUtnfFLaUSew7ZGM+NuIdP+VDiqYQhLPP5+MRBnRr
 3+jJWx4Emt3lvVQae89PrvXtIXgzM5UvD+uD3QMMLMe5307noFGTDX0Ko17OmDTz+sFGfdGmk
 2MRPVVzHZcr8uuFkx2Z2sGd2jcEibtjUjltHsFSDvpnN9TLTn9wRN34erLhy9J55/LJ7r8WXt
 H+1TW3pZgeWKWlgHMtdUIbOF3pITKWfoidu3R+62oJSxO/s8rO7LZRSly0skvHuftpfel1GIa
 KOJ7wheqelu29xpaUH1cRLeSMtsF0Olq6xxLH+Xn0pvxM8tOIw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 6:54 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> (+ Jose (SMCCC Spec author))
>
> On Fri, May 22, 2020 at 04:46:12PM +0200, Arnd Bergmann wrote:
> > On Fri, May 22, 2020 at 2:50 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > +
> > > +       soc_id_rev = res.a0;
> > > +
> > > +       soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> > > +       if (!soc_dev_attr)
> > > +               return -ENOMEM;
> > > +
> > > +       sprintf(soc_id_str, "0x%04x", IMP_DEF_SOC_ID(soc_id_version));
> > > +       sprintf(soc_id_rev_str, "0x%08x", soc_id_rev);
> > > +       sprintf(soc_id_jep106_id_str, "0x%02x%02x",
> > > +               JEP106_BANK_CONT_CODE(soc_id_version),
> > > +               JEP106_ID_CODE(soc_id_version));
> > > +
> > > +       soc_dev_attr->soc_id = soc_id_str;
> > > +       soc_dev_attr->revision = soc_id_rev_str;
> > > +       soc_dev_attr->jep106_id = soc_id_jep106_id_str;
> >
> > Ok, let me try to understand how this maps the 64-bit ID into the
> > six strings in user space:
> >
> > For a chip that identifies as
> >
> > JEP106_BANK_CONT_CODE = 12
> > JEP106_ID_CODE = 34
> > IMP_DEF_SOC_ID = 5678
> > soc_id_rev = 9abcdef0
> >
> > the normal sysfs attributes contain these strings:
> >
> > machine = ""
> > family = ""
> > revision = "0x9abcdef0
> > serial_number = ""
> > soc_id = "0x5678"
> >
> > and the new attribute is
> >
> > jep106_identification_code = "0x1234"
> >
> > This still looks like a rather poorly designed interface to me, with a
> > number of downsides:
> >
> > - Nothing in those strings identifies the numbers as using jep106
> >   numbers rather than some something else that might use strings
> >   with hexadecimal numbers.
> >
>
> Not sure if I understand your concerns completely here.
>
> Anyways I wanted to clarify that the jep106 encoding is applicable only
> for manufacturer's id and not for SoC ID or revision. Not sure if that
> changes anything about your concerns.

The problem I see is that by looking at just the existing attributes,
you have no way of telling what namespace the strings are in,
and a script that tries pattern matching could confuse two
hexadecimal numbers from a different namespace, such as
pci vendor/device or usb vendor/device IDs that are similar
in spirit to the jep106 codes.

> > - I think we should have something unique in "family" just because
> >   existing scripts can use that as the primary indentifier

This is part of the same issue: If we put just "jep106 identified SoC"
as the "family", it would be something a driver could match against.

> > How about making the contents:
> >
> > machine = "" /* could be a future addition, but board specific */
> > family = "jep106:1234"
>
> But this just indicates manufacturer id and nothing related to SoC family.
> If it is jep106:043b, all it indicates is Arm Ltd and assigning it to
> family doesn't sound right to me.
>
> I had requests for both of the above during the design of interface but
> I was told vendors were happy with the interface. I will let the authors
> speak about that.

In most cases, the existing drivers put a hardcoded string into the
family, such as

"Samsung Exynos"
"Freescale i.MX"
"Amlogic Meson"

or slightly more specific

"R-Car Gen2"

Having a numeric identifier for the SoC manufacturer here is a
bit more coarse than that, but would be similar in spirit.

> > soc_id = "jep106:1234:5678" /* duplicates family but makes it unique*/
>
> Not sure again.

> > That would work without any new properties, dropping the other patch,
> > and be easier to use for identification from user space.
> >
>
> OK, I agree on ease part. But for me, we don't have any property in the
> list to indicate the vendor/manufacturer's name. I don't see issue adding
> one, name can be fixed as jep106_identification_code is too specific.
>
> How about manufacturer with the value in the format "jep106:1234" if
> it is not normal string but jep106 encoding.

I don't think we need a real name like "Arm" or "Samsung" here,
but just a number is not enough, it should at least be something
that can be assumed to never conflict with the name of a chip
by another scheme.

jep106:5678 (the IMP_DEF_SOC_ID field in my example) would
probably be sufficient to not conflict with a another soc_device
driver, but is quite likely to clash with an ID used by another
manufacturer.

jep106:1234 (the manufacturer ID) in turn seems too broad from
the soc_id field, as that would include every chip made by one
company.

     Arnd
