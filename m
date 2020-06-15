Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC84C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF613207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="jFbZGRNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbgFONxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:53:38 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:27000 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729766AbgFONxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:53:33 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05FDi3s2007530;
        Mon, 15 Jun 2020 08:53:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=Zq44tBeW5l57gibeHzjqJMU/tLGGd4l0oGdhLewrUZg=;
 b=jFbZGRNqp383M3EcE24tM5d4Nm429Y3/ZwAFlhea526YJPHnmsBIQaOqY9RLrxQSBDzw
 IMlUa5AT2lwnIH95SsD32VFBi3EZEBKQc2R7r7WKnWbPSb5/9lmeI4PsbKxyuXkqn2D+
 0HMLgArfa+x7Fwp+bVeuIVCo2bQEp+vm1mdg1XIWW8kao1i2azF6jEO55P+/Ut2uCLV8
 ZE+BwFHCEQftJ5ieisvpvwsjNBVyBNpAF9LueU7nZpw7J5QlT1vkudT/nbOrsNXHwCDi
 3Z54EE6iLkjcCwqJ3djR14pq/GS5ExpxL3tk6YTN9Hz/Ysqb2zgwuKey+uX5UZQ2N+S2 iw== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 31mv73jqtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 15 Jun 2020 08:53:26 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 15 Jun
 2020 14:53:24 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 15 Jun 2020 14:53:24 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 083A42C6;
        Mon, 15 Jun 2020 13:53:24 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <s.nawrocki@samsung.com>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 1/4] mfd: arizona: Remove BUG_ON usage
Date:   Mon, 15 Jun 2020 14:53:20 +0100
Message-ID: <20200615135323.15215-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0 mlxlogscore=779
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=1
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006150111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BUG_ON macros are generally frowned upon when the issue isn't super
critical, the kernel can certainly carry on with the 32k clock on the
CODEC in a bad state so change the BUG_ON to a WARN_ON.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

No changes since v1.

Thanks,
Charles

 drivers/mfd/arizona-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index f73cf76d1373d..19e0bc3c0683e 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -80,7 +80,7 @@ int arizona_clk32k_disable(struct arizona *arizona)
 {
 	mutex_lock(&arizona->clk_lock);
 
-	BUG_ON(arizona->clk32k_ref <= 0);
+	WARN_ON(arizona->clk32k_ref <= 0);
 
 	arizona->clk32k_ref--;
 
-- 
2.11.0

