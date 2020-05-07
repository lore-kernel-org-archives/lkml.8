Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327A2C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09E5D2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A9iO505k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgEGQTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 12:19:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45100 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgEGQTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 12:19:37 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047GHu8I159445
        for <linux-kernel@vger.kernel.org>; Thu, 7 May 2020 16:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=QNiQ2cJrAHPXydkPG/OgMeHAMqbodlGYYbU1zlcJSgU=;
 b=A9iO505k7i8riCkv3kitniTMgG5KS1Qr171Ql3x+ck5AvQzJHQhNZK+wlhhm3y4nTmND
 ytKxvX+EUAvuycwSBNuccN9bSS5rKHPqwupmFS8K59EFn9sc3cS2tgWHL5Z/QCG2nIBY
 BWv3APZGU0llcmP5QXt7Qsd+s47jWBLND3QKCaRZ6SIGkZSg9+6RElXXs0/kId2WDgUk
 GHBFVibFFk3yIhQh7a5oA/d25bYvmKp/VsyV4juippD3GmH/qioIOP8GB0y3rlp9cQ6n
 PL+t6Wa1dkUR6MFjVsAy34kYaSWbRKxjf+xn0nQe3RgsAQ2NU232kNpA+P7zY4lhOe8x 5Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30vhvyhf89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 16:19:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 047GHXX0105550
        for <linux-kernel@vger.kernel.org>; Thu, 7 May 2020 16:17:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 30sjnptfkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 16:17:34 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 047GCUCH004059
        for <linux-kernel@vger.kernel.org>; Thu, 7 May 2020 16:12:31 GMT
Received: from localhost.localdomain (/70.114.128.235)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 May 2020 09:12:30 -0700
From:   Himanshu Madhani <himanshu.madhani@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH] MAINTAINER: Update my email address
Date:   Thu,  7 May 2020 11:12:29 -0500
Message-Id: <20200507161229.31448-1-himanshu.madhani@oracle.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=1 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I do not have access to my @marvell.com email ID anymore.
Lets map my new email address correctly in .mailmap

Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
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

