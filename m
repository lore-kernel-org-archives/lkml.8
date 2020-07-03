Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD99C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB1A220782
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NpNw9mV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgGCNj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 09:39:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50879 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726048AbgGCNj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 09:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593783567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Td4QKttHcVBeWloZzMNJtuF2odL1QYLKXY8pp4abVHs=;
        b=NpNw9mV8bK/O3AW47kr+i1kuhxlKhXUktiflEyWQV0Ll+V9cM+ihwE4JP1Cwtb7nwP0rsx
        TAKTtp3fVjd43ckRxHGCo8RL20DVlojtvEFu9JmxTeVzMOFOI8SadXX9uE8X2h3F2Gawhx
        r9RBTpOWLY7EV5H96BG6P0z79kENHhg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-KX72pwCgMdS8-8e3QzyQlg-1; Fri, 03 Jul 2020 09:39:24 -0400
X-MC-Unique: KX72pwCgMdS8-8e3QzyQlg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9640CBFC4;
        Fri,  3 Jul 2020 13:39:22 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-0.ams2.redhat.com [10.36.114.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 170677AC7D;
        Fri,  3 Jul 2020 13:39:17 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH v1 0/9] s390: implement and optimize vmemmap_free()
Date:   Fri,  3 Jul 2020 15:39:08 +0200
Message-Id: <20200703133917.39045-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on the latest s390/features branch [1]. It implements
vmemmap_free(), consolidating it with vmem_add_range(), and optimizes it by
- Freeing empty page tables (now also done for idendity mapping).
- Handling cases where the vmemmap of a section does not fill huge pages
  completely.

vmemmap_free() is currently never used, unless adiing standby memory fails
(unlikely). This is relevant for virtio-mem, which adds/removes memory
in memory block/section granularity (always removes memory in the same
granularity it added it).

I gave this a proper test with my virtio-mem prototype (which I will share
once the basic QEMU implementation is upstream), both with 56 byte memmap
per page and 64 byte memmap per page, with and without huge page support.
In both cases, removing memory (routed through arch_remove_memory()) will
result in
- all populated vmemmap pages to get removed/freed
- all applicable page tables for the vmemmap getting removed/freed
- all applicable page tables for the idendity mapping getting removed/freed
Unfortunately, I don't have access to bigger and z/VM (esp. dcss)
environments.

This is the basis for real memory hotunplug support for s390x and should
complete my journey to s390x vmem/vmemmap code for now :)

What needs double-checking is tlb flushing. AFAIKS, as there are no valid
accesses, doing a single range flush at the end is sufficient, both when
removing vmemmap pages and the idendity mapping.

Along, some minor cleanups.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features

David Hildenbrand (9):
  s390/vmem: rename vmem_add_mem() to vmem_add_range()
  s390/vmem: recursive implementation of vmem_remove_range()
  s390/vmemmap: implement vmemmap_free()
  s390/vmemmap: cleanup when vmemmap_populate() fails
  s390/vmemmap: take the vmem_mutex when populating/freeing
  s390/vmem: cleanup empty page tables
  s390/vmemmap: fallback to PTEs if mapping large PMD fails
  s390/vmemmap: remember unused sub-pmd ranges
  s390/vmemmap: avoid memset(PAGE_UNUSED) when adding consecutive
    sections

 arch/s390/mm/vmem.c | 400 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 338 insertions(+), 62 deletions(-)

-- 
2.26.2

