Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2A0C54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 686A420738
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="KGVt1GTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgDUNex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728422AbgDUNew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:34:52 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C794AC061A41
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 06:34:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4964LH5jycz9sSY;
        Tue, 21 Apr 2020 23:34:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1587476088;
        bh=Y+z6/rcJIObmZtZ51xGieSwpLR256JCEweZeuezbpcY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KGVt1GTIlQZOPxOIid++1szONXTthboUOft5u/6EE6JysRPJ8O3iv3vAb+Ihm6B41
         2cWtWSpLVTDTgAtQYInJePYFBXqa31pJ2H2LtW1YCjjhfeyYaK/1BOM/y63Ndfx61F
         +2Z05AzNnKItYukVZO6EckdQVK/oQC5HjIxrJss7+2q0YTdpRwbANP94m9qVl1fBQH
         ZxK5XTabGGImV8mfAnOERHQffGm8D4Z3DOHbFFwTqJqDf006IT8h5JTjmOh/FVjGNp
         7M4aWACvFXqgMhLc59XWbdSFubep7HPt419o68jfI5bOs3y4XRQOzUN7zajxALFiDz
         5g/ux86TtXjfA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Laurent Dufour <ldufour@linux.ibm.com>, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     paulus@samba.org, linux-kernel@vger.kernel.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>, benh@kernel.crashing.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: read ibm,secure-memory nodes
In-Reply-To: <20200416162715.45846-1-ldufour@linux.ibm.com>
References: <20200416162715.45846-1-ldufour@linux.ibm.com>
Date:   Tue, 21 Apr 2020 23:34:59 +1000
Message-ID: <87k129gdx8.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Laurent Dufour <ldufour@linux.ibm.com> writes:
> The newly introduced ibm,secure-memory nodes supersede the
> ibm,uv-firmware's property secure-memory-ranges.

Is either documented in a device tree binding document anywhere?

cheers

> Firmware will no more expose the secure-memory-ranges property so first
> read the new one and if not found rollback to the older one.
>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv_uvmem.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
> index 53b88cae3e73..ad950f8996e0 100644
> --- a/arch/powerpc/kvm/book3s_hv_uvmem.c
> +++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
> @@ -735,6 +735,20 @@ static u64 kvmppc_get_secmem_size(void)
>  	const __be32 *prop;
>  	u64 size = 0;
>  
> +	/*
> +	 * First try the new ibm,secure-memory nodes which supersede the
> +	 * secure-memory-ranges property.
> +	 * If we found somes, no need to read the deprecated one.
> +	 */
> +	for_each_compatible_node(np, NULL, "ibm,secure-memory") {
> +		prop = of_get_property(np, "reg", &len);
> +		if (!prop)
> +			continue;
> +		size += of_read_number(prop + 2, 2);
> +	}
> +	if (size)
> +		return size;
> +
>  	np = of_find_compatible_node(NULL, NULL, "ibm,uv-firmware");
>  	if (!np)
>  		goto out;
> -- 
> 2.26.1
