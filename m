Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DF3C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F3642080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYNQv3fe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgCXOW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:22:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:33080 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727270AbgCXOWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585059774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=JCJHy18k9QJc+GlupAj+Hwcwpa9SELMxiXWh1QeV9l4=;
        b=CYNQv3feP/wGOg+50axV6+wm+YWevznRWCRIKV/EcXvrZoKVAk0Ben7CYdEsCyn6NdETng
        VqkQ19/syKHN8G8n61KhfBRz7oOgQCO9JM0X1qi9QO16D2Vx65PinV2kybAt0eNdvzFVsq
        earh2ykEOuYnFTpMNGvWwB/tCNCBu5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-ZVGxS3XOMIKJBlzaNmo8yg-1; Tue, 24 Mar 2020 10:22:36 -0400
X-MC-Unique: ZVGxS3XOMIKJBlzaNmo8yg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F53B13F6;
        Tue, 24 Mar 2020 14:22:35 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-69.pek2.redhat.com [10.72.12.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE6015C1B2;
        Tue, 24 Mar 2020 14:22:31 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        iamjoonsoo.kim@lge.com, hannes@cmpxchg.org, mhocko@kernel.org,
        vbabka@suse.cz, bhe@redhat.com
Subject: [PATCH 0/5] improvements about lowmem_reserve and /proc/zoneinfo 
Date:   Tue, 24 Mar 2020 22:22:24 +0800
Message-Id: <20200324142229.12028-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When tried to review below patchset from Joonsoo, I found out there's
some space to improve about lowmem_reserve and /proc/zoneinfo printing.
So made this patchset to do it.

[PATCH v3 0/2] integrate classzone_idx and high_zoneidx
http://lkml.kernel.org/r/1584693135-4396-1-git-send-email-iamjoonsoo.kim@lge.com

Baoquan He (5):
  mm/page_alloc.c: only tune sysctl_lowmem_reserve_ratio value once when
    changing it
  mm/page_alloc.c: clear out zone->lowmem_reserve[] if the zone is empty
  mm/vmstat.c: do not show lowmem reserve protection information of
    empty zone
  mm/vmstat.c: move the per-node stats to the front of /proc/zoneinfo
  mm/vmstat.c: remove the useless code

 mm/page_alloc.c | 13 +++++++++++--
 mm/vmstat.c     | 44 +++++++++++++++++---------------------------
 2 files changed, 28 insertions(+), 29 deletions(-)

-- 
2.17.2

