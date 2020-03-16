Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617DCC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C24E2051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731980AbgCPPtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:49:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1476 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731936AbgCPPtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:49:33 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02GFX7qp187981;
        Mon, 16 Mar 2020 11:49:32 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yrtwtwe4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Mar 2020 11:49:32 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02GFjMfp003245;
        Mon, 16 Mar 2020 15:49:30 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma05wdc.us.ibm.com with ESMTP id 2yrpw612b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Mar 2020 15:49:30 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02GFnSWV36569570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Mar 2020 15:49:28 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45FE178067;
        Mon, 16 Mar 2020 15:49:28 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F291778064;
        Mon, 16 Mar 2020 15:49:27 +0000 (GMT)
Received: from habcap11p1.aus.stglabs.ibm.com (unknown [9.41.164.53])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 16 Mar 2020 15:49:27 +0000 (GMT)
From:   Adriana Kobylak <anoo@linux.ibm.com>
To:     mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, anoo@us.ibm.com
Subject: [PATCH] tools/bootconfig: Makefile: Create destination directory
Date:   Mon, 16 Mar 2020 10:49:26 -0500
Message-Id: <1584373766-3509-1-git-send-email-anoo@linux.ibm.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-16_06:2020-03-12,2020-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 phishscore=0 suspectscore=1
 priorityscore=1501 mlxlogscore=855 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003160074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adriana Kobylak <anoo@us.ibm.com>

The DESTDIR path may not be available to the caller, such as
compiling the bootconfig tool from a Yocto native recipe. Have
the Makefile create the directory instead.

Signed-off-by: Adriana Kobylak <anoo@us.ibm.com>
---
 tools/bootconfig/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bootconfig/Makefile b/tools/bootconfig/Makefile
index a6146ac..470b6f0 100644
--- a/tools/bootconfig/Makefile
+++ b/tools/bootconfig/Makefile
@@ -14,6 +14,7 @@ bootconfig: ../../lib/bootconfig.c main.c $(HEADER)
 	$(CC) $(filter %.c,$^) $(CFLAGS) -o $@
 
 install: $(PROGS)
+	install -d $(DESTDIR)$(bindir)
 	install bootconfig $(DESTDIR)$(bindir)
 
 test: bootconfig
-- 
1.8.3.1

