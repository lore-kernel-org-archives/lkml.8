Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60559C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 00:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D820020674
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 00:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="koJmEwET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgFBApr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 20:45:47 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:19694 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgFBApq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 20:45:46 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200602004543epoutp03565631fc0d96d05a28d0af84a4ea54c3~Uk39KQZwM1490414904epoutp034
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 00:45:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200602004543epoutp03565631fc0d96d05a28d0af84a4ea54c3~Uk39KQZwM1490414904epoutp034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591058743;
        bh=4HUVoH0cyT2jau7dKcQMv1Qa8dJKRavUlNm64zWJ0Mk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=koJmEwETr/SJIAh/WRd4ogIzNQQX18DigiAXkFZjuEWVOcd2MwVjOkfEfmgXkC0nz
         uLb6HXg1b45YsbXiIPuI4/334zgEz3+EDqG8rF6/LzmwsBgfzOcr03jjOWE6tLecTG
         yTqw95TGylEzJRW9R2Opo/WV05p9YuaDQ+44O3q0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200602004543epcas1p251d96c46da6e1582a54c488e7b8d0c8b~Uk38657EN0392003920epcas1p24;
        Tue,  2 Jun 2020 00:45:43 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.159]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 49bYHV0Mk6zMqYkj; Tue,  2 Jun
        2020 00:45:42 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        4A.AA.18978.531A5DE5; Tue,  2 Jun 2020 09:45:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200602004541epcas1p194094c41da203e14a32a73358d58700d~Uk37oTIK32528025280epcas1p1G;
        Tue,  2 Jun 2020 00:45:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200602004541epsmtrp2e63bb05d7a3647e3bbdd4334cf21330e~Uk37jH4cl0106601066epsmtrp2Z;
        Tue,  2 Jun 2020 00:45:41 +0000 (GMT)
X-AuditID: b6c32a35-603ff70000004a22-c7-5ed5a1355128
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.07.08303.531A5DE5; Tue,  2 Jun 2020 09:45:41 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200602004541epsmtip298364a8e96d0c7d337eda9d69531a8bd~Uk37SySvv2025820258epsmtip2L;
        Tue,  2 Jun 2020 00:45:41 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH] exfat: remove unnecessary reassignment of
 p_uniname->name_len
Date:   Tue,  2 Jun 2020 09:40:53 +0900
Message-Id: <20200602004053.17304-1-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7bCmvq7pwqtxBrfvW1ns2XuSxeLyrjls
        Fj+m11ts+XeE1YHFo2/LKkaPz5vkApiicmwyUhNTUosUUvOS81My89JtlbyD453jTc0MDHUN
        LS3MlRTyEnNTbZVcfAJ03TJzgPYoKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgoM
        DQr0ihNzi0vz0vWS83OtDA0MjEyBKhNyMvbtfMNUsJSt4tGk84wNjF2sXYycHBICJhILb65m
        7GLk4hAS2MEo0fz4DCuE84lR4uyp9YwgVUICnxkl/u/Mgel42LyHGaJoF6PEk7e72OA6Dh7s
        Y+pi5OBgE9CW+LNFFMQUEVCUuPzeCaSXWSBR4u+3ViYQW1ggQKJ77z82kBIWAVWJlrmZIGFe
        ARuJWz2vWCBWyUus3nAAbJWEwG82iSvtr6CudpHYNu8QE4QtLPHq+BZ2CFtK4vO7vWAzJQSq
        JT7uZ4YIdzBKvPhuC2EbS9xcv4EVpIRZQFNi/S59iLCixM7fcxkhruSTePe1hxViCq9ER5sQ
        RImqRN+lw1BLpSW62j9ALfWQWHKinQUSULESSw6/Y5nAKDsLYcECRsZVjGKpBcW56anFhgWG
        yBG0iRGcbrRMdzBOfPtB7xAjEwfjIUYJDmYlEd7J6pfihHhTEiurUovy44tKc1KLDzGaAkNr
        IrOUaHI+MOHllcQbmhoZGxtbmJiZm5kaK4nzistciBMSSE8sSc1OTS1ILYLpY+LglGpgypG6
        1SbwRS6jft6El9/KIq98sBRn/yzxU2X3gpISJi6Ty6sTFj53VRQVKOItFdXlMX1+I/Kmba+9
        baLm29KV9w5LHs8QKvu7/KvUDtuH/+rsQoNajEWFlr755nugXG7ZupIfrsqyp6c8PTMp+/Iu
        Q93azz/lN7sJarmnxzvuFPffeTFvvfuqNosjF7m23nAufuBgJRke2pJ7SOjT0heK07nqZp+t
        KGefcHZD8OavLbu/7fg6e+smgx8PtjaVp89VWsley7pjh95ZBtMdreoaIaH5kwS0az43hLm/
        rdsed2j/z5Ryqz2P3BIbX106Mi+1fer8s5arXL/dTzeZOnHNlIwr0jtn7npw/h3LrUkyC5RY
        ijMSDbWYi4oTAc9eQkzAAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDJMWRmVeSWpSXmKPExsWy7bCSvK7pwqtxBsdeSFrs2XuSxeLyrjls
        Fj+m11ts+XeE1YHFo2/LKkaPz5vkApiiuGxSUnMyy1KL9O0SuDL27XzDVLCUreLRpPOMDYxd
        rF2MnBwSAiYSD5v3MHcxcnEICexglFhz7C5UQlri2IkzQAkOIFtY4vDhYoiaD4wSH/YsZwWJ
        swloS/zZIgpiiggoSlx+7wTSySyQLPHv7QUWEFtYwE/i7MQrYFNYBFQlWuZmgoR5BWwkbvW8
        YoFYJC+xesMB5gmMPAsYGVYxSqYWFOem5xYbFhjlpZbrFSfmFpfmpesl5+duYgQHgJbWDsY9
        qz7oHWJk4mA8xCjBwawkwjtZ/VKcEG9KYmVValF+fFFpTmrxIUZpDhYlcd6vsxbGCQmkJ5ak
        ZqemFqQWwWSZODilGpgkT6tGFh+VadunZL9t0nr1UAPf9EXPf4j9e9LU90ZOcDlXaGTVs+5z
        k+YuMXLwu7rB4mZQrMCa9zaf3zctOyBeuie7+IapHsufco+UyY4frD9MiBXS2hByrTDePfa9
        ObfoEl7RO38cgq/PjvlZL15R473IoEvfw8Cs3eFbwmnBaZlsbff/WcS8r1d19fDODow4e3w5
        n1gQt/tP94LJSxq/zP/pIlW9JvzA1d/+JuHvtiyfOdvvkM+X94ZfF4imS36cpf6T8fk688j0
        c5d3B7Dqp+S2eBUH+7A5Vu9JF9DQOMB1fusZ0/fp/imflzOX9NkdT3DoNjOV/tU5c+3h0+J+
        9i4N8hryL2UcOPOalViKMxINtZiLihMBlkQmgG8CAAA=
X-CMS-MailID: 20200602004541epcas1p194094c41da203e14a32a73358d58700d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200602004541epcas1p194094c41da203e14a32a73358d58700d
References: <CGME20200602004541epcas1p194094c41da203e14a32a73358d58700d@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild test robot reported :

	fs/exfat/nls.c:531:22: warning: Variable 'p_uniname->name_len'
	is reassigned a value before the old one has been used.

The reassignment of p_uniname->name_len is not needed and remove it.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
---
 fs/exfat/nls.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index 19321773dd07..c1ec05695497 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -514,8 +514,6 @@ static int exfat_utf8_to_utf16(struct super_block *sb,
 		return -ENAMETOOLONG;
 	}
 
-	p_uniname->name_len = unilen & 0xFF;
-
 	for (i = 0; i < unilen; i++) {
 		if (*uniname < 0x0020 ||
 		    exfat_wstrchr(bad_uni_chars, *uniname))
-- 
2.17.1

