Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09657C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB78207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGFGR/d2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbgAMOkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 09:40:51 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45853 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728643AbgAMOkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 09:40:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578926449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nkiqYNaUf9QZxMjcOapYuuaCZwyteQKyk2Vp/EqR3qw=;
        b=UGFGR/d2A4vTugUUoboksK6rA9cSFx26whDahKZSKfmoEuCAd6cxXbp6RSMFnNBj/bNFrr
        udeO4QwLzqHK/KobgXmwOdCFxqHhM5bMNnzVHIII81WS4BSv4JbSKjlG9D93OiOut0WgkQ
        tW+AGO+AgdieqTL9gJzpTI3ZaAQ/e5I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-L5vepq2aMjiP8_ggSb84Lw-1; Mon, 13 Jan 2020 09:40:46 -0500
X-MC-Unique: L5vepq2aMjiP8_ggSb84Lw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D81C1005516;
        Mon, 13 Jan 2020 14:40:44 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-201.ams2.redhat.com [10.36.117.201])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 129AB19756;
        Mon, 13 Jan 2020 14:40:42 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v1 2/2] mm: factor out next_present_section_nr()
Date:   Mon, 13 Jan 2020 15:40:35 +0100
Message-Id: <20200113144035.10848-3-david@redhat.com>
In-Reply-To: <20200113144035.10848-1-david@redhat.com>
References: <20200113144035.10848-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's move it to the header and use the shorter variant from
mm/page_alloc.c (the original one will also check
"__highest_present_section_nr + 1", which is not necessary). While at it,
make the section_nr in next_pfn() const.

In next_pfn(), we now return section_nr_to_pfn(-1) instead of -1 once
we exceed __highest_present_section_nr, which doesn't make a difference i=
n
the caller as it is big enough (>=3D all sane end_pfn).

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mmzone.h | 10 ++++++++++
 mm/page_alloc.c        | 11 ++---------
 mm/sparse.c            | 10 ----------
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index c2bc309d1634..462f6873905a 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1379,6 +1379,16 @@ static inline int pfn_present(unsigned long pfn)
 	return present_section(__nr_to_section(pfn_to_section_nr(pfn)));
 }
=20
+static inline unsigned long next_present_section_nr(unsigned long sectio=
n_nr)
+{
+	while (++section_nr <=3D __highest_present_section_nr) {
+		if (present_section_nr(section_nr))
+			return section_nr;
+	}
+
+	return -1;
+}
+
 /*
  * These are _only_ used during initialisation, therefore they
  * can use __initdata ...  They could have names to indicate
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a92791512077..26e8044e9848 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5852,18 +5852,11 @@ overlap_memmap_init(unsigned long zone, unsigned =
long *pfn)
 /* Skip PFNs that belong to non-present sections */
 static inline __meminit unsigned long next_pfn(unsigned long pfn)
 {
-	unsigned long section_nr;
+	const unsigned long section_nr =3D pfn_to_section_nr(++pfn);
=20
-	section_nr =3D pfn_to_section_nr(++pfn);
 	if (present_section_nr(section_nr))
 		return pfn;
-
-	while (++section_nr <=3D __highest_present_section_nr) {
-		if (present_section_nr(section_nr))
-			return section_nr_to_pfn(section_nr);
-	}
-
-	return -1;
+	return section_nr_to_pfn(next_present_section_nr(section_nr));
 }
 #else
 static inline __meminit unsigned long next_pfn(unsigned long pfn)
diff --git a/mm/sparse.c b/mm/sparse.c
index 3822ecbd8a1f..ac4a2bfae514 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -198,16 +198,6 @@ static void section_mark_present(struct mem_section =
*ms)
 	ms->section_mem_map |=3D SECTION_MARKED_PRESENT;
 }
=20
-static inline unsigned long next_present_section_nr(unsigned long sectio=
n_nr)
-{
-	do {
-		section_nr++;
-		if (present_section_nr(section_nr))
-			return section_nr;
-	} while ((section_nr <=3D __highest_present_section_nr));
-
-	return -1;
-}
 #define for_each_present_section_nr(start, section_nr)		\
 	for (section_nr =3D next_present_section_nr(start-1);	\
 	     ((section_nr !=3D -1) &&				\
--=20
2.24.1

