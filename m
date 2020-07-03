Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01D9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9052120782
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJVDr8xB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgGCNje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 09:39:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25983 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726416AbgGCNjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 09:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593783570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yWLTZ0ohTCOqY8W0BivI+pv17MHIbXm1Wg5QczAEU30=;
        b=UJVDr8xBE5Z9I7LQbxHqHwch/OV7LPbhi/IcOSBMv55Y/UyzE3Ef+VYktu5kR7WbkyI7Io
        OgOfSJI9FRlkBk0sJMK1QIrf7ENh2oJ0doEjwQUXIdamiIY/Em/BF2yoQjTKBDMe67m+9H
        rvbzBtjS37F+2tGDyyApMlnl6Hs3Zbk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-HN_JwzWiNtmJnbIccLMHJw-1; Fri, 03 Jul 2020 09:39:26 -0400
X-MC-Unique: HN_JwzWiNtmJnbIccLMHJw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E99C1902EA8;
        Fri,  3 Jul 2020 13:39:24 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-0.ams2.redhat.com [10.36.114.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E07B67AC7D;
        Fri,  3 Jul 2020 13:39:22 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: [PATCH v1 1/9] s390/vmem: rename vmem_add_mem() to vmem_add_range()
Date:   Fri,  3 Jul 2020 15:39:09 +0200
Message-Id: <20200703133917.39045-2-david@redhat.com>
In-Reply-To: <20200703133917.39045-1-david@redhat.com>
References: <20200703133917.39045-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's match the name to vmem_remove_range().

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/vmem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 3b9e71654c37b..66c5333020ead 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -57,7 +57,7 @@ pte_t __ref *vmem_pte_alloc(void)
 /*
  * Add a physical memory range to the 1:1 mapping.
  */
-static int vmem_add_mem(unsigned long start, unsigned long size)
+static int vmem_add_range(unsigned long start, unsigned long size)
 {
 	unsigned long pgt_prot, sgt_prot, r3_prot;
 	unsigned long pages4k, pages1m, pages2g;
@@ -308,7 +308,7 @@ int vmem_add_mapping(unsigned long start, unsigned long size)
 		return -ERANGE;
 
 	mutex_lock(&vmem_mutex);
-	ret = vmem_add_mem(start, size);
+	ret = vmem_add_range(start, size);
 	if (ret)
 		vmem_remove_range(start, size);
 	mutex_unlock(&vmem_mutex);
@@ -325,7 +325,7 @@ void __init vmem_map_init(void)
 	struct memblock_region *reg;
 
 	for_each_memblock(memory, reg)
-		vmem_add_mem(reg->base, reg->size);
+		vmem_add_range(reg->base, reg->size);
 	__set_memory((unsigned long)_stext,
 		     (unsigned long)(_etext - _stext) >> PAGE_SHIFT,
 		     SET_MEMORY_RO | SET_MEMORY_X);
-- 
2.26.2

