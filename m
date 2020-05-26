Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52A7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98D7620888
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520542;
	bh=bPHmpQ8rFupKag+rTlVDUEQCWtq4WfdatvEyugg2Ya0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uVbISsZGdsUCgllK3nocFIyD/JKFFiOFXptaHqCGBjQWYM400GWt8D54Kee3N1FpA
	 eDKrcThUimP44tEFWS0bSGRP3XQz0g28E8DY/PArjEfrmEZM33jTZqNyVKq0lXfGj1
	 xOIpbj3ZPL5WESKZNdSPGzYBWBU88EnDTxNoMnBw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391966AbgEZTPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:15:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404452AbgEZTPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:15:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13C2F2053B;
        Tue, 26 May 2020 19:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520536;
        bh=bPHmpQ8rFupKag+rTlVDUEQCWtq4WfdatvEyugg2Ya0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rBKm3sdS5Ej7o9Zq+MG0e59LGhcqwciE+LPaNEyAPoVugJprtzbv3AzCXdidsNLJp
         22if9sHaFmFQh1iphHlKl3J2tIkGwD9nSx3m3CG+d7+1KkMuBQV80doWjAI+Nx32bI
         wNNrZdnwIkiHOeXoyx7TW3gcrRmQM8XvLIOzf0YI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Anatoly Pugachev <matorola@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.6 111/126] sparc32: use PUD rather than PGD to get PMD in srmmu_nocache_init()
Date:   Tue, 26 May 2020 20:54:08 +0200
Message-Id: <20200526183946.883633639@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183937.471379031@linuxfoundation.org>
References: <20200526183937.471379031@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

commit c2bc26f7ca1ff1165bb6669a7a4cccc20ffd2ced upstream.

The kbuild test robot reported the following warning:

  arch/sparc/mm/srmmu.c: In function 'srmmu_nocache_init': arch/sparc/mm/srmmu.c:300:9: error: variable 'pud' set but not used [-Werror=unused-but-set-variable]
  300 |  pud_t *pud;

This warning is caused by misprint in the page table traversal in
srmmu_nocache_init() function which accessed a PMD entry using PGD
rather than PUD.

Since sparc32 has only 3 page table levels, the PGD and PUD are
essentially the same and usage of __nocache_fix() removed the type
checking.

Use PUD for the consistency and to silence the compiler warning.

Fixes: 7235db268a2777bc38 ("sparc32: use pgtable-nopud instead of 4level-fixup")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Anatoly Pugachev <matorola@gmail.com>
Cc: <stable@vger.kernel.org>
Link: http://lkml.kernel.org/r/20200520132005.GM1059226@linux.ibm.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/sparc/mm/srmmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -333,7 +333,7 @@ static void __init srmmu_nocache_init(vo
 		pgd = pgd_offset_k(vaddr);
 		p4d = p4d_offset(__nocache_fix(pgd), vaddr);
 		pud = pud_offset(__nocache_fix(p4d), vaddr);
-		pmd = pmd_offset(__nocache_fix(pgd), vaddr);
+		pmd = pmd_offset(__nocache_fix(pud), vaddr);
 		pte = pte_offset_kernel(__nocache_fix(pmd), vaddr);
 
 		pteval = ((paddr >> 4) | SRMMU_ET_PTE | SRMMU_PRIV);


