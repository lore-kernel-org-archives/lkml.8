Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D79FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 04:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A9E7207BB
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 04:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lm2sye2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgERENJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 00:13:09 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5079 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgERENJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 00:13:09 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec20ac70001>; Sun, 17 May 2020 21:10:47 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 17 May 2020 21:13:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 17 May 2020 21:13:08 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 May
 2020 04:13:08 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 18 May 2020 04:13:08 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.48.175]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ec20b540001>; Sun, 17 May 2020 21:13:08 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] drivers/mic/scif: convert get_user_pages() --> pin_user_pages()
Date:   Sun, 17 May 2020 21:13:07 -0700
Message-ID: <20200518041307.1987328-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589775048; bh=cuwLKOTJKSE6e49q/J5ZEuun7K4FWrcNFCi0NALDsCU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=lm2sye2uxDAzQsDuz72nrdclnyI+3mSXl54DWnuRzTk+mC20/nJG9pn0GZ45CY3Mn
         dvPj8WeT0ELbY0UEwItFvN4jcTRLHFhLV4dHfZfqEsp6uWUgOGFYqu0DntiBv5TCQG
         PUl0MbKAszDT/61TaTs2LM9sG3zpq+N+Dr73UK5uK8y6eOjsZc6pSt/TkFuI0f2Mhi
         9Fi0DcmWd8Wwz9D54HyhQ3MIi6axa5MfHzSUiOFFcRF8nf5qweS+mtyjc0YyFP9Lpi
         1982EhchbiVi7IjdMF9G7EfYjUc922cdxk162kvHRe4rb2GCna6azhPexEMrx5kE74
         ovuORk6R7yPgg==
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

Note that this effectively changes the code's behavior as well: it now
ultimately calls set_page_dirty_lock(), instead of SetPageDirty(). This
is probably more accurate.

As Christoph Hellwig put it, "set_page_dirty() is only safe if we are
dealing with a file backed page where we have reference on the inode it
hangs off." [3]

[1] Documentation/core-api/pin_user_pages.rst

[2] "Explicit pinning of user-space pages":
    https://lwn.net/Articles/807108/

[3] https://lore.kernel.org/r/20190723153640.GB720@lst.de

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---

Hi,

Note that I have only compile-tested this patch, although that does
also include cross-compiling for a few other arches.

thanks,
John Hubbard
NVIDIA

 drivers/misc/mic/scif/scif_rma.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/mic/scif/scif_rma.c b/drivers/misc/mic/scif/scif_=
rma.c
index 01e27682ea30..406cd5abfa72 100644
--- a/drivers/misc/mic/scif/scif_rma.c
+++ b/drivers/misc/mic/scif/scif_rma.c
@@ -113,14 +113,17 @@ static int scif_destroy_pinned_pages(struct scif_pinn=
ed_pages *pin)
 	int writeable =3D pin->prot & SCIF_PROT_WRITE;
 	int kernel =3D SCIF_MAP_KERNEL & pin->map_flags;
=20
-	for (j =3D 0; j < pin->nr_pages; j++) {
-		if (pin->pages[j] && !kernel) {
-			if (writeable)
-				SetPageDirty(pin->pages[j]);
-			put_page(pin->pages[j]);
+	if (kernel) {
+		for (j =3D 0; j < pin->nr_pages; j++) {
+			if (pin->pages[j] && !kernel) {
+				if (writeable)
+					set_page_dirty_lock(pin->pages[j]);
+				put_page(pin->pages[j]);
+			}
 		}
-	}
-
+	} else
+		unpin_user_pages_dirty_lock(pin->pages, pin->nr_pages,
+					    writeable);
 	scif_free(pin->pages,
 		  pin->nr_pages * sizeof(*pin->pages));
 	scif_free(pin, sizeof(*pin));
@@ -1375,7 +1378,7 @@ int __scif_pin_pages(void *addr, size_t len, int *out=
_prot,
 			}
 		}
=20
-		pinned_pages->nr_pages =3D get_user_pages_fast(
+		pinned_pages->nr_pages =3D pin_user_pages_fast(
 				(u64)addr,
 				nr_pages,
 				(prot & SCIF_PROT_WRITE) ? FOLL_WRITE : 0,
@@ -1385,11 +1388,8 @@ int __scif_pin_pages(void *addr, size_t len, int *ou=
t_prot,
 				if (ulimit)
 					__scif_dec_pinned_vm_lock(mm, nr_pages);
 				/* Roll back any pinned pages */
-				for (i =3D 0; i < pinned_pages->nr_pages; i++) {
-					if (pinned_pages->pages[i])
-						put_page(
-						pinned_pages->pages[i]);
-				}
+				unpin_user_pages(pinned_pages->pages,
+						 pinned_pages->nr_pages);
 				prot &=3D ~SCIF_PROT_WRITE;
 				try_upgrade =3D false;
 				goto retry;
--=20
2.26.2

