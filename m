Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916F0C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658CD20786
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lAod/7Rk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbgCXL0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 07:26:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43821 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbgCXL0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 07:26:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id b2so20903247wrj.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 04:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4Nuv+vT/40G+s+U11HxTd2nHnucA/xEkwNf5+XdxgYM=;
        b=lAod/7RkxmphP5+Mnr15+MWx9JcjoONDzyS1XlqkRmyEa3iRQXXS/SVpfriHwkbZJv
         4JwB0xAcSzb9UePrMkD5AIPD1j/oLXSonQMYe138++QjVV5EA1nMghy/GgnKPI8AhiPo
         Rk1s1dWFSZdk40cO2ZIyfhzI0AO0yrNrk92rHPPSROZGRilkCp4HYZYmtv+odxQRWrJx
         R2fy61uSHB2860GLur6btg+tUOwXlVvO4FuUHfhWknu2GZ47WJmz04HXUrx8vafSvSAN
         WRHsQ3Glx7rR2JjxsCrQKrTEHg87Y5dpV3NrZ+p5VmjmO8CDf+JhW3GNABWEfj6uSc6G
         ZApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4Nuv+vT/40G+s+U11HxTd2nHnucA/xEkwNf5+XdxgYM=;
        b=jWSJlloGC5zluM5edqz5H/up7Zsiahpv9JsF8+COpsuUCO5607UXxEgoBz2mwanM8I
         iud2EtF50p10nToIx6lQr5Lm2Q91j90rDkk2QJCttGI86luv1aulhBvW5mp5tnV11YPU
         mRKMpOi3Hfnxetpjhcybc1c98qtsdeWoM4tBo1mADjhLBXM7WKKbpGOLKfvyMUrlQSFA
         YzIe/Kyr7KolEUjKExfOeebKLHHS3dYO2jsYl6KDCa3wnFXYJdTSqsEjAKfFukiWb88J
         sU7ex5TYz8hdUB9irDsxAYZaOR7wxDrQzR1JDiC8Ska5n5ykwey6JdO4M0K3QuvD06hV
         xLOQ==
X-Gm-Message-State: ANhLgQ1AZMOEhMt32XuBZHhSl33bPzYFxy6QxPj/m3UGa8347DLPbHcs
        jqe3GC0LKluDuZy6O9n3LrQnys4KlOQ=
X-Google-Smtp-Source: ADFU+vvOBFORbrm3QHz7h3Wbpeq+l/iNoNETQRykilff0C5d3YAY49VBDsuJHBu/pgJqFe6BxQ5qIw==
X-Received: by 2002:a5d:6187:: with SMTP id j7mr12491220wru.419.1585049191921;
        Tue, 24 Mar 2020 04:26:31 -0700 (PDT)
Received: from dell ([2.27.35.213])
        by smtp.gmail.com with ESMTPSA id s2sm10011241wru.68.2020.03.24.04.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 04:26:31 -0700 (PDT)
Date:   Tue, 24 Mar 2020 11:27:20 +0000
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
Subject: Re: [PATCH v8 18/19] platform/x86: intel_pmc_ipc: Convert to MFD
Message-ID: <20200324112720.GA437932@dell>
References: <20200303133649.39819-1-mika.westerberg@linux.intel.com>
 <20200303133649.39819-19-mika.westerberg@linux.intel.com>
 <CAHp75Ve3s1vy6tSgyYCTtxD6z-8+-gUwxOE9A6sX=eW4xViHiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Ve3s1vy6tSgyYCTtxD6z-8+-gUwxOE9A6sX=eW4xViHiA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020, Andy Shevchenko wrote:

> On Tue, Mar 3, 2020 at 3:43 PM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
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
> 
> Lee, are you fine with this?
> I can push it all via my tree and prepare IB for you.

Funny you should ask - it's next on my list.

> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  .../ABI/obsolete/sysfs-driver-intel_pmc_bxt   |  22 +
> >  arch/x86/include/asm/intel_pmc_ipc.h          |  47 --
> >  arch/x86/include/asm/intel_telemetry.h        |   1 +
> >  drivers/mfd/Kconfig                           |  16 +-
> >  drivers/mfd/Makefile                          |   1 +
> >  drivers/mfd/intel_pmc_bxt.c                   | 504 ++++++++++++++
> >  drivers/platform/x86/Kconfig                  |  16 +-
> >  drivers/platform/x86/Makefile                 |   1 -
> >  drivers/platform/x86/intel_pmc_ipc.c          | 645 ------------------
> >  .../platform/x86/intel_telemetry_debugfs.c    |  12 +-
> >  drivers/platform/x86/intel_telemetry_pltdrv.c |   2 +
> >  drivers/usb/typec/tcpm/Kconfig                |   2 +-
> >  include/linux/mfd/intel_pmc_bxt.h             |  43 ++
> >  13 files changed, 602 insertions(+), 710 deletions(-)
> >  create mode 100644 Documentation/ABI/obsolete/sysfs-driver-intel_pmc_bxt
> >  delete mode 100644 arch/x86/include/asm/intel_pmc_ipc.h
> >  create mode 100644 drivers/mfd/intel_pmc_bxt.c
> >  delete mode 100644 drivers/platform/x86/intel_pmc_ipc.c
> >  create mode 100644 include/linux/mfd/intel_pmc_bxt.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
