Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66ED4CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B4B620740
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363207;
	bh=lwCmYmBStc/B78iyH0w3hnthD4nOlcxlZPGhE6PV29M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2X0Rffj7eGIAkCJMGPbM7n4e8FOafYLx2uv5tSBwbTHKtnuwhd67Uu0E1DZy8MFhj
	 kmWk0QWz4mkVeBiYDmiUt5Ew4DoaEtl7/lnTHkOa4p5sBGuETAApoCtc8JMp82gy5C
	 CDG5KMtSc8JThP9Hql5jIvsUKIzh8nfeJneFPr4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732710AbgEMJqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732689AbgEMJqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:46:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B88A6206F5;
        Wed, 13 May 2020 09:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363201;
        bh=lwCmYmBStc/B78iyH0w3hnthD4nOlcxlZPGhE6PV29M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r9sI0pdemDWCjtkS2+2JxaoFTWYaxcy/OxdZcsRXkaoXKo8dJPgzE47Z87XMIS0eZ
         o/ioV/hjARwY/eTKWdKfZm7obq68dpmIrebe06V6/oMAWBmQ8Xb9QT5Gam+aNiS9R9
         rJebHlIphu/kpTzByIpUPGJObC5OxoC8RFS23QXY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Kyrill Tkachov <kyrylo.tkachov@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.19 27/48] arm64: hugetlb: avoid potential NULL dereference
Date:   Wed, 13 May 2020 11:44:53 +0200
Message-Id: <20200513094357.770767423@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094351.100352960@linuxfoundation.org>
References: <20200513094351.100352960@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

commit 027d0c7101f50cf03aeea9eebf484afd4920c8d3 upstream.

The static analyzer in GCC 10 spotted that in huge_pte_alloc() we may
pass a NULL pmdp into pte_alloc_map() when pmd_alloc() returns NULL:

|   CC      arch/arm64/mm/pageattr.o
|   CC      arch/arm64/mm/hugetlbpage.o
|                  from arch/arm64/mm/hugetlbpage.c:10:
| arch/arm64/mm/hugetlbpage.c: In function ‘huge_pte_alloc’:
| ./arch/arm64/include/asm/pgtable-types.h:28:24: warning: dereference of NULL ‘pmdp’ [CWE-690] [-Wanalyzer-null-dereference]
| ./arch/arm64/include/asm/pgtable.h:436:26: note: in expansion of macro ‘pmd_val’
| arch/arm64/mm/hugetlbpage.c:242:10: note: in expansion of macro ‘pte_alloc_map’
|     |arch/arm64/mm/hugetlbpage.c:232:10:
|     |./arch/arm64/include/asm/pgtable-types.h:28:24:
| ./arch/arm64/include/asm/pgtable.h:436:26: note: in expansion of macro ‘pmd_val’
| arch/arm64/mm/hugetlbpage.c:242:10: note: in expansion of macro ‘pte_alloc_map’

This can only occur when the kernel cannot allocate a page, and so is
unlikely to happen in practice before other systems start failing.

We can avoid this by bailing out if pmd_alloc() fails, as we do earlier
in the function if pud_alloc() fails.

Fixes: 66b3923a1a0f ("arm64: hugetlb: add support for PTE contiguous bit")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Kyrill Tkachov <kyrylo.tkachov@arm.com>
Cc: <stable@vger.kernel.org> # 4.5.x-
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/mm/hugetlbpage.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -218,6 +218,8 @@ pte_t *huge_pte_alloc(struct mm_struct *
 		ptep = (pte_t *)pudp;
 	} else if (sz == (PAGE_SIZE * CONT_PTES)) {
 		pmdp = pmd_alloc(mm, pudp, addr);
+		if (!pmdp)
+			return NULL;
 
 		WARN_ON(addr & (sz - 1));
 		/*


