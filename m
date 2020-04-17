Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA762C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A54BE21D95
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8DoksE/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbgDQK72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729512AbgDQK70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:59:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798C6C061A0C;
        Fri, 17 Apr 2020 03:59:26 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 7so2079269pjo.0;
        Fri, 17 Apr 2020 03:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7XwplSffS8PQjHrGDZuZ8RPTxZAfesrxyrxD5hoE77Q=;
        b=K8DoksE/so776nUG17O0SKT0dfCG4TA9Le9+JyI+Z2Sz1IUtSe2MtS1GwDxA9B/fqo
         ZIR4Kjl2Ve6cNE+utKaRuUYn+/0bDCLNor3V3WtuEYPb6LvC9hIJ+mHkvZ4OzydJdOuA
         m7z6vbDuVlbxm4u5whxL6PJFvYN50Wf+MlI5Y5NNrIThiQqWgCIo3mAJwO38sxPfIgW3
         MSb7+/YJ51Uk3xy0s2DoydkbsVGqSgf0JdThaR0nvjo2nsEweh0FTcMOJFgnJzE1+Pk3
         FvbgDbFsZs+eVLorBpQXrueHCpoMy18Lp03YHqxWFbObLV4C4rUhtLIk4bLcRnR/oh1g
         znAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7XwplSffS8PQjHrGDZuZ8RPTxZAfesrxyrxD5hoE77Q=;
        b=HPOYLNztwv8ykUCi5sdoCsSVXXU921u0ec7StCP4rMa2Gv+5jHtXM2S+kuxri/pYMc
         8qIuG/qECyE+vN9TzamD7x13z02qRpItcy2WPyZ7QpWp1v5Vz0bxZwQODPrV2FoD5Gur
         e/m64PtCRMQlBiYs4wUiU2X2gXZoPbeB0ivlXi2xIwOZYwe7bBpASuoHqTjwhV60yJkT
         5gVcndkNUgSjsthUGYSFnc0gT0kMizWd3mWu0c3NYT8kA7TsEJR1N509plzjAwdmlP4t
         8N/7/PWgC2zoTC1YoYpE+3fxheDBnBrMS5RjBiA0biJSnNQ7t2sWtna4n//XNT79CYaB
         PWAg==
X-Gm-Message-State: AGi0PuYu2VXIGPzZwdiKgYQFOKW9P8dMOVN0V5ICcmPkVWzNwNLHOXRa
        1iSZNqHP4LJqRwz12YSGlCvL6zgh/J6cP4bxkKY=
X-Google-Smtp-Source: APiQypKUd8l72UInPugfso5fGTvfhyRNBB4Edrc9kV2qsSe64pPwkag0Eu5pFev+NayDoWxrLET57MpLYVRqgkAZOnw=
X-Received: by 2002:a17:90a:364c:: with SMTP id s70mr3633491pjb.143.1587121165994;
 Fri, 17 Apr 2020 03:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200416081552.68083-1-mika.westerberg@linux.intel.com>
 <20200416081552.68083-20-mika.westerberg@linux.intel.com> <20200417105704.GE3737@dell>
In-Reply-To: <20200417105704.GE3737@dell>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Apr 2020 13:59:14 +0300
Message-ID: <CAHp75VcMH47yvqaTNN851+G4ghT-og0M15DaN0b_+J_0yCW84g@mail.gmail.com>
Subject: Re: [PATCH v9 19/20] platform/x86: intel_pmc_ipc: Convert to MFD
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 1:56 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Thu, 16 Apr 2020, Mika Westerberg wrote:
>
> > This driver only creates a bunch of platform devices sharing resources
> > belonging to the PMC device. This is pretty much what MFD subsystem is
> > for so move the driver there, renaming it to intel_pmc_bxt.c which
> > should be more clear what it is.
> >
> > MFD subsystem provides nice helper APIs for subdevice creation so
> > convert the driver to use those. Unfortunately the ACPI device includes
> > separate resources for most of the subdevices so we cannot simply call
> > mfd_add_devices() to create all of them but instead we need to call it
> > separately for each device.
> >
> > The new MFD driver continues to expose two sysfs attributes that allow
> > userspace to send IPC commands to the PMC/SCU to avoid breaking any
> > existing applications that may use these. Generally this is bad idea so
> > document this in the ABI documentation.
> >
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  .../ABI/obsolete/sysfs-driver-intel_pmc_bxt   |  22 +
> >  arch/x86/include/asm/intel_pmc_ipc.h          |  47 --
> >  arch/x86/include/asm/intel_telemetry.h        |   1 +
> >  drivers/mfd/Kconfig                           |  16 +-
> >  drivers/mfd/Makefile                          |   1 +
> >  drivers/mfd/intel_pmc_bxt.c                   | 468 +++++++++++++
> >  drivers/platform/x86/Kconfig                  |  16 +-
> >  drivers/platform/x86/Makefile                 |   1 -
> >  drivers/platform/x86/intel_pmc_ipc.c          | 645 ------------------
> >  .../platform/x86/intel_telemetry_debugfs.c    |  12 +-
> >  drivers/platform/x86/intel_telemetry_pltdrv.c |   2 +
> >  drivers/usb/typec/tcpm/Kconfig                |   2 +-
> >  drivers/watchdog/iTCO_wdt.c                   |  25 +-
> >  include/linux/mfd/intel_pmc_bxt.h             |  53 ++
> >  include/linux/platform_data/itco_wdt.h        |  11 +-
> >  15 files changed, 602 insertions(+), 720 deletions(-)
> >  create mode 100644 Documentation/ABI/obsolete/sysfs-driver-intel_pmc_bxt
> >  delete mode 100644 arch/x86/include/asm/intel_pmc_ipc.h
> >  create mode 100644 drivers/mfd/intel_pmc_bxt.c
> >  delete mode 100644 drivers/platform/x86/intel_pmc_ipc.c
> >  create mode 100644 include/linux/mfd/intel_pmc_bxt.h
>
> Looks good to me know.
>
> Thanks for taking the time to realise my review comments.
>
> For my own reference (apply this as-is to your sign-off block):
>
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Can you prepare ib for ii that I can pull from?
Or do you want me to do the same for you?

-- 
With Best Regards,
Andy Shevchenko
