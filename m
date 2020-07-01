Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C88C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CA6320722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Ti96LA5T";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="c4kTMI28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgGAGXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:23:22 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:21184 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727071AbgGAGXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:23:16 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0616H9GJ014532;
        Tue, 30 Jun 2020 23:22:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=qVUi0yl+qIKCwHrcuhRPVPyw5qHBBBzSwFgBYXpfC88=;
 b=Ti96LA5TJg3p+sNyPtq57pjSShSdS16cOWKFOeCPAyY8OzrM+RlDsaH8S1nhOkOfeGU6
 bb8J1OMhhnWq5JWq8seV+2WFwYUd0hniNZLxQ68ZwMImbpXDUESaBCU1B9Ak4M0YZriM
 kUyT9ZuVDPG8D907i4vlQQ3QrtVFv4Xlmg/WLET5WpI3444R8plZ/tWjpEGIFZTvL/Wv
 uV0oJq1ih/d9I/iV20wVOgqPn44xwQecinWIXsCFeO8L9MagAFOWK6aWmoaBeTk8KCYR
 jBdkpHqo4slLNI3OXvHgO43Kgodwkrijbia8IMYUV3ICjunVAjlE9i1jQkFMyqMk2gNq 6w== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-0014ca01.pphosted.com with ESMTP id 31x2nxxa8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 23:22:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbZysMvCqnkv3x2exnUB+26+2fNvLBXevBArztHKvH6gru47aIa1ZI2/Jf/9BO4qZuaPMYri5sHcfFnXexiCzw8632Fn83pCd9ibxz/19oM/B5McOfLy5hE+uQF2NQ8BJu5dId8HFAtocnG8zSz9erHcE6ZNMpagM/rjj+iLzzxnYMdEKUhjXdpHk6D5wS/A8FMlY6SpF22RfwGDEJbe1KfaU0B7Qd3sbEfCziVuwYlo3D9nfIntMVD78Lqx2IS+qd0zK8I8Ty+TNlzeJ/15CftWk0PZUSOQjUYjbKBfgDrjJSL07tdjhsdEU/NWvEfDKWISCLIPAY5TpMGdoKE8Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVUi0yl+qIKCwHrcuhRPVPyw5qHBBBzSwFgBYXpfC88=;
 b=XZoT3y/4GmaBYUhIiI5UpE26Zf5oJE2ma5St9PqliorxaPSB570ABURVCmPvD41JCAMT/8un7dpJdyK6M29WAxBxV7qPJHfSNMURAFcvZ13MHft90IoNgJrsoLhL6fJrXV4GZ6Zb3pMFFCg9ZMViNq4iu5Q9x4FrpyIj0c+rBLg9OkxSdB1HEQJjcqRy0/dauYl1H3L1+QCfapWJ4J/IyNbRHYvyqYKor/rlRIxB0hHCzSB8UaPcjA5JAHsPpenV2NRx0WUkdzOKYE6c5iT0X16hGof1iyCwpC1/UDmZjc7tRIEE0LBzFMg5oYDCgj2Gp7wL1NB2pSPbUO2XqZHSRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVUi0yl+qIKCwHrcuhRPVPyw5qHBBBzSwFgBYXpfC88=;
 b=c4kTMI28dsniDehUmE0/oBK9Zg77A6HJxkOd6geZHuEwf09KJI/dMveYkhdWm7aznCGiw7ckQA74ux6o2qnLUt5ahllWfSv4FFioG/67BfhYqKawEZEY4fBasPtVAQg0qI7xdGgMJDx0aLgd1c28c9DFLA1J6N8jH2tjancwcHA=
Received: from BN6PR17CA0006.namprd17.prod.outlook.com (2603:10b6:404:65::16)
 by CY4PR0701MB3811.namprd07.prod.outlook.com (2603:10b6:910:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Wed, 1 Jul
 2020 06:22:53 +0000
Received: from BN8NAM12FT015.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::9f) by BN6PR17CA0006.outlook.office365.com
 (2603:10b6:404:65::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend
 Transport; Wed, 1 Jul 2020 06:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT015.mail.protection.outlook.com (10.13.183.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.17 via Frontend Transport; Wed, 1 Jul 2020 06:22:49 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0616MjiO092304
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 23:22:48 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 1 Jul 2020 08:22:45 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 1 Jul 2020 08:22:45 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0616Mjfn030592;
        Wed, 1 Jul 2020 08:22:45 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0616Mjx5030591;
        Wed, 1 Jul 2020 08:22:45 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rogerq@ti.com>, <peter.chen@nxp.com>
CC:     <dan.carpenter@oracle.com>, <heikki.krogerus@linux.intel.com>,
        <colin.king@canonical.com>, <jpawar@cadence.com>,
        <ben.dooks@codethink.co.uk>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH 3/9] usb: cnds3: Improvement: deleted !=
Date:   Wed, 1 Jul 2020 08:19:58 +0200
Message-ID: <20200701062004.29908-4-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200701062004.29908-1-pawell@cadence.com>
References: <20200701062004.29908-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(36092001)(46966005)(1076003)(70586007)(70206006)(8936002)(2906002)(26005)(4744005)(54906003)(110136005)(82310400002)(36756003)(47076004)(336012)(36906005)(4326008)(186003)(356005)(6666004)(83380400001)(5660300002)(86362001)(426003)(8676002)(82740400003)(478600001)(42186006)(316002)(107886003)(81166007)(7416002)(2616005);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 934ff23b-0e5a-4dd1-97a5-08d81d872da3
X-MS-TrafficTypeDiagnostic: CY4PR0701MB3811:
X-Microsoft-Antispam-PRVS: <CY4PR0701MB3811D3B2A4786FA3CFE81F54DD6C0@CY4PR0701MB3811.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P5Jj4VdyywmabQN5SiT3l8LgzC5SCes76q8XW1/X/W6gyeMXHqHcBICIrvFVs/SMskYwF1Ofd2mIb9mAqPQpIeg4nQnMpfTMYQUSCebLOdF9oE8KAfVV+IIpuKvR3WbXNGFStqC9l/EMbaz8N7KjijToObCBweZM3TW4zXvqYbssBB5VNNFOviVG3ImMbWYvBaP4CZnRedvagP6BEneaeMncI7esSHoQjRKD6HbULMD8td6Bf0yqlusq9Gn0BdUxj/JmdS9/6LyICbKxQ07lpTHoGyl0ZP6h4vgevjBn4/Mpi9CK+In54zcN/o3y91cOb4DXa+GSQg0eQDxII7mFPBKi0+HUTN0VQDF+dt8HoDMQ8bjhR+0kpWQjWibE57L18hp021FlrcKg58/zxjRup+yJdgyjAD12ip53IIqc94k=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 06:22:49.4802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 934ff23b-0e5a-4dd1-97a5-08d81d872da3
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT015.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0701MB3811
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_03:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 cotscore=-2147483648 mlxlogscore=835 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007010045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch deletes unnecessary != from condition statement ini cdns3_drd_init
function.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/drd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index 4939a568d8a2..6d2da504ad49 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -365,7 +365,7 @@ int cdns3_drd_init(struct cdns3 *cdns)
 	}
 
 	state = readl(&cdns->otg_regs->sts);
-	if (OTGSTS_OTG_NRDY(state) != 0) {
+	if (OTGSTS_OTG_NRDY(state)) {
 		dev_err(cdns->dev, "Cadence USB3 OTG device not ready\n");
 		return -ENODEV;
 	}
-- 
2.17.1

