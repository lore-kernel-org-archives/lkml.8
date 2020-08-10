Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F47C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 06:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B785206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 06:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZjeZWdnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgHJGZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 02:25:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36808 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725808AbgHJGZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 02:25:06 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07A61HpI046835;
        Mon, 10 Aug 2020 02:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=dKbb8WnE5Gsi5uk81jwD6lHeZhZ/D0JfR/38oaFPPWw=;
 b=ZjeZWdnbS69rdPK3ldGtDxHbmIz0HAloSJAMFegV4oGVeCHjIjhe8zVtHQ0JA4kRlM3F
 s7N+bglzm3Tlm+xgqu7FBQEUAPQQueCIz5BELzDtvxzftK57nNVlS7iOeKy+jYAvLlsr
 rK7oUOgJixews1YkIElFc6wD+gD9raQzvHRvDKd4nCccryTNuH/IoRjCq9Ebu8ai2eCD
 g4k+Zoq5lJ8JVWzjOW0kddfUkLEvA1jRC0CcrpS83HUKIcvW8Y8CR6KJWqaUCX42Cg5/
 c5YlAtzgGuSCu8o4V3mNGV4ceYIPeDWQY/X7O9Z8QOZe2fgse+dS3CgakLIOetV7HSLk NQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32src0hhgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 02:25:03 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07A6Khhp000539;
        Mon, 10 Aug 2020 06:25:01 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 32skp89wxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 06:25:01 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07A6OxIf32440742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Aug 2020 06:24:59 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89398A4054;
        Mon, 10 Aug 2020 06:24:59 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E528A4062;
        Mon, 10 Aug 2020 06:24:59 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.20.209])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 10 Aug 2020 06:24:59 +0000 (GMT)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] docs/vm: fix 'mm_count' vs 'mm_users' counter confusion
Date:   Mon, 10 Aug 2020 08:24:55 +0200
Message-Id: <1597040695-32633-1-git-send-email-agordeev@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-10_02:2020-08-06,2020-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 impostorscore=0
 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 suspectscore=1 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008100039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the context of the anonymous address space lifespan
description the 'mm_users' reference counter is confused
with 'mm_count'. I.e a "zombie" mm gets released when
"mm_count" becomes zero, not "mm_users".

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 Documentation/vm/active_mm.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/vm/active_mm.rst b/Documentation/vm/active_mm.rst
index c84471b..6f8269c 100644
--- a/Documentation/vm/active_mm.rst
+++ b/Documentation/vm/active_mm.rst
@@ -64,7 +64,7 @@ Active MM
  actually get cases where you have a address space that is _only_ used by
  lazy users. That is often a short-lived state, because once that thread
  gets scheduled away in favour of a real thread, the "zombie" mm gets
- released because "mm_users" becomes zero.
+ released because "mm_count" becomes zero.
 
  Also, a new rule is that _nobody_ ever has "init_mm" as a real MM any
  more. "init_mm" should be considered just a "lazy context when no other
-- 
1.8.3.1

