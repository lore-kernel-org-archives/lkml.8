Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5991BC33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C72C207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aHSFk8cC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgAMM7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:59:48 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:49198 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgAMM7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 07:59:48 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DCwcl9062900;
        Mon, 13 Jan 2020 12:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=ZfQ1LgEbn14jkZf0Ql+4WtMf3jaMLStq+biPvvi5LeY=;
 b=aHSFk8cCApgGWGP9EVWzSjLQdiG2Bpi9zxuSrvIVNMKnFz4ekCONCWcx4xcSeZLOX55D
 aM8DohhHK0kwdp9UeShe1Bx8n91QLMOChpyAMw1HJLU8YQdgqaDp9SuVcnCiZwSARTFy
 MhNWao7CBnUQvOI5wqv6upPCvtMFRbTQNL3sPNhzatrYm6IzcKOeFPm6AjcHO5VGptlM
 XxRvgeBe+d1CSpoCiQH9T568qZcwQ/UOuYu94b1V8YDe2JzrX9GWgq7Hz4pImRRXAU8y
 y4jmXd4yrVt8pFCycTcddauB+lLWyX+qZUOM5rJ66Uw1I77eDhXx6O2BpZuf77TCRnFL Gg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xf73tesk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 12:59:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00DCwaqv020336;
        Mon, 13 Jan 2020 12:59:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2xfrh61xqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 12:59:44 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00DCxg8o012055;
        Mon, 13 Jan 2020 12:59:42 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Jan 2020 04:59:42 -0800
Date:   Mon, 13 Jan 2020 15:59:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] regulator: mpq7920: Check the correct variable in
 mpq7920_regulator_register()
Message-ID: <20200113125805.xri6jqoxy2ldzqyg@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9498 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001130108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9498 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001130108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a typo in the error checking.  We should be checking
"->rdev[i]" instead of just "->rdev".

Fixes: 6501c1f54a17 ("regulator: mpq7920: add mpq7920 regulator driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/regulator/mpq7920.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/mpq7920.c b/drivers/regulator/mpq7920.c
index ab1b847c57e5..80f3131f0d1b 100644
--- a/drivers/regulator/mpq7920.c
+++ b/drivers/regulator/mpq7920.c
@@ -274,8 +274,8 @@ static inline int mpq7920_regulator_register(
 
 		info->rdev[i] = devm_regulator_register(info->dev, rdesc,
 					 config);
-		if (IS_ERR(info->rdev))
-			return PTR_ERR(info->rdev);
+		if (IS_ERR(info->rdev[i]))
+			return PTR_ERR(info->rdev[i]);
 	}
 
 	return 0;
-- 
2.11.0

