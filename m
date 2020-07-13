Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A7BC433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDE1220758
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="mz/FmSZF";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="YaS1+BgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbgGMKHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 06:07:06 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:41220 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727035AbgGMKGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 06:06:33 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06DA2BJS014737;
        Mon, 13 Jul 2020 03:06:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=rdQONh4CY1EV94jM0VuQyufyzyyqDd27dwJDoPPf5Ro=;
 b=mz/FmSZFTUmOLTotGX2Dzdp6gGjlU8Wuru8Li2ktRLm/03XVD611VKaTF56MUjCGLePT
 DIu3US29r2We3JniATTVtFIy0xYpzvw+QXRu03TK9TwDebNlhuWT8zjRq0sj7evTLxcB
 w9/qht/ToJlhZFs/S3GZz6uiTeU68ZwWLAb0SK1sKEwIAPPwSMI0ZfrOd5SPsr5DIJXx
 yVG/MaMIIpBGVbgcR7LMjcI+NnCvFaBAtF9CNxq7qxIkQNPrZSOZ+meHLsuLp1Tmbqjk
 9eldkVpUyjzfNfUI7Iyo802HHcmyg62ycqvdAoCAw3p0IXqvHSy5+gKFCQhQlE8Jcpq9 Hg== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by mx0b-0014ca01.pphosted.com with ESMTP id 328ftugxdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 03:06:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaGhtK9/jEy188DswnHLNc5uKbQSB1OpBDslVluB0GyjD/6NqUQj3dG/Cn1cCybiSPmHLPminV5jcQ8Y8g52EC/hwoI8I2au2h5RIZnfXJmj6fOXK/yjUDewcbDUOoTN/P57JVCToUAy4qyPzLhowa2ifS/uTxB9tf+jRvMPgfQ0NMY11/ES5yQ0S2jMY3BOp22qftkAu1nfYaJMvxsfEojhgjz5qI0NC+MPIhTLBNSgNl2X8EzbuTBeIqFSZDo81MI2Va9P9YJgepOtlMh0VHN5MrlCc/fIrV5Z71oDj+QbkSr1eisUXK9YIKBjnWaW3+AVVZLjxof/WQtF+Xetyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdQONh4CY1EV94jM0VuQyufyzyyqDd27dwJDoPPf5Ro=;
 b=OlqgqRN4RgJEBbQ7Qdrwg6tTHMRd7T6EnBKs1fBXspOnK/ubQirQaTefAP+Xh8ILQIQzTVxcu1dpWKsw9U7Jut7XYl/wUawBTsgMtjq2EzJheDpL/OFfp0e77aSUHSHpHtQlnZ1udIcEsvCMtIPiH/dtXcAgN3zSJkds6utI+MxsXO7xp7DePP/S37D5bRNIQWIgsUxXCy1JR1cucYDLVSnTV4Q+/U3EMUrN72omNhtD98ZsKCK/7rOHzxHEhGIbc9/aM5MddW6Xp93ag0Vc2T6QkIOSHfo13Z4Q9z2/ZI1Zn1mWRa2QpJcBo/gSsqMmismWoQP7FswJ51/Un4rlkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdQONh4CY1EV94jM0VuQyufyzyyqDd27dwJDoPPf5Ro=;
 b=YaS1+BgMe6CU6MBgSmixKMVRpo91nH6DicWsq/1RQoF3acqSkzaDCAU691ctIg1r/B2vSk6WoZYiOtkJVPBgvS26CdWbl9bSlwuOp3RUYuVfKwiTWc4MqaNG9Ux808gFSs5d/T31TJ2LKL44UhBBwPkp7vwj/nwS/zqS6wRG8e0=
Received: from DM5PR20CA0013.namprd20.prod.outlook.com (2603:10b6:3:93::23) by
 BN8PR07MB7075.namprd07.prod.outlook.com (2603:10b6:408:d6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21; Mon, 13 Jul 2020 10:06:11 +0000
Received: from DM6NAM12FT016.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::93) by DM5PR20CA0013.outlook.office365.com
 (2603:10b6:3:93::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend
 Transport; Mon, 13 Jul 2020 10:06:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT016.mail.protection.outlook.com (10.13.178.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Mon, 13 Jul 2020 10:06:11 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 06DA63Ys013926
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 13 Jul 2020 06:06:09 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 13 Jul 2020 12:06:03 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 13 Jul 2020 12:06:03 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 06DA63kR028641;
        Mon, 13 Jul 2020 12:06:03 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 06DA63OL028640;
        Mon, 13 Jul 2020 12:06:03 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rogerq@ti.com>, <peter.chen@nxp.com>
CC:     <dan.carpenter@oracle.com>, <heikki.krogerus@linux.intel.com>,
        <colin.king@canonical.com>, <jpawar@cadence.com>,
        <ben.dooks@codethink.co.uk>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2 4/9] usb: cdns3: drd: return IRQ_NONE explicitly.
Date:   Mon, 13 Jul 2020 12:05:49 +0200
Message-ID: <20200713100554.28530-5-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200713100554.28530-1-pawell@cadence.com>
References: <20200713100554.28530-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(36092001)(46966005)(82310400002)(8676002)(70206006)(70586007)(426003)(6666004)(86362001)(81166007)(4326008)(356005)(5660300002)(186003)(36906005)(478600001)(8936002)(2616005)(7416002)(336012)(107886003)(316002)(36756003)(26005)(110136005)(54906003)(83380400001)(47076004)(82740400003)(42186006)(4744005)(2906002)(1076003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55f83c1c-20d5-45ab-ffcf-08d827145e7e
X-MS-TrafficTypeDiagnostic: BN8PR07MB7075:
X-Microsoft-Antispam-PRVS: <BN8PR07MB707554FC6560881A6A88A0D8DD600@BN8PR07MB7075.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:469;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eHlvDHrJ1zYHJBahJDLrc3I9pQdGgBkd5oKRwGWK+Spwx+tEtjLgFIDupushKTYE4/I8YS9b35WZhU65kmQfIeYXrxk4kk1TVhrEHFRvkZU5vn8Wt981LPOwT2lgR4f4EnBCmy8aI+Yavn8tl72Z7roHRA0rBaFbpi9bqMNuIj70HCa+fx6LRF2JTg+o6xx4ED0nSDwjZ9WjB2s5bmRI5NP4ezWqigMNWgO3ZcwyJf2cIAGW3CNVbYt5HZz6xCOc19btR228P3YfAQPYrTJth8diSPtSytIv3zJbw3Qlr6UXwqTRLyU03Ymhia3PjxzhYVQ82lMXjGSjQjGMEANB+lrLMJ00Gt5bJbLR6eudEkoDM63ZUcrPhEetaRapfj+BdklW2554DNm/d5OjZvtT67utsWoHiFHExoW3QmO9lgI=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 10:06:11.0356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f83c1c-20d5-45ab-ffcf-08d827145e7e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT016.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB7075
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_07:2020-07-10,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=574
 mlxscore=0 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007130075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQ_NONE can be returned indirect.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/drd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index 6d2da504ad49..05a9f7d54c46 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -279,12 +279,12 @@ static irqreturn_t cdns3_drd_irq(int irq, void *data)
 	u32 reg;
 
 	if (cdns->dr_mode != USB_DR_MODE_OTG)
-		return ret;
+		return IRQ_NONE;
 
 	reg = readl(&cdns->otg_regs->ivect);
 
 	if (!reg)
-		return ret;
+		return IRQ_NONE;
 
 	if (reg & OTGIEN_ID_CHANGE_INT) {
 		dev_dbg(cdns->dev, "OTG IRQ: new ID: %d\n",
-- 
2.17.1

