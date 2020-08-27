Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40903C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 21:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE2A620825
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 21:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nE4no8bO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgH0VYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 17:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgH0VYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 17:24:08 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB50C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 14:24:08 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z2so1804318qtv.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 14:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=MVC75WhA7d+0oDQazfX2DGa6cSUtXkIL8si5LFw8QKo=;
        b=nE4no8bOYuNaI5l9TjJ+/StsPJHYNmB5V/L+olDFa1PVPA7CS6C3e0hRxqk8ekmyf2
         wM+xTgli8KOZ7u4BtEI/0+bMj2IEG6DOUpfI9ixOqMmH2Z7j3d8M8zSBU/6brb6Yc9ck
         DeVirLgs0ikpFF+uYb326kItTsvAUTWiHOjNKXB9y+vwfo+ik4N16fAQ74H4RfcT5DJ4
         ry45RgjADUO7zljmmW743bRbLkCjlE8nZBpDYkzEGXrHJy6bTrCwaGCrfKTCJPoENv8t
         rvzm8S2d+o5mIyNPpHScJAS9ASCyi+voRmangDBQgBMftLlNoNeZOpAgNMP56BcEAoni
         c6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=MVC75WhA7d+0oDQazfX2DGa6cSUtXkIL8si5LFw8QKo=;
        b=eTqAiiZSqQ6ohRkESKHN/fTnWsY/+QGmrJW+ddzqJRa7QDOxdWXoMGb3qdxz0et8oC
         cBry8I6q1ErmP4vVeYR3bT9s7IvIAw3ItwPFn+xN6v9NiatjKN1jmLqJQ3KSFLSUIa+5
         240Pvd1Pg0xqRmm6J6hlRWJfbL5uofEBd9SgOICWS7473xOF0TWucEFquINWoPv7M89S
         oAtPkrN2hwgQaN+ggcarXg5F/Zl16GYE7K/tV612R43WnkyceHQy+O1R0Bvzz8Nox1U0
         qtCL/2776GaAYuZaYjWDJmC/TNYAb1t8LlsgPlz1yA5ibML/q+XYRy1zk/AMAkscPvMj
         uLyg==
X-Gm-Message-State: AOAM532Tq2X2iRGBv58BR/WxE7n43/B99AD/lXALStKbgSWiVXT8MP9k
        nU0uzqy2lL2DjOT6oG3iTXM=
X-Google-Smtp-Source: ABdhPJye21DrpNVQ72mgNG9+VcshecC/+jLXcFU32/VkAcT9ulqX6b5xuxHB/dXaesYuiXTDwU1ViA==
X-Received: by 2002:ac8:66d3:: with SMTP id m19mr21062282qtp.276.1598563447427;
        Thu, 27 Aug 2020 14:24:07 -0700 (PDT)
Received: from LeoBras ([2804:14d:8084:8e41:9b0d:571e:a65:b5d8])
        by smtp.gmail.com with ESMTPSA id u41sm3022336qth.42.2020.08.27.14.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 14:24:06 -0700 (PDT)
Message-ID: <e06630576e199db4e93d64b55e565eff8456a2e4.camel@gmail.com>
Subject: Re: [PATCH v1 05/10] powerpc/pseries/iommu: Add
 iommu_pseries_alloc_table() helper
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
Date:   Thu, 27 Aug 2020 18:23:59 -0300
In-Reply-To: <e4ea6264-578d-f8ea-a0c4-3b279b5c0411@ozlabs.ru>
References: <20200817234033.442511-1-leobras.c@gmail.com>
         <20200817234033.442511-6-leobras.c@gmail.com>
         <e4ea6264-578d-f8ea-a0c4-3b279b5c0411@ozlabs.ru>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-24 at 10:38 +1000, Alexey Kardashevskiy wrote:
> 
> On 18/08/2020 09:40, Leonardo Bras wrote:
> > Creates a helper to allow allocating a new iommu_table without the need
> > to reallocate the iommu_group.
> > 
> > This will be helpful for replacing the iommu_table for the new DMA window,
> > after we remove the old one with iommu_tce_table_put().
> > 
> > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> > ---
> >  arch/powerpc/platforms/pseries/iommu.c | 25 ++++++++++++++-----------
> >  1 file changed, 14 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> > index 8fe23b7dff3a..39617ce0ec83 100644
> > --- a/arch/powerpc/platforms/pseries/iommu.c
> > +++ b/arch/powerpc/platforms/pseries/iommu.c
> > @@ -53,28 +53,31 @@ enum {
> >  	DDW_EXT_QUERY_OUT_SIZE = 2
> >  };
> >  
> > -static struct iommu_table_group *iommu_pseries_alloc_group(int node)
> > +static struct iommu_table *iommu_pseries_alloc_table(int node)
> >  {
> > -	struct iommu_table_group *table_group;
> >  	struct iommu_table *tbl;
> >  
> > -	table_group = kzalloc_node(sizeof(struct iommu_table_group), GFP_KERNEL,
> > -			   node);
> > -	if (!table_group)
> > -		return NULL;
> > -
> >  	tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL, node);
> >  	if (!tbl)
> > -		goto free_group;
> > +		return NULL;
> >  
> >  	INIT_LIST_HEAD_RCU(&tbl->it_group_list);
> >  	kref_init(&tbl->it_kref);
> > +	return tbl;
> > +}
> >  
> > -	table_group->tables[0] = tbl;
> > +static struct iommu_table_group *iommu_pseries_alloc_group(int node)
> > +{
> > +	struct iommu_table_group *table_group;
> > +
> > +	table_group = kzalloc_node(sizeof(*table_group), GFP_KERNEL, node);
> 
> I'd prefer you did not make unrelated changes (sizeof(struct
> iommu_table_group) -> sizeof(*table_group)) so the diff stays shorter
> and easier to follow. You changed  sizeof(struct iommu_table_group) but
> not sizeof(struct iommu_table) and this confused me enough to spend more
> time than this straight forward change deserves.

Sorry, I will keep this in mind for future patches.
Thank you for the tip!

> 
> Not important in this case though so
> 
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Thank you!


