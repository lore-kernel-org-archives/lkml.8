Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA1DC3B184
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A65C21835
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ge1Z10G6";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="D1bv9oh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgBJJ5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 04:57:03 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:49062 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726118AbgBJJ5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 04:57:02 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01A9rYiO031851;
        Mon, 10 Feb 2020 01:56:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=gxRHML1FZpKac5PWW1t3eP0QoXXPGZcBWFSP2+LCBCg=;
 b=ge1Z10G6MoG3JGfYDRMLci0Qx24rCBSlphhYU0MewQeNLsy+MKzpmd5TEujuYLqwJZZb
 mIaugM+ATyjZSYw2I1XGJ1b4lwzqAhz7cVrk3IdZMQSgykMgF1WndOYc/4AsrCx+v+uM
 aOlrddBlGv4LxJMyAm0RK6hSFGFGd+hl9AD9nhrg2O39DrzLf5BoYXNuU8VCOiDRMKZZ
 zMI4OTti89niCxQdvfJLem+hc4Lk1/bQ+TJEDLEnHE5wZsZwSGNhXT3ELRXaBO+HZkav
 ZScHIGh8I5CS8lQAt8CIiJTIRnFLA1ZQ275g86HMWS7Q6v88xk6CIjz9Z/uWZ+0dQZgh jw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2y1u17d9eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Feb 2020 01:56:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQVOQzZh/n4hQacwei40l0deeWFvJxXD492sQbHQGoVUpXPxmSCwFIOwxTBj3t28G4iG/R0NF1cobXfd4AbscG2oyUhWd6/BMHGhYx0hWaWibPl3dcNi7BlM/HbLTa1BX2gE2CzHhbEe7Rjy+8BCY6Y+gkVz8aDneIjAmX5sMGoB2JScfUy9e04OFfCsEKFZV2TH96lwP64B4SNm+4W1QDe3HhbnyivlyvqRkJEK4r+5BsBtpTkyN8dwNtHK4ttkEfYnxVlatQklnAOMGvfpemZ/g3Afq+rl6eBpk5pN8O0WSUE3fhDga0miyf0KqOkW9tfGVyI5lf2X5Ud49AOC3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxRHML1FZpKac5PWW1t3eP0QoXXPGZcBWFSP2+LCBCg=;
 b=lWggTNz5DSxDA+CleQYg5D+gDgGmj5YjjcstOlO9yrPGw3hioO/KdzHIIQb+KZAYAQB3H71sTQfYNlpNzdeYGm24wJhNf152Im0FswJZFtI9j2TqUBWyEHsFa+eMHP+yq+AaMfv520llKanfWQt3qXIvjnNhB4SpR3eU9pKB0Cp+YJH5S4lHZZ67rCObw7n5/3NMFknfhM3tZ0mzR5rNUDDwBT7JzmQj6zuKOnBL3o23CsouYr8nkQxeLtssMQii/utbkYHoRCokIfA53SC7sCbhnYB5uWOe//jT/UUCJRmkUmrsEvIEBghWuBNB/t5amsUDWu+P7BSySz+Pfnfp2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.28) smtp.rcpttodomain=nod.at smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxRHML1FZpKac5PWW1t3eP0QoXXPGZcBWFSP2+LCBCg=;
 b=D1bv9oh/hQ5715Nmg9Bp2rmHIqGwmph/aKAZR49zttZVHcJs34aSSDJelcfI3Xd17aLKw97/QxncNx+5PguOCm20VUMOhAqmP+YS4q7LF11xSvURFa5rWC1Pst9BPNiy+MF9Me16jbtNjxc/fi1HYwQPNdGViWS2SUKfZKRn0Y4=
Received: from CO2PR07CA0065.namprd07.prod.outlook.com (2603:10b6:100::33) by
 BN8PR07MB6833.namprd07.prod.outlook.com (2603:10b6:408:b6::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.28; Mon, 10 Feb 2020 09:56:40 +0000
Received: from MW2NAM12FT037.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::208) by CO2PR07CA0065.outlook.office365.com
 (2603:10b6:100::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Mon, 10 Feb 2020 09:56:39 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.28; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 MW2NAM12FT037.mail.protection.outlook.com (10.13.180.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.10 via Frontend Transport; Mon, 10 Feb 2020 09:56:38 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 01A9uXCf010151
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 10 Feb 2020 01:56:37 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 10 Feb 2020 10:56:36 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 10 Feb 2020 10:56:36 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 01A9ua2O030266;
        Mon, 10 Feb 2020 10:56:36 +0100
Received: (from piotrs@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 01A9uaRu030265;
        Mon, 10 Feb 2020 10:56:36 +0100
From:   Piotr Sroka <piotrs@cadence.com>
CC:     Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] mtd: rawnand: cadence: change bad block marker size
Date:   Mon, 10 Feb 2020 10:55:27 +0100
Message-ID: <1581328530-29966-3-git-send-email-piotrs@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1581328530-29966-1-git-send-email-piotrs@cadence.com>
References: <1581328530-29966-1-git-send-email-piotrs@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(376002)(199004)(189003)(36092001)(246002)(2616005)(316002)(5660300002)(42186006)(2906002)(54906003)(426003)(336012)(186003)(26005)(356004)(6666004)(36756003)(7636002)(70586007)(70206006)(8676002)(8936002)(26826003)(86362001)(478600001)(109986005)(4326008)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR07MB6833;H:sjmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:corp.Cadence.COM;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4424a400-bf2c-4929-13ab-08d7ae0f85c2
X-MS-TrafficTypeDiagnostic: BN8PR07MB6833:
X-Microsoft-Antispam-PRVS: <BN8PR07MB68330322A324DC9BF845B36ADD190@BN8PR07MB6833.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-Forefront-PRVS: 03094A4065
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jskDBg4KM6rmzfhhSEcVDCIkkFDOgNZ8YC0khWd+xiWP/991UYR707BRVpSMwzH2QZRdrHWmVg9cIRkRCcQ7PXjVeZjWGm5kZQ6d/M4fLl5kYMaOgl4f5IXHC/woKSqJ/hbxc9OBOCOARFCudCHVDJSV+4yw8qCT5m8kiB/9ESamFxtdWkWH+VnrSyrh4XyE2xpNXAsqUQR6RSlpeueTGj9X3V1ayDZI7VNOZh7Q4wxsZAzuzVWIjJd3IDxug5bdicFwaRtQxKz4iIkTtqdYJqLPBT+jPiWCdGMc81QxQXZ4LTGir2PXsiSBUFSK6MerkH3BJfNe8rGbpTlN1KbnyiQHE8zGnjzp6zO2m4ubFour3iDMyvfIb1F/QGBcSTOe00SoP2whPs3Jlslm40162o+0+fGno9DylsnuXwVWE9u6HpWsQK6t7p+Y8A1sop+7W2Sf7C6ylB2y9PXBMwN5E4TBmp+SxxKm1SseS8WMigRP8P99H5s9zY+GRfdamKhompCPwVg7bpzkq71W3kPicg==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2020 09:56:38.7456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4424a400-bf2c-4929-13ab-08d7ae0f85c2
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB6833
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_02:2020-02-07,2020-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=905 clxscore=1015 mlxscore=0 suspectscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002100077
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Increase bad block marker size from one byte to two bytes.
Bad block marker is handled by skip bytes feature of HPNFC.
Controller excpects this value to be an even number.

Signed-off-by: Piotr Sroka <piotrs@cadence.com>
---
 drivers/mtd/nand/raw/cadence-nand-controller.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index 2ebfd0934739..5c1bbb05ab51 100644
--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -2612,12 +2612,9 @@ int cadence_nand_attach_chip(struct nand_chip *chip)
 	chip->options |= NAND_NO_SUBPAGE_WRITE;
 
 	cdns_chip->bbm_offs = chip->badblockpos;
-	if (chip->options & NAND_BUSWIDTH_16) {
-		cdns_chip->bbm_offs &= ~0x01;
-		cdns_chip->bbm_len = 2;
-	} else {
-		cdns_chip->bbm_len = 1;
-	}
+	cdns_chip->bbm_offs &= ~0x01;
+	/* this value should be even number */
+	cdns_chip->bbm_len = 2;
 
 	ret = nand_ecc_choose_conf(chip,
 				   &cdns_ctrl->ecc_caps,
-- 
2.17.1

