Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E4EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0FD72087C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="eh7XGn5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgIDMZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 08:25:13 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:56976 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730113AbgIDMZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:25:11 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 084CJHlF025678;
        Fri, 4 Sep 2020 07:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=Qc7RhO3Z8DUmpqppgDnlz4Yb25OKBWKftAj0kFBkgoQ=;
 b=eh7XGn5F+d0XXQP3soXHbEZEyue9PyyUV7CfVI2JDvu7w37EeGaL299bEoyUdpFn8tDk
 Pw8oSeAvuzGPlaN9ueaGmn6l7wH/1i4MR1HT3RtSv7EjPH8p8VAwyXlEYsviIJs1bQJi
 7RumzZVhBMIzANx3Ts5tXj7FX/6MFEELz3fGjpqUxZjo1vLJt3n1yJbgCaRKMvOchImI
 fF9k6Nge+U7ZtosZUQwJpB2Zb90M7Un9s3memwOg0XGFdIRVQpMeaaGursXTkk+yRa9w
 piqEc/YmP+pRSp4xQHsWCPRzwGGpxK9axo015eVVyo+ir3/eXyIzdUEiBm05oVm/orDH cg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 337me3sc2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Sep 2020 07:25:08 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 4 Sep 2020
 13:25:06 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 4 Sep 2020 13:25:06 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3684D45;
        Fri,  4 Sep 2020 12:25:06 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH] regulator: lochnagar: Add additional VDDCORE range
Date:   Fri, 4 Sep 2020 13:25:06 +0100
Message-ID: <20200904122506.28017-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 mlxscore=0 mlxlogscore=999 phishscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=1 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of an unrecognised mini-card the Lochnagar will not
initialise the VDDCORE voltage register leading to a value outside of the
current range. Add an additional range to cover these values, initially
this wasn't done since they are duplicates of the existing minimum
value.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/regulator/lochnagar-regulator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/lochnagar-regulator.c b/drivers/regulator/lochnagar-regulator.c
index 5ea3e41416849..cb71fa5f43c3e 100644
--- a/drivers/regulator/lochnagar-regulator.c
+++ b/drivers/regulator/lochnagar-regulator.c
@@ -98,6 +98,7 @@ static const struct regulator_ops lochnagar_vddcore_ops = {
 };
 
 static const struct linear_range lochnagar_vddcore_ranges[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0,    0x7, 0),
 	REGULATOR_LINEAR_RANGE(600000, 0x8, 0x41, 12500),
 };
 
-- 
2.11.0

