Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D32C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA462072E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217843;
	bh=SKk62hgPbXoCxXpnUj5XJblGn1m21tA2Mh2HExM3X9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ru2HOMGIoYeZhbDjp6tetE1FuNcpvuEH9lvzrbphB8lY4kxrUriT0gpXKAt8Zbk+v
	 +ebO7YkGXnpUIDBXToYwKTSAGxYd2hbyNL/f7fPSQqXe5XTP4FYx3NUjYlBKN6RaTO
	 qXO44iWyud48f2Vomojy9WOexE0bnDMw1ly99Hs8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404510AbgAPXhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:37:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:38808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391107AbgAPXbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:31:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A244D20661;
        Thu, 16 Jan 2020 23:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217466;
        bh=SKk62hgPbXoCxXpnUj5XJblGn1m21tA2Mh2HExM3X9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XphB3qtSsmBFkb1WzBv3254QJ8WsHNSVtJSM7auPuSUZqoLBXlUeJ2+4APbKhC/tt
         XnB59XPDBrmEeaPn9ULoKmkpaZ+hyMJuo2dUIHYjzsOjx05x2WxWwawF7Uv7jms70v
         3YaIEFwr76vEwiqiLjf8vbHNbDoDGCqmkK/QfED8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Laura Abbott <labbott@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.14 10/71] arm64: Make sure permission updates happen for pmd/pud
Date:   Fri, 17 Jan 2020 00:18:08 +0100
Message-Id: <20200116231710.926122766@linuxfoundation.org>
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

From: Laura Abbott <labbott@redhat.com>

commit 82034c23fcbc2389c73d97737f61fa2dd6526413 upstream.

Commit 15122ee2c515 ("arm64: Enforce BBM for huge IO/VMAP mappings")
disallowed block mappings for ioremap since that code does not honor
break-before-make. The same APIs are also used for permission updating
though and the extra checks prevent the permission updates from happening,
even though this should be permitted. This results in read-only permissions
not being fully applied. Visibly, this can occasionaly be seen as a failure
on the built in rodata test when the test data ends up in a section or
as an odd RW gap on the page table dump. Fix this by using
pgattr_change_is_safe instead of p*d_present for determining if the
change is permitted.

Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Peter Robinson <pbrobinson@gmail.com>
Reported-by: Peter Robinson <pbrobinson@gmail.com>
Fixes: 15122ee2c515 ("arm64: Enforce BBM for huge IO/VMAP mappings")
Signed-off-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/mm/mmu.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -917,13 +917,15 @@ int pud_set_huge(pud_t *pudp, phys_addr_
 {
 	pgprot_t sect_prot = __pgprot(PUD_TYPE_SECT |
 					pgprot_val(mk_sect_prot(prot)));
+	pud_t new_pud = pfn_pud(__phys_to_pfn(phys), sect_prot);
 
-	/* ioremap_page_range doesn't honour BBM */
-	if (pud_present(READ_ONCE(*pudp)))
+	/* Only allow permission changes for now */
+	if (!pgattr_change_is_safe(READ_ONCE(pud_val(*pudp)),
+				   pud_val(new_pud)))
 		return 0;
 
 	BUG_ON(phys & ~PUD_MASK);
-	set_pud(pudp, pfn_pud(__phys_to_pfn(phys), sect_prot));
+	set_pud(pudp, new_pud);
 	return 1;
 }
 
@@ -931,13 +933,15 @@ int pmd_set_huge(pmd_t *pmdp, phys_addr_
 {
 	pgprot_t sect_prot = __pgprot(PMD_TYPE_SECT |
 					pgprot_val(mk_sect_prot(prot)));
+	pmd_t new_pmd = pfn_pmd(__phys_to_pfn(phys), sect_prot);
 
-	/* ioremap_page_range doesn't honour BBM */
-	if (pmd_present(READ_ONCE(*pmdp)))
+	/* Only allow permission changes for now */
+	if (!pgattr_change_is_safe(READ_ONCE(pmd_val(*pmdp)),
+				   pmd_val(new_pmd)))
 		return 0;
 
 	BUG_ON(phys & ~PMD_MASK);
-	set_pmd(pmdp, pfn_pmd(__phys_to_pfn(phys), sect_prot));
+	set_pmd(pmdp, new_pmd);
 	return 1;
 }
 


