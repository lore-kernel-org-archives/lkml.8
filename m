Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23F3C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B74E20792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbgGULuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:50:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23180 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726755AbgGULuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:50:13 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06LBZTsA116725;
        Tue, 21 Jul 2020 07:50:12 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32bwk82xtf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 07:50:12 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06LBo63r011443;
        Tue, 21 Jul 2020 11:50:10 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 32brq7ux0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 11:50:10 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06LBmrSx26542144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jul 2020 11:48:53 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AEF642047;
        Tue, 21 Jul 2020 11:48:53 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A69FF42045;
        Tue, 21 Jul 2020 11:48:51 +0000 (GMT)
Received: from naverao1-tp.ibmuc.com (unknown [9.102.1.141])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Jul 2020 11:48:51 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     <linux-doc@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] docs: Move kprobes.rst from staging/ to trace/
Date:   Tue, 21 Jul 2020 17:18:22 +0530
Message-Id: <8a09c01c64b2e003d5486c4f0c89740618f1bae4.1595331824.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1595331824.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1595331824.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_05:2020-07-21,2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=951
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007210082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kprobes contitutes a dynamic tracing technology and as such can be
moved alongside documentation of other tracing technologies.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 Documentation/staging/index.rst              | 1 -
 Documentation/trace/index.rst                | 1 +
 Documentation/{staging => trace}/kprobes.rst | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/{staging => trace}/kprobes.rst (100%)

diff --git a/Documentation/staging/index.rst b/Documentation/staging/index.rst
index 184e6aece0a7..abd0d18254d2 100644
--- a/Documentation/staging/index.rst
+++ b/Documentation/staging/index.rst
@@ -7,7 +7,6 @@ Unsorted Documentation
    :maxdepth: 2
 
    crc32
-   kprobes
    lzo
    remoteproc
    rpmsg
diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 7d83156c9ac1..879ebb9f647d 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -9,6 +9,7 @@ Linux Tracing Technologies
    tracepoint-analysis
    ftrace
    ftrace-uses
+   kprobes
    kprobetrace
    uprobetracer
    tracepoints
diff --git a/Documentation/staging/kprobes.rst b/Documentation/trace/kprobes.rst
similarity index 100%
rename from Documentation/staging/kprobes.rst
rename to Documentation/trace/kprobes.rst
-- 
2.25.4

