Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2EAC33CBA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D444721734
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="UmSbd0vo";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="maoQNixY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgAVKzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:55:45 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:33308 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727022AbgAVKzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:55:43 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00MAkedi012926;
        Wed, 22 Jan 2020 02:55:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=lMR2h13/uSeeRPpRDNAteBv9NiYLqRkPC7M825TzV5o=;
 b=UmSbd0voHAE84nFvf+9sX1X19cl0CqPa3UPsWBoQ9vSP+z5i1Dlpg8FYsmj7/qpvgRjh
 5IF0UAQVpV4zryddZl2utvJPbAdjgp40UuBb/cPoo08Tc6nWWa3LAbTRjTGm1F4mDQtn
 qV4B2htNMwxQBbMUNlVjHQYQjO9wWZzSfRmyibjeuZVo2YeBFQ6UVbVKkbl3LlMMcO4z
 RsxHIkFtkOpsiilfxDI30j8EjEIKe9SZZbTCi8tjQp+lRgV5mhMKkrRNE1QngT98gka5
 l5RSEuAO0Z9r5Cuy5lPuvFNx+QiEYcbx5sXg39HzTIhJvW/VGEGvBaR1cHG/BtYAlszc +A== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2xkyf5mhng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jan 2020 02:55:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+E2VqYrZ5DBIjAMW2zK8/RKYVoMbVGjwtt98OHlPzHdbEqReOGGsb29KFUdAxEpt9N4BXwizDOacz5jZhBVjgsCxNkn25SvtKFFet4Iy/C8bObbrqxJPC6JVKk0hgITuJ29p+eJa3BcC/dy2ImR3zUBBjxYKhKUfQZUdes4mMCLLUq2pzS3xeJhJLSR1MZ6tg3BCISD1TBQPbdyVxP6Jao5mCKzYiFzMcYEZNeW9pQuYi516Ba254JU6HnJtX5cjJzWvm/nRyZu7U3UBNt4PI6rZ9uxIGG9YzCV56xJ3X4EI/RfNodbwkPGnWsSFZk34rJRoun0eSZWXCpu8J7hwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMR2h13/uSeeRPpRDNAteBv9NiYLqRkPC7M825TzV5o=;
 b=OArUKA2fx0dzGXRkiwtn8xligccRVGv9tizrCvwTDPcLjYJKVU2E6tbAG8mI7KPS8zpbDAY0yIlvnQ8ClLqwSANcPFRrSguX+Pxnxig4CVTJRW+8bGMhmODS9g+3YO4ydk6Yx0Z0aVbO6+oNb92xZTLAfSRUyI5CS5AhJszZlW8HUWVE6/5kenPzFfQBx+UEXQOG1g6kTaYM78mwRGbjQNwK/Ak60Ojtjl3xta9YbpqFCqKil0pFXUDukR0/76mGrlwizXqJZ5xkbWUW4zhGOxLp1JQ9gywn4oJ9wuI2VqpMxMcQjZ6k2cMPn5MKTUdLhTjL1ZOCJNyzGLIzb/UDZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=linux.ie smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMR2h13/uSeeRPpRDNAteBv9NiYLqRkPC7M825TzV5o=;
 b=maoQNixYvuG7SPfsT+NEK3qgsP0OE0oXylmgbSEjAY58+yHlibAC1Y9kZxY+jIJUws/NP+h3axfSNPv8WdBb48hdocxOcyAtMK6TM08X4wwkrY0EZTUiKlNhnGgopwK23Mbn6acYr8ZLRA0Q+1cx1DiPn3CrS2qpQXWzo+WRmSA=
Received: from CH2PR07CA0028.namprd07.prod.outlook.com (2603:10b6:610:20::41)
 by BN8PR07MB6930.namprd07.prod.outlook.com (2603:10b6:408:7e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18; Wed, 22 Jan
 2020 10:55:15 +0000
Received: from DM6NAM12FT062.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe59::205) by CH2PR07CA0028.outlook.office365.com
 (2603:10b6:610:20::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Wed, 22 Jan 2020 10:55:14 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 DM6NAM12FT062.mail.protection.outlook.com (10.13.178.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.6 via Frontend Transport; Wed, 22 Jan 2020 10:55:14 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 00MAt78c071698
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 22 Jan 2020 02:55:09 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 22 Jan 2020 11:55:06 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 22 Jan 2020 11:55:06 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 00MAt6NX011093;
        Wed, 22 Jan 2020 11:55:06 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 00MAt2Mc010791;
        Wed, 22 Jan 2020 11:55:02 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <maxime@cerno.tech>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <mark.rutland@arm.com>, <a.hajda@samsung.com>,
        <narmstrong@baylibre.com>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@siol.net>
CC:     <praneeth@ti.com>, <jsarha@ti.com>, <tomi.valkeinen@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v3 0/3] drm: Add support for Cadence MHDP DPI/DP bridge and J721E wrapper.
Date:   Wed, 22 Jan 2020 11:54:58 +0100
Message-ID: <1579690501-10698-1-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(199004)(189003)(36092001)(110136005)(81156014)(8676002)(70586007)(42186006)(19627235002)(316002)(478600001)(966005)(70206006)(4326008)(36906005)(5660300002)(2906002)(54906003)(186003)(6666004)(2616005)(356004)(36756003)(7416002)(336012)(81166006)(107886003)(26005)(426003)(86362001)(8936002)(921003)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR07MB6930;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:unused.mynethost.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cb3d865-998d-4152-6067-08d79f298f57
X-MS-TrafficTypeDiagnostic: BN8PR07MB6930:
X-Microsoft-Antispam-PRVS: <BN8PR07MB69307DA0E9D1B74C313FFBB1D20C0@BN8PR07MB6930.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 029097202E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VtdHUNpLaVAxcP+kWRugEmgR5B2QQvGdeVKrdH8xm0T5OmitARkoTlWkjgC4SKanlU819zbofY3WECEO/eh8onDrbe7CwyCd9l3ZMScn2h4mHCVzm7aL5Idc7rsn0IH+WwXop42qlqBjPrbAoql9AXPBk+88vFEpbdFfMXCvzQbgJ9NEVFaNs7HjryOMwxMbTxHHyX/wV77nyuu1E4d0QPbvF5xrpbxbUTG3buWxhkxjlFlmjr8sOfu9LvHpdrb0kQLW6rfuKa0J8nUh4KfZDvDf72AI8N8gVpboIVkZbenbaRmAXhyqvgKG6SOVyVlEtEATAbwqN2Ehei3MtsgLLxlXqUc5IkRhMGO/EWfyjAnX9KWmZZuBZaFTaH6cF/hk0M7SN4keryRUWlURH5xBDMPCPbf1zKXsDwBIv5m73CmKIG/Ie4NbytuP4POmvE2BIBln5pv3uZoNE6dCWKJk+rHn7J+XaHNglWcUuFbhWVXcqFSm2oCxeDbCz8DozuOmKiaxKIBcdBp2ARQInLcZplJ69EzKtONyH149kLGJK/0Kg8yAmxjUhpEux3JRAD9bgRFBPSDg8lDCF2Q+36GIbjYrS9W61tR6io7D0GI/ZG4=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 10:55:14.2329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb3d865-998d-4152-6067-08d79f298f57
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB6930
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001220099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds new DRM driver for Cadence Display Port.
The Cadence Display Port is also referred as MHDP (Mobile High
Definition Link, High-Definition Multimedia Interface Display
Port) Cadence Display Port complies with VESA DisplayPort (DP)
and embedded Display Port (eDP) standards. This driver implements
Single Stream Transport (SST) support. Adds Texas Instruments SoC
J721e specific wrapper and adds the device tree bindings in YAML format.

The patch series has three patches which applies the changes in the below sequence
1. 001-dt-bindings-drm-bridge-Document-Cadence-MHDP-bridge-bindings-in-yaml-format
Documents the bindings in yaml format.
2. 002-drm-bridge-Add-support-for-Cadence-MHDP-bridge
This patch adds new DRM driver for Cadence MHDP Display Port. The patch imple  ments supports
for single stream transport mode.
3. 003-drm-mhdp-add-j721e-wrapper
Add Texas Instruments (TI) j721e wrapper for mhdp. The wrapper configures mhdp clocks
and muxes as required by SoC.

Version History:

v3:
- Added if / then clause to validate that the reg length is proper
  based on the value of the compatible property.
- Updated phy property description in YAML to a generic one.
- Renamed num_lanes and max_bit_rate property strings to cdns,num-lanes 
  and cdns,max-bit-rate based on update in PHY series [2].

v2:
- Use enum in compatible property of YAML file.
- Add reg-names property to YAML file
- Add minItems and maxItems to reg property in YAML.
- Remove cdns_mhdp_link_probe function to remove
  duplication of reading dpcd capabilities.

This patch series is dependent on PHY DisplayPort configuration patch [1]

[1]

https://lkml.org/lkml/2020/1/6/279

[2]

https://lkml.org/lkml/2020/1/22/631

Yuti Amonkar (3):
  dt-bindings: drm/bridge: Document Cadence MHDP bridge bindings in yaml
    format
  drm: bridge: Add support for Cadence MHDP DPI/DP bridge
  drm/mhdp: add j721e wrapper

 .../bindings/display/bridge/cdns,mhdp.yaml         |  131 ++
 drivers/gpu/drm/bridge/Kconfig                     |   23 +
 drivers/gpu/drm/bridge/Makefile                    |    6 +
 drivers/gpu/drm/bridge/cdns-mhdp-j721e.c           |   79 +
 drivers/gpu/drm/bridge/cdns-mhdp-j721e.h           |   55 +
 drivers/gpu/drm/bridge/cdns-mhdp.c                 | 2214 ++++++++++++++++++++
 drivers/gpu/drm/bridge/cdns-mhdp.h                 |  381 ++++
 7 files changed, 2889 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp-j721e.c
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp-j721e.h
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp.c
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp.h

-- 
2.4.5

