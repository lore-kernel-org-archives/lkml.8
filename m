Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE434C433F8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8906320714
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKZqApvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731860AbgGVJqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:46:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32401 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731680AbgGVJqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:46:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595411180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yYo4IrrUPC/u5TNQyahS6XDyB7Q0g6/zk1H4elFCsEo=;
        b=KKZqApvRXgufWtFML4lVttCx39ZWsxQe56lOALpagSNFEiKKiD+pYt1LYpwfE68P1r+UKY
        suTeD/cE8gDrJnLUvG29lo6Yi/+ZLNXntAtfNKlficNCmrsmSzRaid1DdjOIJKzRZ1Uy+I
        DZEIMJscgI16hqMHj2Yh+kL+jgTq0vs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-GIIpnbHlOd-59SCO_E-BiA-1; Wed, 22 Jul 2020 05:46:18 -0400
X-MC-Unique: GIIpnbHlOd-59SCO_E-BiA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61D85100AA24;
        Wed, 22 Jul 2020 09:46:16 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-254.ams2.redhat.com [10.36.113.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFDA45D9CA;
        Wed, 22 Jul 2020 09:46:14 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: [PATCH v2 5/9] s390/vmemmap: take the vmem_mutex when populating/freeing
Date:   Wed, 22 Jul 2020 11:45:54 +0200
Message-Id: <20200722094558.9828-6-david@redhat.com>
In-Reply-To: <20200722094558.9828-1-david@redhat.com>
References: <20200722094558.9828-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
index be32a38bb91fd..a2b79681df69d 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -334,17 +334,21 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 {
 	int ret;
 
+	mutex_lock(&vmem_mutex);
 	/* We don't care about the node, just use NUMA_NO_NODE on allocations */
 	ret = add_pagetable(start, end, false);
 	if (ret)
 		remove_pagetable(start, end, false);
+	mutex_unlock(&vmem_mutex);
 	return ret;
 }
 
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

