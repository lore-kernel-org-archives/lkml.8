Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC59C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF81218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1HdVowG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgBENxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 08:53:04 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50415 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726308AbgBENxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 08:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580910783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kMQltNsA1uUOUOr4lm3GKwUv0TAsDgw6Dk2mWcNnf7A=;
        b=Y1HdVowGUjC6b3vviRrkgYXVzPyVN5/JxMdg48J4MMi5YYhxaiUEVOq0IU+CxYKw1ANjvi
        aNDFbps1s+l7ZUpeRv7VIb1TWMU27F38u74PQpriXjc2oX5NnTXHgre3Wqkgfns/eLywzj
        bc08n0ySg3WatHA8e/W4ASa4flTDw2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-N-9C93N-NWmPXdEIF_RnUg-1; Wed, 05 Feb 2020 08:52:59 -0500
X-MC-Unique: N-9C93N-NWmPXdEIF_RnUg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 840CA184AEA4;
        Wed,  5 Feb 2020 13:52:57 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-116-217.ams2.redhat.com [10.36.116.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D139187B15;
        Wed,  5 Feb 2020 13:52:52 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH v1] mm/memory_hotplug: Easier calculation to get pages to next section boundary
Date:   Wed,  5 Feb 2020 14:52:51 +0100
Message-Id: <20200205135251.37488-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's use a calculation that's easier to understand and calculates the
same result. Reusing existing macros makes this look nicer.

We always want to have the number of pages (> 0) to the next section
boundary, starting from the current pfn.

Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Baoquan He <bhe@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0a54ffac8c68..c30191183c04 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -528,7 +528,8 @@ void __remove_pages(unsigned long pfn, unsigned long =
nr_pages,
 	for (; pfn < end_pfn; pfn +=3D cur_nr_pages) {
 		cond_resched();
 		/* Select all remaining pages up to the next section boundary */
-		cur_nr_pages =3D min(end_pfn - pfn, -(pfn | PAGE_SECTION_MASK));
+		cur_nr_pages =3D min(end_pfn - pfn,
+				   SECTION_ALIGN_UP(pfn + 1) - pfn);
 		__remove_section(pfn, cur_nr_pages, map_offset, altmap);
 		map_offset =3D 0;
 	}
--=20
2.24.1

