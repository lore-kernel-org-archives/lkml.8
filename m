Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2994CC33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED585207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IUOxECxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgATIMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:12:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42125 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgATIMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:12:33 -0500
Received: by mail-wr1-f68.google.com with SMTP id q6so28355129wro.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 00:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=iA3EwgrIbCP+VdgBtFW9CZv31WmNUdZplPog0qNx7xc=;
        b=IUOxECxIXb2To4NkBUArsH/prMwH8vr7g2COTWLshO68+0FbZ2C9c6RlS5BH566kAq
         Em16ZUQGhSPNyQqKmwZvbf/usI85Q58gKT6k622D9IJO3hjelsKN0Ax7/0u02keFL20Q
         vZLob1SYC5n1N3lS4XPJYDzah98lBW7AP5T7vTaK/22U/JykbrdDRwpRdDHlcP7ODOfT
         kHGuM69MSVqPOQ+hywS4Ff8wlAlOu8QgiHMy4TBNijEq5puYhFa1o4gjJIIj03kdyr7q
         osdFveKQHawx/RXYDy4Qrp8M5/09vDiaEyJPSZVvVXJyjI10XkQVss9tt2ansUX7URqP
         pK8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iA3EwgrIbCP+VdgBtFW9CZv31WmNUdZplPog0qNx7xc=;
        b=SiE01fmcomdac0D43svPL8Fz0GWKg/HuP0DQ5ABvMsm81R9NatT6CPXX35KXrPN0Wg
         EuFuGiJ/tM/Cu1zRxedjUlK6TE1gl2ffkgBXLCZGcZekmynL5fIRMCD5IYXcpncPGeDd
         LMi7MXib7P8JMtN2eVFK2KDxQuZdbGD7RTcz6w2rxKRA9m584SjLGUqXkDKQhBJtKyGO
         szHN9rOxk9i7MD9KZ5dfsR9GnToU8pp25OIlhE0oX3wQMeHi0k269PWXoMdh1f76CGMq
         P3rp0weExgzycP9PzbpPH9h9yAyUzjpJzPqulACuAIZkTcp20vg/olWyqT5BiKICMe45
         OmBw==
X-Gm-Message-State: APjAAAVx+oq0vzAEkgCIlRs5rCoYIaaG8BXpDuLuVL8HYmTZxOHmV4+/
        BcAuLIFcM3xf19Du3BcyQM/TlQ==
X-Google-Smtp-Source: APXvYqy7AhB5hANh5i3GxwRkqjd99DuRQCWIlVWcGjRRxnMutH/h96ZafZ6lV3QC/+e1GNqGlqqM0A==
X-Received: by 2002:a5d:4d4a:: with SMTP id a10mr17518365wru.220.1579507951432;
        Mon, 20 Jan 2020 00:12:31 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id o15sm47150199wra.83.2020.01.20.00.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 00:12:30 -0800 (PST)
Date:   Mon, 20 Jan 2020 08:12:46 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 35/36] platform/x86: intel_pmc_ipc: Convert to MFD
Message-ID: <20200120081246.GS15507@dell>
References: <20200113135623.56286-1-mika.westerberg@linux.intel.com>
 <20200113135623.56286-36-mika.westerberg@linux.intel.com>
 <20200116132108.GH325@dell>
 <20200116143730.GE2838@lahna.fi.intel.com>
 <20200117113202.GH15507@dell>
 <20200117142750.GP2838@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200117142750.GP2838@lahna.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020, Mika Westerberg wrote:

> On Fri, Jan 17, 2020 at 11:32:02AM +0000, Lee Jones wrote:
> > On Thu, 16 Jan 2020, Mika Westerberg wrote:
> > > On Thu, Jan 16, 2020 at 01:21:08PM +0000, Lee Jones wrote:
> > > > On Mon, 13 Jan 2020, Mika Westerberg wrote:
> > > > 
> > > > > This driver only creates a bunch of platform devices sharing resources
> > > > > belonging to the PMC device. This is pretty much what MFD subsystem is
> > > > > for so move the driver there, renaming it to intel_pmc_bxt.c which
> > > > > should be more clear what it is.
> > > > > 
> > > > > MFD subsystem provides nice helper APIs for subdevice creation so
> > > > > convert the driver to use those. Unfortunately the ACPI device includes
> > > > > separate resources for most of the subdevices so we cannot simply call
> > > > > mfd_add_devices() to create all of them but instead we need to call it
> > > > > separately for each device.
> > > > > 
> > > > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > > ---
> > > > >  drivers/mfd/Kconfig                           |  16 +-
> > > > >  drivers/mfd/Makefile                          |   1 +
> > > > >  drivers/mfd/intel_pmc_bxt.c                   | 543 +++++++++++++++
> > > > >  drivers/platform/x86/Kconfig                  |  16 +-
> > > > >  drivers/platform/x86/Makefile                 |   1 -
> > > > >  drivers/platform/x86/intel_pmc_ipc.c          | 650 ------------------
> > > > >  .../platform/x86/intel_telemetry_debugfs.c    |   2 +-
> > > > >  drivers/usb/typec/tcpm/Kconfig                |   2 +-
> > > > >  .../linux/mfd/intel_pmc_bxt.h                 |  11 +-
> > > > >  9 files changed, 573 insertions(+), 669 deletions(-)
> > > > >  create mode 100644 drivers/mfd/intel_pmc_bxt.c
> > > > >  delete mode 100644 drivers/platform/x86/intel_pmc_ipc.c
> > > > >  rename arch/x86/include/asm/intel_pmc_ipc.h => include/linux/mfd/intel_pmc_bxt.h (83%)

[...]

> > > > > +	scu = intel_scu_ipc_probe(&pdev->dev, &pdata);
> > > > 
> > > > This is a parent or child device?
> > > 
> > > The SCU IPC is a library so here it is just the device that has the SCU
> > > IPC registers the library can use.
> > 
> > "probing" a library doesn't sound right.
> > 
> > Looking at the code, I think this should be a device.
> 
> Well, by "library" I mean that the SCU IPC itself does not bind to
> anything but instead it gets called by different drivers such as this
> one passing the device pointer that is the SCU IPC device. Here for
> example it is the platfrom device created from an ACPI description.

Not keen on that at all.  Why can it not be a platform device?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
