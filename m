Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1003FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 22:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE97B20899
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 22:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGBwUYy9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388743AbgFXWM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 18:12:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53760 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728798AbgFXWM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 18:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593036775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0ksvO9ticUJvIkR1i4QO0sQ/GYZlPZO564d2hYgiyFM=;
        b=DGBwUYy9+n/m/iO8SqyvQ2dRmBRjsmOC38qgw8rT8HcF6PZ563B9Dk+yP5aTxA9/L6U0SO
        Se4uv/WwrwK8N4QiaAA5nNxLSs0Dr7iAuTSsNGP5+eBCVWXyrKpYre5NAhZhP/qj7T5ivG
        hdLJvvau+jxMhWQUYc1lmgpYxNMh9Hg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-Hv2wShhSMUam2jc56p5bZw-1; Wed, 24 Jun 2020 18:12:53 -0400
X-MC-Unique: Hv2wShhSMUam2jc56p5bZw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8444B1005512;
        Wed, 24 Jun 2020 22:12:52 +0000 (UTC)
Received: from jsavitz.bos.com (ovpn-112-219.rdu2.redhat.com [10.10.112.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC95179327;
        Wed, 24 Jun 2020 22:12:48 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Rafael Aquini <aquini@redhat.com>,
        Fabrizio D'Angelo <fdangelo@redhat.com>, linux-mm@kvack.org,
        trivial@kernel.org
Subject: [PATCH] mm/page_alloc: fix documentation error
Date:   Wed, 24 Jun 2020 18:12:36 -0400
Message-Id: <20200624221236.29560-1-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Rafael Aquini <aquini@redhat.com>
Cc: Fabrizio D'Angelo <fdangelo@redhat.com>
Cc: linux-mm@kvack.org
Cc: trivial@kernel.org

When I increased the upper bound of the min_free_kbytes value in
ee8eb9a5fe863, I forgot to tweak the above comment to reflect
the new value. This patch fixes that mistake.

Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 48eb0f1410d4..e028b87ce294 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7832,7 +7832,7 @@ void setup_per_zone_wmarks(void)
  * Initialise min_free_kbytes.
  *
  * For small machines we want it small (128k min).  For large machines
- * we want it large (64MB max).  But it is not linear, because network
+ * we want it large (256MB max).  But it is not linear, because network
  * bandwidth does not increase linearly with machine size.  We use
  *
  *	min_free_kbytes = 4 * sqrt(lowmem_kbytes), for better accuracy:
-- 
2.23.0

