Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D589C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 633182078B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="wgV+HQ8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgGIS12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgGIS1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:27:20 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B037FC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 11:27:19 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k5so1154205plk.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 11:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=CX4+62PhknVXUdLMwiSWKRCmW3vKZehIunEgFfO23pk=;
        b=wgV+HQ8IzCZw4u85wSWv0uFcdU8JRUHxWUOJw3nUNCJg0V7JtiXq9HGIHvCJwy0rU4
         5NauoUVqQnXcquFoyXjiIj9oarJ08Xw96QE3ykDMiYPXQSta/D700HWhrKl5Vouwqfic
         sPIzjXuXy2OHVKPZDZuWVY/AAZvgf67cRjIIL5K3hAq5dYFywytI9E2HLRDqMatjSYHg
         rKPTbFroPXaZCtHfzKnC5s7krVrLd6GYXc9hQVoorI7+eqTmhCbzW5mX9WMNPAeI3E8T
         iWh2YarBX1GJP6kJlsBCn1uE476I6PduPB7TPOCtSmgDn2ifoOoUQ6DuhGG3dp14FZsE
         jHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=CX4+62PhknVXUdLMwiSWKRCmW3vKZehIunEgFfO23pk=;
        b=pjP+TcIcn/mtNAfKPCYMhwW+m/lK9YwL0EcRQEn2+g7sMOAOxMlCO0X5bP8+wVT2z0
         WUcAScDwrWxM4Rh7EJDM3SCZr5CcadMvQfklBvDbrbVpLy23rKBZuvibq+f9eQ7k02QX
         G3rtuCJWW2zgiu1kSuh0haq876tvxyWO2TBV+xN+fGp9sy4/ceGFq1muvpR9NTXkS1vZ
         EDisYtfPCsiEWqogj4TACyV62tDwt+U8tKJrCirVxp/JkBenDWqas5AwstA7yrrld6gr
         6NiEs3ytE/KDmp7zp5FbuGUi1ff6UR344XWIIVOqGjYMkXRVX+NNM9YGWAIf1JZoOPEP
         qWWg==
X-Gm-Message-State: AOAM532CkYBLbAXJiW3qQ9OWw/9GQyRrejo9mlyaRwRJvz+Yfaaoz08U
        KZdsve0cSgW3yfbvHQkh4UR5aw==
X-Google-Smtp-Source: ABdhPJzxG/jyzCXqn27lyEUywkbLI2zMYmWvsiVaPaozDnjrB06A0bRJUjVKi+RMxTl5smlkIHzqvA==
X-Received: by 2002:a17:90b:4ace:: with SMTP id mh14mr1423091pjb.139.1594319239021;
        Thu, 09 Jul 2020 11:27:19 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id s22sm3531604pfm.164.2020.07.09.11.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 11:27:18 -0700 (PDT)
Date:   Thu, 09 Jul 2020 11:27:18 -0700 (PDT)
X-Google-Original-Date: Thu, 09 Jul 2020 11:25:29 PDT (-0700)
Subject:     Re: [PATCH 1/2] riscv: Register System RAM as iomem resources
In-Reply-To: <063fab26f4c15bf5b833b57fa818749afa7811d4.1592292685.git.zong.li@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-cd7e19bb-859a-45a4-90e8-7851c4fb3083@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 00:45:46 PDT (-0700), zong.li@sifive.com wrote:
> Add System RAM to /proc/iomem, various tools expect it such as kdump.
> It is also needed for page_is_ram API which checks the specified address
> whether registered as System RAM in iomem_resource list.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/mm/init.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index f4adb3684f3d..bbe816e03b2f 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -517,6 +517,27 @@ void mark_rodata_ro(void)
>  }
>  #endif
>
> +void __init resource_init(void)
> +{
> +	struct memblock_region *region;
> +
> +	for_each_memblock(memory, region) {
> +		struct resource *res;
> +
> +		res = memblock_alloc(sizeof(struct resource), SMP_CACHE_BYTES);
> +		if (!res)
> +			panic("%s: Failed to allocate %zu bytes\n", __func__,
> +			      sizeof(struct resource));
> +
> +		res->name = "System RAM";
> +		res->start = __pfn_to_phys(memblock_region_memory_base_pfn(region));
> +		res->end = __pfn_to_phys(memblock_region_memory_end_pfn(region)) - 1;
> +		res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;

Looks like everyone else is checking MEMBLOCK_NOMAP before registering memory
regions.  I've added that and put this on for-next.  Thanks!

commit 11dc632bf515874c84887727614e8044452f1f28
gpg: Signature made Thu 09 Jul 2020 11:24:08 AM PDT
gpg:                using RSA key 2B3C3747446843B24A943A7A2E1319F35FBB1889
gpg:                issuer "palmer@dabbelt.com"
gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
gpg:                 aka "Palmer Dabbelt <palmerdabbelt@google.com>" [ultimate]
Author: Zong Li <zong.li@sifive.com>
Date:   Tue Jun 16 15:45:46 2020 +0800

    riscv: Register System RAM as iomem resources
    
    Add System RAM to /proc/iomem, various tools expect it such as kdump.
    It is also needed for page_is_ram API which checks the specified address
    whether registered as System RAM in iomem_resource list.
    
    Signed-off-by: Zong Li <zong.li@sifive.com>
    [Palmer: check MEMBLOCK_NOMAP]
    Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index f4adb3684f3d..8b78fd23713e 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -517,6 +517,32 @@ void mark_rodata_ro(void)
 }
 #endif
 
+void __init resource_init(void)
+{
+	struct memblock_region *region;
+
+	for_each_memblock(memory, region) {
+		struct resource *res;
+
+		res = memblock_alloc(sizeof(struct resource), SMP_CACHE_BYTES);
+		if (!res)
+			panic("%s: Failed to allocate %zu bytes\n", __func__,
+			      sizeof(struct resource));
+
+		if (memblock_is_nomap(region) {
+			res->name = "reserved";
+			res->flags = IORESOURCE_MEM;
+		} else {
+			res->name = "System RAM";
+			res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+		}
+		res->start = __pfn_to_phys(memblock_region_memory_base_pfn(region));
+		res->end = __pfn_to_phys(memblock_region_memory_end_pfn(region)) - 1;
+
+		request_resource(&iomem_resource, res);
+	}
+}
+
 void __init paging_init(void)
 {
 	setup_vm_final();
@@ -524,6 +550,7 @@ void __init paging_init(void)
 	sparse_init();
 	setup_zero_page();
 	zone_sizes_init();
+	resource_init();
 }
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP


> +
> +		request_resource(&iomem_resource, res);
> +	}
> +}
> +
>  void __init paging_init(void)
>  {
>  	setup_vm_final();
> @@ -524,6 +545,7 @@ void __init paging_init(void)
>  	sparse_init();
>  	setup_zero_page();
>  	zone_sizes_init();
> +	resource_init();
>  }
>
>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
