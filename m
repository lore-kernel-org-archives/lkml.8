Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CF4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1114220776
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fNnwq81C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732901AbgFSM7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:59:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57271 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728851AbgFSM7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 08:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592571581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rvOYlxX/ss3he1Lry1x4z3ESe0cJhRvr+Z1vSMlD8Bw=;
        b=fNnwq81CQ0PlYOsd8/Zemru/S9UU4xDCD9MIj+u6jhrRxNf2utA7tCHa7LkPbsEGkTmfN9
        i57IyNn6ijOjkT+Bz9eK8JVnbDxC9xUWnK4grziGp9vnltlQhewhfaAXSvQlNNkClWfsXO
        NysJYefNazQ50q2KQhsj45ekYasZE2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-Z3v5g7uPPfe9Nx2mtqzgMQ-1; Fri, 19 Jun 2020 08:59:37 -0400
X-MC-Unique: Z3v5g7uPPfe9Nx2mtqzgMQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DF2B107ACF6;
        Fri, 19 Jun 2020 12:59:36 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-137.ams2.redhat.com [10.36.113.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E99F05D9CA;
        Fri, 19 Jun 2020 12:59:34 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v2 2/3] mm/memory_hotplug: document why shuffle_zone() is relevant
Date:   Fri, 19 Jun 2020 14:59:21 +0200
Message-Id: <20200619125923.22602-3-david@redhat.com>
In-Reply-To: <20200619125923.22602-1-david@redhat.com>
References: <20200619125923.22602-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not completely obvious why we have to shuffle the complete zone, as
some sort of shuffling is already performed when onlining pages via
__free_one_page(), placing MAX_ORDER-1 pages either to the head or the tail
of the freelist. Let's document why we have to shuffle the complete zone
when exposing larger, contiguous physical memory areas to the buddy.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 9b34e03e730a4..a0d81d404823d 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -822,6 +822,14 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	zone->zone_pgdat->node_present_pages += onlined_pages;
 	pgdat_resize_unlock(zone->zone_pgdat, &flags);
 
+	/*
+	 * When exposing larger, physically contiguous memory areas to the
+	 * buddy, shuffling in the buddy (when freeing onlined pages, putting
+	 * them either to the head or the tail of the freelist) is only helpful
+	 * for mainining the shuffle, but not for creating the initial shuffle.
+	 * Shuffle the whole zone to make sure the just onlined pages are
+	 * properly distributed across the whole freelist.
+	 */
 	shuffle_zone(zone);
 
 	node_states_set_node(nid, &arg);
-- 
2.26.2

