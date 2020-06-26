Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7ADC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3992F20768
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Phip5v07";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Cg3QnW8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgFZE4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 00:56:32 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:36060 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725975AbgFZE4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 00:56:31 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05Q4rM22017009;
        Thu, 25 Jun 2020 21:55:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=proofpoint;
 bh=/VQM8ZXurK9AHUQUSXOUAs/tOAu0Ef4cVMZbjZpuo/Y=;
 b=Phip5v07rMX0gPxTHo60xOwuM4HOZMjP66vsn7BM1N9oYrAVDiNR8dr/B17kYqjY+iRI
 jIeNiCfPCkcH98t65uOMjeji5VDdFsITO4aJsvAoSN43YW2fOM2k3ghrxbvrgP1n/d4w
 3wGLrY+FG99mGa/RcgqadRx4GT+ahJAYkYd3EbO8Fi3S4l7frFFc7Bklx94LjuDCIzxB
 yrq7eK+uAXKJb4VnmlFNVDWVa1cfspsJ27xgekx5yQqPNgGY7BQKzSKsPHtnw4GAXTKw
 5iomWGo2RwPVqzZOpjWn00JQTQLonF8V+xzs2U8lg5maqSSicUxnF+UGDMWstAtXlvRy vw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0a-0014ca01.pphosted.com with ESMTP id 31uur5sh5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 21:55:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZzivU8uKAYO2v0SIyToDKu6iEP/VBPK6hjoFePY7TqRN4jrbrd6z92rjchnY4ObiPvVHcq+QpZv5QlwOj8W50gD5E1XPevXil/MBzV3JjD/EF87V1LX7k1+wN0HNzs0HBKAqquB3f6xzoLjEvCXEe3LRBAdbQOeSyRi41eabaUHS5Svw1pPbzQOaDsl1NDUALgij5Tq6Ge/pxbtPnDLXwwUNf0wN0qNF0jLAHAyw8sRjKHQ1K2+MV9jjY6qyB4wflGjNY+uNCyQ7TwDzLqLwwXO/QrgjiWD+33vtPDqjknZiqsiDSU5Qxz0JdS0k07NrCM3G1pAL0L2H/y3YyIuBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VQM8ZXurK9AHUQUSXOUAs/tOAu0Ef4cVMZbjZpuo/Y=;
 b=l2ROx8V3CwhI22gLHDpqhTtpQA7OBRw1+SQE0WNH2lpoW+R7/1ul80zY0iTXxD2a0CeixYYKt6cgtQiyg2IeqMbQdmwr2Dj1HHVhDrjh8Pe0YNlA2UV/AN+yXg2CUUidZNkEj6+DdBxD6Cxfzy/YP/7FqYaby1uqrX38t5W7xTQYv0bGktxRxb4D9yHfHhYY90MM38N4YsbsQlbgFlXWjdxKTGkATMtvyR2iiHG97nlbGH4xNHh7rvMtsdJqPHbnOs5qQrJPGVsdP82q/5f1WyYHLNrlPtEP4yeNhrR+6CKQrY8KKYALBnY1yKKTRAhzsN04GswY4oCArPziGlceJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VQM8ZXurK9AHUQUSXOUAs/tOAu0Ef4cVMZbjZpuo/Y=;
 b=Cg3QnW8Is0cAoeYsLg4g3kRHleSJEezvRxX7TJsGqzgxnhWRqthbGbryT5pXt1We5ntUKIxhygzE6JiWzLJJKH75eATMrX18wkLL2XqViEIX8t21diUzXwqvF1uB29N+apdxYjLOCpjpwUn6t8PBiSx4JaQpVIoEHOqd4PWUXHU=
Received: from DM3PR12CA0122.namprd12.prod.outlook.com (2603:10b6:0:51::18) by
 BYAPR07MB4920.namprd07.prod.outlook.com (2603:10b6:a03:59::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20; Fri, 26 Jun 2020 04:55:54 +0000
Received: from DM6NAM12FT027.eop-nam12.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::5d) by DM3PR12CA0122.outlook.office365.com
 (2603:10b6:0:51::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Fri, 26 Jun 2020 04:55:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT027.mail.protection.outlook.com (10.13.178.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.13 via Frontend Transport; Fri, 26 Jun 2020 04:55:53 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 05Q4tnk9202776
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Thu, 25 Jun 2020 21:55:51 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 26 Jun 2020 06:55:49 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 26 Jun 2020 06:55:49 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 05Q4tmcp010920;
        Fri, 26 Jun 2020 06:55:48 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 05Q4tiwo010902;
        Fri, 26 Jun 2020 06:55:44 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <balbi@kernel.org>, <devicetree@vger.kernel.org>
CC:     <dan.carpenter@oracle.com>, <ben.dooks@codethink.co.uk>,
        <colin.king@canonical.com>, <rogerq@ti.com>, <peter.chen@nxp.com>,
        <weiyongjun1@huawei.com>, <jpawar@cadence.com>,
        <kurahul@cadene.com>, <sparmar@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH RFC 0/5] Introduced new Cadence USBSSP DRD Driver.
Date:   Fri, 26 Jun 2020 06:54:45 +0200
Message-ID: <20200626045450.10205-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(36092001)(46966005)(186003)(26005)(54906003)(8936002)(8676002)(70586007)(70206006)(110136005)(336012)(426003)(7416002)(107886003)(316002)(4326008)(36906005)(1076003)(42186006)(478600001)(36756003)(5660300002)(82740400003)(83380400001)(82310400002)(47076004)(81166007)(86362001)(2616005)(356005)(2906002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9335667-61b8-4771-3890-08d8198d344d
X-MS-TrafficTypeDiagnostic: BYAPR07MB4920:
X-Microsoft-Antispam-PRVS: <BYAPR07MB4920D192C31FF65E1F377BA8DD930@BYAPR07MB4920.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: unlaVhqUjGpAFe6ihnfIuyizTSj8iSFx+B4G604L5KD+J3YX5VUt7VTtOIFHVi0BQMzXqlDSwDHxshvVe70nBIs9OBD2xM8xfa2gjRUQMG0fnRzoflDSPXEDr4k81UJeyIBQV9nnvLZoZM6+2ywZjh+4CoCaEIodsnsuFINWDdz2zUhsYE/ujNXndLkF2sshcyX9r9WskhTFBj6VlMcKPh8yCKnf5NO9UPiPAWahgWvPL5zCLteUZGqF0rbxvbRdaciQjtsthtHR+9BGd8gz5nVhS6u89A9YAHWVgXPP1VJwWtTui0A/2gcgP/xS3nLBeuz2OvZ6NUlx3fMcMxvQcJpXF1A1m6uz0tiq5KAxBhrxOTuOS6gnezlV2IwR2/LfmgZ8QulqwiNhsI9Wgm7xgksGa0tOpi4vmddESCQgz+E=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 04:55:53.0344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9335667-61b8-4771-3890-08d8198d344d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT027.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4920
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-26_01:2020-06-26,2020-06-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 mlxlogscore=628 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 suspectscore=0 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006260034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduce new Cadence USBSS DRD driver to linux kernel.

The Cadence USBSS DRD Controller is a highly configurable IP Core which
can be instantiated as Dual-Role Device (DRD), Peripheral Only and
Host Only (XHCI)configurations.

The current driver has been validated with FPGA burned. We have support
for PCIe bus, which is used on FPGA prototyping.

The host side of USBSS-DRD controller is compliance with XHCI
specification, so it works with standard XHCI Linux driver.

The host side of USBSS DRD controller is compliant with XHCI.
The architecture for device side is almost the same as for host side,
and most of the XHCI specification can be used to understand how
this controller operates.

This controller and driver support Full Speed, Hight Speed, Supper Speed
and Supper Speed Plus USB protocol.

The prefix cdnsp used in driver has chosen by analogy to cdn3 driver.
The last letter of this acronym means PLUS. The formal name of controller
is USBSSP but it's to generic so I've decided to use CDNSP.

The patch 1: adds DT binding.
The patch 2: adds PCI to platform wrapper used on Cadnece testing
             platform. It is FPGA based on platform.
The patches 3-5: add the main part of driver and has been intentionally
             split into 3 part. In my opinion such division should not
             affect understanding and reviewing the driver, and cause that
             main patch (4/5) is little smaller. Patch 3 introduces main
             header file for driver, 4 is the main part that implements all
             functionality of driver and 5 introduces tracepoints.

---

Pawel Laszczak (5):
  dt-bindings: add binding for CDNSP-DRD controller
  usb:cdns3: Add pci to platform driver wrapper
  usb: cdnsp: Device side header file for CDNSP driver
  usb: cdnsp: usb:cdns3 Add main part of Cadence USBSSP DRD Driver
  usb: cdnsp: Add tracepoints for CDNSP driver

 .../devicetree/bindings/usb/cdns-cdnsp.yaml   |  104 +
 drivers/usb/Kconfig                           |    1 +
 drivers/usb/Makefile                          |    1 +
 drivers/usb/cdnsp/Kconfig                     |   49 +
 drivers/usb/cdnsp/Makefile                    |   15 +
 drivers/usb/cdnsp/cdnsp-pci.c                 |  214 ++
 drivers/usb/cdnsp/core.c                      |  632 +++++
 drivers/usb/cdnsp/core.h                      |   90 +
 drivers/usb/cdnsp/debug.h                     |  583 ++++
 drivers/usb/cdnsp/drd.c                       |  372 +++
 drivers/usb/cdnsp/drd.h                       |  127 +
 drivers/usb/cdnsp/ep0.c                       |  482 ++++
 drivers/usb/cdnsp/export.h                    |   36 +
 drivers/usb/cdnsp/gadget.c                    | 1990 ++++++++++++++
 drivers/usb/cdnsp/gadget.h                    | 1586 +++++++++++
 drivers/usb/cdnsp/host.c                      |   74 +
 drivers/usb/cdnsp/mem.c                       | 1340 +++++++++
 drivers/usb/cdnsp/ring.c                      | 2443 +++++++++++++++++
 drivers/usb/cdnsp/trace.c                     |   12 +
 drivers/usb/cdnsp/trace.h                     |  839 ++++++
 20 files changed, 10990 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/cdns-cdnsp.yaml
 create mode 100644 drivers/usb/cdnsp/Kconfig
 create mode 100644 drivers/usb/cdnsp/Makefile
 create mode 100644 drivers/usb/cdnsp/cdnsp-pci.c
 create mode 100644 drivers/usb/cdnsp/core.c
 create mode 100644 drivers/usb/cdnsp/core.h
 create mode 100644 drivers/usb/cdnsp/debug.h
 create mode 100644 drivers/usb/cdnsp/drd.c
 create mode 100644 drivers/usb/cdnsp/drd.h
 create mode 100644 drivers/usb/cdnsp/ep0.c
 create mode 100644 drivers/usb/cdnsp/export.h
 create mode 100644 drivers/usb/cdnsp/gadget.c
 create mode 100644 drivers/usb/cdnsp/gadget.h
 create mode 100644 drivers/usb/cdnsp/host.c
 create mode 100644 drivers/usb/cdnsp/mem.c
 create mode 100644 drivers/usb/cdnsp/ring.c
 create mode 100644 drivers/usb/cdnsp/trace.c
 create mode 100644 drivers/usb/cdnsp/trace.h

-- 
2.17.1

