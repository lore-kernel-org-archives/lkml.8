Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E020DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 04:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF70E20885
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 04:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="AgGFJjlN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgEVEPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 00:15:12 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3764 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgEVEPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 00:15:10 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec751c10001>; Thu, 21 May 2020 21:14:57 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 21 May 2020 21:15:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 21 May 2020 21:15:09 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 May
 2020 04:15:09 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 22 May 2020 04:15:09 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.48.182]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ec751cc0002>; Thu, 21 May 2020 21:15:08 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     John Hubbard <jhubbard@nvidia.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Jani Nikula <jani.nikula@intel.com>,
        <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>
Subject: [PATCH 2/2] video: fbdev: convert get_user_pages() --> pin_user_pages()
Date:   Thu, 21 May 2020 21:15:06 -0700
Message-ID: <20200522041506.39638-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522041506.39638-1-jhubbard@nvidia.com>
References: <20200522041506.39638-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590120897; bh=ouw78Ze34s++yvNZQkTG1iTTFB5/htkcycvRireHQNE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=AgGFJjlNoGWVVjm8kijEcZNDXRlAEGwnJ4pgoR9yHJTI8Eu5TfiCKnOyH4M4UiFl2
         rwAdWweoH98+1/VP6biU6pwSKe/QvY4tkRUMyyudd0YHhJRVB/e08Sx82h5jjuqfI8
         +CTMa40jjdBVGbMAVJfcwD1r0Leb47iMx6RUkw/3wa9lf6D8NAt/YxvCHv4G1MQV55
         AeuIPAk/Hc7ZOz6rS207GQ3hqv6NwYhL3VaPMFBDnTEYAjAcdBVTO2+pyA0TNlIP8Z
         YYn5USowgtaIC7x47L/2U602+QixoydX6hpANgsLVznr7YZBUZGvhPNG3cd1Ym3fXr
         jVTGx8EnBI9QA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code was using get_user_pages*(), in a "Case 2" scenario
(DMA/RDMA), using the categorization from [1]. That means that it's
time to convert the get_user_pages*() + put_page() calls to
pin_user_pages*() + unpin_user_pages() calls.

There is some helpful background in [2]: basically, this is a small
part of fixing a long-standing disconnect between pinning pages, and
file systems' use of those pages.

[1] Documentation/core-api/pin_user_pages.rst

[2] "Explicit pinning of user-space pages":
    https://lwn.net/Articles/807108/

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/video/fbdev/pvr2fb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
index ceb6ef590597..2d9f69b93392 100644
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -652,7 +652,7 @@ static ssize_t pvr2fb_write(struct fb_info *info, const=
 char *buf,
 	if (!pages)
 		return -ENOMEM;
=20
-	ret =3D get_user_pages_fast((unsigned long)buf, nr_pages, FOLL_WRITE, pag=
es);
+	ret =3D pin_user_pages_fast((unsigned long)buf, nr_pages, FOLL_WRITE, pag=
es);
 	if (ret < nr_pages) {
 		if (ret < 0) {
 			/*
@@ -712,9 +712,7 @@ static ssize_t pvr2fb_write(struct fb_info *info, const=
 char *buf,
 	ret =3D count;
=20
 out_unmap:
-	for (i =3D 0; i < nr_pages; i++)
-		put_page(pages[i]);
-
+	unpin_user_pages(pages, nr_pages);
 	kfree(pages);
=20
 	return ret;
--=20
2.26.2

