Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79DFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 914F920658
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IbaRS/E0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgHRJfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 05:35:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726568AbgHRJfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:35:18 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07I9YBLG075709;
        Tue, 18 Aug 2020 05:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=rwRynWrFDwfiRh9GJtGcLcgC+/9bC5jkzU/yd3xiEOc=;
 b=IbaRS/E0rcDQ9KOD6yIs0LbDpvRkY7fg0KUOOKlBi3c/th+tvlrKDGNDm3wXDcp2nl4X
 0nzX4/RSnXCarolhLW6C6rNR/JgH2ZD0mYm2gMwa9255N4eGWPaa9Cytvgi4RfgjgUdf
 xxAprflKRyd5NoPFgA2nUQA4nJPe+Ibosis+9bQp2wyqj4Di0xdQEGhwk6nqx/hKOIWh
 a70zRdJH8/RfHY6DLoVMZewhUBf7jZK/v9nbXvlvO2KnX/8SxYUTmULaSce6BnFTBhN4
 gXyGCF2D+IvG1KnySRYoDknbOdcdLSN8E9qEd5JdQgvxkxc0vIS8S0KsoxNOC3hXAzlG qg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3304t1bka8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 05:35:14 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07I9KOfr019506;
        Tue, 18 Aug 2020 09:35:12 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3304c909dv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 09:35:12 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07I9ZACK51052994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Aug 2020 09:35:10 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7706D52051;
        Tue, 18 Aug 2020 09:35:10 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.33.217])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 789ED52057;
        Tue, 18 Aug 2020 09:35:09 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 2/2] tasks: Add headers and improve spacing format
Date:   Tue, 18 Aug 2020 15:05:01 +0530
Message-Id: <54c868c79b5fc364a8be7799891934a6fe6d1464.1597742951.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1597742951.git.riteshh@linux.ibm.com>
References: <cover.1597742951.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-18_06:2020-08-18,2020-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=881
 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008180064
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the patch.
<e.g. o/p>
      TASK          PID    COMM
0xffffffff82c2b8c0   0   swapper/0
0xffff888a0ba20040   1   systemd
0xffff888a0ba24040   2   kthreadd
0xffff888a0ba28040   3   rcu_gp

w/o
0xffffffff82c2b8c0 <init_task> 0 swapper/0
0xffff888a0ba20040 1 systemd
0xffff888a0ba24040 2 kthreadd
0xffff888a0ba28040 3 rcu_gp

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 scripts/gdb/linux/tasks.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/gdb/linux/tasks.py b/scripts/gdb/linux/tasks.py
index 0301dc1e0138..17ec19e9b5bf 100644
--- a/scripts/gdb/linux/tasks.py
+++ b/scripts/gdb/linux/tasks.py
@@ -73,11 +73,12 @@ class LxPs(gdb.Command):
         super(LxPs, self).__init__("lx-ps", gdb.COMMAND_DATA)
 
     def invoke(self, arg, from_tty):
+        gdb.write("{:>10} {:>12} {:>7}\n".format("TASK", "PID", "COMM"))
         for task in task_lists():
-            gdb.write("{address} {pid} {comm}\n".format(
-                address=task,
-                pid=task["pid"],
-                comm=task["comm"].string()))
+            gdb.write("{} {:^5} {}\n".format(
+                task.format_string().split()[0],
+                task["pid"].format_string(),
+                task["comm"].string()))
 
 
 LxPs()
-- 
2.25.4

