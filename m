Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566CCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E8E3206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592896205;
	bh=Vxe+g7VgAeLGDBDFeBZcV8njBkhKVMWKBJcJPQvJF9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GAfEo08Cwn9ijBQBZ+o5kpMFTIqmwswCsbyzdda+zeQ1PdgPojnSi0lsZVaUW1fug
	 +0cINthakX3m2Wll606c+Rr3dmkOvSxCR+kJ9Hktbu2Ppy8fgh0lRSgIJWlycfpB6e
	 l0hImPEz3hCnNb8VAYsEOyVfHmaZLRukAcjScbCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbgFWHKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:10:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731285AbgFWHJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:09:16 -0400
Received: from mail.kernel.org (unknown [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D67A207DD;
        Tue, 23 Jun 2020 07:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592896155;
        bh=Vxe+g7VgAeLGDBDFeBZcV8njBkhKVMWKBJcJPQvJF9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o79nSGE8F1Njks2uk02gSeNB2UdeGxiZr8BqT4WssTEO9XbNQnwWCuwd1AtTIbhVD
         NUvllqprMceqEtmwjNLgExUiNVC4fxZiJ+A8aTEbnSPmE4nP2zGNX1k0H5ZRvX7ol0
         cWwB6q+MtjrrlA54Vt7D2QCeDcbrTP6AYt7q3Ga4=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jnd3R-003qjL-9a; Tue, 23 Jun 2020 09:09:13 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org
Subject: [PATCH v2 10/15] docs: hugetlbpage.rst: fix some warnings
Date:   Tue, 23 Jun 2020 09:09:06 +0200
Message-Id: <86b6796b1a84e18b24314ecd29318951c1479ca2.1592895969.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592895969.git.mchehab+huawei@kernel.org>
References: <cover.1592895969.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some new command line parameters were added at hugetlbpage.rst.
Adjust them in order to properly parse that part of the file,
avoiding those warnings:

    Documentation/admin-guide/mm/hugetlbpage.rst:105: WARNING: Unexpected indentation.
    Documentation/admin-guide/mm/hugetlbpage.rst:108: WARNING: Unexpected indentation.
    Documentation/admin-guide/mm/hugetlbpage.rst:109: WARNING: Block quote ends without a blank line; unexpected unindent.
    Documentation/admin-guide/mm/hugetlbpage.rst:112: WARNING: Block quote ends without a blank line; unexpected unindent.
    Documentation/admin-guide/mm/hugetlbpage.rst:120: WARNING: Unexpected indentation.
    Documentation/admin-guide/mm/hugetlbpage.rst:121: WARNING: Block quote ends without a blank line; unexpected unindent.
    Documentation/admin-guide/mm/hugetlbpage.rst:132: WARNING: Unexpected indentation.
    Documentation/admin-guide/mm/hugetlbpage.rst:135: WARNING: Block quote ends without a blank line; unexpected unindent.

Fixes: cd9fa28b5351 ("hugetlbfs: clean up command line processing")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/mm/hugetlbpage.rst | 23 +++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index 5026e58826e2..015a5f7d7854 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -101,37 +101,48 @@ be specified in bytes with optional scale suffix [kKmMgG].  The default huge
 page size may be selected with the "default_hugepagesz=<size>" boot parameter.
 
 Hugetlb boot command line parameter semantics
-hugepagesz - Specify a huge page size.  Used in conjunction with hugepages
+
+hugepagesz
+	Specify a huge page size.  Used in conjunction with hugepages
 	parameter to preallocate a number of huge pages of the specified
 	size.  Hence, hugepagesz and hugepages are typically specified in
-	pairs such as:
+	pairs such as::
+
 		hugepagesz=2M hugepages=512
+
 	hugepagesz can only be specified once on the command line for a
 	specific huge page size.  Valid huge page sizes are architecture
 	dependent.
-hugepages - Specify the number of huge pages to preallocate.  This typically
+hugepages
+	Specify the number of huge pages to preallocate.  This typically
 	follows a valid hugepagesz or default_hugepagesz parameter.  However,
 	if hugepages is the first or only hugetlb command line parameter it
 	implicitly specifies the number of huge pages of default size to
 	allocate.  If the number of huge pages of default size is implicitly
 	specified, it can not be overwritten by a hugepagesz,hugepages
 	parameter pair for the default size.
-	For example, on an architecture with 2M default huge page size:
+
+	For example, on an architecture with 2M default huge page size::
+
 		hugepages=256 hugepagesz=2M hugepages=512
+
 	will result in 256 2M huge pages being allocated and a warning message
 	indicating that the hugepages=512 parameter is ignored.  If a hugepages
 	parameter is preceded by an invalid hugepagesz parameter, it will
 	be ignored.
-default_hugepagesz - Specify the default huge page size.  This parameter can
+default_hugepagesz
+	pecify the default huge page size.  This parameter can
 	only be specified once on the command line.  default_hugepagesz can
 	optionally be followed by the hugepages parameter to preallocate a
 	specific number of huge pages of default size.  The number of default
 	sized huge pages to preallocate can also be implicitly specified as
 	mentioned in the hugepages section above.  Therefore, on an
-	architecture with 2M default huge page size:
+	architecture with 2M default huge page size::
+
 		hugepages=256
 		default_hugepagesz=2M hugepages=256
 		hugepages=256 default_hugepagesz=2M
+
 	will all result in 256 2M huge pages being allocated.  Valid default
 	huge page size is architecture dependent.
 
-- 
2.26.2

