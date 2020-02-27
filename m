Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BF4C3F2CB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3C92469C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 23:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582845779;
	bh=7+gTZW27aY4hf5vwBl9dT1mMM0XSUpttYHUYVSGA70c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IAELrmJGbaUvNNssYXZ4hrS+iZOOhSdug7ireZwzkw8vHgLi1vmSny+dx0X4HAJeH
	 Vs43iELtctONBdPzy/yX5XL1qqaJsP/sPLhM1V5rfw88eRFo81toLWy+sDLJwPAzpg
	 UHwcMaR3wtIX9rvpYU3oXWq1leuYB328eS6jA34M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbgB0XW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 18:22:58 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44407 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729391AbgB0XW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 18:22:58 -0500
Received: by mail-ot1-f66.google.com with SMTP id h9so864768otj.11;
        Thu, 27 Feb 2020 15:22:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UkIj7Br6bPd7hbW7TV5UiV4FHsIuHQGX64PWFr24Elw=;
        b=LDozMsfxXmeO1BiQO6QhIKiUwrhCYJRNJbGBaSS4YrE+tOAy8JMCAxDP4jEmLeAZer
         2ak3VpM7+VUvgC5ZGwFsg5jwmqLNeCETnakCl9mU3oHd1jToKSrQkRTrnRWEGlB57CzZ
         l6UvGTCypPphbR90zxvYf88xBEOQepNp/SGdiitzomX7jPJYVeA/lWWnQF2DQdDuTn6X
         xyFrEwsxmhXka8DATyKj2LeFN/+n4huKOcWIqneUNiDRWITrdqLDd7XUO/v+X+a3o5f5
         KlCETYzFLF0hfQs4nbPz8COBe4sN1QwYhPak81VWmMCKzR3Yaw9NIALhhEhxWbiVJQ6h
         1ckA==
X-Gm-Message-State: APjAAAUssXgeLi/3PxB6fttyvn1/EErMao5kcSIhAtAxd9lF5wagPJQe
        a6srsyvTs3EO9O9eXeGM+w==
X-Google-Smtp-Source: APXvYqwyoGSeOvDsr/b/4MBxlzKifGUIKH2KNXIq/Dsvt2qo0CMzRCuC3CpAFxDHEcT2vx8OeH8M/A==
X-Received: by 2002:a9d:12a2:: with SMTP id g31mr1069694otg.283.1582845777179;
        Thu, 27 Feb 2020 15:22:57 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n25sm2496905oic.6.2020.02.27.15.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 15:22:55 -0800 (PST)
Received: (nullmailer pid 15847 invoked by uid 1000);
        Thu, 27 Feb 2020 23:22:53 -0000
Date:   Thu, 27 Feb 2020 17:22:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alistair Delva <adelva@google.com>
Cc:     linux-kernel@vger.kernel.org, Kenny Root <kroot@google.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, devicetree@vger.kernel.org,
        linux-nvdimm@lists.01.org, kernel-team@android.com
Subject: Re: [PATCH v3 3/3] dt-bindings: pmem-region: Document memory-region
Message-ID: <20200227232253.GA5966@bogus>
References: <20200224021029.142701-1-adelva@google.com>
 <20200224021029.142701-3-adelva@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224021029.142701-3-adelva@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 06:10:29PM -0800, Alistair Delva wrote:
> From: Kenny Root <kroot@google.com>
> 
> Add documentation and example for memory-region in pmem.
> 
> Signed-off-by: Kenny Root <kroot@google.com>
> Signed-off-by: Alistair Delva <adelva@google.com>
> Cc: "Oliver O'Halloran" <oohall@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-nvdimm@lists.01.org
> Cc: kernel-team@android.com
> ---
> [v3: adelva: remove duplicate "From:"]
>  .../devicetree/bindings/pmem/pmem-region.txt  | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pmem/pmem-region.txt b/Documentation/devicetree/bindings/pmem/pmem-region.txt
> index 5cfa4f016a00..0ec87bd034e0 100644
> --- a/Documentation/devicetree/bindings/pmem/pmem-region.txt
> +++ b/Documentation/devicetree/bindings/pmem/pmem-region.txt
> @@ -29,6 +29,18 @@ Required properties:
>  		in a separate device node. Having multiple address ranges in a
>  		node implies no special relationship between the two ranges.
>  
> +		This property may be replaced or supplemented with a
> +		memory-region property. Only one of reg or memory-region
> +		properties is required.
> +
> +	- memory-region:
> +		Reference to the reserved memory node. The reserved memory
> +		node should be defined as per the bindings in
> +		reserved-memory.txt

Though we've never enforced it, but /reserved-memory should be within 
the bounds of /memory node(s). Is that the intent here? If so, how does 
that work? Wouldn't all the memory be persistent then? Or some other 
system processor is preserving the contents?

> +
> +		This property may be replaced or supplemented with a reg
> +		property. Only one of reg or memory-region is required.
> +
>  Optional properties:
>  	- Any relevant NUMA assocativity properties for the target platform.
>  
> @@ -63,3 +75,20 @@ Examples:
>  		volatile;
>  	};
>  
> +
> +	/*
> +	 * This example uses a reserved-memory entry instead of
> +	 * specifying the memory region directly in the node.
> +	 */
> +
> +	reserved-memory {
> +		pmem_1: pmem@5000 {
> +			no-map;

Just add 'compatible = "pmem-region";' here and be done with it. Why add 
a layer of indirection?

> +			reg = <0x00005000 0x00001000>;
> +		};
> +	};
> +
> +	pmem@1 {

No 'reg', so shouldn't have a unit-address here.

> +		compatible = "pmem-region";
> +		memory-region = <&pmem_1>;
> +	};
> -- 
> 2.25.0.265.gbab2e86ba0-goog
> 
