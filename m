Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91165C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DAB520885
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZN6giSeT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389992AbgFXJsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 05:48:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27407 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388034AbgFXJr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 05:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592992075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=As/RiLcx3QSCT66IiodQttbgWQYDaA6eF3/r4/FuBjM=;
        b=ZN6giSeTFKZDhyQ+QrS6DZredCd2F2bQawM6KcYyTAtdwBp+yLFsNGCucuHOs4+Yps2Mkp
        uo6cjhcZ+scIe1W9YtAw8kkltuSR5BiGp2SUHMeTUqK6Ax3E//Lf5hrK/2w+oT5MSZYDwi
        yjsd+yu1/G9FNMpw03jz4ur0A6vf1RY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-8IxozmEVPvCQQSRranh35g-1; Wed, 24 Jun 2020 05:47:54 -0400
X-MC-Unique: 8IxozmEVPvCQQSRranh35g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88982188360B;
        Wed, 24 Jun 2020 09:47:52 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-65.ams2.redhat.com [10.36.113.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E3CD1017E27;
        Wed, 24 Jun 2020 09:47:50 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: [PATCH v3 2/3] mm/memory_hotplug: document why shuffle_zone() is relevant
Date:   Wed, 24 Jun 2020 11:47:40 +0200
Message-Id: <20200624094741.9918-3-david@redhat.com>
In-Reply-To: <20200624094741.9918-1-david@redhat.com>
References: <20200624094741.9918-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not completely obvious why we have to shuffle the complete zone -
introduced in commit e900a918b098 ("mm: shuffle initial free memory to
improve memory-side-cache utilization") - because some sort of shuffling is
already performed when onlining pages via __free_one_page(), placing
MAX_ORDER-1 pages either to the head or the tail of the freelist. Let's
document why we have to shuffle the complete zone when exposing larger,
contiguous physical memory areas to the buddy.

Acked-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index be3c62e3fb95c..ac6961abaa103 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -831,6 +831,14 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	zone->zone_pgdat->node_present_pages += onlined_pages;
 	pgdat_resize_unlock(zone->zone_pgdat, &flags);
 
+	/*
+	 * When exposing larger, physically contiguous memory areas to the
+	 * buddy, shuffling in the buddy (when freeing onlined pages, putting
+	 * them either to the head or the tail of the freelist) is only helpful
+	 * for maintaining the shuffle, but not for creating the initial
+	 * shuffle. Shuffle the whole zone to make sure the just onlined pages
+	 * are properly distributed across the whole freelist.
+	 */
 	shuffle_zone(zone);
 
 	node_states_set_node(nid, &arg);
-- 
2.26.2

