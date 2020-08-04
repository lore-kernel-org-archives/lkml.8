Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B3FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 07:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C68F22CA1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 07:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrPJXgEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbgHDHY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 03:24:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31113 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726974AbgHDHY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 03:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596525867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JiseTXeyGcxm0IDE+cCbj3AHOMga1BCxMtg+WGu3TNY=;
        b=JrPJXgEvM0Ke78HL0QOSMC8dbgTYeNJicscGhN0UKH83nILVb9AR7uPi9dqrY313YYlzZV
        8OHhZ5Y5kaqLZwBA8XDw3HjIwbJyz9Xifa6awKWsegz1MkxJ7kucEiMioTiWec6JifAtVL
        YeXCC8PtqzIY1EhCH1He6QYkbb4MUco=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-nqgPXntXN3GHtsdhgNi-Ww-1; Tue, 04 Aug 2020 03:24:23 -0400
X-MC-Unique: nqgPXntXN3GHtsdhgNi-Ww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D41D858;
        Tue,  4 Aug 2020 07:24:21 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-95.ams2.redhat.com [10.36.113.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7BE475DA33;
        Tue,  4 Aug 2020 07:24:09 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v3 0/6] mm / virtio-mem: support ZONE_MOVABLE
Date:   Tue,  4 Aug 2020 09:24:02 +0200
Message-Id: <20200804072408.5481-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@Andrew can we give this a churn and consider it for v5.9 in case there
are no more comments?

Patch #1-#4 have RB's, patch #5 is virtio-mem stuff maintained by me,
patch #6 is just a doc update.

---

Currently, virtio-mem does not really support ZONE_MOVABLE. While it allows
to online fully plugged memory blocks to ZONE_MOVABLE, it does not allow
to online partially-plugged memory blocks to ZONE_MOVABLE and will never
consider such memory blocks when unplugging memory. This might be
surprising for users (especially, if onlining suddenly fails).

Let's support partially plugged memory blocks in ZONE_MOVABLE, allowing
partially plugged memory blocks to be online to ZONE_MOVABLE and also
unplugging from such memory blocks.

This is especially helpful for testing, but also paves the way for
virtio-mem optimizations, allowing more memory to get reliably unplugged.

Cleanup has_unmovable_pages() and set_migratetype_isolate(), providing
better documentation of how ZONE_MOVABLE interacts with different kind of
unmovable pages (memory offlining vs. alloc_contig_range()).

v2 -> v3:
- "mm: document semantics of ZONE_MOVABLE"
-- Fix a typo

v1 -> v2:
- "mm/page_isolation: don't dump_page(NULL) in set_migratetype_isolate()"
-- Move to position 1, add Fixes: tag
-- Drop unused "out:" label
- "mm/page_isolation: drop WARN_ON_ONCE() in set_migratetype_isolate()"
-- Keep curly braces on "else" case
- Replace "[PATCH v1 5/6] mm/page_alloc: restrict ZONE_MOVABLE optimization
           in has_unmovable_pages() to memory offlining"
  by "mm: document semantics of ZONE_MOVABLE"
-- Brain dump of what I know about ZONE_MOVABLE

David Hildenbrand (6):
  mm/page_isolation: don't dump_page(NULL) in set_migratetype_isolate()
  mm/page_alloc: tweak comments in has_unmovable_pages()
  mm/page_isolation: drop WARN_ON_ONCE() in set_migratetype_isolate()
  mm/page_isolation: cleanup set_migratetype_isolate()
  virtio-mem: don't special-case ZONE_MOVABLE
  mm: document semantics of ZONE_MOVABLE

 drivers/virtio/virtio_mem.c | 47 +++++++------------------------------
 include/linux/mmzone.h      | 34 +++++++++++++++++++++++++++
 mm/page_alloc.c             | 22 +++++------------
 mm/page_isolation.c         | 39 ++++++++++++++----------------
 4 files changed, 65 insertions(+), 77 deletions(-)

-- 
2.26.2

