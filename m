Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBF0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2CC8206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="uMgTzf32";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="snsjOipv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgH0Nre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 09:47:34 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:20810 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728071AbgH0N3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:29:13 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RDJxV8014989;
        Thu, 27 Aug 2020 06:29:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=oGR96nzxbwpeA6KDUi55HbE2M33HfkIZ/QtLjln6Rv8=;
 b=uMgTzf32mQlw88P28HnBkw4uFs4/kiridynPl0gqTUGWBLOobTlIBL8UVuCSEQeskvt6
 dgc/9JAboFukD7nUCtes/MZMvDGmbrqjlgJf7vIQMbXMi09KvPoAemn0EqJ5rKdTG+9N
 TsV8EeaDhUWqSDJH0FUMSy5dmxMO+4dP7sR0A1fVADiiXznugC3bWrKELkOZgk0nWu2S
 m5AMIMDzhyUR50GqUFhth7iuy0AyFJ470washE3Iy8ymceezHocLO0abyD7bVUbIZ77t
 sIkx342PR/MVI43ED5CxDLfGJIaR7RmbA12UFVAeGr5rRdjF7uxc16rsdlC7WYyd32Bt pA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by mx0b-0014ca01.pphosted.com with ESMTP id 332xxxcnrd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 06:29:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7J//dm/Sha2lVBOqb09Lg4nnEM63QN4z8PYbMlihFB7nwukGWRqHQ/DXLvx/idRK4mWGVy9HCNbx/QWL3cGu339Uz3Bm2Z+nyJh1xZ/RTnXhPekQ4g17W9KrN4jdh7cI+SLxFCK7WiC3+it8HAzPJQGaT7IdWIEtL6LDqQS82fgQOdjESAZxQ86cFZmkZ4wnIVbKuhEEnboqOHL2C/ltGwMOTLM9JzpbSFV9+UcDoOCkDq70FzPnvzNEq1vaZFcU59XF+Z4g7gHmLfjy9q9YpdxN+l2HFb4aXyCimmqkXjmWtSSGM4jaa8TqoBDPiM42xHq9uqG00wtSd7+vHtHYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGR96nzxbwpeA6KDUi55HbE2M33HfkIZ/QtLjln6Rv8=;
 b=fdMYVa8Ei8urI8bqwpuYbLUIU9As/vLZd9eJQSoc66bcHO0ZEjZTg0o2cp7u07rDFRQbdDEtfWqrXk77ucadd8MzBYJkGusg49TXMTxU2s/KkTeWLv37O5MxSqorV0D0Mji14vcIYFVZTObmHsdPMCKVqhJGovZ99jdLud+I8pUls2S8WzViSw7VGHGpaQzNFUfchUWkB6nNpYaQgXLexC+CIsW+KgLPIGgSeaIOKqY5dRK/+yxfSg9h2PZgsOWct2+eFl2a1yueaWqkCAPk+k1MA09K5JLG0hAEKXukFstCWstczddutJP2xPl3VLA2ReKWJ2+rMXyig5bBGNBzQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGR96nzxbwpeA6KDUi55HbE2M33HfkIZ/QtLjln6Rv8=;
 b=snsjOipv66vwPMBm8cm08xPZFotY6Y8HCE3uISl3lgT9fX42V5embKa9jU9i5Rzv1Cmb8o6PlN7a/uT8OmPR+Wy0dVJHF8liPRMaJLsRu2c/LmHBGDd0ecwD9FMnadxhEq+CfZrSauUM9Xx+4/YglEN0FozUzNvKLwb69j4GBuE=
Received: from DM5PR05CA0014.namprd05.prod.outlook.com (2603:10b6:3:d4::24) by
 BN8PR07MB6209.namprd07.prod.outlook.com (2603:10b6:408:b6::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19; Thu, 27 Aug 2020 13:29:00 +0000
Received: from DM6NAM12FT051.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::57) by DM5PR05CA0014.outlook.office365.com
 (2603:10b6:3:d4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.5 via Frontend
 Transport; Thu, 27 Aug 2020 13:29:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT051.mail.protection.outlook.com (10.13.178.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 13:28:58 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 07RDSrRh001550
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 27 Aug 2020 09:28:57 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 27 Aug 2020 15:28:54 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 27 Aug 2020 15:28:54 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 07RDSrM1018738;
        Thu, 27 Aug 2020 15:28:53 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 07RDSqdC018730;
        Thu, 27 Aug 2020 15:28:52 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v2 0/7] PHY: Prepare Cadence Torrent PHY driver to support multilink configurations
Date:   Thu, 27 Aug 2020 15:28:45 +0200
Message-ID: <1598534932-18693-1-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 691d4d36-d7c5-49d2-6af4-08d84a8d279b
X-MS-TrafficTypeDiagnostic: BN8PR07MB6209:
X-Microsoft-Antispam-PRVS: <BN8PR07MB6209E537664D3318A4D8437FC5550@BN8PR07MB6209.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 65/qhIX/XWKk1w/KGH+1Z93hptl91d6+dh5laJgHEor87O6djsfXsdTDiqntJgkLx/w7Q1Zf08/mlrlmBwyYnB7U6YX69f8L183xhIozoWBO/oEiV3pQOSeW12eCI2HglhL+yWpgn1ifM30rozKBkh7z5DCv8KLh0NZ6mqwtNWLMbcrNX7KPpu6AgQlMuQuQykfij8aIiTOZ7vQ4hJ/4Gwnzgg9l+XiLB5uXwEYLvALx+aex9n1e289WQrJNYR4BmRQR7/VMHqghV2ZbuHTrozpDwqQIsbZRG601YXF2QiegivJmn9xOT+mhend5nlT1kPcAwtEsH5QBg4jW38rcaWqWHhJbr3A6IGP52rmgWHTaazGoKfaYy+vFqw/y8etEPgy0JYlHnjskpOrQwNEKUi/iD6zzRVfSbwVV6w89c38CYA8tBikne6/iu+8lgvbQd+g3OVbJV2qF5ILecc7OqEEx8rCiBHW5+7jnKBo7KUNaDTUXp98JCCNgjx8BcAQd
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(36092001)(46966005)(6666004)(70586007)(70206006)(8676002)(8936002)(5660300002)(478600001)(316002)(54906003)(86362001)(966005)(42186006)(36906005)(110136005)(2906002)(336012)(83380400001)(82740400003)(186003)(47076004)(26005)(36756003)(4326008)(82310400002)(426003)(81166007)(2616005)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 13:28:58.7556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 691d4d36-d7c5-49d2-6af4-08d84a8d279b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT051.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB6209
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_07:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=669 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008270101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cadence Torrent PHY is a multiprotocol PHY supporting different multilink
PHY configurations including DisplayPort, PCIe, USB, SGMII, QSGMII etc.
Existing Torrent PHY driver supports only DisplayPort. This patch series
prepares Torrent PHY driver so that different multilink configurations can
be supported. It also updates DT bindings accordingly. This doesn't affect
ABI as Torrent PHY driver has never been functional, and therefore do not
exist in any active use case.

Support for different multilink configurations with register sequences for
protocols above will be added in a separate patch series.

This patch series is dependent on PHY attributes patch series [1].

[1] https://lkml.org/lkml/2020/8/24/1586

Version History:

v2:
   - Rebased on latest PHY next and new PHY attributes patch series [1]

Swapnil Jakhade (7):
  phy: cadence-torrent: Use of_device_get_match_data() to get driver
    data
  phy: cadence-torrent: Use devm_platform_ioremap_resource() to get reg
    addresses
  phy: cadence-torrent: Enable support for multiple subnodes
  phy: cadence-torrent: Add separate regmap functions for torrent and DP
  phy: cadence-torrent: Check total lane count for all subnodes is
    within limit
  dt-bindings: phy: cadence-torrent: Add binding to specify SSC mode
  dt-bindings: phy: cadence-torrent: Update Torrent PHY bindings for
    generic use

 .../bindings/phy/phy-cadence-torrent.yaml     |  85 +++++++---
 drivers/phy/cadence/phy-cadence-torrent.c     | 146 ++++++++++--------
 include/dt-bindings/phy/phy-cadence-torrent.h |  13 ++
 3 files changed, 164 insertions(+), 80 deletions(-)
 create mode 100644 include/dt-bindings/phy/phy-cadence-torrent.h

-- 
2.26.1

