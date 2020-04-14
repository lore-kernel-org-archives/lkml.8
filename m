Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD6EC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55233208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MZPcMzQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502588AbgDNNIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:08:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38612 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730314AbgDNNId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:08:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EAY6PH104127;
        Tue, 14 Apr 2020 10:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=7IB4h4vyHZWuhixM+o7hLit581/PbOa3rBB6fd0VUW8=;
 b=MZPcMzQjDfxCxXNIYeqRN9HocfuwqrmnTenxdO2rqeN2uXqKXipO3qic8tbl3CbmAfkd
 V280YB2ZkN7oIwRxDneQg4GZHn/+aZQlq3o49sFIt/5eETL8v9nhgAR4iD/5wj+NZ4L8
 Lb1xHUE04kmF1i8pZ6kAEs2pLU9Zmdm77AL7UW28fPvPIX2ZGMWMGK2UVnHEkfcW15IQ
 aMRX44wom+dKiU2FK8yH3jZM5U1S0UKGq5TuA+JNfVqVwYsOhFjGxZW1xDVhMlByNZSa
 qF8z8HPudP2SzAQ0vTewEvJF5ABa8OARycNnB/DPBuC0KvNeohXeH7GlnlyIBMjzogwz Eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 30b5um3pc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 10:36:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EAW0pY123322;
        Tue, 14 Apr 2020 10:36:41 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 30bqpfy3g0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 10:36:41 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03EAabmn015613;
        Tue, 14 Apr 2020 10:36:37 GMT
Received: from mihai.localdomain (/10.153.73.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 03:36:36 -0700
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mihai Carabas <mihai.carabas@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86: microcode: fix return value for microcode late loading
Date:   Tue, 14 Apr 2020 12:55:35 +0300
Message-Id: <1586858135-29337-1-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=1 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=1 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004140087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value from stop_machine might not be consistent.

stop_machine_cpuslocked returns:
- zero if all functions have returned 0
- a non-zero value if at least one of the functions returned
a non-zero value

There is no way to know if it is negative or positive. So make
__reload_late return 0 on success, or negative otherwise.

Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 arch/x86/kernel/cpu/microcode/core.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 7019d4b..336003e 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -545,8 +545,7 @@ static int __wait_for_cpus(atomic_t *t, long long timeout)
 /*
  * Returns:
  * < 0 - on error
- *   0 - no update done
- *   1 - microcode was updated
+ *   0 - success (no update done or microcode was updated)
  */
 static int __reload_late(void *info)
 {
@@ -573,11 +572,9 @@ static int __reload_late(void *info)
 	else
 		goto wait_for_siblings;
 
-	if (err > UCODE_NFOUND) {
+	if (err >= UCODE_NFOUND) {
 		pr_warn("Error reloading microcode on CPU %d\n", cpu);
 		ret = -1;
-	} else if (err == UCODE_UPDATED || err == UCODE_OK) {
-		ret = 1;
 	}
 
 wait_for_siblings:
@@ -608,7 +605,7 @@ static int microcode_reload_late(void)
 	atomic_set(&late_cpus_out, 0);
 
 	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
-	if (ret > 0)
+	if (ret == 0)
 		microcode_check();
 
 	pr_info("Reload completed, microcode revision: 0x%x\n", boot_cpu_data.microcode);
@@ -649,7 +646,7 @@ static ssize_t reload_store(struct device *dev,
 put:
 	put_online_cpus();
 
-	if (ret >= 0)
+	if (ret == 0)
 		ret = size;
 
 	return ret;
-- 
1.8.3.1

