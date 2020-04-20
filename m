Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7B8C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11932206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HAWvLcNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgDTH3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 03:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgDTH3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 03:29:15 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8095BC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 00:29:15 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t14so10741122wrw.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 00:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LyN9pox3SaOxRcsjO37PKtf7W/L5quIGDct2ytf3h/U=;
        b=HAWvLcNWGYCsM0m6jkRYYORYooXPFRb47MJqCKoUxMtw5IFEfr7NWX9l16zqOb+gnn
         VQAiyAUudMnxH9y7WJnIk0LmPTmVX/wo6FHiE7DcVCWpvvCumcLdi1GlrfypzmOlz4dV
         vjdsdKkpYFYG/tPSQgEKSG90fdm3dnwiIBVMOD4nuYV7eGees/fIGP6xgwq6ctj/lfcj
         YNChXw9+7MAuPicmn9L2mL0WHzoCvk76PN+8wJJaGG9jikZD9iVknrbnWOawSXkqXaFz
         KOK/yVjsnnWDUONjd82PV4cvPOiQgbl8IWKKaNo6Ja1+EGgiyZ3BW/p+cw69GjRt+DYo
         eMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LyN9pox3SaOxRcsjO37PKtf7W/L5quIGDct2ytf3h/U=;
        b=J/oc50/UsHTU+yFY0/Kb+rio+PbkCtUm8rpYCAc8Qc4Uww1G5NbGCs7/N6QK6nh18/
         BeM+zGedvkVjxG5VBkXRTmA9optEFCszUqMZxO+o2ZSSXAVTa6rRJjt2FXMA1xIxZRqz
         rTPWNUiKfsfT3LUDNlbfJH88zUnt7IHxsHjEQdnm/bQh4LjnrntMUMBG182pOxeKNBsW
         ro+E4tw+Zo4vXHC1hW/cRr8yD2BuyZvnv1rRHbXARSjlSgPsebWKfqtV6pwj6Zz5/Bli
         ayDqqy0cwV+o4DS+pxuAGsFNzbwwod1b0v7Tn50TgzxSv2Pe94CQmC5MoLqPNiyUb2z8
         ARmw==
X-Gm-Message-State: AGi0PubpBGDuiWN5f16RUVyzHZyASpdcUBmDU/Qk74wPgdCyyBO0TyuY
        UdCdHI3w6H7a4cwvhlpJ971ugA==
X-Google-Smtp-Source: APiQypIbsK22d8VR6jZfY40lBxD1KunZSdXNEJDjh7XcSPlaDQuufe8n4hQjfR1cVVbIvMvD/5YJBQ==
X-Received: by 2002:a5d:688f:: with SMTP id h15mr17432861wru.352.1587367754242;
        Mon, 20 Apr 2020 00:29:14 -0700 (PDT)
Received: from dell ([95.149.164.107])
        by smtp.gmail.com with ESMTPSA id x13sm214084wmc.5.2020.04.20.00.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 00:29:13 -0700 (PDT)
Date:   Mon, 20 Apr 2020 08:29:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
Subject: Re: [PATCH v9 19/20] platform/x86: intel_pmc_ipc: Convert to MFD
Message-ID: <20200420072911.GJ3737@dell>
References: <20200416081552.68083-1-mika.westerberg@linux.intel.com>
 <20200416081552.68083-20-mika.westerberg@linux.intel.com>
 <20200417105704.GE3737@dell>
 <CAHp75VcMH47yvqaTNN851+G4ghT-og0M15DaN0b_+J_0yCW84g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VcMH47yvqaTNN851+G4ghT-og0M15DaN0b_+J_0yCW84g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020, Andy Shevchenko wrote:

> On Fri, Apr 17, 2020 at 1:56 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Thu, 16 Apr 2020, Mika Westerberg wrote:
> >
> > > This driver only creates a bunch of platform devices sharing resources
> > > belonging to the PMC device. This is pretty much what MFD subsystem is
> > > for so move the driver there, renaming it to intel_pmc_bxt.c which
> > > should be more clear what it is.
> > >
> > > MFD subsystem provides nice helper APIs for subdevice creation so
> > > convert the driver to use those. Unfortunately the ACPI device includes
> > > separate resources for most of the subdevices so we cannot simply call
> > > mfd_add_devices() to create all of them but instead we need to call it
> > > separately for each device.
> > >
> > > The new MFD driver continues to expose two sysfs attributes that allow
> > > userspace to send IPC commands to the PMC/SCU to avoid breaking any
> > > existing applications that may use these. Generally this is bad idea so
> > > document this in the ABI documentation.
> > >
> > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  .../ABI/obsolete/sysfs-driver-intel_pmc_bxt   |  22 +
> > >  arch/x86/include/asm/intel_pmc_ipc.h          |  47 --
> > >  arch/x86/include/asm/intel_telemetry.h        |   1 +
> > >  drivers/mfd/Kconfig                           |  16 +-
> > >  drivers/mfd/Makefile                          |   1 +
> > >  drivers/mfd/intel_pmc_bxt.c                   | 468 +++++++++++++
> > >  drivers/platform/x86/Kconfig                  |  16 +-
> > >  drivers/platform/x86/Makefile                 |   1 -
> > >  drivers/platform/x86/intel_pmc_ipc.c          | 645 ------------------
> > >  .../platform/x86/intel_telemetry_debugfs.c    |  12 +-
> > >  drivers/platform/x86/intel_telemetry_pltdrv.c |   2 +
> > >  drivers/usb/typec/tcpm/Kconfig                |   2 +-
> > >  drivers/watchdog/iTCO_wdt.c                   |  25 +-
> > >  include/linux/mfd/intel_pmc_bxt.h             |  53 ++
> > >  include/linux/platform_data/itco_wdt.h        |  11 +-
> > >  15 files changed, 602 insertions(+), 720 deletions(-)
> > >  create mode 100644 Documentation/ABI/obsolete/sysfs-driver-intel_pmc_bxt
> > >  delete mode 100644 arch/x86/include/asm/intel_pmc_ipc.h
> > >  create mode 100644 drivers/mfd/intel_pmc_bxt.c
> > >  delete mode 100644 drivers/platform/x86/intel_pmc_ipc.c
> > >  create mode 100644 include/linux/mfd/intel_pmc_bxt.h
> >
> > Looks good to me know.
> >
> > Thanks for taking the time to realise my review comments.
> >
> > For my own reference (apply this as-is to your sign-off block):
> >
> >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> Can you prepare ib for ii that I can pull from?
> Or do you want me to do the same for you?

It would probably be easier for me to do it, as I already have the
infra. to deal with it.  I have some more reviews to conduct, then
I'll get around to it.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
