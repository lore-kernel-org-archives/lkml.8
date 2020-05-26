Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC94C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 01:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C757E2071C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 01:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBcUjXew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388586AbgEZBnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 21:43:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46185 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387794AbgEZBnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 21:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590457384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=90A2V+s9G7+5U5tOSG/V9yeg3CjImgO19y8K0xgH3vo=;
        b=ZBcUjXewX8p6W31MrW+CRIKTiV9gJxESlCkPyI2yU5AZ+iGy5ZUdPeM2AbYhjZMphaWCXo
        4R6KMHw8hhY9lvaHigTmzOFLYl4tg1f5JgXYdisQNkCgiwPVk1R3SgwPolpDnaSAN0S8wz
        SQxWwvpZNbE7S7i4o8H3eAeVVkxyqIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-UgCT4IApOH-CVovWkXx76g-1; Mon, 25 May 2020 21:42:50 -0400
X-MC-Unique: UgCT4IApOH-CVovWkXx76g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C5E8107ACCD;
        Tue, 26 May 2020 01:42:48 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0850879C3E;
        Tue, 26 May 2020 01:42:44 +0000 (UTC)
Date:   Tue, 26 May 2020 09:42:42 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, catalin.marinas@arm.com,
        will@kernel.org, dyoung@redhat.com, robh+dt@kernel.org,
        John.p.donnelly@oracle.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        horms@verge.net.au, guohanjun@huawei.com, pkushwaha@marvell.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 0/5] support reserving crashkernel above 4G on arm64
 kdump
Message-ID: <20200526014242.GF20045@MiWiFi-R3L-srv>
References: <20200521093805.64398-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521093805.64398-1-chenzhou10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/21/20 at 05:38pm, Chen Zhou wrote:
> This patch series enable reserving crashkernel above 4G in arm64.
> 
> There are following issues in arm64 kdump:
> 1. We use crashkernel=X to reserve crashkernel below 4G, which will fail
> when there is no enough low memory.
> 2. Currently, crashkernel=Y@X can be used to reserve crashkernel above 4G,
> in this case, if swiotlb or DMA buffers are required, crash dump kernel
> will boot failure because there is no low memory available for allocation.
> 
> To solve these issues, introduce crashkernel=X,low to reserve specified
> size low memory.
> Crashkernel=X tries to reserve memory for the crash dump kernel under
> 4G. If crashkernel=Y,low is specified simultaneously, reserve spcified
> size low memory for crash kdump kernel devices firstly and then reserve
> memory above 4G.
> 
> When crashkernel is reserved above 4G in memory, that is, crashkernel=X,low
> is specified simultaneously, kernel should reserve specified size low memory
> for crash dump kernel devices. So there may be two crash kernel regions, one
> is below 4G, the other is above 4G.
> In order to distinct from the high region and make no effect to the use of
> kexec-tools, rename the low region as "Crash kernel (low)", and add DT property
> "linux,low-memory-range" to crash dump kernel's dtb to pass the low region.
> 
> Besides, we need to modify kexec-tools:
> arm64: kdump: add another DT property to crash dump kernel's dtb(see [1])
> 
> The previous changes and discussions can be retrieved from:
> 
> Changes since [v7]
> - Move x86 CRASH_ALIGN to 2M
> Suggested by Dave and do some test, move x86 CRASH_ALIGN to 2M.

OK, moving x86 CRASH_ALIGN to 2M is suggested by Dave. Because
CONFIG_PHYSICAL_ALIGN can be selected from 2M to 16M. So 2M seems good.
But, anyway, we should tell the reason why it need be changed in commit
log.


arch/x86/Kconfig:
config PHYSICAL_ALIGN
        hex "Alignment value to which kernel should be aligned"
        default "0x200000"
        range 0x2000 0x1000000 if X86_32
        range 0x200000 0x1000000 if X86_64

> - Update Documentation/devicetree/bindings/chosen.txt 
> Add corresponding documentation to Documentation/devicetree/bindings/chosen.txt suggested by Arnd.
> - Add Tested-by from Jhon and pk
> 
> Changes since [v6]
> - Fix build errors reported by kbuild test robot.
> 
> Changes since [v5]
> - Move reserve_crashkernel_low() into kernel/crash_core.c.
> - Delete crashkernel=X,high.

And the crashkernel=X,high being deleted need be told too. Otherwise
people reading the commit have to check why themselves. I didn't follow
the old version, can't see why ,high can't be specified explicitly.

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
> [1]: http://lists.infradead.org/pipermail/kexec/2020-May/025128.html
> [v1]: https://lkml.org/lkml/2019/4/2/1174
> [v2]: https://lkml.org/lkml/2019/4/9/86
> [v3]: https://lkml.org/lkml/2019/4/9/306
> [v4]: https://lkml.org/lkml/2019/4/15/273
> [v5]: https://lkml.org/lkml/2019/5/6/1360
> [v6]: https://lkml.org/lkml/2019/8/30/142
> [v7]: https://lkml.org/lkml/2019/12/23/411
> 
> Chen Zhou (5):
>   x86: kdump: move reserve_crashkernel_low() into crash_core.c
>   arm64: kdump: reserve crashkenel above 4G for crash dump kernel
>   arm64: kdump: add memory for devices by DT property, low-memory-range
>   kdump: update Documentation about crashkernel on arm64
>   dt-bindings: chosen: Document linux,low-memory-range for arm64 kdump
> 
>  Documentation/admin-guide/kdump/kdump.rst     | 13 ++-
>  .../admin-guide/kernel-parameters.txt         | 12 ++-
>  Documentation/devicetree/bindings/chosen.txt  | 25 ++++++
>  arch/arm64/kernel/setup.c                     |  8 +-
>  arch/arm64/mm/init.c                          | 61 ++++++++++++-
>  arch/x86/kernel/setup.c                       | 66 ++------------
>  include/linux/crash_core.h                    |  3 +
>  include/linux/kexec.h                         |  2 -
>  kernel/crash_core.c                           | 85 +++++++++++++++++++
>  kernel/kexec_core.c                           | 17 ----
>  10 files changed, 208 insertions(+), 84 deletions(-)
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

