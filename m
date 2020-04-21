Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA32C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E9EF206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NFQwfC7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgDUUIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:08:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55392 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgDUUIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 16:08:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03LK2bFe134049;
        Tue, 21 Apr 2020 20:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=X+//GjRlupUmIYIFzP0Ctl779RKP1FxieoOD/8PQKf8=;
 b=NFQwfC7R605RcIgKo5Bh4sZ43bethE5EefhF9TffLBQgJfOqa4IJ6QtNFnyOIofTqFeF
 QqLgeMAV+Hbz3nElDNa5aropDYZnBfxXIarOP1OA7o0jMjnDjorcSnC0/ytIVSjhtc/T
 C6C9YApg1Xq7QhZZCqoEU8KWvabxnkKFo13OixJyPMTDh1dgVw79bB4zT9kAbVSN8SW6
 se3r8m47IdbxR1FWo6+j1GB2aT00imuiA2jUi79nUTItAhJ0akBRIjXlqpe1yzJRjUB3
 bWnRqD4tGr/OtMmdLkMbbCjNymlIlxZX443+BmSxefAfFaHaEgtFKThkb+Dz7WmPDXyA Ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 30fsgky4a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 20:08:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03LK2Vee128225;
        Tue, 21 Apr 2020 20:08:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 30gbber9dh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 20:08:21 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03LK8JCT006680;
        Tue, 21 Apr 2020 20:08:19 GMT
Received: from mihai.localdomain (/10.153.73.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Apr 2020 13:08:19 -0700
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mihai Carabas <mihai.carabas@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2] x86: microcode: fix return value for microcode late loading
Date:   Tue, 21 Apr 2020 22:28:38 +0300
Message-Id: <1587497318-4438-1-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1586858135-29337-1-git-send-email-mihai.carabas@oracle.com>
References: <1586858135-29337-1-git-send-email-mihai.carabas@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=1 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=1 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210150
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
Changes in v2:
- do not print anything on UCODE_NFOUND as microcode not found
is not an error

 arch/x86/kernel/cpu/microcode/core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 7019d4b..a2ae3da 100644
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
@@ -576,8 +575,8 @@ static int __reload_late(void *info)
 	if (err > UCODE_NFOUND) {
 		pr_warn("Error reloading microcode on CPU %d\n", cpu);
 		ret = -1;
-	} else if (err == UCODE_UPDATED || err == UCODE_OK) {
-		ret = 1;
+	} else if (err == UCODE_NFOUND) {
+		ret = -1;
 	}
 
 wait_for_siblings:
@@ -608,7 +607,7 @@ static int microcode_reload_late(void)
 	atomic_set(&late_cpus_out, 0);
 
 	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
-	if (ret > 0)
+	if (ret == 0)
 		microcode_check();
 
 	pr_info("Reload completed, microcode revision: 0x%x\n", boot_cpu_data.microcode);
@@ -649,7 +648,7 @@ static ssize_t reload_store(struct device *dev,
 put:
 	put_online_cpus();
 
-	if (ret >= 0)
+	if (ret == 0)
 		ret = size;
 
 	return ret;
-- 
1.8.3.1

