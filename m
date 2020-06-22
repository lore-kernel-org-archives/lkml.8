Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1C6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5906D2076E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eECU36ZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbgFVTA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730351AbgFVS7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:59:37 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17EFC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:59:37 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id r22so15046337qke.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 11:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=f4iy9Hd1w0zJAlXEFRCnJHxvinMyhXg+8Iy3wz3TXII=;
        b=eECU36ZVjZz8hZY846jkt5SJoCTI+4a8kDaC/+DEX+OfOjFg6ncgMcPhIa4GruhLg4
         BG0cLqfGfolvPcZcFYfhqxo0FMAiF/NmAK2HYMwjazdJKX/eJo5MbeANBbFofDZTb8/X
         KfLkchm/gOLRPh5Swk3bdBZJTWhq4+Nq0XQGKZtLZPWCC4ZEM2cwJ5QXjSaJ4mbqAHUR
         fL54FRINqrSwmhGbUlA+k0veRzVjSDDENfLH8KCJyeyewscnfXHU5+7gWkTOZ/ofU+Mx
         JEqK6Pk//PAeJwzG7aOPEG0TnnarSIzf0+KMcAnsPoC+Vv10k0DON44NqOTCyOb1C1SQ
         FgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=f4iy9Hd1w0zJAlXEFRCnJHxvinMyhXg+8Iy3wz3TXII=;
        b=FCJcClbF64CKPCN+Kr4JPmaZuoS1Es/cySfqgMtov4dhHmlevWbWzDgjiHpvkJK5Bk
         86UPnhGG6jQgQBuWrP76CBWw5Wq1Tt72JJ5tUqo+xIZARWaenmaz4hG8MvW5Iyv9LkSs
         ZHLCObfMcfH9PW0AQJVsGCMrZrPvw9ChSSzCxrtnBq49MJxN23K2ZUarzW4X+7K+4fBr
         xlZEBrBUCVNQloIy7BgDzG56bDMKfZl31MN0VKvcDp+cIElEXZzx2OmY7C9pDrGOb1gd
         /xfamCCCKQoHwVj/yGp/wAmWT3mOmdm2rF2y3Vw4Aj7nsEPIuSHWHWTvXa3oFdy0Kq/G
         SWuA==
X-Gm-Message-State: AOAM532JtOM51nILnTxfeXJGWX9d6DEQKgNADBFyNNsgtUmFTMiCUAjx
        H5SwnUU94ejCW291FihMaHY=
X-Google-Smtp-Source: ABdhPJzzoWaREA/uNfK0f9aPzY48EBbv95gn9nHTvdkd33MN1QQwXKfRvdvvVRCYJRObdZRJCWK7aQ==
X-Received: by 2002:a05:620a:788:: with SMTP id 8mr7327048qka.127.1592852376858;
        Mon, 22 Jun 2020 11:59:36 -0700 (PDT)
Received: from LeoBras (177-131-65-187.dynamic.desktop.com.br. [177.131.65.187])
        by smtp.gmail.com with ESMTPSA id i14sm13900216qkl.105.2020.06.22.11.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 11:59:36 -0700 (PDT)
Message-ID: <ccf7b591f2bf61ba4705699b2e2b050c3cf48d99.camel@gmail.com>
Subject: Re: [PATCH 3/4] powerpc/pseries/iommu: Move window-removing part of
 remove_ddw into remove_dma_window
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Mon, 22 Jun 2020 15:59:14 -0300
In-Reply-To: <51201582-efe5-85df-7e65-a998e91ab63f@ozlabs.ru>
References: <20200619050619.266888-1-leobras.c@gmail.com>
         <20200619050619.266888-4-leobras.c@gmail.com>
         <51201582-efe5-85df-7e65-a998e91ab63f@ozlabs.ru>
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
> > Move the window-removing part of remove_ddw into a new function
> > (remove_dma_window), so it can be used to remove other DMA windows.
> > 
> > It's useful for removing DMA windows that don't create DIRECT64_PROPNAME
> > property, like the default DMA window from the device, which uses
> > "ibm,dma-window".
> > 
> > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> > ---
> >  arch/powerpc/platforms/pseries/iommu.c | 53 +++++++++++++++-----------
> >  1 file changed, 31 insertions(+), 22 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> > index 5e1fbc176a37..de633f6ae093 100644
> > --- a/arch/powerpc/platforms/pseries/iommu.c
> > +++ b/arch/powerpc/platforms/pseries/iommu.c
> > @@ -767,25 +767,14 @@ static int __init disable_ddw_setup(char *str)
> >  
> >  early_param("disable_ddw", disable_ddw_setup);
> >  
> > -static void remove_ddw(struct device_node *np, bool remove_prop)
> > +static void remove_dma_window(struct device_node *pdn, u32 *ddw_avail,
> 
> You do not need the entire ddw_avail here, pass just the token you need.

Well, I just emulated the behavior of create_ddw() and query_ddw() as
both just pass the array instead of the token, even though they only
use a single token. 

I think it's to make the rest of the code independent of the design of
the "ibm,ddw-applicable" array, and if it changes, only local changes
on the functions will be needed.

> Also, despite this particular file, the "pdn" name is usually used for
> struct pci_dn (not device_node), let's keep it that way.

Sure, I got confused for some time about this, as we have:
static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn).
but on *_ddw() we have "struct pci_dn *pdn".

I will also add a patch that renames those 'struct device_node *pdn' to
something like 'struct device_node *parent_dn'.

> > +			      struct property *win)
> >  {
> >  	struct dynamic_dma_window_prop *dwp;
> > -	struct property *win64;
> > -	u32 ddw_avail[3];
> >  	u64 liobn;
> > -	int ret = 0;
> > -
> > -	ret = of_property_read_u32_array(np, "ibm,ddw-applicable",
> > -					 &ddw_avail[0], 3);
> > -
> > -	win64 = of_find_property(np, DIRECT64_PROPNAME, NULL);
> > -	if (!win64)
> > -		return;
> > -
> > -	if (ret || win64->length < sizeof(*dwp))
> > -		goto delprop;
> > +	int ret;
> >  
> > -	dwp = win64->value;
> > +	dwp = win->value;
> >  	liobn = (u64)be32_to_cpu(dwp->liobn);
> >  
> >  	/* clear the whole window, note the arg is in kernel pages */
> > @@ -793,24 +782,44 @@ static void remove_ddw(struct device_node *np, bool remove_prop)
> >  		1ULL << (be32_to_cpu(dwp->window_shift) - PAGE_SHIFT), dwp);
> >  	if (ret)
> >  		pr_warn("%pOF failed to clear tces in window.\n",
> > -			np);
> > +			pdn);
> >  	else
> >  		pr_debug("%pOF successfully cleared tces in window.\n",
> > -			 np);
> > +			 pdn);
> >  
> >  	ret = rtas_call(ddw_avail[2], 1, 1, NULL, liobn);
> >  	if (ret)
> >  		pr_warn("%pOF: failed to remove direct window: rtas returned "
> >  			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
> > -			np, ret, ddw_avail[2], liobn);
> > +			pdn, ret, ddw_avail[2], liobn);
> >  	else
> >  		pr_debug("%pOF: successfully removed direct window: rtas returned "
> >  			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
> > -			np, ret, ddw_avail[2], liobn);
> > +			pdn, ret, ddw_avail[2], liobn);
> > +}
> > +
> > +static void remove_ddw(struct device_node *np, bool remove_prop)
> > +{
> > +	struct property *win;
> > +	u32 ddw_avail[3];
> > +	int ret = 0;
> > +
> > +	ret = of_property_read_u32_array(np, "ibm,ddw-applicable",
> > +					 &ddw_avail[0], 3);
> > +	if (ret)
> > +		return;
> > +
> > +	win = of_find_property(np, DIRECT64_PROPNAME, NULL);
> > +	if (!win)
> > +		return;
> > +
> > +	if (win->length >= sizeof(struct dynamic_dma_window_prop))
> 
> Any good reason not to make it "=="? Is there something optional or we
> expect extension (which may not grow from the end but may add cells in
> between). Thanks,

Well, it comes from the old behavior of remove_ddw():
-	if (ret || win64->length < sizeof(*dwp))
-		goto delprop;

As I reversed the logic from 'if (test) go out' to 'if (!test) do
stuff', I also reversed (a < b) to !(a < b) => (a >= b).

I have no problem changing that to '==', but it will produce a
different behavior than before. 

> 
> 
> > +		remove_dma_window(np, ddw_avail, win);
> > +
> > +	if (!remove_prop)
> > +		return;
> >  
> > -delprop:
> > -	if (remove_prop)
> > -		ret = of_remove_property(np, win64);
> > +	ret = of_remove_property(np, win);
> >  	if (ret)
> >  		pr_warn("%pOF: failed to remove direct window property: %d\n",
> >  			np, ret);
> > 

Best regards,
Leonardo

