Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17B4C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 07:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 994C6207BC
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 07:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="JKC/DFdO";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ztv2h7h/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbgEaHL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 03:11:28 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:11288 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726220AbgEaHL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 03:11:27 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04V79ijb012572;
        Sun, 31 May 2020 00:11:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=K8EsqARzlM7OO6TNKp5cTGqaHBnBmOU4tQ7IV+JvOME=;
 b=JKC/DFdO7kn7bpP1xlWC4yaWv7cR6SbZX5Q71SjtxIckbLAPO8QunCokCaa4AcUWwbSC
 r4URtfLb/rMWRzbWXysbLoV3jyLWgoWNvc01Vy55culeoTb4TMj0oKxohTobbLTyvpH2
 /mQHUdxpHF0dIduE/K/j09qTvZ2hqU27bCgZfeeOxmgp2lX3XJW5geCoFleqvMtSMnON
 ujLqezGpsse4Y+KWg+reUqF3Hoy+Vuve/qZbaSd++nO+Fjwu7sJGRq3ymOJP3dOpvnsl
 TMcSFmIe2zD1qhxlY9cRzkdv/h/odLKEdwwEqYT/9hJ/lrsa3HJVlrJcPqluvOjxhL8A kQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0b-0014ca01.pphosted.com with ESMTP id 31bk2xande-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 31 May 2020 00:11:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8H/FazboALJCPvN2CoVocEBSXAGwyV75hxQptKk/2z1pliu2EayZkE4lXVeVkNaXuk2sZ+/KDJktpOivqXG9akw27JC9FXy3p7v5sVLbTaNORUzUUEmiFrB9hojZl6DEuTz9nKnD/CGHB3rY/NeNFuqDBAHEfYjxssKcO9v0M2NfPxd+gIhRnPMUlXEZWgkL4Y75k89nmj02kQd9lxMe28C02lHbybLDlp+lOe1GlLXQ6iogIOd0RpGH+25ZE7UOshtO+L9o573C1BDSuvq4lSJcypijLdcpUZ2v4OiPOEbt+lzA5NgGU+33aBpn5ebTHijIme8lzYNQxTCVEg5Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8EsqARzlM7OO6TNKp5cTGqaHBnBmOU4tQ7IV+JvOME=;
 b=INR+7FmPvUeLl/GmAIlWXQKo+H2k60C1VUIwzmKru6FvzDFiM4Kgt830KSqio2Mv4a9pt8BW5SJsJ0qHXcJY0pAc2fJIIk3UPrLfIpf+97ZcrH4SwbcL8a1gWjwjz3nw+vALhcB9VNVkXCPYzVh6NiILliQ+p46bGHIDza6iuywCtjqE5WndqarbuxGdIo0CjCsbVZ1c3wtE+wiA3r0lq15tJp4iEsrrdwWf+RD+7j0j7IBhCG+RY2gE2B+aY1KkkxiCKTFZ4HtxBPeaKLoyCTN2ffT9idyFjzDV4CBIV2xXyCQkWe3vOY3A5H+mnyFdzSotM3zk1L/5oY4sMSjwaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8EsqARzlM7OO6TNKp5cTGqaHBnBmOU4tQ7IV+JvOME=;
 b=ztv2h7h/v5GZwZlK2lPTVvsv0tBZ4N/b1XKbtQnwlPd52eOUaUZ3xovwCAv+qNaJyadJbH+Bk0sr8BaOKv0FQ5Fg9yPwmhY4EAeBP8qvRmOrzBQRufo67Cc7By3Smmb5PYz94uUYgQrs7K5NwR3kXxYqUbSw2UpITl+2HSTq7rE=
Received: from CO2PR04CA0191.namprd04.prod.outlook.com (2603:10b6:104:5::21)
 by MN2PR07MB6830.namprd07.prod.outlook.com (2603:10b6:208:115::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Sun, 31 May
 2020 07:11:13 +0000
Received: from MW2NAM12FT032.eop-nam12.prod.protection.outlook.com
 (2603:10b6:104:5:cafe::cc) by CO2PR04CA0191.outlook.office365.com
 (2603:10b6:104:5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend
 Transport; Sun, 31 May 2020 07:11:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT032.mail.protection.outlook.com (10.13.180.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.8 via Frontend Transport; Sun, 31 May 2020 07:11:12 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 04V7B8jW021051
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 31 May 2020 00:11:09 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sun, 31 May 2020 09:11:07 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 31 May 2020 09:11:07 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 04V7B7jb006134;
        Sun, 31 May 2020 09:11:07 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 04V7B43n006128;
        Sun, 31 May 2020 09:11:04 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v8 0/7] I3C mastership handover support
Date:   Sun, 31 May 2020 09:11:03 +0200
Message-ID: <1590909063-6013-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(346002)(39850400004)(136003)(36092001)(46966005)(316002)(42186006)(186003)(36906005)(107886003)(4326008)(7636003)(47076004)(36756003)(478600001)(26005)(336012)(2906002)(70586007)(83380400001)(70206006)(356005)(2616005)(426003)(82740400003)(5660300002)(82310400002)(8676002)(8936002)(54906003)(110136005)(86362001);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7c16f7d-62ff-416d-e803-08d80531cd1a
X-MS-TrafficTypeDiagnostic: MN2PR07MB6830:
X-Microsoft-Antispam-PRVS: <MN2PR07MB6830C675D35C14C260E04C7BC18D0@MN2PR07MB6830.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0420213CCD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R10uAWQyKGehugllP0OnPHQPDsVIR8OskyQn9PzjkqIr+0nUBbRXHS8YetvG2PvfpViNaj9uO77Pi5OivGJPVY/moq37klYkWvShc6W8cgC4HV9L2Y6aoxbK22c6p2vWbeF+y93lbg4z5mtNj1PARex5GqLuDMSgMpEDcGbcBX+VihsinDs+LXW7/wQAyj1ynYT7Xd5il1NtT0dSXNXhOV0XWaoj/YpGvrA5gIbVAi73G3gSYu3W3P/vumtXXlK4Kro4AMBaQQ/GBFNu/QGhKiR3MIMlD10K5KqsYbCBfh1hkayWOqvUFlMzyhA0oWzac7y7pUvkaidzoxLXOT+KJ6vYrIIFCTiNT+PnSE4x/GexSXhkwy5/KuOaQbFEbxQT6CmuT9TKGZW1eIByC/3WWWVwghIN/qJCG+2ujpyMi+E=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2020 07:11:12.4974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c16f7d-62ff-416d-e803-08d80531cd1a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6830
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-31_01:2020-05-28,2020-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 impostorscore=0
 bulkscore=0 cotscore=-2147483648 mlxscore=0 clxscore=1015 spamscore=0
 phishscore=0 suspectscore=2 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005310056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Main changes between v7 and v8 are:
- Document format changed from table to DOT diagram
- Appropriate names for few functions
- Moved mastership request process entirely to the driver
- Reuse of i3c_master_add_i3c_dev_locked in core defslvs
  processing

Main changes between v6 and v7 are:
- Added separate functions for main and secondary
  master initialization
- Secondary master initialization don't wait for
  DEFSLSVS.
- Change to use I2C device information from DTS,
  and corresponding changes in controller driver
  and I3C core DEFSLVS processing to ignore I2C
  devices received in DEFSLVS
- Reverted bus_init split
- Fixed formatting issues in document

Main changes between v5 and v6 are:
- Moved populate_bus() hook to master subsystem code.
- For secondary master initialization i3c_master_register
  spawan separate threads, as secondary master may have to
  wait for DEFSLVS and bus mastership.
- Populate bus info is based on DEFSLVS data and take care
  of hot plugged / unplugged I3C devices.
- Split bus_init into bus_init and master_set_info callbacks
- Moved mastership aquire and handover to separate state 
  machines.
- Added DEFSLVS processing code.
- Moved back all locks in side the subsystem code.
- Secondary mastership support to Cadence I3C master
  controller driver
- Sysfs key 'i3c_acquire_bus' to acauire bus.
- NULL check for pool pointer in i3c_generic_ibi_free_pool.

Main changes between v4 and v5 are:
- Add populate_bus() hook
- Split i3c_master_register into init and register pair
- Split device information retrieval, let add partialy discovered devices
- Make i3c_master_set_info private
- Add separate function to register secondary master
- Reworked secondary master register in CDNS driver
- Export i3c_bus_set_mode

Main changes between v3 and v4 are:
- Reworked acquire bus ownership
- Refactored the code

Main changes between v2 and v3 are:
- Added DEFSLVS devices are registered from master driver
- Reworked I2C registering on secondary master side
- Reworked Mastership event is enabled/disabled globally (for all devices)

Main changes between initial version and v2 are:
- Reworked devices registration on secondary master side
- Reworked mastership event disabling/enabling
- Reworked bus locking during mastership takeover process
- Added DEFSLVS devices registration during initialization
- Fixed style issues


Parshuram Thombare (7):
  i3c: master: master initialization flow document
  i3c: master: use i3c_master_register only for main master
  i3c: master: add i3c_secondary_master_register
  i3c: master: add mastership handover support
  i3c: master: add defslvs processing
  i3c: master: sysfs key for acquire bus
  i3c: master: mastership handover, defslvs processing in cdns
    controller driver

 Documentation/driver-api/i3c/index.rst        |   1 +
 .../i3c/master-initialization-flow.rst        | 190 +++++++
 drivers/i3c/master.c                          | 486 ++++++++++++++++--
 drivers/i3c/master/dw-i3c-master.c            |   4 +-
 drivers/i3c/master/i3c-master-cdns.c          | 329 +++++++++++-
 include/linux/i3c/master.h                    |  23 +-
 6 files changed, 964 insertions(+), 69 deletions(-)
 create mode 100644 Documentation/driver-api/i3c/master-initialization-flow.rst

-- 
2.17.1

