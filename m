Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49316C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6AA222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="r3rTHMKk";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Z1OOW0qW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgBFGLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 01:11:24 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:59742 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726778AbgBFGLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 01:11:24 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01669Nar016381;
        Wed, 5 Feb 2020 22:11:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=NdO+nKflGC6a3D3Bk7Hf5yMUu7z58dEFzZdA0vAFYdk=;
 b=r3rTHMKk3Jpe3iDTD8k+pHYMFdDttnVyo7BZxfEV9KUYwOo2gkPesJ8jQzI/qx+9g8rN
 haEpnsJXiTbZ0BuXy5oWzWy6SvoX7Sdcyz0KVfQJuWlk/FwSXi2TphhPqXCZBC6gSCZA
 ZCdYHMaHe58+kn59Vy6LV8fdkgSav5mQfQL6Krotygvbnm6xZuQwR88gkUN29QdoNK2Z
 1+O4U1CIsPj6Q5uuWQwhvu5KRjGYo0pi+VMunxSExmKPTsZ+tOx+vdtCMUurczWNSC4E
 4dEAE2q6uTps49Dcr+98tzPG6dsolSQASOgfC/JeNV194GBw8WwW2ocOY2/Gpqk2BQ7L Bg== 
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2055.outbound.protection.outlook.com [104.47.38.55])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2xyhkunraj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 22:11:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBcUTtC1K8UOrhdtHUdYwstL9gGsQhRdhKvJrPYL2qgOIZ2AobS617mJy/J354Za53q+6wgafVy9RX24kVSCs5+WK5pRmJwEybqWk/FIfbVAd4B1iuvf3Ur2yydp32RMWerCnSCw6p0HdUD06cKi1NGtOSmj/PoUa3O5/rQxROexmnV2JB+GZI+DcQW/jVoPlTlnEJds8Atkw297vGVytyQ3GQxh72WkxSgCNahUHiigZapwAbJRMcqf0Q9Fhp9RXzboAiyNL7+jDontOyRdCAgAU6R6aphx0Dx60YT+D8AExYN3kL0DdPlstZQd8vcO92+JvgNEHcsou9hTsIHQ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdO+nKflGC6a3D3Bk7Hf5yMUu7z58dEFzZdA0vAFYdk=;
 b=OXatZsJ2w7R5h9fv03uiWtpzW1aeVx8bMv6HVD0IP9ps5m+/DJCDtzcY6Ku358Z1M/4NPPWKfxZ9do4mOFQJJMi2z7gUFocqndNoIeXjfvYIJCyBIgDZqD8n6e2wS4DCfqf/gqMs1NkXJLq+5p+CH6YycLJruJrIjRX7GS4loQRY3eQtFdGrJwuI3a2+ZoEtMl8T3iPLki5dQXaDk2X8qqqYl/v2ekoi+B5P/zNXM+55BcT3y4IjzFMZSDZGYPsUDVLnrxD3/mMrmnCk3SyEQ80b/wAVz5oSJmZtBh5LOx02/XdF5K31O0fhk3KUXjuIAwTKxPBJ0jJF9E/gCFpZow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdO+nKflGC6a3D3Bk7Hf5yMUu7z58dEFzZdA0vAFYdk=;
 b=Z1OOW0qWzQnLnLC0KBGpUoK5vyapxP7e0nPWit4jpkZyoqfed4Cr2TjfKiftfy4jvBtyg+bCcNv1k0eDBibO7T7pq9xNQDN/DBr5AzPldXeVxNkRzXQ/zu2pDx6BoUGfrBYH1/5qpnr0oIcgpXS9cDtPulD+IqVH8j1RtF/M56U=
Received: from CO2PR07CA0050.namprd07.prod.outlook.com (2603:10b6:100::18) by
 DM6PR07MB4603.namprd07.prod.outlook.com (2603:10b6:5:9f::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Thu, 6 Feb 2020 06:11:11 +0000
Received: from MW2NAM12FT028.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::204) by CO2PR07CA0050.outlook.office365.com
 (2603:10b6:100::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Thu, 6 Feb 2020 06:11:11 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 MW2NAM12FT028.mail.protection.outlook.com (10.13.181.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.10 via Frontend Transport; Thu, 6 Feb 2020 06:11:10 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0166B5F0174490
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 5 Feb 2020 22:11:09 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 6 Feb 2020 07:11:03 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 6 Feb 2020 07:11:03 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0166B3mC017025;
        Thu, 6 Feb 2020 07:11:03 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0166B3Sh017024;
        Thu, 6 Feb 2020 07:11:03 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v4 01/13] dt-bindings: phy: Remove Cadence MHDP PHY dt binding
Date:   Thu, 6 Feb 2020 07:10:49 +0100
Message-ID: <1580969461-16981-2-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1580969461-16981-1-git-send-email-yamonkar@cadence.com>
References: <1580969461-16981-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(36092001)(70586007)(70206006)(5660300002)(478600001)(86362001)(81156014)(2906002)(6666004)(8676002)(8936002)(356004)(36756003)(4326008)(26005)(186003)(2616005)(107886003)(110136005)(36906005)(54906003)(336012)(42186006)(316002)(426003)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4603;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:unused.mynethost.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b305d41-1aee-49bb-7fd5-08d7aacb5cb0
X-MS-TrafficTypeDiagnostic: DM6PR07MB4603:
X-Microsoft-Antispam-PRVS: <DM6PR07MB460325625F06F6CBF907E668D21D0@DM6PR07MB4603.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-Forefront-PRVS: 0305463112
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fxr5PvvozWHSYmNsngpl8jA02cgQj1vmM9N0OQXxZjxQFUoEKkKnKCJwIpghxdDoaW8cBRQ1MgGT1DQpZgVa2bCf//JMrTNoLj3J0b7+7hn5JeEsIBCGd8gEsVk9g8tsCFpFjn1sYd3GGArPxHrmeeYHhkzg9Fl091ZCSUfcLl1X0zWdIFUBaFhYfu2oqLBWvBJrYfILzKOLnefTR0hRhUT5RzYkb/qNA+zQF++dgyEoKX92tE3RMbXnEPsxkMYEQWuVO58Q1pk8BOmJDn1wBBeImBREQ561ndMCXSdldN+plY5V9sovEDby3pLpAprx5eLVf7mSVfgR8m3jH8aj0NvIfCML8rCziJHlDSP97J1WL0wp+rLKuH9S0KEteevnkPHUWAjoWObVF3ReiEo0lAIi7wFOx8FqAQP/VxS8k8RuuClpPVm9/Ezh5IiyGHPLKHl7cwsdoiQnbbMi694gWVprybRA1FPHviGELcYHlLUTRd2Kq1dBG7Sei5EGASmv
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 06:11:10.5798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b305d41-1aee-49bb-7fd5-08d7aacb5cb0
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4603
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_06:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=924 clxscore=1015 adultscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the Cadence MHDP PHY bindings. The binding is added
in next commit in YAML format. It is renamed to adopt
torrent nomenclature.
This will not affect ABI as the driver has never been functional,
and therefore do not exist in any active use case.

Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
---
 .../bindings/phy/phy-cadence-dp.txt           | 30 -------------------
 1 file changed, 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-dp.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt b/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
deleted file mode 100644
index 7f49fd54ebc1..000000000000
--- a/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Cadence MHDP DisplayPort SD0801 PHY binding
-===========================================
-
-This binding describes the Cadence SD0801 PHY hardware included with
-the Cadence MHDP DisplayPort controller.
-
--------------------------------------------------------------------------------
-Required properties (controller (parent) node):
-- compatible	: Should be "cdns,dp-phy"
-- reg		: Defines the following sets of registers in the parent
-		  mhdp device:
-			- Offset of the DPTX PHY configuration registers
-			- Offset of the SD0801 PHY configuration registers
-- #phy-cells	: from the generic PHY bindings, must be 0.
-
-Optional properties:
-- num_lanes	: Number of DisplayPort lanes to use (1, 2 or 4)
-- max_bit_rate	: Maximum DisplayPort link bit rate to use, in Mbps (2160,
-		  2430, 2700, 3240, 4320, 5400 or 8100)
--------------------------------------------------------------------------------
-
-Example:
-	dp_phy: phy@f0fb030a00 {
-		compatible = "cdns,dp-phy";
-		reg = <0xf0 0xfb030a00 0x0 0x00000040>,
-		      <0xf0 0xfb500000 0x0 0x00100000>;
-		num_lanes = <4>;
-		max_bit_rate = <8100>;
-		#phy-cells = <0>;
-	};
-- 
2.20.1

