Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD59C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB018208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XP+y5Nlu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgH1PZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbgH1PZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:25:25 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5194CC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 08:25:25 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id o2so560896qvk.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 08:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=tuFcAVgxZuIdt9eXxsDgxRA0dJvRlxmkweppk3DZWFw=;
        b=XP+y5NluP9JTl7Cq94oskvsNQJQMpygl7bCO9ouKjefZswXkzWgv8vKEnI/GUTonxl
         cSJFJD2EeAfkQazp26ItRlDa4UY+CncNC/5cY1IlVL9DxZ1tcmh2CjpwclKuN9bx0v+Y
         06Kbz8oxrNuak6sgL1wi2WSLLELLwHB3yVMc3zx2eeJl41LQAfXqlbP1qgdNDaD67rHJ
         l3rajf1OOTmzuZd7iDUsgbNWJFFUYB+ojX++8GKaRyGZJqwY7prxf7Zo4Ko3dr3247gl
         ayPRyj9HUX478H4JLFSGTct9I7deHTku+4X+I/Kvx/71ntCXxhgdQeAOtee02WNknOvh
         84ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=tuFcAVgxZuIdt9eXxsDgxRA0dJvRlxmkweppk3DZWFw=;
        b=VrjYztA3K56Iu8JWUQXVvWJqmppI0G60UEIX0ynCb7Yebu3EyfwqG0x4WkuDteeU+r
         x2mix7B4zK5MaU4HcwJEnDojRwbGcVDOPnS+169o/2U1nqTZivMHmnZEtsRsWueuOK19
         z2JveF8tPLmKaixWJe8chcYZKzMnAfWy9fBxpNRZCl2Bz/ToRXk7q813nt9yHxoVa3Y1
         EiCoStN781mzekR47VAkT2VqaAhm0jNxcMyzKNv4mweS7Wz8r76CWxRXClblpwQ7a7ld
         5shvru/x7OHGsUTWD9r2I/g/8zzWhHYmccKenaOAMN6BsFUp7SiLWaNV2oC7U+85C4yt
         RaeQ==
X-Gm-Message-State: AOAM533OdhN3N9w5P3od8rXZd9zBPmAZtrno6UvkEJDQHyt816LhVONb
        Oh3r0K9nnCHnn5r4GwIn70Q=
X-Google-Smtp-Source: ABdhPJyXZkL8JRbNMI2cvACeLgarraOFKmH/M5LVD+xAiuxt4VKZh4wA56Q5TuzqdwwDM3YJFd5ZNw==
X-Received: by 2002:a0c:e9c7:: with SMTP id q7mr2179051qvo.195.1598628324371;
        Fri, 28 Aug 2020 08:25:24 -0700 (PDT)
Received: from LeoBras ([2804:14d:8084:8e41:9b0d:571e:a65:b5d8])
        by smtp.gmail.com with ESMTPSA id a67sm1037358qkd.40.2020.08.28.08.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 08:25:23 -0700 (PDT)
Message-ID: <06f732abbc3e6d4745428c4fc8cc98baf960a2e0.camel@gmail.com>
Subject: Re: [PATCH v1 08/10] powerpc/pseries/iommu: Add
 ddw_property_create() and refactor enable_ddw()
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Joel Stanley <joel@jms.id.au>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>,
        Murilo Fossa Vicentini <muvic@linux.ibm.com>,
        David Dai <zdai@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Aug 2020 12:25:16 -0300
In-Reply-To: <952fb640-01dd-003f-7fcb-bd48446d526c@ozlabs.ru>
References: <20200817234033.442511-1-leobras.c@gmail.com>
         <20200817234033.442511-9-leobras.c@gmail.com>
         <952fb640-01dd-003f-7fcb-bd48446d526c@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-24 at 15:07 +1000, Alexey Kardashevskiy wrote:
> 
> On 18/08/2020 09:40, Leonardo Bras wrote:
> > Code used to create a ddw property that was previously scattered in
> > enable_ddw() is now gathered in ddw_property_create(), which deals with
> > allocation and filling the property, letting it ready for
> > of_property_add(), which now occurs in sequence.
> > 
> > This created an opportunity to reorganize the second part of enable_ddw():
> > 
> > Without this patch enable_ddw() does, in order:
> > kzalloc() property & members, create_ddw(), fill ddwprop inside property,
> > ddw_list_add(), do tce_setrange_multi_pSeriesLP_walk in all memory,
> > of_add_property().
> > 
> > With this patch enable_ddw() does, in order:
> > create_ddw(), ddw_property_create(), of_add_property(), ddw_list_add(),
> > do tce_setrange_multi_pSeriesLP_walk in all memory.
> > 
> > This change requires of_remove_property() in case anything fails after
> > of_add_property(), but we get to do tce_setrange_multi_pSeriesLP_walk
> > in all memory, which looks the most expensive operation, only if
> > everything else succeeds.
> > 
> > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> > ---
> >  arch/powerpc/platforms/pseries/iommu.c | 97 +++++++++++++++-----------
> >  1 file changed, 57 insertions(+), 40 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> > index 4031127c9537..3a1ef02ad9d5 100644
> > --- a/arch/powerpc/platforms/pseries/iommu.c
> > +++ b/arch/powerpc/platforms/pseries/iommu.c
> > @@ -1123,6 +1123,31 @@ static void reset_dma_window(struct pci_dev *dev, struct device_node *par_dn)
> >  			 ret);
> >  }
> >  
> > +static int ddw_property_create(struct property **ddw_win, const char *propname,
> 
> @propname is always the same, do you really want to pass it every time?

I think it reads better, like "create a ddw property with this name".
Also, it makes possible to create ddw properties with other names, in
case we decide to create properties with different names depending on
the window created.

Also, it's probably optimized / inlined at this point.
Is it ok doing it like this?

> 
> > +			       u32 liobn, u64 dma_addr, u32 page_shift, u32 window_shift)
> > +{
> > +	struct dynamic_dma_window_prop *ddwprop;
> > +	struct property *win64;
> > +
> > +	*ddw_win = win64 = kzalloc(sizeof(*win64), GFP_KERNEL);
> > +	if (!win64)
> > +		return -ENOMEM;
> > +
> > +	win64->name = kstrdup(propname, GFP_KERNEL);
> 
> Not clear why "win64->name = DIRECT64_PROPNAME" would not work here, the
> generic OF code does not try kfree() it but it is probably out of scope
> here.

Yeah, I had that question too. 
Previous code was like that, and I as trying not to mess too much on
how it's done.

> > +	ddwprop = kzalloc(sizeof(*ddwprop), GFP_KERNEL);
> > +	win64->value = ddwprop;
> > +	win64->length = sizeof(*ddwprop);
> > +	if (!win64->name || !win64->value)
> > +		return -ENOMEM;
> 
> Up to 2 memory leaks here. I see the cleanup at "out_free_prop:" but
> still looks fragile. Instead you could simply return win64 as the only
> error possible here is -ENOMEM and returning NULL is equally good.

I agree. It's better if this function have it's own cleaning routine.
It will be fixed for next version.

> 
> 
> > +
> > +	ddwprop->liobn = cpu_to_be32(liobn);
> > +	ddwprop->dma_base = cpu_to_be64(dma_addr);
> > +	ddwprop->tce_shift = cpu_to_be32(page_shift);
> > +	ddwprop->window_shift = cpu_to_be32(window_shift);
> > +
> > +	return 0;
> > +}
> > +
> >  /*
> >   * If the PE supports dynamic dma windows, and there is space for a table
> >   * that can map all pages in a linear offset, then setup such a table,
> > @@ -1140,12 +1165,11 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
> >  	struct ddw_query_response query;
> >  	struct ddw_create_response create;
> >  	int page_shift;
> > -	u64 max_addr;
> > +	u64 max_addr, win_addr;
> >  	struct device_node *dn;
> >  	u32 ddw_avail[DDW_APPLICABLE_SIZE];
> >  	struct direct_window *window;
> > -	struct property *win64;
> > -	struct dynamic_dma_window_prop *ddwprop;
> > +	struct property *win64 = NULL;
> >  	struct failed_ddw_pdn *fpdn;
> >  	bool default_win_removed = false;
> >  
> > @@ -1244,38 +1268,34 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
> >  		goto out_failed;
> >  	}
> >  	len = order_base_2(max_addr);
> > -	win64 = kzalloc(sizeof(struct property), GFP_KERNEL);
> > -	if (!win64) {
> > -		dev_info(&dev->dev,
> > -			"couldn't allocate property for 64bit dma window\n");
> > +
> > +	ret = create_ddw(dev, ddw_avail, &create, page_shift, len);
> > +	if (ret != 0)
> 
> It is usually just "if (ret)"

It was previously like that, and all query_ddw() checks return value
this way. Should I update them all or just this one?

Thanks!

> 
> 
> >  		goto out_failed;
> > -	}
> > -	win64->name = kstrdup(DIRECT64_PROPNAME, GFP_KERNEL);
> > -	win64->value = ddwprop = kmalloc(sizeof(*ddwprop), GFP_KERNEL);
> > -	win64->length = sizeof(*ddwprop);
> > -	if (!win64->name || !win64->value) {
> > +
> > +	dev_dbg(&dev->dev, "created tce table LIOBN 0x%x for %pOF\n",
> > +		create.liobn, dn);
> > +
> > +	win_addr = ((u64)create.addr_hi << 32) | create.addr_lo;
> > +	ret = ddw_property_create(&win64, DIRECT64_PROPNAME, create.liobn, win_addr,
> > +				  page_shift, len);
> > +	if (ret) {
> >  		dev_info(&dev->dev,
> > -			"couldn't allocate property name and value\n");
> > +			 "couldn't allocate property, property name, or value\n");
> >  		goto out_free_prop;
> >  	}
> >  
> > -	ret = create_ddw(dev, ddw_avail, &create, page_shift, len);
> > -	if (ret != 0)
> > +	ret = of_add_property(pdn, win64);
> > +	if (ret) {
> > +		dev_err(&dev->dev, "unable to add dma window property for %pOF: %d",
> > +			pdn, ret);
> >  		goto out_free_prop;
> > -
> > -	ddwprop->liobn = cpu_to_be32(create.liobn);
> > -	ddwprop->dma_base = cpu_to_be64(((u64)create.addr_hi << 32) |
> > -			create.addr_lo);
> > -	ddwprop->tce_shift = cpu_to_be32(page_shift);
> > -	ddwprop->window_shift = cpu_to_be32(len);
> > -
> > -	dev_dbg(&dev->dev, "created tce table LIOBN 0x%x for %pOF\n",
> > -		  create.liobn, dn);
> > +	}
> >  
> >  	/* Add new window to existing DDW list */
> > -	window = ddw_list_add(pdn, ddwprop);
> > +	window = ddw_list_add(pdn, win64->value);
> >  	if (!window)
> > -		goto out_clear_window;
> > +		goto out_prop_del;
> >  
> >  	ret = walk_system_ram_range(0, memblock_end_of_DRAM() >> PAGE_SHIFT,
> >  			win64->value, tce_setrange_multi_pSeriesLP_walk);
> > @@ -1285,14 +1305,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
> >  		goto out_free_window;
> >  	}
> >  
> > -	ret = of_add_property(pdn, win64);
> > -	if (ret) {
> > -		dev_err(&dev->dev, "unable to add dma window property for %pOF: %d",
> > -			 pdn, ret);
> > -		goto out_free_window;
> > -	}
> > -
> > -	dev->dev.archdata.dma_offset = be64_to_cpu(ddwprop->dma_base);
> > +	dev->dev.archdata.dma_offset = win_addr;
> >  	goto out_unlock;
> >  
> >  out_free_window:
> > @@ -1302,14 +1315,18 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
> >  
> >  	kfree(window);
> >  
> > -out_clear_window:
> > -	remove_ddw(pdn, true);
> > +out_prop_del:
> > +	of_remove_property(pdn, win64);
> >  
> >  out_free_prop:
> > -	kfree(win64->name);
> > -	kfree(win64->value);
> > -	kfree(win64);
> > -	win64 = NULL;
> > +	if (win64) {
> > +		kfree(win64->name);
> > +		kfree(win64->value);
> > +		kfree(win64);
> > +		win64 = NULL;
> > +	}
> > +
> > +	remove_ddw(pdn, true);
> >  
> >  out_failed:
> >  	if (default_win_removed)
> > 

