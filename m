Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCBAC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 391D720768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YohsMXTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbgF3Imw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:42:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37307 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728132AbgF3Imv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 04:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593506569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mMek0t2pSkJxyvN4LFvUyYB33GHpZByMfTgNNPMGb7s=;
        b=YohsMXTp3xrfA4kEKHtXBt+euLAusq/8bVkAHJdmxNvBKH9OfUicHMA02tFNxQS+cugKE3
        lhqXspa4HrIibA78UjmGJ/vKYSO2IxE6nZxjvfl4T8ErPwNfdtVw+BheK4ePG6sszyJXyF
        Az+oDkutGNyqwVrtFtZFZXv4S06bz4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-xaprAVJLPJWW_5PpBSGALg-1; Tue, 30 Jun 2020 04:42:47 -0400
X-MC-Unique: xaprAVJLPJWW_5PpBSGALg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EBEE107ACCA;
        Tue, 30 Jun 2020 08:42:46 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-56.ams2.redhat.com [10.36.114.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67D7710013C0;
        Tue, 30 Jun 2020 08:42:41 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: [PATCH v1] s390/extmem: remove stale -ENOSPC comment and handling
Date:   Tue, 30 Jun 2020 10:42:40 +0200
Message-Id: <20200630084240.8283-1-david@redhat.com>
In-Reply-To: <20200625150029.45019-1-david@redhat.com>
References: <20200625150029.45019-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

segment_load() will no longer return -ENOSPC. If a segment overlaps with
storage, we now also return -EBUSY. Remove the stale comment from
__segment_load() and the stale handling from segment_warning().

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/extmem.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/s390/mm/extmem.c b/arch/s390/mm/extmem.c
index 105c09282f8c5..5060956b8e7d6 100644
--- a/arch/s390/mm/extmem.c
+++ b/arch/s390/mm/extmem.c
@@ -401,8 +401,7 @@ __segment_load (char *name, int do_nonshared, unsigned long *addr, unsigned long
  * -EIO     : could not perform query or load diagnose
  * -ENOENT  : no such segment
  * -EOPNOTSUPP: multi-part segment cannot be used with linux
- * -ENOSPC  : segment cannot be used (overlaps with storage)
- * -EBUSY   : segment can temporarily not be used (overlaps with dcss)
+ * -EBUSY   : segment cannot be used (overlaps with dcss or storage)
  * -ERANGE  : segment cannot be used (exceeds kernel mapping range)
  * -EPERM   : segment is currently loaded with incompatible permissions
  * -ENOMEM  : out of memory
@@ -627,10 +626,6 @@ void segment_warning(int rc, char *seg_name)
 		pr_err("DCSS %s has multiple page ranges and cannot be "
 		       "loaded or queried\n", seg_name);
 		break;
-	case -ENOSPC:
-		pr_err("DCSS %s overlaps with used storage and cannot "
-		       "be loaded\n", seg_name);
-		break;
 	case -EBUSY:
 		pr_err("%s needs used memory resources and cannot be "
 		       "loaded or queried\n", seg_name);
-- 
2.26.2

