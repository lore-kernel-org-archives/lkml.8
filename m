Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4C6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8573E20721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgEUJfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 05:35:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48810 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728700AbgEUJfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 05:35:11 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7F2FEE3A1CFA707ED67B;
        Thu, 21 May 2020 17:35:02 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 21 May 2020 17:34:56 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <dyoung@redhat.com>,
        <bhe@redhat.com>, <robh+dt@kernel.org>
CC:     <arnd@arndb.de>, <John.p.donnelly@oracle.com>,
        <pkushwaha@marvell.com>, <horms@verge.net.au>,
        <guohanjun@huawei.com>, <chenzhou10@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>
Subject: [PATCH v8 0/5] support reserving crashkernel above 4G on arm64 kdump
Date:   Thu, 21 May 2020 17:38:00 +0800
Message-ID: <20200521093805.64398-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enable reserving crashkernel above 4G in arm64.

There are following issues in arm64 kdump:
1. We use crashkernel=X to reserve crashkernel below 4G, which will fail
when there is no enough low memory.
2. Currently, crashkernel=Y@X can be used to reserve crashkernel above 4G,
in this case, if swiotlb or DMA buffers are required, crash dump kernel
will boot failure because there is no low memory available for allocation.

To solve these issues, introduce crashkernel=X,low to reserve specified
size low memory.
Crashkernel=X tries to reserve memory for the crash dump kernel under
4G. If crashkernel=Y,low is specified simultaneously, reserve spcified
size low memory for crash kdump kernel devices firstly and then reserve
memory above 4G.

When crashkernel is reserved above 4G in memory, that is, crashkernel=X,low
is specified simultaneously, kernel should reserve specified size low memory
for crash dump kernel devices. So there may be two crash kernel regions, one
is below 4G, the other is above 4G.
In order to distinct from the high region and make no effect to the use of
kexec-tools, rename the low region as "Crash kernel (low)", and add DT property
"linux,low-memory-range" to crash dump kernel's dtb to pass the low region.

Besides, we need to modify kexec-tools:
arm64: kdump: add another DT property to crash dump kernel's dtb(see [1])

The previous changes and discussions can be retrieved from:

Changes since [v7]
- Move x86 CRASH_ALIGN to 2M
Suggested by Dave and do some test, move x86 CRASH_ALIGN to 2M.
- Update Documentation/devicetree/bindings/chosen.txt 
Add corresponding documentation to Documentation/devicetree/bindings/chosen.txt suggested by Arnd.
- Add Tested-by from Jhon and pk

Changes since [v6]
- Fix build errors reported by kbuild test robot.

Changes since [v5]
- Move reserve_crashkernel_low() into kernel/crash_core.c.
- Delete crashkernel=X,high.
- Modify crashkernel=X,low.
If crashkernel=X,low is specified simultaneously, reserve spcified size low
memory for crash kdump kernel devices firstly and then reserve memory above 4G.
In addition, rename crashk_low_res as "Crash kernel (low)" for arm64, and then
pass to crash dump kernel by DT property "linux,low-memory-range".
- Update Documentation/admin-guide/kdump/kdump.rst.

Changes since [v4]
- Reimplement memblock_cap_memory_ranges for multiple ranges by Mike.

Changes since [v3]
- Add memblock_cap_memory_ranges back for multiple ranges.
- Fix some compiling warnings.

Changes since [v2]
- Split patch "arm64: kdump: support reserving crashkernel above 4G" as
two. Put "move reserve_crashkernel_low() into kexec_core.c" in a separate
patch.

Changes since [v1]:
- Move common reserve_crashkernel_low() code into kernel/kexec_core.c.
- Remove memblock_cap_memory_ranges() i added in v1 and implement that
in fdt_enforce_memory_region().
There are at most two crash kernel regions, for two crash kernel regions
case, we cap the memory range [min(regs[*].start), max(regs[*].end)]
and then remove the memory range in the middle.

[1]: http://lists.infradead.org/pipermail/kexec/2020-May/025128.html
[v1]: https://lkml.org/lkml/2019/4/2/1174
[v2]: https://lkml.org/lkml/2019/4/9/86
[v3]: https://lkml.org/lkml/2019/4/9/306
[v4]: https://lkml.org/lkml/2019/4/15/273
[v5]: https://lkml.org/lkml/2019/5/6/1360
[v6]: https://lkml.org/lkml/2019/8/30/142
[v7]: https://lkml.org/lkml/2019/12/23/411

Chen Zhou (5):
  x86: kdump: move reserve_crashkernel_low() into crash_core.c
  arm64: kdump: reserve crashkenel above 4G for crash dump kernel
  arm64: kdump: add memory for devices by DT property, low-memory-range
  kdump: update Documentation about crashkernel on arm64
  dt-bindings: chosen: Document linux,low-memory-range for arm64 kdump

 Documentation/admin-guide/kdump/kdump.rst     | 13 ++-
 .../admin-guide/kernel-parameters.txt         | 12 ++-
 Documentation/devicetree/bindings/chosen.txt  | 25 ++++++
 arch/arm64/kernel/setup.c                     |  8 +-
 arch/arm64/mm/init.c                          | 61 ++++++++++++-
 arch/x86/kernel/setup.c                       | 66 ++------------
 include/linux/crash_core.h                    |  3 +
 include/linux/kexec.h                         |  2 -
 kernel/crash_core.c                           | 85 +++++++++++++++++++
 kernel/kexec_core.c                           | 17 ----
 10 files changed, 208 insertions(+), 84 deletions(-)

-- 
2.20.1

