Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8089C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C64B20720
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kg41CQjE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbgFWCPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728447AbgFWCPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:15:17 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D59EC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 19:15:17 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d27so14311309qtg.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 19:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=zPuuLnD2JMR0gFscQNLcEig+u3tWYGPvfC5HYQiv6xs=;
        b=kg41CQjE3NNtozsMZU3SWTq5uaRK6UfddOHwptmHW5TxRBCXtchMkMFehcQcyXs84K
         c/KCPMKBmgOkBo3M3t3j5lpg5HfMMchaAHST+1+PwGtDEvwQK3YeaOrCnL0zCipN3HaQ
         QWXTVROn8nzTta4nsFRAktAGyRM2KYhIrj7dIp5xpA76qZ5JJ+5SjxNKnv7fQ4OXLkkM
         U2Oq5++o+9N0E/hhYnFkUibrohfZvo1b+Cb9ZTCQMXHsqxTBOhBen/6iYJ+P4a3x4SB4
         h4dpUjS4/ndB+XhHhoWYCnpF+TAxsSQS0ENVptcjSkbKKjuv86rLuwkdg1/ZfQAmCgbU
         7ScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=zPuuLnD2JMR0gFscQNLcEig+u3tWYGPvfC5HYQiv6xs=;
        b=cu+CI60bsHvIGJGxto/7loZNrkE1+tqpdfNZbEu4AZ77R9vNOLPzHrfENN4T8CUnrv
         9vIVBXWUepI6a+mSK1RuFsCIt8KAd/vrEhmAXBSlQumtSxYO7CSwDcDdIpJiU71ZWOeo
         1IFb4FRrhARWjBJx2G9hwyxNcVVbw5zHB+vdZAwzrPuoKZWegJPcLjgG9Hvq7DrspEh2
         sAUpUGb/r/iM4bp2G7Wf7O+AfvbykS/60UIreqF8SGWnostc3GnVxT2/Qxs8JNSV0OXO
         dXzZRV1xSPFk8se6x1oJldXQMOFXTws70rNingUtOUXiZjNkt1l1D2LoXnK2gySMUpm5
         ey0A==
X-Gm-Message-State: AOAM531O6223FgBwT486pW0OfM+rK2iECyMnybnFHdSGJ/RezkYSCO0G
        B67xnumv0PPi+GBN0UJvLHTNKZIi
X-Google-Smtp-Source: ABdhPJzoHZz2iVjx44jQQQ0Lt8K6HySqMbRySz+68LnyY4O+3VMRtC54RCFdp6jMTxxw7TrsrVXdqA==
X-Received: by 2002:aed:2062:: with SMTP id 89mr19110910qta.327.1592878516477;
        Mon, 22 Jun 2020 19:15:16 -0700 (PDT)
Received: from LeoBras (177-131-65-187.dynamic.desktop.com.br. [177.131.65.187])
        by smtp.gmail.com with ESMTPSA id d2sm15527769qti.62.2020.06.22.19.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 19:15:15 -0700 (PDT)
Message-ID: <c331742c9f7a3e3ccead5d9db99a66d3f268b95f.camel@gmail.com>
Subject: Re: [PATCH 1/4] powerpc/pseries/iommu: Update call to
 ibm,query-pe-dma-windows
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 22 Jun 2020 23:14:51 -0300
In-Reply-To: <4176ea2b-c778-2f59-ba57-7339b873ead5@ozlabs.ru>
References: <20200619050619.266888-1-leobras.c@gmail.com>
         <20200619050619.266888-2-leobras.c@gmail.com>
         <cfbcacde-ca7f-5fc7-2fcf-267f698f3d49@ozlabs.ru>
         <c15189a5c77752ea62022608dab28601965afaaa.camel@gmail.com>
         <4176ea2b-c778-2f59-ba57-7339b873ead5@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-23 at 11:12 +1000, Alexey Kardashevskiy wrote:
[snip]
> > > > +static int query_ddw_out_sz(struct device_node *par_dn)
> > > 
> > > Can easily be folded into query_ddw().
> > 
> > Sure, but it will get inlined by the compiler, and I think it reads
> > better this way. 
> > I mean, I understand you have a reason to think it's better to fold it
> > in query_ddw(), and I would like to better understand that to improve
> > my code in the future.
> 
> You have numbers 5 and 6 (the number of parameters) twice in the file,
> this is why I brought it up. query_ddw_out_sz() can potentially return
> something else than 5 or 6 and you will have to change the callsite(s)
> then, since these are not macros, this allows to think there may be more
> places with 5 and 6. Dunno. A single function will simplify things imho.

That's a good point. Thanks!

> 
> 
> > > > +{
> > > > +	int ret;
> > > > +	u32 ddw_ext[3];
> > > > +
> > > > +	ret = of_property_read_u32_array(par_dn, "ibm,ddw-extensions",
> > > > +					 &ddw_ext[0], 3);
> > > > +	if (ret || ddw_ext[0] < 2 || ddw_ext[2] != 1)
> > > 
> > > Oh that PAPR thing again :-/
> > > 
> > > ===
> > > The “ibm,ddw-extensions” property value is a list of integers the first
> > > integer indicates the number of extensions implemented and subsequent
> > > integers, one per extension, provide a value associated with that
> > > extension.
> > > ===
> > > 
> > > So ddw_ext[0] is length.
> > > Listindex==2 is for "reset" says PAPR and
> > > Listindex==3 is for this new 64bit "largest_available_block".
> > > 
> > > So I'd expect ddw_ext[2] to have the "reset" token and ddw_ext[3] to
> > > have "1" for this new feature but indexes are smaller. I am confused.
> > > Either way these "2" and "3" needs to be defined in macros, "0" probably
> > > too.
> > 
> > Remember these indexes are not C-like 0-starting indexes, where the
> > size would be Listindex==1.
> 
> Yeah I can see that is the assumption but out of curiosity - is it
> written anywhere? Across PAPR, they index bytes from 1 but bits from 0 :-/

From LoPAR: 
The “ibm,ddw-extensions” property value is a list of integers the first
integer indicates the number of extensions implemented and subsequent
integers, one per extension, provide a value associated with that
extension.

And the list/table then shows extensions from 2 on onwards:
List index 2 : Token of the ibm,reset-pe-dma-windows RTAS Call
(...)

> Either way make them macros.
> 
> 
> > Basically, in C-like array it's :
> > a[0] == size, 
> > a[1] == reset_token, 
> > a[2] == new 64bit "largest_available_block"
> > 
> > > Please post 'lsprop "ibm,ddw-extensions"' here. Thanks,
> > 
> > Sure:
> > [root@host pci@800000029004005]# lsprop "ibm,ddw-extensions"
> > ibm,dd
> > w-extensions
> >                  00000002 00000056 00000000
> 
> Right, good. Thanks,

Thank you for reviewing!

> 
> > 
> > > > +		return 5;
> > > > +	return 6;
> > > > +}
> > > > +
> > > >  static int query_ddw(struct pci_dev *dev, const u32 *ddw_avail,
> > > > -			struct ddw_query_response *query)
> > > > +		     struct ddw_query_response *query,
> > > > +		     struct device_node *par_dn)
> > > >  {
> > > >  	struct device_node *dn;
> > > >  	struct pci_dn *pdn;
> > > > -	u32 cfg_addr;
> > > > +	u32 cfg_addr, query_out[5];
> > > >  	u64 buid;
> > > > -	int ret;
> > > > +	int ret, out_sz;
> > > >  
> > > >  	/*
> > > >  	 * Get the config address and phb buid of the PE window.
> > > > @@ -888,12 +906,29 @@ static int query_ddw(struct pci_dev *dev, const u32 *ddw_avail,
> > > >  	pdn = PCI_DN(dn);
> > > >  	buid = pdn->phb->buid;
> > > >  	cfg_addr = ((pdn->busno << 16) | (pdn->devfn << 8));
> > > > +	out_sz = query_ddw_out_sz(par_dn);
> > > > +
> > > > +	ret = rtas_call(ddw_avail[0], 3, out_sz, query_out,
> > > > +			cfg_addr, BUID_HI(buid), BUID_LO(buid));
> > > > +	dev_info(&dev->dev, "ibm,query-pe-dma-windows(%x) %x %x %x returned %d\n",
> > > > +		 ddw_avail[0], cfg_addr, BUID_HI(buid), BUID_LO(buid), ret);
> > > > +
> > > > +	switch (out_sz) {
> > > > +	case 5:
> > > > +		query->windows_available = query_out[0];
> > > > +		query->largest_available_block = query_out[1];
> > > > +		query->page_size = query_out[2];
> > > > +		query->migration_capable = query_out[3];
> > > > +		break;
> > > > +	case 6:
> > > > +		query->windows_available = query_out[0];
> > > > +		query->largest_available_block = ((u64)query_out[1] << 32) |
> > > > +						 query_out[2];
> > > > +		query->page_size = query_out[3];
> > > > +		query->migration_capable = query_out[4];
> > > > +		break;
> > > > +	}
> > > >  
> > > > -	ret = rtas_call(ddw_avail[0], 3, 5, (u32 *)query,
> > > > -		  cfg_addr, BUID_HI(buid), BUID_LO(buid));
> > > > -	dev_info(&dev->dev, "ibm,query-pe-dma-windows(%x) %x %x %x"
> > > > -		" returned %d\n", ddw_avail[0], cfg_addr, BUID_HI(buid),
> > > > -		BUID_LO(buid), ret);
> > > >  	return ret;
> > > >  }
> > > >  
> > > > @@ -1040,7 +1075,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
> > > >  	 * of page sizes: supported and supported for migrate-dma.
> > > >  	 */
> > > >  	dn = pci_device_to_OF_node(dev);
> > > > -	ret = query_ddw(dev, ddw_avail, &query);
> > > > +	ret = query_ddw(dev, ddw_avail, &query, pdn);
> > > >  	if (ret != 0)
> > > >  		goto out_failed;
> > > >  
> > > > @@ -1068,7 +1103,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
> > > >  	/* check largest block * page size > max memory hotplug addr */
> > > >  	max_addr = ddw_memory_hotplug_max();
> > > >  	if (query.largest_available_block < (max_addr >> page_shift)) {
> > > > -		dev_dbg(&dev->dev, "can't map partition max 0x%llx with %u "
> > > > +		dev_dbg(&dev->dev, "can't map partition max 0x%llx with %llu "
> > > >  			  "%llu-sized pages\n", max_addr,  query.largest_available_block,
> > > >  			  1ULL << page_shift);
> > > >  		goto out_failed;
> > > > 
> > 
> > Best regards,
> > Leonardo
> > 

Best regards,
Leonardo Bras

