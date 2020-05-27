Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A4CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C5E220707
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="h3hLoOZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgE0Wcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 18:32:48 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4815 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgE0Wcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:32:46 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eceea820001>; Wed, 27 May 2020 15:32:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 27 May 2020 15:32:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 27 May 2020 15:32:46 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 May
 2020 22:32:46 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 May 2020 22:32:45 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.87.74]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5eceea8d0004>; Wed, 27 May 2020 15:32:45 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/2] mm/gup: introduce pin_user_pages_locked()
Date:   Wed, 27 May 2020 15:32:42 -0700
Message-ID: <20200527223243.884385-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527223243.884385-1-jhubbard@nvidia.com>
References: <20200527223243.884385-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590618754; bh=IycP13r0Bgehgro+i/kfeYy/gdTMPNNoxOMONjYdmKE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=h3hLoOZxMnWJnisFnZpNwUOKl3cIRfZkUKEo2EH5nn5TVuwgH/Sy9X6W048B9fWuN
         TkjuhLSVPp/Ldd+oGSUph85GF/1ErZRBXCQ/8O0NJiayOKD3fe3ox+3hF3PALbLPx2
         0HVWUlgM8m/4dlJ58ynDuhIGwEFUZywz8EFtwGxwBS5KGC1iikyZaU/weATU8wjHKO
         qN8Uk8+jli6K/b+6N8ZYlmdOx8dxpohKKuzvTGwvksl+x2NMTk4JEx8G8Q06XdWkFY
         jzKCcrUSFZWnategb3taYH2Iu3iCvdIXWvobdoPKM4a0lUMl+E0uJthGpSH0divnrx
         e6gHD8gOfJ3hA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce pin_user_pages_locked(), which is nearly identical to
get_user_pages_locked() except that it sets FOLL_PIN and rejects
FOLL_GET.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/mm.h |  2 ++
 mm/gup.c           | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 98be7289d7e9..d16951087c93 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1700,6 +1700,8 @@ long pin_user_pages(unsigned long start, unsigned lon=
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
index 2f0a0b497c23..17418a949067 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2992,3 +2992,33 @@ long pin_user_pages_unlocked(unsigned long start, un=
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

