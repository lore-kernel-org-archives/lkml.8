Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16468C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE01C2469D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Gv/3ZYEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgB1Plr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:41:47 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:37898 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727064AbgB1Plq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:41:46 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01SFaOEP002043;
        Fri, 28 Feb 2020 09:41:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=xTcKA8ZvleVFPvcXWLXlaHTYI6ivzdsHzjYPo2nEuIw=;
 b=Gv/3ZYEyNfLH3i9n4gnil/B3gheDlYw7aqwUcOuS9vmaTd0G9bWwZ8HZanXj4PCPJPq6
 BAK0Brxrurp4jq7To+HKDB1u3Ks26rWINXdbkccnloZ+1WBHJBaY6PiAKa3cQ4AMy3o/
 HaSu8Fb3Grwk2CoIF40MZuojYWpn4wttXQdzIKPGb6i7FonRoAXW58oEp28NUxETTW71
 uGGQHonWf+TyVe+xaBgA7QI/haKNTQD/2FoJaqWkna1UBjkkGOo0gzlXer81yDKyNyrk
 bp9n8/3ghfeFpqrsbkuHLblsvKYDXwRd+Icr/HgM8pBr5XikCoW6LHoKxcGfRsM7G1gu Iw== 
Authentication-Results: ppops.net;
        spf=pass smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([5.172.152.52])
        by mx0b-001ae601.pphosted.com with ESMTP id 2yepvmsd87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 28 Feb 2020 09:41:43 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Fri, 28 Feb
 2020 15:41:42 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Fri, 28 Feb 2020 15:41:42 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 18DC545D;
        Fri, 28 Feb 2020 15:41:42 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <linus.walleij@linaro.org>
CC:     <tony@atomide.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH] pinctrl: core: Remove extra kref_get which blocks hogs being freed
Date:   Fri, 28 Feb 2020 15:41:42 +0000
Message-ID: <20200228154142.13860-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=811 spamscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=1 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002280124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kref_init starts with the reference count at 1, which will be balanced
by the pinctrl_put in pinctrl_unregister. The additional kref_get in
pinctrl_claim_hogs will increase this count to 2 and cause the hogs to
not get freed when pinctrl_unregister is called.

Fixes: 6118714275f0 ("pinctrl: core: Fix pinctrl_register_and_init() with pinctrl_enable()")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/pinctrl/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 446d84fe0e31c..f23c55e221955 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -2021,7 +2021,6 @@ static int pinctrl_claim_hogs(struct pinctrl_dev *pctldev)
 		return PTR_ERR(pctldev->p);
 	}
 
-	kref_get(&pctldev->p->users);
 	pctldev->hog_default =
 		pinctrl_lookup_state(pctldev->p, PINCTRL_STATE_DEFAULT);
 	if (IS_ERR(pctldev->hog_default)) {
-- 
2.11.0

