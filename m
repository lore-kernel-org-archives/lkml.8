Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17C7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEA8420714
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ie0yGgFe";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="fUPMjol+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgGVHlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:41:16 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:52708 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726506AbgGVHlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:41:15 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06M7bOBZ013743;
        Wed, 22 Jul 2020 00:40:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=rVv4l1AKD3Z76W+7FCViP+rj69KhBJX4crZ0SqDmdB8=;
 b=ie0yGgFeMhtsiBKVR2WpvwDM0r651kkxqz1lYQU0odSVjX7E/7IK3detT+FvWb8Cd34r
 mzVTwnBwD/z1wa1N91A5bgllv2SZnD/RFPgP++uL40XHoGyJFII/PGYWuS6Y2R95K8/t
 1MNoPvvStPu7kZMaGYMyhYvi9omDBwjUCUkHzCEiPZ156o5fmSZo+3NykpC8qqkrG5Yi
 TeL/OS0f2JkZBDA4ArWGf3W85l988zT0SSyhiI5J2CbKrTTHjGPP8oDWcDwfHxjuYOk9
 qrJxyGh0LJ6iAh1egZYGHTmyIvSv2yK8f4dG7j/dFrNPW0a9iXDbvx7USgmo3sEKGwNY sA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by mx0a-0014ca01.pphosted.com with ESMTP id 32bwmwm5wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 00:40:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiADDVS8oD8hwqO/SVZlTnIQ2r70XeQz+7zEVjAPqn5XhtFwot+ZAqQ25Xg4qB6cHZdLwVCnJxktoZueR8soYMCoc+vTkXMBmjH7fHx5lLNy0yirzNklx4HhIGYYs55+UdmWy66MUM1ALrtPSAVyX850eLxrdCPxnkwzJUbJmR0QA2IMXAOomLPIcGd3CG++24rKplNgQJF17lPjjopn3th+LqF0ON96EGB6jXR1LSbFlsR60QhAnP3ESYxQ9HWtaVNldRLonKrEQgU+n9K2sFr+XT0ODEfYgt/wo8COtjp43k42WlYyAibLmazuf8lnWqBTfCYts8+cKy4XBfIeWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVv4l1AKD3Z76W+7FCViP+rj69KhBJX4crZ0SqDmdB8=;
 b=etxHB9hl2eLFuvbWKl9D4iRAvCBht+34K8EwRXzcCdAhozB/msKzjrDsEv9yfqQPC0PdyfLzP5TylfUzxVQUmpCnZvAcmJSnBgz8iONQFPYbQZWyWuOKXJwXMg45ufpGlz1TFqW50vx9J9I8LbME5YA89pOeXhDgP+cDdh25w1ROqTX/yZuAU3MRPrOTHNqvqsybt6SD9MNXdlGUv22RJc3tCGwh50dj0mXuN3hS37JrrdaHrUBd+FEpjuvKfO1yQGt82tFBpjY04UCs6xic/uvAMuEoAJDt3oPj1VhtqP6xUpq34v4kIKEjYMH8TC08JJXHzphbvSnmXNRexMoNRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=samsung.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVv4l1AKD3Z76W+7FCViP+rj69KhBJX4crZ0SqDmdB8=;
 b=fUPMjol+ilsuzMZmbILE5hK5PrWH7WPWPp0xFXO/GvzAYOXbBH2fNlskRi1jLnzqNDa6NTAsXjuWCIHRxECsdW/xaMG4XEBaCwjXpJoizI5zssV6M1a20twi7k/QLqAF/CYFNzEBo/ui/PncUv6PVNTem50gA7Bmxcu7WcvFZZY=
Received: from BN6PR19CA0093.namprd19.prod.outlook.com (2603:10b6:404:133::31)
 by DM6PR07MB7162.namprd07.prod.outlook.com (2603:10b6:5:1f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Wed, 22 Jul
 2020 07:40:54 +0000
Received: from BN8NAM12FT022.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::ac) by BN6PR19CA0093.outlook.office365.com
 (2603:10b6:404:133::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend
 Transport; Wed, 22 Jul 2020 07:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT022.mail.protection.outlook.com (10.13.183.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Wed, 22 Jul 2020 07:40:52 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 06M7ehn2188912
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 22 Jul 2020 00:40:51 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 22 Jul 2020 09:40:43 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 22 Jul 2020 09:40:43 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 06M7ehZO012870;
        Wed, 22 Jul 2020 09:40:43 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 06M7eeWd012853;
        Wed, 22 Jul 2020 09:40:40 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Laurent.pinchart@ideasonboard.com>, <robh+dt@kernel.org>,
        <a.hajda@samsung.com>, <narmstrong@baylibre.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@siol.net>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>, <praneeth@ti.com>
Subject: [PATCH v7 0/3] drm: Add support for Cadence MHDP DPI/DP bridge and J721E wrapper.
Date:   Wed, 22 Jul 2020 09:40:37 +0200
Message-ID: <1595403640-12816-1-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(36092001)(46966005)(110136005)(8676002)(26005)(82740400003)(54906003)(966005)(478600001)(186003)(2616005)(70206006)(70586007)(83380400001)(4326008)(47076004)(82310400002)(5660300002)(2906002)(36756003)(36906005)(316002)(8936002)(426003)(7416002)(6666004)(336012)(42186006)(81166007)(356005)(86362001)(921003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1f05177-b8f8-4abe-411b-08d82e128fa0
X-MS-TrafficTypeDiagnostic: DM6PR07MB7162:
X-Microsoft-Antispam-PRVS: <DM6PR07MB7162A986E27906ECD6C2C06AC5790@DM6PR07MB7162.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 343w3MTqDrNBcBoZphh4kYG36ihb2Ok/pgyNG8zQ8IRUCVtYBRedsekVPPG9JFZZRxmXpy2jAUTJP0xUfEcgvl0UGTbEeHxiLOHxHMdZJKm1In/wReJeGLOIRvszNOQpsOALLDAo8YyWGz0c63OAJN7Fg3mWca2a7+V0m4Nq9iHPD0sGMgpb9ZnjoreeiRkfwcuUkMz9a+UBZFMaQR8TvZzh/T+PSbFzYwYSSL7CRmgJpSY06GBaf50p4DvFwbH6WbDxsHuLw30Wj6b8M4bUjnyTq/JaoVCuBQyWEDsnMdiaIdbfUQUCnO0MORczIWFvGVFjYLCHiGyI1a8EP9z6G8JcAWD1h05p5dA8GDwLpyS0Ki/yxM2tG9lnsiaXZY6ZNnFwD86f+48GyWqQEHan3/GCDTlhobPZ6boFAkMGOIQQRXC5D6aZMxlISq30GqogqBaPXHHUP7ZKmjPiU5BXJ/j0bY4Lq2uOIOfeHDBagQ24s6ATIrkELOQrIgAB+fd4O+PL4lfYqXTD4Fa+QwpIx6nMjLGUybVCQkPxWHPbiQaQDWpVjCfUETxhcYu06S34
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2020 07:40:52.5279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1f05177-b8f8-4abe-411b-08d82e128fa0
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT022.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB7162
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-22_03:2020-07-22,2020-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 clxscore=1011 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007220057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds new DRM bridge driver for Cadence MHDP DPI/DP
bridge. The Cadence Display Port IP is also referred as MHDP (Mobile High
Definition Link, High-Definition Multimedia Interface, Display Port).
Cadence Display Port complies with VESA DisplayPort (DP) and embedded
Display Port (eDP) standards.

The MHDP bridge driver currently implements Single Stream Transport (SST)
mode. It also adds Texas Instruments j721e SoC specific wrapper and adds
the device tree bindings in YAML format.

Some of the features that will be added later on include (but are not
limited to):
- Power Management (PM) support: We will implement the PM functions in
  next stage once there will be a stable driver in upstream
- Converting to connector bridge operations: This is not supported
  currently because of dependency on TIDSS driver which has some
  limitations in supporting new model
- Audio and MST support

The patch series has three patches in the below sequence:
1. 0001-dt-bindings-drm-bridge-Document-Cadence-MHDP-brid.patch
Documents the bindings in yaml format.
2. 0002-drm-bridge-Add-support-for-Cadence-MHDP-DPI-DP-br.patch
This patch adds new DRM bridge driver for Cadence MHDP Display Port.
The patch implements support for single stream transport mode.
3. 0003-drm-bridge-cdns-mhdp-Add-j721e-wrapper.patch
Adds Texas Instruments (TI) j721e wrapper for MHDP. The wrapper configures
MHDP clocks and muxes as required by SoC.

This patch series is dependent on PHY patch series [1] to add new PHY APIs
to get/set PHY attributes which is under review and not merged yet.

[1] https://lkml.org/lkml/2020/7/17/158

Version History:

v7:

In 1/3
- No change

In 2/3
- Switch to atomic versions of bridge operations
- Implement atomic_check() handler to perform all validation checks
- Add struct cdns_mhdp_bridge_state with subclassed bridge state
- Use PHY API[1] to get PHY attributes instead of reading from PHY DT node
- Updated HPD handling and link configuration in IRQ handler
- Add "link_mutex" protecting the access to all the link parameters
- Add support to check and print FW version information
- Add separate function to initialize host parameters to simplify probe
- Use waitqueue instead of manual loop in cdns_mhdp_remove
- Add forward declarations and header files in cdns-mhdp-core.h file
- Use bool instead of single bit values in struct cdns_mhdp_device
- Fix for other minor comments given for v6 patches

In 3/3
- Use of_device_is_compatible() to set compatible string specific values
- Move mhdp_ti_j721e_ops structure to cdns-mhdp-j721e.c
- Remove duplicate Copyright message
- Remove CONFIG_DRM_CDNS_MHDP_J721E check
- Add Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

v6:
- Added minor fixes in YAML file.
- Added Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
  to the YAML patch.
- Removed all the FIXME comments which are invalid in drm driver.
- Reduced the mailbox timeout from 5s to 2s.
- Added Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
  to the 003-drm-mhdp-add-j721e-wrapper patch.
- Added Signed-off all the module authors.
- Fixed the compiler error Reported-by: kbuild test robot <lkp@intel.com>.

v5:
- Added Signed-off-by: Jyri Sarha <jsarha@ti.com> tag to
  the code patches.

v4:
- Added SPDX dual license tag to YAML bindings.
- Corrected indentation of the child node properties.
- Removed the maxItems in the conditional statement.
- Add Reviewed-by: Rob Herring <robh@kernel.org> tag to the
  Document Cadence MHDP bridge bindings patch.
- Renamed the DRM driver executable name from mhdp8546 to cdns-mhdp in
  Makefile.
- Renamed the DRM driver and header file from cdns-mhdp to cdns-mhdp-core.

v3:
- Added if / then clause to validate that the reg length is proper
  based on the value of the compatible property.
- Updated phy property description in YAML to a generic one.
- Renamed num_lanes and max_bit_rate property strings to cdns,num-lanes
  and cdns,max-bit-rate.

v2:
- Use enum in compatible property of YAML file.
- Add reg-names property to YAML file
- Add minItems and maxItems to reg property in YAML.
- Remove cdns_mhdp_link_probe function to remove
  duplication of reading dpcd capabilities.

Swapnil Jakhade (2):
  drm: bridge: Add support for Cadence MHDP DPI/DP bridge
  drm: bridge: cdns-mhdp: Add j721e wrapper

Yuti Amonkar (1):
  dt-bindings: drm/bridge: Document Cadence MHDP bridge bindings

 .../bindings/display/bridge/cdns,mhdp.yaml    |  127 +
 drivers/gpu/drm/bridge/Kconfig                |   24 +
 drivers/gpu/drm/bridge/Makefile               |    7 +
 drivers/gpu/drm/bridge/cdns-mhdp-core.c       | 2508 +++++++++++++++++
 drivers/gpu/drm/bridge/cdns-mhdp-core.h       |  397 +++
 drivers/gpu/drm/bridge/cdns-mhdp-j721e.c      |   75 +
 drivers/gpu/drm/bridge/cdns-mhdp-j721e.h      |   19 +
 7 files changed, 3157 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp-core.c
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp-core.h
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp-j721e.c
 create mode 100644 drivers/gpu/drm/bridge/cdns-mhdp-j721e.h

-- 
2.26.1

