Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A1CC34031
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 04:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59BC32465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 04:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPKXKS9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgBTEdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 23:33:35 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53535 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727476AbgBTEde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 23:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582173213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=7DqC/cWvoNfH4S97tWnGRiY8s53fR26RRmf0ozJgcU8=;
        b=BPKXKS9fCsPL00vJu7krnhT02LlTn6kSzYrhE160PPv12Fb26Fc8qlrng2FYeBjHvU9FYn
        +qdOcFb9JyzXAZj8+DefKafPNJFouGnwBe7yJV8ljgfsAVllExQUrIQSvg1gVQEySNOaMc
        H7dIB+QAHeKLtJI3SJ89RwAboxp2pys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-nVuufj3uNGak-C0Kp8jEZg-1; Wed, 19 Feb 2020 23:33:28 -0500
X-MC-Unique: nVuufj3uNGak-C0Kp8jEZg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AEB4800D53;
        Thu, 20 Feb 2020 04:33:26 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-32.pek2.redhat.com [10.72.12.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0BE725DA60;
        Thu, 20 Feb 2020 04:33:18 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        richardw.yang@linux.intel.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, mhocko@suse.com, bhe@redhat.com,
        rppt@linux.ibm.com, robin.murphy@arm.com
Subject: [PATCH v2 0/7] mm/hotplug: Only use subsection map in VMEMMAP case
Date:   Thu, 20 Feb 2020 12:33:09 +0800
Message-Id: <20200220043316.19668-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory sub-section hotplug was added to fix the issue that nvdimm could
be mapped at non-section aligned starting address. A subsection map is
added into struct mem_section_usage to implement it. However, sub-section
is only supported in VMEMMAP case. Hence there's no need to operate
subsection map in SPARSEMEM|!VMEMMAP case. In this patchset, change
codes to make sub-section map and the relevant operation only available
in VMEMMAP case.

And since sub-section hotplug added, the hot add/remove functionality
have been broken in SPARSEMEM|!VMEMMAP case. Wei Yang and I, each of us
make one patch to fix one of the failures. In this patchset, the patch
1/7 from me is used to fix the hot remove failure. Wei Yang's patch has
been merged by Andrew. 

Changelog:
v1->v2:
  Move the hot remove fixing patch to the front so that people can 
  back port it to easier. Suggested by David.

  Split the old patch which invalidate the sub-section map in
  !VMEMMAP case into two patches, patch 4/7, and patch 6/7. This
  makes patch reviewing easier. David by David.

  Take Wei Yang's fixing patch out to post alone, since it has been
  reviewed and acked by people. Suggested by Andrew.

  Fix a code comment mistake in the current patch 2/7. Found out by
  Wei Yang during reviewing.

Baoquan He (7):
  mm/hotplug: fix hot remove failure in SPARSEMEM|!VMEMMAP case
  mm/sparse.c: introduce new function fill_subsection_map()
  mm/sparse.c: introduce a new function clear_subsection_map()
  mm/sparse.c: only use subsection map in VMEMMAP case
  mm/sparse.c: add code comment about sub-section hotplug
  mm/sparse.c: move subsection_map related codes together
  mm/sparse.c: Use __get_free_pages() instead in
    populate_section_memmap()

 include/linux/mmzone.h |   2 +
 mm/sparse.c            | 178 +++++++++++++++++++++++++++++------------
 2 files changed, 127 insertions(+), 53 deletions(-)

-- 
2.17.2

