Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D36C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07C5D20825
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACBUpLaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgH1Tzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgH1Tze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:55:34 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F40C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:55:34 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id j10so196086qvk.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=o36Cmr3OXJRZce0uBQNiBVYMiMoOxeo0YMfigbFdEdo=;
        b=ACBUpLaE0lbdBO+MnjckyQnvzPNXul4bx+ZnJUyXquia/RquuXx0k/zhf/enUJ9TuF
         /qY8kAJksifVdcveboVRaQ4bB7cU87H+Z8fMOGqqjysDKn0UaiCYo360+ukJwBLiCtry
         E2TgQxvtgRbAMMzCPiPHE4zJai2+Nlh843HqcrSsNx8Ao1xdvq+HNzjlCQX1zS1QC/Rn
         fjIzUGGOXUWcDimqJVTUjYprlc91fINI5S4FQV7InogjGk4wJoDFz6Sb8uOH1fExbUFQ
         lgBXeQl+QPS3LeY9RajrKzrVOrtdJ5/Fi6EVn0CHAePp0We7MaqJzcfYJnlJi68l1Zs0
         PDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=o36Cmr3OXJRZce0uBQNiBVYMiMoOxeo0YMfigbFdEdo=;
        b=AykxKih54NHrbdjhDFWtkMue6iciagxgSJ8qtoKilH+OdktNf+ZEfkjeG5jv9lxt2w
         JkoQWBsRzAdWNVBFIIsXmzDl90caWEcbbKJNecJ5aTKSdpFhMo96wGJBc4ZZ/5KXbwZJ
         5o8LLvqNMisJGATuW4DYzUkEe3TQspO1uYPVmQ8JU1ONNEFCDcDhPO7t0Sh8k7vzWJd7
         DY7rjl+Mf+MXTGAVUVF0gpHbej3yPMgZkNg+fL9SldTCiUTsEP5lj6h/2piSBB9OE1el
         46j0Ty/Wqf/p41TJNYknhV+CUgahQ7Trx9O8+N3hMHcLzXvq0812IeZliUHnhD5P8qsr
         JKcQ==
X-Gm-Message-State: AOAM532PANLVo8wFr4f8HhK+EaDH5NNXUt4sPq+yPzSSf7kCy8W32k8C
        d5bLimovWqaqVPZOMDmA0nE=
X-Google-Smtp-Source: ABdhPJy+1wXwwXL37YnXQ0Wc+ya5tWXF5b4c/zouuVbAKyu5qc5wQZhg+IWmw+TtRRA9WBAGHB/F8g==
X-Received: by 2002:a05:6214:954:: with SMTP id dn20mr199304qvb.122.1598644533555;
        Fri, 28 Aug 2020 12:55:33 -0700 (PDT)
Received: from LeoBras ([2804:14d:8084:8e41:9b0d:571e:a65:b5d8])
        by smtp.gmail.com with ESMTPSA id z10sm150980qtb.17.2020.08.28.12.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 12:55:32 -0700 (PDT)
Message-ID: <93037398c7afaabc0411890998f3f29f741c8aff.camel@gmail.com>
Subject: Re: [PATCH v1 01/10] powerpc/pseries/iommu: Replace hard-coded page
 shift
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
Date:   Fri, 28 Aug 2020 16:55:25 -0300
In-Reply-To: <1e77a3d9-dff9-f58b-45be-77be7cbea41a@ozlabs.ru>
References: <20200817234033.442511-1-leobras.c@gmail.com>
         <20200817234033.442511-2-leobras.c@gmail.com>
         <6232948f-033d-8322-e656-544f12c5f784@ozlabs.ru>
         <31e913d842693b6e107cb2b8e51fd45118b1bd2c.camel@gmail.com>
         <1e77a3d9-dff9-f58b-45be-77be7cbea41a@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-08-28 at 12:27 +1000, Alexey Kardashevskiy wrote:
> 
> On 28/08/2020 01:32, Leonardo Bras wrote:
> > Hello Alexey, thank you for this feedback!
> > 
> > On Sat, 2020-08-22 at 19:33 +1000, Alexey Kardashevskiy wrote:
> > > > +#define TCE_RPN_BITS		52		/* Bits 0-51 represent RPN on TCE */
> > > 
> > > Ditch this one and use MAX_PHYSMEM_BITS instead? I am pretty sure this
> > > is the actual limit.
> > 
> > I understand this MAX_PHYSMEM_BITS(51) comes from the maximum physical memory addressable in the machine. IIUC, it means we can access physical address up to (1ul << MAX_PHYSMEM_BITS). 
> > 
> > This 52 comes from PAPR "Table 9. TCE Definition" which defines bits
> > 0-51 as the RPN. By looking at code, I understand that it means we may input any address < (1ul << 52) to TCE.
> > 
> > In practice, MAX_PHYSMEM_BITS should be enough as of today, because I suppose we can't ever pass a physical page address over 
> > (1ul << 51), and TCE accepts up to (1ul << 52).
> > But if we ever increase MAX_PHYSMEM_BITS, it doesn't necessarily means that TCE_RPN_BITS will also be increased, so I think they are independent values. 
> > 
> > Does it make sense? Please let me know if I am missing something.
> 
> The underlying hardware is PHB3/4 about which the IODA2 Version 2.4
> 6Apr2012.pdf spec says:
> 
> "The number of most significant RPN bits implemented in the TCE is
> dependent on the max size of System Memory to be supported by the platform".
> 
> IODA3 is the same on this matter.
> 
> This is MAX_PHYSMEM_BITS and PHB itself does not have any other limits
> on top of that. So the only real limit comes from MAX_PHYSMEM_BITS and
> where TCE_RPN_BITS comes from exactly - I have no idea.

Well, I created this TCE_RPN_BITS = 52 because the previous mask was a
hardcoded 40-bit mask (0xfffffffffful), for hard-coded 12-bit (4k)
pagesize, and on PAPR+/LoPAR also defines TCE as having bits 0-51
described as RPN, as described before.

IODA3 Revision 3.0_prd1 (OpenPowerFoundation), Figure 3.4 and 3.5.
shows system memory mapping into a TCE, and the TCE also has bits 0-51
for the RPN (52 bits). "Table 3.6. TCE Definition" also shows it.

In fact, by the looks of those figures, the RPN_MASK should always be a
52-bit mask, and RPN = (page >> tceshift) & RPN_MASK.

Maybe that's it?

> 
> 
> > > 
> > > > +#define TCE_RPN_MASK(ps)	((1ul << (TCE_RPN_BITS - (ps))) - 1)
> > > >  #define TCE_VALID		0x800		/* TCE valid */
> > > >  #define TCE_ALLIO		0x400		/* TCE valid for all lpars */
> > > >  #define TCE_PCI_WRITE		0x2		/* write from PCI allowed */
> > > > diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> > > > index e4198700ed1a..8fe23b7dff3a 100644
> > > > --- a/arch/powerpc/platforms/pseries/iommu.c
> > > > +++ b/arch/powerpc/platforms/pseries/iommu.c
> > > > @@ -107,6 +107,9 @@ static int tce_build_pSeries(struct iommu_table *tbl, long index,
> > > >  	u64 proto_tce;
> > > >  	__be64 *tcep;
> > > >  	u64 rpn;
> > > > +	const unsigned long tceshift = tbl->it_page_shift;
> > > > +	const unsigned long pagesize = IOMMU_PAGE_SIZE(tbl);
> > > > +	const u64 rpn_mask = TCE_RPN_MASK(tceshift);
> > > 
> > > Using IOMMU_PAGE_SIZE macro for the page size and not using
> > > IOMMU_PAGE_MASK for the mask - this incosistency makes my small brain
> > > explode :) I understand the history but maaaaan... Oh well, ok.
> > > 
> > 
> > Yeah, it feels kind of weird after two IOMMU related consts. :)
> > But sure IOMMU_PAGE_MASK() would not be useful here :)
> > 
> > And this kind of let me thinking:
> > > > +		rpn = __pa(uaddr) >> tceshift;
> > > > +		*tcep = cpu_to_be64(proto_tce | (rpn & rpn_mask) << tceshift);
> > Why not:
> > 	rpn_mask =  TCE_RPN_MASK(tceshift) << tceshift;
> 
> A mask for a page number (but not the address!) hurts my brain, masks
> are good against addresses but numbers should already have all bits
> adjusted imho, may be it is just me :-/
> 
> 
> > 	
> > 	rpn = __pa(uaddr) & rpn_mask;
> > 	*tcep = cpu_to_be64(proto_tce | rpn)
> > 
> > I am usually afraid of changing stuff like this, but I think it's safe.
> > 
> > > Good, otherwise. Thanks,
> > 
> > Thank you for reviewing!
> >  
> > 
> > 

