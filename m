Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CBBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E47EE20672
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivUHG2Ue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388854AbgF3O0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:26:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22021 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727874AbgF3O0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593527213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gU/53Q4tAoN32Y01QPMAepmzJ7LSqVhB1rBWsw7cZSg=;
        b=ivUHG2Ue/uy/wpdd/UFPh0xbhPS/aYk+XYW3H9misWf9y47sHUNEBtx1hvACkDYtvAm4Xg
        lVwNCVOUt7RfzAKH5ZYJp0uZ1rnACU0SJ2dkdk+5Qr6mEPEC/6COeCWoiGkxevE/kFkC2W
        gOgSwQ13/qjQSxPoXMPOChS0SItoLio=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-4CP9VNIcMiS_76sFdXrFRQ-1; Tue, 30 Jun 2020 10:26:49 -0400
X-MC-Unique: 4CP9VNIcMiS_76sFdXrFRQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66AAA18A8223;
        Tue, 30 Jun 2020 14:26:48 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-56.ams2.redhat.com [10.36.114.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06CF0282EF;
        Tue, 30 Jun 2020 14:26:39 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v1 0/6] mm / virtio-mem: support ZONE_MOVABLE
Date:   Tue, 30 Jun 2020 16:26:33 +0200
Message-Id: <20200630142639.22770-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

David Hildenbrand (6):
  mm/page_alloc: tweak comments in has_unmovable_pages()
  mm/page_isolation: don't dump_page(NULL) in set_migratetype_isolate()
  mm/page_isolation: drop WARN_ON_ONCE() in set_migratetype_isolate()
  mm/page_isolation: cleanup set_migratetype_isolate()
  mm/page_alloc: restrict ZONE_MOVABLE optimization in
    has_unmovable_pages() to memory offlining
  virtio-mem: don't special-case ZONE_MOVABLE

 drivers/virtio/virtio_mem.c | 47 +++++++------------------------------
 mm/page_alloc.c             | 29 +++++++++--------------
 mm/page_isolation.c         | 40 ++++++++++++++-----------------
 3 files changed, 36 insertions(+), 80 deletions(-)

-- 
2.26.2

