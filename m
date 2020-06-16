Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902AEC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F33820CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+WWapIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgFPLw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:52:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27415 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726052AbgFPLw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 07:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592308347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Pr+wuRZtHm7tiAqBY6uNhMOKLlUQ7F/W7bJv+gvRi8o=;
        b=Y+WWapILZucmM+kSNW0Wws1UEyoz3LVpvh3fuuWa3ISoTeBwWyq/SDvuYe196arF0jumvg
        gEL7GhfbAEew7+cGQofEQWJD6po4kSlXnle9o/5K1Q+skK67uUtvwSENNbihLlmoh1Ox9e
        dpM4yzRjKip/qyujJ0iMSGV8iB+rkvI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-_D6WWEHuNrmra6ivUbR8eQ-1; Tue, 16 Jun 2020 07:52:23 -0400
X-MC-Unique: _D6WWEHuNrmra6ivUbR8eQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1465A803329;
        Tue, 16 Jun 2020 11:52:21 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-106.ams2.redhat.com [10.36.114.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED025707C6;
        Tue, 16 Jun 2020 11:52:14 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <keith.busch@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v1 0/3] mm/shuffle: fix and cleanips
Date:   Tue, 16 Jun 2020 13:52:10 +0200
Message-Id: <20200616115213.13109-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch #1 is a fix for overlapping zones and offline sections. Patch #2
stops shuffling the complete zone when onlining a memory block. Patch #3
removes dynamic reconfiguration which is currently dead code (and it's
unclear if this will be needed in the near future).

David Hildenbrand (3):
  mm/shuffle: don't move pages between zones and don't read garbage
    memmaps
  mm/memory_hotplug: don't shuffle complete zone when onlining memory
  mm/shuffle: remove dynamic reconfiguration

 mm/memory_hotplug.c |  3 ---
 mm/shuffle.c        | 48 ++++++++++++---------------------------------
 mm/shuffle.h        | 29 ---------------------------
 3 files changed, 12 insertions(+), 68 deletions(-)

-- 
2.26.2

