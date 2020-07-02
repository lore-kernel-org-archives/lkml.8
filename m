Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1964C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EEC5206E2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVKTZdZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgGBC7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 22:59:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41218 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726187AbgGBC7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 22:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593658784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QEK6R9G90/zOz77+9pwzvG2TS0PXah5aDKU36HLvoW0=;
        b=GVKTZdZH8QWBzhPMA8WzqWQ88jZnkPum+9QaZy/DmroXnaWIpLU/QnxPAF5SdxkSELk4n7
        OvJmdcKQx+87uJZ/q/HUWL3tIHKIVWEnNx/LZMHLZfVh9jCnq3IK6CjcV0WF/tN9ADe5Z8
        ZI3GIG84tS1y4NP9tVRxSD9i57iVYw8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-6iw7E02ENVGj0BTBZ93pYQ-1; Wed, 01 Jul 2020 22:59:41 -0400
X-MC-Unique: 6iw7E02ENVGj0BTBZ93pYQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75871107ACCD;
        Thu,  2 Jul 2020 02:59:38 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-13-96.pek2.redhat.com [10.72.13.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E86260BE1;
        Thu,  2 Jul 2020 02:59:29 +0000 (UTC)
Date:   Thu, 2 Jul 2020 10:59:26 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bhe@redhat.com,
        catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com,
        robh+dt@kernel.org, arnd@arndb.de, John.P.donnelly@oracle.com,
        prabhakar.pkin@gmail.com, nsaenzjulienne@suse.de, corbet@lwn.net,
        bhsharma@redhat.com, horms@verge.net.au, xiexiuqi@huawei.com,
        linux-doc@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com,
        guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 5/5] kdump: update Documentation about crashkernel on
 arm64
Message-ID: <20200702025926.GB12277@dhcp-128-65.nay.redhat.com>
References: <20200628083458.40066-1-chenzhou10@huawei.com>
 <20200628083458.40066-6-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200628083458.40066-6-chenzhou10@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen,
On 06/28/20 at 04:34pm, Chen Zhou wrote:
> Now we support crashkernel=X,[low] on arm64, update the Documentation.
> We could use parameters "crashkernel=X crashkernel=Y,low" to reserve
> memory above 4G.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> Tested-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> ---
>  Documentation/admin-guide/kdump/kdump.rst       | 13 +++++++++++--
>  Documentation/admin-guide/kernel-parameters.txt | 17 +++++++++++++++--
>  2 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> index 2da65fef2a1c..6ba294d425c9 100644
> --- a/Documentation/admin-guide/kdump/kdump.rst
> +++ b/Documentation/admin-guide/kdump/kdump.rst
> @@ -299,7 +299,13 @@ Boot into System Kernel
>     "crashkernel=64M@16M" tells the system kernel to reserve 64 MB of memory
>     starting at physical address 0x01000000 (16MB) for the dump-capture kernel.
>  
> -   On x86 and x86_64, use "crashkernel=64M@16M".
> +   On x86 use "crashkernel=64M@16M".
> +
> +   On x86_64, use "crashkernel=Y[@X]" to select a region under 4G first, and
> +   fall back to reserve region above 4G when '@offset' hasn't been specified.

Actually crashkernel=Y without the offset works well, I do not see why
we need the offset, it should be some legacy thing.  So it should be
better just use the Y without offset here, and just leave a note
somewhere people can use [@X] offset when they really have to.

> +   We can also use "crashkernel=X,high" to select a region above 4G, which
> +   also tries to allocate at least 256M below 4G automatically and
> +   "crashkernel=Y,low" can be used to allocate specified size low memory.
>  
>     On ppc64, use "crashkernel=128M@32M".
>  
> @@ -316,8 +322,11 @@ Boot into System Kernel
>     kernel will automatically locate the crash kernel image within the
>     first 512MB of RAM if X is not given.
>  
> -   On arm64, use "crashkernel=Y[@X]".  Note that the start address of
> +   On arm64, use "crashkernel=Y[@X]". Note that the start address of
>     the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
> +   If crashkernel=Z,low is specified simultaneously, reserve spcified size
> +   low memory for crash kdump kernel devices firstly and then reserve memory

"devices" seems not very accurate, maybe just drop the "for crash kdump
kernel devices" since it is clear based on the context.

> +   above 4G.
>  
>  Load the Dump-capture Kernel
>  ============================
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index fb95fad81c79..335431a351c0 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -722,6 +722,9 @@
>  			[KNL, x86_64] select a region under 4G first, and
>  			fall back to reserve region above 4G when '@offset'
>  			hasn't been specified.
> +			[KNL, arm64] If crashkernel=X,low is specified, reserve
> +			spcified size low memory for crash kdump kernel devices

Ditto.

> +			firstly, and then reserve memory above 4G.
>  			See Documentation/admin-guide/kdump/kdump.rst for further details.
>  
>  	crashkernel=range1:size1[,range2:size2,...][@offset]
> @@ -746,13 +749,23 @@
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
> +			This one let user to specify own low range under 4G
> +			for crash dump kernel instead.
> +			Different with x86_64, kernel allocates specified size

sounds better:
s/Different with/Be different from

s/allocates/reserves

> +			physical memory region only when this parameter is specified
> +			instead of trying to allocate at least 256M below 4G

s/allocate/reserve

> +			automatically.
> +			This parameter is used along with crashkernel=X when we

Could change the passive sentence to below:
"Use this parameter along with"

> +			want to reserve crashkernel above 4G. If there are devices
> +			need to use ZONE_DMA in crash dump kernel, it is also
> +			a good choice.
>  	cryptomgr.notests
>  			[KNL] Disable crypto self-tests
>  
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

Thanks
Dave

