Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D39BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FB3323117
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fzkzyegv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgHFQ3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:29:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52889 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727977AbgHFQSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596730669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tvRZphwGLcKXWF0F9sTs95B5v17a5GMwIlyltTlNMcU=;
        b=fzkzyegvVUwNy2qYUChW6AtI83fl/hZonENCGf+kPzU5S1NVyVGrMvzCO+ZrM3CGDytMVN
        6PiRCz4o7/ZXJ/8sQ4nIsdCuYdpReDOMcZdCDEos6GB+YOMXh2u/6xPQTXRqLtTe3gA5BI
        W9SyxJRIcoBnstGsdCkRSRNyOK3IgCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-OZxF1WYZN6-uEj33VNIDqQ-1; Thu, 06 Aug 2020 07:38:05 -0400
X-MC-Unique: OZxF1WYZN6-uEj33VNIDqQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 866391B18BC0;
        Thu,  6 Aug 2020 11:38:02 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-96.pek2.redhat.com [10.72.12.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F65119C4F;
        Thu,  6 Aug 2020 11:37:53 +0000 (UTC)
Date:   Thu, 6 Aug 2020 19:37:50 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com,
        tglx@linutronix.de, mingo@redhat.com, bhe@redhat.com,
        corbet@lwn.net, John.P.donnelly@oracle.com,
        prabhakar.pkin@gmail.com, bhsharma@redhat.com,
        wangkefeng.wang@huawei.com, arnd@arndb.de,
        linux-doc@vger.kernel.org, xiexiuqi@huawei.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, horms@verge.net.au, nsaenzjulienne@suse.de,
        huawei.libin@huawei.com, guohanjun@huawei.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v11 0/5] support reserving crashkernel above 4G on arm64
 kdump
Message-ID: <20200806113750.GB2492@dhcp-128-65.nay.redhat.com>
References: <20200801130856.86625-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200801130856.86625-1-chenzhou10@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen,

Thanks for the update. I was busy on other things, I will review your x86/common changes
this weekend or early next week.

On 08/01/20 at 09:08pm, Chen Zhou wrote:
> There are following issues in arm64 kdump:
> 1. We use crashkernel=X to reserve crashkernel below 4G, which
> will fail when there is no enough low memory.
> 2. If reserving crashkernel above 4G, in this case, crash dump
> kernel will boot failure because there is no low memory available
> for allocation.
> 3. Since commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32"),
> if the memory reserved for crash dump kernel falled in ZONE_DMA32,
> the devices in crash dump kernel need to use ZONE_DMA will alloc
> fail.
> 
> To solve these issues, change the behavior of crashkernel=X.
> crashkernel=X tries low allocation in ZONE_DMA, and fall back to
> high allocation if it fails.
> 
> If requized size X is too large and leads to very little free memory
> in ZONE_DMA after low allocation, the system may not work normally.
> So add a threshold and go for high allocation directly if the required
> size is too large. The value of threshold is set as the half of
> the low memory.
> 
> If crash_base is outside ZONE_DMA, try to allocate at least 256M in
> ZONE_DMA automatically. "crashkernel=Y,low" can be used to allocate
> specified size low memory.
> For non-RPi4 platforms, change ZONE_DMA memtioned above to ZONE_DMA32.
> 
> When reserving crashkernel in high memory, some low memory is reserved
> for crash dump kernel devices. So there may be two regions reserved for
> crash dump kernel, one is below 4G, the other is above 4G.
> In order to distinct from the high region and make no effect to the use
> of existing kexec-tools, rename the low region as "Crash kernel (low)",
> and pass the low region by reusing DT property
> "linux,usable-memory-range". We made the low memory region as the last
> range of "linux,usable-memory-range" to keep compatibility with existing
> user-space and older kdump kernels.
> 
> Besides, we need to modify kexec-tools:
> arm64: support more than one crash kernel regions(see [1])
> 
> Another update is document about DT property 'linux,usable-memory-range':
> schemas: update 'linux,usable-memory-range' node schema(see [2])
> 
> Changes since [v10]
> - Reimplement crashkernel=X suggested by Catalin, Many thanks to Catalin.
> 
> Changes since [v9]
> - Patch 1 add Acked-by from Dave.
> - Update patch 5 according to Dave's comments.
> - Update chosen schema.
> 
> Changes since [v8]
> - Reuse DT property "linux,usable-memory-range".
> Suggested by Rob, reuse DT property "linux,usable-memory-range" to pass the low
> memory region.
> - Fix kdump broken with ZONE_DMA reintroduced.
> - Update chosen schema.
> 
> Changes since [v7]
> - Move x86 CRASH_ALIGN to 2M
> Suggested by Dave and do some test, move x86 CRASH_ALIGN to 2M.
> - Update Documentation/devicetree/bindings/chosen.txt.
> Add corresponding documentation to Documentation/devicetree/bindings/chosen.txt
> suggested by Arnd.
> - Add Tested-by from Jhon and pk.
> 
> Changes since [v6]
> - Fix build errors reported by kbuild test robot.
> 
> Changes since [v5]
> - Move reserve_crashkernel_low() into kernel/crash_core.c.
> - Delete crashkernel=X,high.
> - Modify crashkernel=X,low.
> If crashkernel=X,low is specified simultaneously, reserve spcified size low
> memory for crash kdump kernel devices firstly and then reserve memory above 4G.
> In addition, rename crashk_low_res as "Crash kernel (low)" for arm64, and then
> pass to crash dump kernel by DT property "linux,low-memory-range".
> - Update Documentation/admin-guide/kdump/kdump.rst.
> 
> Changes since [v4]
> - Reimplement memblock_cap_memory_ranges for multiple ranges by Mike.
> 
> Changes since [v3]
> - Add memblock_cap_memory_ranges back for multiple ranges.
> - Fix some compiling warnings.
> 
> Changes since [v2]
> - Split patch "arm64: kdump: support reserving crashkernel above 4G" as
> two. Put "move reserve_crashkernel_low() into kexec_core.c" in a separate
> patch.
> 
> Changes since [v1]:
> - Move common reserve_crashkernel_low() code into kernel/kexec_core.c.
> - Remove memblock_cap_memory_ranges() i added in v1 and implement that
> in fdt_enforce_memory_region().
> There are at most two crash kernel regions, for two crash kernel regions
> case, we cap the memory range [min(regs[*].start), max(regs[*].end)]
> and then remove the memory range in the middle.
> 
> [1]: http://lists.infradead.org/pipermail/kexec/2020-June/020737.html
> [2]: https://github.com/robherring/dt-schema/pull/19 
> [v1]: https://lkml.org/lkml/2019/4/2/1174
> [v2]: https://lkml.org/lkml/2019/4/9/86
> [v3]: https://lkml.org/lkml/2019/4/9/306
> [v4]: https://lkml.org/lkml/2019/4/15/273
> [v5]: https://lkml.org/lkml/2019/5/6/1360
> [v6]: https://lkml.org/lkml/2019/8/30/142
> [v7]: https://lkml.org/lkml/2019/12/23/411
> [v8]: https://lkml.org/lkml/2020/5/21/213
> [v9]: https://lkml.org/lkml/2020/6/28/73
> [v10]: https://lkml.org/lkml/2020/7/2/1443
> 
> Chen Zhou (5):
>   arm64: kdump: add macro CRASH_ALIGN and CRASH_ADDR_LOW_MAX
>   x86: kdump: move reserve_crashkernel_low() into crash_core.c
>   arm64: kdump: reimplement crashkernel=X
>   arm64: kdump: add memory for devices by DT property
>     linux,usable-memory-range
>   kdump: update Documentation about crashkernel
> 
>  Documentation/admin-guide/kdump/kdump.rst     | 21 +++-
>  .../admin-guide/kernel-parameters.txt         | 11 ++-
>  arch/arm64/include/asm/kexec.h                |  9 ++
>  arch/arm64/include/asm/processor.h            |  1 +
>  arch/arm64/kernel/setup.c                     |  8 +-
>  arch/arm64/mm/init.c                          | 99 +++++++++++++++----
>  arch/x86/include/asm/kexec.h                  | 24 +++++
>  arch/x86/kernel/setup.c                       | 86 ++--------------
>  include/linux/crash_core.h                    |  3 +
>  include/linux/kexec.h                         |  2 -
>  kernel/crash_core.c                           | 74 ++++++++++++++
>  kernel/kexec_core.c                           | 17 ----
>  12 files changed, 233 insertions(+), 122 deletions(-)
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

