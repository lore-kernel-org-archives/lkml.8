Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30218C4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068B021D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582753003;
	bh=P4wqZ/G/RRozD3/33SDHyrWrXUAr2WpACya0jZ2Nj4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G1ygZi3OR5OmeGwL0F4jI/zam+5rAzwITkGjXOFE1goXDAgeZYYucyfAbksaKCnBr
	 8wQMb0CALQMNF8bSexwbTs3nT8vvi+DwfgGqfR1eg3WbKxfHqGLDRYAg60lmXEACnr
	 p/EKUWmIJr22/Zzn2K1JjMIJrHgT3nHO8XOgkETY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgBZVgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:36:41 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43917 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727581AbgBZVgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:36:41 -0500
Received: by mail-oi1-f193.google.com with SMTP id p125so1066515oif.10;
        Wed, 26 Feb 2020 13:36:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k5x7wgpT9UNOStLpFcvf/lxLcJwiRX3Kcmib1RAv6/M=;
        b=d+2AofRWv8QAiUgbtoAahOBYJdwKBIBMfkkkCQkvyop8fmBkJ49LW0hIij28e4bXwf
         eZEjdBXatQmHdXgv0EwBu/WZm0Jh5lOcQfp5zyOcI99HIOtRPTMS8/Y52hr7OFmJLkG6
         /oF3Lz5wNRqhTzO5JTsptaD9gUqXrIL+Ar9+Yy7/m6+0BTx29jDidmhmDy6eZmivmfcK
         ePmmXPR5c2w0UBhMDjnQHz+r4TYFx4vYfxwQx1bhHH/bpJunUgr+uOqFHGAKy9AdhbM1
         cRpgeMfDP2fSZwCuozAV0V/kkNatAtO+GATUu6ewBFgu1JMDa88dLHxWzmtnyLzqsUlK
         R49Q==
X-Gm-Message-State: APjAAAUEmMn94oMH5p19EQ7/sQqwrpHFfRKetX4BErnblP8WRoicgvQi
        cZ3MzXkxRajtY8h7EgG7WZp0DLc=
X-Google-Smtp-Source: APXvYqzxoFXD4QTUBqV8b6x0l6zhopTqR/fPvOEI2ik/K8lV5JkYOHYqWljuXlRDRwmfMDVD4du2+g==
X-Received: by 2002:aca:f05:: with SMTP id 5mr880691oip.140.1582753000384;
        Wed, 26 Feb 2020 13:36:40 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 7sm1250313oin.5.2020.02.26.13.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 13:36:39 -0800 (PST)
Received: (nullmailer pid 1736 invoked by uid 1000);
        Wed, 26 Feb 2020 21:36:38 -0000
Date:   Wed, 26 Feb 2020 15:36:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        david@gibson.dropbear.id.au, sjg@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, devicetree-compiler@vger.kernel.org,
        Ian Lepore <ian@freebsd.org>
Subject: Re: [RFC PATCH v2 2/4] of: fdt: print dtb build information
Message-ID: <20200226213638.GA29417@bogus>
References: <20200221161418.20225-1-alexandre.torgue@st.com>
 <20200221161418.20225-3-alexandre.torgue@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221161418.20225-3-alexandre.torgue@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 05:14:16PM +0100, Alexandre Torgue wrote:
> This commit prints out DTB build information (build time, dts source
> version used, ...) if "Build-info" property exists in DTB root node.

/Build/build/

> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 2cdf64d2456f..aa5989039746 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -1224,9 +1224,18 @@ bool __init early_init_dt_scan(void *params)
>   */
>  void __init unflatten_device_tree(void)
>  {
> +	const char *build_info;
> +	unsigned long dt_root;
> +
>  	__unflatten_device_tree(initial_boot_params, NULL, &of_root,
>  				early_init_dt_alloc_memory_arch, false);
>  
> +	/* If available, provide dtb build information */
> +	dt_root = of_get_flat_dt_root();
> +	build_info = of_get_flat_dt_prop(dt_root, "build-info", NULL);

We just unflattened the tree, why are we using the flat dt functions?

> +	if (build_info)
> +		pr_info("%s\n", build_info);
> +
>  	/* Get pointer to "/chosen" and "/aliases" nodes for use everywhere */
>  	of_alias_scan(early_init_dt_alloc_memory_arch);
>  
> -- 
> 2.17.1
> 
