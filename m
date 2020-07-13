Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65465C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B2B620758
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="e5LQa87k";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ksQdYWq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbgGMKGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 06:06:35 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:33664 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727834AbgGMKGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 06:06:33 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06DA35kU026888;
        Mon, 13 Jul 2020 03:06:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=pa314vjLTrlCI4ZsW8ad7qvIzY3kOvCySH9VwpWt/dI=;
 b=e5LQa87kngn9ojAhvngov4ppekTddqhVd6G6cugezwbQTbRUID3bsr4sz4SFfNEpEbb5
 8PCbl5hAfbwIZiCzgF6/qT+26pfgfWJutYfXJSwf+Cj1xmqyQWudCQU0fj+uTGcmuwbx
 vDCf5k9Hym9BMPonzClouBYGmx6esORIA6ObMgY4kNmq1wvFxIBlhrlr96GjUr7rzBnP
 uMpYEgm3rX5z+MiM48DTVcWO2hH5aW8dcSvZY2oO7bbanR2auBxOOLl6CFE6vF2W+Msq
 49JYcQEHVbSIQHRJdAG2wKgZj8feB3WYNTi12rrs6AutUhVJNxXoj+Ctz6WqSbAvcCp9 Vg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3279yud6c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 03:06:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdsLu/HUO2xT2rbZLhNdVposS95A/BNuSbST50TX4jvfNjcdTW+0obOSM0PYtQydQhM0aqRj6rfdew71CK2GW1gFwn6X2R0tNKh40AZLMGWOM4A9jemAwGFQVb06iV4IqYvj+N3OIZej4zgJmWUOgKNaSQtQkY3V6M0tHwmrB3KbyECOc7e0FkMnZgVkcWb3HKiNgvdbS8AV7VayL3W8DPLXOAegQ739PeJPKl54FnLahl32bFPS1OstJ2SJT22P/qJGxiL+LEdssO2c0ARlwwq3YlBpf52bnQ1yur++Iy84WPid702KPlqp94SgcFwemPKe+CJM0yzi7v4+yplCxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa314vjLTrlCI4ZsW8ad7qvIzY3kOvCySH9VwpWt/dI=;
 b=WfqirMFDGxPSYiwz59uGe4nxIGEpI7bs0WtZmJFEHPbu/cvoReM9qDkrhuHPriqSfyvSMTXq+tQIvFaONniMJ9wn98C95uRec22u7A1pIWAN2cJyJ8l4/lmJHmdBSDB+kYqgOllrnvrV7xUr1XpnMJF6GYzvR2+0Nqr+BehxlbstxHylVUqEM2SaXcpEhLmfXtvzTByzboq2bNRazxsl4eXYrLWuOGqIACowzlQd4YnsW/9A2lpuriST8Hp/iugx+49ifQ+Q7krUUpVb3HqknJvJrHyrsVi4neEa76tlBumu0OghD4Aq7sB61he5vzanAegaa88y8Ig1dvUL9vJ8Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa314vjLTrlCI4ZsW8ad7qvIzY3kOvCySH9VwpWt/dI=;
 b=ksQdYWq2p8FMOKhiFQtEk2f0lHpyxkPs98qqMfQOypvmIKg54UGB+E5tvjx0uKCzHmyl6vrdJ1t6GTeV9YL9ITts+G2vRebK8lRCujt+rRoPfdH4FhrTJ9mR44Up1mYDKDyW2qcS24NG1yBAPukRZUodd3c0255YJq4csYhJddA=
Received: from BN4PR10CA0019.namprd10.prod.outlook.com (2603:10b6:403::29) by
 CY4PR07MB2936.namprd07.prod.outlook.com (2603:10b6:903:2b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.23; Mon, 13 Jul 2020 10:06:08 +0000
Received: from BN8NAM12FT026.eop-nam12.prod.protection.outlook.com
 (2603:10b6:403:0:cafe::d8) by BN4PR10CA0019.outlook.office365.com
 (2603:10b6:403::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend
 Transport; Mon, 13 Jul 2020 10:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT026.mail.protection.outlook.com (10.13.182.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Mon, 13 Jul 2020 10:06:07 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 06DA63Yp013926
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 13 Jul 2020 06:06:06 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 13 Jul 2020 12:06:03 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 13 Jul 2020 12:06:03 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 06DA63qp028627;
        Mon, 13 Jul 2020 12:06:03 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 06DA63gF028626;
        Mon, 13 Jul 2020 12:06:03 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rogerq@ti.com>, <peter.chen@nxp.com>
CC:     <dan.carpenter@oracle.com>, <heikki.krogerus@linux.intel.com>,
        <colin.king@canonical.com>, <jpawar@cadence.com>,
        <ben.dooks@codethink.co.uk>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2 1/9] usb: cdns3: core: removed cdns3_get_current_role_driver function
Date:   Mon, 13 Jul 2020 12:05:46 +0200
Message-ID: <20200713100554.28530-2-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200713100554.28530-1-pawell@cadence.com>
References: <20200713100554.28530-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(36092001)(46966005)(70206006)(6666004)(2906002)(70586007)(1076003)(86362001)(478600001)(82310400002)(8676002)(4326008)(107886003)(83380400001)(8936002)(36906005)(356005)(81166007)(4744005)(36756003)(110136005)(2616005)(7416002)(47076004)(82740400003)(336012)(426003)(42186006)(316002)(54906003)(5660300002)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39a91f26-aa9b-4ff5-68bb-08d827145ca7
X-MS-TrafficTypeDiagnostic: CY4PR07MB2936:
X-Microsoft-Antispam-PRVS: <CY4PR07MB2936ECCC0CD404DFCAE31DA6DD600@CY4PR07MB2936.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1rofIEEVIgdk3MnE148E1tUJEzdsabxNXhAZ4mr8f4brnMWGkjvn3MYD3gbLduVG6MEgsi1/PCDJmFoQCjdCA1wrYZMrC7galuig22nUFAq68gazBCCUCRj6qCvaEbia1i41po3XsSZMbghybgZ27vHA7xeGw66efYklO/nLYqQo0yskAY7e+C/N6PmjiMhU/ynJwgSh6AS5VSJwIJ51SikFWd54yOcgAm3e9haPGXm/mNI3Hp2x9reH0eOH7kxSQo5hKQNE14UMeJG78AzwyTWNyLU/i3XtCHKkRa4bB3B6afE13WjYL5E6Z29gyz+2PwEJucWn4gkg4RD3nFiulSeyflivTUH97F9gClkMwxH7QWt5NboPq0vzFTRpe8WwcfQrXDvqbwUdZov2muB8aa5l3Qdms2f5C+HB+Y2k3jQ=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 10:06:07.9869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a91f26-aa9b-4ff5-68bb-08d827145ca7
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT026.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2936
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_07:2020-07-13,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 mlxlogscore=827
 mlxscore=0 phishscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function is not used in driver so it can be removed.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Reviewed-by: Peter Chen <peter.chen@nxp.com>
---
 drivers/usb/cdns3/core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 59e5e213a99b..1f77fb5aefbf 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -27,13 +27,6 @@
 
 static int cdns3_idle_init(struct cdns3 *cdns);
 
-static inline
-struct cdns3_role_driver *cdns3_get_current_role_driver(struct cdns3 *cdns)
-{
-	WARN_ON(!cdns->roles[cdns->role]);
-	return cdns->roles[cdns->role];
-}
-
 static int cdns3_role_start(struct cdns3 *cdns, enum usb_role role)
 {
 	int ret;
-- 
2.17.1

