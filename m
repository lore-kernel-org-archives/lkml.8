Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C2EC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50BD20836
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgCBSR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:17:28 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:60683 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgCBSR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:17:28 -0500
Received: from methusalix.internal.home.lespocky.de ([109.250.99.45]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MhCq4-1jeKsj2SoM-00eP3P; Mon, 02 Mar 2020 19:16:51 +0100
Received: from lemmy.internal.home.lespocky.de ([192.168.243.175] helo=lemmy.home.lespocky.de)
        by methusalix.internal.home.lespocky.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <alex@home.lespocky.de>)
        id 1j8pcV-00019g-Di; Mon, 02 Mar 2020 19:16:48 +0100
Received: (nullmailer pid 21156 invoked by uid 2001);
        Mon, 02 Mar 2020 18:16:47 -0000
From:   Alexander Dahl <post@lespocky.de>
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        Alexander Dahl <post@lespocky.de>
Subject: [PATCH] dma: Fix max PFN arithmetic overflow on 32 bit systems
Date:   Mon,  2 Mar 2020 19:16:12 +0100
Message-Id: <20200302181612.20597-1-post@lespocky.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scan-Signature: 7719f4cb0a203ae1a5f64d3866c1573d
X-Provags-ID: V03:K1:8B37tE9F2d8izwA/UGPTWbhBuKeo+jRutJy6I7/WLDKVHQsW/DV
 iO1kegFF2RaNOdoRni9TU0dRHbMUJ+9k6MAoADpjWanR5E/IJ3yKmUSHB9nQTMtU4j0mFzk
 Kj8TCvHP9wnYrUG2gIITeaGUAaDG8HcLt0iTCr9RT+VCz1KwuWOtQRu4sWCTBRz3y/XCza/
 qxffYem9wHCi6lbSMMYnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rnpPttj3NGg=:Mr3Pecror39pfDvFqmoom6
 luO0uKV28oTDMnPJSsBAGB6ck0JCdKr5UsxhuAhfrqHP8/Ug4fx7fqLE5I5PoXIxdyk4RBb4c
 sQ2g/vb2dfNGjVE8ZC1t9xzDrh8/jrwleIt2J8gr088eHfFLye226Fq3w8Xp7mz2eaOpcTxlz
 Q/7+dkqhvlpIY0shFQoHk8BzhH+5/+jHwd9BWqjEW/C7VPEtjET5eTkI6khDzaNRwZERw7Lwh
 FF+zjsG8pZm76Ki0+FEPvI2TZnAms6OM6McQ0Td7zlZr+ozp7DkQWOCQohhNtAYo51vclvD5v
 ESj38IweKQtfRghLkHZtKHDt9wiyxmtGa/pIBD4U2WyFkGP3gNveyWXfZ+3XBJRFQduYCuSBM
 T73MSBcA9NBpWeftQEz/Yf0Pu+C+O5vsaFWCuwosgjKBjSb0Dmsel7T3LBdVRV4jI1WPMwqxF
 ZXWjR9XFv61ZvTFccun7Km7XC7Jm5A7iGijSCveg7c+NpTiqKHM1uqBuUKcZSMCg/HBG7cC+W
 QDk32pSh6sM5Vxe8G6PxhIYwZbqGyARzNKX/pvs0R9YtsgfIHwKoEpC+3N4ruinC0la02SI7A
 Ng2Ro1Wels0uTkLmkWgpX7hYRSdU/i43v7ChE/yl5VTqgxRBQXZNZ1Af036uMCOXWDPuU8uQu
 2JdIoizWvntYOa8xWQVaT7FN09C2J02b3j17NqZoTBwaaS6CMAcKfIGToJHvqPqm+SFgss/Ik
 VBFsKxx7gP+ay2uZiKOPIxuGq1XxWGUVP0C99d5S03q7Rh84neRUdnC2TNIM4QGZmhZYyVq/t
 V8AfUmMEM4wOJWXSyk74gM/NaPHKfuHJkhWwq0pXUDcPRB+duFXq14rYhuMjnjDksthzBLq
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For ARCH=x86 (32 bit) when you set CONFIG_IOMMU_INTEL since c5a5dc4cbbf4
("iommu/vt-d: Don't switch off swiotlb if bounce page is used") there's
a dependency on CONFIG_SWIOTLB, which was not necessarily active before.

The init code for swiotlb in 'pci_swiotlb_detect_4gb()' compares
something against MAX_DMA32_PFN to decide if it should be active.
However that define suffers from an arithmetic overflow since
1b7e03ef7570 ("x86, NUMA: Enable emulation on 32bit too") when it was
first made visible to x86_32.

The effect is at boot time 64 MiB (default size) were allocated for
bounce buffers now, which is a noticeable amount of memory on small
systems. We noticed this effect on the fli4l Linux distribution when
migrating from kernel v4.19 (LTS) to v5.4 (LTS) on boards like pcengines
ALIX 2D3 with 256 MiB memory for example:

  Linux version 5.4.22 (buildroot@buildroot) (gcc version 7.3.0 (Buildroot 2018.02.8)) #1 SMP Mon Nov 26 23:40:00 CET 2018
  …
  Memory: 183484K/261756K available (4594K kernel code, 393K rwdata, 1660K rodata, 536K init, 456K bss , 78272K reserved, 0K cma-reserved, 0K highmem)
  …
  PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
  software IO TLB: mapped [mem 0x0bb78000-0x0fb78000] (64MB)

The initial analysis and the suggested fix was done by user 'sourcejedi'
at stackoverflow and explicitly marked as GPLv2 for inclusion in the
Linux kernel:

  https://unix.stackexchange.com/a/520525/50007

Fixes: https://web.nettworks.org/bugs/browse/FFL-2560
Fixes: https://unix.stackexchange.com/q/520065/50007
Suggested-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Signed-off-by: Alexander Dahl <post@lespocky.de>
---
We tested this in qemu and on real hardware with fli4l on top of v5.4,
v5.5, and v5.6-rc kernels, but only as far as the reserved memory goes.
The patch itself is based on v5.6-rc3 (IIRC).

A quick grep over the kernel code showed me this define MAX_DMA32_PFN is
used in other places as well. I would appreciate feedback on this,
because I can not oversee all side effects this might have?!

Thanks again to Alan who proposed the fix, and for his permission to
send it upstream.

Greets
Alex
---
 arch/x86/include/asm/dma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/dma.h b/arch/x86/include/asm/dma.h
index 00f7cf45e699..e25514eca8d6 100644
--- a/arch/x86/include/asm/dma.h
+++ b/arch/x86/include/asm/dma.h
@@ -74,7 +74,7 @@
 #define MAX_DMA_PFN   ((16UL * 1024 * 1024) >> PAGE_SHIFT)
 
 /* 4GB broken PCI/AGP hardware bus master zone */
-#define MAX_DMA32_PFN ((4UL * 1024 * 1024 * 1024) >> PAGE_SHIFT)
+#define MAX_DMA32_PFN (4UL * ((1024 * 1024 * 1024) >> PAGE_SHIFT))
 
 #ifdef CONFIG_X86_32
 /* The maximum address that we can perform a DMA transfer to on this platform */
-- 
2.20.1

