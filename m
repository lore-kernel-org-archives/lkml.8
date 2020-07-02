Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3215FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B598208D5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rzmaWld0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbgGBPXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:23:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54680 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgGBPXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:23:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 062FMWEe186983;
        Thu, 2 Jul 2020 15:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=kkfvYworqJqVbvmXpZkoO213bi9Sr3ObjvqMzgZoE6Q=;
 b=rzmaWld0zx6vpbXUWgm3TnEd8g/nE/AWRcKBAcrT0V5jo17QtNvUAqjXQaIHOftH/eYL
 nqWzVjtJgnsSwPTBGTGlC9MyZIf622BVX2dMO6zyj4OD1xfqV4DCdKy/Pus4LA7V4Xqa
 3o2HoXGsXnK/YMKYa1v9m6tWsdcLy2YGbA/K0Aam4RQ8kqooblNi/bGaR2ZTUBmJLUh7
 xQxCkFThjE9cPMEMitXUWYtn6ra8N3X/KzxzGottCBlGcZzj+V+Bq5G0yRX/XiruWJQo
 nfAfSEca0TIZWsc4YMoJiFpfGkg1xA0SUlsEgPXKQtgtHTCPDDI5OmBv7wdfXyAcMIsT GQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31xx1e5xpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 02 Jul 2020 15:23:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 062EvrAj162760;
        Thu, 2 Jul 2020 15:21:46 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 31xg2144en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Jul 2020 15:21:46 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 062FLjno000819;
        Thu, 2 Jul 2020 15:21:45 GMT
Received: from mihai.localdomain (/10.153.73.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Jul 2020 15:20:53 +0000
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH RFC 4/7] x86: cpu: bugs.c: update cpu_smt_disable to be callable at runtime
Date:   Thu,  2 Jul 2020 18:18:24 +0300
Message-Id: <1593703107-8852-5-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1593703107-8852-1-git-send-email-mihai.carabas@oracle.com>
References: <1593703107-8852-1-git-send-email-mihai.carabas@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9670 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 mlxlogscore=935 adultscore=0 mlxscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007020106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9670 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=1 mlxlogscore=957 cotscore=-2147483648 lowpriorityscore=0
 malwarescore=0 phishscore=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007020107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the microcode late loading and bug mitigation logic needs to turn
off SMT, it must use the hot plug infrastructure, not the boot time call
"cpu_smt_disable".

Update "cpu_smt_disable" to use the hot plug infrastructure to turn off
SMT when the system is in state running.

Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 kernel/cpu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index fe67a01..719670f 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -393,9 +393,25 @@ void __weak arch_smt_update(void) { }
 
 void cpu_smt_disable(bool force)
 {
+	int ret;
+
 	if (!cpu_smt_possible())
 		return;
 
+	if (system_state == SYSTEM_RUNNING) {
+		if (force)
+			ret = cpuhp_smt_disable(CPU_SMT_FORCE_DISABLED);
+		else
+			ret = cpuhp_smt_disable(CPU_SMT_DISABLED);
+
+		/* If SMT disable did not succeed, print a warning*/
+		if (ret)
+			pr_warn("SMT: not disabled %d\n", ret);
+		else
+			pr_info("SMT:%s disabled\n", force ? " Force" : "");
+		return;
+	}
+
 	if (force) {
 		pr_info("SMT: Force disabled\n");
 		cpu_smt_control = CPU_SMT_FORCE_DISABLED;
-- 
1.8.3.1

