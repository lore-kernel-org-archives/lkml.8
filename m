Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C780C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF9F0207D4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592203705;
	bh=1mCMCeSx1C7ExZesYEscLhEm/6vQrRpxVziGsEx4NTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yCI/H6WyKV1fTsKwxSQsgpMcr1+ItzJlyveF8GWfqT2y+CPzqvTh85TskkHSztvBB
	 sr98RUfrhzePMRFu3guYkIPw4FLAy27LDF0tadfoK7TIMLn1IgjpsqsXoH/ifukG+/
	 7+xPrYXHJq98GSo/8C2CBWoslwsY26LpVm1I2bdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgFOGsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:48:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728474AbgFOGrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:47:14 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 297E020A8B;
        Mon, 15 Jun 2020 06:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203632;
        bh=1mCMCeSx1C7ExZesYEscLhEm/6vQrRpxVziGsEx4NTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DLUTwUxk/Eo9A4PaLcGJ/JhdGyDZV2qcTIhNgYtRrHYzitjLpOiKp0kKfRv5ubaq7
         miDl+PQW4fLsYr49ptm7DOuibctDzEzO0ezyu+CT/2zjZvUGRaPrz3yN0sYKhe36jG
         GZvhJI0qYkyn62L0M/MuvMpP2A4KaJBrcd86zb+w=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkith-009nnA-Ut; Mon, 15 Jun 2020 08:47:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Will Deacon <will@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH 17/29] docs: hugetlbpage.rst: fix some warnings
Date:   Mon, 15 Jun 2020 08:46:56 +0200
Message-Id: <59f1aeae4839528046fd46408081fd70d53e15a6.1592203542.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592203542.git.mchehab+huawei@kernel.org>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
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
 Documentation/admin-guide/mm/hugetlbpage.rst | 25 ++++++++++++++------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index 5026e58826e2..729f810a58ac 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -100,38 +100,49 @@ with a huge page size selection parameter "hugepagesz=<size>".  <size> must
 be specified in bytes with optional scale suffix [kKmMgG].  The default huge
 page size may be selected with the "default_hugepagesz=<size>" boot parameter.
 
-Hugetlb boot command line parameter semantics
-hugepagesz - Specify a huge page size.  Used in conjunction with hugepages
+Hugetlb
+	boot command line parameter semantics
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

