Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA4AC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15F93221EE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599815048;
	bh=L21rvyv2ND6nwhqTc1FQBgm3D+MpPJUrd6X48OuHPtI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IVkxt4NZA1FsmiWvK+fnf3pJoWhCssafgdaaVVcwBVk14pwbg5ulFV1g111WvisRh
	 uPXZ1XL53kAzwtG0ZM1hKzFypTYkiYs7YM75BYbBEz9wBGaL4mwp7VpizXrqOq508n
	 MSY4LolaOG6saaXm2ZE4tOkc0ELWyoAIe0T15pd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgIKJEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 05:04:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgIKJEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 05:04:06 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4E1D22204
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 09:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599815045;
        bh=L21rvyv2ND6nwhqTc1FQBgm3D+MpPJUrd6X48OuHPtI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KltXo2ISgCT26+CbmmWjkOFG0pEqKwXtsQbYV6p4j8MudO8GeYmkE9SJ9trxJMzs4
         zdu3u8ryDp1h8AxoSlqaNgnX92qYw99YeT48/PwicXJWbZotih7R+HyNVxq80oJF90
         igfYEqfh87FFcdjtuQ7gkHaBi8UfhqpKPR103dMs=
Received: by mail-ed1-f43.google.com with SMTP id w1so9221579edr.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 02:04:04 -0700 (PDT)
X-Gm-Message-State: AOAM531sopeF/NmUeG4HXT9CLq9D5zse1Eo61el25SHGll0U4atoGiw2
        hvyoVkoa4C6zZFXfXTzTuws7W32zJ8DzeWB3QIs=
X-Google-Smtp-Source: ABdhPJxr/SlzbK2WyJvZtTXPsPONjb+rVSHvOuvOw9boH8cjPSRqtQepF5LBsQQ0UusvBs5yCBI0Kn8bYrz9xou2OxY=
X-Received: by 2002:aa7:da16:: with SMTP id r22mr989409eds.132.1599815043378;
 Fri, 11 Sep 2020 02:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <1599553645-26928-1-git-send-email-yilun.xu@intel.com>
 <1599553645-26928-2-git-send-email-yilun.xu@intel.com> <20200908100102.GB24693@pi3>
 <20200911084234.GB7802@yilunxu-OptiPlex-7050>
In-Reply-To: <20200911084234.GB7802@yilunxu-OptiPlex-7050>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 11 Sep 2020 11:03:50 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfjd99PLH1FBc2NSmc1Z=5PGrxezqPucdvvbDtyjm8jOA@mail.gmail.com>
Message-ID: <CAJKOXPfjd99PLH1FBc2NSmc1Z=5PGrxezqPucdvvbDtyjm8jOA@mail.gmail.com>
Subject: Re: [PATCH] memory: dfl-emif: add the DFL EMIF private feature driver
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        trix@redhat.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, lgoncalv@redhat.com, hao.wu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Sep 2020 at 10:46, Xu Yilun <yilun.xu@intel.com> wrote:
>
> Sorry I missed one comments, see inline.
>
> On Tue, Sep 08, 2020 at 12:01:02PM +0200, Krzysztof Kozlowski wrote:
> > On Tue, Sep 08, 2020 at 04:27:25PM +0800, Xu Yilun wrote:
> > > This driver is for the EMIF private feature implemented under FPGA
> > > Device Feature List (DFL) framework. It is used to expose memory
> > > interface status information as well as memory clearing control.
> > >
> > > The purpose of memory clearing block is to zero out all private memory
> > > when FPGA is to be reprogrammed. This gives users a reliable method to
> > > prevent potential data leakage.
> > >
> > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > ---
> > >  .../ABI/testing/sysfs-bus-dfl-devices-emif         |  25 +++
> > >  drivers/memory/Kconfig                             |   9 +
> > >  drivers/memory/Makefile                            |   2 +
> > >  drivers/memory/dfl-emif.c                          | 211 +++++++++++++++++++++
> > >  4 files changed, 247 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
> > >  create mode 100644 drivers/memory/dfl-emif.c
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-dfl-devices-emif b/Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
> > > new file mode 100644
> > > index 0000000..33d557e
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
> > > @@ -0,0 +1,25 @@
> > > +What:              /sys/bus/dfl/devices/dfl_dev.X/infX_cal_fail
> > > +Date:              Sep 2020
> > > +KernelVersion:     5.10
> > > +Contact:   Xu Yilun <yilun.xu@intel.com>
> > > +Description:       Read-only. It indicates if the calibration is failed on this
> > > +           memory interface. "1" for calibration failure, "0" for OK.
> >
> > "if the calibration failed"
> >
> > > +           Format: %u
> > > +
> > > +What:              /sys/bus/dfl/devices/dfl_dev.X/infX_init_done
> > > +Date:              Sep 2020
> > > +KernelVersion:     5.10
> > > +Contact:   Xu Yilun <yilun.xu@intel.com>
> > > +Description:       Read-only. It indicates if the initialization is complete on
> > > +           this memory interface. "1" for initialization complete, "0"
> > > +           for not yet.
> > > +           Format: %u
> >
> > "if the initialization completed"
> >
> > > +
> > > +What:              /sys/bus/dfl/devices/dfl_dev.X/infX_clear
> > > +Date:              Sep 2020
> > > +KernelVersion:     5.10
> > > +Contact:   Xu Yilun <yilun.xu@intel.com>
> > > +Description:       Write-only. Writing "1" to this file will zero out all memory
> > > +           data in this memory interface. Writing other values are
> > > +           invalid.
> >
> > "Writing of other values is invalid."
> >
> > > +           Format: %u
> > > diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> > > index 8072204..fb0858f 100644
> > > --- a/drivers/memory/Kconfig
> > > +++ b/drivers/memory/Kconfig
> > > @@ -215,6 +215,15 @@ config STM32_FMC2_EBI
> > >       devices (like SRAM, ethernet adapters, FPGAs, LCD displays, ...) on
> > >       SOCs containing the FMC2 External Bus Interface.
> > >
> > > +config FPGA_DFL_EMIF
> > > +   tristate "DFL EMIF private feature support"
> > > +   depends on FPGA_DFL && HAS_IOMEM
> >
> > Cannot be compile tested without FPGA_DFL?
>
> We need this FPGA_DFL dependency. The driver will use the
> __dfl_driver_register(), which is defined in drivers/fpga/dfl.c, and
> FPGA_DFL enables the compiling of dfl.c

Yeah but the DFL headers provide empty stubs for such case, don't
they? If they don't, probably they should.

Best regards,
Krzysztof
