Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A798C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063E920836
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583258536;
	bh=YVVksQWhRHSA7KzDODPmjPlyQ38Pa39Pr6eqLBlAPZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CjbvDnzHf2SZVogGdbni3NV5wK5VS5UclTVyBG5L/iBbLeWPcHZUxaao2kMM32iNy
	 EmdL24egmBXDTrYqeuCxTQywVpvVElxZEDfnaiHdy87n8qT3cUEsUsgPHGbNoJRx9P
	 0CVLcXktZTSKSrleDi33hFvyXvgTL1/wx4XnCnz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388172AbgCCSCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:02:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:46756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387746AbgCCSCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 13:02:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C81620836;
        Tue,  3 Mar 2020 18:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583258532;
        bh=YVVksQWhRHSA7KzDODPmjPlyQ38Pa39Pr6eqLBlAPZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L8aWh46ni3rzMrtiz3+BguKyvklzRtmizKCZ8Y/Fkv9NDwiEMrj6oAAV1TJIU0zHS
         dIGUBJRQoNvOyv/B+6+54uuZ//gM8+PG4Z8G07mX2qsyUcfr94zK6QzhSIf3NuctPh
         j1sYy1Dam64eQ8o+I6VdUpZnGr1erKLaFFTsrNvU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yang <richardw.yang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 86/87] mm/huge_memory.c: use head to check huge zero page
Date:   Tue,  3 Mar 2020 18:44:17 +0100
Message-Id: <20200303174358.045254973@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174349.075101355@linuxfoundation.org>
References: <20200303174349.075101355@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yang <richardw.yang@linux.intel.com>

commit cb829624867b5ab10bc6a7036d183b1b82bfe9f8 upstream.

The page could be a tail page, if this is the case, this BUG_ON will
never be triggered.

Link: http://lkml.kernel.org/r/20200110032610.26499-1-richardw.yang@linux.intel.com
Fixes: e9b61f19858a ("thp: reintroduce split_huge_page()")

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/huge_memory.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2661,7 +2661,7 @@ int split_huge_page_to_list(struct page
 	unsigned long flags;
 	pgoff_t end;
 
-	VM_BUG_ON_PAGE(is_huge_zero_page(page), page);
+	VM_BUG_ON_PAGE(is_huge_zero_page(head), head);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(!PageCompound(page), page);
 


