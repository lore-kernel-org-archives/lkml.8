Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24092C47254
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2EB2206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EQUz5wlB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbgEDPGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:06:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42000 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbgEDPGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:06:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044ElhAv024581;
        Mon, 4 May 2020 15:04:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=t0Jfg7lDKwZXvqE1qLiEmLz1WGtmClHHRzVrFx22SYw=;
 b=EQUz5wlBjxHzin0fdQMWm/gLowQ2XNmEkmnv0kG6v61Vx/UA8l03x7T8NXYgfqltQL0h
 G7UKvBCFfdx9GBmEIcRwqykfBQfj+MQIrGjZzdTgYYMpEIFcHO8ppfwx1Vrfyh2Bku2T
 ZOh/dhDH84LssVuz4kj2OSRr7agAIrZ/68mWqbfKB/F2mf98jKz46lOaP0cQ+FbZgeuc
 JnXcZIyr4iwKlHhTMXF3D6wlG01LiKiCvl4yEsJ1Q8Qv1/fktoEhYD/GD8fVmIWFlwqY
 ctum47iV/E7YV5Hx/gusvhXqIw4cXv2zdCHqlBkC2X4NGw/6LxHkvrTDKakTfbPpcUpo /A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 30s1gmy9rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:04:55 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044ElNYI034147;
        Mon, 4 May 2020 15:04:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 30sjnaws5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:04:54 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 044F4rcu028874;
        Mon, 4 May 2020 15:04:53 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 08:04:53 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-3 12/14] asidrv/asicmd: Add more test sequences for testing ASI
Date:   Mon,  4 May 2020 17:02:33 +0200
Message-Id: <20200504150235.12171-13-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200504150235.12171-1-alexandre.chartre@oracle.com>
References: <20200504150235.12171-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add more options to the asicmd command to test access to map
or unmapped memory buffer, interrupt, NMI, scheduling while
using ASI.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 drivers/staging/asi/asicmd.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/staging/asi/asicmd.c b/drivers/staging/asi/asicmd.c
index 4d6a347a6d29..849fa09423e6 100644
--- a/drivers/staging/asi/asicmd.c
+++ b/drivers/staging/asi/asicmd.c
@@ -26,6 +26,20 @@ struct asidrv_test {
 struct asidrv_test test_list[] = {
 	{ "nop", ASIDRV_SEQ_NOP, true,
 	  "enter/exit ASI and nothing else" },
+	{ "mem", ASIDRV_SEQ_MEM, false,
+	  "enter ASI and accessed an unmapped buffer" },
+	{ "memmap", ASIDRV_SEQ_MEMMAP, true,
+	  "enter ASI and accessed a mapped buffer" },
+	{ "intr", ASIDRV_SEQ_INTERRUPT, true,
+	  "receive an interruption while running with ASI" },
+	{ "nmi", ASIDRV_SEQ_NMI, true,
+	  "receive a NMI while running with ASI" },
+	{ "intrnmi", ASIDRV_SEQ_INTRNMI, true,
+	  "receive a NMI in an interrupt received while running with ASI" },
+	{ "sched", ASIDRV_SEQ_SCHED, true,
+	  "call schedule() while running with ASI" },
+	{ "printk", ASIDRV_SEQ_PRINTK, true,
+	  "call printk() while running with ASI" },
 };
 
 #define	TEST_LIST_SIZE	(sizeof(test_list) / sizeof(test_list[0]))
-- 
2.18.2

