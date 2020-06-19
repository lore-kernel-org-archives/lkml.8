Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06031C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D844420809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592581968;
	bh=1nqs4DqbgeZgMHpBxJQRypqiP9gwPyGbe6RIQZ4mk84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tVq0ryLw9GJf5XV4u2lAF6So6zfJYgiHn5gwysEj2Plx7xKXN6Q3aElUSnGvbBQzW
	 CLm4nb2kBB/+XBjotfPWv0jcEve2VI73Gr57KOb/TG5n1x8AeVvSp0CfikI5KRS7V1
	 hfVQlCnf0C6dJI0n8zYrOhg9T/F97MvLgFGs8dHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392222AbgFSPwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:52:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727032AbgFSPW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:22:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1549E21582;
        Fri, 19 Jun 2020 15:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580177;
        bh=1nqs4DqbgeZgMHpBxJQRypqiP9gwPyGbe6RIQZ4mk84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lzYyD4VL7F9Aya/qYS1MLuJPl/+8LiNS7+J0yPA+hyMrxe/NZP8riCK7VXHiZJ+qj
         i/coBp2Y0R9rintOu2xTgwe3nirIwuALPmryyoMbZdDYHIloduCgN0bHW3x8GMF4oc
         EU16qH3oH8n6cgeEDriq89StCpA4i2B1D87BDq8E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 111/376] efi/libstub/random: Align allocate size to EFI_ALLOC_ALIGN
Date:   Fri, 19 Jun 2020 16:30:29 +0200
Message-Id: <20200619141715.603524839@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

[ Upstream commit e1df73e2d18b3b7d66f2ec38d81d9566b3a7fb21 ]

The EFI stub uses a per-architecture #define for the minimum base
and size alignment of page allocations, which is set to 4 KB for
all architecures except arm64, which uses 64 KB, to ensure that
allocations can always be (un)mapped efficiently, regardless of
the page size used by the kernel proper, which could be a kexec'ee

The API wrappers around page based allocations assume that this
alignment is always taken into account, and so efi_free() will
also round up its size argument to EFI_ALLOC_ALIGN.

Currently, efi_random_alloc() does not honour this alignment for
the allocated size, and so freeing such an allocation may result
in unrelated memory to be freed, potentially leading to issues
after boot. So let's round up size in efi_random_alloc() as well.

Fixes: 2ddbfc81eac84a29 ("efi: stub: add implementation of efi_random_alloc()")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/libstub/randomalloc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index 4578f59e160c..6200dfa650f5 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -74,6 +74,8 @@ efi_status_t efi_random_alloc(unsigned long size,
 	if (align < EFI_ALLOC_ALIGN)
 		align = EFI_ALLOC_ALIGN;
 
+	size = round_up(size, EFI_ALLOC_ALIGN);
+
 	/* count the suitable slots in each memory map entry */
 	for (map_offset = 0; map_offset < map_size; map_offset += desc_size) {
 		efi_memory_desc_t *md = (void *)memory_map + map_offset;
@@ -109,7 +111,7 @@ efi_status_t efi_random_alloc(unsigned long size,
 		}
 
 		target = round_up(md->phys_addr, align) + target_slot * align;
-		pages = round_up(size, EFI_PAGE_SIZE) / EFI_PAGE_SIZE;
+		pages = size / EFI_PAGE_SIZE;
 
 		status = efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
 				     EFI_LOADER_DATA, pages, &target);
-- 
2.25.1



