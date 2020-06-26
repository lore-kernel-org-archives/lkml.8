Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE42C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 11:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4637C20781
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 11:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="BiSmIrJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgFZLqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 07:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgFZLqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 07:46:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D61C08C5C1;
        Fri, 26 Jun 2020 04:46:12 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d140021dd7ed6b715c4c4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1400:21dd:7ed6:b715:c4c4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 23A021EC0328;
        Fri, 26 Jun 2020 13:46:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1593171969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yucFdKjCgoeX7C5mwPW8/rg/saxXn/xSVvZ7fS34kZo=;
        b=BiSmIrJGCJ0faVBTZtyCh7yIB1Uqh9DHPhI2oITaZpZkMxJelcG9IUXj87k4aPSN9CDwfQ
        NWSmB1HxwZn/+psfecdpLWBxf30ds9kL9HUXdAG1jYW/DrYmbBsZMtJGqwHemik4kwPaUw
        f1ErWNzJemfGf7t3q9dl/erT/q4WHto=
Date:   Fri, 26 Jun 2020 13:46:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, x86@kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        intel-gfx@lists.freedesktop.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 09/13] x86: Remove dev->archdata.iommu pointer
Message-ID: <20200626114603.GC27151@zn.tnic>
References: <20200625130836.1916-1-joro@8bytes.org>
 <20200625130836.1916-10-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200625130836.1916-10-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 03:08:32PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> There are no users left, all drivers have been converted to use the
> per-device private pointer offered by IOMMU core.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/include/asm/device.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/device.h b/arch/x86/include/asm/device.h
> index 49bd6cf3eec9..7c0a52ca2f4d 100644
> --- a/arch/x86/include/asm/device.h
> +++ b/arch/x86/include/asm/device.h
> @@ -3,9 +3,6 @@
>  #define _ASM_X86_DEVICE_H
>  
>  struct dev_archdata {
> -#ifdef CONFIG_IOMMU_API
> -	void *iommu; /* hook for IOMMU specific extension */
> -#endif
>  };
>  
>  struct pdev_archdata {
> -- 

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
