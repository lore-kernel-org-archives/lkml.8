Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B5EC5518B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1ED62076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUyVjlD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgDVPyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:54:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32492 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726472AbgDVPyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:54:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587570846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aJDnyZpIWP95k4SsgqPkwCGGLXiYUuGlji6Ow9Xys+c=;
        b=JUyVjlD0zRwN69rOvsWVmrIMdgY1m/WMdBmJNjiH7yrbXN2LFOdCLRDiOxxL6h3/hQjU6s
        ZS0Hz9m37HYcagJWjJ3GsINOo9nbBbhylfqaEXlSvWYulFLHksvtspod5Vy2UGBnRzsf2R
        FNv9qmPUq6/pmfNQD+p0urysFv+15K0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-xFz6ZPNXPMOjOVVdwwV1MQ-1; Wed, 22 Apr 2020 11:54:01 -0400
X-MC-Unique: xFz6ZPNXPMOjOVVdwwV1MQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95463107ACC9;
        Wed, 22 Apr 2020 15:53:59 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-57.ams2.redhat.com [10.36.114.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A83205D706;
        Wed, 22 Apr 2020 15:53:54 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Baoquan He <bhe@redhat.com>, Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v1 0/2] mm/memory_hotplug: handle memblocks only with CONFIG_ARCH_KEEP_MEMBLOCK
Date:   Wed, 22 Apr 2020 17:53:51 +0200
Message-Id: <20200422155353.25381-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on some other cleanups I stumbled over the creation/removal
of memblocks in hotplug code and wondered why we still need that. Turns
out, we only need that handling with CONFIG_ARCH_KEEP_MEMBLOCK.

Gave it a quick test on x86-64.

RFC -> v1:
- Added ACKs
- Rephrased subject/description of patch #1
- Use IS_ENABLED() instead of ifdefs in patch #2

David Hildenbrand (2):
  mm/memory_hotplug: set node_start_pfn of hotadded pgdat to 0
  mm/memory_hotplug: handle memblocks only with
    CONFIG_ARCH_KEEP_MEMBLOCK

 mm/Kconfig          |  3 +++
 mm/memory_hotplug.c | 35 ++++++++++++++++-------------------
 2 files changed, 19 insertions(+), 19 deletions(-)

--=20
2.25.3

