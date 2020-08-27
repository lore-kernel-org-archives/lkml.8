Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706B8C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 441A020848
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XufHWbEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgH0WLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 18:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgH0WLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 18:11:36 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6AFC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 15:11:36 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id z3so7645153qkz.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 15:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=tckEyhhhQ7HGtoJozq598EKm+bx20MWZHeieMIF9q5g=;
        b=XufHWbEzrTArFbdd0uvm8hn5uvxsEsVAO3eGPiZJG+A34kNZEwwswC15vWvmQxWbe4
         ic9hXfr/HdobtOL/qWXE8X09cd5SECRxF7Nvhjc9tywTzsuI/kb2rK1MWcXoNC1QcTil
         rWeTMaWqvJeaMWo1xDp6qs8COZPe5OMKNxKoUO8IRfaUWqKI6XIqiR9NwFhe19yg25c0
         Dt3syjscZUmmI3s3Zf9PQFjv6C9Sd9ThAcIkQuKLYr4CeUG0ybKD0khabMM+YhyjqTtK
         GcBHW8KGgand8Vp4WWk6lOg0yUrSlCdN2L9DIi3iPHRIJcs9kGsyHJ+uYtqwT+Iht9to
         A4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=tckEyhhhQ7HGtoJozq598EKm+bx20MWZHeieMIF9q5g=;
        b=s/PQRoVfockkDGBCr4nyvgjKzhETeHXY+s0wGuQP7tXVOJhOFuP8gycYcWaBSVGR5H
         WNZo38VaQrM91o2fWeAAKL2SNkJbAnnLiKX/8wKICWvsMpZOWZjfhcJcKfA15/nDYhVF
         WWkv9RcXbU01JxO+oB9PMz1oENibhxfMhLA0TDEJS8nDPV90z0G5VyirSVBB2C2n/+uH
         xA5SDtcYFsnf9dpGDLZT+zCSyrJIm5M9DajLaj/KHlaNn0jOAmGHyqFDGRYebODQLZ6P
         lKkalth4xbqkElClTw73UTqaMSAmUrJLql0Rn7ZMnq0Q2wO07Xf3g0944hMfAMqARCRH
         CE7A==
X-Gm-Message-State: AOAM5327Y/r/mB7K0fVb1Q0veyG3Tf4KaZHdAwOntH8u8Y7EgvJ7K0om
        9XoFloEAj/jK7kuDyzQofHw=
X-Google-Smtp-Source: ABdhPJwtCZUwqtlcF8l5OmsR4/12SZH/mhBkSlTzKlRzZWsnWrsjxsA04j84C1jKbFRO0yCFcP5S1Q==
X-Received: by 2002:a37:7407:: with SMTP id p7mr21257829qkc.350.1598566295135;
        Thu, 27 Aug 2020 15:11:35 -0700 (PDT)
Received: from LeoBras ([2804:14d:8084:8e41:9b0d:571e:a65:b5d8])
        by smtp.gmail.com with ESMTPSA id x5sm2813588qtp.76.2020.08.27.15.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 15:11:34 -0700 (PDT)
Message-ID: <f80040bf941755469918fb75cf520590a4a5e3db.camel@gmail.com>
Subject: Re: [PATCH v1 06/10] powerpc/pseries/iommu: Add ddw_list_add()
 helper
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
Date:   Thu, 27 Aug 2020 19:11:28 -0300
In-Reply-To: <af4246bb-9357-098e-f167-8f30c6b893f2@ozlabs.ru>
References: <20200817234033.442511-1-leobras.c@gmail.com>
         <20200817234033.442511-7-leobras.c@gmail.com>
         <af4246bb-9357-098e-f167-8f30c6b893f2@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-24 at 13:46 +1000, Alexey Kardashevskiy wrote:
> >  static int find_existing_ddw_windows(void)
> >  {
> >  	int len;
> > @@ -887,18 +905,11 @@ static int find_existing_ddw_windows(void)
> >  		if (!direct64)
> >  			continue;
> >  
> > -		window = kzalloc(sizeof(*window), GFP_KERNEL);
> > -		if (!window || len < sizeof(struct dynamic_dma_window_prop)) {
> > +		window = ddw_list_add(pdn, direct64);
> > +		if (!window || len < sizeof(*direct64)) {
> 
> Since you are touching this code, it looks like the "len <
> sizeof(*direct64)" part should go above to "if (!direct64)".

Sure, makes sense.
It will be fixed for v2.

> 
> 
> 
> >  			kfree(window);
> >  			remove_ddw(pdn, true);
> > -			continue;
> >  		}
> > -
> > -		window->device = pdn;
> > -		window->prop = direct64;
> > -		spin_lock(&direct_window_list_lock);
> > -		list_add(&window->list, &direct_window_list);
> > -		spin_unlock(&direct_window_list_lock);
> >  	}
> >  
> >  	return 0;
> > @@ -1261,7 +1272,8 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
> >  	dev_dbg(&dev->dev, "created tce table LIOBN 0x%x for %pOF\n",
> >  		  create.liobn, dn);
> >  
> > -	window = kzalloc(sizeof(*window), GFP_KERNEL);
> > +	/* Add new window to existing DDW list */
> 
> The comment seems to duplicate what the ddw_list_add name already suggests.

Ok, I will remove it then.

> > +	window = ddw_list_add(pdn, ddwprop);
> >  	if (!window)
> >  		goto out_clear_window;
> >  
> > @@ -1280,16 +1292,14 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
> >  		goto out_free_window;
> >  	}
> >  
> > -	window->device = pdn;
> > -	window->prop = ddwprop;
> > -	spin_lock(&direct_window_list_lock);
> > -	list_add(&window->list, &direct_window_list);
> > -	spin_unlock(&direct_window_list_lock);
> 
> I'd leave these 3 lines here and in find_existing_ddw_windows() (which
> would make  ddw_list_add -> ddw_prop_alloc). In general you want to have
> less stuff to do on the failure path. kmalloc may fail and needs kfree
> but you can safely delay list_add (which cannot fail) and avoid having
> the lock help twice in the same function (one of them is hidden inside
> ddw_list_add).
> Not sure if this change is really needed after all. Thanks,

I understand this leads to better performance in case anything fails.
Also, I think list_add happening in the end is less error-prone (in
case the list is checked between list_add and a fail).

But what if we put it at the end?
What is the chance of a kzalloc of 4 pointers (struct direct_window)
failing after walk_system_ram_range?  

Is it not worthy doing that for making enable_ddw() easier to
understand?

Best regards,
Leonardo

