Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E57C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6CCA20781
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947831;
	bh=rDTaJGdmCoVcQyeluXk57ognL7Avrgnsr5Bh1IrQ7fg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AYunWV5CKdCVBK7gz05hcF6JMKBdgJosSDORINe/6PISIsV9WAKH5GJDnTIFc57s5
	 CVDx+wXdHxL5NkZYFjW16SwCuPU8QDbe+ogFglzWx2NBbdPCzTKLqeRLu7QO1rRL/K
	 JdhrrJQSA/ut60lxeFgqDe4SJaGkrkpG11MWNPMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389122AbgFWUNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:13:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388077AbgFWUNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:13:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B235B206C3;
        Tue, 23 Jun 2020 20:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943212;
        bh=rDTaJGdmCoVcQyeluXk57ognL7Avrgnsr5Bh1IrQ7fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D+WKSjyQ6uCyDXLHLQtx4xXMajZ2WNZOaTOJNlqbaOgOE0ZTDXiP/jnYlHKV7VYJr
         4ckfSaZEVHec0K5tyKP0Dmmw8LYZaPTM75aZ0ySF6oQcZVDCEMOzzfiWZdCO8tvcP9
         gIZIcbl7km2pvPjBl6ZBGAufn8Pu8c9ZGwvwFSzE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 273/477] powerpc/32s: Dont warn when mapping RO data ROX.
Date:   Tue, 23 Jun 2020 21:54:30 +0200
Message-Id: <20200623195420.469804463@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit 4b19f96a81bceaf0bcf44d79c0855c61158065ec ]

Mapping RO data as ROX is not an issue since that data
cannot be modified to introduce an exploit.

PPC64 accepts to have RO data mapped ROX, as a trade off
between kernel size and strictness of protection.

On PPC32, kernel size is even more critical as amount of
memory is usually small.

Depending on the number of available IBATs, the last IBATs
might overflow the end of text. Only warn if it crosses
the end of RO data.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/6499f8eeb2a36330e5c9fc1cee9a79374875bd54.1589866984.git.christophe.leroy@csgroup.eu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/book3s32/mmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index 39ba53ca5bb55..a9b2cbc747977 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -187,6 +187,7 @@ void mmu_mark_initmem_nx(void)
 	int i;
 	unsigned long base = (unsigned long)_stext - PAGE_OFFSET;
 	unsigned long top = (unsigned long)_etext - PAGE_OFFSET;
+	unsigned long border = (unsigned long)__init_begin - PAGE_OFFSET;
 	unsigned long size;
 
 	if (IS_ENABLED(CONFIG_PPC_BOOK3S_601))
@@ -201,9 +202,10 @@ void mmu_mark_initmem_nx(void)
 		size = block_size(base, top);
 		size = max(size, 128UL << 10);
 		if ((top - base) > size) {
-			if (strict_kernel_rwx_enabled())
-				pr_warn("Kernel _etext not properly aligned\n");
 			size <<= 1;
+			if (strict_kernel_rwx_enabled() && base + size > border)
+				pr_warn("Some RW data is getting mapped X. "
+					"Adjust CONFIG_DATA_SHIFT to avoid that.\n");
 		}
 		setibat(i++, PAGE_OFFSET + base, base, size, PAGE_KERNEL_TEXT);
 		base += size;
-- 
2.25.1



