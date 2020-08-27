Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B93C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA17020786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BXsu5XUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgH0TEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:04:39 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8648 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgH0TEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 15:04:38 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4803b80000>; Thu, 27 Aug 2020 12:04:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 27 Aug 2020 12:04:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 27 Aug 2020 12:04:38 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Aug
 2020 19:04:38 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 27 Aug 2020 19:04:38 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4803c50002>; Thu, 27 Aug 2020 12:04:37 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH] mm/test: use the new SKIP() macro
Date:   Thu, 27 Aug 2020 12:04:00 -0700
Message-ID: <20200827190400.12608-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598555064; bh=tyYJnOGUbn8M6OcI0QlHbRb0snJ2xTK+ApnxWnOBsic=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=BXsu5XUnDKKwSIWiV7a1TSfU1RJg9JD8O3EDL454TgZagF6P372wGk3sSs9DulWlL
         O4/IUdhdWc4NJKjPLSOuMuxSEL7cDL512EPlJ9xPcXj+GVEd6EuPikPmcTETd+FC8l
         tFih1RKjUJ1INpzhIypW+kgrxEGCDJCs3tIdhTzJwjGgM1sGwqnR9nh9AQelkpASo8
         87oit53X5sRDp2cTnMEnNIrpq+km4wN3Bdx8cTKGOisu4IIzhZDhuSN4tCb+hKZFXu
         OoiPh6N5+HY2qv0G4MiTQW2r97Zj7jGUoy7CBbYGgdsfA17wE3iB767RVNqtNBNANf
         A24pWUqGLnUmA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some tests might not be able to be run if resources like huge pages are
not available. Mark these tests as skipped instead of simply passing.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---

This applies to linux-mm and is for Andrew Morton's tree.

 tools/testing/selftests/vm/hmm-tests.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/hmm-tests.c b/tools/testing/selftes=
ts/vm/hmm-tests.c
index 93fc5cadce61..0a28a6a29581 100644
--- a/tools/testing/selftests/vm/hmm-tests.c
+++ b/tools/testing/selftests/vm/hmm-tests.c
@@ -680,7 +680,7 @@ TEST_F(hmm, anon_write_hugetlbfs)
=20
 	n =3D gethugepagesizes(pagesizes, 4);
 	if (n <=3D 0)
-		return;
+		SKIP(return, "Huge page size could not be determined");
 	for (idx =3D 0; --n > 0; ) {
 		if (pagesizes[n] < pagesizes[idx])
 			idx =3D n;
@@ -694,7 +694,7 @@ TEST_F(hmm, anon_write_hugetlbfs)
 	buffer->ptr =3D get_hugepage_region(size, GHR_STRICT);
 	if (buffer->ptr =3D=3D NULL) {
 		free(buffer);
-		return;
+		SKIP(return, "Huge page could not be allocated");
 	}
=20
 	buffer->fd =3D -1;
--=20
2.20.1

