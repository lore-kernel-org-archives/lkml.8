Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B25CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54ADF206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWXtKJKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731308AbgFWCUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728447AbgFWCUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:20:32 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390DCC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 19:20:31 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id m9so2533352qvx.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 19:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=RiVxZrK7W9En977XCqTruiSR8ZglkbLVbM9+VSLHSI4=;
        b=MWXtKJKUKdl6cavddgRsqTACe0qSqYfUD+h8OoCMRaFkJn8MW5oGBWRo3sYI3tBmjn
         GlCyeSkJcVxN4JZ9I7cprk7lqmnoIwO4HgiaVEFawCVujnHDG/FotlhyhutJBT5a9kc+
         L5bo4tYBZjFR6/tQIxJvaIXogKMLV3H0waYQ2sB5jk4kIF+BdbSf7lX0Zrgz/ccxer/w
         lDZGwsQAOJVY3zeU0w2kIqUzCwVdY+h4DGCD70wxt9ulXDVmrhLB8b3MXxjq77/yZ4Rb
         EEcuanMK/aT+d1lMeRQSxdWfWSM6n5IP7kAUFYDX2O6ky2MzTctlovKI/wH62lsEmcUq
         pCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=RiVxZrK7W9En977XCqTruiSR8ZglkbLVbM9+VSLHSI4=;
        b=eoOl2auSCxDhobkSdhY6DnPDPab7Mnqn/aHyXoIP7VeIwtoXTu6XokPonJmwT2gmBk
         +0hDZin673RnRzZJRdzDjZRyKbvJkn3CM8U+IzARHIpamgyyoTUQk7Y9BLjHd3sMz2rw
         PXNIy8FXYKH79R+gyNlfR/n9XBj4hkwVWDiM2/dm6rwCpDcujjO06OISp/j01CrB4RM4
         Syk8MxPBcHsYVYUze7y0+rqiNDqiKa5W8iAeGapwjX8NLbXoLKZfAno4K3lJSaSHOAK9
         l5BZB0gQG8gsR1kLGlW/WPkV5UoTwyLfoLHCTr/Y5B4Q6lO5/+Rz8Od9Iw6wpKH4fne1
         9m5Q==
X-Gm-Message-State: AOAM531HKZlL9GyZk72fJ1EAv+6Wec+CR16m7HC33+9nqYiDFJI5XsgH
        wc6W+FmpSm2+fyRwVjEeDR0=
X-Google-Smtp-Source: ABdhPJzACCXKb4DvU1aJ1moVc8D+dJbwDtwToBTSHC1yig/UIau1yudbB8TD5XAgO8ixR0k3mShnMA==
X-Received: by 2002:ad4:4526:: with SMTP id l6mr286078qvu.16.1592878830489;
        Mon, 22 Jun 2020 19:20:30 -0700 (PDT)
Received: from LeoBras (177-131-65-187.dynamic.desktop.com.br. [177.131.65.187])
        by smtp.gmail.com with ESMTPSA id p80sm4214865qke.19.2020.06.22.19.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 19:20:29 -0700 (PDT)
Message-ID: <020498a66f6683e21d9691c0f23642dae7f176cf.camel@gmail.com>
Subject: Re: [PATCH 2/4] powerpc/pseries/iommu: Implement
 ibm,reset-pe-dma-windows rtas call
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Mon, 22 Jun 2020 23:20:08 -0300
In-Reply-To: <c02fbebb-32ed-f328-ff93-ab2201844d61@ozlabs.ru>
References: <20200619050619.266888-1-leobras.c@gmail.com>
         <20200619050619.266888-3-leobras.c@gmail.com>
         <2f004ecc-4788-47b6-e9ae-0c08d4723008@ozlabs.ru>
         <4180fd9bb0409a9c7009fef3ccae8eb2ad46d0a2.camel@gmail.com>
         <c02fbebb-32ed-f328-ff93-ab2201844d61@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-23 at 11:11 +1000, Alexey Kardashevskiy wrote:
> 
> On 23/06/2020 04:58, Leonardo Bras wrote:
> > Hello Alexey, thanks for the feedback!
> > 
> > On Mon, 2020-06-22 at 20:02 +1000, Alexey Kardashevskiy wrote:
> > > On 19/06/2020 15:06, Leonardo Bras wrote:
> > > > Platforms supporting the DDW option starting with LoPAR level 2.7 implement
> > > > ibm,ddw-extensions. The first extension available (index 2) carries the
> > > > token for ibm,reset-pe-dma-windows rtas call, which is used to restore
> > > > the default DMA window for a device, if it has been deleted.
> > > > 
> > > > It does so by resetting the TCE table allocation for the PE to it's
> > > > boot time value, available in "ibm,dma-window" device tree node.
> > > > 
> > > > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> > > > ---
> > > >  arch/powerpc/platforms/pseries/iommu.c | 33 ++++++++++++++++++++++++++
> > > >  1 file changed, 33 insertions(+)
> > > > 
> > > > diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> > > > index e5a617738c8b..5e1fbc176a37 100644
> > > > --- a/arch/powerpc/platforms/pseries/iommu.c
> > > > +++ b/arch/powerpc/platforms/pseries/iommu.c
> > > > @@ -1012,6 +1012,39 @@ static phys_addr_t ddw_memory_hotplug_max(void)
> > > >  	return max_addr;
> > > >  }
> > > >  
> > > > +/*
> > > > + * Platforms supporting the DDW option starting with LoPAR level 2.7 implement
> > > > + * ibm,ddw-extensions, which carries the rtas token for
> > > > + * ibm,reset-pe-dma-windows.
> > > > + * That rtas-call can be used to restore the default DMA window for the device.
> > > > + */
> > > > +static void reset_dma_window(struct pci_dev *dev, struct device_node *par_dn)
> > > > +{
> > > > +	int ret;
> > > > +	u32 cfg_addr, ddw_ext[3];
> > > > +	u64 buid;
> > > > +	struct device_node *dn;
> > > > +	struct pci_dn *pdn;
> > > > +
> > > > +	ret = of_property_read_u32_array(par_dn, "ibm,ddw-extensions",
> > > > +					 &ddw_ext[0], 3);
> > > 
> > > s/3/2/ as for the reset extension you do not need the "64bit largest
> > > block" extension.
> > 
> > Sure, I will update this.
> > 
> > > 
> > > > +	if (ret)
> > > > +		return;
> > > > +
> > > > +	dn = pci_device_to_OF_node(dev);
> > > > +	pdn = PCI_DN(dn);
> > > > +	buid = pdn->phb->buid;
> > > > +	cfg_addr = ((pdn->busno << 16) | (pdn->devfn << 8));
> > > > +
> > > > +	ret = rtas_call(ddw_ext[1], 3, 1, NULL, cfg_addr,
> > > 
> > > Here the "reset" extention is in ddw_ext[1]. Hm. 1/4 has a bug then.
> > 
> > Humm, in 1/4 I used dd_ext[0] (how many extensions) and ddw_ext[2] (64-
> > bit largest window count). I fail to see the bug here.
> 
> There is none, my bad :)
> 
> 
> > > And I am pretty sure it won't compile as reset_dma_window() is not used
> > > and it is static so fold it into one the next patches. Thanks,
> > 
> > Sure, I will do that. 
> > I was questioning myself about this and thought it would be better to
> > split for easier revision.
> 
> People separate things when a patch is really huge but even then I miss
> the point - I'd really like to see a new function _and_ its uses in the
> same patch, otherwise I either need to jump between mails or apply the
> series, either is little but extra work :) Thanks,


Sure, that makes sense.
I will keep that in mind for future patchsets (and v2).

Thank you!

> 
> 
> > > 
> > > > +			BUID_HI(buid), BUID_LO(buid));
> > > > +	if (ret)
> > > > +		dev_info(&dev->dev,
> > > > +			 "ibm,reset-pe-dma-windows(%x) %x %x %x returned %d ",
> > > > +			 ddw_ext[1], cfg_addr, BUID_HI(buid), BUID_LO(buid),
> > > > +			 ret);
> > > > +}
> > > > +
> > > >  /*
> > > >   * If the PE supports dynamic dma windows, and there is space for a table
> > > >   * that can map all pages in a linear offset, then setup such a table,
> > > > 
> > 
> > Best regards,
> > Leonardo
> > 

