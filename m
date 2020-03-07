Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B47C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 08:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08DA20675
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 08:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Besub7F/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgCGImo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 03:42:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58387 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726193AbgCGImo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 03:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583570563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=GmgXVGiA+TBQpnsnaXGXkc4+xi5nwhM2ZnRo/JQe/AI=;
        b=Besub7F/KsyMau+8P+bgK+8p1Zz28/FKT20EtJDY9pzl/HYxAgrpxqw4KvnEi/30KJG7qu
        d9yd3dUJlWFV7LZIymxRRS6/e6zXbWMIrRptspbItTmoV1N0vxGnm3EWumzP5wu1aV2hCa
        2gOE1w/18mIA9O90OTpxgZP7RHodOkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219--Q7cM5PqOoCJv0w6QBDDIw-1; Sat, 07 Mar 2020 03:42:39 -0500
X-MC-Unique: -Q7cM5PqOoCJv0w6QBDDIw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D4618017CC;
        Sat,  7 Mar 2020 08:42:37 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2305A5D9CA;
        Sat,  7 Mar 2020 08:42:30 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com,
        david@redhat.com, richardw.yang@linux.intel.com,
        dan.j.williams@intel.com, osalvador@suse.de, rppt@linux.ibm.com,
        bhe@redhat.com
Subject: [PATCH v3 0/7] mm/hotplug: Only use subsection map for VMEMMAP
Date:   Sat,  7 Mar 2020 16:42:22 +0800
Message-Id: <20200307084229.28251-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory sub-section hotplug was added to fix the issue that nvdimm could
be mapped at non-section aligned starting address. A subsection map is
added into struct mem_section_usage to implement it. 

However, config ZONE_DEVICE depends on SPARSEMEM_VMEMMAP. It means
subsection map only makes sense when SPARSEMEM_VMEMMAP enabled. For the                                                                           
classic sparse, subsection map is meaningless and confusing.

About the classic sparse which doesn't support subsection hotplug, Dan
said it's more because the effort and maintenance burden outweighs the
benefit. Besides, the current 64 bit ARCHes all enable
SPARSEMEM_VMEMMAP_ENABLE by default.

In this patchset, the patches 2~4 ares used to make sub-section map and the
relevant operation only available for VMEMMAP. 

Patch 1 fixes a hot remove failure when the classic sparse is enabled.

Patches 5~7 are for document adding and doc/code cleanup.

Changelog

v2->v3:
  David spotted a code bug in the old patch 1, the old local variable
  subsection_map is invalid once ms->usage is resetting. Add a local
  variable 'empty' to cache if subsection_map is empty or not.

  Remove the kernel-doc comments for the newly added functions
  fill_subsection_map() and clear_subsection_map(). Michal and David
  suggested this.

  Add a new static function is_subsection_map_empty() to check if the
  handled section map is empty, but not return the value from
  clear_subsection_map(). David suggested this.

  Add document about only VMEMMAP supporting sub-section hotplug, and
  check_pfn_span() gating the alignment and size. Michal help rephrase
  the words. 

v1->v2:
  Move the hot remove fixing patch to the front so that people can
  back port it to easier. Suggested by David.

  Split the old patch which invalidate the sub-section map in
  !VMEMMAP case into two patches, patch 4/7, and patch 6/7. This
  makes patch reviewing easier. Suggested by David.

  Take Wei Yang's fixing patch out to post alone, since it has been
  reviewed and acked by people. Suggested by Andrew.

  Fix a code comment mistake in the current patch 2/7. Found out by
  Wei Yang during reviewing.

Baoquan He (7):
  mm/hotplug: fix hot remove failure in SPARSEMEM|!VMEMMAP case
  mm/sparse.c: introduce new function fill_subsection_map()
  mm/sparse.c: introduce a new function clear_subsection_map()
  mm/sparse.c: only use subsection map in VMEMMAP case
  mm/sparse.c: add note about only VMEMMAP supporting sub-section
    support
  mm/sparse.c: move subsection_map related codes together
  mm/sparse.c: Use __get_free_pages() instead in
    populate_section_memmap()

 include/linux/mmzone.h |   2 +
 mm/sparse.c            | 159 +++++++++++++++++++++++++++--------------
 2 files changed, 107 insertions(+), 54 deletions(-)

-- 
2.17.2

