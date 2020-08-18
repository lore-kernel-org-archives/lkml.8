Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7EFC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 04:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DED0D2072A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 04:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JfCs+D1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgHREEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 00:04:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbgHREEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 00:04:52 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07I42UQ8194198;
        Tue, 18 Aug 2020 00:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=/4oqOV4LYeWWZ79+QyApMKjx9ScJfNcJD9LWU04JZo8=;
 b=JfCs+D1c9L8wuCRBlUDFiAO41fUP5lgq9seI4S+3bs40s5koxiDdamcC3quP3wx5B/gl
 K1UCaMWMZZ98CSIBk1wyW5G1EPAuMJwXyQnXtnZ7gN6i8/nPkItfOSy32HPZ5IDiXjfp
 9RK2i6cX5vQ6TSTmQcsLFAtAXW3bNCMvIqdHVrUSLmjtc0K7hnAkfRTF1rE9k8v522q/
 wR+1rjprVFMyPCnSScptyGXCza5vkS9fscgz8gBbEQjdJnbHNk3XOysMrRFm4cI+YYC/
 HtxBQU6ObuvL5/ZRyqp2nkXPKagVioe4+nAvk419UKkBC7C1HAmqzbS6EjmY1hfYEX0F 6g== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3304r5bud3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 00:04:44 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07I3psaL028869;
        Tue, 18 Aug 2020 04:04:42 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3304bt05hk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 04:04:42 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07I44e6g61473256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Aug 2020 04:04:40 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21A7CAE045;
        Tue, 18 Aug 2020 04:04:40 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35FD5AE04D;
        Tue, 18 Aug 2020 04:04:39 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.33.217])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Aug 2020 04:04:39 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 0/2] scripts:gdb: Add few structs in gdb scripts
Date:   Tue, 18 Aug 2020 09:34:29 +0530
Message-Id: <cover.1597721575.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-18_01:2020-08-17,2020-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=894
 malwarescore=0 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008180026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was using these structs info internally in my gdb scripts.
So sending it out for merge to upstream.

Ritesh Harjani (2):
  proc: Add struct mount & struct super_block addr in lx-mounts command
  tasks: Add task_struct addr for lx-ps cmd

 scripts/gdb/linux/lists.py | 43 ++++++++++++++++++++++++++++++++++++++
 scripts/gdb/linux/proc.py  | 15 +++++++------
 scripts/gdb/linux/tasks.py |  9 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.25.4

