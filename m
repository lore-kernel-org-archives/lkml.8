Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6918EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A36320643
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="oEneF3BR";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="1Z37e8mg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgERMPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 08:15:09 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:64506 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726448AbgERMPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 08:15:08 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04IC7HiC021362;
        Mon, 18 May 2020 05:15:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=pFzFDkUXgNiKByTaVxiRCYh++HgTdr9qJgoZEWQVR6o=;
 b=oEneF3BRXfxVfV7o1h02zsWZfG8nrWKPa7UtorYDVIYNVtl+Z/0fSciRKqEw9Rnu4XQ8
 ikT4uFkEVbkxQwrIgvm6yZr8OEFWn954r9gGf82g+z6gfLbS6hU96waLYFk+aAo7HolD
 T2CAf26APGZgaIc++r8JtXM+BWQWJsjUCUqs29lrygDbculTHeTsEv1yKIAvqTCw9u2p
 qSm5nxSbwkv446v5Ou9nMXT9PwkeSmkAHRktOuYCe8R+O46ySwkiY0epgqkJnl6fXXyC
 4ByRAkg82gKocKlFCM27ExqUZMIopDpKaZWqujLKsVjM3U1Z0YO/EE/xd/RdPSgqztUK Cw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-0014ca01.pphosted.com with ESMTP id 312cqy6hk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 05:15:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9MeEi+/5wTK9TqPPCKSg15F22noup/rAl0duvSGLOdecKlgPDjGAzmxExBp3z/xS1Ie/aXxlNRcNMt2l/EcalnrNwvqd207p0NnLbr8g12h2Lqm7BUyE0MXWcERTfV290EJcY1eYxtMgiRme/JamBBXl3Fq02y92E88or7uNwSwA/ZPqyNsn0ctdqkLpb0VVm+XGHjyC7PqpYpexgsGdyvid4zR385PBpqugGexvOCjqop9V2Ajub6WiN6U5woMDNQ5l9UTaoihg5AnMm9B/0lqENjRrlaUmpPKO2yuFGVtI1Q+HF7+rsOJcMPMT3YmQrG+bY5Aa0ab77sUjAYk0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFzFDkUXgNiKByTaVxiRCYh++HgTdr9qJgoZEWQVR6o=;
 b=lE9olzzwyB4BUT0IXnVYWQI8qCYdiCcAmG2hcRIUz0eTlxaC8Orq0tGHKvgSpUYWgE8bnkFFc6saoh1dh8fbW/pzcfOnq46hf8blBX/8jq22q9kPAq+tukUkTfxzgVSyjxsfy1gzmo89KNJMmPUHfxCTUxBw/DvfyIal51SUr2TudvVFDBcVqh1xaKxGsjo/ZuuaH9/JiuSLtOw71PpcB0RDWyK/R3+Rn35kchMrvZolzjx1JWAQn22F+KnZIhRc5QaUUV6FsMdlZEVf+SZXzpkUaVlGO7cSBvFQxlRIrbgSuiK8dCv5vlhoDeH8lQVzMVE8vv22Kit74UFH45qpPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFzFDkUXgNiKByTaVxiRCYh++HgTdr9qJgoZEWQVR6o=;
 b=1Z37e8mgHnGRbyeTojxsl4TZ9GigZGW4vJeXiBVaocUzvSSjiJLg6RZM4SpIjRur9oHJTjl59XNHaKhVP6F8NREVYHWajkT1gaCQybmgQGucblfEMYnxZ+YCVtNayZJhuASF5G3hlD7iZk8ZNNMhbOz3zH9oDIpYn6zh90b+dJ4=
Received: from BN3PR03CA0052.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::12) by SN6PR07MB4477.namprd07.prod.outlook.com
 (2603:10b6:805:5d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 12:14:57 +0000
Received: from BN8NAM12FT064.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:7a4d:cafe::21) by BN3PR03CA0052.outlook.office365.com
 (2a01:111:e400:7a4d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26 via Frontend
 Transport; Mon, 18 May 2020 12:14:57 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT064.mail.protection.outlook.com (10.13.182.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.11 via Frontend Transport; Mon, 18 May 2020 12:14:56 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 04ICErZQ027990
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 18 May 2020 08:14:55 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 18 May 2020 14:14:53 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 18 May 2020 14:14:53 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 04ICErW9014682;
        Mon, 18 May 2020 14:14:53 +0200
Received: (from sparmar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 04ICEq1D014673;
        Mon, 18 May 2020 14:14:52 +0200
From:   Sanket Parmar <sparmar@cadence.com>
To:     <kishon@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <rogerq@ti.com>,
        <vkoul@kernel.org>, <sjakhade@cadence.com>, <kurahul@cadence.com>,
        <pawell@cadence.com>, <jpawar@cadence.com>, <nsekhar@ti.com>,
        Sanket Parmar <sparmar@cadence.com>
Subject: [PATCH] phy: cadence: sierra: Fix for USB3 U1/U2 state
Date:   Mon, 18 May 2020 14:14:13 +0200
Message-ID: <1589804053-14302-1-git-send-email-sparmar@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(36092001)(46966005)(4326008)(8936002)(70206006)(6666004)(47076004)(81166007)(82740400003)(70586007)(356005)(82310400002)(8676002)(26005)(86362001)(107886003)(54906003)(36756003)(6916009)(426003)(186003)(2616005)(316002)(478600001)(36906005)(42186006)(336012)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4c37f7b-ecb1-4505-d0ea-08d7fb25142c
X-MS-TrafficTypeDiagnostic: SN6PR07MB4477:
X-Microsoft-Antispam-PRVS: <SN6PR07MB44778954B9A0A4ED0AED72E9B0B80@SN6PR07MB4477.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:196;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cdmW+a/sACtRmZYLSYlRHEuniEv1Uv5fHBShNxoP9Pn4KRIz03pWZw6zueKmPhQT41ujR1t+DnsadPtC+/VQzG1C8Rnd9DMHnyvG+CMbuGzVo/GpeTSB6RP7Eaj0z4mfyA+qP0np5UsYB6T/881bunIZdHo1RIT55bRR93R9nR0xM9T+f59lED/mzRg9xo79bsq+8rtoI4m23ZYpSttA/UXTvDpcT8lRvEUtRGko2iNmKWXdOFq6JQKMtu7dv182itJBPY5nD7/37PJN+4A5NwjCj2oO0V857yPlJcvQ6OJLizymC1HoGOoMe5uV4burDWYjimR0eEayxu/MyPkeibeBoJA2v92YPiyHFesWSSd0GEY+5Rf4qijhoVwVUSA6Ex7nhuj12Y3ZADyXssuWggxNOe3Cyc+rYG/Tfl8iDHmOk75rkB6Owp762fzI/Om8/NLtc7I7yFEyYxtj+4G9qjsCKKsW0JWXnIBvXIYz519IBrUyytCllCaQ1vRPBnfoPEdlPOjgEC6Qck6APFV3LMnBjW7N/up4acuYuC/T9i4=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 12:14:56.6807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c37f7b-ecb1-4505-d0ea-08d7fb25142c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4477
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-18_05:2020-05-15,2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 spamscore=0 cotscore=-2147483648 impostorscore=0
 mlxlogscore=734 phishscore=0 clxscore=1011 mlxscore=0 priorityscore=1501
 malwarescore=0 suspectscore=1 bulkscore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005180111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated values of USB3 related Sierra PHY registers.
This change fixes USB3 device disconnect issue observed
while enternig U1/U2 state.

Signed-off-by: Sanket Parmar <sparmar@cadence.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index a5c08e5..faed652 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -685,10 +685,10 @@ static struct cdns_reg_pairs cdns_usb_cmn_regs_ext_ssc[] = {
 static struct cdns_reg_pairs cdns_usb_ln_regs_ext_ssc[] = {
 	{0xFE0A, SIERRA_DET_STANDEC_A_PREG},
 	{0x000F, SIERRA_DET_STANDEC_B_PREG},
-	{0x00A5, SIERRA_DET_STANDEC_C_PREG},
+	{0x55A5, SIERRA_DET_STANDEC_C_PREG},
 	{0x69ad, SIERRA_DET_STANDEC_D_PREG},
 	{0x0241, SIERRA_DET_STANDEC_E_PREG},
-	{0x0010, SIERRA_PSM_LANECAL_DLY_A1_RESETS_PREG},
+	{0x0110, SIERRA_PSM_LANECAL_DLY_A1_RESETS_PREG},
 	{0x0014, SIERRA_PSM_A0IN_TMR_PREG},
 	{0xCF00, SIERRA_PSM_DIAG_PREG},
 	{0x001F, SIERRA_PSC_TX_A0_PREG},
@@ -696,7 +696,7 @@ static struct cdns_reg_pairs cdns_usb_ln_regs_ext_ssc[] = {
 	{0x0003, SIERRA_PSC_TX_A2_PREG},
 	{0x0003, SIERRA_PSC_TX_A3_PREG},
 	{0x0FFF, SIERRA_PSC_RX_A0_PREG},
-	{0x0619, SIERRA_PSC_RX_A1_PREG},
+	{0x0003, SIERRA_PSC_RX_A1_PREG},
 	{0x0003, SIERRA_PSC_RX_A2_PREG},
 	{0x0001, SIERRA_PSC_RX_A3_PREG},
 	{0x0001, SIERRA_PLLCTRL_SUBRATE_PREG},
@@ -705,19 +705,19 @@ static struct cdns_reg_pairs cdns_usb_ln_regs_ext_ssc[] = {
 	{0x00CA, SIERRA_CLKPATH_BIASTRIM_PREG},
 	{0x2512, SIERRA_DFE_BIASTRIM_PREG},
 	{0x0000, SIERRA_DRVCTRL_ATTEN_PREG},
-	{0x873E, SIERRA_CLKPATHCTRL_TMR_PREG},
-	{0x03CF, SIERRA_RX_CREQ_FLTR_A_MODE1_PREG},
-	{0x01CE, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
+	{0x823E, SIERRA_CLKPATHCTRL_TMR_PREG},
+	{0x078F, SIERRA_RX_CREQ_FLTR_A_MODE1_PREG},
+	{0x078F, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
 	{0x7B3C, SIERRA_CREQ_CCLKDET_MODE01_PREG},
-	{0x033F, SIERRA_RX_CTLE_MAINTENANCE_PREG},
+	{0x023C, SIERRA_RX_CTLE_MAINTENANCE_PREG},
 	{0x3232, SIERRA_CREQ_FSMCLK_SEL_PREG},
 	{0x0000, SIERRA_CREQ_EQ_CTRL_PREG},
-	{0x8000, SIERRA_CREQ_SPARE_PREG},
+	{0x0000, SIERRA_CREQ_SPARE_PREG},
 	{0xCC44, SIERRA_CREQ_EQ_OPEN_EYE_THRESH_PREG},
-	{0x8453, SIERRA_CTLELUT_CTRL_PREG},
-	{0x4110, SIERRA_DFE_ECMP_RATESEL_PREG},
-	{0x4110, SIERRA_DFE_SMP_RATESEL_PREG},
-	{0x0002, SIERRA_DEQ_PHALIGN_CTRL},
+	{0x8452, SIERRA_CTLELUT_CTRL_PREG},
+	{0x4121, SIERRA_DFE_ECMP_RATESEL_PREG},
+	{0x4121, SIERRA_DFE_SMP_RATESEL_PREG},
+	{0x0003, SIERRA_DEQ_PHALIGN_CTRL},
 	{0x3200, SIERRA_DEQ_CONCUR_CTRL1_PREG},
 	{0x5064, SIERRA_DEQ_CONCUR_CTRL2_PREG},
 	{0x0030, SIERRA_DEQ_EPIPWR_CTRL2_PREG},
@@ -725,7 +725,7 @@ static struct cdns_reg_pairs cdns_usb_ln_regs_ext_ssc[] = {
 	{0x5A5A, SIERRA_DEQ_ERRCMP_CTRL_PREG},
 	{0x02F5, SIERRA_DEQ_OFFSET_CTRL_PREG},
 	{0x02F5, SIERRA_DEQ_GAIN_CTRL_PREG},
-	{0x9A8A, SIERRA_DEQ_VGATUNE_CTRL_PREG},
+	{0x9999, SIERRA_DEQ_VGATUNE_CTRL_PREG},
 	{0x0014, SIERRA_DEQ_GLUT0},
 	{0x0014, SIERRA_DEQ_GLUT1},
 	{0x0014, SIERRA_DEQ_GLUT2},
@@ -772,6 +772,7 @@ static struct cdns_reg_pairs cdns_usb_ln_regs_ext_ssc[] = {
 	{0x000F, SIERRA_LFPSFILT_NS_PREG},
 	{0x0009, SIERRA_LFPSFILT_RD_PREG},
 	{0x0001, SIERRA_LFPSFILT_MP_PREG},
+	{0x6013, SIERRA_SIGDET_SUPPORT_PREG},
 	{0x8013, SIERRA_SDFILT_H2L_A_PREG},
 	{0x8009, SIERRA_SDFILT_L2H_PREG},
 	{0x0024, SIERRA_RXBUFFER_CTLECTRL_PREG},
-- 
2.4.5

