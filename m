Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70686C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B3A020768
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ricGvkCb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbgFVS7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730030AbgFVS7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:59:24 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44485C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:59:24 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id er17so8469968qvb.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=mrWr6kV+xxuaeAPelslUEIXjbrMNdMFZdqp0d0NBrWE=;
        b=ricGvkCbGapsRagk0P/ooqxU2YZShHCnDQleoF5icWCOEPdJyr0fj2Ev3TWJiE2Hxg
         XeFTJpyUWpOjha3FyzAJbkNvNtBMY7RMxrPP3Wzd0LkbpDzvleN3llV/LWFWkhsDh/WF
         MrIh1LAFu0E2N4X50qKG95bGcrWuxWvVVFWBl/JBDY/RUhBuofcV6CMxHf9joa7QOPnj
         q74goP8iutSXUh3bbBHZM8eSnGMAb5ZGnkdT+pcd4GGdAc2T+r16EdipTSgsZA2GSSwc
         O1WSWsje4rTWiFeom8ZtzDU86CDbmpozkErRCc9JhrLNUeabus7xJxw/bUSKiv7EjiRi
         r/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=mrWr6kV+xxuaeAPelslUEIXjbrMNdMFZdqp0d0NBrWE=;
        b=cHreRETj46nPThTeg+LEsFHHqNdWAjWq8lwG69PPBJHleK5Hhq5oF1g8IcjykqRNTq
         n4WQD8iGQNeDdEh9ZKqyy9gEZaXXhtfqkpwFXtEZsBNQnaxKdqQg+0sSEsY4VblJuxRD
         B+AcWQwYirBOKOZl/AeFNFjOWx779jWaHtb3+jcM2kgbq5MapvAqWOgSRKRhesZYrtiE
         Belr3cs592ZCxjZBQ43vG5TI3AqUS5PFLjLaliCi4xbEaXqO6q1qVJGJ5TUMrdkwrWE7
         HAdbyVcrnzM0/wj7WuH+GPilUfPS1qp2wi/4Otq/pKoT1yG8fnxaSjFmALufEDIabvVG
         vQMg==
X-Gm-Message-State: AOAM532dWbBa8E7hGxSg/lvw8cHXB7zAAY7wboGqp2u/Z1gzBIDz55bb
        wQqN75DF6dcW5Gw4H2r9iL14kmU6
X-Google-Smtp-Source: ABdhPJy8MpcqHwxreI5mbCmgW2JedRG0HFRE8kNBfLEsMNfvqdn3hFTaVKMG2xKHZPYh/5wm6cRynQ==
X-Received: by 2002:ad4:4f23:: with SMTP id fc3mr23471455qvb.25.1592852363119;
        Mon, 22 Jun 2020 11:59:23 -0700 (PDT)
Received: from LeoBras (177-131-65-187.dynamic.desktop.com.br. [177.131.65.187])
        by smtp.gmail.com with ESMTPSA id l2sm17383902qtc.80.2020.06.22.11.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 11:59:22 -0700 (PDT)
Message-ID: <4180fd9bb0409a9c7009fef3ccae8eb2ad46d0a2.camel@gmail.com>
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
Date:   Mon, 22 Jun 2020 15:58:50 -0300
In-Reply-To: <2f004ecc-4788-47b6-e9ae-0c08d4723008@ozlabs.ru>
References: <20200619050619.266888-1-leobras.c@gmail.com>
         <20200619050619.266888-3-leobras.c@gmail.com>
         <2f004ecc-4788-47b6-e9ae-0c08d4723008@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexey, thanks for the feedback!

On Mon, 2020-06-22 at 20:02 +1000, Alexey Kardashevskiy wrote:
> 
> On 19/06/2020 15:06, Leonardo Bras wrote:
> > Platforms supporting the DDW option starting with LoPAR level 2.7 implement
> > ibm,ddw-extensions. The first extension available (index 2) carries the
> > token for ibm,reset-pe-dma-windows rtas call, which is used to restore
> > the default DMA window for a device, if it has been deleted.
> > 
> > It does so by resetting the TCE table allocation for the PE to it's
> > boot time value, available in "ibm,dma-window" device tree node.
> > 
> > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> > ---
> >  arch/powerpc/platforms/pseries/iommu.c | 33 ++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> > 
> > diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> > index e5a617738c8b..5e1fbc176a37 100644
> > --- a/arch/powerpc/platforms/pseries/iommu.c
> > +++ b/arch/powerpc/platforms/pseries/iommu.c
> > @@ -1012,6 +1012,39 @@ static phys_addr_t ddw_memory_hotplug_max(void)
> >  	return max_addr;
> >  }
> >  
> > +/*
> > + * Platforms supporting the DDW option starting with LoPAR level 2.7 implement
> > + * ibm,ddw-extensions, which carries the rtas token for
> > + * ibm,reset-pe-dma-windows.
> > + * That rtas-call can be used to restore the default DMA window for the device.
> > + */
> > +static void reset_dma_window(struct pci_dev *dev, struct device_node *par_dn)
> > +{
> > +	int ret;
> > +	u32 cfg_addr, ddw_ext[3];
> > +	u64 buid;
> > +	struct device_node *dn;
> > +	struct pci_dn *pdn;
> > +
> > +	ret = of_property_read_u32_array(par_dn, "ibm,ddw-extensions",
> > +					 &ddw_ext[0], 3);
> 
> s/3/2/ as for the reset extension you do not need the "64bit largest
> block" extension.

Sure, I will update this.

> 
> 
> > +	if (ret)
> > +		return;
> > +
> > +	dn = pci_device_to_OF_node(dev);
> > +	pdn = PCI_DN(dn);
> > +	buid = pdn->phb->buid;
> > +	cfg_addr = ((pdn->busno << 16) | (pdn->devfn << 8));
> > +
> > +	ret = rtas_call(ddw_ext[1], 3, 1, NULL, cfg_addr,
> 
> Here the "reset" extention is in ddw_ext[1]. Hm. 1/4 has a bug then.

Humm, in 1/4 I used dd_ext[0] (how many extensions) and ddw_ext[2] (64-
bit largest window count). I fail to see the bug here.

> And I am pretty sure it won't compile as reset_dma_window() is not used
> and it is static so fold it into one the next patches. Thanks,

Sure, I will do that. 
I was questioning myself about this and thought it would be better to
split for easier revision.

> 
> 
> > +			BUID_HI(buid), BUID_LO(buid));
> > +	if (ret)
> > +		dev_info(&dev->dev,
> > +			 "ibm,reset-pe-dma-windows(%x) %x %x %x returned %d ",
> > +			 ddw_ext[1], cfg_addr, BUID_HI(buid), BUID_LO(buid),
> > +			 ret);
> > +}
> > +
> >  /*
> >   * If the PE supports dynamic dma windows, and there is space for a table
> >   * that can map all pages in a linear offset, then setup such a table,
> > 

Best regards,
Leonardo

