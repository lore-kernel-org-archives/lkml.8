Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46ECC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E14720748
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 19:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCnakP/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgGAT5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 15:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgGAT5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:57:54 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51893C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 12:57:54 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c30so19574889qka.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 12:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=P2xXya0vmfcuml5Lq07kKdDHnBOYeeXGCdjYEYzukXs=;
        b=WCnakP/Xu1KPP+ci5vTdXDmdqpN8Z/kb3IUXHmLW15aI15vSeLPGHbZj4JlNLonKWw
         hwz52bg3N0SP0ZDU1YWOKnQezOcP6DJgqMDVdZVGQbQ5kPmgq6gfPyeW6o18vUxPBye4
         sFXGY4k3zUgUftA/aBOzwm3PtEf13KeYSQJntO3+cAGEuo/vR3NK0qWqB+HxDzibnk5B
         aTNTimPuSmYf1Ct9y75ppLdvffYZevTdvqSYb3B9RYq//Lx+Ar3W9+MY14UUw0Gi3FQT
         Bwr+cggqJdbO8l3VffzPEpjNZi91Up8iZ/5i3DPzDVXfYHKqHYlgnkeYHAYlI2HN/cGM
         L5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=P2xXya0vmfcuml5Lq07kKdDHnBOYeeXGCdjYEYzukXs=;
        b=npAbtLXSRzvUXeDZOybsg4kxcDSj73Sl6pYng3peA7fn14De69nyY7qLscrGHH9115
         9QWZS5bh4S2xrxsTon4gptY0aFDU9hVgwA7vntG3rBuXsTgx1EhREp/5koYP6RryDy5O
         EaDFF2s44yjygMbX/zNmOlVVr+UDNLR3j6hJ1QWWb3qcynf6Gv5OWtYuJC15nYNrxTfj
         aixmV+5RHieX0mfUmNpnLisHH16gbHlRha7p3NK04Q4nKRZmLI2tOZXUovjP6Z9mV/Vc
         L4MQBe0EopMfGNvoYisfnA/eSTgK1WwsBeX2HCXYG1x2k+9f/VyNeU8pC2RkGdGdktYC
         jXqQ==
X-Gm-Message-State: AOAM531HFf87NI7AaTK1+OzAbJJZH1QBoVtaJqtiLoDmOIAMOo0uhB5p
        TnpzOYWswG1pX7wMTAmdm3w=
X-Google-Smtp-Source: ABdhPJz2Q1ryYJBEVe3jfg97Uhhv90ytvOvhr3w9z07qMByGII19RpkENExpkqJerQ4m1Rf9PToofA==
X-Received: by 2002:a05:620a:12fa:: with SMTP id f26mr27515688qkl.38.1593633473572;
        Wed, 01 Jul 2020 12:57:53 -0700 (PDT)
Received: from LeoBras (200-236-245-17.dynamic.desktop.com.br. [200.236.245.17])
        by smtp.gmail.com with ESMTPSA id k2sm6643807qkf.127.2020.07.01.12.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 12:57:52 -0700 (PDT)
Message-ID: <0e8bcc38614ec80c7816c07dd4dc70854c2b901d.camel@gmail.com>
Subject: Re: [PATCH v2 5/6] powerpc/pseries/iommu: Make use of DDW even if
 it does not map the partition
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 01 Jul 2020 16:57:48 -0300
In-Reply-To: <18df09c0-ef83-a0d8-1143-1cb4d50bf6b7@ozlabs.ru>
References: <20200624062411.367796-1-leobras.c@gmail.com>
         <20200624062411.367796-6-leobras.c@gmail.com>
         <18df09c0-ef83-a0d8-1143-1cb4d50bf6b7@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-01 at 18:16 +1000, Alexey Kardashevskiy wrote:
> 
> On 24/06/2020 16:24, Leonardo Bras wrote:
> > As of today, if a DDW is created and can't map the whole partition, it's
> > removed and the default DMA window "ibm,dma-window" is used instead.
> > 
> > Usually this DDW is bigger than the default DMA window, so it would be
> > better to make use of it instead.
> > 
> > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> > ---
> >  arch/powerpc/platforms/pseries/iommu.c | 28 +++++++++++++++++---------
> >  1 file changed, 19 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> > index 4fcf00016fb1..2d217cda4075 100644
> > --- a/arch/powerpc/platforms/pseries/iommu.c
> > +++ b/arch/powerpc/platforms/pseries/iommu.c
> > @@ -685,7 +685,7 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
> >  	struct iommu_table *tbl;
> >  	struct device_node *dn, *pdn;
> >  	struct pci_dn *ppci;
> > -	const __be32 *dma_window = NULL;
> > +	const __be32 *dma_window = NULL, *alt_dma_window = NULL;
> >  
> >  	dn = pci_bus_to_OF_node(bus);
> >  
> > @@ -699,8 +699,13 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
> >  			break;
> >  	}
> >  
> > +	/* If there is a DDW available, use it instead */
> > +	alt_dma_window = of_get_property(pdn, DIRECT64_PROPNAME, NULL);
> 
> It is not necessarily "direct" anymore as the name suggests, you may
> want to change that. DMA64_PROPNAME, may be. Thanks,
> 

Yeah, you are right.
I will change this for next version, also changing the string name to
reflect this.

-#define DIRECT64_PROPNAME "linux,direct64-ddr-window-info"
+#define DMA64_PROPNAME "linux,dma64-ddr-window-info"

Is that ok?

Thank you for helping!


