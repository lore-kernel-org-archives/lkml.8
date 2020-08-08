Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807BDC433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 10:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C1842075D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 10:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ixlp0mjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgHHKC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 06:02:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38180 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726074AbgHHKC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 06:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596880975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9sQZQ3O/mt1wEI6vVEOUOzXH/lCb8p+hxo0Z8dtXlDY=;
        b=Ixlp0mjFRAGsWmQaMbhNcgIJlLHD40f8dcH0SDkJqeSchohK6n6cPr3iqiqxEXrobFP0fU
        RtYfo/0AV6qSergsIWhYf3vYvlw6ePyFTTL7h1G1xTtZRC9Df5ZazxsPZmph495iH/45S0
        S7oSKht0psAtRnhDyymta3n9lVtL2Uk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-4m4wsm1qP9CP0y11zK1KUg-1; Sat, 08 Aug 2020 06:02:53 -0400
X-MC-Unique: 4m4wsm1qP9CP0y11zK1KUg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3171F100960F;
        Sat,  8 Aug 2020 10:02:51 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-106.pek2.redhat.com [10.72.12.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 67E558AC2B;
        Sat,  8 Aug 2020 10:02:43 +0000 (UTC)
Date:   Sat, 8 Aug 2020 18:02:39 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com,
        tglx@linutronix.de, mingo@redhat.com, bhe@redhat.com,
        corbet@lwn.net, John.P.donnelly@oracle.com,
        prabhakar.pkin@gmail.com, bhsharma@redhat.com, horms@verge.net.au,
        robh+dt@kernel.org, arnd@arndb.de, nsaenzjulienne@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        guohanjun@huawei.com, xiexiuqi@huawei.com, huawei.libin@huawei.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH v11 5/5] kdump: update Documentation about crashkernel
Message-ID: <20200808100239.GB60590@dhcp-128-65.nay.redhat.com>
References: <20200801130856.86625-1-chenzhou10@huawei.com>
 <20200801130856.86625-6-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801130856.86625-6-chenzhou10@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/20 at 09:08pm, Chen Zhou wrote:
> Now the behavior of crashkernel=X has been changed, which tries low
> allocation in ZONE_DMA, and fall back to high allocation if it fails.
> 
> If requized size X is too large and leads to very little free memory
> in ZONE_DMA after low allocation, the system may not work well.
> So add a threshold and go for high allocation directly if the required
> size is too large. The threshold is set as the half of low memory.
> 
> If crash_base is outside ZONE_DMA, try to allocate at least 256M in
> ZONE_DMA automatically. "crashkernel=Y,low" can be used to allocate
> specified size low memory. For non-RPi4 platforms, change ZONE_DMA
> memtioned above to ZONE_DMA32.
> 
> So update the Documentation.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  Documentation/admin-guide/kdump/kdump.rst     | 21 ++++++++++++++++---
>  .../admin-guide/kernel-parameters.txt         | 11 ++++++++--
>  2 files changed, 27 insertions(+), 5 deletions(-)
> 
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
> +   ZONE_DMA, try to allocate at least 256M in ZONE_DMA automatically.
> +   "crashkernel=Y,low" can be used to allocate specified size low memory.
> +   For non-RPi4 platforms, change ZONE_DMA memtioned above to ZONE_DMA32.
> +   Use "crashkernel=Y@X" if you really have to reserve memory from
> +   specified start address X. Note that the start address of the kernel,
> +   X if explicitly specified, must be aligned to 2MiB (0x200000).
>  
>  Load the Dump-capture Kernel
>  ============================
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index fb95fad81c79..d1b6016850d6 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -722,6 +722,10 @@
>  			[KNL, x86_64] select a region under 4G first, and
>  			fall back to reserve region above 4G when '@offset'
>  			hasn't been specified.
> +			[KNL, arm64] Try low allocation in ZONE_DMA, fall back
> +			to high allocation if it fails when '@offset' hasn't been
> +			specified. For non-RPi4 platforms, change ZONE_DMA to
> +			ZONE_DMA32.
>  			See Documentation/admin-guide/kdump/kdump.rst for further details.
>  
>  	crashkernel=range1:size1[,range2:size2,...][@offset]
> @@ -746,13 +750,16 @@
>  			requires at least 64M+32K low memory, also enough extra
>  			low memory is needed to make sure DMA buffers for 32-bit
>  			devices won't run out. Kernel would try to allocate at
> -			at least 256M below 4G automatically.
> +			least 256M below 4G automatically.
>  			This one let user to specify own low range under 4G
>  			for second kernel instead.
>  			0: to disable low allocation.
>  			It will be ignored when crashkernel=X,high is not used
>  			or memory reserved is below 4G.
> -
> +			[KNL, arm64] range under 4G.
> +			This one let user to specify a low range in ZONE_DMA for
> +			crash dump kernel. For non-RPi4 platforms, change ZONE_DMA
> +			to ZONE_DMA32.
>  	cryptomgr.notests
>  			[KNL] Disable crypto self-tests
>  
> -- 
> 2.20.1
> 

Hi Chen,

Previously I remember we talked about to use similar logic as X86, but I
remember you mentioned on some arm64 platform there could be no low
memory at all.  Is this not a problem now for the fallback?  Just be
curious, thanks for the update, for the common part looks good.

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

