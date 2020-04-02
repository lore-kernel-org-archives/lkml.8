Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97930C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDCA20784
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GkgzCMmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388391AbgDBOBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:01:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42313 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726425AbgDBOBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585836091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=l3Lz3/NpN+EM4WUox3xNHgHxlnh2gL9sfw46cjDTFYo=;
        b=GkgzCMmcrl11zMhqlQAJks8flJVjd8Pe2NYc2sC/B0oF6ypFsWK87xLE2BMzHWZHZQ9pOO
        35Auox2xeLwvRgnJqBaqBbF6M0PufMhhTTZSuGr5kXTi+6opVKebx2aGYEK4Yw9JidSA6L
        veFaJ5l4vv2k1yJTMVpkl6NlJRlpXfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-RqFGssjRM9WbdfHG0PcDXg-1; Thu, 02 Apr 2020 10:01:27 -0400
X-MC-Unique: RqFGssjRM9WbdfHG0PcDXg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 049C9DB64;
        Thu,  2 Apr 2020 14:01:26 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 389B260BF1;
        Thu,  2 Apr 2020 14:01:22 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        iamjoonsoo.kim@lge.com, mhocko@kernel.org, bhe@redhat.com,
        mgorman@techsingularity.net, rientjes@google.com
Subject: [PATCH v2 2/3] mm/page_alloc.c: clear out zone->lowmem_reserve[] if the zone is empty
Date:   Thu,  2 Apr 2020 22:01:12 +0800
Message-Id: <20200402140113.3696-3-bhe@redhat.com>
In-Reply-To: <20200402140113.3696-1-bhe@redhat.com>
References: <20200402140113.3696-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When requesting memory allocation from a specific zone is not satisfied,
it will fall to lower zone to try allocating memory. In this case,
lower zone's ->lowmem_reserve[] will help protect its own memory resource.
The higher the relevant ->lowmem_reserve[] is, the harder the upper zone
can get memory from this lower zone.

However, this protection mechanism should be applied to populated zone,
but not an empty zone. So filling ->lowmem_reserve[] for empty zone is
not necessary, and may mislead people that it's valid data in that zone.

Node 2, zone      DMA
  pages free     0
        min      0
        low      0
        high     0
        spanned  0
        present  0
        managed  0
        protection: (0, 0, 1024, 1024)
Node 2, zone    DMA32
  pages free     0
        min      0
        low      0
        high     0
        spanned  0
        present  0
        managed  0
        protection: (0, 0, 1024, 1024)
Node 2, zone   Normal
  per-node stats
      nr_inactive_anon 0
      nr_active_anon 143
      nr_inactive_file 0
      nr_active_file 0
      nr_unevictable 0
      nr_slab_reclaimable 45
      nr_slab_unreclaimable 254

Here clear out zone->lowmem_reserve[] if zone is empty.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/page_alloc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c0c788798d8b..138a56c0f48f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7840,8 +7840,10 @@ static void setup_per_zone_lowmem_reserve(void)
 				idx--;
 				lower_zone = pgdat->node_zones + idx;
 
-				if (!sysctl_lowmem_reserve_ratio[idx]) {
+				if (!sysctl_lowmem_reserve_ratio[idx] ||
+				    !zone_managed_pages(lower_zone)) {
 					lower_zone->lowmem_reserve[j] = 0;
+					continue;
 				} else {
 					lower_zone->lowmem_reserve[j] =
 						managed_pages / sysctl_lowmem_reserve_ratio[idx];
-- 
2.17.2

