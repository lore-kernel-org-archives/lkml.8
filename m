Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FABC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38722067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 12:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rq1cTr58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgCLMo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 08:44:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53815 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725978AbgCLMo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 08:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584017066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=U43XaPUC3PwlgayDYxZ3AihkbX2l033vy/KfO0DfgaA=;
        b=Rq1cTr58jUH69Fwd/PPDRBAzAXBBhDi6XJUp4dDDmQA0AlQHhYrxirV9+CKQ//41fjnOXV
        3mIqVATOD3q8yRiCtdjzAnJmTAMKa6XfOXnzx4PByeVzA82rCkDW9Weau2853YHWQd+XPs
        1X61gRTuVDiUP0Nw0UdHdQKZN5kWnYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-jSsTkPoOMc-4uT-JjrVZTg-1; Thu, 12 Mar 2020 08:44:24 -0400
X-MC-Unique: jSsTkPoOMc-4uT-JjrVZTg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2A4F107B7E4;
        Thu, 12 Mar 2020 12:44:22 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-43.pek2.redhat.com [10.72.12.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0ACBD8FBFE;
        Thu, 12 Mar 2020 12:44:15 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com,
        david@redhat.com, richard.weiyang@gmail.com,
        dan.j.williams@intel.com, bhe@redhat.com
Subject: [PATCH v4 0/5]  mm/hotplug: Only use subsection map for VMEMMAP
Date:   Thu, 12 Mar 2020 20:44:09 +0800
Message-Id: <20200312124414.439-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

This patchset is rebased on the old patch 1 of v3 and an apended fix
which doesn't initialize the local variable 'empty'.

The old patch 7 in v3 will be taken out to post alone, since it's a
clean up patch, not related to this subsection map handling.

Changelog
v3->v4:
  No big change, mainly address concerns from David.

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

Baoquan He (5):
  mm/sparse.c: introduce new function fill_subsection_map()
  mm/sparse.c: introduce a new function clear_subsection_map()
  mm/sparse.c: only use subsection map in VMEMMAP case
  mm/sparse.c: add note about only VMEMMAP supporting sub-section
    support
  mm/sparse.c: move subsection_map related functions together

 include/linux/mmzone.h |   2 +
 mm/sparse.c            | 136 ++++++++++++++++++++++++++++-------------
 2 files changed, 95 insertions(+), 43 deletions(-)

-- 
2.17.2

