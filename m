Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55196C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D72B20578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="JjBXPwoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgHUQYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:24:32 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:18634 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728550AbgHUQXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:23:06 -0400
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
        by m0050095.ppops.net-00190b01. (8.16.0.42/8.16.0.42) with SMTP id 07LGLbUe005671;
        Fri, 21 Aug 2020 17:21:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id; s=jan2016.eng;
 bh=rzIJAPEqi9ZbyvNsKoNPSLx0bNPb0cYaCsV3sB7wpNw=;
 b=JjBXPwoUdmZbAzQQXOABQ4KCyONKzCLOFOG/CSYoz3MbSTpu0pCA3wa1ru6VdcZC06fH
 sY3IH6bOhQAE7SmiOwqGzAQd0U6wZB4ioG4v9UTk6JxEutOjGxbl2gRRQ0Gf3PLxWx/L
 ABNJN7edtKoTcGgenlDBTPaM3T2+O5BxzFuzAqo/2stl7FjbEuJ39MUtNO7FXSl0cB7/
 wWvUoSxnf56wMZf5PbPfmwfBTBAmn1fvkQx19hZG15FujFxzYd36864C/GHb8Z8S8DMA
 /Gss8qT7brRRgvbzjdwBA2PHc4PqtNkK74Zm8lqt0BS8z3ItWsotKQiDyZY/MdTUCo9P qg== 
Received: from prod-mail-ppoint4 (a72-247-45-32.deploy.static.akamaitechnologies.com [72.247.45.32] (may be forged))
        by m0050095.ppops.net-00190b01. with ESMTP id 331d2fg4a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Aug 2020 17:21:37 +0100
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
        by prod-mail-ppoint4.akamai.com (8.16.0.42/8.16.0.42) with SMTP id 07LFnKSk008414;
        Fri, 21 Aug 2020 12:21:31 -0400
Received: from prod-mail-relay19.dfw02.corp.akamai.com ([172.27.165.173])
        by prod-mail-ppoint4.akamai.com with ESMTP id 32xb1yhq7e-1;
        Fri, 21 Aug 2020 12:21:31 -0400
Received: from bos-lpjec.145bw.corp.akamai.com (bos-lpjec.145bw.corp.akamai.com [172.28.3.71])
        by prod-mail-relay19.dfw02.corp.akamai.com (Postfix) with ESMTP id 6712F6025E;
        Fri, 21 Aug 2020 16:21:31 +0000 (GMT)
From:   Jason Baron <jbaron@akamai.com>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (nct7904) Correct divide by 0
Date:   Fri, 21 Aug 2020 12:20:14 -0400
Message-Id: <1598026814-2604-1-git-send-email-jbaron@akamai.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_08:2020-08-21,2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008210147
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_08:2020-08-21,2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008210153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We hit a kernel panic due to a divide by 0 in nct7904_read_fan() for
the hwmon_fan_min case. Extend the check to hwmon_fan_input case as well
for safety.

[ 1656.545650] divide error: 0000 [#1] SMP PTI
[ 1656.545779] CPU: 12 PID: 18010 Comm: sensors Not tainted 5.4.47 #1
[ 1656.546065] RIP: 0010:nct7904_read+0x1e9/0x510 [nct7904]
...
[ 1656.546549] RAX: 0000000000149970 RBX: ffffbd6b86bcbe08 RCX: 0000000000000000
...
[ 1656.547548] Call Trace:
[ 1656.547665]  hwmon_attr_show+0x32/0xd0 [hwmon]
[ 1656.547783]  dev_attr_show+0x18/0x50
[ 1656.547898]  sysfs_kf_seq_show+0x99/0x120
[ 1656.548013]  seq_read+0xd8/0x3e0
[ 1656.548127]  vfs_read+0x89/0x130
[ 1656.548234]  ksys_read+0x7d/0xb0
[ 1656.548342]  do_syscall_64+0x48/0x110
[ 1656.548451]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Jason Baron <jbaron@akamai.com>
---
 drivers/hwmon/nct7904.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index b042569..242ff8b 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -231,7 +231,7 @@ static int nct7904_read_fan(struct device *dev, u32 attr, int channel,
 		if (ret < 0)
 			return ret;
 		cnt = ((ret & 0xff00) >> 3) | (ret & 0x1f);
-		if (cnt == 0x1fff)
+		if (cnt == 0 || cnt == 0x1fff)
 			rpm = 0;
 		else
 			rpm = 1350000 / cnt;
@@ -243,7 +243,7 @@ static int nct7904_read_fan(struct device *dev, u32 attr, int channel,
 		if (ret < 0)
 			return ret;
 		cnt = ((ret & 0xff00) >> 3) | (ret & 0x1f);
-		if (cnt == 0x1fff)
+		if (cnt == 0 || cnt == 0x1fff)
 			rpm = 0;
 		else
 			rpm = 1350000 / cnt;
-- 
2.7.4

