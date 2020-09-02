Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F575C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 05:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F234206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 05:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1sJW0tD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIBF1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 01:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgIBF1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 01:27:45 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69CEC061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 22:27:45 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id z2so2751038qtv.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 22:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=XfN2S4wEu3J30uItKa8ht/kF+Elcvq3r/VGMNW/Xds8=;
        b=g1sJW0tDpt5NJf6zdMPyOsbWtJTqUQVvaYlg2XRBGUm062xJkXUU5EKdS6Lj38VmMY
         a4KzzEXivXnEFbZ2k3l3RbM0u0dzejW11knYYs2/XD4Ysyqt4YqZ9bOS8bZAjHjxlYpS
         acQ+wBtAjQ9S8hIEKlIvVH6k70gcSINY4AJmUhtmhig7GaN5YoiuimXghGdHbJZQ4nL0
         5cmOSNeEglAIvJssTPekubsg3WHFlnF9OV8/CujbQ5E6iBV2o55wBOPvBSBXglnzYlzR
         D8wWeElb/tdlDN685wXoMhHkR3EQb6PO23jIyuuy4r6DHJxJ4Ux+yRXOi71z3hccRAI/
         VkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=XfN2S4wEu3J30uItKa8ht/kF+Elcvq3r/VGMNW/Xds8=;
        b=W53jF9ycBgBXV+wXDY5zGbG3LLoOhXQ5Xx84qVCL+cFrhtVCGU+zUmFfAJzJFLKkix
         yyLHd+8k/37NpGwqkmgxfJdp7A4L2h6n1PZJMbzGAD4XJ0z7KGHYN4S8EkUl/0on3qgh
         Bd0+jqfrElTrj4PUy/5s2d2Db18gY4KeotptGrp+PqjfVwjaBIJmtzV4DF9i9Hypf4sU
         xEXouC1JKMNVedhXG6aX12hTLjPP/HTS5E/Htx/gY33wOl3KQwM4J7Nv8yH05QtA/6b4
         X2bvVeC6QbTGBm0Ip4NPmkjfbh2eTQGZYov3BMTS3CBLcIDAJRJ9Scys6aS23GEioLNT
         WxXg==
X-Gm-Message-State: AOAM532i3czEf0nldgnrx/JF7UW90d3erdpLPGsEdPAc9HxnZUCFqG92
        L4KQM+wNUDHpHCxd+a+oFL4=
X-Google-Smtp-Source: ABdhPJxKH5DCo6veAfOrPa0oTAGIaKUU+c58s6FPXyK/XyjUw1/jddq2MVhMRBehSmyR6DaQmF2bPA==
X-Received: by 2002:aed:21da:: with SMTP id m26mr5348675qtc.197.1599024464901;
        Tue, 01 Sep 2020 22:27:44 -0700 (PDT)
Received: from LeoBras (179-125-130-62.dynamic.desktop.com.br. [179.125.130.62])
        by smtp.gmail.com with ESMTPSA id y18sm3962554qkf.93.2020.09.01.22.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 22:27:44 -0700 (PDT)
Message-ID: <893b6cc95a3e415677c98834af5a6febd70717f4.camel@gmail.com>
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
Date:   Wed, 02 Sep 2020 02:27:37 -0300
In-Reply-To: <1a469384-91ad-81f0-2a42-4c985cbc92da@ozlabs.ru>
References: <20200817234033.442511-1-leobras.c@gmail.com>
         <20200817234033.442511-9-leobras.c@gmail.com>
         <952fb640-01dd-003f-7fcb-bd48446d526c@ozlabs.ru>
         <06f732abbc3e6d4745428c4fc8cc98baf960a2e0.camel@gmail.com>
         <1a469384-91ad-81f0-2a42-4c985cbc92da@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-31 at 14:34 +1000, Alexey Kardashevskiy wrote:
> 
> On 29/08/2020 01:25, Leonardo Bras wrote:
> > On Mon, 2020-08-24 at 15:07 +1000, Alexey Kardashevskiy wrote:
> > > On 18/08/2020 09:40, Leonardo Bras wrote:
> > > > Code used to create a ddw property that was previously scattered in
> > > > enable_ddw() is now gathered in ddw_property_create(), which deals with
> > > > allocation and filling the property, letting it ready for
> > > > of_property_add(), which now occurs in sequence.
> > > > 
> > > > This created an opportunity to reorganize the second part of enable_ddw():
> > > > 
> > > > Without this patch enable_ddw() does, in order:
> > > > kzalloc() property & members, create_ddw(), fill ddwprop inside property,
> > > > ddw_list_add(), do tce_setrange_multi_pSeriesLP_walk in all memory,
> > > > of_add_property().
> > > > 
> > > > With this patch enable_ddw() does, in order:
> > > > create_ddw(), ddw_property_create(), of_add_property(), ddw_list_add(),
> > > > do tce_setrange_multi_pSeriesLP_walk in all memory.
> > > > 
> > > > This change requires of_remove_property() in case anything fails after
> > > > of_add_property(), but we get to do tce_setrange_multi_pSeriesLP_walk
> > > > in all memory, which looks the most expensive operation, only if
> > > > everything else succeeds.
> > > > 
> > > > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> > > > ---
> > > >  arch/powerpc/platforms/pseries/iommu.c | 97 +++++++++++++++-----------
> > > >  1 file changed, 57 insertions(+), 40 deletions(-)
> > > > 
> > > > diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> > > > index 4031127c9537..3a1ef02ad9d5 100644
> > > > --- a/arch/powerpc/platforms/pseries/iommu.c
> > > > +++ b/arch/powerpc/platforms/pseries/iommu.c
> > > > @@ -1123,6 +1123,31 @@ static void reset_dma_window(struct pci_dev *dev, struct device_node *par_dn)
> > > >  			 ret);
> > > >  }
> > > >  
> > > > +static int ddw_property_create(struct property **ddw_win, const char *propname,
> > > 
> > > @propname is always the same, do you really want to pass it every time?
> > 
> > I think it reads better, like "create a ddw property with this name".
> 
> This reads as "there are at least two ddw properties".
> 
> > Also, it makes possible to create ddw properties with other names, in
> > case we decide to create properties with different names depending on
> > the window created.
> 
> It is one window at any given moment, why call it different names... I
> get the part that it is not always "direct" anymore but still...
> 

It seems the case as one of the options you suggested on patch [09/10]

>> I suspect it breaks kexec (from older kernel to this one) so you
>> either need to check for both DT names or just keep the old one.

> 
> > Also, it's probably optimized / inlined at this point.
> > Is it ok doing it like this?
> > 
> > > > +			       u32 liobn, u64 dma_addr, u32 page_shift, u32 window_shift)
> > > > +{
> > > > +	struct dynamic_dma_window_prop *ddwprop;
> > > > +	struct property *win64;
> > > > +
> > > > +	*ddw_win = win64 = kzalloc(sizeof(*win64), GFP_KERNEL);
> > > > +	if (!win64)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	win64->name = kstrdup(propname, GFP_KERNEL);
> > > 
> > > Not clear why "win64->name = DIRECT64_PROPNAME" would not work here, the
> > > generic OF code does not try kfree() it but it is probably out of scope
> > > here.
> > 
> > Yeah, I had that question too. 
> > Previous code was like that, and I as trying not to mess too much on
> > how it's done.
> > 
> > > > +	ddwprop = kzalloc(sizeof(*ddwprop), GFP_KERNEL);
> > > > +	win64->value = ddwprop;
> > > > +	win64->length = sizeof(*ddwprop);
> > > > +	if (!win64->name || !win64->value)
> > > > +		return -ENOMEM;
> > > 
> > > Up to 2 memory leaks here. I see the cleanup at "out_free_prop:" but
> > > still looks fragile. Instead you could simply return win64 as the only
> > > error possible here is -ENOMEM and returning NULL is equally good.
> > 
> > I agree. It's better if this function have it's own cleaning routine.
> > It will be fixed for next version.
> > 
> > > 
> > > > +
> > > > +	ddwprop->liobn = cpu_to_be32(liobn);
> > > > +	ddwprop->dma_base = cpu_to_be64(dma_addr);
> > > > +	ddwprop->tce_shift = cpu_to_be32(page_shift);
> > > > +	ddwprop->window_shift = cpu_to_be32(window_shift);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  /*
> > > >   * If the PE supports dynamic dma windows, and there is space for a table
> > > >   * that can map all pages in a linear offset, then setup such a table,
> > > > @@ -1140,12 +1165,11 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
> > > >  	struct ddw_query_response query;
> > > >  	struct ddw_create_response create;
> > > >  	int page_shift;
> > > > -	u64 max_addr;
> > > > +	u64 max_addr, win_addr;
> > > >  	struct device_node *dn;
> > > >  	u32 ddw_avail[DDW_APPLICABLE_SIZE];
> > > >  	struct direct_window *window;
> > > > -	struct property *win64;
> > > > -	struct dynamic_dma_window_prop *ddwprop;
> > > > +	struct property *win64 = NULL;
> > > >  	struct failed_ddw_pdn *fpdn;
> > > >  	bool default_win_removed = false;
> > > >  
> > > > @@ -1244,38 +1268,34 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
> > > >  		goto out_failed;
> > > >  	}
> > > >  	len = order_base_2(max_addr);
> > > > -	win64 = kzalloc(sizeof(struct property), GFP_KERNEL);
> > > > -	if (!win64) {
> > > > -		dev_info(&dev->dev,
> > > > -			"couldn't allocate property for 64bit dma window\n");
> > > > +
> > > > +	ret = create_ddw(dev, ddw_avail, &create, page_shift, len);
> > > > +	if (ret != 0)
> > > 
> > > It is usually just "if (ret)"
> > 
> > It was previously like that, and all query_ddw() checks return value
> > this way.
> 
> ah I see.
> 
> > Should I update them all or just this one?
> 
> Pick one variant and make sure all new lines use just that. In this
> patch you add both variants. Thanks,

Ok, I will do that from now on.
Thanks!



