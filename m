Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FCBC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190ED222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="QTiy75BO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgANPK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:10:56 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:34854 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726297AbgANPKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:10:52 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00EFAojf004601;
        Tue, 14 Jan 2020 09:10:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=WYX1kSQtqsHCwWog7hm5oGkcnj1nltSebjra8pCkUJo=;
 b=QTiy75BOeiVWaZkVetE9RmHn1rPgX8QBJVtsqM4NhzrZ58jREJFRNgq9H6EqAgD9KCxn
 mgrJL/AcjnhTUjj8oX3Zt+UW3roEkxglsN14pEAL/LLA9jZBKJ9V8lsQzdTTwp/0yqKh
 ids0d8pDEK6HE7PEZAhbooX/DsI6mYQjgu5gJqBlnnvl79RnceGETYTPkrvy06XR+Qw2
 lAxQXe0Q+Qayr+q8HN21KTgC0FjEefSX/3WKQ5s+E2icPAjEDnQsmrOOWuJtf9vPHF2m
 OHxYjiDqRFvU6zwyn3TeQ3Cdm918ubJtqYOLM27pqyXfh5uTrmLrITGN3Kvs6NnFw1KA Qw== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([5.172.152.52])
        by mx0b-001ae601.pphosted.com with ESMTP id 2xfbntvpsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Jan 2020 09:10:50 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 14 Jan
 2020 15:10:48 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Tue, 14 Jan 2020 15:10:48 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BF7C32D1;
        Tue, 14 Jan 2020 15:10:48 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH RESEND 2/3] mfd: madera: Wait for boot done before accessing any other registers
Date:   Tue, 14 Jan 2020 15:10:47 +0000
Message-ID: <20200114151048.20282-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200114151048.20282-1-ckeepax@opensource.cirrus.com>
References: <20200114151048.20282-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=1 priorityscore=1501 impostorscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001140130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is advised to wait for the boot done bit to be set before reading
any other register, update the driver to respect this.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

This patch can be applied separately from the other patches in the series,
if needed. Just resending to keep everything together in one chain.

Thanks,
Charles

 drivers/mfd/madera-core.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index a8cfadc1fc01e..a7d50a7fa625d 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -199,7 +199,7 @@ EXPORT_SYMBOL_GPL(madera_name_from_type);
 #define MADERA_BOOT_POLL_INTERVAL_USEC		5000
 #define MADERA_BOOT_POLL_TIMEOUT_USEC		25000
 
-static int madera_wait_for_boot(struct madera *madera)
+static int madera_wait_for_boot_noack(struct madera *madera)
 {
 	ktime_t timeout;
 	unsigned int val = 0;
@@ -226,6 +226,13 @@ static int madera_wait_for_boot(struct madera *madera)
 		ret = -ETIMEDOUT;
 	}
 
+	return ret;
+}
+
+static int madera_wait_for_boot(struct madera *madera)
+{
+	int ret = madera_wait_for_boot_noack(madera);
+
 	/*
 	 * BOOT_DONE defaults to unmasked on boot so we must ack it.
 	 * Do this even after a timeout to avoid interrupt storms.
@@ -545,6 +552,12 @@ int madera_dev_init(struct madera *madera)
 	regcache_cache_only(madera->regmap, false);
 	regcache_cache_only(madera->regmap_32bit, false);
 
+	ret = madera_wait_for_boot_noack(madera);
+	if (ret) {
+		dev_err(madera->dev, "Device failed initial boot: %d\n", ret);
+		goto err_reset;
+	}
+
 	/*
 	 * Now we can power up and verify that this is a chip we know about
 	 * before we start doing any writes to its registers.
@@ -650,7 +663,7 @@ int madera_dev_init(struct madera *madera)
 
 	ret = madera_wait_for_boot(madera);
 	if (ret) {
-		dev_err(madera->dev, "Device failed initial boot: %d\n", ret);
+		dev_err(madera->dev, "Failed to clear boot done: %d\n", ret);
 		goto err_reset;
 	}
 
-- 
2.11.0

