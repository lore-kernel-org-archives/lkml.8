Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AC6C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 378782065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594846285;
	bh=7K2AKFplTVr819ofOXAFAyKxxpTCjfqstUP/bwMZbFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QDqsiMK4AkVEBv4ENplVZK3K5sUr/iqDpXszx5NOY7cT58R9Y57QMW5gnPqGubRLJ
	 DC9A3Je648GYI/BU74GrySDEgMW9I+5fHH6yQseBfsHwhBTH1m2XgkcX0b1VfciH/N
	 iyL+bVUp/pn2lgMDtUeD+52s7IohacvrDOGXYspA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgGOUvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 16:51:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40700 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOUvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 16:51:23 -0400
Received: by mail-io1-f66.google.com with SMTP id l17so3728614iok.7;
        Wed, 15 Jul 2020 13:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q9ACE8nvrxYAkV7UmkgZ6sY12qZMuGAXz/YkNp21cP8=;
        b=LpBQtXg04ocu1/Q8mGVkib+W0iU7MtYouSSSgQ/34Boyh+bpLQ7p/GovdOggOwulsU
         vhE6CIKFThZx+KzEpBGD3cSlpOeMrBXSF3AK8FcId3FyNiFZIFww/RDZ32ra1r5pLVj3
         2PTRvBMJw2wyfVU51b14qX3xBIIRB8hwROwQq4QxQypIRV52Dq1pvHXRBX/XgQmXBEAp
         E5Pnfgd5Af078PGV7G5pZxAXt5dI5iYN/QIUBahTc/8EsAWVHf/WISeduP3npOhJUpQp
         LyA/nMH0jgL8LVOwLaGKkUsprr884+CoOCLgpz82HpZeyGeUXXXYlozhltIXoK41oOnB
         Hf4Q==
X-Gm-Message-State: AOAM531xyvCulBgRrh5OYmx9dZ3QXvy9FynsAXHx4Kch5v3DlNEkbWhf
        iJYcL+Aglj4ys0Pb7cZvdFXp5ctCrg==
X-Google-Smtp-Source: ABdhPJwJgZBHTochu4o5lfkCZewGDWCyBkruv1P6g3YXlsJ82fsfdRZEt+/xHnCbpv9RpaMjsjLcFw==
X-Received: by 2002:a6b:4409:: with SMTP id r9mr1160938ioa.158.1594846282053;
        Wed, 15 Jul 2020 13:51:22 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id s18sm1576592ilj.63.2020.07.15.13.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 13:51:21 -0700 (PDT)
Received: (nullmailer pid 795410 invoked by uid 1000);
        Wed, 15 Jul 2020 20:51:20 -0000
Date:   Wed, 15 Jul 2020 14:51:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com,
        Yong Wu <yong.wu@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: Re: [PATCH 1/4] dt-bindings: mediatek: add mediatek,infracfg phandle
Message-ID: <20200715205120.GA778876@bogus>
References: <20200702093721.6063-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702093721.6063-1-miles.chen@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 05:37:17PM +0800, Miles Chen wrote:
> Add a description for mediatek,infracfg. We can check if 4GB mode
> is enable by reading it instead of checking the unexported
> symbol "max_pfn".
> 
> This is a step towards building mtk_iommu as a kernel module.

You determined this before without DT, so it is an OS problem and 
shouldn't need a DT update.

I'd assume there's only one instance of the node mediatek,infracfg 
points to, so just search for it if you want to get the info from DT.


> 
> Cc: Yong Wu <yong.wu@mediatek.com>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---
>  Documentation/devicetree/bindings/iommu/mediatek,iommu.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> index ce59a505f5a4..a7881deabcca 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> @@ -74,6 +74,8 @@ Required properties:
>  - mediatek,larbs : List of phandle to the local arbiters in the current Socs.
>  	Refer to bindings/memory-controllers/mediatek,smi-larb.txt. It must sort
>  	according to the local arbiter index, like larb0, larb1, larb2...
> +- mediatek,infracfg: a phandle to infracfg. It is used to confirm if 4GB mode is set.
> +	It is an optional property, add it when the SoC have 4g mode.
>  - iommu-cells : must be 1. This is the mtk_m4u_id according to the HW.
>  	Specifies the mtk_m4u_id as defined in
>  	dt-binding/memory/mt2701-larb-port.h for mt2701, mt7623
> -- 
> 2.18.0
