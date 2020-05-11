Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25407C54E4A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAA3E20735
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="HWuOSy31";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="c6VCaYU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgEKNRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 09:17:08 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:43934 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726013AbgEKNRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:17:07 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04BDEOWk013457;
        Mon, 11 May 2020 06:16:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=D6ASknqDZ+R3RSj4O9hfCPcJF26w7yqdePhBoCzhyqE=;
 b=HWuOSy31r88rcdr28hwIwnfI2VLpl9uTvp1kRkhIBleIyqkY2LcqEVbBxipZ/iljV9AO
 PeknOT2vcQVXYA4nnsb549IgawSK7z6CJ6V7hS6zLACKhCXo9/w1bLXg4PiRV1EiWGXi
 AiodF/O2qVLqgmcNDTDoh6ED8p+kw6Dn0dgWJlgV0PfgjvHhbktdqESkna9Tdd9TQMvr
 fVA6JItlr66tRzfjaZC1E9WFOAAnCXpV36I9h9WNqmRK4r0m0UyitFONtmlJlurgpxaw
 ci45JwmgORovaGLXRZnml1vhU7uIzWFu3JSXZhp+mmOlHwcSR4pj6rhsTxp3sVj22Olr Ow== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0b-0014ca01.pphosted.com with ESMTP id 30wr3xeaw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 06:16:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNtNIh0Il+AON6JtH1CNx3Ox6oXCVTLqQlsIs1guVwN75a6olMNPooIBLWPwPb4aMTon0eu9SYiKVvBFXQX/MPCgfXbgvMgKh+O8Vuh2AHcRlyr3RUtYJIAd23qvwxryGIr6ZnP2jEiCtvCfGF2/0NGA8TLmlvHCk4Mbi3UKfr5zf/MZwtpNUc94vR/1MHG5BAMer5saaETk7G8L4/6QmB9WN0QN26law42qd/JlotFd5ETK8RAkN5GK53HllSWG/1oaNvH5pI1Br/s6+zJKf519SP0HipyJm4vVRgrUmexmPZq/sSUohvgc7HBko0hbQcWyMtG4IbIvHw5AFJjS0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6ASknqDZ+R3RSj4O9hfCPcJF26w7yqdePhBoCzhyqE=;
 b=gbVqNA0ClKO9pREhfmwH8joeZf1Nr+8d9Q6orCJFRQ7A323CZRu6BmDgA1/6XFaWSCj3y+o/BQwWcoA7h9fo7yx8089N6p9UOq973jOXGCGvyuPN3rBiw/mVBuU0nRfI1kIh/JqQUfNzCEoU/qXp88vC2CFN2unoPaY31c8z62W5YInPHxlPfOI+h0EHmZm+Soa+HW8UQNSMhEzAiGLwbTqvDQ8mUr+2Y+A3xWYKHwC8vqIocaQNGNmabOmlf/40avWHsP/nViyRCDaGLTPm4Y34wVTLqSY5EOFMvDyGzGQsQbtGqzEahNyFs0F/g2+HD+CsjbxPuppP5u6ppYp8JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6ASknqDZ+R3RSj4O9hfCPcJF26w7yqdePhBoCzhyqE=;
 b=c6VCaYU9zyVSLefKFD2DZrjmz24qsmtGIlhays4VEuB+6mVkNxfyx6/yOMc3qR8omljLl5Xei6IXBiITcSTTdAxfOQmsGbtWIB0s++IxMdsNHefytsaCbNyp+n3iRdbo4UHyGiF7cnhwhgm276mMgorhp0b/trYKVLTZhXYo8pE=
Received: from BN6PR1101CA0012.namprd11.prod.outlook.com
 (2603:10b6:405:4a::22) by DM6PR07MB7161.namprd07.prod.outlook.com
 (2603:10b6:5:1e1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Mon, 11 May
 2020 13:16:57 +0000
Received: from BN8NAM12FT024.eop-nam12.prod.protection.outlook.com
 (2603:10b6:405:4a:cafe::e0) by BN6PR1101CA0012.outlook.office365.com
 (2603:10b6:405:4a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend
 Transport; Mon, 11 May 2020 13:16:57 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT024.mail.protection.outlook.com (10.13.183.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.11 via Frontend Transport; Mon, 11 May 2020 13:16:56 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 04BDGrvI019936
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 11 May 2020 09:16:54 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 11 May 2020 15:16:51 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 11 May 2020 15:16:50 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 04BDGokC010948;
        Mon, 11 May 2020 15:16:50 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 04BDGnXp010945;
        Mon, 11 May 2020 15:16:49 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v7 6/7] i3c: master: sysfs key for acquire bus
Date:   Mon, 11 May 2020 15:16:48 +0200
Message-ID: <1589203008-10880-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1589202702-4879-1-git-send-email-pthombar@cadence.com>
References: <1589202702-4879-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(36092001)(46966005)(33430700001)(356005)(81166007)(82740400003)(33440700001)(82310400002)(107886003)(4326008)(5660300002)(86362001)(478600001)(2616005)(336012)(47076004)(2906002)(36756003)(426003)(8676002)(316002)(186003)(26005)(36906005)(70586007)(70206006)(42186006)(8936002)(110136005)(54906003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fa23c99-58ce-4c1f-536d-08d7f5ad946c
X-MS-TrafficTypeDiagnostic: DM6PR07MB7161:
X-Microsoft-Antispam-PRVS: <DM6PR07MB716182C8BD3B1CE0BC9D2238C1A10@DM6PR07MB7161.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-Forefront-PRVS: 04004D94E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DYGuCxNzcKhNoAoWs4L0wSCXYm08G8hNwXxrERSuQEbskead0qikLE5GdaE5EYfV6qt8kDzQewE9IXUKhNCtkQ8MzC+/pA7iQpIWh+R3daQPI8VzmmC0ZY3N9dSFQtJPUfq7yj51i44TXu28SrCh47F2e5BuCVuH0cj4+Q3Lsx0WXLdTKohYWjayJJKqVClsoe/KwwHdiYKk4y8exKCAVhTQ8SVz1KkFfnyIrSscNUeg8OsuUQjnxAUgix1MQZh5WpjABt0FakszZO8HgQ8EBcBZnU3HpXrzCpqB5zZwMKknC9RLbo3Kzz2pRCCWqcClySAK3bL1oWCvcmRzrffG52YVXrWE6lMULXBwCFZ8PrejHmgoaxhAY4P116Hi7dsN0UW/o1OoIO+aGA78d/GezQnjg1GodeuCPRj6SkBGm9mraP9x5UB1U9QQaE8AhKeCCnmYF+9GLxK3Hl795xaeZibsoVCBBbjIYsvBwN9jSU+234FyWROdaoEFnk2LBf5OtzzNSXZO+tCjhVEXoSozI925SvBj0VZhXXF7B7FVSi3vK5Y6hrTXw2/qhRjo7W5ccm2U4hh1z/LwX8/0bsSEx1MrN68NXMGcHszNHtGmv0c=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2020 13:16:56.4239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa23c99-58ce-4c1f-536d-08d7f5ad946c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB7161
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-11_05:2020-05-11,2020-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 phishscore=0 clxscore=1015 suspectscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=964 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005110110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support to acquire I3C bus through sysfs interface.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/i3c/master.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index ea53fadeed99..ec27196e987c 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -607,6 +607,23 @@ static ssize_t i2c_scl_frequency_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(i2c_scl_frequency);
 
+static ssize_t i3c_acquire_bus_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct i3c_master_controller *master = dev_to_i3cmaster(dev);
+	int ret;
+
+	i3c_bus_normaluse_lock(&master->bus);
+	ret = i3c_master_acquire_bus(master);
+	i3c_bus_normaluse_unlock(&master->bus);
+	if (!ret)
+		i3c_master_enable_mr_events(master);
+
+	return ret ?: count;
+}
+static DEVICE_ATTR_WO(i3c_acquire_bus);
+
 static struct attribute *i3c_masterdev_attrs[] = {
 	&dev_attr_mode.attr,
 	&dev_attr_current_master.attr,
@@ -617,6 +634,7 @@ static struct attribute *i3c_masterdev_attrs[] = {
 	&dev_attr_pid.attr,
 	&dev_attr_dynamic_address.attr,
 	&dev_attr_hdrcap.attr,
+	&dev_attr_i3c_acquire_bus.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(i3c_masterdev);
-- 
2.17.1

