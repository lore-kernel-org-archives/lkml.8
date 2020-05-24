Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39539C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 16:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0637C20812
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 16:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590339247;
	bh=tbfyF8Gc0VJZg/qt06s+XuPIZbuK7GsvX8u3HOrwBQY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=m0A8GbU7rITOV9kVVnjmbMNNHw0xEcbtVS/v6hoCCYOaFegwT+ZKzgoaYgOt0xShu
	 KHJkY986ETIOwd21EyZwiU/787d2pbOdICOProaX7ZhB4tfXrJGZ4ZkkiaXZc+RtiB
	 MMLEOJWLk9wnM6mEVCboKqyXuTpF1Ws2Mb/hxDcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387760AbgEXQyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 12:54:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:34050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728375AbgEXQyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 12:54:05 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5264B2073B;
        Sun, 24 May 2020 16:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590339245;
        bh=tbfyF8Gc0VJZg/qt06s+XuPIZbuK7GsvX8u3HOrwBQY=;
        h=From:To:Cc:Subject:Date:From;
        b=lgVmuHWzTKcfFO926HF7v+JvUBv/SAafc4WDxcrRf1btKKf9XdaKY99pxOWRYvR3o
         cScRHiUgRP1zyTfdcx5N0AS1O53w6n/k9rY4271Bk2ptxtvsMFCW0A6E9BlPTGqL4Y
         2TEXdt6SqEojy7Nvm6HJ9m+wBUQ2ofw1Cdz0N1j4=
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] sparc32: register memory occupied by kernel as memblock.memory
Date:   Sun, 24 May 2020 19:53:58 +0300
Message-Id: <20200524165358.27188-1-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

sparc32 never registered the memory occupied by the kernel image with
memblock_add() and it only reserved this memory with meblock_reserve().

With openbios as system firmware, the memory occupied by the kernel is
reserved in openbios and removed from mem.available. The prom setup code in
the kernel uses mem.available to set up the memory banks and essentially
there is a hole for the memory occupied by the kernel image.

Later in bootmem_init() this memory is memblock_reserve()d.

Up until recently, memmap initialization would call __init_single_page()
for the pages in that hole, the free_low_memory_core_early() would mark
them as reserved and everything would be Ok.

After the change in memmap initialization introduced by the commit "mm:
memmap_init: iterate over memblock regions rather that check each PFN", the
hole is skipped and the page structs for it are not initialized. And when
they are passed from memblock to page allocator as reserved, the latter
gets confused.

Simply registering the memory occupied by the kernel with memblock_add()
resolves this issue.

Tested on qemu-system-sparc with Debian Etch [1] userspace.

[1] https://people.debian.org/~aurel32/qemu/sparc/debian_etch_sparc_small.qcow2

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Link: https://lkml.kernel.org/r/20200517000050.GA87467@roeck-us.nlllllet/ 
---

David,

I'd really appreciate your Ack or an explanation where my analysis is wrong :)

 arch/sparc/mm/init_32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index e45160839f79..eb2946b1df8a 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -192,6 +192,7 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
 	/* Reserve the kernel text/data/bss. */
 	size = (start_pfn << PAGE_SHIFT) - phys_base;
 	memblock_reserve(phys_base, size);
+	memblock_add(phys_base, size);
 
 	size = memblock_phys_mem_size() - memblock_reserved_size();
 	*pages_avail = (size >> PAGE_SHIFT) - high_pages;
-- 
2.26.2

