Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C4EC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4E1246AA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNRAbSPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgB1J6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:58:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23215 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726413AbgB1J6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582883919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MNW9HVPqI0kTe9A0LBBiSsbv8ETEfJ83EjG1Wn7sou0=;
        b=iNRAbSPOKoFqjQ+a2eaF1sTRBljmdZcWWJxAspAcsBglM5THPde9GSg6xYSw5jAuI8QWGE
        vMtroG4plU4KIEIler/NN9gxBENdOXPopH4FfqkGrHg/PRS5hTxqo5TFuaF6VjZ60oIpma
        NbkBQZeIGoMpnPkenGEs6LBXi5+2UgI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-wBE7xIANOIGU3sQYTsMG0A-1; Fri, 28 Feb 2020 04:58:34 -0500
X-MC-Unique: wBE7xIANOIGU3sQYTsMG0A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFD30800D5B;
        Fri, 28 Feb 2020 09:58:32 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-180.ams2.redhat.com [10.36.117.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A40C76E3EE;
        Fri, 28 Feb 2020 09:58:30 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>, Baoquan He <bhe@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH v2 1/2] mm/memory_hotplug: simplify calculation of number of pages in __remove_pages()
Date:   Fri, 28 Feb 2020 10:58:18 +0100
Message-Id: <20200228095819.10750-2-david@redhat.com>
In-Reply-To: <20200228095819.10750-1-david@redhat.com>
References: <20200228095819.10750-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 52fb87c81f11 ("mm/memory_hotplug: cleanup __remove_pages()"),
we cleaned up __remove_pages(), and introduced a shorter variant to
calculate the number of pages to the next section boundary.

Turns out we can make this calculation easier to read. We always want to
have the number of pages (> 0) to the next section boundary, starting fro=
m
the current pfn.

We'll clean up __remove_pages() in a follow-up patch and directly make
use of this computation.

Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 4a9b3f6c6b37..8fe7e32dad48 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -534,7 +534,8 @@ void __remove_pages(unsigned long pfn, unsigned long =
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

