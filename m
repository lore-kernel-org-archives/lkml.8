Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4BFC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 07:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE730207C4
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 07:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="BpuqJQST";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="4hnpanso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgEaHQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 03:16:00 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:9326 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728411AbgEaHP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 03:15:59 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04V7Cpxg011959;
        Sun, 31 May 2020 00:15:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=/T7GTYU3RQOnC6gbPnbdFwHvkgoysayqSF6TCqvuctU=;
 b=BpuqJQSTMRMVhVfeRxWHZaXQnXz7l0XfXnxko47ac2as51mJHw5sXMCBCB/XT/SOVwJa
 MGtdy7kHyCTM45NGRcbGtk3ts/8Zi8IbEaFL5UB1Whjv19DCqJmnyrYAUy6Rd+TJsr30
 Jp3swyegySNfv7wt1+eVgcfHHEoKi5MmWSqvQWCIblbaQWDjIWf8sAeFYFOJEZJtD33u
 OCehs085hr6u7d5kyLujk4BcxJMY9Gu/JAy9ISU2jKX3ZgpRIENpQUFFdKTFWdTaMOdk
 gTfKZ4CSoYUxJpyNm1XiL2Ce20AydpDPp7U0ClvFHC2iUiAvFCst4c0ZQzfAWX0i2ZIr 5Q== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-0014ca01.pphosted.com with ESMTP id 31bm1wjg0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 31 May 2020 00:15:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICDcdzxR1ENjDpcQmM5ZbscVh9BDZC/5kn61JhCi/hJEiqigrNWFmPGs04p1rj1hucx2wRidyhaz/Y7247U4SpGWYwi6ePc8eOzqP0scTouGyYAAjeMTYTXI5gtRGvGA2nrtdx6Knn3XYfHjcp99gLiT1G+HUIxrMAyog2Mlk/hNT7mFeptJY9cc7HZ8Rtn3aiJEmBAk9Ti/wdwUElz1jucRxhL3ywBWq7za7NLrDrEeLx69wRCTUFpOJmAqzgIyidAeZ2YuecLvMU74MCsReKRvyYu+NDAgg4ej0rLP1RrD8JNdQ7w6HdXrodR9gC4zt9XanHF2bad+c7A7ef0gYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/T7GTYU3RQOnC6gbPnbdFwHvkgoysayqSF6TCqvuctU=;
 b=g5M6/cjOf2SnO2nu45QSxamN2TWqTYG3huu7t9txfN8QLs/FBBtoKXSTfSb9f6jItUt5Jhwjrt6OTbeoTbjlkuJVNVUqVwXZxAA397hshQGOj7WoODat7vJ2xqZLHrh3ykOgFAqLcXxiIIbbzABuqqFgDeTVXRFkBY8/BiBCSKw3k7JPWVaNzsTxcEB+Sh/EUfbuaihtmnnppAdwqT2uQdejhjrLd6O+fVgYPv4xeg+u5uOd+Yh528U6zxPmE+EveYUx36tBVIeVT3E7nKBMaP6vEKFQpGLJ2obRcOE35PffpxoYGd4QNBb7Mdc2yeRKGYC0TiltZ+XABzYQWGNykQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/T7GTYU3RQOnC6gbPnbdFwHvkgoysayqSF6TCqvuctU=;
 b=4hnpansoMd/4IE6bgZoj3mM9Wa6P2U+W5OoazWEBdiiPy49HjZoawS+u00RXM32ClBDsAR+Zn72sMnqd9TVG7IzcihouQ+0tp6dcxUMbwP3tjityWbXXc/72qBmb0LyyABrjiMgp5BSAbHK6lWA9OmGKHzsZntbTahwyhIz1h7w=
Received: from DM5PR13CA0037.namprd13.prod.outlook.com (2603:10b6:3:7b::23) by
 BYAPR07MB4758.namprd07.prod.outlook.com (2603:10b6:a02:f9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.21; Sun, 31 May 2020 07:15:50 +0000
Received: from DM6NAM12FT055.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::5) by DM5PR13CA0037.outlook.office365.com
 (2603:10b6:3:7b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.7 via Frontend
 Transport; Sun, 31 May 2020 07:15:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT055.mail.protection.outlook.com (10.13.179.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.8 via Frontend Transport; Sun, 31 May 2020 07:15:50 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 04V7FmhO236428
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Sun, 31 May 2020 00:15:49 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sun, 31 May 2020 09:15:47 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 31 May 2020 09:15:47 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 04V7Fl49007472;
        Sun, 31 May 2020 09:15:47 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 04V7Flaj007471;
        Sun, 31 May 2020 09:15:47 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v8 6/7] i3c: master: sysfs key for acquire bus
Date:   Sun, 31 May 2020 09:15:46 +0200
Message-ID: <1590909346-7434-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1590909063-6013-1-git-send-email-pthombar@cadence.com>
References: <1590909063-6013-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:unused.mynethost.com;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39850400004)(346002)(376002)(396003)(36092001)(46966005)(107886003)(70206006)(4326008)(2906002)(70586007)(336012)(478600001)(356005)(426003)(8936002)(8676002)(82310400002)(86362001)(81166007)(5660300002)(316002)(82740400003)(42186006)(2616005)(36906005)(54906003)(47076004)(186003)(83380400001)(26005)(36756003)(110136005);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66ec6653-be56-4576-dc43-08d8053272bd
X-MS-TrafficTypeDiagnostic: BYAPR07MB4758:
X-Microsoft-Antispam-PRVS: <BYAPR07MB4758B9CE7F8808F05FF2E7D2C18D0@BYAPR07MB4758.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-Forefront-PRVS: 0420213CCD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iEDEBRDJN447XzOUyIjseITst43Xb2132eG0XHGRnmdu6zxYkvj9WBbxrqkKpLCNPXkJ4gRAyVf1BkaRDj1L7fCwBjlndhhehFq3CZr69Q1QXunC1Gn88122TzWBfqFyAh51ka9h+BxHhX94XCVOjwrXVe2pSzAUYJ5TMH+yYpaAcK/dWouoYnfTpkaAlYEXbtiOGbhZlGzknoPuSr5J+5leWxUetLCkCewD9Y2ttxK/KIw8Hqz5N9owW+k98dqA+NX6oryIQOCKIw6w4wncBfCX7fW1v5idHLvKhI2VBcYlVwHQdnJNyt8wmtODeSD/3cI9sWcsjxZcCISMpS0HJZt7L7tn3CDNZeNNGBCoc/03KyP33aKNmko+jfUBdfUgzrrJO0ELi5aGAeds4OaytJohdoJIMNwlp9r/phGUzBU=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2020 07:15:50.3394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ec6653-be56-4576-dc43-08d8053272bd
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4758
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-31_01:2020-05-28,2020-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 mlxlogscore=980 suspectscore=0 phishscore=0 adultscore=0
 cotscore=-2147483648 spamscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005310057
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
index de3cb39df9ff..17c0c9a6099d 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -596,6 +596,23 @@ static ssize_t i2c_scl_frequency_show(struct device *dev,
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
@@ -606,6 +623,7 @@ static struct attribute *i3c_masterdev_attrs[] = {
 	&dev_attr_pid.attr,
 	&dev_attr_dynamic_address.attr,
 	&dev_attr_hdrcap.attr,
+	&dev_attr_i3c_acquire_bus.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(i3c_masterdev);
-- 
2.17.1

