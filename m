Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6ECC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DD2206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJQJD5FA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388421AbgDBOBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:01:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36402 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726425AbgDBOBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585836092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=P47tpISp/BvzRS6PYC8l3ShMVYjQpript2B4/RcjUII=;
        b=jJQJD5FAawG1XO4EQjIWGGQVesvD4tZcvdxbQ0mzaXoNOR5PpCUPAV7rMlCX7rSqRKjirK
        bBANjGnPKkiJa5lkJ6ZjJIX0eVkkFuDe/CoOsJ3elMDZL2sKC/OsFlAIqqgA15XHbpKhyr
        bdvXtWB4lruyNCIqagQ/FRx1B5dCook=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-p88hI8ERNW2AeZOKGVT1nw-1; Thu, 02 Apr 2020 10:01:21 -0400
X-MC-Unique: p88hI8ERNW2AeZOKGVT1nw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59433DB6B;
        Thu,  2 Apr 2020 14:01:19 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E516260BF1;
        Thu,  2 Apr 2020 14:01:14 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        iamjoonsoo.kim@lge.com, mhocko@kernel.org, bhe@redhat.com,
        mgorman@techsingularity.net, rientjes@google.com
Subject: [PATCH v2 0/3] improvements about lowmem_reserve and /proc/zoneinfo
Date:   Thu,  2 Apr 2020 22:01:10 +0800
Message-Id: <20200402140113.3696-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this post, I just drop the patch 4 and patch 5 in old v1 since David
and Michal worried moving per-node stats to the front of /proc/zoneinfo
has potential to break the existing user space scripts. For patch 1~3,
there's no change, seems no risk is found out so far, so just keep them
and repost.

The v1 thread can be found here:
https://lore.kernel.org/linux-mm/20200324142229.12028-1-bhe@redhat.com/

Baoquan He (3):
  mm/page_alloc.c: only tune sysctl_lowmem_reserve_ratio value once when
    changing it
  mm/page_alloc.c: clear out zone->lowmem_reserve[] if the zone is empty
  mm/vmstat.c: do not show lowmem reserve protection information of
    empty zone

 mm/page_alloc.c | 13 +++++++++++--
 mm/vmstat.c     | 12 ++++++------
 2 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.17.2

