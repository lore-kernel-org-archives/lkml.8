Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DB9C3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D6220661
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZA5raSFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgBMPsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:48:19 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36977 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbgBMPsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:48:17 -0500
Received: by mail-pj1-f68.google.com with SMTP id m13so2593612pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 07:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RfjI9i0NTaYRVEjadn31wa1/emWqSJn2YdEHdUOUyBU=;
        b=ZA5raSFERSr6fQvHPMwDSLdEQlIfkgjiokvpTh1ecbNiK1/Ivu7CB+edrDHrrVyMUK
         GcmhpFWjXs4fnf9tWtV2UYrigT16wNJ6XQ3BwsgEL3wpHimLu4q4SkO76axq03MnkjwK
         nm7/Zqcxy3pFypmqNQPWmheKat8JYok6VMM48yDUaIaBg6ZHHyV1KUQRXSNksm6PojDl
         6UqLwWC4NYsteLyoF+ebYAeBHMT4r3Wji3lkt7V5gq8Z+HaWXGmFMdGzs4EAyys2p95C
         N6HBHo0DUww9XS/hS/g7aFT3N0LwSyfGAVEzo/Y1rlZdgXOA48Qg148Jz4vLonVrmxSu
         gU4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RfjI9i0NTaYRVEjadn31wa1/emWqSJn2YdEHdUOUyBU=;
        b=ewhfjCXnkqAnSKGfEswPEZhIP2prd0MaDS/nMdxTq3Kocu02/dmHlZhHq5D+kEGMhR
         qjK8GU6tRiwbQ+1zJLU88VGSIha1dBqIQMY4mbcesb3+pt3Kry2S+BpK662RrAJnz2eO
         MOVFpi+F0kJQthhprmatrLaOQLN2v7WBTGRyLs3F+Ywr08uU0XGcfsYoxVANwC8UAvFs
         9PoGqMrTu+4js7fCqRvKNZej8iuMIcyUW19CDpK5rSEsJEVVXN0ti+VsOOTttKcNhp6b
         HGTnYSqMBIK9I0U+1g5VH9NeQlxuijtqimE8c/QhIYyMKXXOo52iJ+la0Tijwpw8rXga
         BRFQ==
X-Gm-Message-State: APjAAAVfbTlcmF138xXVdy0X32X+BSvZOyQ4i9C8BVaZ4QBGBnG0hq55
        rWrMKlG5eK88BioBADZwkOBLhZvZBA==
X-Google-Smtp-Source: APXvYqzCrml+6ep+ejXmeFv0G9vMlEKJa30gxFiGaO7tQQY/FwDOwuo9oqaxpcOzHc33+8VEyfBrjQ==
X-Received: by 2002:a17:90a:c084:: with SMTP id o4mr5671111pjs.35.1581608896960;
        Thu, 13 Feb 2020 07:48:16 -0800 (PST)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id m101sm3252070pje.13.2020.02.13.07.48.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 07:48:16 -0800 (PST)
Date:   Thu, 13 Feb 2020 21:18:09 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/16] bus: mhi: core: Add support for registering MHI
 controllers
Message-ID: <20200213154809.GA26953@mani>
References: <20200131135009.31477-1-manivannan.sadhasivam@linaro.org>
 <20200131135009.31477-3-manivannan.sadhasivam@linaro.org>
 <20200206165755.GB3894455@kroah.com>
 <20200211184130.GA11908@Mani-XPS-13-9360>
 <20200211192055.GA1962867@kroah.com>
 <20200213152013.GB15010@mani>
 <20200213153418.GA3623121@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213153418.GA3623121@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Feb 13, 2020 at 07:34:18AM -0800, Greg KH wrote:
> On Thu, Feb 13, 2020 at 08:50:13PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Feb 11, 2020 at 11:20:55AM -0800, Greg KH wrote:
> > > On Wed, Feb 12, 2020 at 12:11:30AM +0530, Manivannan Sadhasivam wrote:
> > > > Hi Greg,
> > > > 
> > > > On Thu, Feb 06, 2020 at 05:57:55PM +0100, Greg KH wrote:
> > > > > On Fri, Jan 31, 2020 at 07:19:55PM +0530, Manivannan Sadhasivam wrote:
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/bus/mhi/core/init.c
> > > > > > @@ -0,0 +1,407 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > +/*
> > > > > > + * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
> > > > > > + *
> > > > > > + */
> > > > > > +
> > > > > > +#define dev_fmt(fmt) "MHI: " fmt
> > > > > 
> > > > > This should not be needed, right?  The bus/device name should give you
> > > > > all you need here from what I can tell.  So why is this needed?
> > > > > 
> > > > 
> > > > The log will have only the device name as like PCI-E. But that won't specify
> > > > where the error is coming from. Having "MHI" prefix helps the users to
> > > > quickly identify that the error is coming from MHI stack.
> > > 
> > > If the driver binds properly to the device, the name of the driver will
> > > be there in the message, so I suggest using that please.
> > > 
> > > No need for this prefix...
> > > 
> > 
> > So the driver name will be in the log but that won't help identifying where
> > the log is coming from. This is more important for MHI since it reuses the
> > `struct device` of the transport device like PCI-E. For instance, below is
> > the log without MHI prefix:
> > 
> > [   47.355582] ath11k_pci 0000:01:00.0: Requested to power on
> > [   47.355724] ath11k_pci 0000:01:00.0: Power on setup success
> > 
> > As you can see, this gives the assumption that the log is coming from the
> > ath11k_pci driver. But the reality is, it is coming from MHI bus.
> 
> Then you should NOT be trying to "reuse" a struct device.
> 
> > With the prefix added, we will get below:
> > 
> > [   47.355582] ath11k_pci 0000:01:00.0: MHI: Requested to power on
> > [   47.355724] ath11k_pci 0000:01:00.0: MHI: Power on setup success
> > 
> > IMO, the prefix will give users a clear idea of logs and that will be very
> > useful for debugging.
> > 
> > Hope this clarifies.
> 
> Don't try to reuse struct devices, if you are a bus, have your own
> devices as that's the correct way to do things.
> 

I assumed that the buses relying on a different physical interface for the
actual communication can reuse the `struct device`. I can see that the MOXTET
bus driver already doing it. It reuses the `struct device` of SPI.

And this assumption has deep rooted in MHI bus design.

Thanks,
Mani

> thanks,
> 
> greg k-h
