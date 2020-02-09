Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCD2C3F68F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 10:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88B82080C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 10:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4FWiSKz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgBIKsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 05:48:40 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56870 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726081AbgBIKsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 05:48:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581245318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=z0Z0S0bd9YQeiqHAL6/0RXLiYTJOm2O0u4Uov4hCfLg=;
        b=f4FWiSKzXREhdq50S3xrhCiwG3tdpAxdZ83kdn3ELFrxZaOQPjTxPADlfsOqpKOzzZP+17
        vPPy4GhT1kpVuW7KYUkmXT73SuKtqSQ7LKGVkEy1CN8HhLN9AYZGtYhDkp/A46or14WsLA
        BuZefoSbCPpmZlJunD3hpE50nFs9Gnk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-v04u3ZY7PoarzC_GXcgLKg-1; Sun, 09 Feb 2020 05:48:34 -0500
X-MC-Unique: v04u3ZY7PoarzC_GXcgLKg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23F0310054E3;
        Sun,  9 Feb 2020 10:48:33 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F404A10018FF;
        Sun,  9 Feb 2020 10:48:27 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, richardw.yang@linux.intel.com,
        david@redhat.com, bhe@redhat.com
Subject: [PATCH 0/7] mm/hotplug: Only use subsection in VMEMMAP case and fix hot add/remove failure in SPARSEMEM|!VMEMMAP case
Date:   Sun,  9 Feb 2020 18:48:19 +0800
Message-Id: <20200209104826.3385-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory sub-section hotplug was added to fix the issue that nvdimm could
be mapped at non-section aligned starting address. A subsection map is
added into struct mem_section_usage implement it. However, sub-section
is only supported in VMEMMAP case, there's no need to operate subsection
map in SPARSEMEM|!VMEMMAP. The former 4 patches is for it.

And since sub-section hotplug added, the hot add/remove functionality
have been broken in SPARSEMEM|!VMEMMAP case. Wei Yang and I, each of us
make one patch to fix one issue.

Baoquan He (6):
  mm/sparse.c: Introduce new function fill_subsection_map()
  mm/sparse.c: Introduce a new function clear_subsection_map()
  mm/sparse.c: only use subsection map in VMEMMAP case
  mm/sparse.c: Use __get_free_pages() instead in
    populate_section_memmap()
  mm/sparse.c: update code comment about section activate/deactivate
  mm/hotplug: fix hot remove failure in SPARSEMEM|!VMEMMAP case

Wei Yang (1):
  mm/sparsemem: pfn_to_page is not valid yet on SPARSEMEM

 include/linux/mmzone.h |   2 +
 mm/sparse.c            | 248 ++++++++++++++++++++++++++---------------
 2 files changed, 161 insertions(+), 89 deletions(-)

-- 
2.17.2

