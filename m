Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B6AC2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB03208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ByDtxukF";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="GxY2LbNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgDFW4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 18:56:36 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:54816 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726287AbgDFW4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 18:56:36 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 036MGvhx003807;
        Mon, 6 Apr 2020 15:21:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=w9lCPLv2HC7RRhOjj8aCZiyTVq/tBNMk+rrYBZGIfRQ=;
 b=ByDtxukFI8cQ3kKNM/J46zWVLiCjM/y/yHFVVx8yD6NJaOfPgGY/+ojM1fXLGPr/MG8z
 c5KO+bEzrvpGMJ2gOpawCtPiKaSIIslsZengLbUGqSrYHR9vbETy+48wt7zhSqwlkqtK
 HCBNlAtA1d7jozxxmUXmISE0EFn4iS3IYIw72r4+OVJux6HMlm5uZWhhRMM7j9sPEzEm
 /gTPHowo79Bp3G2Nn4I74CwDM2V5qKsWbwzQrWOpVUFtmRCTU5/98HYwczvssRvzEYE/
 wkNAhSfqBOOhVAI8Y7rQyAg5KMWJgIQly670J6gCNiEurKopF2jMb2fnw8qoUtQUUPfi lQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0a-0014ca01.pphosted.com with ESMTP id 306psw07gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Apr 2020 15:21:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBNbMjnbf++cDoc5ZGvF8CmHcUo175fH9ES0XHj7VetCeo9G3/fgO8vJFzqckg0kHusByLummt2/c80+zbr9vjP1QS51g1uI6ZTLUuyHKoenYaZIim9Z4cq6Mt1UWYg0tpmecU40e6NrFbyUx8DuqGN5a5b54jE/5p9qU+M4L1iM6tVR7KxK7oSuq2seciO17jKZzsZwR4kA5mcgGdZd8KFlzVHeny0Hui+aiNcDJicK7mOgnHAOUPJUvjLjDn29jrySmIPlGn38qNlrptjcccoNEV+jUJ4gp5Fbjx9DBHQgqq8xLgLsD9CR5upjkbDyxRp6t5hxr/icv9nt8SMhYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9lCPLv2HC7RRhOjj8aCZiyTVq/tBNMk+rrYBZGIfRQ=;
 b=OQUNi+4RRKNi1roUrIU7yzOaVWBnIqEwtxcMLKpYilPo5rS/5Uh0bA7JqyzhDCfGTgN+VB81tXJjhQ+r/8seBvuOJFArSMdH2L7pS2cZ/NBkNJyl1YK9pYdDJ6c0HCXtOYsn1c5viL19IyQicYRfycz3YE2WbnamiC3igQv8WYjNphtgV5uuNLJHWzf1+j8C+D0w8LVbx8jI+4kapSVX0KbMnEWDahLJCeGuvJACe+q0JgrweW7zvlwkOT4KzC1/30/gdQiZPcUZGtxpbNVbsrfUaSECh45HocJk8cvGs5TyyybH0Ba7zGIzJ41ufxQfcXBKnxo0uCpNDOV4Kf92jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9lCPLv2HC7RRhOjj8aCZiyTVq/tBNMk+rrYBZGIfRQ=;
 b=GxY2LbNP9BhEFEcrANSM2aNMvKDgoQrmb4mG5zIiwm4fHLV9J1Ji+U9K2zfTqpVkQfI9nnT8yyOFwyPTc2fySe1OETqHVRCTG24N+lvWxzrX8zL+138Eu5wZqz2ZKpxEWg1C+BGr1uYF+vyg3wfnSRE3oUzUpi4Ax5nWH6S8kL4=
Received: from MN2PR02CA0017.namprd02.prod.outlook.com (2603:10b6:208:fc::30)
 by BL0PR07MB3874.namprd07.prod.outlook.com (2603:10b6:207:4b::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Mon, 6 Apr
 2020 22:21:50 +0000
Received: from BN8NAM12FT010.eop-nam12.prod.protection.outlook.com
 (2603:10b6:208:fc:cafe::cd) by MN2PR02CA0017.outlook.office365.com
 (2603:10b6:208:fc::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Mon, 6 Apr 2020 22:21:50 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT010.mail.protection.outlook.com (10.13.182.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.9 via Frontend Transport; Mon, 6 Apr 2020 22:21:49 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 036MLju5009940
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 6 Apr 2020 15:21:48 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 7 Apr 2020 00:21:45 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 7 Apr 2020 00:21:45 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 036MLjRn008923;
        Tue, 7 Apr 2020 00:21:45 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 036MLj0r008922;
        Tue, 7 Apr 2020 00:21:45 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v1 2/3] i3c: add mastership handover support to i3c master subsystem
Date:   Tue, 7 Apr 2020 00:21:43 +0200
Message-ID: <1586211703-8862-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1586211645-8065-1-git-send-email-pthombar@cadence.com>
References: <1586211645-8065-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(136003)(39850400004)(376002)(346002)(36092001)(46966005)(47076004)(30864003)(356004)(2616005)(36906005)(36756003)(186003)(336012)(8676002)(42186006)(107886003)(26826003)(478600001)(86362001)(54906003)(4326008)(316002)(2906002)(110136005)(426003)(82740400003)(5660300002)(8936002)(7636002)(70206006)(26005)(246002)(70586007)(42413003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82515725-c5c8-4e11-c1f1-08d7da78e6af
X-MS-TrafficTypeDiagnostic: BL0PR07MB3874:
X-Microsoft-Antispam-PRVS: <BL0PR07MB3874C6659BB2CC0E3A0FBA0DC1C20@BL0PR07MB3874.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:372;
X-Forefront-PRVS: 0365C0E14B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OOAbMYhvFFOmzAtz8Ia1T4VNki9KmSRvfGS+pVrtFUqa0wlzFLPsuwwStwpC+B/UzUF4lGni+IVuJ+uaAzfNI/kZwoOidHoTAE58sWc5laB46Q/ohD0hUI0nZEgo2shulPRFjLJma3Y/e337oQsjgNQ9r/vrhrdiVgM/EIpHEuaS+9Tdxk1BQcCKrxDwN4VZpF+YzsEhvMnIrDluu1zeXTFvGzxE9VKLtoFPMBbqEsGKJvMgmcNgT2JNNCyprYntsmEJE07on06RYS7NRl8/suuOsSMhq5N0CpWzXn9kBaQ+y81p03DC78djST718lgi/dWk6P3xzJrDnRd3vk/X0SXh4o23IJYQCYBmD5GnH8EGp1CSZbMdu0GHThPAsNdXh5xepcsXfEYo66XpEBUke/c548ZHmwQZns7P4SCghZ0AWIOcXrhvRDf8FmBTqGNB2lUZ7OHPcVQMDHX0gFR8cj3YUwrvtiya5T0k4UwQHxwrtMF1nLPkJo984ermBSexiEwyyrvxNhcTfgSBEc531NhVRkoLSuk2UClpp4Ay+W52Kjc8DsTLXATyqGEejqkY
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 22:21:49.5424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82515725-c5c8-4e11-c1f1-08d7da78e6af
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB3874
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

This patch adds mastership handover support to I3C master
subsystem as per MIPI I3C v1.0 specification.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/i3c/master.c       | 486 ++++++++++++++++++++++++++++++++++---
 include/linux/i3c/master.h |  40 +++
 2 files changed, 487 insertions(+), 39 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 0ec332e45737..42b6385fc3c8 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -963,6 +963,33 @@ int i3c_master_defslvs_locked(struct i3c_master_controller *master)
 }
 EXPORT_SYMBOL_GPL(i3c_master_defslvs_locked);
 
+static int i3c_master_get_accmst_locked(struct i3c_master_controller *master,
+					u8 addr)
+{
+	struct i3c_ccc_getaccmst *accmst;
+	struct i3c_ccc_cmd_dest dest;
+	struct i3c_ccc_cmd cmd;
+	int ret;
+
+	accmst = i3c_ccc_cmd_dest_init(&dest, addr, sizeof(*accmst));
+	if (!accmst)
+		return -ENOMEM;
+
+	i3c_ccc_cmd_init(&cmd, true, I3C_CCC_GETACCMST, &dest, 1);
+
+	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
+	if (ret)
+		goto out;
+
+	if (dest.payload.len != sizeof(*accmst))
+		ret = -EIO;
+
+out:
+	i3c_ccc_cmd_dest_cleanup(&dest);
+
+	return ret;
+}
+
 static int i3c_master_setda_locked(struct i3c_master_controller *master,
 				   u8 oldaddr, u8 newaddr, bool setdasa)
 {
@@ -1525,6 +1552,185 @@ int i3c_master_do_daa(struct i3c_master_controller *master)
 }
 EXPORT_SYMBOL_GPL(i3c_master_do_daa);
 
+static int i3c_master_getaccmst(struct i3c_master_controller *master)
+{
+	int ret;
+
+	i3c_bus_maintenance_lock(&master->bus);
+	ret = i3c_master_get_accmst_locked(master, master->mr_addr);
+	i3c_bus_maintenance_unlock(&master->bus);
+
+	return ret;
+}
+
+static int i3c_master_request_mastership(struct i3c_master_controller *master)
+{
+	int ret;
+
+	/* request_mastership callback should handle EN/DIS EC MR.*/
+	i3c_bus_maintenance_lock(&master->bus);
+	ret = master->ops->request_mastership(master);
+	i3c_bus_maintenance_unlock(&master->bus);
+
+	return ret;
+}
+
+static void i3c_mst_yield_bus(struct work_struct *work)
+{
+	struct i3c_master_controller *m;
+	struct i3c_dev_desc *i3cdev;
+	int ret;
+
+	m = container_of(work, struct i3c_master_controller, mst_work);
+	switch (m->mr_state) {
+	case I3C_MR_DISEC_MR:
+		/*
+		 * Disable MR on all but the secondary master first
+		 * reaching here.
+		 */
+		i3c_bus_for_each_i3cdev(&m->bus, i3cdev) {
+			if (I3C_BCR_DEVICE_ROLE(i3cdev->info.bcr) !=
+			    I3C_BCR_I3C_MASTER ||
+			    i3cdev->info.dyn_addr == m->mr_addr ||
+			    m->this == i3cdev)
+				continue;
+			i3c_bus_maintenance_lock(&m->bus);
+			i3c_master_disec_locked(m, i3cdev->info.dyn_addr,
+						I3C_CCC_EVENT_MR);
+			i3c_bus_maintenance_unlock(&m->bus);
+		}
+		m->mr_state = I3C_MR_GETACCMST;
+		queue_work(m->wq, &m->mst_work);
+		break;
+
+	case I3C_MR_GETACCMST:
+		ret = i3c_master_getaccmst(m);
+		if (!ret)
+			m->mr_state = I3C_MR_DONE;
+		else
+			m->mr_state = I3C_MR_FAILED;
+		queue_work(m->wq, &m->mst_work);
+		break;
+
+	case I3C_MR_DONE:
+		i3c_bus_for_each_i3cdev(&m->bus, i3cdev) {
+			if (m->mr_addr == i3cdev->info.dyn_addr) {
+				m->bus.cur_master = i3cdev;
+				break;
+			}
+		}
+		m->mr_state = I3C_MR_IDLE;
+		break;
+
+	case I3C_MR_FAILED:
+		m->ops->enable_mr_events(m);
+		i3c_bus_maintenance_lock(&m->bus);
+		i3c_master_enec_locked(m, I3C_BROADCAST_ADDR,
+				       I3C_CCC_EVENT_MR);
+		i3c_bus_maintenance_unlock(&m->bus);
+		m->mr_state = I3C_MR_IDLE;
+		break;
+
+	default:
+		break;
+	}
+}
+
+void
+i3c_master_yield_bus(struct i3c_master_controller *master, u8 sec_mst_dyn_addr)
+{
+	master->ops->disable_mr_events(master);
+	master->mr_addr = sec_mst_dyn_addr;
+	master->mr_state = I3C_MR_DISEC_MR;
+	queue_work(master->wq, &master->mst_work);
+}
+EXPORT_SYMBOL_GPL(i3c_master_yield_bus);
+
+static void i3c_sec_mst_acquire_bus(struct work_struct *work)
+{
+	struct i3c_master_controller *m;
+	struct i3c_bus *i3cbus;
+	int ret;
+
+	m = container_of(work, struct i3c_master_controller, sec_mst_work);
+	i3cbus = i3c_master_get_bus(m);
+	switch (m->mr_state) {
+	case I3C_MR_WAIT_DA:
+		/* Wait until this master have dynamic address */
+		if (m->ops->check_event_set(m, I3C_SLV_DA_UPDATE))
+			m->mr_state = I3C_MR_REQUEST;
+		queue_work(m->wq, &m->sec_mst_work);
+		break;
+
+	case I3C_MR_REQUEST:
+		/* Wait until we can send MR */
+		ret = i3c_master_request_mastership(m);
+		if (!ret)
+			m->mr_state = I3C_MR_WAIT_DEFSLVS;
+		queue_work(m->wq, &m->sec_mst_work);
+		break;
+
+	case I3C_MR_WAIT_DEFSLVS:
+		/*
+		 * Wait for DEFSLVS, this event check should make sure
+		 * that DEFSLVS list is read into m->defslvs_data
+		 */
+		if (m->ops->check_event_set(m, I3C_SLV_DEFSLVS_CCC))
+			m->mr_state = I3C_MR_WAIT_MR_DONE;
+		queue_work(m->wq, &m->sec_mst_work);
+		break;
+
+	case I3C_MR_WAIT_MR_DONE:
+		if (m->ops->check_event_set(m, I3C_SLV_MR_DONE)) {
+			m->mr_state = I3C_MR_DONE;
+			complete(&m->mr_comp);
+		} else {
+			queue_work(m->wq, &m->sec_mst_work);
+		}
+		break;
+
+	default:
+		m->mr_state = I3C_MR_FAILED;
+		complete(&m->mr_comp);
+		break;
+	}
+}
+
+void i3c_sec_mst_mr_dis_event(struct i3c_master_controller *m)
+{
+	if (m->mr_state != I3C_MR_IDLE)
+		m->mr_state = I3C_MR_WAIT_DA;
+}
+EXPORT_SYMBOL_GPL(i3c_sec_mst_mr_dis_event);
+
+static int i3c_master_acquire_bus(struct i3c_master_controller *master)
+{
+	int ret = 0;
+
+	if (!master->this || master->this != master->bus.cur_master) {
+		i3c_bus_normaluse_lock(&master->bus);
+		if (master->mr_state == I3C_MR_IDLE) {
+			master->mr_state = I3C_MR_WAIT_DA;
+			i3c_bus_normaluse_unlock(&master->bus);
+			init_completion(&master->mr_comp);
+			queue_work(master->wq, &master->sec_mst_work);
+			wait_for_completion(&master->mr_comp);
+			if (master->mr_state != I3C_MR_DONE)
+				ret = -EAGAIN;
+			master->mr_state = I3C_MR_IDLE;
+		} else {
+			/*
+			 * MR request is already in process for
+			 * this master
+			 */
+			ret = -EAGAIN;
+			i3c_bus_normaluse_unlock(&master->bus);
+		}
+	}
+
+	return ret;
+}
+
 /**
  * i3c_master_set_info() - set master device information
  * @master: master used to send frames on the bus
@@ -1558,10 +1764,6 @@ int i3c_master_set_info(struct i3c_master_controller *master,
 	if (!i3c_bus_dev_addr_is_avail(&master->bus, info->dyn_addr))
 		return -EINVAL;
 
-	if (I3C_BCR_DEVICE_ROLE(info->bcr) == I3C_BCR_I3C_MASTER &&
-	    master->secondary)
-		return -EINVAL;
-
 	if (master->this)
 		return -EINVAL;
 
@@ -1622,9 +1824,10 @@ static void i3c_master_detach_free_devs(struct i3c_master_controller *master)
  * 1. Attach I2C and statically defined I3C devs to the master so that the
  *    master can fill its internal device table appropriately
  *
- * 2. Call &i3c_master_controller_ops->bus_init() method to initialize
- *    the master controller. That's usually where the bus mode is selected
- *    (pure bus or mixed fast/slow bus)
+ * 2. Should have called &i3c_master_controller_ops->bus_init()
+ *    method with pure bus mode to initialize the master controller.
+ *    That's usually where the bus mode is selected (pure bus or
+ *    mixed fast/slow bus)
  *
  * 3. Instruct all devices on the bus to drop their dynamic address. This is
  *    particularly important when the bus was previously configured by someone
@@ -1708,14 +1911,6 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 		}
 	}
 
-	/*
-	 * Now execute the controller specific ->bus_init() routine, which
-	 * might configure its internal logic to match the bus limitations.
-	 */
-	ret = master->ops->bus_init(master);
-	if (ret)
-		goto err_detach_devs;
-
 	ret = master->ops->master_set_info(master);
 	if (ret)
 		goto err_detach_devs;
@@ -1728,7 +1923,7 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 		dev_err(&master->dev,
 			"master_set_info() was not called in ->bus_init()\n");
 		ret = -EINVAL;
-		goto err_bus_cleanup;
+		goto err_detach_devs;
 	}
 
 	/*
@@ -1737,14 +1932,14 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 	 */
 	ret = i3c_master_rstdaa_locked(master, I3C_BROADCAST_ADDR);
 	if (ret && ret != I3C_ERROR_M2)
-		goto err_bus_cleanup;
+		goto err_detach_devs;
 
 	/* Disable all slave events before starting DAA. */
 	ret = i3c_master_disec_locked(master, I3C_BROADCAST_ADDR,
 				      I3C_CCC_EVENT_SIR | I3C_CCC_EVENT_MR |
 				      I3C_CCC_EVENT_HJ);
 	if (ret && ret != I3C_ERROR_M2)
-		goto err_bus_cleanup;
+		goto err_detach_devs;
 
 	/*
 	 * Pre-assign dynamic address and retrieve device information if
@@ -1762,10 +1957,6 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 err_rstdaa:
 	i3c_master_rstdaa_locked(master, I3C_BROADCAST_ADDR);
 
-err_bus_cleanup:
-	if (master->ops->bus_cleanup)
-		master->ops->bus_cleanup(master);
-
 err_detach_devs:
 	i3c_master_detach_free_devs(master);
 
@@ -2249,6 +2440,9 @@ void i3c_generic_ibi_free_pool(struct i3c_generic_ibi_pool *pool)
 	struct i3c_generic_ibi_slot *slot;
 	unsigned int nslots = 0;
 
+	if (!pool)
+		return;
+
 	while (!list_empty(&pool->free_slots)) {
 		slot = list_first_entry(&pool->free_slots,
 					struct i3c_generic_ibi_slot, node);
@@ -2392,9 +2586,179 @@ static int i3c_master_check_ops(const struct i3c_master_controller_ops *ops)
 	     !ops->recycle_ibi_slot))
 		return -EINVAL;
 
+	if (ops->request_mastership &&
+	    (!ops->enable_mr_events || !ops->disable_mr_events ||
+	     !ops->check_event_set))
+		return -EINVAL;
+
 	return 0;
 }
 
+static struct i2c_dev_boardinfo *
+i3c_master_alloc_i2c_boardinfo(struct i3c_master_controller *master,
+			       u16 addr, u8 lvr)
+{
+	struct i2c_dev_boardinfo *i2cboardinfo;
+
+	i2cboardinfo = kzalloc(sizeof(*i2cboardinfo), GFP_KERNEL);
+	if (!i2cboardinfo)
+		return ERR_PTR(-ENOMEM);
+
+	i2cboardinfo->base.addr = addr;
+	i2cboardinfo->lvr = lvr;
+
+	return i2cboardinfo;
+}
+
+static int i3c_secondary_master_bus_init(struct i3c_master_controller *master)
+{
+	struct i3c_ccc_dev_desc *desc;
+	struct i3c_dev_desc *i3cdev;
+	struct i2c_dev_desc *i2cdev;
+	struct i2c_dev_boardinfo *info;
+	int ret, slot;
+
+	desc = master->defslvs_data.devs;
+	for (slot = 1; slot <= master->defslvs_data.ndevs; slot++, desc++) {
+		if (desc->static_addr) {
+			i3c_bus_set_addr_slot_status(&master->bus,
+						     desc->static_addr,
+						     I3C_ADDR_SLOT_I2C_DEV);
+			info = i3c_master_alloc_i2c_boardinfo(master,
+							      desc->static_addr,
+							      desc->lvr);
+			if (IS_ERR(info)) {
+				ret = PTR_ERR(info);
+				goto err_detach_devs;
+			}
+
+			i2cdev = i3c_master_alloc_i2c_dev(master, info);
+			if (IS_ERR(i2cdev)) {
+				ret = PTR_ERR(i2cdev);
+				goto err_detach_devs;
+			}
+
+			ret = i3c_master_attach_i2c_dev(master, i2cdev);
+			if (ret) {
+				i3c_master_free_i2c_dev(i2cdev);
+				goto err_detach_devs;
+			}
+		} else {
+			struct i3c_device_info info = {
+				.dyn_addr = desc->dyn_addr,
+			};
+
+			i3cdev = i3c_master_alloc_i3c_dev(master, &info);
+			if (IS_ERR(i3cdev)) {
+				ret = PTR_ERR(i3cdev);
+				goto err_detach_devs;
+			}
+
+			ret = i3c_master_attach_i3c_dev(master, i3cdev);
+			if (ret) {
+				i3c_master_free_i3c_dev(i3cdev);
+				goto err_detach_devs;
+			}
+		}
+	}
+
+	ret = master->ops->master_set_info(master);
+	if (ret)
+		goto err_bus_cleanup;
+
+	i3c_bus_for_each_i3cdev(&master->bus, i3cdev) {
+		if (master->this != i3cdev) {
+			ret = i3c_master_retrieve_dev_info(i3cdev);
+			if (ret)
+				goto err_bus_cleanup;
+		}
+	}
+
+	if (!master->this) {
+		dev_err(&master->dev,
+			"master_set_info() was not called in ->bus_init()\n");
+		ret = -EINVAL;
+		goto err_bus_cleanup;
+	}
+
+	return 0;
+
+err_bus_cleanup:
+	if (master->ops->bus_cleanup)
+		master->ops->bus_cleanup(master);
+
+err_detach_devs:
+	i3c_master_detach_free_devs(master);
+
+	return ret;
+}
+
+static void i3c_secondary_master_register(struct work_struct *work)
+{
+	struct i3c_master_controller *master;
+	struct i3c_bus *i3cbus;
+	int ret;
+
+	master = container_of(work, struct i3c_master_controller,
+			      sec_mst_register_work);
+	i3cbus = i3c_master_get_bus(master);
+
+	ret = i3c_master_acquire_bus(master);
+	if (ret)
+		goto err_cleanup_bus;
+
+	/* Again bus_init to bus_mode, based on data received in DEFSLVS */
+	ret = i3c_bus_set_mode(i3cbus, master->defslvs_data.bus_mode);
+	if (ret)
+		goto err_cleanup_bus;
+
+	ret = master->ops->bus_init(master);
+	if (ret)
+		goto err_cleanup_bus;
+
+	ret = i3c_secondary_master_bus_init(master);
+	if (ret)
+		goto err_cleanup_bus;
+
+	ret = device_add(&master->dev);
+	if (ret)
+		goto err_cleanup_bus;
+
+	/*
+	 * Expose our I3C bus as an I2C adapter so that I2C devices are exposed
+	 * through the I2C subsystem.
+	 */
+	ret = i3c_master_i2c_adapter_init(master);
+	if (ret)
+		goto err_del_dev;
+
+	/*
+	 * We're done initializing the bus and the controller, we can now
+	 * register I3C devices from defslvs list.
+	 */
+	master->init_done = true;
+	i3c_bus_normaluse_lock(&master->bus);
+	i3c_master_register_new_i3c_devs(master);
+	i3c_bus_normaluse_unlock(&master->bus);
+
+	master->ops->enable_mr_events(master);
+	i3c_bus_maintenance_lock(&master->bus);
+	ret = i3c_master_enec_locked(master, I3C_BROADCAST_ADDR,
+				     I3C_CCC_EVENT_MR);
+	i3c_bus_maintenance_unlock(&master->bus);
+
+	return;
+
+err_del_dev:
+	device_del(&master->dev);
+
+err_cleanup_bus:
+	if (master->ops->bus_cleanup)
+		master->ops->bus_cleanup(master);
+
+	put_device(&master->dev);
+}
+
 /**
  * i3c_master_register() - register an I3C master
  * @master: master used to send frames on the bus
@@ -2424,10 +2788,10 @@ int i3c_master_register(struct i3c_master_controller *master,
 	struct i3c_bus *i3cbus = i3c_master_get_bus(master);
 	enum i3c_bus_mode mode = I3C_BUS_MODE_PURE;
 	struct i2c_dev_boardinfo *i2cbi;
-	int ret;
+	int ret, sz;
 
-	/* We do not support secondary masters yet. */
-	if (secondary)
+	/*Check if controller driver supports secondary masters. */
+	if (secondary && !ops->request_mastership)
 		return -ENOTSUPP;
 
 	ret = i3c_master_check_ops(ops);
@@ -2451,10 +2815,45 @@ int i3c_master_register(struct i3c_master_controller *master,
 	device_initialize(&master->dev);
 	dev_set_name(&master->dev, "i3c-%d", i3cbus->id);
 
-	ret = of_populate_i3c_bus(master);
+	master->wq = alloc_workqueue("%s", 0, 0, dev_name(parent));
+	if (!master->wq) {
+		ret = -ENOMEM;
+		goto err_put_dev;
+	}
+
+	master->mr_state = I3C_MR_IDLE;
+	INIT_WORK(&master->sec_mst_work, i3c_sec_mst_acquire_bus);
+	INIT_WORK(&master->mst_work, i3c_mst_yield_bus);
+
+	ret = i3c_bus_set_mode(i3cbus, mode);
+	if (ret)
+		goto err_put_dev;
+
+	/*
+	 * Now execute the controller specific ->bus_init() routine, which
+	 * might configure its internal logic to match the bus limitations.
+	 */
+	ret = master->ops->bus_init(master);
 	if (ret)
 		goto err_put_dev;
 
+	if (secondary) {
+		sz = sizeof(struct i3c_ccc_dev_desc) * I3C_BUS_MAX_DEVS;
+		master->defslvs_data.devs = devm_kzalloc(&master->dev, sz,
+							 GFP_KERNEL);
+		if (!master->defslvs_data.devs)
+			goto err_put_dev;
+
+		INIT_WORK(&master->sec_mst_register_work,
+			  i3c_secondary_master_register);
+		queue_work(master->wq, &master->sec_mst_register_work);
+		return 0;
+	}
+
+	ret = of_populate_i3c_bus(master);
+	if (ret)
+		goto err_cleanup_bus;
+
 	list_for_each_entry(i2cbi, &master->boardinfo.i2c, node) {
 		switch (i2cbi->lvr & I3C_LVR_I2C_INDEX_MASK) {
 		case I3C_LVR_I2C_INDEX(0):
@@ -2468,23 +2867,13 @@ int i3c_master_register(struct i3c_master_controller *master,
 			break;
 		default:
 			ret = -EINVAL;
-			goto err_put_dev;
+			goto err_cleanup_bus;
 		}
 	}
 
-	ret = i3c_bus_set_mode(i3cbus, mode);
-	if (ret)
-		goto err_put_dev;
-
-	master->wq = alloc_workqueue("%s", 0, 0, dev_name(parent));
-	if (!master->wq) {
-		ret = -ENOMEM;
-		goto err_put_dev;
-	}
-
 	ret = i3c_master_bus_init(master);
 	if (ret)
-		goto err_put_dev;
+		goto err_cleanup_bus;
 
 	ret = device_add(&master->dev);
 	if (ret)
@@ -2507,6 +2896,22 @@ int i3c_master_register(struct i3c_master_controller *master,
 	i3c_master_register_new_i3c_devs(master);
 	i3c_bus_normaluse_unlock(&master->bus);
 
+	if (ops->request_mastership) {
+		master->ops->enable_mr_events(master);
+		i3c_bus_maintenance_lock(&master->bus);
+		i3c_master_enec_locked(master, I3C_BROADCAST_ADDR,
+				       I3C_CCC_EVENT_MR);
+		i3c_bus_maintenance_unlock(&master->bus);
+	}
+
+	ret = i3c_bus_set_mode(i3cbus, mode);
+	if (ret)
+		goto err_del_dev;
+
+	ret = master->ops->bus_init(master);
+	if (ret)
+		goto err_del_dev;
+
 	return 0;
 
 err_del_dev:
@@ -2557,7 +2962,10 @@ int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
 	if (!master->ops->priv_xfers)
 		return -ENOTSUPP;
 
-	return master->ops->priv_xfers(dev, xfers, nxfers);
+	if (!i3c_master_acquire_bus(master))
+		return master->ops->priv_xfers(dev, xfers, nxfers);
+	else
+		return -EAGAIN;
 }
 
 int i3c_dev_disable_ibi_locked(struct i3c_dev_desc *dev)
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 3dc7eafe811a..c6427c62ed83 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -259,6 +259,27 @@ enum i3c_bus_mode {
 	I3C_BUS_MODE_MIXED_SLOW,
 };
 
+enum i3c_mr_state {
+	I3C_MR_IDLE,
+	I3C_MR_DISEC_MR,
+	I3C_MR_SEND_DEFSLVS,
+	I3C_MR_GETACCMST,
+	I3C_MR_WAIT_DA,
+	I3C_MR_CHECK_STATE,
+	I3C_MR_REQUEST,
+	I3C_MR_WAIT_DEFSLVS,
+	I3C_MR_WAIT_MR_DONE,
+	I3C_MR_DONE,
+	I3C_MR_FAILED,
+};
+
+enum i3c_event {
+	I3C_SLV_DA_UPDATE,
+	I3C_SLV_DEFSLVS_CCC,
+	I3C_SLV_MR_DIS,
+	I3C_SLV_MR_DONE,
+};
+
 /**
  * enum i3c_addr_slot_status - I3C address slot status
  * @I3C_ADDR_SLOT_FREE: address is free
@@ -448,6 +469,11 @@ struct i3c_master_controller_ops {
 	int (*disable_ibi)(struct i3c_dev_desc *dev);
 	void (*recycle_ibi_slot)(struct i3c_dev_desc *dev,
 				 struct i3c_ibi_slot *slot);
+	int (*request_mastership)(struct i3c_master_controller *master);
+	void (*enable_mr_events)(struct i3c_master_controller *m);
+	void (*disable_mr_events)(struct i3c_master_controller *m);
+	bool (*check_event_set)(struct i3c_master_controller *m,
+				enum i3c_event);
 };
 
 /**
@@ -489,6 +515,17 @@ struct i3c_master_controller {
 	} boardinfo;
 	struct i3c_bus bus;
 	struct workqueue_struct *wq;
+	struct work_struct sec_mst_register_work;
+	struct work_struct mst_work;
+	struct work_struct sec_mst_work;
+	struct completion mr_comp;
+	enum i3c_mr_state mr_state;
+	u8 mr_addr;
+	struct {
+		u32 ndevs;
+		enum i3c_bus_mode bus_mode;
+		struct i3c_ccc_dev_desc *devs;
+	} defslvs_data;
 };
 
 /**
@@ -513,6 +550,9 @@ struct i3c_master_controller {
 #define i3c_bus_for_each_i3cdev(bus, dev)				\
 	list_for_each_entry(dev, &(bus)->devs.i3c, common.node)
 
+void i3c_master_yield_bus(struct i3c_master_controller *master,
+			  u8 slv_dyn_addr);
+void i3c_sec_mst_mr_dis_event(struct i3c_master_controller *m);
 int i3c_master_do_i2c_xfers(struct i3c_master_controller *master,
 			    const struct i2c_msg *xfers,
 			    int nxfers);
-- 
2.17.1

