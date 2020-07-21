Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F96FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAAF720792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgGULvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:51:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59042 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726755AbgGULvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:51:54 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06LBaaC3170623;
        Tue, 21 Jul 2020 07:51:53 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32bvqvhngv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 07:51:51 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06LBnt8a011282;
        Tue, 21 Jul 2020 11:50:08 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 32brq7ux0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 11:50:08 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06LBmpnP23855584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jul 2020 11:48:51 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B93D4203F;
        Tue, 21 Jul 2020 11:48:51 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1842A42045;
        Tue, 21 Jul 2020 11:48:50 +0000 (GMT)
Received: from naverao1-tp.ibmuc.com (unknown [9.102.1.141])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Jul 2020 11:48:49 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     <linux-doc@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] docs: staging/kprobes.rst: Move references to a separate appendix
Date:   Tue, 21 Jul 2020 17:18:21 +0530
Message-Id: <2bba61cd60eec87fbcca3e4343b7f95afa1178cd.1595331824.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1595331824.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1595331824.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_05:2020-07-21,2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007210077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kprobes references are currently listed right after kretprobes example,
and appears to be part of the same section. Move this out to a separate
appendix for clarity.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 Documentation/staging/kprobes.rst | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/staging/kprobes.rst b/Documentation/staging/kprobes.rst
index 620699f5df22..b757b6dfd3d4 100644
--- a/Documentation/staging/kprobes.rst
+++ b/Documentation/staging/kprobes.rst
@@ -20,6 +20,7 @@ Kernel Probes (Kprobes)
   10. Deprecated Features
   Appendix A: The kprobes debugfs interface
   Appendix B: The kprobes sysctl interface
+  Appendix C: References
 
 Concepts: Kprobes and Return Probes
 =========================================
@@ -710,11 +711,6 @@ Kretprobes Example
 
 See samples/kprobes/kretprobe_example.c
 
-For additional information on Kprobes, refer to the following URLs:
-
-- https://www.ibm.com/developerworks/library/l-kprobes/index.html
-- https://www.kernel.org/doc/ols/2006/ols2006v2-pages-109-124.pdf
-
 Deprecated Features
 ===================
 
@@ -797,3 +793,11 @@ Note that this knob *changes* the optimized state. This means that optimized
 probes (marked [OPTIMIZED]) will be unoptimized ([OPTIMIZED] tag will be
 removed). If the knob is turned on, they will be optimized again.
 
+References
+==========
+
+For additional information on Kprobes, refer to the following URLs:
+
+- https://www.ibm.com/developerworks/library/l-kprobes/index.html
+- https://www.kernel.org/doc/ols/2006/ols2006v2-pages-109-124.pdf
+
-- 
2.25.4

