Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD59C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 580F720771
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZEhBaa5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgGCEq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 00:46:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32515 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725891AbgGCEq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 00:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593751617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KcSzgsJYu9sLP23m3DckKrOdBZkrV3N6NwnGG2HbKLQ=;
        b=WZEhBaa5m3GMF1KSURlTs7xygP4AEAMXi6S+yd5EknfcbJqusHH+QMDotaJU+ddwvngiu/
        yhtas3KUxguoZkG8gR8Lri+EqgBUglexwKn190cHDAFq9rDDLtKp5QKE98r25264MdSl9Z
        ECTX47by/8V85DjzjSY84p4wTK9VH2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-AXKcsR8RMH2XUyJBsTRA0A-1; Fri, 03 Jul 2020 00:46:52 -0400
X-MC-Unique: AXKcsR8RMH2XUyJBsTRA0A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D905DBFD1;
        Fri,  3 Jul 2020 04:46:49 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-13-10.pek2.redhat.com [10.72.13.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C64173FFF;
        Fri,  3 Jul 2020 04:46:38 +0000 (UTC)
Date:   Fri, 3 Jul 2020 12:46:35 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bhe@redhat.com,
        catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com,
        robh+dt@kernel.org, arnd@arndb.de, John.P.donnelly@oracle.com,
        prabhakar.pkin@gmail.com, nsaenzjulienne@suse.de, corbet@lwn.net,
        bhsharma@redhat.com, horms@verge.net.au, guohanjun@huawei.com,
        xiexiuqi@huawei.com, huawei.libin@huawei.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 5/5] kdump: update Documentation about crashkernel on
 arm64
Message-ID: <20200703044635.GA28640@dhcp-128-65.nay.redhat.com>
References: <20200703035816.31289-1-chenzhou10@huawei.com>
 <20200703035816.31289-6-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703035816.31289-6-chenzhou10@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the update, but still some nitpicks :(

I'm sorry I did not catch them previously,  but maybe it is not worth to
repost the whole series if no other changes needed.
On 07/03/20 at 11:58am, Chen Zhou wrote:
> Now we support crashkernel=X,[low] on arm64, update the Documentation.
> We could use parameters "crashkernel=X crashkernel=Y,low" to reserve
> memory above 4G.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> Tested-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> ---
>  Documentation/admin-guide/kdump/kdump.rst       | 14 ++++++++++++--
>  Documentation/admin-guide/kernel-parameters.txt | 17 +++++++++++++++--
>  2 files changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> index 2da65fef2a1c..e80fc9e28a9a 100644
> --- a/Documentation/admin-guide/kdump/kdump.rst
> +++ b/Documentation/admin-guide/kdump/kdump.rst
> @@ -299,7 +299,15 @@ Boot into System Kernel
>     "crashkernel=64M@16M" tells the system kernel to reserve 64 MB of memory
>     starting at physical address 0x01000000 (16MB) for the dump-capture kernel.
>  
> -   On x86 and x86_64, use "crashkernel=64M@16M".
> +   On x86 use "crashkernel=64M@16M".
> +
> +   On x86_64, use "crashkernel=Y" to select a region under 4G first, and
> +   fall back to reserve region above 4G.
> +   We can also use "crashkernel=X,high" to select a region above 4G, which
> +   also tries to allocate at least 256M below 4G automatically and
> +   "crashkernel=Y,low" can be used to allocate specified size low memory.
> +   Use "crashkernel=Y@X" if we really have to reserve memory from specified

s/we/you

> +   start address X.
>  
>     On ppc64, use "crashkernel=128M@32M".
>  
> @@ -316,8 +324,10 @@ Boot into System Kernel
>     kernel will automatically locate the crash kernel image within the
>     first 512MB of RAM if X is not given.
>  
> -   On arm64, use "crashkernel=Y[@X]".  Note that the start address of
> +   On arm64, use "crashkernel=Y[@X]". Note that the start address of
>     the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
> +   If crashkernel=Z,low is specified simultaneously, reserve spcified size

s/spcified/specified

> +   low memory firstly and then reserve memory above 4G.
>  
>  Load the Dump-capture Kernel
>  ============================
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index fb95fad81c79..58a731eed011 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -722,6 +722,9 @@
>  			[KNL, x86_64] select a region under 4G first, and
>  			fall back to reserve region above 4G when '@offset'
>  			hasn't been specified.
> +			[KNL, arm64] If crashkernel=X,low is specified, reserve
> +			spcified size low memory firstly, and then reserve memory

s/spcified/specified

> +			above 4G.
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

s/own low/a low

> +			for crash dump kernel instead.
> +			Be different from x86_64, kernel reserves specified size
> +			physical memory region only when this parameter is specified
> +			instead of trying to reserve at least 256M below 4G
> +			automatically.
> +			Use this parameter along with crashkernel=X when we want
> +			to reserve crashkernel above 4G. If there are devices
> +			need to use ZONE_DMA in crash dump kernel, it is also
> +			a good choice.
>  	cryptomgr.notests
>  			[KNL] Disable crypto self-tests
>  
> -- 
> 2.20.1
> 

