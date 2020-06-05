Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263EEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8371208FE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591366710;
	bh=9bgOnoqQ3+XkHBwKqZjrpgx+J9Wfv4rHG89fs41V1TM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XmeD78+KQnRqTFGNG2TqMShUEEvT9HCf2pON7/bd9ybiEsV1a0tio+F7nmMc8aQiZ
	 5dk671HmG40kbtMPgW1lW20xmMGbo5ghR8aXcGm9QZcWF/hszHizhY1lcW5dEhmKwJ
	 ykFCSLeTftU9wsMgMKe1h++Xjw4pw9MSBKU6i9ew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgFEOS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:18:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728661AbgFEOSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:18:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D84D5208B8;
        Fri,  5 Jun 2020 14:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591366703;
        bh=9bgOnoqQ3+XkHBwKqZjrpgx+J9Wfv4rHG89fs41V1TM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bCbKh1rVRdcruYOjlT37m4Byq/recCkv5f1fdGBrj4eTqiiiTkZF8KuAiLt88RJ0Q
         SqdKcM8h85CmDxeq+60nPPPnSdl/Cx5okjgSz63NzU9GjJ1mzrhIL42akifRzd+OiQ
         KCrtYtwi3//jdWjuEUjcU7YlIDxBAVerv3KGDmwU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fan Yang <Fan_Yang@sjtu.edu.cn>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.4 02/38] mm: Fix mremap not considering huge pmd devmap
Date:   Fri,  5 Jun 2020 16:14:45 +0200
Message-Id: <20200605140252.678256519@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200605140252.542768750@linuxfoundation.org>
References: <20200605140252.542768750@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fan Yang <Fan_Yang@sjtu.edu.cn>

commit 5bfea2d9b17f1034a68147a8b03b9789af5700f9 upstream.

The original code in mm/mremap.c checks huge pmd by:

		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd)) {

However, a DAX mapped nvdimm is mapped as huge page (by default) but it
is not transparent huge page (_PAGE_PSE | PAGE_DEVMAP).  This commit
changes the condition to include the case.

This addresses CVE-2020-10757.

Fixes: 5c7fb56e5e3f ("mm, dax: dax-pmd vs thp-pmd vs hugetlbfs-pmd")
Cc: <stable@vger.kernel.org>
Reported-by: Fan Yang <Fan_Yang@sjtu.edu.cn>
Signed-off-by: Fan Yang <Fan_Yang@sjtu.edu.cn>
Tested-by: Fan Yang <Fan_Yang@sjtu.edu.cn>
Tested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/pgtable.h |    1 +
 mm/mremap.c                    |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -253,6 +253,7 @@ static inline int pmd_large(pmd_t pte)
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+/* NOTE: when predicate huge page, consider also pmd_devmap, or use pmd_large */
 static inline int pmd_trans_huge(pmd_t pmd)
 {
 	return (pmd_val(pmd) & (_PAGE_PSE|_PAGE_DEVMAP)) == _PAGE_PSE;
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -266,7 +266,7 @@ unsigned long move_page_tables(struct vm
 		new_pmd = alloc_new_pmd(vma->vm_mm, vma, new_addr);
 		if (!new_pmd)
 			break;
-		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd)) {
+		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd) || pmd_devmap(*old_pmd)) {
 			if (extent == HPAGE_PMD_SIZE) {
 				bool moved;
 				/* See comment in move_ptes() */


