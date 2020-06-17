Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0831C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 15:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DFB9206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 15:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="UfxZNrtG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgFQPVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 11:21:43 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:6730 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726815AbgFQPVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 11:21:43 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05HFLeFP015744;
        Wed, 17 Jun 2020 10:21:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=LczWbyRKAQLiLjNE42NBExLivrTvgCbGmOnMR6ffhSg=;
 b=UfxZNrtGYEiu7NgoTQQuwthBw/NdGgMNSGR/wnMIe1ZCon/DgE5CtfIvtqbhI47Yhi8h
 1rXpK8Vi8Vxl+6XAfShDugB1n7BeyoEOdYwdSSrp9hrlyWwgwoZUprUgDk517OoZ+8is
 +L5Lt+r4Q/hMDB9M8M0rP1wJ//+menR49/wdvbA+5lN8Spz9J0LqVSRVTkFFFu0tcZwA
 xlSuYtzVzRBt1/WYm5PvZeCLe1sqaNmEaJmLoQnwObvAzt00ZiHoii/BKSDdcxPVWIdY
 mvwwt4b/4pzJS/0H3EsRnb7Bqg13AixWV+dU5UfS9l7WX8S7RZZ1TQpsSSqJDT5b3iTy WA== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 31q664sg9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 17 Jun 2020 10:21:40 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 17 Jun
 2020 16:21:30 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 17 Jun 2020 16:21:30 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0CDE42C6;
        Wed, 17 Jun 2020 15:21:30 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH] regmap: Fix memory leak from regmap_register_patch
Date:   Wed, 17 Jun 2020 16:21:29 +0100
Message-ID: <20200617152129.19655-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=747 impostorscore=0 phishscore=0
 adultscore=0 suspectscore=3 lowpriorityscore=0 clxscore=1015
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006170121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a register patch is registered the reg_sequence is copied but the
memory allocated is never freed. Add a kfree in regmap_exit to clean it
up.

Fixes: 22f0d90a3482 ("regmap: Support register patch sets")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/base/regmap/regmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 94e2e2d1824bb..414422e1a2e6e 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1349,6 +1349,7 @@ void regmap_exit(struct regmap *map)
 	if (map->hwlock)
 		hwspin_lock_free(map->hwlock);
 	kfree_const(map->name);
+	kfree(map->patch);
 	kfree(map);
 }
 EXPORT_SYMBOL_GPL(regmap_exit);
-- 
2.11.0

