Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4935FC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 07:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09F27207BC
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 07:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Xigl28Pk";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="DgseZLHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbgEaHMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 03:12:09 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:56766 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726220AbgEaHMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 03:12:08 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04V76bnE003483;
        Sun, 31 May 2020 00:12:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=Y/z8XqHEP4KBRQdKHHWNggjXLYKL2v6uCTDIZ/rpu1o=;
 b=Xigl28PkzhgnzxOsWgEF2b974ZfEPLOBAPqJbiVpn4PxujFXVVV08JwL5dy221ytlZ90
 a0rzuR2D2aQos/JEnsWNk35C+7A9UY23iJ/yMzXhYLqlIy2juWwK5FHiHz7Y+kW0jiCY
 jYdo3EAYqFRQ9nH87vMdPh7DLBt4APYSxhkR7+/FWklg5utVAKNVLFNU+3rww6ZzyFGA
 w5g9CCPB5xgMHLYtcVD4wy3/MYVH1Q/OobNkU030YNBMVw+RBlEmkiC0XyhaAPGQQKro
 vioNXycC4pPF98bBEHalUTGvVQu1xSXdRR7jFVx4UG19y+rv5ZOxdKCSfcr0Up1zt0XM wg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0a-0014ca01.pphosted.com with ESMTP id 31bm1wjft0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 31 May 2020 00:12:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mj2TeQcCrsQCIaIOIjf1vokWQrKjJpua2AyS5oxpffPt/PtuGiPNKwLtUEegZcjWAoAZjKfOCPA61zJRLBLF2AzeThI2JLTqxox4wQe8mhMu74n6vxldTnZdNT9KcrhlNX+yvkgvExZHcLUi1Ydgzs9mFAh3tqpiN9r/poF3SXfeao0LFu78DwfXUDFWUKUEHIIw0UODDkYXo/d0kd7M3N2I6XyvnqttzJzLo9aGZJwApSlvkNulS8tQJwt16144AaQqQtjaKrAd6OhN+cEW4o70cMhF8eGh/SzxJ5awCBMh9WcuPhWOKJLhEuCtunK4Py7EGTWJJH+QJFIHC2hyMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/z8XqHEP4KBRQdKHHWNggjXLYKL2v6uCTDIZ/rpu1o=;
 b=fQhj6k2R/W6LuUbUwGZl6uTmIUxoPIN+8MDxSv17Mv0yJ4cjvJprj7OFDuLrDuXzURA2bKszh054WVEHKtoNzh21L4V2N3W5Mnr2ZX86RH/tDsJ88/YuXX+S2ffAO6HO8GoBHUqsx1pABJW0uC1YPa9CJsvTWBTPFdCCs89bzFg580lE4M0C7bzk30RWZFhdlVr+ncSv5LfT8CXXk0s9FZ5dPqXlqg91LhrCSruS8P8UX/BQJ+9+sDjmGZcOASP1FoGI+a4OVbHT/GA9FGjz0NHb2rXy8JEsFYYoL2pn+e+FrnKUJFDc0Yi93jWsKI0oGtrOLky+o5hEGDCtWdit3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/z8XqHEP4KBRQdKHHWNggjXLYKL2v6uCTDIZ/rpu1o=;
 b=DgseZLHHLptW3WlrJYOJ2l0/cQyk2AdR3EedJzD1JUn0+8dNcK67quliw8I8YN8DhN5R2cRF7hXqrGzgi5NHsw9OqB9IWBWiNQwzlC320qQOQeVmHhUnm9otbxrNRQlzNj5Oj1CbZXjToa8ew2ljkI8fJG3QoLM9ibZCEJHTMqU=
Received: from BN6PR03CA0087.namprd03.prod.outlook.com (2603:10b6:405:6f::25)
 by MWHPR07MB3437.namprd07.prod.outlook.com (2603:10b6:301:63::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Sun, 31 May
 2020 07:11:57 +0000
Received: from BN8NAM12FT031.eop-nam12.prod.protection.outlook.com
 (2603:10b6:405:6f:cafe::64) by BN6PR03CA0087.outlook.office365.com
 (2603:10b6:405:6f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend
 Transport; Sun, 31 May 2020 07:11:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT031.mail.protection.outlook.com (10.13.183.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.8 via Frontend Transport; Sun, 31 May 2020 07:11:56 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 04V7BqEu019608
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 31 May 2020 00:11:54 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sun, 31 May 2020 09:11:52 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 31 May 2020 09:11:52 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 04V7BqMU006389;
        Sun, 31 May 2020 09:11:52 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 04V7Bqdw006388;
        Sun, 31 May 2020 09:11:52 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v8 1/7] i3c: master: master initialization flow document
Date:   Sun, 31 May 2020 09:11:50 +0200
Message-ID: <1590909110-6340-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1590909063-6013-1-git-send-email-pthombar@cadence.com>
References: <1590909063-6013-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(136003)(346002)(39850400004)(36092001)(46966005)(186003)(47076004)(478600001)(336012)(82310400002)(2616005)(82740400003)(42186006)(356005)(36906005)(86362001)(316002)(7636003)(8936002)(54906003)(4326008)(5660300002)(83380400001)(8676002)(2906002)(426003)(36756003)(110136005)(70206006)(107886003)(26005)(70586007);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de723486-6bc2-4c3e-19b0-08d80531e77f
X-MS-TrafficTypeDiagnostic: MWHPR07MB3437:
X-Microsoft-Antispam-PRVS: <MWHPR07MB3437760AD8D574C0E7603F4DC18D0@MWHPR07MB3437.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:785;
X-Forefront-PRVS: 0420213CCD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZQx4pWWO86Kf19y9MlFvNLqA/9oxE9zMENR+sgDhhE2hbx/O/3nAPssIauEcxUdbtErz9830ZF9o9C04P7uB8o6rJCoAAJsLMla5Ms58DlVae4HAFtBVTKTKCH3AeJDNbDwZqlD97QMpnFLQw5Zw+2sIUVh1OrYF3R71XZf9VtnMX4ISzSJNorFx2yjob6zt29S1dGO3MfCSYgbIiQO97MN1CEgJzK/l+MQRNo01ahJT6Fnd5Bg1jTL6WJvVWRmFq9pF7W/G5JyPZniRTjr25xvsnVfiujDjiYx0hdPGho6GbncpdpMG+DNTxw33oHhntkqYpPeoYYgz5/HUioVtkcf+jl1VwXNuRQOGsg3B8Pqf1ovkdLQviBc235LnqAI/Uginh6OK+FCDcmzZcQ3G9GcWxpjOzJinqvXFpX+IcZo=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2020 07:11:56.6918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de723486-6bc2-4c3e-19b0-08d80531e77f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3437
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-31_01:2020-05-28,2020-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 mlxlogscore=999 suspectscore=2 phishscore=0 adultscore=0
 cotscore=-2147483648 spamscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005310056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document describing master initialization, mastership handover
and DEFSLVS handling processes.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 Documentation/driver-api/i3c/index.rst        |   1 +
 .../i3c/master-initialization-flow.rst        | 187 ++++++++++++++++++
 2 files changed, 188 insertions(+)
 create mode 100644 Documentation/driver-api/i3c/master-initialization-flow.rst

diff --git a/Documentation/driver-api/i3c/index.rst b/Documentation/driver-api/i3c/index.rst
index 783d6dad054b..604f1c5e4a5b 100644
--- a/Documentation/driver-api/i3c/index.rst
+++ b/Documentation/driver-api/i3c/index.rst
@@ -9,3 +9,4 @@ I3C subsystem
    protocol
    device-driver-api
    master-driver-api
+   master-initialization-flow
diff --git a/Documentation/driver-api/i3c/master-initialization-flow.rst b/Documentation/driver-api/i3c/master-initialization-flow.rst
new file mode 100644
index 000000000000..b5849f4e229e
--- /dev/null
+++ b/Documentation/driver-api/i3c/master-initialization-flow.rst
@@ -0,0 +1,187 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================
+I3C Master Initialization Flow
+==============================
+
+.. kernel-render:: DOT
+   :alt: I3C Master Initialization digraph
+   :caption: I3C Master Initialization Flow
+
+   digraph master_init {
+       ranksep=.25; size="35,35";
+       subgraph cluster_0 {
+           style=dashed
+           x0[shape=ellipse, label="I3C driver probe", style="filled"]
+           x1[shape=diamond, label="Secondary Master ?"]
+           a1[shape=box, label="Do I3C master controller specific initialization"]
+           b1[shape=box, label="Do I3C master controller specific initialization,\n
+           except enabling the DEFSLVS interrupt."]
+           a2[shape=box, label="Call i3c_primary_master_register"]
+           b2[shape=box, label="Call i3c_secondary_master_register"]
+           x0->x1;
+           x1->a1[label="No"];
+           x1->b1[label="Yes"];
+           a1->a2; b1->b2;
+       }
+
+       subgraph cluster_1 {
+           style=dashed
+           label="Current Master";
+           a3[shape=ellipse, label="i3c_primary_master_register", style="filled"]
+           a4[shape=box, label="Initialize I3C master controller object."]
+           a5[shape=box, label="Create I2C objects for devices in DTS and add to I2C list."]
+           a6[shape=box, label="Set appropriate bus mode based on I2C devices information."]
+           a7[shape=box, label="Create a work queue."]
+           a8[shape=box, label="Call i3c_primary_master_bus_init"]
+           a19[shape=box, label="Add I3C object representing this master to the system."]
+           a20[shape=box, label="Expose our I3C bus as an I2C adapter so that I2C devices\n
+           are exposed through the I2C subsystem."]
+           a21[shape=box, label="Register all I3C devices."]
+           a22[shape=box, label="Broadcast ENEC MR, HJ message."]
+           a3->a4->a5->a6->a7->a8; a19->a20->a21->a22;
+           a8->a19[style="invisible"];
+       }
+
+       subgraph cluster_2 {
+           style=dashed
+           label="Current Master";
+           a9[shape=ellipse, label="i3c_primary_master_bus_init", style="filled"]
+           a10[shape=box, label="Call bus_init to do controller specific bus initialization\n
+           and enabling the controller."]
+           a11[shape=box, label="Create I3C object representing the master and add it to\n
+           the I3C device list."]
+           a12[shape=box, label="Set current master to the object created to represent I3C\n
+           master device."]
+           a13[shape=box, label="Reset all dynamic address that may have been assigned before."]
+           a14[shape=box, label="Disable all slave events before starting DAA."]
+           a15[shape=box, label="Pre-assign dynamic address and retrieve device information."]
+           a16[shape=box, label="Do dynamic address assignment to all I3C devices currenly\n
+           present on the bus."]
+           a17[shape=box, label="Create I3C objects representing devices found during DAA."]
+           a18[shape=box, label="Send DEFSVLS message containing information about all\n
+           known I3C and I2C devices."]
+           a9->a10->a11->a12->a13->a14->a15->a16->a17->a18;
+       }
+
+       subgraph cluster_3 {
+           style=dashed
+           label="Current Master";
+           h1[shape=ellipse, label="MR request interrupt", style="filled"]
+           h2[shape=box, label="Bottom half i3c_master_yield_bus"]
+           h1->h2;
+       }
+
+       subgraph cluster_4 {
+           style=dashed
+           label="Current Master";
+           i1[shape=ellipse, label="i3c_master_yield_bus", style="filled"]
+           i2[shape=box, label="Check if this device is still a master to handle a case of\n
+           multiple MR requests from different devices at a same time."]
+           i3[shape=box, label="Broadcast DISEC MR, HJ message.\n
+           New master should broadcast ENEC MR, HJ once its usage of bus is done."]
+           i4[shape=box, label="Get accept mastership acknowldege from requesting master."]
+           i5[shape=box, label="In case of failure reenable MR requests by broadcasting ENEC MR, HJ."]
+           i6[shape=box, label="Mastership hand over is done."]
+           i1->i2->i3->i4->i5->i6;
+       }
+
+       subgraph cluster_5 {
+           style=dashed
+           b3[shape=ellipse, label="i3c_secondary_master_register", style="filled"]
+           b4[shape=box, label="Initialize I3C master controller object."]
+           b5[shape=box, label="Create I2C objects for devices in DTS and add to I2C list."]
+           b6[shape=box, label="Set appropriate bus mode based on I2C devices information."]
+           b7[shape=box, label="Create a work queue."]
+           b8[shape=box, label="Call i3c_secondary_master_bus_init."]
+           b12[shape=box, label="Allocate memory for defslvs_data, that will be used to pass I3C\n
+           device list received in DEFSLVS to the I3C core DEFSLVS processing."]
+           b13[shape=box, label="Add I3C object representing this master to the system."]
+           b14[shape=box, label="Expose our I3C bus as an I2C adapter so that I2C devices are\n
+           exposed through the I2C subsystem."]
+           b3->b4->b5->b6->b7->b8; b12->b13->b14;
+           b8->b12[style="invisible"]
+       }
+
+       subgraph cluster_6 {
+           style=dashed
+           b9[shape=ellipse, label="i3c_secondary_master_bus_init", style="filled"]
+           b10[shape=box, label="Call bus_init to do controller specific bus initialization\n
+           and enabling the controller."]
+           b11[shape=box, label="Create I3C object representing the master and add it to\n
+           the I3C device list."]
+           b9->b10->b11;
+       }
+
+       subgraph cluster_7 {
+           style=dashed
+           d1[shape=ellipse, label="DEFSLVS interrupt", style="filled"]
+           d2[shape=box, label="Controller driver can chose how to to handle I2C devices received\n
+           in DEFSLVS."]
+           d3[shape=box, label="Read all I3C devices information from DEFSLVS message\n
+           to defslvs_data structure in the master object."]
+           d4[shape=box, label="Call i3c_master_process_defslvs."]
+           d1->d2->d3->d4;
+       }
+
+       subgraph cluster_8 {
+           style=dashed
+           d5[shape=ellipse, label="i3c_master_process_defslvs", style="filled"]
+           d6[shape=box, label="Acquire I3C bus mastership."]
+           d7[shape=diamond, label="Bus acquired ?"]
+           d8[shape=box, label="Handle I3C device list from DEFSLVS."]
+           d9[shape=box, label="Call i3c_master_populate_bus"]
+           d10[shape=box, label="Queue defslvs processing task for retry."]
+           d5->d6;
+           d7->d8[label="Yes"];
+           d8->d9;
+           d7->d10[label="No"];
+           d6->d7[style="invisible"];
+           d10->d5[style="dotted", constraint=false];
+       }
+
+       subgraph cluster_9 {
+           style=dashed
+           e1[shape=ellipse, label="i3c_master_acquire_bus", style="filled"]
+           e2[shape=box, label="If device is already holding the mastership,\n
+           just broadcast DISEC MR, HJ message and return success."]
+           e3[shape=box, label="Call request_mastership method"]
+           e1->e2->e3;
+       }
+
+       subgraph cluster_10 {
+           style=dashed
+           f1[shape=ellipse, label="request_mastership", style="filled"]
+           f2[shape=box, label="Return success if device is already in master mode."]
+           f3[shape=box, label="Return error if device don't have dyn_addr."]
+           f4[shape=box, label="Return error if MR requests are disabled by current master."]
+           f5[shape=box, label="Send MR request"]
+           f6[shape=box, label="Wait with timeout until MR_DONE interrupt is received."]
+           f1->f2->f3->f4->f5->f6;
+       }
+
+       subgraph cluster_11 {
+           style=dashed
+           g1[shape=ellipse, label="i3c_master_populate_bus", style="filled"]
+           g2[shape=box, label="Free up all I3C addresses to handle address\n
+           re assignment by main master."]
+           g3[shape=box, label="Master acquire dyn_addr received from the driver."]
+           g4[shape=box, label="For every I3C device in the defslvs_data\n
+           call i3c_master_add_i3c_dev_locked."]
+           g1->g2->g3->g4;
+       }
+
+       a2->a3; a8->a9; a18->a19;
+       b2->b3; b8->b9; b11->b12;
+       b14->d1[style=invisible];
+       a22->h1[style=invisible];
+       d4->d5;
+       d6->e1;
+       e3->f1;
+       f6->d7[constraint=false];
+       h2->i1;
+       d9->g1;
+       a18->d1[style="dotted", constraint=false];
+       f5->h1[style="dotted", constraint=false];
+       i4->f6[style="dotted", constraint=false];
+   }
-- 
2.17.1

