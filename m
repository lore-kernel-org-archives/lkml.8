Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75548C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 474A420723
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ENxvXMcC";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="dXujzOOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbgEZOfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 10:35:31 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:31178 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728795AbgEZOf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 10:35:28 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04QEYO71031207;
        Tue, 26 May 2020 07:35:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=PgRAttcniqoLYNUt0U1AVvg21Tx9Iyl+5Eyre6GImcc=;
 b=ENxvXMcCPrPNkUaB+t5m2sVNoWISB+0EeL8PGm6bBs0O9nt/beLPk8uOhlpV33A+DnlT
 TQS5Fd089dJkSMWMCw/bxxb6POpVZK0fli03QDfSVHsQSwSlx1P5ht746nKV0DfwVeG3
 FVJ/M/tBq4ObbW2RVy/3Im/oV3eRvEwIwpKi3Dv4X37UYO2yt62HXrCPGEZjmuAqmDDh
 /jr41fal8rAKh2BD/bpY1A/I20lySijFS9xcn1zo7sKCmM77zNm+Du+4OVA8gtFsb1Hn
 84S9BJ+eFlMPbFhFoRsXPfwA7Sk5BvIo9ZSV/CLt4osH4c7SBRBj3hUf5jI4ALuNwHFq zQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0b-0014ca01.pphosted.com with ESMTP id 316ye08qqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 May 2020 07:35:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJ8Jcj1VxSgMcllM0hLhqLHMD56Gb1hQEkzdXJh5m8y8KSGeHNFp5iU5jrtMdg9qfVYEleb7u3JF7tESvTtQvB6FYhQmBLoimacM8XVMHHOG9grak3dBk/ceLXhjkYsrPU0Q7RWZhKFlo+EZ+jJg/BDqG1Fggiu7N/pNRqG1qXxrDxjQRDaB0RNHeQ1pcZ45zTLWEriLzhTLzoSeYlU2/vhpTbHv+eAzxtwf00cUnyVtkmlte4s0JJvT2Zak0BFvou8vv5KB36VX+Bf/6wWywDEGnr4th2IL3l8vOWX4NDj0xL9Oy0mfzNK3An0Va0noMfxbvmCkDVZtzMIfJAo1ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgRAttcniqoLYNUt0U1AVvg21Tx9Iyl+5Eyre6GImcc=;
 b=dEKs5tNX9a+9xh+rj6I4szZnHklvrDViuZ0vIKDSqErEXarl8BcAR1jMo4qnNG8AUTYQJzjTrKXd6T4WBKU7//0lB6w7bsQNCF66ACG4i94HVu4g4XF20JnXvlHe7xMC219wBBQFeEm+XsGMNs58dkI5y/cnmbY6+9nluq7NccFrxu4yoscJ4ZtuqRO4Y6NP8HmSs78ZsUPVM8H8g8U0ugXE3XNYzHcGHalf2Ka97aBGgy/pduJbMQQoT41dzNn3ll+ubcNTZ5dN8h0IHNzoS38/gvKSE+x/sgS6T77BVcyQbbyHoT43j2kflD6Amg9L+y5chLhGnJda0OXPlxeAXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgRAttcniqoLYNUt0U1AVvg21Tx9Iyl+5Eyre6GImcc=;
 b=dXujzOOs7lXmJKrsXjKB0s5GSxpYE04mXsJD0lWre0ajRLHPuTYr4KpVSuY70gsmzCHBQHbNyLel7ETdAgwOrjiE82RmpzZUALboHhrTIby0jWF6OfpIU9TSyVZIK26UStqOtLb7PjudZZl/au0dIcDQd/dnleN6+mVHgTK/t0I=
Received: from BN6PR13CA0048.namprd13.prod.outlook.com (2603:10b6:404:13e::34)
 by DM5PR07MB3580.namprd07.prod.outlook.com (2603:10b6:4:68::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Tue, 26 May
 2020 14:35:12 +0000
Received: from BN8NAM12FT052.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::31) by BN6PR13CA0048.outlook.office365.com
 (2603:10b6:404:13e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.8 via Frontend
 Transport; Tue, 26 May 2020 14:35:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT052.mail.protection.outlook.com (10.13.182.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.10 via Frontend Transport; Tue, 26 May 2020 14:35:11 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 04QEZ8HB002019
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 26 May 2020 10:35:09 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 26 May 2020 16:35:07 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 26 May 2020 16:35:07 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 04QEZ7gi015138;
        Tue, 26 May 2020 16:35:07 +0200
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 04QEZ4JB015096;
        Tue, 26 May 2020 16:35:04 +0200
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <kishon@ti.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <maxime@cerno.tech>
CC:     <nsekhar@ti.com>, <jsarha@ti.com>, <tomi.valkeinen@ti.com>,
        <praneeth@ti.com>, <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v2 0/2] Add support to get/set PHY attributes using PHY framework
Date:   Tue, 26 May 2020 16:35:02 +0200
Message-ID: <1590503704-15057-1-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(36092001)(46966005)(186003)(966005)(107886003)(4326008)(2616005)(8936002)(47076004)(42186006)(36756003)(8676002)(336012)(70586007)(82740400003)(70206006)(426003)(478600001)(86362001)(316002)(110136005)(54906003)(356005)(36906005)(5660300002)(26005)(2906002)(82310400002)(81166007)(2101003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b998f261-3874-421b-8d33-08d80181ff59
X-MS-TrafficTypeDiagnostic: DM5PR07MB3580:
X-Microsoft-Antispam-PRVS: <DM5PR07MB3580DC2017A5FA9C051FB267D2B00@DM5PR07MB3580.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 041517DFAB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xB0qeKJCk6fw0ztnJeqC2M1bKH+1THaKBKDZ8Q1ggSsKyl6UNa0hNIvXaocg3s1fZI8/xDtucAnmBkiVeZsxgvntZnG/XfjluIBV/+uMkVJSO71F5W8vlMUI634PKG7wOqqfPhCMLIx6ZgDnwSEZX3jycIJYCI57dhlQiZXLIM4WmHlQaJMeQ4rEAiR99NyK/07l7Mk4E6ezPbvLJOfuyTMrm+hd5uZcwN6Q5WSGu7dlj8N8gUSuMeHvTciKlc3ybe5iB3fjXui4vFopsfXANpuNesoUwotV+ZDOKtbL5RYeLOGGiKlKHJNMJUb4+BaWOsVhUTflNs57GyjTVNaA+mHwNKf9W6Jzt3DJy7LsKLsdVHCETJYfcMIJvKTWSbulK3CAfvo996p26GLY1BzoeVPXXjwubyP3fYtiScJeyN79BjeJE+KrgoMyCWvTKnOu8VmeA1SX0UbhumgPa8Qb3YWqGJ7Zm9Rv7kJzTQ/qkxyCDgD2FP4iVl4Y0z1aKGGAQg06m/LMeAthkSbY81buow==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2020 14:35:11.9123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b998f261-3874-421b-8d33-08d80181ff59
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3580
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-26_02:2020-05-26,2020-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 phishscore=0 cotscore=-2147483648 spamscore=0
 mlxscore=0 suspectscore=0 adultscore=0 impostorscore=0 clxscore=1011
 bulkscore=0 malwarescore=0 mlxlogscore=484 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support to use kernel PHY subsystem APIs to get/set PHY
attributes like number of lanes and maximum link rate.

It includes following patches:

1. v2-0001-phy-Add-max_link_rate-as-a-PHY-attribute-and-APIs.patch 
This patch adds max_link_rate as a PHY attribute along with a pair of APIs that
allow the generic PHY subsystem to get/set PHY attributes supported by the PHY.
The PHY provider driver may use phy_set_attrs() API to set the values that PHY supports.
The controller driver may then use phy_get_attrs() API to fetch the PHY attributes in 
order to properly configure the controller.

2. v2-0002-phy-phy-cadence-torrent-Use-kernel-PHY-API-to-set.patch
This patch uses kernel PHY API phy_set_attrs to set corresponding PHY properties
in Cadence Torrent PHY driver. This will enable drivers using this PHY to read 
these properties using PHY framework.

The phy_get_attrs() API will be used in the DRM bridge driver [1] which is in process of upstreaming.

[1]

https://lkml.org/lkml/2020/2/26/263

Version History:

v2:
    - Implemented single pair of functions to get/set all PHY attributes

Swapnil Jakhade (1):
  phy: phy-cadence-torrent: Use kernel PHY API to set PHY attributes

Yuti Amonkar (1):
  phy: Add max_link_rate as a PHY attribute and APIs to get/set
    phy_attrs

 drivers/phy/cadence/phy-cadence-torrent.c |  7 +++++++
 include/linux/phy/phy.h                   | 25 +++++++++++++++++++++++
 2 files changed, 32 insertions(+)

-- 
2.17.1

