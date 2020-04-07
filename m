Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF17C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E896D206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WMueFxck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbgDGPBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:01:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58714 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728917AbgDGPBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586271705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=AF7Rel5LO4XBz6MttPesae+/BrIA3c18+PEN6n9w9Hw=;
        b=WMueFxck1YhSDWZChYKIQQ8qvH5wkpOZrIu1qUdLWY+l6pZ/ew82DyR/JyQGQBxR+LecxF
        zIQHMt+C9CGfZCL+5iRo5wMcN+GtactIF6eSkPRNHBzPmxUu+Da8jzBYaT0PVlrlYWN5nO
        bYh4+MsW3Et9SEo7ZVwUwl2rwJegy0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-U-pgugmlO62_SadVrITTjQ-1; Tue, 07 Apr 2020 11:01:41 -0400
X-MC-Unique: U-pgugmlO62_SadVrITTjQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B95B190B2A2;
        Tue,  7 Apr 2020 15:01:39 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C36A910027A4;
        Tue,  7 Apr 2020 15:01:36 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 037F1auk029412;
        Tue, 7 Apr 2020 11:01:36 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 037F1XBj029408;
        Tue, 7 Apr 2020 11:01:33 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 7 Apr 2020 11:01:33 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
cc:     x86@kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dm-devel@redhat.com
Subject: [PATCH] memcpy_flushcache: use cache flusing for larger lengths
Message-ID: <alpine.LRH.2.02.2004071029270.8662@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ resending this to x86 maintainers ]

Hi

I tested performance of various methods how to write to optane-based 
persistent memory, and found out that non-temporal stores achieve 
throughput 1.3 GB/s. 8 cached stores immediatelly followed by clflushopt 
or clwb achieve throughput 1.6 GB/s.

memcpy_flushcache uses non-temporal stores, I modified it to use cached 
stores + clflushopt and it improved performance of the dm-writecache 
target significantly:

dm-writecache throughput:
(dd if=/dev/zero of=/dev/mapper/wc bs=64k oflag=direct)
writecache block size   512             1024            2048            4096
movnti                  496 MB/s        642 MB/s        725 MB/s        744 MB/s
clflushopt              373 MB/s        688 MB/s        1.1 GB/s        1.2 GB/s

For block size 512, movnti works better, for larger block sizes, 
clflushopt is better.

I was also testing the novafs filesystem, it is not upstream, but it 
benefitted from similar change in __memcpy_flushcache and 
__copy_user_nocache:
write throughput on big files - movnti: 662 MB/s, clwb: 1323 MB/s
write throughput on small files - movnti: 621 MB/s, clwb: 1013 MB/s


I submit this patch for __memcpy_flushcache that improves dm-writecache 
performance.

Other ideas - should we introduce memcpy_to_pmem instead of modifying 
memcpy_flushcache and move this logic there? Or should I modify the 
dm-writecache target directly to use clflushopt with no change to the 
architecture-specific code?

Mikulas




From: Mikulas Patocka <mpatocka@redhat.com>

I tested dm-writecache performance on a machine with Optane nvdimm and it
turned out that for larger writes, cached stores + cache flushing perform
better than non-temporal stores. This is the throughput of dm-writecache
measured with this command:
dd if=/dev/zero of=/dev/mapper/wc bs=64 oflag=direct

block size	512		1024		2048		4096
movnti		496 MB/s	642 MB/s	725 MB/s	744 MB/s
clflushopt	373 MB/s	688 MB/s	1.1 GB/s	1.2 GB/s

We can see that for smaller block, movnti performs better, but for larger
blocks, clflushopt has better performance.

This patch changes the function __memcpy_flushcache accordingly, so that
with size >= 768 it performs cached stores and cache flushing. Note that
we must not use the new branch if the CPU doesn't have clflushopt - in
that case, the kernel would use inefficient "clflush" instruction that has
very bad performance.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 arch/x86/lib/usercopy_64.c |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

Index: linux-2.6/arch/x86/lib/usercopy_64.c
===================================================================
--- linux-2.6.orig/arch/x86/lib/usercopy_64.c	2020-03-24 15:15:36.644945091 -0400
+++ linux-2.6/arch/x86/lib/usercopy_64.c	2020-03-30 07:17:51.450290007 -0400
@@ -152,6 +152,42 @@ void __memcpy_flushcache(void *_dst, con
 			return;
 	}
 
+	if (static_cpu_has(X86_FEATURE_CLFLUSHOPT) && size >= 768 && likely(boot_cpu_data.x86_clflush_size == 64)) {
+		while (!IS_ALIGNED(dest, 64)) {
+			asm("movq    (%0), %%r8\n"
+			    "movnti  %%r8,   (%1)\n"
+			    :: "r" (source), "r" (dest)
+			    : "memory", "r8");
+			dest += 8;
+			source += 8;
+			size -= 8;
+		}
+		do {
+			asm("movq    (%0), %%r8\n"
+			    "movq   8(%0), %%r9\n"
+			    "movq  16(%0), %%r10\n"
+			    "movq  24(%0), %%r11\n"
+			    "movq    %%r8,   (%1)\n"
+			    "movq    %%r9,  8(%1)\n"
+			    "movq   %%r10, 16(%1)\n"
+			    "movq   %%r11, 24(%1)\n"
+			    "movq  32(%0), %%r8\n"
+			    "movq  40(%0), %%r9\n"
+			    "movq  48(%0), %%r10\n"
+			    "movq  56(%0), %%r11\n"
+			    "movq    %%r8, 32(%1)\n"
+			    "movq    %%r9, 40(%1)\n"
+			    "movq   %%r10, 48(%1)\n"
+			    "movq   %%r11, 56(%1)\n"
+			    :: "r" (source), "r" (dest)
+			    : "memory", "r8", "r9", "r10", "r11");
+			clflushopt((void *)dest);
+			dest += 64;
+			source += 64;
+			size -= 64;
+		} while (size >= 64);
+	}
+
 	/* 4x8 movnti loop */
 	while (size >= 32) {
 		asm("movq    (%0), %%r8\n"

