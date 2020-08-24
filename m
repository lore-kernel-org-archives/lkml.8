Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACAEC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F8120767
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 18:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="doSxAb53";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="VRNynOqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgHXS27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 14:28:59 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:11738 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727048AbgHXS2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:28:53 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07OIRkYj010487;
        Mon, 24 Aug 2020 11:28:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=zckxbDGm41PHmGhdr+wIBKU52MqKuAAqpZdHtTIHsWs=;
 b=doSxAb538tQO2FPNEXBXZePqCPPfsAIYe1XD/r6/jvAMDvdgoPIDpyym71v3R8zTxyy8
 qyJ0v/s0Uxi9ZdrYRRGJItDzjvwWaTw82bRYbNM6IJL4NyXTGJLQevBpJ6BjCYOOvCOm
 Jmys6Ca31+lWKwp0EFn4xDHLu+NCOSGdt1ZMf4RDMtJYeSgYUuGHf10ntvh1fSm9+KjE
 AmiGLYr294F3DueMHEvMvjVM0huhbS//hxzWwQExgKiIeD0A+aG+7SkPF5+WwAZBQK45
 d5sd85w/YHTyzp8hS+tAqrdJ7kd64GPjVa4UsZX9GTvb3Uuda0XD0RJ5jWgwuwUwouBF XA== 
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2051.outbound.protection.outlook.com [104.47.38.51])
        by mx0a-0014ca01.pphosted.com with ESMTP id 332ywvqfqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 11:28:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAdkcv3ghV9M5WHvo0l5bqjJhNHF3L7ssyybQQQJdE0peZ7ULCr5yY/97PxXuFQSXpoSFYMTd1judUoOSUQ2kBtjvlMem+1Q2dk9aMKPrRVlI/CiPnoB9ZlZXRlaMqcZKJqYxMBMt4224YwvfXj8MXhneSnK+nmXXMYIwDfLjOD01gLSna3elIALOhM8jXYeuvJFb/JpkTWd9Vivt+MEWUXxykn7+T23c4uQHzbpSHXluTn4V7Y/D2q4FQVji8UrCXskjctISGeJW4Eh6CtvqgczxWubWboSIKUp3R5gzxzhuZeOWnVOixu3w5g0hbLnWC+piQIOOk5JW1RemEMxZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zckxbDGm41PHmGhdr+wIBKU52MqKuAAqpZdHtTIHsWs=;
 b=d1Uhhe+pvBXMIS6s3bRNqpeHWmWPK4AV08euVEtQoHuHtgSjB/onio/asPlfWVv7KLD79snKT/6AOBmO9H5hLUEJFjB1ld5loQCbRt3SPBC0651NDbMWagx7EQmykibgkjghYVNa7knAcVNzU//hfFI8dVgAazdV+DRt1aVU9h7t0550BnrlwlF3IQswYTkqzQWc6yOxy5nJjj0HXcoC/mbJGRF0n4E4GltaN/Q8meWrrUYQxNx7lzr5SOFE6JX3Ab2aQ4TZ6lVP7s+ynCFDXlBXiQ1Gi3PZWiBNA4bnLNtU3dnThqyuqzs66klzq5lFhW+y/uGHLhcbdCjL+0z5vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zckxbDGm41PHmGhdr+wIBKU52MqKuAAqpZdHtTIHsWs=;
 b=VRNynOqvjTud5kr9P8fja0wF74yPMuO0h3kwtdi7s5I/O9cGNXW46p7d0t/BvBxVeUZoI7g45RLWyrQ2OQvT8PNVS2vfyupIorV+bFV2JE+jKfyI+E51sQEX4v2DT6omCIKava6RJATm0N+/gHhhZmScH+I4Ykj3a+/8ygakIck=
Received: from DM5PR13CA0007.namprd13.prod.outlook.com (2603:10b6:3:23::17) by
 BLAPR07MB7602.namprd07.prod.outlook.com (2603:10b6:208:29b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Mon, 24 Aug
 2020 18:28:36 +0000
Received: from DM6NAM12FT019.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::d1) by DM5PR13CA0007.outlook.office365.com
 (2603:10b6:3:23::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend
 Transport; Mon, 24 Aug 2020 18:28:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT019.mail.protection.outlook.com (10.13.178.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.16 via Frontend Transport; Mon, 24 Aug 2020 18:28:35 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 07OISWin013830
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 24 Aug 2020 14:28:34 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 24 Aug 2020 20:28:32 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 24 Aug 2020 20:28:32 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 07OISVUv023410;
        Mon, 24 Aug 2020 20:28:31 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 07OISV7M023409;
        Mon, 24 Aug 2020 20:28:31 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>, <maxime@cerno.tech>,
        <Laurent.pinchart@ideasonboard.com>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <nsekhar@ti.com>, <tomi.valkeinen@ti.com>,
        <jsarha@ti.com>, <praneeth@ti.com>
Subject: [PATCH v5 0/2] Add new PHY APIs to framework to get/set PHY attributes
Date:   Mon, 24 Aug 2020 20:28:29 +0200
Message-ID: <1598293711-23362-1-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70f83432-454c-45fc-1327-08d8485b837d
X-MS-TrafficTypeDiagnostic: BLAPR07MB7602:
X-Microsoft-Antispam-PRVS: <BLAPR07MB7602BD14FED45AA58C352E77C5560@BLAPR07MB7602.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dah2RR7JwtQruyVXbSKFBZhW6Dj7Q1lz0i/FYP1kPbdoBi03XluTddmyKvot1pmzghFSx/FDrA7Wghl+7bhFTWxiQpXxiSnp7QNteKoaoygMdszkSclo6foKzunCLIxieodX3ucoCFrSazA17dVOlo596iqIUKHT6vvl5tWLgfIKyuOaRblK4ghM7gr8edEgexK2wxz9rOkVJk+45K27xCCNOodIoqJeHPPHX4xGRLaD9Y3zLcxddFgKzGdWqZH1FM/d8164oYNH1g17liYKMKVBB/zeaBqxF0GoBRSNIkK+QfWO4zGwTC9ckQAutLVqmWmpD0eHlACgvsZQ+qDW73bbbN8KoqbnOF1yw5Rt8DkfXElytQTl5ESNeHiX16pW5gkwYWrdzIumgu2Dto9tpTe4xV8sOqv+Ue99UROqbUbFNXJBDIfEIURkvKmAS7mTgp9+APaHyPFTN29vw/Yu9BixLEAdQq9Ifi0lhL1IlBmNJ4tt/60yqehs+pg0vYLm
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(36092001)(46966005)(426003)(336012)(36756003)(42186006)(54906003)(110136005)(36906005)(2616005)(316002)(86362001)(8676002)(82310400002)(26005)(356005)(186003)(966005)(82740400003)(5660300002)(478600001)(4326008)(81166007)(8936002)(47076004)(70206006)(2906002)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 18:28:35.7441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f83432-454c-45fc-1327-08d8485b837d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT019.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR07MB7602
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 bulkscore=0 mlxlogscore=775 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a new pair of PHY APIs that can be used to get/set
all the PHY attributes. It also adds a new PHY attribute max_link_rate.

It includes following patches:

1. v5-0001-phy-Add-new-PHY-attribute-max_link_rate-and-APIs-.patch
This patch adds max_link_rate as a new PHY attribute along with a pair of
APIs that allow using the generic PHY subsystem to get/set PHY attributes
supported by the PHY.

2. v5-0002-phy-cadence-torrent-Use-kernel-PHY-API-to-set-PHY.patch
This patch uses PHY API phy_set_attrs() to set corresponding PHY properties
in Cadence Torrent PHY driver. This will enable drivers using this PHY to
read these properties using PHY framework.

The phy_get_attrs() API will be used in the DRM bridge driver [1] which is
in the process of upstreaming.

[1]

https://lkml.org/lkml/2020/8/6/649

Version History:

v5:
    - Add kernel-doc comments for phy_get_attrs/phy_set_attrs APIs
    - Pass second parameter of phy_set_attrs() as const struct *
    - Add Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

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

 drivers/phy/cadence/phy-cadence-torrent.c |  7 ++++
 include/linux/phy/phy.h                   | 43 +++++++++++++++++++++++
 2 files changed, 50 insertions(+)

-- 
2.26.1

