Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804F4C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494DA2467D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 15:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="dZX2vwT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgANPKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 10:10:52 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:26060 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbgANPKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 10:10:51 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00EFAoje004601;
        Tue, 14 Jan 2020 09:10:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=B2ewmIhlXb5TUpXO1HRhjHb7LAbvkZY4Dg5n/fEb2G0=;
 b=dZX2vwT5WSvQrmeGK02lGFbNR2ZQy21oyM3GxMKMU46Hc4ucGZVKS+5IkOAl40vpXkNm
 9PIMyZR6NRiGWwUc1dudt5FvIb1wXhxkBVvTCqAsIvA26Vy+MPhBLzQkNR/k8dU5+bLy
 Zuun6KBwWWMFEDSJVpgqc1ymwg+YDjfIDrm96MzDuOMSMyeq9qQJzNdKuWDPR9KWPwqd
 KaldwQPu+bGpQFbZddTavZ8+nKuMf7AWVvbqB/QF7HTaGOzUKPuD1VMdvF+qW4paqGY6
 eAGFsKMBOiNYqw2R53vlo0NIzqInQ8WEo2rWeTd/PaAGpskQ4J53XAF9jGfJpXN1nCSx 5g== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([5.172.152.52])
        by mx0b-001ae601.pphosted.com with ESMTP id 2xfbntvps9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Jan 2020 09:10:50 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 14 Jan
 2020 15:10:48 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Tue, 14 Jan 2020 15:10:48 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AFB442B1;
        Tue, 14 Jan 2020 15:10:48 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 1/3] mfd: cs47l15: Add missing register default
Date:   Tue, 14 Jan 2020 15:10:46 +0000
Message-ID: <20200114151048.20282-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=1 priorityscore=1501 impostorscore=0 mlxlogscore=992
 phishscore=0 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001140130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accessory detect mode 1 is missing a default, add one to the table.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

This patch can be applied separately from the other patches in the series,
if needed.

Thanks,
Charles

 drivers/mfd/cs47l15-tables.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/cs47l15-tables.c b/drivers/mfd/cs47l15-tables.c
index f81b45336690e..3c77f0a24e9bd 100644
--- a/drivers/mfd/cs47l15-tables.c
+++ b/drivers/mfd/cs47l15-tables.c
@@ -112,6 +112,7 @@ static const struct reg_default cs47l15_reg_default[] = {
 	{ 0x000001dd, 0x0011 }, /* R477 (0x1DD) - FLL AO Control 11 */
 	{ 0x00000218, 0x00e6 }, /* R536 (0x218) - Mic Bias Ctrl 1 */
 	{ 0x0000021c, 0x0222 }, /* R540 (0x21C) - Mic Bias Ctrl 5 */
+	{ 0x00000293, 0x0080 }, /* R659 (0x293) - Accessory Detect Mode 1 */
 	{ 0x00000299, 0x0000 }, /* R665 (0x299) - Headphone Detect 0 */
 	{ 0x0000029b, 0x0000 }, /* R667 (0x29B) - Headphone Detect 1 */
 	{ 0x000002a2, 0x0010 }, /* R674 (0x2A2) - Mic Detect 1 Control 0 */
-- 
2.11.0

