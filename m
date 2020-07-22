Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D356C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E40F720825
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4mTuqY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgGVXpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 19:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgGVXpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 19:45:34 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B8FC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 16:45:34 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id h7so3773851qkk.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 16:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=KHh56+Ss89jHm1k4aVhgmUHFFsDiPlnWkvKWi9iX6pg=;
        b=S4mTuqY5ZfXbI6vRCYpIJN+S8F0EEPCbqlyhUN0hXe3ucCH821MMzmy07dEI8JA7lB
         Kwe00d9AaTmbl5kdndQ9IrBxglWH5c3dbi55hYk3YS9Qr3PG4Mql3fjQTVZ9CxQJHGd7
         wb3VcwywfUeVjUzbdHUKI8pWPW/QTpkEDKBZ/MuSqfTSG2/vXF0FG2+5yiAIl0up/O3n
         UH4GaNc+eDFOJ4H8oEluqdyNalw619axyA0Ii2wksSNUlVR7XKw2LUXDsfpXAUqnkNpt
         5UnDLWZfzRppcO97JwnPxF2pQz6aWLKu09FIu9B65mmmFz3pWCKPxTMFj4GrLvbafjJk
         DfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=KHh56+Ss89jHm1k4aVhgmUHFFsDiPlnWkvKWi9iX6pg=;
        b=QZ0KMmx+AjZO/UwRfHLgpjsLmgVH64xGrZrHYYhClFu35Rfd67DI+4o8fGi8qVO4F/
         prbEHVlpRFAc37h6NsRQaLeYt8ZXJkbzzuwE6QmSek9LBClCe8WJrYDpaW1SbMUSr2Io
         z+G7yP1TlsW90CZGbbMxAF/ll8xyEC252mJTKcUi2trz38oO6Shphn8cub/M7kfn4Xv3
         rSLLPQ29DUmttcoOH9fSStowcI7GXcp76rFgUrnHHCb5iipN1LEg4VQxVTgH6b6SgyGu
         URe+DGSQxeudBoChIPh/3F+jfqVa6rZfM4mNwFPl3T+fib3BG4CN67p276yY4h1hukKM
         z8bA==
X-Gm-Message-State: AOAM5316zxjLPsYQb8C55ea7+Y4FX2gprdxsk2EfZHWzI1Sqbc8lnN1E
        lcPo4qhohXFCgy8iCKbIMHg=
X-Google-Smtp-Source: ABdhPJzCPLel4ripFzhP8OQSnx1WFD+US06BMXUjgjaCvklZoAhyPyRzjZc6/odiBunqfRfCpZQj7w==
X-Received: by 2002:a37:8746:: with SMTP id j67mr2360874qkd.405.1595461533312;
        Wed, 22 Jul 2020 16:45:33 -0700 (PDT)
Received: from LeoBras (179-125-153-225.dynamic.desktop.com.br. [179.125.153.225])
        by smtp.gmail.com with ESMTPSA id p34sm973735qtd.56.2020.07.22.16.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 16:45:32 -0700 (PDT)
Message-ID: <e23c8ffd6667e675ab80c83c39f8b91beb591328.camel@gmail.com>
Subject: Re: [PATCH v4 5/7] powerpc/iommu: Move iommu_table cleaning routine
 to iommu_table_clean
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Brian King <brking@linux.vnet.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 22 Jul 2020 20:45:25 -0300
In-Reply-To: <d6078fce-bb5f-f829-5de2-5bce3cee2bd5@linux.vnet.ibm.com>
References: <20200716071658.467820-1-leobras.c@gmail.com>
         <20200716071658.467820-6-leobras.c@gmail.com>
         <51235292-a571-8792-c693-d0dc6faeb21c@ozlabs.ru>
         <0f4c2d84d0958e98e7ada53c25750fe548cadf0b.camel@gmail.com>
         <d6078fce-bb5f-f829-5de2-5bce3cee2bd5@linux.vnet.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-21 at 19:52 -0500, Brian King wrote:
> > 
> > As of today, there seems to be nothing like that happening in the
> > driver I am testing. 
> > I spoke to Brian King on slack, and he mentioned that at the point DDW
> > is created there should be no allocations in place.
> 
> I think there are a couple of scenarios here. One is where there is a DMA
> allocation prior to a call to set the DMA mask. Second scenario is if the
> driver makes multiple calls to set the DMA mask. I would argue that a properly
> written driver should tell the IOMMU subsystem what DMA mask it supports prior
> to allocating DMA memroy. Documentation/core-api/dma-api-howto.rst should
> describe what is legal and what is not.
> 
> It might be reasonable to declare its not allowed to allocate DMA memory
> and then later change the DMA mask and clearly call this out in the documentation
> if its not already.
> 
> -Brian

Thank you for the feedback Brian!

That makes sense to me. I will try to have this in mind for the next
patchset. 

Best regards,

