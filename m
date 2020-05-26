Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CBFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B5EA2071A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COoLYTQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgEZINv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 04:13:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58694 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727011AbgEZINu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 04:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590480828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=F6dY7b577fJbY2Wvy6nSoJBff9CB2njzSCj4WHlFr/M=;
        b=COoLYTQXrxNESnoPE4odcpJXhQxVybogSq5szfo1Cl3iCOtNraWbFmikJavySvAkUN+vqz
        Qynd/IZfl5j1V5lqJUkvW2ZNV8rr+hkZ119QSSI6yubpsSgdL9Vk4a/Z1BkydkCfOstN3g
        claNDsRX3r3d6NKRyUOHYNWXqjm+ukg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-RfyK_COPMb2ZHsotDGds_g-1; Tue, 26 May 2020 04:13:43 -0400
X-MC-Unique: RfyK_COPMb2ZHsotDGds_g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2913E800688;
        Tue, 26 May 2020 08:13:42 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E971179C45;
        Tue, 26 May 2020 08:13:39 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH] mm/gup: correct pin_user_pages.rst location
Date:   Tue, 26 May 2020 10:13:38 +0200
Message-Id: <20200526081338.179532-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pin_user_pages.rst lives in Documentation/core-api/, not Documentation/vm/,
adjust all links accordingly.

Fixes: 3faa52c03f44 ("mm/gup: track FOLL_PIN pages")
Fixes: eddb1c228f79 ("mm/gup: introduce pin_user_pages*() and FOLL_PIN")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 include/linux/mm.h |  4 ++--
 mm/gup.c           | 18 +++++++++---------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5a323422d783..1f2850465f59 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1219,7 +1219,7 @@ void unpin_user_pages(struct page **pages, unsigned long npages);
  * used to track the pincount (instead using of the GUP_PIN_COUNTING_BIAS
  * scheme).
  *
- * For more information, please see Documentation/vm/pin_user_pages.rst.
+ * For more information, please see Documentation/core-api/pin_user_pages.rst.
  *
  * @page:	pointer to page to be queried.
  * @Return:	True, if it is likely that the page has been "dma-pinned".
@@ -2834,7 +2834,7 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
  * releasing pages: get_user_pages*() pages must be released via put_page(),
  * while pin_user_pages*() pages must be released via unpin_user_page().
  *
- * Please see Documentation/vm/pin_user_pages.rst for more information.
+ * Please see Documentation/core-api/pin_user_pages.rst for more information.
  */
 
 static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
diff --git a/mm/gup.c b/mm/gup.c
index 87a6a59fe667..87a3a4b400f9 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2845,10 +2845,10 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast);
  * the arguments here are identical.
  *
  * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
- * see Documentation/vm/pin_user_pages.rst for further details.
+ * see Documentation/core-api/pin_user_pages.rst for further details.
  *
- * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_pages.rst. It
- * is NOT intended for Case 2 (RDMA: long-term pins).
+ * This is intended for Case 1 in Documentation/core-api/pin_user_pages.rst
+ * (DIO). It is NOT intended for Case 2 (RDMA: long-term pins).
  */
 int pin_user_pages_fast(unsigned long start, int nr_pages,
 			unsigned int gup_flags, struct page **pages)
@@ -2885,10 +2885,10 @@ EXPORT_SYMBOL_GPL(pin_user_pages_fast);
  * the arguments here are identical.
  *
  * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
- * see Documentation/vm/pin_user_pages.rst for details.
+ * see Documentation/core-api/pin_user_pages.rst for details.
  *
- * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_pages.rst. It
- * is NOT intended for Case 2 (RDMA: long-term pins).
+ * This is intended for Case 1 in Documentation/core-api/pin_user_pages.rst
+ * (DIO). It is NOT intended for Case 2 (RDMA: long-term pins).
  */
 long pin_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
 			   unsigned long start, unsigned long nr_pages,
@@ -2921,10 +2921,10 @@ EXPORT_SYMBOL(pin_user_pages_remote);
  * FOLL_PIN is set.
  *
  * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
- * see Documentation/vm/pin_user_pages.rst for details.
+ * see Documentation/core-api/pin_user_pages.rst for details.
  *
- * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_pages.rst. It
- * is NOT intended for Case 2 (RDMA: long-term pins).
+ * This is intended for Case 1 in Documentation/core-api/pin_user_pages.rst
+ * (DIO). It is NOT intended for Case 2 (RDMA: long-term pins).
  */
 long pin_user_pages(unsigned long start, unsigned long nr_pages,
 		    unsigned int gup_flags, struct page **pages,
-- 
2.25.4

