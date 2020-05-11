Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484D9C54E4A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BF8A20735
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="cTqg7Rsy";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="yEjK079R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbgEKNNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 09:13:01 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:30870 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726687AbgEKNNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:13:00 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04BD88U4016509;
        Mon, 11 May 2020 06:12:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=sTAplfbdy+B97iC3mdY8J3ROwCeB4Xy2iD0rgKJowE4=;
 b=cTqg7RsyT0s1YGn4fjfzNDQZRudX0zbbLfwJuoIMRBBn+0eIe/UrxBu+d3+0YliTiUZL
 5udH/5CrVohmMvtoHbC0OtikeU7PIhPBPelwrkFwICx4afRrsefXEyYjJfHtDLU28jrU
 WjGQDExkkoHs0VpBLvm2QLVOa5HOsHrHpcX2u8FRFRFPW7ONn+8f55iE2VI+ESksUcyC
 IjzaMDTtTEKGHrzhySbJXUz3TVN23ie5m/tUvAAWJ9glwsYJpPfeRywcVqjztcWO9oNO
 ZGqBndhz2ERhv2Go91raOEc7ys3DeC4hSgv83iEqNWTrSLBdUDGpvx5VApt1hY+q9L0I rg== 
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2050.outbound.protection.outlook.com [104.47.46.50])
        by mx0a-0014ca01.pphosted.com with ESMTP id 30ws2xx3sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 06:12:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FznQ3iqhL63tzJtczx90GQNgHMM1ZYuHmhHYcYnrqOjfQjc+NFQRl5kUgzyfn17k422tXhPI7IruFbg2XeflKtGn90SXTekxt5V0/1CP7zPuvNQdcUYzelPezNUNuarokFJT73UgZ9PKM2fhFg9NILVvABDAoITX9gj8fYKcHAJPrIkJEiKvXgLfVkfdaj5Z0lsx9N52Vg1uCY+EoTSQoVKomFIIOCulT4WQI59+WX38BXgpbGyDBLqykwHPF4BI7VWZPpFNFkez7n6MjWJVg0uOyQo7oV4KBGaVkhSQaFZfrllz8EOCwQzu2fVylan5NN18zBHTi9puBHHVoXyZ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTAplfbdy+B97iC3mdY8J3ROwCeB4Xy2iD0rgKJowE4=;
 b=jhX3eHJFHgnZo4zKbqVkewAP//HxLUiwRDK2RuVC+GJySK5XHqOxb+LLH0aa1shKTek4cVD7eOyTPyg8AezCB+gN9btsiPh5bvyU3tlGtqgbtTzin7gE5aBilPSe6nrk6sgaonZSa6giS7ut3f81Du8ejv8IcIXX5AhTNPm0NhsDldLN8uEbdthefmFjp6RmGUhg/aA4cRz2aVOktd2o0bp1Ij9Y8Ma7O+uKIhCIBaBjBz0T6E5oKCP+70kpw/GPdGhdkvB6c32TrUmY0gwHJTEO710Qt04aTutHnBiT1aeKKJde66ANS5Wl3m7yOqNkzDRF2MuV4e7De6SIVVju0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTAplfbdy+B97iC3mdY8J3ROwCeB4Xy2iD0rgKJowE4=;
 b=yEjK079Rt/ifTcx2xdJNHriKR/8UFvoKCkfVxCmmu2TxQgdjVf7ngGFKppnvqIcGMw/r+KsfnO6Zktbc3l2pgMVfRrUpPa7gLrMHVWgHdvSRsQ64RbLmbKGQn+BjdRJtY3Im09nBuLlX00ydW2rLr6KVCpYwMmhWwyIogto0NnY=
Received: from BN8PR12CA0033.namprd12.prod.outlook.com (2603:10b6:408:60::46)
 by BYAPR07MB4229.namprd07.prod.outlook.com (2603:10b6:a02:c7::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Mon, 11 May
 2020 13:12:49 +0000
Received: from BN8NAM12FT004.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::66) by BN8PR12CA0033.outlook.office365.com
 (2603:10b6:408:60::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Mon, 11 May 2020 13:12:48 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT004.mail.protection.outlook.com (10.13.183.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.11 via Frontend Transport; Mon, 11 May 2020 13:12:47 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 04BDCgKx028629
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 11 May 2020 06:12:44 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 11 May 2020 15:12:42 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 11 May 2020 15:12:42 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 04BDCgCT005751;
        Mon, 11 May 2020 15:12:42 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 04BDCg33005750;
        Mon, 11 May 2020 15:12:42 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v7 1/7] i3c: master: secondary master initialization document
Date:   Mon, 11 May 2020 15:12:39 +0200
Message-ID: <1589202759-5677-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1589202702-4879-1-git-send-email-pthombar@cadence.com>
References: <1589202702-4879-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(36092001)(46966005)(33430700001)(36906005)(478600001)(316002)(8676002)(33440700001)(356005)(82740400003)(42186006)(110136005)(86362001)(54906003)(70586007)(70206006)(4326008)(2906002)(5660300002)(336012)(7636003)(186003)(2616005)(107886003)(82310400002)(36756003)(26005)(6666004)(426003)(47076004)(8936002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 349a6e32-d58c-48c4-0dba-08d7f5ad0028
X-MS-TrafficTypeDiagnostic: BYAPR07MB4229:
X-Microsoft-Antispam-PRVS: <BYAPR07MB4229AB6BC31FF5570EC2BBABC1A10@BYAPR07MB4229.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U6bKw6wcM+O4rh4wtp+v/IDi3iS1hpBypx/XsBrA4QGlvLi1ikg4RcUh8/0xR0WeZ7gYaQ5uiq+KWm+Aw1hF7y0di7XAC5N3tdPB5+j96oK/SkpBNSKRU4QI0Hj62iEiDk0z+MeN5WqBIRVvVp3QeytRXKnnnfCCQcRwa7yOUOlg3kY4aiXQRhMeliPhgxCQA2yEoMRYVAiG8kVnj2gI/mLZOfv/SwX4j5A6UGmd3n2G6OIeu918GsyWVwrmMh5NMxPk7t/AGM1UcbLji4n+YRWRnQSABIJdLla1FovXBtMV8+riUodzy7UK01MENZSrC7mVw3GtgUa+I29IvosxKZkGoGW6KH8t1rw0ID5hrTkZCDnPwq0vjdxnuzgUhrlcyK9yunoPJvYBiAkC04sjx7qSoMYDqz0CQN9lRwZ+GnUWNZySXT7RGjqPmTBYRpHx8ZO4Hydf2reYD3Tri7vBQ9+HOHjIQCzo0/tiGz2IrmjSQKuvsZ3CbXq4AVYYq1HNIf4yctjCUt1fbqFF8rKLok8gGL8jW0M6ZNxaChVdUJdRODA+eaRziNPTy+kfB9F2PIXAFPfvx3im68F1NRsgmH0GeorQL8ABvCend0XWdZo=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 13:12:47.5627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 349a6e32-d58c-48c4-0dba-08d7f5ad0028
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4229
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-11_05:2020-05-11,2020-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 suspectscore=2 impostorscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005110109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document describing secondary master initialization,
mastership handover and DEFSLVS handling processes.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 Documentation/driver-api/i3c/index.rst        |   1 +
 .../i3c/secondary-master-initialization.rst   | 118 ++++++++++++++++++
 2 files changed, 119 insertions(+)
 create mode 100644 Documentation/driver-api/i3c/secondary-master-initialization.rst

diff --git a/Documentation/driver-api/i3c/index.rst b/Documentation/driver-api/i3c/index.rst
index 783d6dad054b..af2a0aa68f5b 100644
--- a/Documentation/driver-api/i3c/index.rst
+++ b/Documentation/driver-api/i3c/index.rst
@@ -9,3 +9,4 @@ I3C subsystem
    protocol
    device-driver-api
    master-driver-api
+   secondary-master-initialization
diff --git a/Documentation/driver-api/i3c/secondary-master-initialization.rst b/Documentation/driver-api/i3c/secondary-master-initialization.rst
new file mode 100644
index 000000000000..9d1869550807
--- /dev/null
+++ b/Documentation/driver-api/i3c/secondary-master-initialization.rst
@@ -0,0 +1,118 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================================
+I3C Secondary Master Initialization
+===================================
+
++-----------------------------------------+-------------------------------------------+
+| **Main master**                         | **Secondary master**                      |
++=========================================+===========================================+
+|                                         |                                           |
+| | Do I3C master controller specific     | | Do I3C master controller specefic       |
+|   initialization.                       |   initialization, except enabling         |
+|                                         |   the DEFSLVS interrupt.                  |
+| | Call i3c_master_register              | | Call i3c_secondary_master_register      |
+|                                         |                                           |
+|   *i3c_master_register*                 |   *i3c_secondary_master_register*         |
+|    | Initialize I3C master controller   |    | Initialize I3C master controller     |
+|      object.                            |      object.                              |
+|    | Scan I3C and I2C devices from DTS. |    | Scan I2C devices from DTS.           |
+|    | Set appropriate bus mode based on  |    | Set appropriate bus mode based on    |
+|      I2C devices information.           |      I3C and I2C devices information.     |
+|    | Create a work queue.               |    | Create a work queue.                 |
+|    | Call i3c_master_bus_init           |    | Call i3c_secondary_master_bus_init   |
+|                                         |                                           |
+|      *i3c_master_bus_init*              |      *i3c_secondary_master_bus_init*      |
+|       | Call bus_init to do controller  |       | Call bus_init to do controller    |
+|         specific bus initialization and |         specific bus initialization and   |
+|         enabling the controller.        |         enabling the controller.          |
+|       | Create I3C device representing a|       | Create I3C device representing a  |
+|         master and add it to the I3C    |         master and add it to the I3C      |
+|         device list.                    |         device list.                      |
+|       | Set current master to the device|                                           |
+|         created to represent I3C master |    | Allocate memory for 'defslvs_data',  |
+|         device.                         |      that will be used to pass I3C        |
+|       | Reset all dynamic address that  |      device list received in DEFSLVS      |
+|         may have been assigned before.  |      to I3C core DEFSLVS processing       |
+|       | Disable all slave events before |    | Add I3C device representing this     |
+|         starting DAA.                   |      master to the system.                |
+|       | Pre-assign dynamic address and  |    | Expose our I3C bus as an I2C adapter |
+|         retrieve device information if  |      so that I2C devices are exposed      |
+|         needed.                         |      through the I2C subsystem.           |
+|       | Do dynamic address assignment to|                                           |
+|         all I3C devices currenly present| | Enable DEFSLVS interrupt.               |
+|         on the bus.                     |                                           |
+|       | Create I3C devices representing |                                           |
+|         those found during DAA.         +-------------------------------------------+
+|       | Send DEFSVLS message            | | *DEFSLVS interrupt*                     |
+|         containing information about all| | Controller driver can chose how to      |
+|         known I3C and I2C devices.      |   to handle I2C devices received in       |
+|                                         |   DEFSLVS e.g. Cadence's controller       |
+|                                         |   driver ignore I2C devices from          |
+|                                         |   DEFSLVS and only uses I2C device        |
+|                                         |   information from DTS.                   |
+|                                         | | Read all I3C devices information        |
+|                                         |   from DEFSLVS message in hardware to     |
+|                                         |   defslvs_data in master object.          |
+|                                         | | Call i3c_master_process_defslvs         |
+|                                         |                                           |
+|                                         |   *i3c_master_process_defslvs*            |
+|                                         |    | Acquire I3c bus                      |
+|                                         |                                           |
+|                                         |      *i3c_master_acquire_bus*             |
+|    | Add I3C device representing this   |       | If device is already holding the  |
+|      master to the system.              |         mastership, just broadcast DISEC  |
+|    | Expose our I3C bus as an I2C       |         MR, HJ message and return.        |
+|      adapter so that I2C devices are    |       | Check if device has got a address |
+|      exposed through the I2C subsystem. |         by polling with a timeout.        |
+|    | Register all I3C devices.          |                                           |
+|                                         |       | Send MR request: Controller driver|
+|                                         |         should check if it is already in  |
+|                                         |         master mode, to handle the case   |
+|                                         |         of mastership yielded but due to  |
+|                                         |         poll timeout acquire failed.      |
+|                                         |       | If not a master, wait until MR    |
+|                                         |         ENEC is received if currently it  |
+|                                         |         is disabled.                      |
+|    | Broadcast ENEC MR, HJ message.     |       | Send MR request.                  |
++-----------------------------------------+                                           |
+| | *MR request interrupt*                |                                           |
+|                                         |                                           |
+|   *i3c_master_yield_bus*                |                                           |
+|    | Check if this device is still a    |                                           |
+|      master to handle a case of         |                                           |
+|      multiple MR requests from different|                                           |
+|      devices at a same time.            |                                           |
+|    | Broadcast DISEC MR, HJ message.    |                                           |
+|      New master should broadcast ENEC   |                                           |
+|      MR, HJ once it's usage of bus is   |                                           |
+|      done.                              |                                           |
+|    | Get accept mastership acknowldege  |                                           |
+|      from requesting master.            |                                           |
+|    | Mastership hand over is done.      |       | Check if device enter master      |
+|    | In case of failure reenable        |         mode by polling with a timeout.   |
+|      MR requests by broadcasting ENEC   |                                           |
+|      MR, HJ.                            |    Handle I3C device list from DEFSLVS.   |
+|                                         |                                           |
+|                                         |    *i3c_master_populate_bus*              |
+|                                         |     | Free up all I3C addresses to handle |
+|                                         |       address re assignment by main       |
+|                                         |       master.                             |
+|                                         |     | Move all devices from I3C list to a |
+|                                         |       temporary list.                     |
+|                                         |     | For every device from defslvs_data  |
+|                                         |       list except the receiving master    |
+|                                         |       device, retrieve pid and compare it |
+|                                         |       with already known I3C devices from |
+|                                         |       I3C list. If match is found,        |
+|                                         |       allocate new address and move the   |
+|                                         |       device to the original I3C device   |
+|                                         |       list. If no match is found, it is a |
+|                                         |       new device. Register and add it to  |
+|                                         |       the original I3C list.              |
+|                                         |     | At the end if temporary list is not |
+|                                         |       empty, it contains unplugged I3C    |
+|                                         |       device. Deregister and delete them. |
+|                                         |                                           |
+|                                         |     Broadcast ENEC MR, HJ message.        |
++-----------------------------------------+-------------------------------------------+
-- 
2.17.1

