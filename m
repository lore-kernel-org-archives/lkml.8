Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E03C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77F4420823
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Hdgth6Df"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgETKGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 06:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgETKGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:06:21 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8B2C061A0E;
        Wed, 20 May 2020 03:06:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49RpLL1W3Yz9sT3;
        Wed, 20 May 2020 20:06:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1589969178;
        bh=3GidhOtwFs/P6tyysIag06q8EQS0u4xFnUTj3xKsBBc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Hdgth6Df9sJzMV7/TTAxzBB/4r/PzMXo117W2uHO3N+fIsnSKWQzCZYJXdUV39K7+
         qfSNsU/dWr8sPyekrbBD32w7RELrdV96godybDB5vjiEQUkOdz+XsPFw083v+eX4gG
         LBfZtGf8FMASlkoINyqj+YeKG1f8bVLWv8FPMJtSDQOynlUSc+9aN9qsma7htUaYUT
         xyNxD68yDUp7PEP6Hnz/XrSgcUEBT7uwQ2dO5gQzpY6lXrtMaAmYt8z8eEBhDDi90g
         o8I3ry3LzeoYg/FxxUnlEi3T3HEKFW0wUiig44fJiNJ7gMi6Rt2u0spM++PD3b+orL
         Wy/0DeV3E71Og==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] of: drop a reference on error in __of_attach_node_sysfs()
In-Reply-To: <20200518113021.GB48709@mwanda>
References: <20200518113021.GB48709@mwanda>
Date:   Wed, 20 May 2020 20:06:39 +1000
Message-ID: <877dx69az4.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> writes:
> We add a new of_node_get() to this function, but we should drop the
> reference if kobject_add().
                            ^
                            fails?
>
> Fixes: 5b2c2f5a0ea3 ("of: overlay: add missing of_node_get() in __of_attach_node_sysfs")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> From static analysis.  Maybe we should just call of_node_get() right
> before we return 0?

Yeah that would be simpler and equally correct AFAICS.

cheers

> diff --git a/drivers/of/kobj.c b/drivers/of/kobj.c
> index c72eef988041..a90dc4b3b060 100644
> --- a/drivers/of/kobj.c
> +++ b/drivers/of/kobj.c
> @@ -138,8 +138,10 @@ int __of_attach_node_sysfs(struct device_node *np)
>  
>  	rc = kobject_add(&np->kobj, parent, "%s", name);
>  	kfree(name);
> -	if (rc)
> +	if (rc) {
> +		of_node_put(np);
>  		return rc;
> +	}
>  
>  	for_each_property_of_node(np, pp)
>  		__of_add_property_sysfs(np, pp);
> -- 
> 2.26.2
