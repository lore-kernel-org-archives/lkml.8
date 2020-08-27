Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F32C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0C0122B40
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYWdIOg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgH0PdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgH0PdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:33:09 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2EFC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 08:33:08 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id 60so880605qtc.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 08:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=E5IRRkGc1AhclJ6Um81LWbYPnMwL582+X2bSm2+mckg=;
        b=CYWdIOg31Ru+q3WsqzZ+IiG0IABWdiaweROVTwUnjSI44Nde6JFWxpzz9KOgGfQbI+
         uFSRPr+0q/8jTcCE4fl7mKZuk8r/5CSX97kao5FEfvSW7oZ1vekVrnFTnSCX32Nbuue4
         UYg63Oq5gsgHCegmefJeP9b4mqLwjXtOpHOLuXrB1TXg/nE1DbDsnOMj7VT9TM39wLGi
         gDdO0Vxl+4h8IpmS7GESBpUFvXaDaYIypqBgFtffwj5fHc4ObW3krjAv+pCgYgYRraVH
         pCHsJTopEHecs7Xvb4483qGigoSNqUWmnCkxzHskXpF7UhAcZ7GSZzkUEeOVMLSx7NEW
         pOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=E5IRRkGc1AhclJ6Um81LWbYPnMwL582+X2bSm2+mckg=;
        b=uJYq+g2+TfajoaAc3YrcgIoR4MLpHDiaF8coGi0vkgUWJQ+qSQkYQKAtlksg4ORPh/
         E/itSYcMp3ZZm/W+2fUl9IMA2gZ45RuL4houeyrPGbb/r3IHeDmIDhKl1s1j1Ww0C8c3
         i40CJydAKEici+4t1r76B1Q62Z6kGn46l+biX+OJ96j8aMGattLLd84/Qfu37KVVOZaX
         2L53+fU0XXibZTRgODp2QIKvBmA5W5efFEEut7OHBo7bZtTh0/LEexi/SUHuCz07ewJS
         b2PyR5OKch/yPOkpnoJrX4R5sy8cG85vERDDAvL46wDv/G5NgQS54b8+3TYWSbZXtJ5V
         Y7Lg==
X-Gm-Message-State: AOAM5330hkcJ5wfecuBObcIRxTLCBhUV59Zck0V+WaO2116jGnr1eowq
        a2co8ZotiDx+bcX9dmzu+YA=
X-Google-Smtp-Source: ABdhPJxQOy8z2tpz1ix5dHQc5fNnoO5W3POhV+lw0/IW1KMQm/iA/K4WQYEcLQkVmx48Q14mGSDYGw==
X-Received: by 2002:ac8:550f:: with SMTP id j15mr19283657qtq.26.1598542385460;
        Thu, 27 Aug 2020 08:33:05 -0700 (PDT)
Received: from LeoBras ([2804:14d:8084:8e41:9b0d:571e:a65:b5d8])
        by smtp.gmail.com with ESMTPSA id t11sm270862qtp.32.2020.08.27.08.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 08:33:04 -0700 (PDT)
Message-ID: <31e913d842693b6e107cb2b8e51fd45118b1bd2c.camel@gmail.com>
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
Date:   Thu, 27 Aug 2020 12:32:57 -0300
In-Reply-To: <6232948f-033d-8322-e656-544f12c5f784@ozlabs.ru>
References: <20200817234033.442511-1-leobras.c@gmail.com>
         <20200817234033.442511-2-leobras.c@gmail.com>
         <6232948f-033d-8322-e656-544f12c5f784@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexey, thank you for this feedback!

On Sat, 2020-08-22 at 19:33 +1000, Alexey Kardashevskiy wrote:
> > +#define TCE_RPN_BITS		52		/* Bits 0-51 represent RPN on TCE */
> 
> Ditch this one and use MAX_PHYSMEM_BITS instead? I am pretty sure this
> is the actual limit.

I understand this MAX_PHYSMEM_BITS(51) comes from the maximum physical memory addressable in the machine. IIUC, it means we can access physical address up to (1ul << MAX_PHYSMEM_BITS). 

This 52 comes from PAPR "Table 9. TCE Definition" which defines bits
0-51 as the RPN. By looking at code, I understand that it means we may input any address < (1ul << 52) to TCE.

In practice, MAX_PHYSMEM_BITS should be enough as of today, because I suppose we can't ever pass a physical page address over 
(1ul << 51), and TCE accepts up to (1ul << 52).
But if we ever increase MAX_PHYSMEM_BITS, it doesn't necessarily means that TCE_RPN_BITS will also be increased, so I think they are independent values. 

Does it make sense? Please let me know if I am missing something.

> 
> 
> > +#define TCE_RPN_MASK(ps)	((1ul << (TCE_RPN_BITS - (ps))) - 1)
> >  #define TCE_VALID		0x800		/* TCE valid */
> >  #define TCE_ALLIO		0x400		/* TCE valid for all lpars */
> >  #define TCE_PCI_WRITE		0x2		/* write from PCI allowed */
> > diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> > index e4198700ed1a..8fe23b7dff3a 100644
> > --- a/arch/powerpc/platforms/pseries/iommu.c
> > +++ b/arch/powerpc/platforms/pseries/iommu.c
> > @@ -107,6 +107,9 @@ static int tce_build_pSeries(struct iommu_table *tbl, long index,
> >  	u64 proto_tce;
> >  	__be64 *tcep;
> >  	u64 rpn;
> > +	const unsigned long tceshift = tbl->it_page_shift;
> > +	const unsigned long pagesize = IOMMU_PAGE_SIZE(tbl);
> > +	const u64 rpn_mask = TCE_RPN_MASK(tceshift);
> 
> Using IOMMU_PAGE_SIZE macro for the page size and not using
> IOMMU_PAGE_MASK for the mask - this incosistency makes my small brain
> explode :) I understand the history but maaaaan... Oh well, ok.
> 

Yeah, it feels kind of weird after two IOMMU related consts. :)
But sure IOMMU_PAGE_MASK() would not be useful here :)

And this kind of let me thinking:
> > +		rpn = __pa(uaddr) >> tceshift;
> > +		*tcep = cpu_to_be64(proto_tce | (rpn & rpn_mask) << tceshift);
Why not:
	rpn_mask =  TCE_RPN_MASK(tceshift) << tceshift;
	
	rpn = __pa(uaddr) & rpn_mask;
	*tcep = cpu_to_be64(proto_tce | rpn)

I am usually afraid of changing stuff like this, but I think it's safe.

> Good, otherwise. Thanks,

Thank you for reviewing!
 


