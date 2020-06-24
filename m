Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA918C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C6C920885
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6v4Y1b1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389955AbgFXJry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 05:47:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60802 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388034AbgFXJrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 05:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592992072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=84dXOiMild9I9O/vAtdotw5cdWGXEX19WD0RWkDQXeI=;
        b=O6v4Y1b1khu+S2rqvUwqO6D9BMaxhxjSBonmG8Hi1PmA2ToV6wNBLatbxSNZCBxIqd2v9i
        hQd2jmLyGLYGoV93k5s2nGyzQeCQYH1k3UDAL5D1B9WwgEkEKO5N3wPw2TtYfoBxYDkdj4
        GsASl4OT9kpPuTn9bXzogS91Rh63daw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-XOJChA7HPPqFajw_7cd2bA-1; Wed, 24 Jun 2020 05:47:50 -0400
X-MC-Unique: XOJChA7HPPqFajw_7cd2bA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3570188360A;
        Wed, 24 Jun 2020 09:47:47 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-65.ams2.redhat.com [10.36.113.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 317C4101E250;
        Wed, 24 Jun 2020 09:47:42 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH v3 0/3] mm/shuffle: fix and cleanups
Date:   Wed, 24 Jun 2020 11:47:38 +0200
Message-Id: <20200624094741.9918-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch #1 is a fix for overlapping zones and offline sections. Patch #2
documents why we have to shuffle on memory hotplug, when onlining memory.
Patch #3 removes dynamic reconfiguration which is currently dead code.

v2 -> v3:
- "mm/memory_hotplug: document why shuffle_zone() is relevant"
-- Fix spelling, reference introducing commit
- Added ACKs/RB's

v1 -> v2:
- Replace "mm/memory_hotplug: don't shuffle complete zone when onlining
  memory" by "mm/memory_hotplug: document why shuffle_zone() is relevant"
- "mm/shuffle: remove dynamic reconfiguration"
-- Add details why autodetection is not implemented

David Hildenbrand (3):
  mm/shuffle: don't move pages between zones and don't read garbage
    memmaps
  mm/memory_hotplug: document why shuffle_zone() is relevant
  mm/shuffle: remove dynamic reconfiguration

 mm/memory_hotplug.c |  8 ++++++++
 mm/shuffle.c        | 46 +++++++++++----------------------------------
 mm/shuffle.h        | 17 -----------------
 3 files changed, 19 insertions(+), 52 deletions(-)

-- 
2.26.2

