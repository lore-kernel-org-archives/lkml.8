Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58313C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187372072A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="TkyHeETx";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="nqslRqMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgDFWwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 18:52:35 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:32150 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726246AbgDFWwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 18:52:35 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 036MNCBG009717;
        Mon, 6 Apr 2020 15:23:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=7wHSv0am9OQoZebiR9rHF++s0NpUbmG1qgVWelzGGLc=;
 b=TkyHeETxF4yI3XSlSaKeMTrs+pSIkYxjTYFEZOaJWXQJ1m5pIGeS40ImnfNVV+kYifxG
 7I14IYnIdQHeg9Fr6tYMEqbLmNrUsPyR78YycWoBTc2JY6p5g05n0XcM8C09SW+SGhxS
 fWYB4j4yu5tJB+pzmRx30guM5luguSn/4e7aE/5ggwIbJGMTiI+tP+Lg5NNJMqjXs9Fo
 ooeFWECI0pW4EDTnmEOAXiQC/qcYmjWtlY2GjrmStKDoAIRn5fmDJF+HZzp/LY/ma4CK
 RHnWbkkdHqFKZFjWK6fUHav7GSwa5aGOs0zIzNM8YIGCIR0y0pX/krsb+CepizqShFii bA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0a-0014ca01.pphosted.com with ESMTP id 306psw07m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Apr 2020 15:23:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+XhHmMj4DM6j5RIgKGUVtBqBPcgDRiKt020bP02MFAMxoWsZkCOqKMrbzmaBf1Edh+ofpXPHjfysrg08Q3jiQkPErS3MqcuWLgPYhkIFFEhlY76X4eUfOWlFg9DPuH+WZEpdIynJd/w+L5EblKd7nKCTvwbnM76tF3nZ7wSdLmT9M2/s/Zao/bYjyMneR0k1lC1JGZPmPkIi4e+96JHblgLod6Y7oQlhCEP8oyyJK8ZTI9+CxTlOqGqgeYmkKk9PHYEn2bOKRXsg+5wsKQs/Rj9FQuPnBlBAwtb0Qv2X1Ru/RXtQX7i9ijoRUov7jbHDoGU8ff5z86UFpQ3B0ZJYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wHSv0am9OQoZebiR9rHF++s0NpUbmG1qgVWelzGGLc=;
 b=MMe9Kk23HLVz96K2OKZ7Smh6mla4sNLJPk1mV+FqBpbpE9XM7kTm3htMmhXfAXa2LnZt/oB4c9EekOs5mpSbsrB+J+6/hp/UQR86C3I3ynSJ+5N4Deo41ZC0VFspdxpYJVX0nVcfkXZ/YL84SGisxj4rdA69jHhQtpvlc4swERQK+sNE+CRGPjFvoaMoozPwVpz4azjhPcWVur7PaVyvdny65dylejvTPorEPg3h/MJF7QkTGseg3+kvLcg32KxsXwxjpDxwli469+bwQAFM0vDUWvmqc9xv+iUzVlOSMd7zzENKFd1kiE0zBlLTZ7kd0o5XT2sxUqbrJXwSYMBXVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wHSv0am9OQoZebiR9rHF++s0NpUbmG1qgVWelzGGLc=;
 b=nqslRqMl9YguW50ZFwVnpSOSMwWf8AZLe/QjnQN70OjfDyHvP4jbscNADWEmRKgLYKMA9NJ7wcMqSDZfrmD/5q4TkUYLCwt38X5fmK1SVqlmm0vsaX9v95IH/OKXgejFzDSPJ6KwyHJ6SZzfSZQpzngf30fcY5m7ugH5o193cjg=
Received: from MWHPR1201CA0007.namprd12.prod.outlook.com
 (2603:10b6:301:4a::17) by BYAPR07MB5431.namprd07.prod.outlook.com
 (2603:10b6:a03:10::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Mon, 6 Apr
 2020 22:22:50 +0000
Received: from MW2NAM12FT006.eop-nam12.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::b7) by MWHPR1201CA0007.outlook.office365.com
 (2603:10b6:301:4a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Mon, 6 Apr 2020 22:22:50 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MW2NAM12FT006.mail.protection.outlook.com (10.13.180.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.9 via Frontend Transport; Mon, 6 Apr 2020 22:22:50 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 036MMl4c057715
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Mon, 6 Apr 2020 15:22:49 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 7 Apr 2020 00:22:47 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 7 Apr 2020 00:22:47 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 036MMlX4009569;
        Tue, 7 Apr 2020 00:22:47 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 036MMlHG009566;
        Tue, 7 Apr 2020 00:22:47 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v1 3/3] i3c: master: add mastership handover support to cdns i3c master driver
Date:   Tue, 7 Apr 2020 00:21:56 +0200
Message-ID: <1586211716-9023-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1586211645-8065-1-git-send-email-pthombar@cadence.com>
References: <1586211645-8065-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:unused.mynethost.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(346002)(136003)(396003)(39850400004)(36092001)(46966005)(36756003)(47076004)(30864003)(70206006)(8676002)(2616005)(81156014)(70586007)(8936002)(86362001)(81166006)(336012)(426003)(107886003)(26826003)(316002)(82740400003)(36906005)(5660300002)(2906002)(4326008)(6666004)(478600001)(26005)(356004)(54906003)(186003)(110136005)(42186006)(42413003);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 476b0dd5-0aa0-4193-eb46-08d7da790aab
X-MS-TrafficTypeDiagnostic: BYAPR07MB5431:
X-Microsoft-Antispam-PRVS: <BYAPR07MB5431F89233CF648CF70FB1E3C1C20@BYAPR07MB5431.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:142;
X-Forefront-PRVS: 0365C0E14B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wFOPhKLX40IxHrXDsVdk/TTfggzk/0nWexqAoS8T9dOa3+vasLAZgK3B8WpJxmNwjcmqAIFCaWdylpzg7E3rKseprZ2cWocML8wHhGvIF8N6iTvEulPBWAMrzOqZNPEFBWcLbqYuhm2AeiOknzl107f1owtypFALaSlUF34PhjEuHDpEHEj0Aa19Lg9tp8dza2SRGfItvSF9v/P3qD9+tTZhwfkWNehgzcz7zFkrIm8uQj5oSP8V/jnSnS1wMdbHWEAUgVXneaw7GVilJOux2bOz5pIS+BBG/Jh1svwD8hKdsFjm6mgq+PIEMpDkVYsLAk9eQkZazLZ55BZFTRCjsIKwDU+3KPhMzSvv2m8veW/uesX4Z17Hq27tMdo0hDMn+zzu4rySADF6GRjiSxYhohjGFk+iQ1TcMnztxxm8L6mDNURq3sLA+bh6lvOuBETO558iYZAP8JxoXkGtGrVt/wPwUf+mF/bP0Cm29oEst5wgwbLAa+I36/RGTOgYukfn5rqcyx28ncPpGUuXO9Y/nAYVDCHRaXZGdu0bKKEz7QVm+Ei7BbphxF+/M8em9muK
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 22:22:50.0581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 476b0dd5-0aa0-4193-eb46-08d7da790aab
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5431
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-06_10:2020-04-06,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 spamscore=0 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=834 mlxscore=0 suspectscore=2
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds mastership handover support to the Cadence
I3C controller driver.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/i3c/master/i3c-master-cdns.c | 322 +++++++++++++++++++++++++--
 1 file changed, 299 insertions(+), 23 deletions(-)

diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index c2d1631a9e38..672391d845bb 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -391,6 +391,10 @@ struct cdns_i3c_xfer {
 struct cdns_i3c_master {
 	struct work_struct hj_work;
 	struct i3c_master_controller base;
+	struct {
+		struct work_struct work;
+		u32 ibir;
+	} events;
 	u32 free_rr_slots;
 	unsigned int maxdevs;
 	struct {
@@ -936,6 +940,27 @@ static int cdns_i3c_master_get_rr_slot(struct cdns_i3c_master *master,
 	return -EINVAL;
 }
 
+static int cdns_i3c_master_find_rr_slot(struct cdns_i3c_master *master,
+					u8 addr)
+{
+	u32 activedevs, rr;
+	int i;
+
+	activedevs = readl(master->regs + DEVS_CTRL) &
+		     DEVS_CTRL_DEVS_ACTIVE_MASK;
+
+	for (i = 1; i <= master->maxdevs; i++) {
+		if (!(BIT(i) & activedevs))
+			continue;
+
+		rr = readl(master->regs + DEV_ID_RR0(i));
+		if (DEV_ID_RR0_GET_DEV_ADDR(rr) == addr)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
 static int cdns_i3c_master_reattach_i3c_dev(struct i3c_dev_desc *dev,
 					    u8 old_dyn_addr)
 {
@@ -955,7 +980,11 @@ static int cdns_i3c_master_attach_i3c_dev(struct i3c_dev_desc *dev)
 	if (!data)
 		return -ENOMEM;
 
-	slot = cdns_i3c_master_get_rr_slot(master, dev->info.dyn_addr);
+	if (m->secondary)
+		slot = cdns_i3c_master_find_rr_slot(master, dev->info.dyn_addr);
+	else
+		slot = cdns_i3c_master_get_rr_slot(master, dev->info.dyn_addr);
+
 	if (slot < 0) {
 		kfree(data);
 		return slot;
@@ -998,7 +1027,12 @@ static int cdns_i3c_master_attach_i2c_dev(struct i2c_dev_desc *dev)
 	struct cdns_i3c_i2c_dev_data *data;
 	int slot;
 
-	slot = cdns_i3c_master_get_rr_slot(master, 0);
+	if (m->secondary)
+		slot = cdns_i3c_master_find_rr_slot(master,
+						    dev->boardinfo->base.addr);
+	else
+		slot = cdns_i3c_master_get_rr_slot(master, 0);
+
 	if (slot < 0)
 		return slot;
 
@@ -1010,14 +1044,17 @@ static int cdns_i3c_master_attach_i2c_dev(struct i2c_dev_desc *dev)
 	master->free_rr_slots &= ~BIT(slot);
 	i2c_dev_set_master_data(dev, data);
 
-	writel(prepare_rr0_dev_address(dev->boardinfo->base.addr) |
-	       (dev->boardinfo->base.flags & I2C_CLIENT_TEN ?
-		DEV_ID_RR0_LVR_EXT_ADDR : 0),
-	       master->regs + DEV_ID_RR0(data->id));
-	writel(dev->boardinfo->lvr, master->regs + DEV_ID_RR2(data->id));
-	writel(readl(master->regs + DEVS_CTRL) |
-	       DEVS_CTRL_DEV_ACTIVE(data->id),
-	       master->regs + DEVS_CTRL);
+	if (!m->secondary) {
+		writel(prepare_rr0_dev_address(dev->boardinfo->base.addr) |
+		       (dev->boardinfo->base.flags & I2C_CLIENT_TEN ?
+			DEV_ID_RR0_LVR_EXT_ADDR : 0),
+			master->regs + DEV_ID_RR0(data->id));
+		writel(dev->boardinfo->lvr,
+		       master->regs + DEV_ID_RR2(data->id));
+		writel(readl(master->regs + DEVS_CTRL) |
+		       DEVS_CTRL_DEV_ACTIVE(data->id),
+		       master->regs + DEVS_CTRL);
+	}
 
 	return 0;
 }
@@ -1187,10 +1224,6 @@ static int cdns_i3c_master_do_daa(struct i3c_master_controller *m)
 
 	cdns_i3c_master_upd_i3c_scl_lim(master);
 
-	/* Unmask Hot-Join and Mastership request interrupts. */
-	i3c_master_enec_locked(m, I3C_BROADCAST_ADDR,
-			       I3C_CCC_EVENT_HJ | I3C_CCC_EVENT_MR);
-
 	return 0;
 }
 
@@ -1356,6 +1389,7 @@ static void cdns_i3c_master_handle_ibi(struct cdns_i3c_master *master,
 
 static void cnds_i3c_master_demux_ibis(struct cdns_i3c_master *master)
 {
+	struct i3c_dev_desc *dev;
 	u32 status0;
 
 	writel(MST_INT_IBIR_THR, master->regs + MST_ICR);
@@ -1377,27 +1411,102 @@ static void cnds_i3c_master_demux_ibis(struct cdns_i3c_master *master)
 
 		case IBIR_TYPE_MR:
 			WARN_ON(IBIR_XFER_BYTES(ibir) || (ibir & IBIR_ERROR));
+			if (ibir & IBIR_ACKED) {
+				dev = master->ibi.slots[IBIR_SLVID(ibir)];
+				i3c_master_yield_bus(&master->base,
+						     dev->info.dyn_addr);
+			}
+			break;
+
 		default:
 			break;
 		}
 	}
 }
 
+static void cdns_i3c_process_defslvs(struct cdns_i3c_master *master)
+{
+	enum i3c_bus_mode mode = I3C_BUS_MODE_PURE;
+	struct i3c_ccc_dev_desc *desc;
+	u32 devs, ndevs, val, rr, slot;
+
+	desc = master->base.defslvs_data.devs;
+	ndevs = readl(master->regs + CONF_STATUS0);
+	ndevs = CONF_STATUS0_DEVS_NUM(ndevs);
+	master->base.defslvs_data.ndevs = ndevs;
+	devs = readl(master->regs + DEVS_CTRL) & DEVS_CTRL_DEVS_ACTIVE_MASK;
+	for (slot = 1; slot < I3C_BUS_MAX_DEVS; slot++) {
+		if (!(devs & BIT(slot)))
+			continue;
+
+		memset(desc, 0, sizeof(struct i3c_ccc_dev_desc));
+		val = readl(master->regs + DEV_ID_RR0(slot));
+		if (val & DEV_ID_RR0_IS_I3C) {
+			rr = readl(master->regs + DEV_ID_RR0(slot));
+			desc->dyn_addr = DEV_ID_RR0_GET_DEV_ADDR(rr);
+			rr = readl(master->regs + DEV_ID_RR2(slot));
+			desc->dcr = rr;
+			desc->bcr = rr >> 8;
+		} else {
+			rr = readl(master->regs + DEV_ID_RR0(slot));
+			desc->static_addr = DEV_ID_RR0_GET_DEV_ADDR(rr);
+			rr = readl(master->regs + DEV_ID_RR2(slot));
+			desc->lvr = rr;
+			switch (desc->lvr & I3C_LVR_I2C_INDEX_MASK) {
+			case I3C_LVR_I2C_INDEX(0):
+				if (mode < I3C_BUS_MODE_MIXED_FAST)
+					mode = I3C_BUS_MODE_MIXED_FAST;
+				break;
+			case I3C_LVR_I2C_INDEX(1):
+			case I3C_LVR_I2C_INDEX(2):
+				if (mode < I3C_BUS_MODE_MIXED_SLOW)
+					mode = I3C_BUS_MODE_MIXED_SLOW;
+				break;
+			default:
+				break;
+			}
+		}
+		desc++;
+	}
+	master->base.defslvs_data.bus_mode = mode;
+}
+
+void cdns_i3c_handle_slv_events(struct cdns_i3c_master *master, u32 events)
+{
+	u32 status1;
+
+	status1 = readl(master->regs + SLV_STATUS1);
+
+	if (events & SLV_INT_EVENT_UP && status1 & SLV_STATUS1_MR_DIS)
+		i3c_sec_mst_mr_dis_event(&master->base);
+}
+
 static irqreturn_t cdns_i3c_master_interrupt(int irq, void *data)
 {
 	struct cdns_i3c_master *master = data;
 	u32 status;
 
-	status = readl(master->regs + MST_ISR);
-	if (!(status & readl(master->regs + MST_IMR)))
-		return IRQ_NONE;
+	if (!master->base.this ||
+	    master->base.this != master->base.bus.cur_master) {
+		status = (readl(master->regs + SLV_ISR) &
+			  readl(master->regs + SLV_IMR));
+		if (!status)
+			return IRQ_NONE;
+		cdns_i3c_handle_slv_events(master, status);
+
+		writel(status, master->regs + SLV_ICR);
+	} else {
+		status = readl(master->regs + MST_ISR);
+		if (!(status & readl(master->regs + MST_IMR)))
+			return IRQ_NONE;
 
-	spin_lock(&master->xferqueue.lock);
-	cdns_i3c_master_end_xfer_locked(master, status);
-	spin_unlock(&master->xferqueue.lock);
+		spin_lock(&master->xferqueue.lock);
+		cdns_i3c_master_end_xfer_locked(master, status);
+		spin_unlock(&master->xferqueue.lock);
 
-	if (status & MST_INT_IBIR_THR)
-		cnds_i3c_master_demux_ibis(master);
+		if (status & MST_INT_IBIR_THR)
+			cnds_i3c_master_demux_ibis(master);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -1521,6 +1630,166 @@ static void cdns_i3c_master_recycle_ibi_slot(struct i3c_dev_desc *dev,
 	i3c_generic_ibi_recycle_slot(data->ibi_pool, slot);
 }
 
+static int cdns_i3c_master_find_ibi_slot(struct cdns_i3c_master *master,
+					 struct i3c_dev_desc *dev,
+					 s16 *slot)
+{
+	unsigned long flags;
+	unsigned int i;
+	int ret = -ENOENT;
+
+	spin_lock_irqsave(&master->ibi.lock, flags);
+		for (i = 0; i < master->ibi.num_slots; i++) {
+			if (master->ibi.slots[i] == dev) {
+				*slot = i;
+				ret = 0;
+				break;
+			}
+		}
+
+	if (ret) {
+		for (i = 0; i < master->ibi.num_slots; i++) {
+			if (!master->ibi.slots[i]) {
+				master->ibi.slots[i] = dev;
+				*slot = i;
+				ret = 0;
+				break;
+			}
+		}
+	}
+	spin_unlock_irqrestore(&master->ibi.lock, flags);
+
+	return ret;
+}
+
+static int cdns_i3c_request_mastership(struct i3c_master_controller *m)
+{
+	struct cdns_i3c_master *master = to_cdns_i3c_master(m);
+	int status;
+
+	status = readl(master->regs + SLV_STATUS1);
+
+	if (status & SLV_STATUS1_MR_DIS)
+		return -EACCES;
+
+	writel(readl(master->regs + CTRL) | CTRL_MST_INIT | CTRL_MST_ACK,
+	       master->regs + CTRL);
+
+	return 0;
+}
+
+static void
+cdns_i3c_master_disable_mastership_events(struct i3c_master_controller *m)
+{
+	struct cdns_i3c_master *master = to_cdns_i3c_master(m);
+	struct cdns_i3c_i2c_dev_data *data;
+	struct i3c_dev_desc *i3cdev;
+	unsigned long flags;
+	u32 sirmap;
+
+	i3c_bus_for_each_i3cdev(&m->bus, i3cdev) {
+		if (I3C_BCR_DEVICE_ROLE(i3cdev->info.bcr) !=
+		    I3C_BCR_I3C_MASTER ||
+		    m->this == i3cdev)
+			continue;
+
+		data = i3c_dev_get_master_data(i3cdev);
+
+		if (i3cdev->ibi && i3cdev->ibi->handler)
+			continue;
+
+		spin_lock_irqsave(&master->ibi.lock, flags);
+		sirmap = readl(master->regs + SIR_MAP_DEV_REG(data->ibi));
+		sirmap &= ~SIR_MAP_DEV_CONF_MASK(data->ibi);
+		sirmap |= SIR_MAP_DEV_CONF(data->ibi,
+					SIR_MAP_DEV_DA(I3C_BROADCAST_ADDR));
+		writel(sirmap, master->regs + SIR_MAP_DEV_REG(data->ibi));
+		spin_unlock_irqrestore(&master->ibi.lock, flags);
+
+		cdns_i3c_master_free_ibi(i3cdev);
+	}
+}
+
+static void
+cdns_i3c_master_enable_mastership_events(struct i3c_master_controller *m)
+{
+	struct cdns_i3c_master *master = to_cdns_i3c_master(m);
+	struct cdns_i3c_i2c_dev_data *data;
+	struct i3c_dev_desc *i3cdev;
+	unsigned long flags;
+	u32 sircfg, sirmap;
+	int ret;
+
+	i3c_bus_for_each_i3cdev(&m->bus, i3cdev) {
+		if (I3C_BCR_DEVICE_ROLE(i3cdev->info.bcr) !=
+		    I3C_BCR_I3C_MASTER ||
+		    m->this == i3cdev)
+			continue;
+
+		data = i3c_dev_get_master_data(i3cdev);
+		if (!data)
+			continue;
+
+		ret = cdns_i3c_master_find_ibi_slot(master, i3cdev, &data->ibi);
+		if (ret)
+			continue;
+
+		spin_lock_irqsave(&master->ibi.lock, flags);
+		sirmap = readl(master->regs + SIR_MAP_DEV_REG(data->ibi));
+		sirmap &= ~SIR_MAP_DEV_CONF_MASK(data->ibi);
+		sircfg = SIR_MAP_DEV_ROLE(i3cdev->info.bcr >> 6) |
+			SIR_MAP_DEV_DA(i3cdev->info.dyn_addr) |
+			SIR_MAP_DEV_PL(i3cdev->info.max_ibi_len) |
+			SIR_MAP_DEV_ACK;
+
+		if (i3cdev->info.bcr & I3C_BCR_MAX_DATA_SPEED_LIM)
+			sircfg |= SIR_MAP_DEV_SLOW;
+
+		sirmap |= SIR_MAP_DEV_CONF(data->ibi, sircfg);
+		writel(sirmap, master->regs + SIR_MAP_DEV_REG(data->ibi));
+		spin_unlock_irqrestore(&master->ibi.lock, flags);
+	}
+}
+
+static bool
+cdns_i3c_master_check_event_set(struct i3c_master_controller *m,
+				enum i3c_event event)
+{
+	struct cdns_i3c_master *master = to_cdns_i3c_master(m);
+	bool ret = false;
+	u32 status;
+
+	switch (event) {
+	case I3C_SLV_DA_UPDATE:
+		if (readl(master->regs + SLV_STATUS1) & SLV_STATUS1_HAS_DA)
+			ret = true;
+		break;
+
+	case I3C_SLV_DEFSLVS_CCC:
+		status = readl(master->regs + CONF_STATUS0);
+		if (CONF_STATUS0_DEVS_NUM(status) > 1) {
+			cdns_i3c_process_defslvs(master);
+			ret = true;
+		}
+		break;
+
+	case I3C_SLV_MR_DIS:
+		if (readl(master->regs + SLV_STATUS1) & SLV_STATUS1_MR_DIS)
+			ret = true;
+		break;
+
+	case I3C_SLV_MR_DONE:
+		if (readl(master->regs + MST_STATUS0) & MST_STATUS0_MASTER_MODE)
+			ret = true;
+		break;
+
+	default:
+		break;
+	}
+
+	return ret;
+}
+
 static const struct i3c_master_controller_ops cdns_i3c_master_ops = {
 	.bus_init = cdns_i3c_master_bus_init,
 	.master_set_info = cdns_i3c_master_set_info,
@@ -1541,6 +1810,10 @@ static const struct i3c_master_controller_ops cdns_i3c_master_ops = {
 	.request_ibi = cdns_i3c_master_request_ibi,
 	.free_ibi = cdns_i3c_master_free_ibi,
 	.recycle_ibi_slot = cdns_i3c_master_recycle_ibi_slot,
+	.request_mastership = cdns_i3c_request_mastership,
+	.enable_mr_events = cdns_i3c_master_enable_mastership_events,
+	.disable_mr_events = cdns_i3c_master_disable_mastership_events,
+	.check_event_set = cdns_i3c_master_check_event_set,
 };
 
 static void cdns_i3c_master_hj(struct work_struct *work)
@@ -1556,6 +1829,7 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
 {
 	struct cdns_i3c_master *master;
 	struct resource *res;
+	bool secondary;
 	int ret, irq;
 	u32 val;
 
@@ -1607,6 +1881,7 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, master);
 
 	val = readl(master->regs + CONF_STATUS0);
+	secondary = (val & CONF_STATUS0_SEC_MASTER) ? true : false;
 
 	/* Device ID0 is reserved to describe this master. */
 	master->maxdevs = CONF_STATUS0_DEVS_NUM(val);
@@ -1627,12 +1902,13 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
 	if (!master->ibi.slots)
 		goto err_disable_sysclk;
 
+	writel(SLV_INT_EVENT_UP, master->regs + SLV_IER);
 	writel(IBIR_THR(1), master->regs + CMD_IBI_THR_CTRL);
 	writel(MST_INT_IBIR_THR, master->regs + MST_IER);
 	writel(DEVS_CTRL_DEV_CLR_ALL, master->regs + DEVS_CTRL);
 
 	ret = i3c_master_register(&master->base, &pdev->dev,
-				  &cdns_i3c_master_ops, false);
+				  &cdns_i3c_master_ops, secondary);
 	if (ret)
 		goto err_disable_sysclk;
 
-- 
2.17.1

