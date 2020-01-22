Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FFAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645722071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685620;
	bh=s+5lwv53EbtjsA0esVf+Gid357TK9ktYSNgEuhry7X8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fqb4n3JVBoVM1P3JUHRaPRvRzRokddlXG4SG1RjSrYF7NjubXGLOcwLTa8ojf2LR+
	 y1RqbCRzMMw7x9Bx5403AMJMl+uaCCfXarCX4Tnths9Xs2/wm2plPNSHu94Tr9YPrZ
	 JvqoIrP6Kbh6MQ5tyub0AOBeyZUJ0Aq4Lef+Sudc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgAVJdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:33:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:47540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730621AbgAVJdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:33:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A74C92071E;
        Wed, 22 Jan 2020 09:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685616;
        bh=s+5lwv53EbtjsA0esVf+Gid357TK9ktYSNgEuhry7X8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wKNAxAoYyvfN7rnRM/hZbIfPR9VN9fzhToG5vsdqNpC/kB0JS2QN7WRFMxH87NfLI
         s+bc4a6EfPo9jR6cxygfYEdng7RYvEtuLPJzH+42a6wceoB61P/CaJjZEL0ubbabuY
         3BrgxcFEAOVGJD4hDOMTxBIKSrCMjLdrf4OaR3Vs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>,
        Lei Li <lious.lilei@hisilicon.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 10/97] arm64: Enforce BBM for huge IO/VMAP mappings
Date:   Wed, 22 Jan 2020 10:28:14 +0100
Message-Id: <20200122092757.442779817@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092755.678349497@linuxfoundation.org>
References: <20200122092755.678349497@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

commit 15122ee2c515a253b0c66a3e618bc7ebe35105eb upstream.

ioremap_page_range doesn't honour break-before-make and attempts to put
down huge mappings (using p*d_set_huge) over the top of pre-existing
table entries. This leads to us leaking page table memory and also gives
rise to TLB conflicts and spurious aborts, which have been seen in
practice on Cortex-A75.

Until this has been resolved, refuse to put block mappings when the
existing entry is found to be present.

Fixes: 324420bf91f60 ("arm64: add support for ioremap() block mappings")
Reported-by: Hanjun Guo <hanjun.guo@linaro.org>
Reported-by: Lei Li <lious.lilei@hisilicon.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/mm/mmu.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -799,6 +799,11 @@ int pud_set_huge(pud_t *pudp, phys_addr_
 {
 	pgprot_t sect_prot = __pgprot(PUD_TYPE_SECT |
 					pgprot_val(mk_sect_prot(prot)));
+
+	/* ioremap_page_range doesn't honour BBM */
+	if (pud_present(READ_ONCE(*pudp)))
+		return 0;
+
 	BUG_ON(phys & ~PUD_MASK);
 	set_pud(pudp, pfn_pud(__phys_to_pfn(phys), sect_prot));
 	return 1;
@@ -808,6 +813,11 @@ int pmd_set_huge(pmd_t *pmdp, phys_addr_
 {
 	pgprot_t sect_prot = __pgprot(PMD_TYPE_SECT |
 					pgprot_val(mk_sect_prot(prot)));
+
+	/* ioremap_page_range doesn't honour BBM */
+	if (pmd_present(READ_ONCE(*pmdp)))
+		return 0;
+
 	BUG_ON(phys & ~PMD_MASK);
 	set_pmd(pmdp, pfn_pmd(__phys_to_pfn(phys), sect_prot));
 	return 1;


