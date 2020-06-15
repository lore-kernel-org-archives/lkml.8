Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB26C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FEAE207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="RV8Mm7oD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbgFONxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:53:51 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:16872 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728326AbgFONxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:53:33 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05FDpRMj016230;
        Mon, 15 Jun 2020 08:53:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=jxTvSA1dvZM5FSGl8XPFgwjEr63mRuVc1zw13o0z7RQ=;
 b=RV8Mm7oD6nVoZf9g45dEHDHgCl1VFD5qjH7p7OvnnaphIH3KrYsz3cgI87xisI0V8SB9
 9PH7EoowEvaIqBnCiy2lrvVJx8tPMLvodVfDpHvHRevEu2tTWYZFcw2ABkBlMtQChcxC
 RgGCPilvn8jti3wXD5YxmF/WjIQ71TRYKkfQpcJZkfaJfSOVqCx7t8B+R/vhd/bNqpqG
 CiepjhmyKJ+WoObmNOujZkhqOBfyjtJtlJINrJEuaCKvrR8HMI/QxE0UGf2iUbsfBLad
 c+S4NFzd1Zq6Tqc1cQkTigOqM72GSlRPuSkB3+A+T/dbOFIC8d4GCO/qMaGwCFvuF8wq cQ== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 31mu7p2q6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 15 Jun 2020 08:53:25 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 15 Jun
 2020 14:53:24 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 15 Jun 2020 14:53:24 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 25A9A2C5;
        Mon, 15 Jun 2020 13:53:24 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <s.nawrocki@samsung.com>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH v2 3/4] mfd: madera: Remove unused forward declaration of madera_codec_pdata
Date:   Mon, 15 Jun 2020 14:53:22 +0100
Message-ID: <20200615135323.15215-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200615135323.15215-1-ckeepax@opensource.cirrus.com>
References: <20200615135323.15215-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 phishscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 suspectscore=1 priorityscore=1501 bulkscore=0 mlxlogscore=876
 malwarescore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006150112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This forward declaration is redundant since the header including the
full data structure is included.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

New since v1 of the series.

Thanks,
Charles

 include/linux/mfd/madera/pdata.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mfd/madera/pdata.h b/include/linux/mfd/madera/pdata.h
index fa9595dd42ba5..601cbbc10370c 100644
--- a/include/linux/mfd/madera/pdata.h
+++ b/include/linux/mfd/madera/pdata.h
@@ -21,7 +21,6 @@
 
 struct gpio_desc;
 struct pinctrl_map;
-struct madera_codec_pdata;
 
 /**
  * struct madera_pdata - Configuration data for Madera devices
-- 
2.11.0

