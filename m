Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE52C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3F1520776
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3XBdYw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732913AbgFSM7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:59:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49003 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728851AbgFSM7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 08:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592571575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hBBlOSUa1hmxJFitkEzGoexVk8IU/eydjJtgFiP7xqM=;
        b=T3XBdYw+pMbYeN3SXOp0Vc8yhzI8rWFWZly8qL34Lj6PyyhKl2bzrsU+xbCYDBExyhFwAj
        VUJDsdPn7KFUpLt5kM8+vcWt8CDDqeknlr+RlNEydR0k6JvHTf3bT27mZo56AFPQ7vSPhl
        HAnLTnnv04LzrPDQnzVpeQ4PtPRA3VY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-tkdsXn0gP0i7gwfFWZ4qZQ-1; Fri, 19 Jun 2020 08:59:33 -0400
X-MC-Unique: tkdsXn0gP0i7gwfFWZ4qZQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8000835B51;
        Fri, 19 Jun 2020 12:59:31 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-137.ams2.redhat.com [10.36.113.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8A9F5D9CA;
        Fri, 19 Jun 2020 12:59:23 +0000 (UTC)
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
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v2 0/3] mm/shuffle: fix and cleanups
Date:   Fri, 19 Jun 2020 14:59:19 +0200
Message-Id: <20200619125923.22602-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch #1 is a fix for overlapping zones and offline sections. Patch #2
documents why we have to shuffle on memory hotplug, when onlining memory.
Patch #3 removes dynamic reconfiguration which is currently dead code.

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

