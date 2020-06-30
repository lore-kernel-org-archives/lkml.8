Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54647C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D7E120768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="apnBeKlY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731139AbgF3IRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:17:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26818 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730670AbgF3IRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 04:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593505066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OxgbA78Isty5LjQU/goDcTyWCLKH0Y+Zl49XxrxsnYY=;
        b=apnBeKlYmoSNpHphKOIkW63ZMvjIcsM1qDFNztTj9C/2bdUdop1KazYqK4Glfn9oiJoySk
        kYEn49s2gaXaqMaE1QHe790bzZ3WWsEE5RkPhS43yClUc9HlzSLqBnLslDhdBXRC67yX+e
        eouxeoRURC7vKE4pmOHHaDRrAFlU/Ps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-bfePINz7OSWHjz17WoQMmA-1; Tue, 30 Jun 2020 04:17:42 -0400
X-MC-Unique: bfePINz7OSWHjz17WoQMmA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9016100CCC0;
        Tue, 30 Jun 2020 08:17:40 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-56.ams2.redhat.com [10.36.114.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5F3060BEC;
        Tue, 30 Jun 2020 08:17:38 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 2/2] s390/mm: don't set ARCH_KEEP_MEMBLOCK
Date:   Tue, 30 Jun 2020 10:17:30 +0200
Message-Id: <20200630081730.6862-3-david@redhat.com>
In-Reply-To: <20200630081730.6862-1-david@redhat.com>
References: <20200630081730.6862-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 50be63450728 ("s390/mm: Convert bootmem to memblock") mentions
	"The original bootmem allocator is getting replaced by memblock. To
	cover the needs of the s390 kdump implementation the physical
	memory list is used."

As we can now reference "physmem" managed in the memblock allocator after
init even without ARCH_KEEP_MEMBLOCK, and s390x does no longer need
other memblock metadata after boot (esp., the zcore memmap device that used
it got removed), we can stop setting ARCH_KEEP_MEMBLOCK.

With this change, we no longer create memblocks for standby/hotplugged
memory (added via add_memory()) and free up memblock metdata (except
physmem) after boot.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Philipp Rudo <prudo@linux.ibm.com>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index c7d7ede6300c5..7697a1f8e819a 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -102,7 +102,6 @@ config S390
 	select ARCH_INLINE_WRITE_UNLOCK_BH
 	select ARCH_INLINE_WRITE_UNLOCK_IRQ
 	select ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE
-	select ARCH_KEEP_MEMBLOCK
 	select ARCH_STACKWALK
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_NUMA_BALANCING
-- 
2.26.2

