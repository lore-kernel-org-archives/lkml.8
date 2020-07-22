Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E4CC433EA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A48412068F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OCbuN3xB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731604AbgGVJqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:46:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34504 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729864AbgGVJqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595411169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MBPzayyDDaE0GAZE66kREJVgIDaMwKB4hXq7u7LMzPg=;
        b=OCbuN3xBuKgGv0rEWwCeavFtqddv5NTBHfLqOeUYTzh9UmnLYjjb8+cp9TBHbzhT4ZjrRS
        VE8mtAZhW3QLKrWLFjcP+OpPORoR21YLbkv2Cx5YUL7WnMeGDNt2m94SY1w9o+OUR8rZtG
        E9kXnH5vD2HySFWN9qr7sp1TdAvH9pg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-Qbgut7EmOUKmHE08V_x4SA-1; Wed, 22 Jul 2020 05:46:05 -0400
X-MC-Unique: Qbgut7EmOUKmHE08V_x4SA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F13CE100CCC0;
        Wed, 22 Jul 2020 09:46:03 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-254.ams2.redhat.com [10.36.113.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79D355D9DC;
        Wed, 22 Jul 2020 09:45:59 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH v2 0/9] s390: implement and optimize vmemmap_free()
Date:   Wed, 22 Jul 2020 11:45:49 +0200
Message-Id: <20200722094558.9828-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on the latest s390/features branch [1]. It
consolidates vmem_add_range(), vmem_remove_range(), and vmemmap_populate()
into a single, recursive page table walker. It then implements
vmemmap_free() and optimizes it by
- Freeing empty page tables (also done for vmem_remove_range()).
- Handling cases where the vmemmap of a section does not fill huge pages
  completely (e.g., sizeof(struct page) == 56).

vmemmap_free() is currently never used, unless adiing standby memory fails
(unlikely). This is relevant for virtio-mem, which adds/removes memory
in memory block/section granularity (always removes memory in the same
granularity it added it).

I gave this a proper test with my virtio-mem prototype (which I will share
in the near future), both with 56 byte memmap per page and 64 byte memmap
per page, with and without huge page support. In both cases, removing
memory (routed through arch_remove_memory()) will result in
- all populated vmemmap pages to get removed/freed
- all applicable page tables for the vmemmap getting removed/freed
- all applicable page tables for the idendity mapping getting removed/freed
Unfortunately, I don't have access to bigger and z/VM (esp. dcss)
environments.

This is the basis for real memory hotunplug support for s390x and should
complete my journey to s390x vmem/vmemmap code for now

What needs double-checking is tlb flushing. AFAIKS, as there are no valid
accesses, doing a single range flush at the end is sufficient, both when
removing vmemmap pages and the idendity mapping.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features

v1 -> v2:
- Convert to a single page table walker named "modify_pagetable()", with
  two helper functions "add_pagetable()" and "remove_pagetable().

David Hildenbrand (9):
  s390/vmem: rename vmem_add_mem() to vmem_add_range()
  s390/vmem: consolidate vmem_add_range() and vmem_remove_range()
  s390/vmemmap: extend modify_pagetable() to handle vmemmap
  s390/vmemmap: cleanup when vmemmap_populate() fails
  s390/vmemmap: take the vmem_mutex when populating/freeing
  s390/vmem: cleanup empty page tables
  s390/vmemmap: fallback to PTEs if mapping large PMD fails
  s390/vmemmap: remember unused sub-pmd ranges
  s390/vmemmap: avoid memset(PAGE_UNUSED) when adding consecutive
    sections

 arch/s390/mm/vmem.c | 637 ++++++++++++++++++++++++++++++--------------
 1 file changed, 442 insertions(+), 195 deletions(-)

-- 
2.26.2

