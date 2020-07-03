Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9CEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF2BD20899
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BG3c/Bmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgGCNjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 09:39:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54655 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726506AbgGCNji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 09:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593783577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VkR62g3UrGpBqyKGtfB0CF1RNYbpRziS7AD0u/OIIZk=;
        b=BG3c/BmobVLIQJuhl9Q7P1YpyNMOZNAj5hWIgogOKsNjvVAnSEGFyrlQ4oKeEGIgmfELQY
        j9I0HgKFb72FFSZ1XO5hHrvwmSPR5hkE/bTUgWoOu8wDuqNvrSntrUoIaJtQXuQLGM56Em
        7ON45dx5S0o3j0PcbV4+YuN/Lng/0/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-Vg_5UOTRNDWIIxSERty0oQ-1; Fri, 03 Jul 2020 09:39:33 -0400
X-MC-Unique: Vg_5UOTRNDWIIxSERty0oQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E97BBFC1;
        Fri,  3 Jul 2020 13:39:32 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-0.ams2.redhat.com [10.36.114.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D0AE71690;
        Fri,  3 Jul 2020 13:39:30 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: [PATCH v1 5/9] s390/vmemmap: take the vmem_mutex when populating/freeing
Date:   Fri,  3 Jul 2020 15:39:13 +0200
Message-Id: <20200703133917.39045-6-david@redhat.com>
In-Reply-To: <20200703133917.39045-1-david@redhat.com>
References: <20200703133917.39045-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's synchronize all accesses to the 1:1 and vmemmap mappings. This will
be especially relevant when wanting to cleanup empty page tables that could
be shared by both. Avoid races when removing tables that might be just
about to get reused.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/vmem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index bcddabd509da8..aa968f67d7f9f 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -293,6 +293,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	pte_t *pt_dir;
 	int ret = -ENOMEM;
 
+	mutex_lock(&vmem_mutex);
 	pgt_prot = pgprot_val(PAGE_KERNEL);
 	sgt_prot = pgprot_val(SEGMENT_KERNEL);
 	if (!MACHINE_HAS_NX) {
@@ -364,6 +365,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	}
 	ret = 0;
 out:
+	mutex_unlock(&vmem_mutex);
 	if (ret)
 		vmemmap_free(start, end, altmap);
 	return ret;
@@ -372,7 +374,9 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 void vmemmap_free(unsigned long start, unsigned long end,
 		struct vmem_altmap *altmap)
 {
+	mutex_lock(&vmem_mutex);
 	remove_pagetable(start, end, false);
+	mutex_unlock(&vmem_mutex);
 }
 
 void vmem_remove_mapping(unsigned long start, unsigned long size)
-- 
2.26.2

