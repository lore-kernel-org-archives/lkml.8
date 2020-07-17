Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE57C433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8011820734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="PWa2Id8g";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="65qKc/fG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgGQGuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 02:50:52 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:60416 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726893AbgGQGuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 02:50:51 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06H6mar0022003;
        Thu, 16 Jul 2020 23:50:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=pb1QWkTf3l7pU5xx7R/S4AaU6DX72chNJJNB6OP66Oc=;
 b=PWa2Id8gjbgXXQShKne/w4PPqd9PynV6AMTLIbZRIf2EFAQXEum8qBNc8eAE/05cZ1q2
 RE2oKMGS10DKXoFmf5SjAyxs108RXyLg9iFZihW4RUFpF5lgxJQM1nO7aNjWwTi4wnoD
 1o4USu7a1Tg4bAp1iigv0nnXFBpbkjZhnzE/cWJKuSFemwdO1poHnh8o7SEHWlnUWoXv
 cMWi8XC6X5QIDrgiy57ZpZ0M5t5g1IAgeMzCTExkYBpJ0L030CCLrP2d6wOSh2wEKKzz
 J+kdopiiLflpDFTpvrpucZOMgJAAokNrm8sr3CrhqmQYxiSBVQSsHW/g1KIjlfKGVsVP mg== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2055.outbound.protection.outlook.com [104.47.37.55])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3279yux5qy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 23:50:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kj2qtZwbAtoXWuHPvnbFDpSBmYLWmNGwL2CwSnULE7GKLaJPzNkltBm99fAR90qsYPi8DXE0xGNAWn6uBleF9YKG4Pa0M/Tx2dnondkU1pwU9oyuOsQaDqvNkBWNdZ8EaoqKVSzmQ8b+rl3IuClp6RKV35MXQ+CbQTkJ7g7DTx8sLG2SzJk3IP4oQV1nIOoZq9tdiQw7pJUd98t3NmNybrwRNydKcNyhID/lxcgbuPtM2owBsIdfODsYnIhDBHEer8c9Ed3hD5SXSnwFiVF9nraF21wPbrdbxAkBhdTCgluYszQUFNKAJbuLjg2YJGDSpBanS8xtGzv/+7RhuBqcpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pb1QWkTf3l7pU5xx7R/S4AaU6DX72chNJJNB6OP66Oc=;
 b=OPbszGkCJ05oG94H+qcEtuAIUexWL7PL0fBKc0He3/N/Afs/kzCnjYZgldIr1I1cg+tQf4XJBc0N0qtv8y9I7+mjNyQlpb0jvRigX/RBm0rpyB2lzowLlldLYS/yiNpHRvlS/qPbliremgM5dOp16C9BBXvyQniKyIO7bms9+k7XzM3lbWBKfIO60eo0lpQ17Wm3iM6kVf+wHBauVn8YLX9C750L7QXptbsXM+CCWuXXFCaAV6aCNrJLCo3zGybEMIFOAanDnkgJBAQ+tLypujPncukDiZrTM35PSCuaKDLeQqy7hGUIwazyllGMsvqIoUpUDNZDWt5qGecU/SxC6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pb1QWkTf3l7pU5xx7R/S4AaU6DX72chNJJNB6OP66Oc=;
 b=65qKc/fGX5NeqPdHFY4UYyd4QI54yufvMsg6dOjvGrY3bH9dc1XEZjCadRpI2jzNOEhRJwqdsrc5Jn6bvckI/+HUIg5bDw6hWRO3sn1NPLn/tXgmiT1XYG9j/M3Viytjp6h9AlWVzUR3r7+3m1pCxhAARbSF8tOMIEAUPOGtueo=
Received: from MW3PR05CA0003.namprd05.prod.outlook.com (2603:10b6:303:2b::8)
 by SN1PR07MB3919.namprd07.prod.outlook.com (2603:10b6:802:2c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 17 Jul
 2020 06:50:41 +0000
Received: from MW2NAM12FT030.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::92) by MW3PR05CA0003.outlook.office365.com
 (2603:10b6:303:2b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.9 via Frontend
 Transport; Fri, 17 Jul 2020 06:50:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 MW2NAM12FT030.mail.protection.outlook.com (10.13.181.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.9 via Frontend Transport; Fri, 17 Jul 2020 06:50:40 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 06H6oYLr016347
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 17 Jul 2020 02:50:38 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 17 Jul 2020 08:50:34 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 17 Jul 2020 08:50:34 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 06H6oX8c012577;
        Fri, 17 Jul 2020 08:50:33 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 06H6oXxU012572;
        Fri, 17 Jul 2020 08:50:33 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>, <maxime@cerno.tech>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <nsekhar@ti.com>, <tomi.valkeinen@ti.com>,
        <jsarha@ti.com>, <praneeth@ti.com>
Subject: [PATCH v4 0/2] Add new PHY APIs to framework to get/set PHY attributes
Date:   Fri, 17 Jul 2020 08:50:31 +0200
Message-ID: <1594968633-12535-1-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(36092001)(46966005)(2906002)(966005)(36906005)(110136005)(478600001)(316002)(54906003)(186003)(356005)(70206006)(8936002)(426003)(82310400002)(26005)(2616005)(8676002)(336012)(42186006)(70586007)(81166007)(36756003)(82740400003)(86362001)(5660300002)(4326008)(47076004);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cc0b679-6611-4d0e-53c0-08d82a1db850
X-MS-TrafficTypeDiagnostic: SN1PR07MB3919:
X-Microsoft-Antispam-PRVS: <SN1PR07MB3919DE4A68F9F84EBDBD06E1C57C0@SN1PR07MB3919.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wHqY4ZY3EBb3UuTuUgnGzOq/umV8uOxRZz71AYesp+me5l0BfXDT4d/df37M6qfHfFPM90v12D0rQtkmZtA4JgBSvM25MNAdYQr4e1fhmTRuc9K17+X//J6Z5yVRLvcBh8msxxYY2n+iy+r9osGCtA3mhqVg8TaQwGTFOzEZ6bKM5WbgTzUynm52h4Eh83Nt3IMglhlcs9b4afyBMNIpLrEN85LuWtmBFgctf0iJALjydmXlTosYa8R/RDZtOO/3UbGGbCWoCIsqbnvSloQhUbjlHaXVGDhJvuK21YZjJDLQyulW6Ozsrzu594N30fj3AA8AdqflzeeQ+z2yRWJkKcL1kC/Pwg8c1xtb9QC/U2HN49jbARyvdOJWTRjMhwJBgh2RtBDmHE1czejzoPPnkK9V9giYcdJXKpA1ftmI52aHWxRDUs6Zrhveq+jEgNz5PUtDVvFXdKYedKmHMSSsibpMD0Fb43nO2gdIwPV1n7XmaJa2SktKNyFjST2IXIKh
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 06:50:40.6106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc0b679-6611-4d0e-53c0-08d82a1db850
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT030.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR07MB3919
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-17_04:2020-07-16,2020-07-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 mlxlogscore=633
 mlxscore=0 phishscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007170052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a new pair of PHY APIs that can be used to get/set
all the PHY attributes. It also adds a new PHY attribute max_link_rate.

It includes following patches:

1. v4-0001-phy-Add-new-PHY-attribute-max_link_rate-and-APIs-.patch
This patch adds max_link_rate as a new PHY attribute along with a pair of
APIs that allow using the generic PHY subsystem to get/set PHY attributes
supported by the PHY.

2. v4-0002-phy-cadence-torrent-Use-kernel-PHY-API-to-set-PHY.patch
This patch uses PHY API phy_set_attrs() to set corresponding PHY properties
in Cadence Torrent PHY driver. This will enable drivers using this PHY to
read these properties using PHY framework.

The phy_get_attrs() API will be used in the DRM bridge driver [1] which is
in the process of upstreaming.

[1]

https://lkml.org/lkml/2020/2/26/263

Version History:

v4:
    - Protect phy_get_attrs/phy_set_attrs APIs with mutex

v3:
    - Add comment describing new PHY attribute max_link_rate
    - Use of memcpy to copy structure members
    - Change commit log a bit

v2:
    - Implemented single pair of functions to get/set all PHY attributes

Swapnil Jakhade (2):
  phy: Add new PHY attribute max_link_rate and APIs to get/set PHY
    attributes
  phy: cadence-torrent: Use kernel PHY API to set PHY attributes

 drivers/phy/cadence/phy-cadence-torrent.c |  7 ++++++
 include/linux/phy/phy.h                   | 26 +++++++++++++++++++++++
 2 files changed, 33 insertions(+)

-- 
2.26.1

