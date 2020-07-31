Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE83C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC027208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596229089;
	bh=OvRm8Q1e12fMuVUSKr8GbmykdmZaR8prGqUEdd04wyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bR7kYVXcnARFamDlpfXoQEVIX6jeIQdi+24hHt4tcOBAjDtvuDqY7ugehZJGb0wWc
	 0sFWSF4xwR0QVfZ1S3KdR5JNfShGJhy2dMBp0hDF/q36sf4LGxsUjcyb9pcfq0MDfO
	 iMIuzCy2gv/1i+KbYRU74i5t2EJ7q7IRsX1zHbAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgGaU6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:58:08 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:34017 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgGaU6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 16:58:08 -0400
Received: by mail-il1-f193.google.com with SMTP id t4so26428537iln.1;
        Fri, 31 Jul 2020 13:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rcyOW7qIuRoMGsE2+TVNMGv+PyvtkKSZN/cGvDKDZM8=;
        b=VWw24Dvxr4w7gL6a7KNXwsV+UoRi1ZxcnRwXl0/XxQz5nRV8ZqTYWPdCiZVJYL5bY2
         apeHBdXoVa1tLkuLDkswRut1zrLxDOXs5bsVc6FtkFUpc+59GFVq2kurxunx//IGW2YR
         m1KF1bkRlBtKKnyrWZ5t9CXytkEXORew2hGtbYi3LEUg6GROLWQKMdO3UEphxj1iTzFb
         7NQAMeDKA0/C8l21m/qanPU2GfugtIDtmS15H3ijnCXPr9/2zGPnUBvdpS+3T65dwzLi
         5L5J76R5rSsPUsg+JSyb+uT/zZOacWqlMTs7KA0pkDBhpnhHc8UFLvIs6xCn0+zPxLNo
         pjDA==
X-Gm-Message-State: AOAM530SLyjxs562g7Zg07mP/7rKoTKYfGWYkKoBfXSG3TzRSQkhLAf+
        2Zw8wVnZDTuiiUPr0xImOQ==
X-Google-Smtp-Source: ABdhPJxmGDIK2n0F7LcntLADTKoB+yOnyNpREExJ0pYlohQMXlRlUSjxE4KX9ssiGMxjIpXnztV4ag==
X-Received: by 2002:a92:c5c1:: with SMTP id s1mr5514077ilt.144.1596229087153;
        Fri, 31 Jul 2020 13:58:07 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v5sm5213848ilg.88.2020.07.31.13.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 13:58:05 -0700 (PDT)
Received: (nullmailer pid 774077 invoked by uid 1000);
        Fri, 31 Jul 2020 20:58:04 -0000
Date:   Fri, 31 Jul 2020 14:58:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claire Chang <tientzu@chromium.org>
Cc:     frowand.list@gmail.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, treding@nvidia.com,
        gregkh@linuxfoundation.org, saravanak@google.com,
        suzuki.poulose@arm.com, dan.j.williams@intel.com,
        heikki.krogerus@linux.intel.com, bgolaszewski@baylibre.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, drinkcat@chromium.org,
        tfiga@chromium.org
Subject: Re: [RFC v2 4/5] dt-bindings: of: Add plumbing for restricted DMA
 pool
Message-ID: <20200731205804.GB756942@bogus>
References: <20200728050140.996974-1-tientzu@chromium.org>
 <20200728050140.996974-5-tientzu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728050140.996974-5-tientzu@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 01:01:39PM +0800, Claire Chang wrote:
> Introduce the new compatible string, device-swiotlb-pool, for restricted
> DMA. One can specify the address and length of the device swiotlb memory
> region by device-swiotlb-pool in the device tree.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
>  .../reserved-memory/reserved-memory.txt       | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> index 4dd20de6977f..78850896e1d0 100644
> --- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> +++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> @@ -51,6 +51,24 @@ compatible (optional) - standard definition
>            used as a shared pool of DMA buffers for a set of devices. It can
>            be used by an operating system to instantiate the necessary pool
>            management subsystem if necessary.
> +        - device-swiotlb-pool: This indicates a region of memory meant to be

swiotlb is a Linux thing. The binding should be independent.

> +          used as a pool of device swiotlb buffers for a given device. When
> +          using this, the no-map and reusable properties must not be set, so the
> +          operating system can create a virtual mapping that will be used for
> +          synchronization. Also, there must be a restricted-dma property in the
> +          device node to specify the indexes of reserved-memory nodes. One can
> +          specify two reserved-memory nodes in the device tree. One with
> +          shared-dma-pool to handle the coherent DMA buffer allocation, and
> +          another one with device-swiotlb-pool for regular DMA to/from system
> +          memory, which would be subject to bouncing. The main purpose for
> +          restricted DMA is to mitigate the lack of DMA access control on
> +          systems without an IOMMU, which could result in the DMA accessing the
> +          system memory at unexpected times and/or unexpected addresses,
> +          possibly leading to data leakage or corruption. The feature on its own
> +          provides a basic level of protection against the DMA overwriting buffer
> +          contents at unexpected times. However, to protect against general data
> +          leakage and system memory corruption, the system needs to provide a
> +          way to restrict the DMA to a predefined memory region.

I'm pretty sure we already support per device carveouts and I don't 
understand how this is different.

What is the last sentence supposed to imply? You need an IOMMU?

>          - vendor specific string in the form <vendor>,[<device>-]<usage>
>  no-map (optional) - empty property
>      - Indicates the operating system must not create a virtual mapping
> @@ -117,6 +135,16 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
>  			compatible = "acme,multimedia-memory";
>  			reg = <0x77000000 0x4000000>;
>  		};
> +
> +		wifi_coherent_mem_region: wifi_coherent_mem_region {
> +			compatible = "shared-dma-pool";
> +			reg = <0x50000000 0x400000>;
> +		};
> +
> +		wifi_device_swiotlb_region: wifi_device_swiotlb_region {
> +			compatible = "device-swiotlb-pool";
> +			reg = <0x50400000 0x4000000>;
> +		};
>  	};
>  
>  	/* ... */
> @@ -135,4 +163,11 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
>  		memory-region = <&multimedia_reserved>;
>  		/* ... */
>  	};
> +
> +	pcie_wifi: pcie_wifi@0,0 {
> +		memory-region = <&wifi_coherent_mem_region>,
> +			 <&wifi_device_swiotlb_region>;
> +		restricted-dma = <0>, <1>;
> +		/* ... */
> +	};
>  };
> -- 
> 2.28.0.rc0.142.g3c755180ce-goog
> 
