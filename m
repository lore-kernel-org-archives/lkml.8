Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B1AC38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D677320857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKoJNQCK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgDQPCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:02:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58526 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728271AbgDQPCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587135726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xefEX7Y1nMqJoMT6fqIG0MZlY8K0HkA37+fDXJufNeQ=;
        b=UKoJNQCK8y6B2wvEuygRGp8cv3WloIoWCGmrhKU4BO6MSfumpwDqQ05zdU3d/kd00J3W0a
        BgsCC8/lu/VGTrqxJK6etw+t3moM3WbdnHZ/v5QpeTLVFwjkT1CrsU342l7eg/OcghBgol
        Wk3NOxwme9gh/iR1mUylfkGYV8aE82g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-rVvU9jVkNO2o7A1Qd4PeoQ-1; Fri, 17 Apr 2020 11:02:03 -0400
X-MC-Unique: rVvU9jVkNO2o7A1Qd4PeoQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 531888018A7;
        Fri, 17 Apr 2020 15:02:02 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-107.ams2.redhat.com [10.36.114.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D3E59F9B5;
        Fri, 17 Apr 2020 15:02:00 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-s390@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [PATCH RFC 2/2] s390/mm: don't set ARCH_KEEP_MEMBLOCK
Date:   Fri, 17 Apr 2020 17:01:51 +0200
Message-Id: <20200417150151.17239-3-david@redhat.com>
In-Reply-To: <20200417150151.17239-1-david@redhat.com>
References: <20200417150151.17239-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 50be63450728 ("s390/mm: Convert bootmem to memblock") mentions
	"The original bootmem allocator is getting replaced by memblock. To
	cover the needs of the s390 kdump implementation the physical
	memory list is used."

zcore was converted to use resources instead of memblocks.
memblock_discard() will *not* mess with "physmem", only with "memory" and
"reserved" memblocks. So, that data will stay after early boot, to be
used in arch/s390/kernel/crash_dump.c to create the ELF header from
inside the 2nd (a.k.a. dumping) kernel.

We no longer need ARCH_KEEP_MEMBLOCK.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Philipp Rudo <prudo@linux.ibm.com>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 8206b2c19aa8..122bf4cad8a5 100644
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
--=20
2.25.1

