Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CFFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 00:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23687206F1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 00:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BGeZOpvn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388373AbgEZA7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 20:59:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40103 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387794AbgEZA7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 20:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590454755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6eA+VGTMrxKe15l1896s+o5D8uO5uEaZ+ep2DD/zbt0=;
        b=BGeZOpvnpm7WsN4GfotrlVc9V8RB91a8pCb+sTHLPatCXaebbqPTaNyepgcX7Xygq+Kj11
        vCUC5HaaQuCJHCydviSblTjmHBloraHkyGMxpajvsux++x4qXCOIVwHDck4swEWwaaHv2b
        AS4zxOA0vo7VQJs4lokziUKcAyi7IOw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-Q7nAuGbRNy6T_74duoFG0Q-1; Mon, 25 May 2020 20:59:13 -0400
X-MC-Unique: Q7nAuGbRNy6T_74duoFG0Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B5E6107ACCA;
        Tue, 26 May 2020 00:59:11 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 008D55C1BB;
        Tue, 26 May 2020 00:59:06 +0000 (UTC)
Date:   Tue, 26 May 2020 08:59:04 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, catalin.marinas@arm.com,
        will@kernel.org, dyoung@redhat.com, robh+dt@kernel.org,
        John.p.donnelly@oracle.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        horms@verge.net.au, guohanjun@huawei.com, pkushwaha@marvell.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 2/5] arm64: kdump: reserve crashkenel above 4G for
 crash dump kernel
Message-ID: <20200526005904.GE20045@MiWiFi-R3L-srv>
References: <20200521093805.64398-1-chenzhou10@huawei.com>
 <20200521093805.64398-3-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521093805.64398-3-chenzhou10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/21/20 at 05:38pm, Chen Zhou wrote:
> Crashkernel=X tries to reserve memory for the crash dump kernel under
> 4G. If crashkernel=X,low is specified simultaneously, reserve spcified
> size low memory for crash kdump kernel devices firstly and then reserve
> memory above 4G.

Wondering why crashkernel=,high is not introduced to arm64 to be
consistent with x86_64, to make the behaviour be the same on all
architecutres. 

> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> Tested-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> ---
>  arch/arm64/kernel/setup.c |  8 +++++++-
>  arch/arm64/mm/init.c      | 31 +++++++++++++++++++++++++++++--
>  2 files changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 3fd2c11c09fc..a8487e4d3e5a 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -238,7 +238,13 @@ static void __init request_standard_resources(void)
>  		    kernel_data.end <= res->end)
>  			request_resource(res, &kernel_data);
>  #ifdef CONFIG_KEXEC_CORE
> -		/* Userspace will find "Crash kernel" region in /proc/iomem. */
> +		/*
> +		 * Userspace will find "Crash kernel" region in /proc/iomem.
> +		 * Note: the low region is renamed as Crash kernel (low).
> +		 */
> +		if (crashk_low_res.end && crashk_low_res.start >= res->start &&
> +				crashk_low_res.end <= res->end)
> +			request_resource(res, &crashk_low_res);
>  		if (crashk_res.end && crashk_res.start >= res->start &&
>  		    crashk_res.end <= res->end)
>  			request_resource(res, &crashk_res);
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index e42727e3568e..71498acf0cd8 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -81,6 +81,7 @@ static void __init reserve_crashkernel(void)
>  {
>  	unsigned long long crash_base, crash_size;
>  	int ret;
> +	phys_addr_t crash_max = arm64_dma32_phys_limit;
>  
>  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>  				&crash_size, &crash_base);
> @@ -88,12 +89,38 @@ static void __init reserve_crashkernel(void)
>  	if (ret || !crash_size)
>  		return;
>  
> +	ret = reserve_crashkernel_low();
> +	if (!ret && crashk_low_res.end) {
> +		/*
> +		 * If crashkernel=X,low specified, there may be two regions,
> +		 * we need to make some changes as follows:
> +		 *
> +		 * 1. rename the low region as "Crash kernel (low)"
> +		 * In order to distinct from the high region and make no effect
> +		 * to the use of existing kexec-tools, rename the low region as
> +		 * "Crash kernel (low)".
> +		 *
> +		 * 2. change the upper bound for crash memory
> +		 * Set MEMBLOCK_ALLOC_ACCESSIBLE upper bound for crash memory.
> +		 *
> +		 * 3. mark the low region as "nomap"
> +		 * The low region is intended to be used for crash dump kernel
> +		 * devices, just mark the low region as "nomap" simply.
> +		 */
> +		const char *rename = "Crash kernel (low)";
> +
> +		crashk_low_res.name = rename;
> +		crash_max = MEMBLOCK_ALLOC_ACCESSIBLE;
> +		memblock_mark_nomap(crashk_low_res.start,
> +				    resource_size(&crashk_low_res));
> +	}
> +
>  	crash_size = PAGE_ALIGN(crash_size);
>  
>  	if (crash_base == 0) {
>  		/* Current arm64 boot protocol requires 2MB alignment */
> -		crash_base = memblock_find_in_range(0, arm64_dma32_phys_limit,
> -				crash_size, SZ_2M);
> +		crash_base = memblock_find_in_range(0, crash_max, crash_size,
> +				SZ_2M);
>  		if (crash_base == 0) {
>  			pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>  				crash_size);
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

