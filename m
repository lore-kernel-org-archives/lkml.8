Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A99C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 15:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AADA208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 15:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XqNu86gt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731355AbgIJPkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 11:40:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42266 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730736AbgIJPiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:38:08 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08AF2EN3074908;
        Thu, 10 Sep 2020 11:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=GbDZ7CBL/LYipeJIp2XxF3Pn1ncBwSbgSFF+3KzbL8k=;
 b=XqNu86gtYDuMVkhJSOVDKsZb2ErtTuItMVO1cbHSnmirE6ANLxP0BZFyfwkGeyT1nbR9
 0W6ky73O1um/vKY4qTX+u/I5oePs52W/Xh/WVUpO+VbUkT5PUPRgGaYGmSTfh9zuZVa5
 a6AMC6MXpVK1znA4R7KtHY0u7VTv81uN7k9k15xvM4rTsKh2XkHSUlWt9rgg2/jdEQUZ
 SMRaJU/gOtQI+plnecPhc012W+XVM8w9ePf9kYs/NUFcYHauR+rI4dD4XpKb50HZRDll
 /hdxPxHMfLroVAADQZAKuZEeABJ0VSvO3DsNX5Sv8ErmdJVQAd3+NgENSH3RIRtoOKos qg== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33fpd60nmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 11:18:45 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08AFDZqI013601;
        Thu, 10 Sep 2020 15:18:45 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04wdc.us.ibm.com with ESMTP id 33c2a98c31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 15:18:45 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08AFIiTI55312666
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Sep 2020 15:18:44 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DEDF6E050;
        Thu, 10 Sep 2020 15:18:44 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A47DC6E052;
        Thu, 10 Sep 2020 15:18:43 +0000 (GMT)
Received: from SHADE6A.ibmuc.com (unknown [9.211.140.115])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 10 Sep 2020 15:18:43 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-fsi@lists.ozlabs.org,
        andrew@aj.id.au, joel@jms.id.au, robh+dt@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, alistair@popple.id.au,
        jk@ozlabs.org
Subject: [PATCH 4/4] fsi: Aspeed master: Set bus frequency from devicetree
Date:   Thu, 10 Sep 2020 10:18:40 -0500
Message-Id: <20200910151840.25333-5-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910151840.25333-1-eajames@linux.ibm.com>
References: <20200910151840.25333-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_03:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=1 bulkscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009100130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the FSI bus frequency based on the value encoded in the
devicetree. The default value is 166MHz, which is the highest
frequency some FSI slaves can accept.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-master-aspeed.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index c006ec008a1a..be19fee0bece 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -515,6 +515,7 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
 	struct fsi_master_aspeed *aspeed;
 	struct resource *res;
 	int rc, links, reg;
+	u32 bus_freq = 166666666;
 	__be32 raw;
 
 	rc = tacoma_cabled_fsi_fixup(&pdev->dev);
@@ -539,6 +540,10 @@ static int fsi_master_aspeed_probe(struct platform_device *pdev)
 		dev_err(aspeed->dev, "couldn't get clock\n");
 		return PTR_ERR(aspeed->clk);
 	}
+
+	of_property_read_u32(pdev->dev.of_node, "bus-frequency", &bus_freq);
+	clk_set_rate(aspeed->clk, bus_freq);
+
 	rc = clk_prepare_enable(aspeed->clk);
 	if (rc) {
 		dev_err(aspeed->dev, "couldn't enable clock\n");
-- 
2.26.2

