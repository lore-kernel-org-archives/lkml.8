Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5BBC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44FE920671
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZlhQE/DX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgEOOhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 10:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726163AbgEOOhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:37:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89220C061A0C;
        Fri, 15 May 2020 07:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Z9YRs5dLpbvo98tj/Cgt22OOiGK6aHhMzE6epEWfQXc=; b=ZlhQE/DX4CKjdZl8xexqucGXRW
        ecW0xdoSIe9Gq35tRpeBiirXpnuIuOEEr39MdMGz1PdURhzPLiTO5wahIkK5vw1PmAPLFD99ZDzpT
        KfzkqvYyTU9LhznNbxGajjy8tQzBZAfMQC8HJfqoH5Sirl+L4HEisHonX50JZQe8vvMnXzsqw+8nd
        n6IBEp27INvtNKjvuFTjxPOaCyavRVTpfVxqewr8imN9jFg90CqXRttj3krRvgExHWVSdjYWekCmo
        h0GSVtWiDytYP4TT9HxbBtbdWa/cwt6vJMcpLMC4v/k/iown67sSCkP/8V0MX4v+5BPt/UyLUKy9X
        x8dhpzzg==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZbSK-0003qc-Oh; Fri, 15 May 2020 14:36:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Roman Zippel <zippel@linux-m68k.org>
Cc:     Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/29] powerpc: unexport flush_icache_user_range
Date:   Fri, 15 May 2020 16:36:20 +0200
Message-Id: <20200515143646.3857579-4-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515143646.3857579-1-hch@lst.de>
References: <20200515143646.3857579-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

flush_icache_user_range is only used by copy_to_user_page, which is
only used by core VM code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/mm/mem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 041ed7cfd341a..f0d1bf0a8e14f 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -587,7 +587,6 @@ void flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
 	flush_icache_range(maddr, maddr + len);
 	kunmap(page);
 }
-EXPORT_SYMBOL(flush_icache_user_range);
 
 /*
  * System memory should not be in /proc/iomem but various tools expect it
-- 
2.26.2

