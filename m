Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8482C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 847E02166E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580694;
	bh=r2yHVLBRkViANlrNr1ctGy2yImraShqdjiFxyaql51U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kVyAj8YOs0jFr3bAAZoeRWXJcNUzAuhArf/HI7sbFoAq8nKpwF4plfn/f0bxt+h5T
	 Et+EvJH1PPcvvCz273ELAI7D0T1j5avxD8xxG6utJxPDKJ3BxoDNGKJ3g+xgQOI/Td
	 J5Fkaj6X+KewexjeuBYGyNyBcdv1MHJ3znIFjwxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404847AbgFSPbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:31:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393817AbgFSPbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:31:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0D362193E;
        Fri, 19 Jun 2020 15:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580682;
        bh=r2yHVLBRkViANlrNr1ctGy2yImraShqdjiFxyaql51U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oNWJivngs82eemhTvekDlFttaYZZ1diMB6IyWkGNiLdhgcheos1AKveHrwQQtbwFV
         rX3j0+ynGLYKt0SUZLxRJQGfBCUtATA7TYb8HH3pM1KvjLZ9hMRL9y2CjTe5V6rNdP
         QZ3J0huZrZFNrFBUNjp+HEFL4BPVFrTMhW4AO4jw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.7 341/376] powerpc/32: Disable KASAN with pages bigger than 16k
Date:   Fri, 19 Jun 2020 16:34:19 +0200
Message-Id: <20200619141726.474527078@linuxfoundation.org>
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

From: Christophe Leroy <christophe.leroy@csgroup.eu>

commit 888468ce725a4cd56d72dc7e5096078f7a9251a0 upstream.

Mapping of early shadow area is implemented by using a single static
page table having all entries pointing to the same early shadow page.
The shadow area must therefore occupy full PGD entries.

The shadow area has a size of 128MB starting at 0xf8000000.
With 4k pages, a PGD entry is 4MB
With 16k pages, a PGD entry is 64MB
With 64k pages, a PGD entry is 1GB which is too big.

Until we rework the early shadow mapping, disable KASAN when the page
size is too big.

Fixes: 2edb16efc899 ("powerpc/32: Add KASAN support")
Cc: stable@vger.kernel.org # v5.2+
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/7195fcde7314ccbf7a081b356084a69d421b10d4.1590660977.git.christophe.leroy@csgroup.eu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -170,8 +170,8 @@ config PPC
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMAP		if PPC_BOOK3S_64 && PPC_RADIX_MMU
 	select HAVE_ARCH_JUMP_LABEL
-	select HAVE_ARCH_KASAN			if PPC32
-	select HAVE_ARCH_KASAN_VMALLOC		if PPC32
+	select HAVE_ARCH_KASAN			if PPC32 && PPC_PAGE_SHIFT <= 14
+	select HAVE_ARCH_KASAN_VMALLOC		if PPC32 && PPC_PAGE_SHIFT <= 14
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT


