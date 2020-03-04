Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC33C3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 02:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4580B2073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 02:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="svKGsOub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387513AbgCDCyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 21:54:25 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:38643 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387459AbgCDCyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 21:54:24 -0500
Received: by mail-ua1-f68.google.com with SMTP id y3so146093uaq.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 18:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BeYrItptjbmjm//xr6aNyLoo5RY49LjduotLIGizl2Q=;
        b=svKGsOub7ZxaZcRswMLgCyDY9M7NlICSs5yYlhOef4CgZNMJcaYeET/xRbMKQ2Sjr5
         x7GrMkay5P8/ZTFyES2T+ek+RbYR2RemcPCVu+HbAmIFr52QuJUfNlYIDjqSawG8QDzp
         0vCxvKUV/N1gtjL905bZyOBMcqzTysyA9eRQIdcblr7hiLn1f0+ey7tUnKSqwIK0dsIS
         QBaYZSPDhDrYqdgCHcHWHXctCO5wH1KioQ8OeE2T7xde0a1zreyfPiWu4q1SIFRVPuK5
         aXi9e42c6PiHzw6poPmQTBgbmSY2eZooZwI57dm74ZY9MkZBdtGScDfCaLfZfBsw1f2W
         kINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BeYrItptjbmjm//xr6aNyLoo5RY49LjduotLIGizl2Q=;
        b=ODJbH64Yu9MmixYctWlZugHj/B2kT+mUnWV3b8dHDvjDlvfh0fll25r1S42OwHW3Cf
         4PsCeHRTgRPucrHZW1CcQ+81KefB8wFvdgQR7gOc7VsWVxaTEAyXf2sO8tgJ0NJW9gPs
         WI58MBcPMS4kP3SHBMGSAT88kKqY305PberZ7OXPsNg9u39oWqnzTvvqhzlCUhTdTnW0
         +PYf944GZDYEhS92Uu5dF2x4zxc6GHMMQhKhkcAZRxufKPS0i9MX6XXcTteV78PfukUC
         EPr7H+THdHm6i4+jonwGLQHnoiQ2twDUd0LLpcBrg/U+qZEg1zOpsZnjfJYC9re0MMsN
         HS8g==
X-Gm-Message-State: ANhLgQ1QH6PpGQrCjjHz6BkmUm7rTQSr/a6sW8x2OhgFdRfWLbpKCgmn
        J90wUrWGBwq2gv2LPu0Adn061Cqzu3HoA4F9VkfyRQ==
X-Google-Smtp-Source: ADFU+vsmy3goZ2XX5DADDbfFg/eIMnxSpbzjpinVr40A+RklPux/uxz2QGDs7Xd1N45NfSJVEjGvjDKfrkpOY1fF7WQ=
X-Received: by 2002:ab0:1161:: with SMTP id g33mr388779uac.32.1583290462899;
 Tue, 03 Mar 2020 18:54:22 -0800 (PST)
MIME-Version: 1.0
References: <2094703.CetWLLyMuz@kreacher> <CAD8Lp46VbG3b5NV54vmBFQH2YLY6wRngYv0oY2tiveovPRhiVw@mail.gmail.com>
 <CAPpJ_edfTg11QZs25MrThj2+FKUo2103rv7iYNzo=kr-jeg1MA@mail.gmail.com>
 <CAJZ5v0gB9yuVmPjJ_MvfT8aFpvP-X5JRsNfZn8+Mv5RwTednGg@mail.gmail.com>
 <CAJZ5v0imqwdmXzKayqs1kgHOb-mXrkr61uNxVka8J9bKca989Q@mail.gmail.com>
 <CAPpJ_efvF0XzjevA1eL3BUJqBwxRTOPLcqWKN40Azj-n1AtjcA@mail.gmail.com>
 <CAJZ5v0hie79+jG+3h4t5Q8r0M7E37HY-7i8ijg8DpvS0RXZSiQ@mail.gmail.com> <CAJZ5v0hwrZX4+4m-g0c2bUTHxJO=1+kenXBjLz1ChWdcxSLJbA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hwrZX4+4m-g0c2bUTHxJO=1+kenXBjLz1ChWdcxSLJbA@mail.gmail.com>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Wed, 4 Mar 2020 10:53:33 +0800
Message-ID: <CAPpJ_ed5KPPu47ri3phnjKrToqJ8vSNV32zaRmBPLr3pq4M_4A@mail.gmail.com>
Subject: Re: [PATCH 0/6] ACPI: EC: Updates related to initialization
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Drake <drake@endlessm.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki <rafael@kernel.org> =E6=96=BC 2020=E5=B9=B43=E6=9C=884=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=886:23=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Mar 3, 2020 at 10:09 AM Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> >
> > On Tue, Mar 3, 2020 at 8:29 AM Jian-Hong Pan <jian-hong@endlessm.com> w=
rote:
> > >
> > > Rafael J. Wysocki <rafael@kernel.org> =E6=96=BC 2020=E5=B9=B43=E6=9C=
=882=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:45=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > >
>
> [cut]
>
> > >
> > > Originally, ec_install_handlers() will return the returned value from
> > > install_gpio_irq_event_handler() from acpi_dev_gpio_irq_get(), which
> > > is -EPROBE_DEFER, instead of -ENXIO.  However, ec_install_handlers()
> > > returns -ENXIO directly if install_gpio_irq_event_handler() returns
> > > false in patch ("ACPI: EC: Consolidate event handler installation
> > > code").  Here needs some modification.
> >
> > Thanks, I forgot about the -EPROBE_DEFER case.
>
> The top-most commit in the git branch at
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  acpi-ec-work
>
> has been updated to take that case into account (I think that it
> should be spelled out explicitly or it will be very easy to overlook
> in the future).
>
> Please test this one if possible.

Tested the commits on some laptops including ASUS UX434DA.  The
brightness hotkeys are working now.

Jian-Hong Pan
