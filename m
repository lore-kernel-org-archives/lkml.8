Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5C4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0832F20787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YmAfrco+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731941AbgGVJqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:46:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58809 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731370AbgGVJq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595411188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T0K2FcSq6leMfuluLpIVelm2NQA8cm14HeDeSCdv624=;
        b=YmAfrco+oYDXfQrMB7kiaLF0ZEvMHOvkpk8qzxJSREpwAtio6iR/62RY/U2yHkAJDYxPxf
        9uV69Safekacmd3oMcOKTcCuLLDGJ2YCmlpFJ9RByd97LYzwIzcv4Zv4O2USr6x3/SGI71
        +qlg4ot0Gbm2hX24/WaUiXFVOvvfhZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-YgASFoKtPVSRf2tB1VsMrA-1; Wed, 22 Jul 2020 05:46:24 -0400
X-MC-Unique: YgASFoKtPVSRf2tB1VsMrA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2774F800688;
        Wed, 22 Jul 2020 09:46:23 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-254.ams2.redhat.com [10.36.113.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1BC45D9CA;
        Wed, 22 Jul 2020 09:46:18 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: [PATCH v2 7/9] s390/vmemmap: fallback to PTEs if mapping large PMD fails
Date:   Wed, 22 Jul 2020 11:45:56 +0200
Message-Id: <20200722094558.9828-8-david@redhat.com>
In-Reply-To: <20200722094558.9828-1-david@redhat.com>
References: <20200722094558.9828-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's fallback to single pages if short on huge pages. No need to stop
memory hotplug.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/vmem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index b831f9f9130aa..e82a63de19db2 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -180,10 +180,10 @@ static int __ref modify_pmd_table(pud_t *pud, unsigned long addr,
 				 */
 				new_page = vmemmap_alloc_block(PMD_SIZE,
 							       NUMA_NO_NODE);
-				if (!new_page)
-					goto out;
-				pmd_val(*pmd) = __pa(new_page) | prot;
-				continue;
+				if (new_page) {
+					pmd_val(*pmd) = __pa(new_page) | prot;
+					continue;
+				}
 			}
 			pte = vmem_pte_alloc();
 			if (!pte)
-- 
2.26.2

