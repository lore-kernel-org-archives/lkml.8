Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8230C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 23:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4BA20707
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 23:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HaeyOZ/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgEaXle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 19:41:34 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18538 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgEaXld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 19:41:33 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed4404e0000>; Sun, 31 May 2020 16:39:58 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 31 May 2020 16:41:32 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 31 May 2020 16:41:32 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 31 May
 2020 23:41:32 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 31 May 2020 23:41:32 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.56.10]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ed440ac0001>; Sun, 31 May 2020 16:41:32 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 1/2] mm/gup: introduce pin_user_pages_locked()
Date:   Sun, 31 May 2020 16:41:30 -0700
Message-ID: <20200531234131.770697-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200531234131.770697-1-jhubbard@nvidia.com>
References: <20200531234131.770697-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590968398; bh=2AD2R/rEqmnIC58l5VDGc8gxM823CQWpdFJrhm1ZY6Y=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=HaeyOZ/7MZgVcgpbYq5xF2ilUkBU9mgEj9XuPozHccwEGdwGFPyCfb5qsfxLy/AzP
         OhWAhCjpZ6gTnmm9o8Sa0D9T3AjpvpmRDz0FyWb+5rg0+bj+onrVDum7toGEhYqC6Y
         899Ja/O9OlK/WGAwor8Otp9MeAVt088/zVcwYh3BqESXz7tHyKFC7MOLCeGt47jOBw
         rcP4NxnUtf59+oMolTEKJ2K9YkhpsprP0hFu9Qx3ZJB3jkW0mOSgxS92j5U6B542/t
         ny41pSsmr7L0B+LUTxC0bdLCDLFzFusjszDeRJdq3X1F2iASM48b0Z6jhwI7JraBf4
         8B0EQF8h5ifJA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce pin_user_pages_locked(), which is nearly identical to
get_user_pages_locked() except that it sets FOLL_PIN and rejects
FOLL_GET.

As with other pairs of get_user_pages*() and pin_user_pages() API calls,
it's prudent to assert that FOLL_PIN is *not* set in the
get_user_pages*() call, so add that as part of this.

Cc: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h |  2 ++
 mm/gup.c           | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b098939691ba..5e29ddcbb5fc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1711,6 +1711,8 @@ long pin_user_pages(unsigned long start, unsigned lon=
g nr_pages,
 		    struct vm_area_struct **vmas);
 long get_user_pages_locked(unsigned long start, unsigned long nr_pages,
 		    unsigned int gup_flags, struct page **pages, int *locked);
+long pin_user_pages_locked(unsigned long start, unsigned long nr_pages,
+		    unsigned int gup_flags, struct page **pages, int *locked);
 long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 		    struct page **pages, unsigned int gup_flags);
 long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
diff --git a/mm/gup.c b/mm/gup.c
index 82ef0db1590a..06b891297a5c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1993,6 +1993,12 @@ long get_user_pages_locked(unsigned long start, unsi=
gned long nr_pages,
 	 */
 	if (WARN_ON_ONCE(gup_flags & FOLL_LONGTERM))
 		return -EINVAL;
+	/*
+	 * FOLL_PIN must only be set internally by the pin_user_pages*() APIs,
+	 * never directly by the caller, so enforce that:
+	 */
+	if (WARN_ON_ONCE(gup_flags & FOLL_PIN))
+		return -EINVAL;
=20
 	return __get_user_pages_locked(current, current->mm, start, nr_pages,
 				       pages, NULL, locked,
@@ -2998,3 +3004,33 @@ long pin_user_pages_unlocked(unsigned long start, un=
signed long nr_pages,
 	return get_user_pages_unlocked(start, nr_pages, pages, gup_flags);
 }
 EXPORT_SYMBOL(pin_user_pages_unlocked);
+
+/*
+ * pin_user_pages_locked() is the FOLL_PIN variant of get_user_pages_locke=
d().
+ * Behavior is the same, except that this one sets FOLL_PIN and rejects
+ * FOLL_GET.
+ */
+long pin_user_pages_locked(unsigned long start, unsigned long nr_pages,
+			   unsigned int gup_flags, struct page **pages,
+			   int *locked)
+{
+	/*
+	 * FIXME: Current FOLL_LONGTERM behavior is incompatible with
+	 * FAULT_FLAG_ALLOW_RETRY because of the FS DAX check requirement on
+	 * vmas.  As there are no users of this flag in this call we simply
+	 * disallow this option for now.
+	 */
+	if (WARN_ON_ONCE(gup_flags & FOLL_LONGTERM))
+		return -EINVAL;
+
+	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
+	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
+		return -EINVAL;
+
+	gup_flags |=3D FOLL_PIN;
+	return __get_user_pages_locked(current, current->mm, start, nr_pages,
+				       pages, NULL, locked,
+				       gup_flags | FOLL_TOUCH);
+}
+EXPORT_SYMBOL(pin_user_pages_locked);
+
--=20
2.26.2

