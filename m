Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C39C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B556820684
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217737;
	bh=0VmsbLkFST9vywj3lsUu+bZOFqgyTE6C8+ee9JLR9+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o1FjrExpaQAK/FfFZMVxwOcny8uTbIFBtzfocEGVJfRv+iDQ6nb2onvJW8+8zQJCU
	 nwYwc5epvp1gwb+h4R5Kp7K38I19B8jgOgF4HB/TmUU91aAqX1cssRX1222NK4vx27
	 Cj0gRJY2aKiX/2v+HG6N3oeI5sPBINhoIOomz3fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404194AbgAPXcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:32:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:40756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391551AbgAPXbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:31:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21F5E2087E;
        Thu, 16 Jan 2020 23:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217514;
        bh=0VmsbLkFST9vywj3lsUu+bZOFqgyTE6C8+ee9JLR9+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xHUZD5AVmG+euQWvj/H+cMMcUDK1KzqEPZc1BYPXaBl2byxLTDVULFWATac78eFdJ
         goXJnkoayAr3FZ6ivhQMwqL1P2bN55l1XUNDwbVenYrXIJ+fvYFOW4ZV7J2BgrKsIv
         sEPVo0uQ+OhURaseLWI2xbpqrGo8QT7H4HvrhoSY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.14 08/71] arm64: mm: Change page table pointer name in  p[md]_set_huge()
Date:   Fri, 17 Jan 2020 00:18:06 +0100
Message-Id: <20200116231710.598555252@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231709.377772748@linuxfoundation.org>
References: <20200116231709.377772748@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

This is preparation for the following backported fixes.  It was done
upstream as part of commit 20a004e7b017 "arm64: mm: Use
READ_ONCE/WRITE_ONCE when accessing page tables", the rest of which
does not seem suitable for stable.

Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/mm/mmu.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -913,21 +913,21 @@ int __init arch_ioremap_pmd_supported(vo
 	return !IS_ENABLED(CONFIG_ARM64_PTDUMP_DEBUGFS);
 }
 
-int pud_set_huge(pud_t *pud, phys_addr_t phys, pgprot_t prot)
+int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
 {
 	pgprot_t sect_prot = __pgprot(PUD_TYPE_SECT |
 					pgprot_val(mk_sect_prot(prot)));
 	BUG_ON(phys & ~PUD_MASK);
-	set_pud(pud, pfn_pud(__phys_to_pfn(phys), sect_prot));
+	set_pud(pudp, pfn_pud(__phys_to_pfn(phys), sect_prot));
 	return 1;
 }
 
-int pmd_set_huge(pmd_t *pmd, phys_addr_t phys, pgprot_t prot)
+int pmd_set_huge(pmd_t *pmdp, phys_addr_t phys, pgprot_t prot)
 {
 	pgprot_t sect_prot = __pgprot(PMD_TYPE_SECT |
 					pgprot_val(mk_sect_prot(prot)));
 	BUG_ON(phys & ~PMD_MASK);
-	set_pmd(pmd, pfn_pmd(__phys_to_pfn(phys), sect_prot));
+	set_pmd(pmdp, pfn_pmd(__phys_to_pfn(phys), sect_prot));
 	return 1;
 }
 


