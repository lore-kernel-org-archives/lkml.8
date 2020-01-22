Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A8FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30CF0205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="DUpEDcut";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Qp6d6UpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbgAVKrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:47:17 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:2414 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729049AbgAVKpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:45:38 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00MAisss016512;
        Wed, 22 Jan 2020 02:45:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=y1kqsuYzbdxg3KZETBS7aGnf9p+p3rm9WsYiQeiOKG8=;
 b=DUpEDcut4KPv6KhrRV/qXSYJQaVoI1WVFyEAv5cw3RMRIHhirExwECgiHl/ULldInwFF
 turPwQyc8ZGUpTKA26HTrs05/rbqbQdp1DAbbFr9eM9QEQMlwEQgc9dfqW8WZ7BJtl4t
 o4cp69hLYDLpYIKh8oiFD/Se5aupzjZGXO/Gh/zAcJ7TtPZCL0rZkXdzv9+EawPot8EJ
 bfLbo7Tj7EsO7u5jfY0KR7HuCP3GMNjHK0fOZPdv8o68ijajKXokbvzinzJFzI9qh5VU
 lBj6rjDr9+OBmf8O6gb7XF3vkJjKK6cpcTNjp7tgLIXUkOnax+TwcRFdMxL+u33tXdrS Pw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2xkxg3vssh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jan 2020 02:45:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSDzaXW9s577DNOhkFiqMAiZStvLeTFg4mOrkvXRvJVjkYavAMrZi+o1LhE/F4iBT6J/0TngVumxDVfVQ1YVKA9LrYm1w/WxTpWk8NEIgmG2obWw8xW8KSbaEE5Lvp73I415fAwqcOBb1tT7YpxJIjlfOvwi+6RuJg4aAU8DZYSGWmhuUm1MzH59RtPWO0UbIAE0+FjlXWgARRIlIKi4Pexm8xGcWZWoeAX/j3bxTH7bMtfP01PLZMbSVYKTdCdAsrgzaj48bhmv5nHPicmhEwxroSfKUZl2Gj2HIM+eWus8BpcZucYJFzRvMePwYjtAqT1NKyb6QqQjgejACHzuzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1kqsuYzbdxg3KZETBS7aGnf9p+p3rm9WsYiQeiOKG8=;
 b=N5EXKdmE3Qm/JiMmARromE8UGtYswY5DAVbSi7EMqQOO7vhNYPpXUhh1Ku8sXjwahTdgBscwkjGtfrulkeIpTmEONLWtdopHJ3PjvW+/Zc7l1gxUK9pidEuNCOZnEOYq5OhsP9Mw+mfceRF+x+q2V4be6sccaUjlOUvufLurF0Pf1kH9xI+YeYpUX0r9bzggZEGntRpUqjAsYM734grbyDqMhGoRlT/4KWNvfzkv1iiI7lEUuZgtbYOZZqpydG5/H/W6/rXczG36Byj7/j1rDV8X/a3JKl4/7+L5HaQ5EgYjn5gG8X2IQs4+nkb27Ics8eIeKBHzaHcRXUvmvqE6qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1kqsuYzbdxg3KZETBS7aGnf9p+p3rm9WsYiQeiOKG8=;
 b=Qp6d6UpNg0lCrPnzkw7FgK5RjzEbCUWSLvIzkcdp4S/jcq27dGoy9Jg4ePNPG91l03WQ7tL1tSLiv4o1quVwyWrYCrViJPl+NK3clUWNO+xDOOxnBMthqix6Dqsa8uHa1ug8P8mXxP5hMYwqfM1PIlEQLPw65dYGqmNFC3A6CDo=
Received: from DM5PR07CA0078.namprd07.prod.outlook.com (2603:10b6:4:ad::43) by
 BL0PR07MB5458.namprd07.prod.outlook.com (2603:10b6:208:83::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Wed, 22 Jan 2020 10:45:23 +0000
Received: from DM6NAM12FT046.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe59::207) by DM5PR07CA0078.outlook.office365.com
 (2603:10b6:4:ad::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Wed, 22 Jan 2020 10:45:23 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.28; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM6NAM12FT046.mail.protection.outlook.com (10.13.178.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.6 via Frontend Transport; Wed, 22 Jan 2020 10:45:23 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 00MAjKB9001726
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 22 Jan 2020 02:45:21 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 22 Jan 2020 11:45:19 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 22 Jan 2020 11:45:19 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 00MAjJQA007234;
        Wed, 22 Jan 2020 11:45:19 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 00MAjIRD007232;
        Wed, 22 Jan 2020 11:45:18 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v3 00/14] PHY: Update Cadence Torrent PHY driver with reconfiguration
Date:   Wed, 22 Jan 2020 11:45:04 +0100
Message-ID: <1579689918-7181-1-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(199004)(189003)(36092001)(8936002)(336012)(2906002)(478600001)(15650500001)(186003)(7636002)(26005)(19627235002)(4326008)(5660300002)(36756003)(70586007)(70206006)(42186006)(6666004)(316002)(356004)(54906003)(2616005)(966005)(426003)(26826003)(110136005)(107886003)(86362001)(246002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR07MB5458;H:sjmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d65ecc9e-18fa-4c24-fb5e-08d79f282f45
X-MS-TrafficTypeDiagnostic: BL0PR07MB5458:
X-Microsoft-Antispam-PRVS: <BL0PR07MB54589A7640C86323261CBFDDD20C0@BL0PR07MB5458.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 029097202E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mRXy74N+pWPct+701gGcpFcis9WoaOMnJlrYze8Nypsq8KzmXL72h2O4R7MXuPDkZw9HtpznUYGtOUou/jYKXDjcRlUDsoJ8hI9V+Omh/a0aLMduvObAxMSvPrgLlIzCTE7zZ2PfiizKhb4HtlZG3tkGZ2GAFDLsAvTd3PI2tCmCoIdgg9azJIQVfrRijAie8MNmfXJCO1Apkhwo5TntyTWDXJYWYskGoPp1ihRWiSOietQ6i31e9u/3P5sJybgra6PNO1rW+bgmiV47ROsuQGiFAWL0Td1rdrUwe+hXAbtIM8LSNx9ebkmADrm1AHcWI3fJ0Gm5yQltgcOV1rRQT+yhSRZNUuFNxXkRY2OQrxK3T6/Xbjpvj/MBmEnvY6MaACCujdobJbGNLUXEQrGFwTGc2yqsW7ly3aDGYGTavZ2PpCuoFmFLH6AQycl1g59AW9Rzfr9xwnVyZoHSWVezH0CmlpgfACziFv1d9cp3YwxE7xVON7PP2F9bUCo42AR3XcX0msNAOMiSoTlo6N6v2H4CPVw51hSpQhZdNTALvoE=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 10:45:23.5738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d65ecc9e-18fa-4c24-fb5e-08d79f282f45
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB5458
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 clxscore=1011 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001220098
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
1. 001-dt-bindings-phy-Convert-Cadence-MHDP-PHY-bindings-to-YAML
This patch converts the MHDP PHY device tree bindings to yaml schemas
2. 002-phy-cadence-dp-Rename-to-phy-Cadence-Torrent
Rename Cadence DP PHY driver from phy-cadence-dp to phy-cadence-torrent
3. 003-phy-cadence-torrent-Adopt-Torrent-nomenclature
Update private data structures, module descriptions and functions prefix to Torrent
4. 004-phy-cadence-torrent-Add-wrapper-for-PHY-register-access
Add a wrapper function to write Torrent PHY registers to improve code readability.
5. 005-phy-cadence-torrent-Add-wrapper-for-DPTX-register-access
Add wrapper functions to read, write DisplayPort specific PHY registers to improve code
readability.
6. 006-phy-cadence-torrent-Refactor-code-for-reusability
Add separate function to set different power state values.
Use of uniform polling timeout value. Check return values of functions for error handling.
7. 007-phy-cadence-torrent-Add-19.2-MHz-reference-clock-support
Add configuration functions for 19.2 MHz reference clock support. Add register configurations
for SSC support.
8. 008-phy-cadence-torrent-Implement-phy-configure-APIs
Add PHY configuration APIs for link rate, number of lanes, voltage swing and pre-emphasis values.
9. 009-phy-cadence-torrent-Use-regmap-to-read-and-write-Torrent-PHY-registers 
Use regmap for accessing Torrent PHY registers. Update register offsets. Abstract address
calculation using regmap APIs.
10. 010-phy: cadence-torrent-Use-regmap-to-read-and-write-DPTX-PHY-registers
Use regmap to read and write DPTX specific PHY registers.
11. 011-dt-bindings-phy-phy-cadence-torrent-Add-platform-dependent-compatible-string
Add a new compatible string used for TI SoCs using Torrent PHY.
12. 012-phy-cadence-torrent-Add-platform-dependent-initialization-structure
Add platform dependent initialization data for Torrent PHY used in TI's J721E SoC.
13. 013-phy-cadence-torrent-dt-bindings-Add-subnode-bindings. 
Add sub-node bindings.
14. 014-phy: cadence-torrent-Add-support-for-subnode-bindings
Implement single link subnode support to the phy driver.

Version History:

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

Swapnil Jakhade (11):
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
  dt-bindings: phy: phy-cadence-torrent: Add subnode bindings.
  phy: cadence-torrent: Add support for subnode bindings

Yuti Amonkar (3):
  dt-bindings: phy: Convert Cadence MHDP PHY bindings to YAML.
  phy: cadence-dp: Rename to phy-cadence-torrent
  dt-bindings: phy: phy-cadence-torrent: Add platform dependent
    compatible string

 .../devicetree/bindings/phy/phy-cadence-dp.txt     |   30 -
 .../bindings/phy/phy-cadence-torrent.yaml          |  140 ++
 drivers/phy/cadence/Kconfig                        |    6 +-
 drivers/phy/cadence/Makefile                       |    2 +-
 drivers/phy/cadence/phy-cadence-dp.c               |  541 ------
 drivers/phy/cadence/phy-cadence-torrent.c          | 1945 ++++++++++++++++++++
 6 files changed, 2089 insertions(+), 575 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
 delete mode 100644 drivers/phy/cadence/phy-cadence-dp.c
 create mode 100644 drivers/phy/cadence/phy-cadence-torrent.c

-- 
2.4.5

