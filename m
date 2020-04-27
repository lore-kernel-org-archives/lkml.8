Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9852C83001
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 23:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F7792076A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 23:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LlkDOFKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgD0X5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 19:57:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54376 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726355AbgD0X5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 19:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588031832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TX3l/PsIBBKAEBFp9II7hFHKmsTrVNvxgpKGxnEg3zs=;
        b=LlkDOFKKSF9tfS0L3MVHmnU6/9z8orRFb6HM3Zac80QGiZl21VEBMp+2Rpy+0pb03+tRkY
        wlGTMAsvWw0RSh9SkZa13wnUuvrAYdzlnIUuXEooosnZ1qfJ/Q5aklzKtqDrK4A9wHCwLm
        FJedj46nVj9cs0b7mr62Qqou6DLFxu0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-V-bSCE4gMoyiC7kkAoz9Zg-1; Mon, 27 Apr 2020 19:57:08 -0400
X-MC-Unique: V-bSCE4gMoyiC7kkAoz9Zg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36668107ACCA;
        Mon, 27 Apr 2020 23:57:07 +0000 (UTC)
Received: from localhost.localdomain.com (vpn2-54-127.bne.redhat.com [10.64.54.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B9E960300;
        Mon, 27 Apr 2020 23:57:04 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        steve.capper@arm.com, catalin.marinas@arm.com, broonie@kernel.org,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v2] arm64/kernel: Fix range on invalidating dcache for boot page tables
Date:   Tue, 28 Apr 2020 09:57:00 +1000
Message-Id: <20200427235700.112220-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to commit 8eb7e28d4c642c31 ("arm64/mm: move runtime pgds to
rodata"), idmap_pgd_dir, tramp_pg_dir, reserved_ttbr0, swapper_pg_dir,
and init_pg_dir were contiguous at the end of the kernel image. The
maintenance at the end of __create_page_tables assumed these were
contiguous, and affected everything from the start of idmap_pg_dir
to the end of init_pg_dir.

That commit moved all but init_pg_dir into the .rodata section, with
other data placed between idmap_pg_dir and init_pg_dir, but did not
update the maintenance. Hence the maintenance is performed on much
more data than necessary (but as the bootloader previously made this
clean to the PoC there is no functional problem).

As we only alter idmap_pg_dir, and init_pg_dir, we only need to perform
maintenance for these. As the other dirs are in .rodata, the bootloader
will have initialised them as expected and cleaned them to the PoC. The
kernel will initialize them as necessary after enabling the MMU.

This patch reworks the maintenance to only cover the idmap_pg_dir and
init_pg_dir to avoid this unnecessary work.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
v2: Include the suggested commit log    (Mark Rutland)
    Improved comments and code          (Mark Rutland)
---
 arch/arm64/include/asm/pgtable.h |  1 +
 arch/arm64/kernel/head.S         | 12 +++++++++---
 arch/arm64/kernel/vmlinux.lds.S  |  1 +
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pg=
table.h
index 8c20e2bd6287..5caff09c6a3a 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -457,6 +457,7 @@ extern pgd_t init_pg_dir[PTRS_PER_PGD];
 extern pgd_t init_pg_end[];
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
+extern pgd_t idmap_pg_end[];
 extern pgd_t tramp_pg_dir[PTRS_PER_PGD];
=20
 extern void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd);
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 57a91032b4c2..32f5ecbec0ea 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -394,13 +394,19 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
=20
 	/*
 	 * Since the page tables have been populated with non-cacheable
-	 * accesses (MMU disabled), invalidate the idmap and swapper page
-	 * tables again to remove any speculatively loaded cache lines.
+	 * accesses (MMU disabled), invalidate those tables again to
+	 * remove any speculatively loaded cache lines.
 	 */
+	dmb	sy
+
 	adrp	x0, idmap_pg_dir
+	adrp	x1, idmap_pg_end
+	sub	x1, x1, x0
+	bl	__inval_dcache_area
+
+	adrp	x0, init_pg_dir
 	adrp	x1, init_pg_end
 	sub	x1, x1, x0
-	dmb	sy
 	bl	__inval_dcache_area
=20
 	ret	x28
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.=
lds.S
index 497f9675071d..94402aaf5f5c 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -139,6 +139,7 @@ SECTIONS
=20
 	idmap_pg_dir =3D .;
 	. +=3D IDMAP_DIR_SIZE;
+	idmap_pg_end =3D .;
=20
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 	tramp_pg_dir =3D .;
--=20
2.23.0

