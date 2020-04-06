Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82EDC2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590A12072A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="G+pwpaO1";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="rEEZUbHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgDFWwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 18:52:36 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:59028 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726230AbgDFWwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 18:52:35 -0400
X-Greylist: delayed 1885 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Apr 2020 18:52:33 EDT
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 036MGtnV003796;
        Mon, 6 Apr 2020 15:21:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=v/Jq0f/Q3Cf7y0O11BM3lByHfl3SGsLzushnQMtfEB4=;
 b=G+pwpaO11KuSeZH1D9HZQaG346ujknu52YD4/Vh7k6O4u1on/vOdrVf2B+gcxFjfFp71
 u4/xB0L0eLvb0IuAimYTITQyLhcaZ0DH0fYCl0opWi3qMU5HKxer4XHFzv+fbNBf1WRW
 ITWIW0nrhgJPnaDXnaOwhbadS054ZyOw5Ngzd5txavhYaddIpgXXElUp041JQVW7oY8T
 KiFJmwVuUr9qNwSDZugqo+9mff6DFRISkg/Kiptn/ojSJYyycY6W12c7v4JZXbnXnwoY
 NYEF4+7pbLXTa8mVvkmRtMrKm8NcShzwlOU8fUafN5RZ9v225PyesTBHVHB62ar34RvH OA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0a-0014ca01.pphosted.com with ESMTP id 306psw07g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Apr 2020 15:21:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEz3qCtaebJJKYp/EpBkd71RO0s1lmwl2gi8FsxXAcw4jZ4q25ChVXZm5eHXlz5QiQAFPgOuxGWlEbLLZwVR8+w/6xGLdI7ztuMNwpuYq6S+cpHKWu+k/QYE/lkJEAekhe02H6imNfGZsJNkrPrsR14y3SgnKvrl91GZ0NjINUvKyllev8iTsNlhx9KTlMZvE8vHmORgqBNCqCJgOiwKk1v9eiLmKGA6sFg6uyytEfoM/3VGRKX77vnMdWpE2PMBH8xoFlgikK0HI70IvWOG8K4APTUtg5OJtKU44CKSeraf9Ct0im7S06wP32JflMuklNfN/lAbgWilo4hkNt1+Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/Jq0f/Q3Cf7y0O11BM3lByHfl3SGsLzushnQMtfEB4=;
 b=ercribkxpu9PXOHOw3UgEzu+6yq0zJdQWGtFxVE5ubLjuctFIznYHhPfdEwxbkbZgw0cXkbXWTeUfgyN+6YH7G9Wp9oF7DIaf6sdyaHBImBW/OAvznJMV9HKC8g7CZ3wHdfkKB0DILiWJXGTqgBBo6uc4rz3tGKTe5X9uTMz1VBO6pWO4WEOpjqSyDjt70TNafCgE1yGconwkMNkipBJpoma/6wJS1GOmDWUuPF4MvUfm7jYJ1OW4KSKAvImefbLeAUhs1LUeFzCjgzM6kNzOPS1FpBc4Dyi3P9UJ3MszdT66cTAILkLBUDDyPNMMzTyd5oSm1SP8iGvNqf4yl3KnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/Jq0f/Q3Cf7y0O11BM3lByHfl3SGsLzushnQMtfEB4=;
 b=rEEZUbHlmcaKOZaIG4yL8olgFxKsMk4uMd9vlTUsLXEJ69CqxTncTux5Q8Fp+yTcMiBI/g+2Gqjq6fQT0yH7/Wg39PgOB3IW7cDZ8Btc/JL1ub8NuiGZloxf+qsQ7obCYJynm7oUgIfS+y9WKUjDMkxnnpmxdyCEOB+H0uqAkHw=
Received: from BN6PR19CA0108.namprd19.prod.outlook.com (2603:10b6:404:a0::22)
 by BY5PR07MB6467.namprd07.prod.outlook.com (2603:10b6:a03:195::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Mon, 6 Apr
 2020 22:21:38 +0000
Received: from BN8NAM12FT050.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::5b) by BN6PR19CA0108.outlook.office365.com
 (2603:10b6:404:a0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Mon, 6 Apr 2020 22:21:38 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT050.mail.protection.outlook.com (10.13.182.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.9 via Frontend Transport; Mon, 6 Apr 2020 22:21:37 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 036MLWU4008931
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 6 Apr 2020 15:21:35 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 7 Apr 2020 00:21:31 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 7 Apr 2020 00:21:31 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 036MLVf0008762;
        Tue, 7 Apr 2020 00:21:31 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 036MLVFD008759;
        Tue, 7 Apr 2020 00:21:31 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v1 1/3] i3c: master: split bus_init callback into bus_init and master_set_info
Date:   Tue, 7 Apr 2020 00:21:29 +0200
Message-ID: <1586211689-8699-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1586211645-8065-1-git-send-email-pthombar@cadence.com>
References: <1586211645-8065-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(376002)(39850400004)(136003)(396003)(36092001)(46966005)(4326008)(5660300002)(36906005)(336012)(107886003)(42186006)(316002)(54906003)(426003)(110136005)(86362001)(356004)(2616005)(478600001)(36756003)(246002)(47076004)(26005)(2906002)(7636002)(26826003)(8936002)(70586007)(8676002)(70206006)(82740400003)(186003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b15a3b1-09f9-401b-8ed6-08d7da78dfb7
X-MS-TrafficTypeDiagnostic: BY5PR07MB6467:
X-Microsoft-Antispam-PRVS: <BY5PR07MB646734C3EACF70F6F2A42EE4C1C20@BY5PR07MB6467.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 0365C0E14B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U9aV78IpZxD5TXaVi5exqaLYmYozBTp+JCkVTsgzM88vmc7EW8FR3LGtQuB4zLETFQFSwTsQ0DPG0WvHSviexHaICIeGYics9gzy9nKnthpWP+gBGP5MRm6C1YykpcG0UOWiWMbbtVo6fR9U7eJu1SPhfSIRilHazRXByJHbcT6G4Wl85eEAj++psdNfHQ4UL5DfDXv8OwObDBrGRFg9QG0qNMyU5IxxbK0WMVHOoPRS/yiEV30pd8a3yO/9D7x6nbbrkMBBO5HUP52HtFL99KTKE1o1s0cyDZKAset3zCNz9B6GbkHf3jmC/eu5XpyC+skguWCnt4t2eNSkgRJmGgT7EGB6rSwWOdVCf6CUySCIhuONyq53hj3CIekW8GfhDqiUNz+DfYpEaCfRr6zDogaKlTLc40OPvbxes0f09AvIuvWkpDKdqLte6q0C6ny6YLOZkdgOl3j4RWFukqRsvMIAMYF/11ovtCZ4HmDb2lvuBU/Gq0PgNDd+IthLwB4HI8Dk3K/r2hIRJNiiYP5q8RKkv6Y0ysTWQUIPNLtYrFo=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 22:21:37.9144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b15a3b1-09f9-401b-8ed6-08d7da78dfb7
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB6467
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-06_10:2020-04-06,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 spamscore=0 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=2
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support mastership handover procedure, this patch splits the
bus_init callback into bus_init and master_set_info callbacks

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/i3c/master.c                 | 10 +++--
 drivers/i3c/master/dw-i3c-master.c   | 29 ++++++++-----
 drivers/i3c/master/i3c-master-cdns.c | 63 ++++++++++++++++++----------
 include/linux/i3c/master.h           |  7 +++-
 4 files changed, 71 insertions(+), 38 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 5f4bd52121fe..0ec332e45737 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1716,6 +1716,10 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 	if (ret)
 		goto err_detach_devs;
 
+	ret = master->ops->master_set_info(master);
+	if (ret)
+		goto err_detach_devs;
+
 	/*
 	 * The master device should have been instantiated in ->bus_init(),
 	 * complain if this was not the case.
@@ -2378,9 +2382,9 @@ EXPORT_SYMBOL_GPL(i3c_generic_ibi_recycle_slot);
 
 static int i3c_master_check_ops(const struct i3c_master_controller_ops *ops)
 {
-	if (!ops || !ops->bus_init || !ops->priv_xfers ||
-	    !ops->send_ccc_cmd || !ops->do_daa || !ops->i2c_xfers ||
-	    !ops->i2c_funcs)
+	if (!ops || !ops->bus_init || !ops->master_set_info ||
+	    !ops->priv_xfers || !ops->send_ccc_cmd || !ops->do_daa ||
+	    !ops->i2c_xfers || !ops->i2c_funcs)
 		return -EINVAL;
 
 	if (ops->request_ibi &&
diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 1d83c97431c7..5c9a72d68fb8 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -593,7 +593,6 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 {
 	struct dw_i3c_master *master = to_dw_i3c_master(m);
 	struct i3c_bus *bus = i3c_master_get_bus(m);
-	struct i3c_device_info info = { };
 	u32 thld_ctrl;
 	int ret;
 
@@ -624,6 +623,24 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 	writel(INTR_MASTER_MASK, master->regs + INTR_STATUS_EN);
 	writel(INTR_MASTER_MASK, master->regs + INTR_SIGNAL_EN);
 
+	writel(IBI_REQ_REJECT_ALL, master->regs + IBI_SIR_REQ_REJECT);
+	writel(IBI_REQ_REJECT_ALL, master->regs + IBI_MR_REQ_REJECT);
+
+	/* For now don't support Hot-Join */
+	writel(readl(master->regs + DEVICE_CTRL) | DEV_CTRL_HOT_JOIN_NACK,
+	       master->regs + DEVICE_CTRL);
+
+	dw_i3c_master_enable(master);
+
+	return 0;
+}
+
+static int dw_i3c_master_set_info(struct i3c_master_controller *m)
+{
+	struct dw_i3c_master *master = to_dw_i3c_master(m);
+	struct i3c_device_info info = { };
+	int ret;
+
 	ret = i3c_master_get_free_addr(m, 0);
 	if (ret < 0)
 		return ret;
@@ -638,15 +655,6 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 	if (ret)
 		return ret;
 
-	writel(IBI_REQ_REJECT_ALL, master->regs + IBI_SIR_REQ_REJECT);
-	writel(IBI_REQ_REJECT_ALL, master->regs + IBI_MR_REQ_REJECT);
-
-	/* For now don't support Hot-Join */
-	writel(readl(master->regs + DEVICE_CTRL) | DEV_CTRL_HOT_JOIN_NACK,
-	       master->regs + DEVICE_CTRL);
-
-	dw_i3c_master_enable(master);
-
 	return 0;
 }
 
@@ -1088,6 +1096,7 @@ static irqreturn_t dw_i3c_master_irq_handler(int irq, void *dev_id)
 
 static const struct i3c_master_controller_ops dw_mipi_i3c_ops = {
 	.bus_init = dw_i3c_master_bus_init,
+	.master_set_info = dw_i3c_master_set_info,
 	.bus_cleanup = dw_i3c_master_bus_cleanup,
 	.attach_i3c_dev = dw_i3c_master_attach_i3c_dev,
 	.reattach_i3c_dev = dw_i3c_master_reattach_i3c_dev,
diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index 8889a4fdb454..c2d1631a9e38 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -1199,21 +1199,20 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
 	struct cdns_i3c_master *master = to_cdns_i3c_master(m);
 	unsigned long pres_step, sysclk_rate, max_i2cfreq;
 	struct i3c_bus *bus = i3c_master_get_bus(m);
-	u32 ctrl, prescl0, prescl1, pres, low;
-	struct i3c_device_info info = { };
-	int ret, ncycles;
+	u32 ctrl, prescl0, prescl1, pres, low, bus_mode;
+	int ncycles;
 
 	switch (bus->mode) {
 	case I3C_BUS_MODE_PURE:
-		ctrl = CTRL_PURE_BUS_MODE;
+		bus_mode = CTRL_PURE_BUS_MODE;
 		break;
 
 	case I3C_BUS_MODE_MIXED_FAST:
-		ctrl = CTRL_MIXED_FAST_BUS_MODE;
+		bus_mode = CTRL_MIXED_FAST_BUS_MODE;
 		break;
 
 	case I3C_BUS_MODE_MIXED_SLOW:
-		ctrl = CTRL_MIXED_SLOW_BUS_MODE;
+		bus_mode = CTRL_MIXED_SLOW_BUS_MODE;
 		break;
 
 	default:
@@ -1244,7 +1243,6 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
 	bus->scl_rate.i2c = sysclk_rate / ((pres + 1) * 5);
 
 	prescl0 |= PRESCL_CTRL0_I2C(pres);
-	writel(prescl0, master->regs + PRESCL_CTRL0);
 
 	/* Calculate OD and PP low. */
 	pres_step = 1000000000 / (bus->scl_rate.i3c * 4);
@@ -1252,15 +1250,43 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
 	if (ncycles < 0)
 		ncycles = 0;
 	prescl1 = PRESCL_CTRL1_OD_LOW(ncycles);
+
+	ctrl = readl(master->regs + CTRL);
+	if (ctrl & CTRL_DEV_EN)
+		cdns_i3c_master_disable(master);
+	writel(prescl0, master->regs + PRESCL_CTRL0);
 	writel(prescl1, master->regs + PRESCL_CTRL1);
+	ctrl &= ~CTRL_BUS_MODE_MASK;
+	ctrl |= bus_mode | CTRL_HALT_EN | CTRL_MCS_EN;
+	/*
+	 * Enable Hot-Join, and, when a Hot-Join request happens,
+	 * disable all events coming from this device.
+	 * We will issue ENTDAA afterwards from the threaded IRQ
+	 * handler.
+	 */
+	if (!m->secondary)
+		ctrl |= CTRL_HJ_ACK | CTRL_HJ_DISEC;
+	writel(ctrl, master->regs + CTRL);
+	cdns_i3c_master_enable(master);
 
-	/* Get an address for the master. */
-	ret = i3c_master_get_free_addr(m, 0);
-	if (ret < 0)
-		return ret;
+	return 0;
+}
 
-	writel(prepare_rr0_dev_address(ret) | DEV_ID_RR0_IS_I3C,
-	       master->regs + DEV_ID_RR0(0));
+static int cdns_i3c_master_set_info(struct i3c_master_controller *m)
+{
+	struct cdns_i3c_master *master = to_cdns_i3c_master(m);
+	struct i3c_device_info info = { };
+	int ret;
+
+	if (!m->secondary) {
+		/* Get an address for the master. */
+		ret = i3c_master_get_free_addr(m, 0);
+		if (ret < 0)
+			return ret;
+
+		writel(prepare_rr0_dev_address(ret) | DEV_ID_RR0_IS_I3C,
+		       master->regs + DEV_ID_RR0(0));
+	}
 
 	cdns_i3c_master_dev_rr_to_info(master, 0, &info);
 	if (info.bcr & I3C_BCR_HDR_CAP)
@@ -1270,16 +1296,6 @@ static int cdns_i3c_master_bus_init(struct i3c_master_controller *m)
 	if (ret)
 		return ret;
 
-	/*
-	 * Enable Hot-Join, and, when a Hot-Join request happens, disable all
-	 * events coming from this device.
-	 *
-	 * We will issue ENTDAA afterwards from the threaded IRQ handler.
-	 */
-	ctrl |= CTRL_HJ_ACK | CTRL_HJ_DISEC | CTRL_HALT_EN | CTRL_MCS_EN;
-	writel(ctrl, master->regs + CTRL);
-
-	cdns_i3c_master_enable(master);
 
 	return 0;
 }
@@ -1507,6 +1523,7 @@ static void cdns_i3c_master_recycle_ibi_slot(struct i3c_dev_desc *dev,
 
 static const struct i3c_master_controller_ops cdns_i3c_master_ops = {
 	.bus_init = cdns_i3c_master_bus_init,
+	.master_set_info = cdns_i3c_master_set_info,
 	.bus_cleanup = cdns_i3c_master_bus_cleanup,
 	.do_daa = cdns_i3c_master_do_daa,
 	.attach_i3c_dev = cdns_i3c_master_attach_i3c_dev,
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index f13fd8b1dd79..3dc7eafe811a 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -337,10 +337,12 @@ struct i3c_bus {
 
 /**
  * struct i3c_master_controller_ops - I3C master methods
- * @bus_init: hook responsible for the I3C bus initialization. You should at
- *	      least call master_set_info() from there and set the bus mode.
+ * @bus_init: hook responsible for the I3C bus initialization.
  *	      You can also put controller specific initialization in there.
  *	      This method is mandatory.
+ * @master_set_info: hook responsible for assigning address to main master.
+ *			You should call i3c_master_set_info from here.
+ *			This method is mandatory.
  * @bus_cleanup: cleanup everything done in
  *		 &i3c_master_controller_ops->bus_init().
  *		 This method is optional.
@@ -421,6 +423,7 @@ struct i3c_bus {
  */
 struct i3c_master_controller_ops {
 	int (*bus_init)(struct i3c_master_controller *master);
+	int (*master_set_info)(struct i3c_master_controller *m);
 	void (*bus_cleanup)(struct i3c_master_controller *master);
 	int (*attach_i3c_dev)(struct i3c_dev_desc *dev);
 	int (*reattach_i3c_dev)(struct i3c_dev_desc *dev, u8 old_dyn_addr);
-- 
2.17.1

