Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CA2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4348F206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHH/n4Wq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731439AbgFWCXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730766AbgFWCXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:23:08 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DE3C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 19:23:06 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id e11so8271047qkm.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 19:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=6zL7pHAEzMEG/c09VqjrAQyA7FSL2PXyExlQIJ6f9QE=;
        b=hHH/n4Wqz4Ik3r4/K77lSSSSQlTfW2cRQbY/9pxkS1SA3OSaJhiAF0Xz4UEcINlwhq
         t5Vi3fQtfno+5dU6NWHG1lnaJbYD9aZtG6+prhschGLjETvp9rSP7X2AcGEETyeCdnTT
         cY45QYJ/ohLz76+e2+XXtQugt3VkRVf9ZNJ2Nczia4XnNV9Cdivv5AaU84illzLR4tQr
         MTO2ylOXVuoD4q95rPssEBn3daaHmsVQqWpva5BLFqtiok9NncCZGt8DD5/3xEF6B4mu
         YJpjMAZ01aGp54dx/aRu1DwFw4m2u7QaWaBkPwpoZHGgGnvErjL0D2oeqoayLuJcVeq0
         fI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=6zL7pHAEzMEG/c09VqjrAQyA7FSL2PXyExlQIJ6f9QE=;
        b=Y3P37sLFvRmVjjJIkkYP+tIpWEnsFf7utsmpm2WGKzSEw5pSXndv9m5LKh1m61vzVw
         himjXrTKPUh6i818BDOYE93F90tvQBJFxE7cumlKZhWwb9/ACXd3DIJLmRUCCW1WymyJ
         v2yl6X2v10FEVxjinrjU0mwNORhItBncVBMmJYuSG/7YvYaHajbM1bceMoa3Pxjlk+2k
         7B0iZIcTJhpUgDec9aCJ/Po7TdQU+x2zyylz4+uharCOqxvcL+JE3KZznUWDlI3x7Xb8
         mkZYS/NVviFyJLTGEWTbLiT4XxuO4H9InF4lngKglUehUltwyTPJRYJ5XKPsZlZp+XZC
         kZfw==
X-Gm-Message-State: AOAM532cA8SAtgE0Khw47dt5FuQKzKzRjyop6Fz0y4baHmmuSbkCUgHI
        ljfeGQnrlQ+WO1B8tPEmCsw=
X-Google-Smtp-Source: ABdhPJyiG7xYSaNSc7EOcWxbon3GIxU74JYJWYppFrKiKZaGztsf206E68h72ctJGP3+BzalrPdMlQ==
X-Received: by 2002:a37:668d:: with SMTP id a135mr17765301qkc.131.1592878985865;
        Mon, 22 Jun 2020 19:23:05 -0700 (PDT)
Received: from LeoBras (177-131-65-187.dynamic.desktop.com.br. [177.131.65.187])
        by smtp.gmail.com with ESMTPSA id 23sm1879040qkl.52.2020.06.22.19.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 19:23:05 -0700 (PDT)
Message-ID: <75e1ece8d8e59322fdc70a32cc3888ce45ffbd56.camel@gmail.com>
Subject: Re: [PATCH 3/4] powerpc/pseries/iommu: Move window-removing part of
 remove_ddw into remove_dma_window
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Oliver <oohall@gmail.com>
Date:   Mon, 22 Jun 2020 23:22:50 -0300
In-Reply-To: <887bf30e-ae9e-b0cb-0388-dc555692ff0a@ozlabs.ru>
References: <20200619050619.266888-1-leobras.c@gmail.com>
         <20200619050619.266888-4-leobras.c@gmail.com>
         <51201582-efe5-85df-7e65-a998e91ab63f@ozlabs.ru>
         <ccf7b591f2bf61ba4705699b2e2b050c3cf48d99.camel@gmail.com>
         <887bf30e-ae9e-b0cb-0388-dc555692ff0a@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-23 at 11:12 +1000, Alexey Kardashevskiy wrote:
> 
> On 23/06/2020 04:59, Leonardo Bras wrote:
> > Hello Alexey, thanks for the feedback!
> > 
> > On Mon, 2020-06-22 at 20:02 +1000, Alexey Kardashevskiy wrote:
> > > On 19/06/2020 15:06, Leonardo Bras wrote:
> > > > Move the window-removing part of remove_ddw into a new function
> > > > (remove_dma_window), so it can be used to remove other DMA windows.
> > > > 
> > > > It's useful for removing DMA windows that don't create DIRECT64_PROPNAME
> > > > property, like the default DMA window from the device, which uses
> > > > "ibm,dma-window".
> > > > 
> > > > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> > > > ---
> > > >  arch/powerpc/platforms/pseries/iommu.c | 53 +++++++++++++++-----------
> > > >  1 file changed, 31 insertions(+), 22 deletions(-)
> > > > 
> > > > diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> > > > index 5e1fbc176a37..de633f6ae093 100644
> > > > --- a/arch/powerpc/platforms/pseries/iommu.c
> > > > +++ b/arch/powerpc/platforms/pseries/iommu.c
> > > > @@ -767,25 +767,14 @@ static int __init disable_ddw_setup(char *str)
> > > >  
> > > >  early_param("disable_ddw", disable_ddw_setup);
> > > >  
> > > > -static void remove_ddw(struct device_node *np, bool remove_prop)
> > > > +static void remove_dma_window(struct device_node *pdn, u32 *ddw_avail,
> > > 
> > > You do not need the entire ddw_avail here, pass just the token you need.
> > 
> > Well, I just emulated the behavior of create_ddw() and query_ddw() as
> > both just pass the array instead of the token, even though they only
> > use a single token. 
> 
> True, there is a pattern.
> 
> > I think it's to make the rest of the code independent of the design of
> > the "ibm,ddw-applicable" array, and if it changes, only local changes
> > on the functions will be needed.
> 
> The helper removes a window, if you are going to call other operations
> in remove_dma_window(), then you'll have to change its name ;)

Not only doing new stuff, it can change the order for some reason (as
the order of the output of query), and it would need not change the
caller.

> 
> 
> > > Also, despite this particular file, the "pdn" name is usually used for
> > > struct pci_dn (not device_node), let's keep it that way.
> > 
> > Sure, I got confused for some time about this, as we have:
> > static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn).
> > but on *_ddw() we have "struct pci_dn *pdn".
> 
> True again, not the cleanest style here.
> 
> 
> > I will also add a patch that renames those 'struct device_node *pdn' to
> > something like 'struct device_node *parent_dn'.
> 
> I would not go that far, we (well, Oliver) are getting rid of many
> occurrences of pci_dn and Oliver may have a stronger opinion here.
> 
> 
> > > > +			      struct property *win)
> > > >  {
> > > >  	struct dynamic_dma_window_prop *dwp;
> > > > -	struct property *win64;
> > > > -	u32 ddw_avail[3];
> > > >  	u64 liobn;
> > > > -	int ret = 0;
> > > > -
> > > > -	ret = of_property_read_u32_array(np, "ibm,ddw-applicable",
> > > > -					 &ddw_avail[0], 3);
> > > > -
> > > > -	win64 = of_find_property(np, DIRECT64_PROPNAME, NULL);
> > > > -	if (!win64)
> > > > -		return;
> > > > -
> > > > -	if (ret || win64->length < sizeof(*dwp))
> > > > -		goto delprop;
> > > > +	int ret;
> > > >  
> > > > -	dwp = win64->value;
> > > > +	dwp = win->value;
> > > >  	liobn = (u64)be32_to_cpu(dwp->liobn);
> > > >  
> > > >  	/* clear the whole window, note the arg is in kernel pages */
> > > > @@ -793,24 +782,44 @@ static void remove_ddw(struct device_node *np, bool remove_prop)
> > > >  		1ULL << (be32_to_cpu(dwp->window_shift) - PAGE_SHIFT), dwp);
> > > >  	if (ret)
> > > >  		pr_warn("%pOF failed to clear tces in window.\n",
> > > > -			np);
> > > > +			pdn);
> > > >  	else
> > > >  		pr_debug("%pOF successfully cleared tces in window.\n",
> > > > -			 np);
> > > > +			 pdn);
> > > >  
> > > >  	ret = rtas_call(ddw_avail[2], 1, 1, NULL, liobn);
> > > >  	if (ret)
> > > >  		pr_warn("%pOF: failed to remove direct window: rtas returned "
> > > >  			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
> > > > -			np, ret, ddw_avail[2], liobn);
> > > > +			pdn, ret, ddw_avail[2], liobn);
> > > >  	else
> > > >  		pr_debug("%pOF: successfully removed direct window: rtas returned "
> > > >  			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
> > > > -			np, ret, ddw_avail[2], liobn);
> > > > +			pdn, ret, ddw_avail[2], liobn);
> > > > +}
> > > > +
> > > > +static void remove_ddw(struct device_node *np, bool remove_prop)
> > > > +{
> > > > +	struct property *win;
> > > > +	u32 ddw_avail[3];
> > > > +	int ret = 0;
> > > > +
> > > > +	ret = of_property_read_u32_array(np, "ibm,ddw-applicable",
> > > > +					 &ddw_avail[0], 3);
> > > > +	if (ret)
> > > > +		return;
> > > > +
> > > > +	win = of_find_property(np, DIRECT64_PROPNAME, NULL);
> > > > +	if (!win)
> > > > +		return;
> > > > +
> > > > +	if (win->length >= sizeof(struct dynamic_dma_window_prop))
> > > 
> > > Any good reason not to make it "=="? Is there something optional or we
> > > expect extension (which may not grow from the end but may add cells in
> > > between). Thanks,
> > 
> > Well, it comes from the old behavior of remove_ddw():
> > -	if (ret || win64->length < sizeof(*dwp))
> > -		goto delprop;
> > As I reversed the logic from 'if (test) go out' to 'if (!test) do
> > stuff', I also reversed (a < b) to !(a < b) => (a >= b).
> > 
> > I have no problem changing that to '==', but it will produce a
> > different behavior than before. 
> 
> I missed than, never mind then.
> 
> 
> > > 
> > > > +		remove_dma_window(np, ddw_avail, win);
> > > > +
> > > > +	if (!remove_prop)
> > > > +		return;
> > > >  
> > > > -delprop:
> > > > -	if (remove_prop)
> > > > -		ret = of_remove_property(np, win64);
> > > > +	ret = of_remove_property(np, win);
> > > >  	if (ret)
> > > >  		pr_warn("%pOF: failed to remove direct window property: %d\n",
> > > >  			np, ret);
> > > > 
> > 
> > Best regards,
> > Leonardo
> > 

