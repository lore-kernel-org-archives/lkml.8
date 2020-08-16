Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468AEC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 12:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25652207FB
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 12:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zj4/69PM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgHPMx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 08:53:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50842 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725843AbgHPMxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 08:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597582429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XGLoJ7O+V6ZZmFm5YMkauKx8SWaJ05qtX0s9I5/GzsQ=;
        b=Zj4/69PM/ok61cQD9hxaj0fZzbu3dunDN6+5bE4XK5eMJdoRZFJcNjamcUPCN4mqa3OPZL
        Yyz9k+48w+w+YvlLhhvzhrY8mu3DS3+NxD8i8ruQfKxeztvCNd4EYpcdBk2IQNxLDp/ItO
        GZouSiwmkd2Lkglx5oQsG4AxCLZHEBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-kB4Cn_1BNAaaJmFGj8OAbg-1; Sun, 16 Aug 2020 08:53:44 -0400
X-MC-Unique: kB4Cn_1BNAaaJmFGj8OAbg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36802801A9D;
        Sun, 16 Aug 2020 12:53:43 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-43.ams2.redhat.com [10.36.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 108476E72F;
        Sun, 16 Aug 2020 12:53:33 +0000 (UTC)
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
        Mike Rapoport <rppt@linux.ibm.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v5 0/6] mm / virtio-mem: support ZONE_MOVABLE
Date:   Sun, 16 Aug 2020 14:53:27 +0200
Message-Id: <20200816125333.7434-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For 5.10. Patch #1-#4,#6 have RBs or ACKs, patch #5 is virtio-mem stuff
maintained by me. This should go via the -mm tree.

---

When introducing virtio-mem, the semantics of ZONE_MOVABLE were rather
unclear, which is why we special-cased ZONE_MOVABLE such that partially
plugged blocks would never end up in ZONE_MOVABLE.

Now that the semantics are much clearer (and are documented in patch #6),
let's support partially plugged memory blocks in ZONE_MOVABLE, allowing
partially plugged memory blocks to be online to ZONE_MOVABLE and also
unplugging from such memory blocks. This avoids surprises when onlining
of memory blocks suddenly fails, just because they are not completely
populated by virtio-mem (yet).

This is especially helpful for testing, but also paves the way for
virtio-mem optimizations, allowing more memory to get reliably unplugged.

Cleanup has_unmovable_pages() and set_migratetype_isolate(), providing
better documentation of how ZONE_MOVABLE interacts with different kind of
unmovable pages (memory offlining vs. alloc_contig_range()).

v4 -> v5:
- Rename "mm/page_isolation: don't dump_page(NULL) in
  set_migratetype_isolate()" to "mm/page_isolation: exit early when
  pageblock is isolated in set_migratetype_isolate()" as I was messing
  up things while reshuffling patches (dump_page(NULL) could never happen,
  only the WARN_ON_ONCE())
-- Clarify in the description that this is currently a cleanup only
- "mm: document semantics of ZONE_MOVABLE"
-- Clarified in the memory hole case, that kernelcore/movablecore is
   required to create such rare special cases

v3 -> v4:
- "mm/page_isolation: drop WARN_ON_ONCE() in set_migratetype_isolate()"
-- Fix typo in description
- "virtio-mem: don't special-case ZONE_MOVABLE"
-- Add more details why we initialli special-cased ZONE_MOVABLE (via MST)
- "mm: document semantics of ZONE_MOVABLE"
-- Rephrase some parts of documentation (via Mike)

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
  mm/page_alloc: tweak comments in has_unmovable_pages()
  mm/page_isolation: exit early when pageblock is isolated in
    set_migratetype_isolate()
  mm/page_isolation: drop WARN_ON_ONCE() in set_migratetype_isolate()
  mm/page_isolation: cleanup set_migratetype_isolate()
  virtio-mem: don't special-case ZONE_MOVABLE
  mm: document semantics of ZONE_MOVABLE

 drivers/virtio/virtio_mem.c | 47 +++++++------------------------------
 include/linux/mmzone.h      | 35 +++++++++++++++++++++++++++
 mm/page_alloc.c             | 22 +++++------------
 mm/page_isolation.c         | 39 ++++++++++++++----------------
 4 files changed, 66 insertions(+), 77 deletions(-)

-- 
2.26.2

