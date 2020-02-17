Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382F2C35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 05:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04FB52064C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 05:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dVa6qj/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgBQF1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 00:27:53 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38709 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgBQF1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 00:27:53 -0500
Received: by mail-pl1-f196.google.com with SMTP id t6so6233358plj.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 21:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PwcK+871dTd7BfFF6Qcv1VSAZKd0zAASIM8Hdwlta4Y=;
        b=dVa6qj/hyycQFK/oAEUfZt3dusdIVnfNZwDaKj6s/3/cneV1vELnPYyNOQuumIXvCz
         +rv60DGhcfVk2cjICWsfkjHYqZCMjiZK3aJZhvQwd2g0S8J1LZCaK20AM5cDFv6Zgsi0
         QZyIc1EeOuuTA7Bzw3HRT0fSw3OdwmEWPaGFCMbd4ZcssYxXfHc3g/EN/i//qGH1Lyvn
         Ii71101DazpupVEzBXgc2kkmoz/c7mOwroT9CRIMiZ730IEfOSBFZyUOVPNZi83zZDsj
         dHU4D/laHDos8CGCE17xerDdSMAppDqOQ5DB7oBv1RtmaNQptybukeok7LTTLkwVXAlx
         FDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PwcK+871dTd7BfFF6Qcv1VSAZKd0zAASIM8Hdwlta4Y=;
        b=sqHtgEBKdeKVO/cyO/kh3SyBMDKGz027yoQ9+JtJz4/hPXtEFpwvI+i4id4InmQ2YN
         VajvDpRyLiw6stEzK0+Dl01pvtRzJilv0nqW/4RHXtAUQ7fRd/LLpMgIuYVojBwUCN+b
         VygnMefwh3k0ww8XoCykzi9xYFdh+6rQjmvPQVRG0DxXb99v5CtqHUZlcmn86RKXdF6C
         fguu97X4NoDGroRyWAkmpQaO2lgFU8IbBhaWqqYl61AWDaJcy+CG904st3BeVcjywoZb
         ilq8WMcOk6L9IwXb01m7cZENnR4soLPGgDsSYkaaRx4uexVivwmXJzwaOii7IOghXs1N
         QYLA==
X-Gm-Message-State: APjAAAX/wZd6JASWer7Gd03ccoxHQ24A2xgKbgbB0oT6aXbOz4/qeqh9
        ZV1/jjDdLiqMQSBwCPLxEAoU
X-Google-Smtp-Source: APXvYqzVLwHh7E2WRaE3Ai1gddrTcafiqsJq81gZulSdD0165MTc1a7xHRxcZi/H6ie9W0HvODFeOQ==
X-Received: by 2002:a17:902:b409:: with SMTP id x9mr14741085plr.218.1581917270951;
        Sun, 16 Feb 2020 21:27:50 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:48d:3349:6027:e3e7:afa3:2ab9])
        by smtp.gmail.com with ESMTPSA id t19sm15204004pgg.23.2020.02.16.21.27.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Feb 2020 21:27:50 -0800 (PST)
Date:   Mon, 17 Feb 2020 10:57:43 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/16] bus: mhi: core: Add support for registering MHI
 controllers
Message-ID: <20200217052743.GA4809@Mani-XPS-13-9360>
References: <20200131135009.31477-1-manivannan.sadhasivam@linaro.org>
 <20200131135009.31477-3-manivannan.sadhasivam@linaro.org>
 <20200206165755.GB3894455@kroah.com>
 <20200211184130.GA11908@Mani-XPS-13-9360>
 <20200211192055.GA1962867@kroah.com>
 <20200213152013.GB15010@mani>
 <20200213153418.GA3623121@kroah.com>
 <20200213154809.GA26953@mani>
 <20200213155302.GA3635465@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213155302.GA3635465@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Feb 13, 2020 at 07:53:02AM -0800, Greg KH wrote:
> On Thu, Feb 13, 2020 at 09:18:09PM +0530, Manivannan Sadhasivam wrote:
> > Hi Greg,
> > 
> > On Thu, Feb 13, 2020 at 07:34:18AM -0800, Greg KH wrote:
> > > On Thu, Feb 13, 2020 at 08:50:13PM +0530, Manivannan Sadhasivam wrote:
> > > > On Tue, Feb 11, 2020 at 11:20:55AM -0800, Greg KH wrote:
> > > > > On Wed, Feb 12, 2020 at 12:11:30AM +0530, Manivannan Sadhasivam wrote:
> > > > > > Hi Greg,
> > > > > > 
> > > > > > On Thu, Feb 06, 2020 at 05:57:55PM +0100, Greg KH wrote:
> > > > > > > On Fri, Jan 31, 2020 at 07:19:55PM +0530, Manivannan Sadhasivam wrote:
> > > > > > > > --- /dev/null
> > > > > > > > +++ b/drivers/bus/mhi/core/init.c
> > > > > > > > @@ -0,0 +1,407 @@
> > > > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > > > +/*
> > > > > > > > + * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
> > > > > > > > + *
> > > > > > > > + */
> > > > > > > > +
> > > > > > > > +#define dev_fmt(fmt) "MHI: " fmt
> > > > > > > 
> > > > > > > This should not be needed, right?  The bus/device name should give you
> > > > > > > all you need here from what I can tell.  So why is this needed?
> > > > > > > 
> > > > > > 
> > > > > > The log will have only the device name as like PCI-E. But that won't specify
> > > > > > where the error is coming from. Having "MHI" prefix helps the users to
> > > > > > quickly identify that the error is coming from MHI stack.
> > > > > 
> > > > > If the driver binds properly to the device, the name of the driver will
> > > > > be there in the message, so I suggest using that please.
> > > > > 
> > > > > No need for this prefix...
> > > > > 
> > > > 
> > > > So the driver name will be in the log but that won't help identifying where
> > > > the log is coming from. This is more important for MHI since it reuses the
> > > > `struct device` of the transport device like PCI-E. For instance, below is
> > > > the log without MHI prefix:
> > > > 
> > > > [   47.355582] ath11k_pci 0000:01:00.0: Requested to power on
> > > > [   47.355724] ath11k_pci 0000:01:00.0: Power on setup success
> > > > 
> > > > As you can see, this gives the assumption that the log is coming from the
> > > > ath11k_pci driver. But the reality is, it is coming from MHI bus.
> > > 
> > > Then you should NOT be trying to "reuse" a struct device.
> > > 
> > > > With the prefix added, we will get below:
> > > > 
> > > > [   47.355582] ath11k_pci 0000:01:00.0: MHI: Requested to power on
> > > > [   47.355724] ath11k_pci 0000:01:00.0: MHI: Power on setup success
> > > > 
> > > > IMO, the prefix will give users a clear idea of logs and that will be very
> > > > useful for debugging.
> > > > 
> > > > Hope this clarifies.
> > > 
> > > Don't try to reuse struct devices, if you are a bus, have your own
> > > devices as that's the correct way to do things.
> > > 
> > 
> > I assumed that the buses relying on a different physical interface for the
> > actual communication can reuse the `struct device`. I can see that the MOXTET
> > bus driver already doing it. It reuses the `struct device` of SPI.
> 
> How can you reuse anything?
> 
> > And this assumption has deep rooted in MHI bus design.
> 
> Maybe I do not understand what this is at all, but a device can only be
> on one "bus" at a time.  How is that being broken here?
> 

Let me share some insight on how it is being used:

The MHI bus sits on top of the actual physical bus like PCI-E and requires
the physical bus for doing activities like allocating I/O virtual address,
runtime PM etc... The part which gets tied to the PCI-E from MHI is called MHI
controller driver. This MHI controller driver is also the actual PCI-E driver
managing the device.

For instance, we have QCA6390 PCI-E WLAN device. For this device, there is a
ath11k PCI-E driver and the same driver also registers as a MHI controller and
acts as a MHI controller driver. This is where I referred to reusing the PCI-E
struct device. It's not that MHI bus itself is reusing the PCI-E struct device
but we need the PCI-E device pointer to do above mentioned IOVA, PM operations
in some places. One of the usage is below:

```
void *buf = dma_alloc_coherent(mhi_cntrl->dev, size, dma_handle, gfp);
```

There was some discussion about it here: https://lkml.org/lkml/2020/1/27/21

The MHI bus itself has the struct device and it is the child of the physical
bus (PCI-E in this case).

Now coming to your actual question of why using a custom "MHI" prefix for
dev_ APIs. I agree that if we use the struct device of MHI bus it is not at all
needed. The fact that we are using "mhi_cntrl->dev" (which points to PCI-E dev)
is what confusing and it can be avoided.

I'll change it in next iteration.

Thanks,
Mani

> thanks,
> 
> greg k-h
