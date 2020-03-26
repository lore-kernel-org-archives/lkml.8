Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592FBC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EEBD2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xR+mTrxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgCZJM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 05:12:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43202 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgCZJM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:12:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id m11so846441wrx.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 02:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZRAvTlrZXSFN4bJ2VygwCf0+VTS3C8V6tKYGFRO59s0=;
        b=xR+mTrxLlKSbJWu299XwWNC76PP3ACrZNe8PyKEylBJc3lWjQwu0Yv+sHl7nQuj3gP
         U/eTAU5NgeoavFls+YTXTP4rx4Sx/woH4150jevSiklG1OWo9RGAgpFDmSACvy+73TRC
         PqjONdJMBxyWwKPEsg1SfsFtgKJl4Ui4E8YKfkJjQYyV418eGnArVNNpQAagcvzg+ich
         UilTxDTjz9pZYMGXHKAqmdGZ8TbwvtI00JFKFw7w7iZde2aBSR4IP8hKwo6eprPNslE0
         BEwp1oHUiaPCN0RXGMTrkdzaHlTbbQA1bmIsjIhTFUQhvJw5DxiIr8Z7RCaiCPz5GJf1
         gL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZRAvTlrZXSFN4bJ2VygwCf0+VTS3C8V6tKYGFRO59s0=;
        b=NK1wP8/KNapfeLm26vLn9ANwEXrg6EoBlcUWv56B3EfpRVCCwixldEoBmaF8MJ2WjW
         P1hFZIyIsiMUCgpKmcVvOFcuGJlr+OgbD6KLd6ZEBWtX7HYvXqtAt4xNE4Ann/6S8vTT
         uDHIglp6TAYzYcA/NpG8k6WzQrDhwhS+AZ1KmA2KtVliX9qX0Sffb3BGwrijTM18MGlB
         ww0pySwH8Zs0IOsEWuKNXrllO5sXUs2TTmoz8UtaLHigwrx655pp2Z1bgxp3GsW7DXrT
         /c4VVpMZxc4kbmwVHtySgonG4V0GzRoZVTWPas9IAnyC0VQzkAYym8Dn0nvnJ/iM2X1E
         zQIw==
X-Gm-Message-State: ANhLgQ3lgY0FOXMsf4o3T5/tnFn0IOeNR/V41JoYKcoDYlS3kaUV/Fcb
        D+4+qLgd1LeGVijed/dFvkVBVldX8ls=
X-Google-Smtp-Source: ADFU+vsvnjK/eg544G1v/bwl4076sBuEOugki0HMuoGTvCBIF3gopHPRZG3olVTvn0KjM7NZtmKAzA==
X-Received: by 2002:a05:6000:4:: with SMTP id h4mr8015747wrx.236.1585213944522;
        Thu, 26 Mar 2020 02:12:24 -0700 (PDT)
Received: from dell ([2.27.35.213])
        by smtp.gmail.com with ESMTPSA id a14sm2688955wmj.6.2020.03.26.02.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 02:12:23 -0700 (PDT)
Date:   Thu, 26 Mar 2020 09:13:13 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Sergey Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: Add Baikal-T1 Boot Controller driver
Message-ID: <20200326091313.GA603801@dell>
References: <20200306130528.9973-1-Sergey.Semin@baikalelectronics.ru>
 <20200306130614.696EF8030704@mail.baikalelectronics.ru>
 <20200325100940.GI442973@dell>
 <20200325165511.tjdaf2l5kkuhbhrr@ubsrv2.baikal.int>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200325165511.tjdaf2l5kkuhbhrr@ubsrv2.baikal.int>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020, Sergey Semin wrote:

> Hello Lee,
> 
> On Wed, Mar 25, 2020 at 10:09:40AM +0000, Lee Jones wrote:
> > On Fri, 06 Mar 2020, Sergey.Semin@baikalelectronics.ru wrote:
> > 
> > > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > 
> > > Baikal-T1 Boot Controller is an IP block embedded into the SoC and
> > > responsible for the chip proper pre-initialization and further
> > > booting up from some memory device. From the Linux kernel point of view
> > > it's just a multi-functional device, which exports three physically mapped
> > > ROMs and a single SPI controller.
> > > 
> > > Primarily the ROMs are intended to be used for transparent access of
> > > the memory devices with system bootup code. First ROM device is an
> > > embedded into the SoC firmware, which is supposed to be used just for
> > > the chip debug and tests. Second ROM device provides a MMIO-based
> > > access to an external SPI flash. Third ROM mirrors either the Internal
> > > or SPI ROM region, depending on the state of the external BOOTCFG_{0,1}
> > > chip pins selecting the system boot device.
> > > 
> > > External SPI flash can be also accessed by the DW APB SSI SPI controller
> > > embedded into the Baikal-T1 Boot Controller. In this case the memory mapped
> > > SPI flash region shouldn't be accessed.
> > > 
> > > Taking into account all the peculiarities described above, we created
> > > an MFD-based driver for the Baikal-T1 controller. Aside from ordinary
> > > OF-based sub-device registration it also provides a simple API to
> > > serialize an access to the external SPI flash from either the MMIO-based
> > > SPI interface or embedded SPI controller.
> > 
> > Not sure why this is being classified as an MFD.
> > 
> > This is clearly 'just' a memory device.
> > 
> 
> Hm, I see this as a normal MFD device. The Boot controller provides a
> set of physically mapped ROMs and a DW APB SSI-based embedded SPI
> controller. Yes, the SPI controller is normally utilized to access an external
> flash device, and at boot stage it is used for it. But still it's a SPI
> controller which driver belongs to the kernel SPI subsystem. Moreover
> nothing prevents a platform designer from using it together with custom
> GPIO-based chip-selects to have additional devices on the SPI bus.
> 
> As I said the problem is that an SPI flash might be accessed either with
> use of a physically mapped ROM or via the normal DW APB SPI controller.
> These two interfaces can't be used simultaneously, because the ROM is
> just an rtl state-machine, which is built to translate MMIO operations
> through the SPI controller registers to an external SPI-nor at CS0 of
> the interface. That's why first I need to make sure the interface is locked,
> then being enabled, then the corresponding driver can use it, then get
> to unlock. That's the point of having the __bt1_bc_spi_lock() and
> bt1_bc_spi_unlock() methods exported from the driver.
> 
> I've got two drivers for MTD ROM and SPI controller based on that
> methods. But I haven't submitted them yet, because they belong to two
> different subsystems and I need to have this one being accepted first.

This is not a totally unique device/situation.  I've seen (and NACKed)
this type of device before.  You need to explain this to the MTD
(SPI-NOR?) maintainers.  They should be in a good position to provide
guidance.

> Recently I've sent an RFC regarding a different question, but it
> concerns the Baikal-T1 system controller and the boot controller as being part
> of it:
> 
> https://lkml.org/lkml/2020/3/22/393

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
