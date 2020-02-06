Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E04C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70815206CC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="sw9yRna2";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="tQ2XdMmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgBFGLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 01:11:25 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:1184 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbgBFGLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 01:11:24 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01669Ba2015932;
        Wed, 5 Feb 2020 22:11:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=1L1lPHWngfNOZB7Ymix8XhOm1MlmRT1GZmmUptZM7LE=;
 b=sw9yRna2wo2cj/KwEEBFIS3FLmmbUE5SXExtSFfA3DIxqph/VLGF+Yo7zYBWpjUdBFKv
 FsC4HMOOh/dgXpfSwzGoMy69jtffgzrKeXEjES0IjUQ2KSQJAZttiz4JHeP7LtdKLsr1
 Vv45IXPIxbi9CuofqkywzzUvMr7KLj8nhZDONGFmrNk+88MD9SfY7b7RKt2PNfLNyZZx
 NT3F9vx3GN1QTBArxgbE/J8OKievHWkQps8Lnv2q26ThlleRbZ+mpjwk84ThrPOYzcLZ
 jvjqRQ+rIzEJrqQE2XTGKlJdnEPPYgT9UvQpsy9I2uF47ClBv83NNvHBmJi6kTLHwhhF Sg== 
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2051.outbound.protection.outlook.com [104.47.46.51])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2xyhkunran-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 22:11:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFJdAhHYzwQNygPyPPVfUj5kSTa7EhHrYCuFQH6S1SzFnPR3EazgV8zQcNEdGvitU2fvgm+IW0oi43/kTa6P25uy86GE6Jhvkfs2fEriKKdnlUXAw2prDU/MV8097ii9mu9T3MP3ignmkQZCs91rytA7fQYF4fmQqcxhNdNMSIPZCixlS43cSJ9F6vhXsbZTSMip7n9DE2Trnc5MCIaaeOqucKE9obP2u/RpOGph5FmRpuQnJoTy9OBkrzcaazHYR0UveAW0seTZDoK0eABN90rLvK7xkawiUqNploHzguSaSSdfNPcLaZtYPHEpvbsTG4C+EtPxVgjEE/PkyUXGeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1L1lPHWngfNOZB7Ymix8XhOm1MlmRT1GZmmUptZM7LE=;
 b=X1fuN4by08ra6fSEbf6Fc2RCIG3sSKRlgF2emwUviIIUk1Q1pFKFuKdc4QXcWYqwgmAq/B+vAaBgYUi0aKz5EAq7bCRiUjyhbwneSIuXsDcWKBWKdKZKy8dbsvKaCmY1c49h8Gvzyhz63kWDSYlYht0wadNSe+Nzc4TgyZ3EzgYvr5S0YccTssnGZntQsA/R4JXOf8rvJ83HiSKK+WirK1A6gAX00IFi4uv05STbBg2DwTJGDfQ1bjM8XlQpIT6ImUd3wokuWzTFBHRp6D0P3bynhBQAGO3Ara99j2wlnYyqY9iXhgUlmNx3yfAAa35sbqpfbNmcWVk7LlUNVd6t7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1L1lPHWngfNOZB7Ymix8XhOm1MlmRT1GZmmUptZM7LE=;
 b=tQ2XdMmxq1ZkGgL0qUubxw/ScZKqnCVPfvjNtxDXi32lsvN1lat8+OX/ytqPrRwg5JQsvqij8cMEtN6D1OeQ9imzVlwMFp/JQa9MbWAluc0fGOBzk73S3uMs2bnUahphhhlzxy+lHhXlBOadRkrRpOcbbLoBATn6bbIOS6c+LmY=
Received: from CH2PR07CA0007.namprd07.prod.outlook.com (2603:10b6:610:20::20)
 by MN2PR07MB6013.namprd07.prod.outlook.com (2603:10b6:208:ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.29; Thu, 6 Feb
 2020 06:11:12 +0000
Received: from MW2NAM12FT023.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::205) by CH2PR07CA0007.outlook.office365.com
 (2603:10b6:610:20::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Thu, 6 Feb 2020 06:11:12 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 MW2NAM12FT023.mail.protection.outlook.com (10.13.180.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.10 via Frontend Transport; Thu, 6 Feb 2020 06:11:11 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0166B5F2174490
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 5 Feb 2020 22:11:10 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 6 Feb 2020 07:11:03 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 6 Feb 2020 07:11:03 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0166B2QJ017021;
        Thu, 6 Feb 2020 07:11:02 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0166B18p017020;
        Thu, 6 Feb 2020 07:11:01 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v4 00/13] PHY: Update Cadence Torrent PHY driver with reconfiguration
Date:   Thu, 6 Feb 2020 07:10:48 +0100
Message-ID: <1580969461-16981-1-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(376002)(346002)(199004)(36092001)(189003)(426003)(86362001)(336012)(478600001)(15650500001)(107886003)(5660300002)(70586007)(19627235002)(2906002)(2616005)(70206006)(8676002)(81156014)(81166006)(36756003)(4326008)(26005)(316002)(110136005)(36906005)(54906003)(8936002)(186003)(6666004)(356004)(42186006)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR07MB6013;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:unused.mynethost.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb8af484-8032-4700-f5a8-08d7aacb5d4f
X-MS-TrafficTypeDiagnostic: MN2PR07MB6013:
X-Microsoft-Antispam-PRVS: <MN2PR07MB6013409FD4F5325173542A54D21D0@MN2PR07MB6013.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0305463112
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uF1hTsfZ0NQ+1mIa4AeCarIJUu7t/G6BvtW68tV7jeFZKXIBIyuFNrwyqxo1pgjwgsAaSRiqIb4AKuO6GqDeQ8bSpLy58O3RyXF0pdd5MRaP4Eq/A62AncauKgneNyPFtux6bHP5m9XvB1oPN9RhrlakK5LLT7rgNpwjV0bcT3F4AKqGrfles4X7rk0l3RQLO78S7Z4B1YE2xkzrCRG5FMsr8SczwWK9xuNHNZG0KX+rKHD5QwcW854/xcTJ2Y4dA42dZ/XViA3hYZq3atIzn8Shms7xVzvmISjkayoGwtgbKDBeycEt6cc+06N3xu9eZ1XgVdu6LMZUX8xkecK7KxaUbeJTxHH7lCqR2BBKsKsmM/WeG120r/ZApNK6WDZXEinoDZWu0iCtBoLSPbWhl24pVRvc03Jm17G/dC/GawJ7HCztdICQ0JCKWiaGqV9F6WOzywT//QTMO8j/qI3yzNC9u8OysEumnenXHPhgQsfYFkqzFkc4FYINYb8+ZTNIXBEX7b60KB05+P56b+oTzi0J0h9BktZtnKixX68BWmj3xlOqdvrphK0kFtEjQ1T9vpE08Stwda8ZKg1FQZCqEg==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 06:11:11.6259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8af484-8032-4700-f5a8-08d7aacb5d4f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6013
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_06:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series applies to the Cadence SD0801 PHY driver.
Cadence SD0801 PHY is also known as Torrent PHY. Torrent PHY
is a multiprotocol PHY supporting PHY configurations including
Display Port, USB and PCIe.

This patch series converts SD0801 PHY driver for DisplayPort into a
generic Torrent PHY driver, updates DisplayPort functionality with
reconfiguration support and finally adds platform dependent initialization
for TI J7 SoCs.

The patch series has following patches which applies the changes
in the below sequence
1. 001-dt-bindings-phy-Remove-Cadence-MHDP-PHY-dt-binding
This patch removes the MHDP PHY binding.
2. 002-dt-bindings-phy-Add-Cadence-MHDP-PHY-bindings-in-YAML-format.
This patch converts the MHDP PHY device tree bindings to yaml schemas
3. 003-phy-cadence-dp-Rename-to-phy-Cadence-Torrent
Rename Cadence DP PHY driver from phy-cadence-dp to phy-cadence-torrent
4. 004-phy-cadence-torrent-Adopt-Torrent-nomenclature
Update private data structures, module descriptions and functions prefix to Torrent
5. 005-phy-cadence-torrent-Add-wrapper-for-PHY-register-access
Add a wrapper function to write Torrent PHY registers to improve code readability.
6. 006-phy-cadence-torrent-Add-wrapper-for-DPTX-register-access
Add wrapper functions to read, write DisplayPort specific PHY registers to improve code
readability.
7. 007-phy-cadence-torrent-Refactor-code-for-reusability
Add separate function to set different power state values.
Use of uniform polling timeout value. Check return values of functions for error handling.
8. 008-phy-cadence-torrent-Add-19.2-MHz-reference-clock-support
Add configuration functions for 19.2 MHz reference clock support. Add register configurations
for SSC support.
9. 009-phy-cadence-torrent-Implement-phy-configure-APIs
Add PHY configuration APIs for link rate, number of lanes, voltage swing and pre-emphasis values.
10. 010-phy-cadence-torrent-Use-regmap-to-read-and-write-Torrent-PHY-registers 
Use regmap for accessing Torrent PHY registers. Update register offsets. Abstract address
calculation using regmap APIs.
11. 011-phy: cadence-torrent-Use-regmap-to-read-and-write-DPTX-PHY-registers
Use regmap to read and write DPTX specific PHY registers.
12. 012-phy-cadence-torrent-Add-platform-dependent-initialization-structure
Add platform dependent initialization data for Torrent PHY used in TI's J721E SoC.
13. 013-phy: cadence-torrent-Add-support-for-subnode-bindings
Implement single link subnode support to the phy driver.

Version History:

v4:
- Add separate patch to remove old binding.
- Add new patch to add new binding in YAML format.
- Squashed "dt-bindings: phy: phy-cadence-torrent: Add platform dependent
  compatible string" with "dt-bindings: phy: Add Cadence MHDP PHY bindings
  in YAML format".
- Added SPDX dual license tag to YAML bindings.
- Updated resets property description and removed reset-names
  property.
- Added enum to cdns,phy-type property adding all the currently
  known phy-type values.
- Updated the child node resets property to support one reset
  per lane.
- Added default values for cdns,num-lanes and cdns,max-bit-rate properties.


v3:
- Removed "Add clock binding" patch from the series and merged it with
  "Convert-Cadence-MHDP-PHY-bindings-to-YAML" patch.
- Added reset and reset-names properties to YAML file.
- Updated dptx_phy reg entry as optional in YAML.
- Renamed reg-names from sd0801_phy to torrent_phy.
- Added subnode property for each group of PHY lanes based on PHY
  type to the YAML. Renamed num_lanes and max_bit_rate to cdns,num-lanes
  and cdns,max-bit-rate and moved it to subnode properties.
- Added cdns,phy-type property in subnode. Currently cdns,phy-type supports only
  PHY_TYPE_DP.
- Added subnode instance structure to the driver in reference to the dts change.
- Updated functions to read properties from child node instead of parent node.
- Added num_lanes as argument to the cdns_torrent_dp_run function.

v2:
- Remove patch [1] from this series and send for a separate review.
- Use enum in compatible property of YAML file.
- Remove quotes in clock-names property "refclk" -> refclk in YAML file.
- Add reg-names property to YAML file
- Add additionalProperties:false to YAML file.
- No change in the driver code.

This patch series is dependent on PHY DisplayPort configuration patch [1].

[1]

https://lkml.org/lkml/2020/1/6/279

Swapnil Jakhade (10):
  phy: cadence-torrent: Adopt Torrent nomenclature
  phy: cadence-torrent: Add wrapper for PHY register access
  phy: cadence-torrent: Add wrapper for DPTX register access
  phy: cadence-torrent: Refactor code for reusability
  phy: cadence-torrent: Add 19.2 MHz reference clock support
  phy: cadence-torrent: Implement PHY configure APIs
  phy: cadence-torrent: Use regmap to read and write Torrent PHY
    registers
  phy: cadence-torrent: Use regmap to read and write DPTX PHY registers
  phy: cadence-torrent: Add platform dependent initialization structure
  phy: cadence-torrent: Add support for subnode bindings

Yuti Amonkar (3):
  dt-bindings: phy: Remove Cadence MHDP PHY dt binding
  dt-bindings: phy: Add Cadence MHDP PHY bindings in YAML format.
  phy: cadence-dp: Rename to phy-cadence-torrent

 .../bindings/phy/phy-cadence-dp.txt           |   30 -
 .../bindings/phy/phy-cadence-torrent.yaml     |  143 ++
 drivers/phy/cadence/Kconfig                   |    6 +-
 drivers/phy/cadence/Makefile                  |    2 +-
 drivers/phy/cadence/phy-cadence-dp.c          |  541 -----
 drivers/phy/cadence/phy-cadence-torrent.c     | 1944 +++++++++++++++++
 6 files changed, 2091 insertions(+), 575 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
 delete mode 100644 drivers/phy/cadence/phy-cadence-dp.c
 create mode 100644 drivers/phy/cadence/phy-cadence-torrent.c

-- 
2.20.1

