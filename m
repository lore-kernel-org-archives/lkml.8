Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8670CC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69379207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgIBRNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:13:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgIBRNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 13:13:48 -0400
Received: from gaia (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3EC72071B;
        Wed,  2 Sep 2020 17:13:44 +0000 (UTC)
Date:   Wed, 2 Sep 2020 18:13:42 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     will@kernel.org, james.morse@arm.com, tglx@linutronix.de,
        mingo@redhat.com, dyoung@redhat.com, bhe@redhat.com,
        corbet@lwn.net, John.P.donnelly@oracle.com,
        prabhakar.pkin@gmail.com, bhsharma@redhat.com, horms@verge.net.au,
        robh+dt@kernel.org, arnd@arndb.de, nsaenzjulienne@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        guohanjun@huawei.com, xiexiuqi@huawei.com, huawei.libin@huawei.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH v11 5/5] kdump: update Documentation about crashkernel
Message-ID: <20200902171341.GC16673@gaia>
References: <20200801130856.86625-1-chenzhou10@huawei.com>
 <20200801130856.86625-6-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801130856.86625-6-chenzhou10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 01, 2020 at 09:08:56PM +0800, Chen Zhou wrote:
> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> index 2da65fef2a1c..4b58f97351d5 100644
> --- a/Documentation/admin-guide/kdump/kdump.rst
> +++ b/Documentation/admin-guide/kdump/kdump.rst
> @@ -299,7 +299,15 @@ Boot into System Kernel
>     "crashkernel=64M@16M" tells the system kernel to reserve 64 MB of memory
>     starting at physical address 0x01000000 (16MB) for the dump-capture kernel.
>  
> -   On x86 and x86_64, use "crashkernel=64M@16M".
> +   On x86 use "crashkernel=64M@16M".
> +
> +   On x86_64, use "crashkernel=X" to select a region under 4G first, and
> +   fall back to reserve region above 4G.
> +   We can also use "crashkernel=X,high" to select a region above 4G, which
> +   also tries to allocate at least 256M below 4G automatically and
> +   "crashkernel=Y,low" can be used to allocate specified size low memory.
> +   Use "crashkernel=Y@X" if you really have to reserve memory from specified
> +   start address X.
>  
>     On ppc64, use "crashkernel=128M@32M".
>  
> @@ -316,8 +324,15 @@ Boot into System Kernel
>     kernel will automatically locate the crash kernel image within the
>     first 512MB of RAM if X is not given.
>  
> -   On arm64, use "crashkernel=Y[@X]".  Note that the start address of
> -   the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
> +   On arm64, use "crashkernel=X" to try low allocation in ZONE_DMA, and
> +   fall back to high allocation if it fails. And go for high allocation
> +   directly if the required size is too large. If crash_base is outside

I wouldn't mention crash_base in the admin guide. That's an
implementation detail really and admins are not supposed to read the
source code to make sense of the documentation. ZONE_DMA is also a
kernel internal, so you'd need to define what it is for arm64. At least
the DMA and DMA32 zones are printed during kernel boot.

> +   ZONE_DMA, try to allocate at least 256M in ZONE_DMA automatically.
> +   "crashkernel=Y,low" can be used to allocate specified size low memory.
> +   For non-RPi4 platforms, change ZONE_DMA memtioned above to ZONE_DMA32.
> +   Use "crashkernel=Y@X" if you really have to reserve memory from
> +   specified start address X. Note that the start address of the kernel,
> +   X if explicitly specified, must be aligned to 2MiB (0x200000).

-- 
Catalin
