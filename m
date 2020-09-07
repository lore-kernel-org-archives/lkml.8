Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90324C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E8EC2080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbgIGRWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:22:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53352 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729678AbgIGNrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:47:37 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 37044B73E2F5FB36280A;
        Mon,  7 Sep 2020 21:47:04 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Sep 2020 21:46:55 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <dyoung@redhat.com>, <bhe@redhat.com>, <corbet@lwn.net>,
        <John.P.donnelly@oracle.com>, <prabhakar.pkin@gmail.com>,
        <bhsharma@redhat.com>
CC:     <horms@verge.net.au>, <robh+dt@kernel.org>, <arnd@arndb.de>,
        <nsaenzjulienne@suse.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <huawei.libin@huawei.com>,
        <wangkefeng.wang@huawei.com>, <chenzhou10@huawei.com>
Subject: [PATCH v12 9/9] kdump: update Documentation about crashkernel
Date:   Mon, 7 Sep 2020 21:47:45 +0800
Message-ID: <20200907134745.25732-10-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200907134745.25732-1-chenzhou10@huawei.com>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For arm64, the behavior of crashkernel=X has been changed, which
tries low allocation in DMA zone, and fall back to high allocation
if it fails.
We can also use "crashkernel=X,high" to select a high region above
DMA zone, which also tries to allocate at least 256M low memory in
DMA zone automatically.
"crashkernel=Y,low" can be used to allocate specified size low memory
in DMA zone.
For non-RPi4 platforms, change DMA zone memtioned above to DMA32 zone.

For x86 and arm64, we introduce threshold for the required memory.
if required size X is too large and leads to very little free low
memory after low allocation, the system may not work well.
So add a threshold and go for high allocation directly if the required
size is too large. The threshold is set as the half of low memory.

So update the Documentation.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 Documentation/admin-guide/kdump/kdump.rst     | 25 ++++++++++++++++---
 .../admin-guide/kernel-parameters.txt         | 13 ++++++++--
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 2da65fef2a1c..549611abc581 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -299,7 +299,16 @@ Boot into System Kernel
    "crashkernel=64M@16M" tells the system kernel to reserve 64 MB of memory
    starting at physical address 0x01000000 (16MB) for the dump-capture kernel.
 
-   On x86 and x86_64, use "crashkernel=64M@16M".
+   On x86 use "crashkernel=64M@16M".
+
+   On x86_64, use "crashkernel=X" to select a region under 4G first, and
+   fall back to reserve region above 4G. And go for high allocation
+   directly if the required size is too large.
+   We can also use "crashkernel=X,high" to select a region above 4G, which
+   also tries to allocate at least 256M below 4G automatically and
+   "crashkernel=Y,low" can be used to allocate specified size low memory.
+   Use "crashkernel=Y@X" if you really have to reserve memory from specified
+   start address X.
 
    On ppc64, use "crashkernel=128M@32M".
 
@@ -316,8 +325,18 @@ Boot into System Kernel
    kernel will automatically locate the crash kernel image within the
    first 512MB of RAM if X is not given.
 
-   On arm64, use "crashkernel=Y[@X]".  Note that the start address of
-   the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
+   On arm64, use "crashkernel=X" to try low allocation in DMA zone, and
+   fall back to high allocation if it fails. And go for high allocation
+   directly if the required size is too large.
+   We can also use "crashkernel=X,high" to select a high region above
+   DMA zone, which also tries to allocate at least 256M low memory in
+   DMA zone automatically.
+   "crashkernel=Y,low" can be used to allocate specified size low memory
+   in DMA zone.
+   For non-RPi4 platforms, change DMA zone memtioned above to DMA32 zone.
+   Use "crashkernel=Y@X" if you really have to reserve memory from
+   specified start address X. Note that the start address of the kernel,
+   X if explicitly specified, must be aligned to 2MiB (0x200000).
 
 Load the Dump-capture Kernel
 ============================
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a1068742a6df..f7df572d8f64 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -727,6 +727,10 @@
 			[KNL, X86-64] Select a region under 4G first, and
 			fall back to reserve region above 4G when '@offset'
 			hasn't been specified.
+			[KNL, arm64] Try low allocation in DMA zone, fall back
+			to high allocation if it fails when '@offset' hasn't been
+			specified. For non-RPi4 platforms, change DMA zone to
+			DMA32 zone.
 			See Documentation/admin-guide/kdump/kdump.rst for further details.
 
 	crashkernel=range1:size1[,range2:size2,...][@offset]
@@ -743,6 +747,8 @@
 			Otherwise memory region will be allocated below 4G, if
 			available.
 			It will be ignored if crashkernel=X is specified.
+			[KNL, arm64] range in high memory.
+			Allow kernel to allocate physical memory region from top.
 	crashkernel=size[KMG],low
 			[KNL, X86-64] range under 4G. When crashkernel=X,high
 			is passed, kernel could allocate physical memory region
@@ -751,13 +757,16 @@
 			requires at least 64M+32K low memory, also enough extra
 			low memory is needed to make sure DMA buffers for 32-bit
 			devices won't run out. Kernel would try to allocate at
-			at least 256M below 4G automatically.
+			least 256M below 4G automatically.
 			This one let user to specify own low range under 4G
 			for second kernel instead.
 			0: to disable low allocation.
 			It will be ignored when crashkernel=X,high is not used
 			or memory reserved is below 4G.
-
+			[KNL, arm64] range in low memory.
+			This one let user to specify a low range in DMA zone for
+			crash dump kernel. For non-RPi4 platforms, change DMA zone
+			to DMA32 zone.
 	cryptomgr.notests
 			[KNL] Disable crypto self-tests
 
-- 
2.20.1

