Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBBCC54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71C36206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbgELPVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:21:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15282 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725888AbgELPVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:21:42 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04CFDmCO096018;
        Tue, 12 May 2020 11:21:41 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30wsa0ppf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 May 2020 11:21:41 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04CFG51h120644;
        Tue, 12 May 2020 11:21:40 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30wsa0ppeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 May 2020 11:21:40 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04CFAaS8030340;
        Tue, 12 May 2020 15:21:39 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 30wm56aqpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 May 2020 15:21:38 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04CFLa5o17760636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 May 2020 15:21:36 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B80F5AE051;
        Tue, 12 May 2020 15:21:36 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68775AE045;
        Tue, 12 May 2020 15:21:36 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.55.157])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 May 2020 15:21:36 +0000 (GMT)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] lib: fix bitmap_parse() on 64-bit big endian archs
Date:   Tue, 12 May 2020 17:21:30 +0200
Message-Id: <1589296890-13064-1-git-send-email-agordeev@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-12_04:2020-05-11,2020-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 bulkscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 adultscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2d626158 ("lib: rework bitmap_parse()") does
not take into account order of halfwords on 64-bit
big endian architectures.

Cc: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 lib/bitmap.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 89260aa..a725e46 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -717,6 +717,19 @@ static const char *bitmap_get_x32_reverse(const char *start,
 	return end;
 }
 
+#if defined(__BIG_ENDIAN) && defined(CONFIG_64BIT)
+static void save_x32_chunk(unsigned long *maskp, u32 chunk, int chunk_idx)
+{
+	maskp += (chunk_idx / 2);
+	((u32 *)maskp)[(chunk_idx & 1) ^ 1] = chunk;
+}
+#else
+static void save_x32_chunk(unsigned long *maskp, u32 chunk, int chunk_idx)
+{
+	((u32 *)maskp)[chunk_idx] = chunk;
+}
+#endif
+
 /**
  * bitmap_parse - convert an ASCII hex string into a bitmap.
  * @start: pointer to buffer containing string.
@@ -738,7 +751,8 @@ int bitmap_parse(const char *start, unsigned int buflen,
 {
 	const char *end = strnchrnul(start, buflen, '\n') - 1;
 	int chunks = BITS_TO_U32(nmaskbits);
-	u32 *bitmap = (u32 *)maskp;
+	int chunk_idx = 0;
+	u32 chunk;
 	int unset_bit;
 
 	while (1) {
@@ -749,9 +763,11 @@ int bitmap_parse(const char *start, unsigned int buflen,
 		if (!chunks--)
 			return -EOVERFLOW;
 
-		end = bitmap_get_x32_reverse(start, end, bitmap++);
+		end = bitmap_get_x32_reverse(start, end, &chunk);
 		if (IS_ERR(end))
 			return PTR_ERR(end);
+
+		save_x32_chunk(maskp, chunk, chunk_idx++);
 	}
 
 	unset_bit = (BITS_TO_U32(nmaskbits) - chunks) * 32;
-- 
1.8.3.1

