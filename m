Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A52C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A438520A8B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IXHCXvl9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgEGRZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:25:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41828 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgEGRZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:25:39 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047HNEUW121855
        for <linux-kernel@vger.kernel.org>; Thu, 7 May 2020 17:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=HfUeggJR/O/iIeAUSeiZiFbWFcwK1K8/rIWzmcMKkx4=;
 b=IXHCXvl9079GLoInGfaNG/q76uqqWpoEUTESeX+4jLmhXcoNPUejo+c3osCcQ8l+5sk9
 f0gmryAnChIGe8loTEKFKjbUC3+KVsU6D/hhu4LIfI7d9Z3tKgLNhRsT2RoenzZfKeGY
 A/ik2Bx5HiBUZ3SE+dowZnBOCYucNaawBaI9RedfEV5440S/nACXpNnXdOZDgiqwDCwx
 Lw7tDCvUltXHVhROy2j7a7gYNahzAkj327snmV3Y5HnuBwXYL92J07RmVr8IlO1AhrYv
 CZzIXj+cUBsFyh7pjBou3PtrB5YBEl/u+peAGJHMBUGZy+VBGdbIGjb48FtrDa6nceV+ Eg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30usgq8m4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 17:25:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047HGgTP045920
        for <linux-kernel@vger.kernel.org>; Thu, 7 May 2020 17:25:37 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 30us7r2ja2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 17:25:37 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 047HPa1R002283
        for <linux-kernel@vger.kernel.org>; Thu, 7 May 2020 17:25:36 GMT
Received: from localhost.localdomain (/70.114.128.235)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 May 2020 10:25:36 -0700
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH v2] .mailmap: Update address of Himanshu Madhani
Date:   Thu,  7 May 2020 12:25:35 -0500
Message-Id: <20200507172535.51314-1-himanshu.madhani@oracle.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=1
 mlxlogscore=998 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070141
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9614 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I do not have access to my @marvell.com email ID anymore.
Lets map my new email address correctly in .mailmap

Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
Changes from v1
- Update patch subject line to reflect .mailmap changes.

---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index db3754a41018..30d8c3f10ca7 100644
--- a/.mailmap
+++ b/.mailmap
@@ -99,6 +99,8 @@ Henk Vergonet <Henk.Vergonet@gmail.com>
 Henrik Kretzschmar <henne@nachtwindheim.de>
 Henrik Rydberg <rydberg@bitmath.org>
 Herbert Xu <herbert@gondor.apana.org.au>
+Himanshu Madhani <himanshu.madhani@oracle.com>
+Himanshu Madhani <hmadhani2024@gmail.com>
 Jacob Shin <Jacob.Shin@amd.com>
 Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk@google.com>
 Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk@motorola.com>
-- 
2.26.2

