Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87807C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 500B0221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599841866;
	bh=jAzQ1ZvicvLKfXMKWysDxGUXCfTXkX9dtV5xPOVfOhU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MsfuriS5kyQMGat8KVgjfYhUYiGrzYUkX+ftGPlcnakWrKBPviGEV9dniRNmyd9qN
	 WswpCkjxRwvIUDpBussAY1YQpU3DPgGFMu6O81LCPfvhdZqs7pDfXegwhscjk04Hp6
	 j/0xBvNnCu3iNvkxKX3AJtPxNrmUgA4scsZugcp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgIKQa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:30:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726442AbgIKPTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:19:23 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34DF2221EB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 15:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599837403;
        bh=jAzQ1ZvicvLKfXMKWysDxGUXCfTXkX9dtV5xPOVfOhU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CQtk/oQM1rzTZL8kLuUYk/XCNu0mS8PAfuHWWxCKRceO53Kli45u6DHzXb31RhSQH
         kuCSKVA2LHksRCzGeEILIxMa2Z4pj9WXJvwwXpg2/G7yZZJatr85CkNeAXuVTiIQ4S
         uRydD9zXvMeI1qcw1jExLfrOZUmMQsjFpNlEsOj0=
Received: by mail-ed1-f44.google.com with SMTP id l63so10326284edl.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 08:16:43 -0700 (PDT)
X-Gm-Message-State: AOAM533iR5grlgjFG6Ne8DX6GUszMgRSCM+g/rd4GJwcD9/2ldYOfPp2
        Ezj3B4oUSRmzUG7lMQOwomRhUQcVsLmOxjDL+7s=
X-Google-Smtp-Source: ABdhPJyX43jMLWrEQ8jpmSIRLi9MtRq5ZEmAZXXoN1vP85D9RLdKAg5Q9Q5VCjSkTJ+FjDanWCgt/efU99te4OAth18=
X-Received: by 2002:a05:6402:ca7:: with SMTP id cn7mr2497177edb.143.1599837401638;
 Fri, 11 Sep 2020 08:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <1599553645-26928-1-git-send-email-yilun.xu@intel.com>
 <1599553645-26928-2-git-send-email-yilun.xu@intel.com> <20200908100102.GB24693@pi3>
 <20200911084234.GB7802@yilunxu-OptiPlex-7050> <CAJKOXPfjd99PLH1FBc2NSmc1Z=5PGrxezqPucdvvbDtyjm8jOA@mail.gmail.com>
 <20200911144356.GA11294@yilunxu-OptiPlex-7050>
In-Reply-To: <20200911144356.GA11294@yilunxu-OptiPlex-7050>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 11 Sep 2020 17:16:29 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfqFvpNti46Uh1SJYCaezgyNeOb8dF8dAp4uFL0r0j7fA@mail.gmail.com>
Message-ID: <CAJKOXPfqFvpNti46Uh1SJYCaezgyNeOb8dF8dAp4uFL0r0j7fA@mail.gmail.com>
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

On Fri, 11 Sep 2020 at 16:48, Xu Yilun <yilun.xu@intel.com> wrote:
>
> On Fri, Sep 11, 2020 at 11:03:50AM +0200, Krzysztof Kozlowski wrote:
> > On Fri, 11 Sep 2020 at 10:46, Xu Yilun <yilun.xu@intel.com> wrote:
> > >
> > > Sorry I missed one comments, see inline.
> > >
> > > On Tue, Sep 08, 2020 at 12:01:02PM +0200, Krzysztof Kozlowski wrote:
> > > > On Tue, Sep 08, 2020 at 04:27:25PM +0800, Xu Yilun wrote:
> > > > > This driver is for the EMIF private feature implemented under FPGA
> > > > > Device Feature List (DFL) framework. It is used to expose memory
> > > > > interface status information as well as memory clearing control.
> > > > >
> > > > > The purpose of memory clearing block is to zero out all private memory
> > > > > when FPGA is to be reprogrammed. This gives users a reliable method to
> > > > > prevent potential data leakage.
> > > > >
> > > > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > > > ---
> > > > >  .../ABI/testing/sysfs-bus-dfl-devices-emif         |  25 +++
> > > > >  drivers/memory/Kconfig                             |   9 +
> > > > >  drivers/memory/Makefile                            |   2 +
> > > > >  drivers/memory/dfl-emif.c                          | 211 +++++++++++++++++++++
> > > > >  4 files changed, 247 insertions(+)
> > > > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
> > > > >  create mode 100644 drivers/memory/dfl-emif.c
> > > > >
> > > > > diff --git a/Documentation/ABI/testing/sysfs-bus-dfl-devices-emif b/Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
> > > > > new file mode 100644
> > > > > index 0000000..33d557e
> > > > > --- /dev/null
> > > > > +++ b/Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
> > > > > @@ -0,0 +1,25 @@
> > > > > +What:              /sys/bus/dfl/devices/dfl_dev.X/infX_cal_fail
> > > > > +Date:              Sep 2020
> > > > > +KernelVersion:     5.10
> > > > > +Contact:   Xu Yilun <yilun.xu@intel.com>
> > > > > +Description:       Read-only. It indicates if the calibration is failed on this
> > > > > +           memory interface. "1" for calibration failure, "0" for OK.
> > > >
> > > > "if the calibration failed"
> > > >
> > > > > +           Format: %u
> > > > > +
> > > > > +What:              /sys/bus/dfl/devices/dfl_dev.X/infX_init_done
> > > > > +Date:              Sep 2020
> > > > > +KernelVersion:     5.10
> > > > > +Contact:   Xu Yilun <yilun.xu@intel.com>
> > > > > +Description:       Read-only. It indicates if the initialization is complete on
> > > > > +           this memory interface. "1" for initialization complete, "0"
> > > > > +           for not yet.
> > > > > +           Format: %u
> > > >
> > > > "if the initialization completed"
> > > >
> > > > > +
> > > > > +What:              /sys/bus/dfl/devices/dfl_dev.X/infX_clear
> > > > > +Date:              Sep 2020
> > > > > +KernelVersion:     5.10
> > > > > +Contact:   Xu Yilun <yilun.xu@intel.com>
> > > > > +Description:       Write-only. Writing "1" to this file will zero out all memory
> > > > > +           data in this memory interface. Writing other values are
> > > > > +           invalid.
> > > >
> > > > "Writing of other values is invalid."
> > > >
> > > > > +           Format: %u
> > > > > diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> > > > > index 8072204..fb0858f 100644
> > > > > --- a/drivers/memory/Kconfig
> > > > > +++ b/drivers/memory/Kconfig
> > > > > @@ -215,6 +215,15 @@ config STM32_FMC2_EBI
> > > > >       devices (like SRAM, ethernet adapters, FPGAs, LCD displays, ...) on
> > > > >       SOCs containing the FMC2 External Bus Interface.
> > > > >
> > > > > +config FPGA_DFL_EMIF
> > > > > +   tristate "DFL EMIF private feature support"
> > > > > +   depends on FPGA_DFL && HAS_IOMEM
> > > >
> > > > Cannot be compile tested without FPGA_DFL?
> > >
> > > We need this FPGA_DFL dependency. The driver will use the
> > > __dfl_driver_register(), which is defined in drivers/fpga/dfl.c, and
> > > FPGA_DFL enables the compiling of dfl.c
> >
> > Yeah but the DFL headers provide empty stubs for such case, don't
> > they? If they don't, probably they should.
>
> The DFL headers don't provide the empty stubs, why they should? A DFL
> driver should not be selected when the DFL framework & DFL bus is not
> enabled in system.

Good point, this is not a consumer API. Then the config entry looks fine.

Best regards,
Krzysztof
