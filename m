Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B9DC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B62A20656
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H05DFvEj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633870AbgDPLmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:42:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46084 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2505313AbgDPKtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 06:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587034161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cwGR/usUMuWdkRSa5KvWDh1h/9sFb7zCuX961pIpYkU=;
        b=H05DFvEjWoY/Or85i+7VYS5ffxreEFFvaindQEE0mH4O5y8j0DzXIN/bCMcpejG7tau6xd
        Bx1v0kK0UcB/EPi76PKCtQ8381BApfMbmnCoTNT+AX6XIwTipdEpnlq8oYACteNZv3D8M5
        xntr6Gb5zOmH4+eh6wulebAVEjmu8V4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-MZ4gobKSOR6M04ijtf7tPg-1; Thu, 16 Apr 2020 06:47:15 -0400
X-MC-Unique: MZ4gobKSOR6M04ijtf7tPg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75C51801E53;
        Thu, 16 Apr 2020 10:47:13 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-9.ams2.redhat.com [10.36.114.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E66A1001920;
        Thu, 16 Apr 2020 10:47:08 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Baoquan He <bhe@redhat.com>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH RFC 0/2] mm/memory_hotplug: handle memblocks only with CONFIG_ARCH_KEEP_MEMBLOCK
Date:   Thu, 16 Apr 2020 12:47:05 +0200
Message-Id: <20200416104707.20219-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on some other cleanups I stumbled over the creation/removal
of memblocks in hotplug code and wondered why we still need that. Turns
out, we only need that handling with CONFIG_ARCH_KEEP_MEMBLOCK - unless
I am missing something important (-> RFC).

I'll be sending out patches to remove CONFIG_ARCH_KEEP_MEMBLOCK on s390x
soonish, after finding a way to test them.

Gave it a quick test on x86-64.

David Hildenbrand (2):
  mm/memory_hotplug: no need to init new pgdat with node_start_pfn
  mm/memory_hotplug: handle memblocks only with
    CONFIG_ARCH_KEEP_MEMBLOCK

 mm/Kconfig          |  3 +++
 mm/memory_hotplug.c | 28 +++++++++++++---------------
 2 files changed, 16 insertions(+), 15 deletions(-)

--=20
2.25.1

