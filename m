Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F378AC11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94972071E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Np8DJaVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgBTKnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 05:43:03 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42995 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgBTKnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:43:03 -0500
Received: by mail-pf1-f193.google.com with SMTP id 4so1727940pfz.9;
        Thu, 20 Feb 2020 02:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kxfpH7hofI2dT1EmNwZZMlMZMqhtSme6d7SbXx3CYq0=;
        b=Np8DJaVuBXgINq398uI6JEI2yyXyGAh82e7JU+kt0/8soFTOF7YQwPC5PE0wGnizng
         ue5XDE3A+y5lsbRnJzClaOJx6v6ZFg1wgwpYORYjNPerLUsWeb29Yh35FoYYmmI6JAj1
         ZT2DAkdxv3Tiwb4WTCwqVqCinjAbA81UN604IN7J28r4b538GGiRZaoVmlD2tYfIvJmU
         /rHaEx693IcAHpxrikt9vHfdi//+DyrLKz4trG/Dd/Mb2gekSeNATFmbId4UH+odFZaL
         AJ4PR9y1fLZytpGX/rKF5f5KDyk52m9bfbwHZFakl1bsfjT0OqJxfx8EhXy6WM53xPBQ
         QC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kxfpH7hofI2dT1EmNwZZMlMZMqhtSme6d7SbXx3CYq0=;
        b=SAz8YUu1l9DeGNnfr6vyN1GnFqHYwXpm5LDRs7YOujjibdILQKBt6mp33Zs/v6XqqO
         jf0HdL3TL86V8GBFHOlnF1FOUmb6IwALVs6CvzUaG0FM1V7G5uXdprEXs0fzB7Ybfs2G
         dj64jDE3PoZmZfPJ23IBFwoSUXSNZTRgkJMgxedkFpwsvw/4qQIaD9qIvj05KGSrq418
         729ChSNunLQvcO2Ji2r2Rwc+znAc76l/fpTrjKks+9AHb9eA8WesYOWw1gRJxatwvNN0
         6dyFmI2F8EeJu4s7kvmBij7gU4GnywbUIZTQ7lalWYnzK8ySvipZlY05C5gtOjynci4F
         dseQ==
X-Gm-Message-State: APjAAAWWN0t45h8AcQY05nfBhtq7hXZhiG8c91Swe+RVTH7h+GRoC36P
        6SRXDY5H3+aoL4kyADC76IZDE9h06Hd+1ZZdYcw=
X-Google-Smtp-Source: APXvYqyHQqwt0fFFU50KayafdANVX58ZyOixQ8mFOe6NZ0nt1CDX7R20BmOadWkafwXoQFVKDWu+YMxD5wBWkSmoyOQ=
X-Received: by 2002:a62:1a09:: with SMTP id a9mr31501241pfa.64.1582195381200;
 Thu, 20 Feb 2020 02:43:01 -0800 (PST)
MIME-Version: 1.0
References: <20200220074637.7578-1-njoshi1@lenovo.com>
In-Reply-To: <20200220074637.7578-1-njoshi1@lenovo.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 20 Feb 2020 12:42:53 +0200
Message-ID: <CAHp75VcJmEOu1-b7F2UAsv=Gujb=pPLzjz2ye9t4=Q68+ors-w@mail.gmail.com>
Subject: Re: [PATCH] thinkpad_acpi: Add sysfs entry for lcdshadow feature
To:     Nitin Joshi <nitjoshi@gmail.com>, Mat King <mathewk@google.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rajat Jain <rajatja@google.com>
Cc:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thinkpad-acpi devel ML <ibm-acpi-devel@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        mpearson@lenovo.com, Nitin Joshi <njoshi1@lenovo.com>,
        Benjamin Berg <bberg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 9:48 AM Nitin Joshi <nitjoshi@gmail.com> wrote:
>
>   This feature is supported on some Thinkpad products like T490s, Thinkpad
>   X1 yoga 4th Gen etc . The lcdshadow feature can be enabled and disabled
>   when user press "Fn" + "D" key. Currently, no user feedback is given for
>   this action. Adding as sysfs entry allows userspace to show an On Screen
>   Display whenever the setting changes.
>
>   Summary of changes is mentioned below :
>
>  - Added TP_HKEY_EV_LCDSHADOW_CHANGED for consistency inside the driver
>  - Added unmapped LCDSHADOW to keymap
>  - Added lcdshadow_get function to read value using ACPI
>  - Added lcdshadow_refresh function to re-read value and send notification
>  - Added sysfs group creation to tpaci_lcdshadow_init
>  - Added lcdshadow_exit to remove sysfs group again
>  - Implemented lcdshadow_enable_show/lcdshadow_enable_store
>  - Added handler to tpacpi_driver_event to update refresh lcdshadow
>  - Explicitly call tpacpi_driver_event for extended keyset

Adding custom PrivacyGuard support to this driver was my mistake,
There is a discussion [1] how to do this in generic way to cover other
possible users.
I Cc this to people from that discussion.

[1]: https://lore.kernel.org/dri-devel/CAL_quvRknSSVvXN3q_Se0hrziw2oTNS3ENNoeHYhvciCRq9Yww@mail.gmail.com/


--
With Best Regards,
Andy Shevchenko
