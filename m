Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F91C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 211AA2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="WCSDxw6N";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="fWuzMK7m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgGMJis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 05:38:48 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:8084 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726360AbgGMJir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 05:38:47 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06D9RNES006995;
        Mon, 13 Jul 2020 02:38:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=Sc/+i11PUkVvreKP/xqbKdEYEzaLItA0j+Qyhovi2Lo=;
 b=WCSDxw6NyjNYb2Gmold2P3iy7soI7bShv7gdPCeRlPonX9FlSEzv+H1akY/k8xnkBEKi
 UJlJ2bkTRi1de/aWbHz17/SgLQyW4pzjQQcjSlAsY39YOb1jrj2yRTt4p4Dol5Li0vPA
 Rgj1NE+/BTm8KkDAizsLWL0NPWKdiBkFZNnEo4yyrcnajODLp2M4MVYgegeAZajJHDsR
 0I3Ng8WigPjDd+B/lay3Xy0NCGl3OUCAGxR0m2P1xEcYhd8v5EhkyH7dJkxhhIz4mb7B
 qgTxsgdkh3hX5TuuxNabqOlsVrT4TNJ+fmrfOIEyu35RmOmr/6//3U9eyhCw7YGczKG9 Pw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3279yud45r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 02:38:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6NHPFISWnKs9vAg3QSqFWpc891WEqNEDjtxwOav5zvRCChf8hI1P/bNoG0spaMA5jTzzpv7wDvnDtfg5tZqIvTBzcB5hc/B9zIppAypccXKYRGK/+QIfXVK8X+W+ubLaTeMoWojDdx+3ywWQiKNNhEY2SAruMLDnjQU2P3U2G486DGtmVXWh0j45X5StfJFLmS9Yd2otMZWKGwMTHSY//AvJ/Hj338l+Qfjc0dq8sIMr0aXo0LHTL4fb/FYQ7XEK3Itp1R4ruSb9QVv4d0VahbK0httCmit8RAf/Yqdmz+Exr/XlD1TJDHerjmvdPppgF3+P3IM5dk5s2W0bHy+rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sc/+i11PUkVvreKP/xqbKdEYEzaLItA0j+Qyhovi2Lo=;
 b=GwJpwI28mGD/e0tszVq2MKclM2s2cxeRwC9exVj3b00n1SBvfQ1tSbIO8gWJjWG4qXk0Fzz1Jg6z0H8nA06MJ2hwUjZUHgIgEnv0hi0xYri3mZalvM7s0iK5lJwL+Y/xMGZZ3obv6EVfqh1LVT8Wk/m9/QMzRedRhuoEa22K6XvmKWoNUPYXd7mCC4DRMLZTSyCaF7l5jmpETkOqAY8FGkzUn1jH49WpjfzX89bYJQljsWFZGYRSAzXjZsPA3Q9CuOSDO91tLolljfBFT37I3WC5WvVdMFAXcb1skXi2VHkTgV0V0zTTz4MZkdGg07rXP7wURgey/Wgi1Qbl/6mPxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sc/+i11PUkVvreKP/xqbKdEYEzaLItA0j+Qyhovi2Lo=;
 b=fWuzMK7mZJBpjFXdLNxB34Sy7ChpD3axpS8GGo89dti9KbXtPyQFiy3FFjtYYD6r1kyb8xr/TWET0Z1si8OEJUjd9fWw7PbPK5qe1bRG5d0XGN5GYaOP524BgS08s7pu9MqRpv7/ilnyEGNE05q0jlebnPC3a71ye8jHa1mTNak=
Received: from BN6PR11CA0052.namprd11.prod.outlook.com (2603:10b6:404:f7::14)
 by BY5PR07MB7281.namprd07.prod.outlook.com (2603:10b6:a03:206::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 09:38:39 +0000
Received: from BN8NAM12FT032.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::28) by BN6PR11CA0052.outlook.office365.com
 (2603:10b6:404:f7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend
 Transport; Mon, 13 Jul 2020 09:38:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT032.mail.protection.outlook.com (10.13.183.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Mon, 13 Jul 2020 09:38:39 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 06D9cYh8012105
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 13 Jul 2020 05:38:37 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 13 Jul 2020 11:38:33 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 13 Jul 2020 11:38:33 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 06D9cXjG004208;
        Mon, 13 Jul 2020 11:38:33 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 06D9cWg7004201;
        Mon, 13 Jul 2020 11:38:32 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>, <maxime@cerno.tech>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <nsekhar@ti.com>, <tomi.valkeinen@ti.com>,
        <jsarha@ti.com>, <praneeth@ti.com>
Subject: [PATCH v3 0/2] Add new PHY APIs to framework to get/set PHY attributes
Date:   Mon, 13 Jul 2020 11:38:30 +0200
Message-ID: <1594633112-4155-1-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(36092001)(46966005)(36756003)(2906002)(316002)(36906005)(42186006)(54906003)(110136005)(82740400003)(4326008)(47076004)(426003)(81166007)(2616005)(82310400002)(356005)(5660300002)(8676002)(70206006)(70586007)(336012)(8936002)(86362001)(186003)(26005)(478600001)(966005);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 486fdf71-7ff2-48a3-dc84-08d8271085c8
X-MS-TrafficTypeDiagnostic: BY5PR07MB7281:
X-Microsoft-Antispam-PRVS: <BY5PR07MB728102C8223B851A05D84FC4C5600@BY5PR07MB7281.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F+oEfWCxbCiASpUnyvbN7GGNYdc464q/nBqFROP9a2VFvE8CmNiNdISZd2IAZGBqIOgkIL4p3Tzvi1oqZuCdKU9Itegd8gkAnRXZrfvBIDKVLI/xuIdn7qnfNEt6NEMgEQG7tdPuOZGmg7t1qRUMvmCP8dnfp4OYzGQv+JUVyQkPDxEbbgtLGUAQmF5P4AqrZoAyG9c24WMXg9uSif0YlvP/uEbtBmsYX9LPvIQV++lPztYLHLjzfe89RCcjJKXa0b9ikBP1YDNqB5bYfHg1rGULrG6U03XzIfq0qcMj628LIE2lkkPY+GRhxGdhj9pDAjCR0NBY66qqQD45Ik2NDq5wmVQsOtpFGb5ZHobo1CDVs0sf4SHJJJ6QhzuCDNKOzLXVFdehxx4tlF6gUVP5ZB/SZff2TP3uCKW9yzd9lRCq0EKoU2k8HWy/5tWvXzy7IPcN/lKnYcvcWFpkw7vaGs2pV6CBlwhBeoiod6xPDaoRfUEjRm4lx99xVZAAGqUB
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 09:38:39.0158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 486fdf71-7ff2-48a3-dc84-08d8271085c8
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT032.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB7281
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_07:2020-07-10,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 mlxlogscore=554
 mlxscore=0 phishscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a new pair of PHY APIs that can be used to get/set
all the PHY attributes. It also adds a new PHY attribute max_link_rate.

It includes following patches:

1. v3-0001-phy-Add-new-PHY-attribute-max_link_rate-and-APIs-.patch
This patch adds max_link_rate as a new PHY attribute along with a pair of
APIs that allow using the generic PHY subsystem to get/set PHY attributes
supported by the PHY.

2. v3-0002-phy-cadence-torrent-Use-kernel-PHY-API-to-set-PHY.patch
This patch uses PHY API phy_set_attrs() to set corresponding PHY properties
in Cadence Torrent PHY driver. This will enable drivers using this PHY to
read these properties using PHY framework.

The phy_get_attrs() API will be used in the DRM bridge driver [1] which is
in the process of upstreaming.

[1]

https://lkml.org/lkml/2020/2/26/263

Version History:

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

 drivers/phy/cadence/phy-cadence-torrent.c |  7 +++++++
 include/linux/phy/phy.h                   | 22 ++++++++++++++++++++++
 2 files changed, 29 insertions(+)

-- 
2.26.1

