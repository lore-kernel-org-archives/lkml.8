Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631CDC3B188
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 04:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F84D215A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 04:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o+4Q+Lx3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgBLETD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 23:19:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54106 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbgBLESu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:18:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hIDhhEou9RiUJDaLZAeECfggSk3sIeZ9QeAjOR5EQ34=; b=o+4Q+Lx3BQoXdB6pmIZNMe2aUb
        CZi3KzFXiBXqjCzC5E0v34MYMxbcmJu3Rrncx01PU9cwODwDLM1dClFtq5oqCLkulOMhhBVCwFQQK
        O7gK1YrssQJSLR/N2MFpNRVO2Ps52v5EPJNgcxPSJ21lMydKV4fn5OeGP5HFe+0KqDluiMhr1V5vX
        bb2mpuVTh9W6rq+6ruMUc7V8iK5X13IWLX8A2Zyh/r87S7Gg3R2VmAgJuMtNHbggNG+d3TY2DSdXy
        uco25ofA+Usz+g9M8rzzYYkIgZFCFuK8TtxGMYwsVRZ5JkQ2iy6Z5kXrYwDXZrnQ6X2yNM6EG5bOW
        tEJkZUrA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1jU6-0006mM-Gc; Wed, 12 Feb 2020 04:18:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v2 01/25] mm: Use vm_fault error code directly
Date:   Tue, 11 Feb 2020 20:18:21 -0800
Message-Id: <20200212041845.25879-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212041845.25879-1-willy@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use VM_FAULT_OOM instead of indirecting through vmf_error(-ENOMEM).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 1784478270e1..1beb7716276b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2491,7 +2491,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		if (!page) {
 			if (fpin)
 				goto out_retry;
-			return vmf_error(-ENOMEM);
+			return VM_FAULT_OOM;
 		}
 	}
 
-- 
2.25.0

