Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FE3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC9D20729
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/SFUi7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731274AbgGUVjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgGUVjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:39:48 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA97C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:39:48 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x62so338925qtd.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=f6dpuk5+La18ZWVO5+si7DCz5e38PY6ivAQLVNSBqmA=;
        b=U/SFUi7id/t/LHsdzY311skIWx53KxIcsw3dbIbaHD6SVpNfo44ZLLR63YgmWd7Veu
         NQ33Tu4Gx8i6gjr6No04I0N+EbNgp8JXEwUhwt9VLA6HjCnYN3HVyXcd+ZOoWoA2mFLm
         5gl8zp/L7yJuzZnu3upL2YYoig+gcHAZLQ3X/EqqUMdYUCgyTHimHbLcfCuTAdBfZk1r
         pfsvxJ2FRig3QL4rxWVQuNmXf84xJ7o3ES5jNNeBlISg2JW/hgHyVxgz4gtrV6eZlglB
         atchVAtCg8EvawE6CFfGl+nH43F6AyyTgG+CjspWNk+Ulhf3OwvkZL2QuoPhGu7ISFQG
         pdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=f6dpuk5+La18ZWVO5+si7DCz5e38PY6ivAQLVNSBqmA=;
        b=FStAcR/dr1kyhMxrYELf3OBre0+H+S0GlZzueeziEfPoQH68SVrUlt1sUyLtFtw8XD
         /o8XUGtQjLS4f7E+29y4smTUpxmxFon48zOuB44D8OZjUkuTT6PEFPJixEhNYoK/ARrO
         MyBkvU+Gl+vuUlXPycFt05M5lWvFzevLVaq5ViTAGEw66HbVhMIGLyJB9ZzSfVgI2A6O
         3fj4UB93o+sYj5kT5aaw4XCN3j0qa9+PK57N4DEsmPMVYOiRv9i1oQadWQnyzSnxwuab
         STZ3pMoISoPxysUT9jMBuq/k+AbIsZOHNm49AkWE1CJ9q+ov6/9bJtMCUpfKUsUsV7Pm
         Ja6A==
X-Gm-Message-State: AOAM530PUshTXblQvcOKKuBvoi5+Seg8s1A7zc2MwJ7rLxbGOlQUTTfz
        oXnvrED3DHTcdVJh2DutIaMcWc0x
X-Google-Smtp-Source: ABdhPJyKYD+bwMc8kmQwGoqjQRczCgRq/FKP5Y7ngik8icr3nxfXpbx921KBNewzPsWm/gTfn4ccnQ==
X-Received: by 2002:ac8:5241:: with SMTP id y1mr6741728qtn.102.1595367587328;
        Tue, 21 Jul 2020 14:39:47 -0700 (PDT)
Received: from LeoBras (179-125-153-225.dynamic.desktop.com.br. [179.125.153.225])
        by smtp.gmail.com with ESMTPSA id n127sm3592591qke.29.2020.07.21.14.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 14:39:46 -0700 (PDT)
Message-ID: <534451cb4ae2a6c38e1cde147d4021581a6a4f0d.camel@gmail.com>
Subject: Re: [PATCH v4 6/7] powerpc/pseries/iommu: Make use of DDW even if
 it does not map the partition
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Tue, 21 Jul 2020 18:39:40 -0300
In-Reply-To: <20200716071658.467820-7-leobras.c@gmail.com>
References: <20200716071658.467820-1-leobras.c@gmail.com>
         <20200716071658.467820-7-leobras.c@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-07-16 at 04:16 -0300, Leonardo Bras wrote:
> +static void iommu_pseries_table_update(struct pci_dev *dev,
> +                                      struct device_node *pdn)
> +{
> +       const struct dynamic_dma_window_prop *ddw;
> +       struct pci_dn *pci;
> +       int len;
> +
> +       ddw = of_get_property(pdn, DMA64_PROPNAME, &len);
> +       if (!ddw  || len < sizeof(struct dynamic_dma_window_prop))
> +               return;
> +
> +       iommu_table_update(pci->table_group->tables[0], pci->phb->node,
> +                          ddw->liobn, ddw->dma_base, ddw->tce_shift,
> +                          ddw->window_shift);
> +}
> +
>  static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
>  {
>         struct device_node *pdn, *dn;
> @@ -1382,6 +1403,7 @@ static bool iommu_bypass_supported_pSeriesLP(struct pci_dev *pdev, u64 dma_mask)
>                 pdev->dev.archdata.dma_offset = enable_ddw(pdev, pdn);
>                 if (pdev->dev.archdata.dma_offset)
>                         return true;
> +               iommu_pseries_table_update(pdev, pdn);
>         }
> 

Noticed a bug in this one: pci is not getting assigned. 
My bad, there must have been a merge error.

Also, I will refactor the function to make use of pdn only, as I can do
pci = PCI_DN(pdn) (I think it's better this way).

Sorry for the buggy patch.

Best regards,

