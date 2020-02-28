Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB19DC3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CD6246B2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WsigKk2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgB1J6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:58:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24171 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726876AbgB1J6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:58:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582883918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MImPD953juWGuFRtgrCEw44TOzCFVl7e+kQZqiJ0GM0=;
        b=WsigKk2OEBEw71GUPbdgoh2EWpKjo9KZ7DyoX+Z0SJtbLosF0KCtbXqpYJ6Pb5H8lct7z1
        7P2hblsqAQPdyGKzc6qIEr62XgHW0ADfwECjcqamu436eXB6SPgdb04BzpT4ZWF0zL1ZU2
        qip1AZsmF9sVxo3rKvUT1o2OH25LiXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-tU4EyxljPC2yEGC8nuXyFQ-1; Fri, 28 Feb 2020 04:58:36 -0500
X-MC-Unique: tU4EyxljPC2yEGC8nuXyFQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 423C613E4;
        Fri, 28 Feb 2020 09:58:35 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-180.ams2.redhat.com [10.36.117.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A65E6E3EE;
        Fri, 28 Feb 2020 09:58:33 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>, Baoquan He <bhe@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH v2 2/2] mm/memory_hotplug: cleanup __add_pages()
Date:   Fri, 28 Feb 2020 10:58:19 +0100
Message-Id: <20200228095819.10750-3-david@redhat.com>
In-Reply-To: <20200228095819.10750-1-david@redhat.com>
References: <20200228095819.10750-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's drop the basically unused section stuff and simplify. The logic
now matches the logic in __remove_pages().

Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 8fe7e32dad48..1a00b5a37ef6 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -307,8 +307,9 @@ static int check_hotplug_memory_addressable(unsigned =
long pfn,
 int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages=
,
 		struct mhp_restrictions *restrictions)
 {
+	const unsigned long end_pfn =3D pfn + nr_pages;
+	unsigned long cur_nr_pages;
 	int err;
-	unsigned long nr, start_sec, end_sec;
 	struct vmem_altmap *altmap =3D restrictions->altmap;
=20
 	err =3D check_hotplug_memory_addressable(pfn, nr_pages);
@@ -331,18 +332,13 @@ int __ref __add_pages(int nid, unsigned long pfn, u=
nsigned long nr_pages,
 	if (err)
 		return err;
=20
-	start_sec =3D pfn_to_section_nr(pfn);
-	end_sec =3D pfn_to_section_nr(pfn + nr_pages - 1);
-	for (nr =3D start_sec; nr <=3D end_sec; nr++) {
-		unsigned long pfns;
-
-		pfns =3D min(nr_pages, PAGES_PER_SECTION
-				- (pfn & ~PAGE_SECTION_MASK));
-		err =3D sparse_add_section(nid, pfn, pfns, altmap);
+	for (; pfn < end_pfn; pfn +=3D cur_nr_pages) {
+		/* Select all remaining pages up to the next section boundary */
+		cur_nr_pages =3D min(end_pfn - pfn,
+				   SECTION_ALIGN_UP(pfn + 1) - pfn);
+		err =3D sparse_add_section(nid, pfn, cur_nr_pages, altmap);
 		if (err)
 			break;
-		pfn +=3D pfns;
-		nr_pages -=3D pfns;
 		cond_resched();
 	}
 	vmemmap_populate_print_last();
--=20
2.24.1

