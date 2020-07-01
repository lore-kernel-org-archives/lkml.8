Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189A6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFD3E20722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="PiTdnBm0";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="JQgIevwy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgGAGXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:23:37 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:57654 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727845AbgGAGXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:23:25 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0616H8i8014514;
        Tue, 30 Jun 2020 23:22:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=glIcFcCBnE/kWZjNZISuj/oddo60+Gb0CBumRR6l66c=;
 b=PiTdnBm0r3cvDg1NPdITY1B0G1QBOOqS4753Yn2hBA3Osbmcu1Y7I9LU8vcE1HhKivA/
 Os88vVL2PAe8yTcH/jt1QkjQVqrKIzexS8PTZp2apQlfSxGGmkGNLslF+VgxHaXfEvBW
 8MmVQ24pqT7aZmRT97zYexiaBSXsjCDbOxpVNJpJgW/JVjE6I3RdDEdWBYgl1axy6uYW
 pKMq2oz3439j0ZD/9+1BI7EUOOUCPoMuFTE2/WYYF1BYFDmdjPT3w3kAPCe2rb1kgezz
 ZzbjKNgZXqy1HkqBUNX5QM66rvskdGjPw8xSVJ8EEFtYZWo7OG/Mb1fupGY2iCnBaDH3 1Q== 
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2059.outbound.protection.outlook.com [104.47.45.59])
        by mx0a-0014ca01.pphosted.com with ESMTP id 31x2nxxa8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 23:22:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaiENie34PiCtDcAbRMC1+wN0BOc4/xz3UiXH/PCz+36UDYuimj3n0PLhniGDwl7t4NFsP7a1xEawShwHGlVM2V4ql2VlzKXPUaE3jaUz9Z1g1XoyY6//NLoh+mjDQLosx8rAOeDUbd46j4ajQEq5yQiatcGb9Jh00GaLU5Fi3S3YofE24/o1yv+NKvpFrwB/PjuqKSqkUpjRVLFZYXeZQlTKyuos67FoubSk6dTFSIErF6D7FiMVeicw4QjuU0tkPXQMPT6TFBmMxSZKkqRFCIna/3pAjAbgARzbVmcvwax3r9xmcyOJ3+KKrYTcHUg8ChdFUyu7gB2FLY3jwHsmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glIcFcCBnE/kWZjNZISuj/oddo60+Gb0CBumRR6l66c=;
 b=MV91qjdQX6K2+LBKL5pJNdn1gyuHVuB+PRP7pxQ3Vlo92Ndmj/SZxgm7rnWuutTOSSXPzaSv+P79+GqOhGU6S0gMaxKX7cWqj8ZWaP8lDl06fcenprr88A6OH3mEXK+pHFRagXVIv36td+T1AjKfNI3kvwMuDAs90tsrda3WivcMfEcSiTPw25Kb8jIJCGsQQegnz8xz/t3SlbWYK4zaTi3ei68vYDEQ06W/sjySQsyPK6m4JoM3UH6Xcv/tqP81Npar7/CqC7C170DyITRuPoLHt0lHsYF7vqie62QqvqTgjR/aJJI26bzqg+JsWSrOpBA/z9zLBb3qMMxS5xhllA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glIcFcCBnE/kWZjNZISuj/oddo60+Gb0CBumRR6l66c=;
 b=JQgIevwy0OAHa1ai8oq618sRIdnR5dn9wmu3qtB+J68egRcKl/BAtJGpC4xBFZcC8fF/UhA/5aahLHK+KIa3JGwRwyAfljFibLnvLuP06zNm6keDSqlFRkj6exvpoJtl8UPqXdzW4MU77d7XMubvD+b760X+CPF1v2YHQeBwwiY=
Received: from BN4PR12CA0023.namprd12.prod.outlook.com (2603:10b6:403:2::33)
 by BN8PR07MB6338.namprd07.prod.outlook.com (2603:10b6:408:b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Wed, 1 Jul
 2020 06:22:54 +0000
Received: from BN8NAM12FT046.eop-nam12.prod.protection.outlook.com
 (2603:10b6:403:2:cafe::97) by BN4PR12CA0023.outlook.office365.com
 (2603:10b6:403:2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Wed, 1 Jul 2020 06:22:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT046.mail.protection.outlook.com (10.13.183.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.16 via Frontend Transport; Wed, 1 Jul 2020 06:22:51 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0616MjiT092304
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 23:22:50 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 1 Jul 2020 08:22:45 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 1 Jul 2020 08:22:45 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0616Mjep030611;
        Wed, 1 Jul 2020 08:22:45 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0616MjHm030610;
        Wed, 1 Jul 2020 08:22:45 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rogerq@ti.com>, <peter.chen@nxp.com>
CC:     <dan.carpenter@oracle.com>, <heikki.krogerus@linux.intel.com>,
        <colin.king@canonical.com>, <jpawar@cadence.com>,
        <ben.dooks@codethink.co.uk>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH 7/9] usb: cdns3: Improvement: removed 'goto not_otg'
Date:   Wed, 1 Jul 2020 08:20:02 +0200
Message-ID: <20200701062004.29908-8-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200701062004.29908-1-pawell@cadence.com>
References: <20200701062004.29908-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(36092001)(46966005)(81166007)(82310400002)(83380400001)(82740400003)(47076004)(8676002)(8936002)(86362001)(7416002)(54906003)(478600001)(316002)(110136005)(36906005)(42186006)(356005)(107886003)(2906002)(1076003)(26005)(36756003)(4326008)(186003)(426003)(6666004)(2616005)(336012)(70206006)(70586007)(5660300002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88dae4e6-c7b7-4cdc-3601-08d81d872f11
X-MS-TrafficTypeDiagnostic: BN8PR07MB6338:
X-Microsoft-Antispam-PRVS: <BN8PR07MB633862413F974E0CB5D9DB3ADD6C0@BN8PR07MB6338.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ILGtKNxW8tcV9Jwl6eUZvDZ273Vk2KKwx3TOJ4xwN9T2DaeUfFQOfk42wb97PLP86oGDnFR8onT1CWWJWeJBtmQmkqdcl6fstJLE4m/Vf2XTzo+rkxmLfla8oO0LxqKrasBMykmnOls7+AUf+oKNXUkQQMcIOAzXnvVUGhjXl5En/J1m6tOr9k9YHKCioXz+/0r/ejKZSirh/1kqEPeW8DoEIAhH1H3IbztwxtGOzd+NU2KeUfR/SQQHvDpAq7HgTxWYluWA6gXmRvSoapqmKyoLErOOn8K7N8DRc66pX5MGP4WmpnLUJsv/YuwgYOyOhHmrjD79YsPVJvMUwsO2qnSsHP/05K0RaNTAqSgHqeViCTSxIWCfzv25eOVhcJXETkeNu4+wimTWH0xw4sm9ygrNZaXDraCNEV3VCrdxB6U=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 06:22:51.8833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88dae4e6-c7b7-4cdc-3601-08d81d872f11
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT046.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB6338
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_03:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 cotscore=-2147483648 mlxlogscore=776 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007010045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch removes 'goto not_otg' instruction from
 cdnsp_hw_role_state_machine function.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/core.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index c3dac945f63d..591186987245 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -191,11 +191,17 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
  */
 static enum usb_role cdns3_hw_role_state_machine(struct cdns3 *cdns)
 {
-	enum usb_role role;
+	enum usb_role role = USB_ROLE_NONE;
 	int id, vbus;
 
-	if (cdns->dr_mode != USB_DR_MODE_OTG)
-		goto not_otg;
+	if (cdns->dr_mode != USB_DR_MODE_OTG) {
+		if (cdns3_is_host(cdns))
+			role = USB_ROLE_HOST;
+		if (cdns3_is_device(cdns))
+			role = USB_ROLE_DEVICE;
+
+		return role;
+	}
 
 	id = cdns3_get_id(cdns);
 	vbus = cdns3_get_vbus(cdns);
@@ -232,14 +238,6 @@ static enum usb_role cdns3_hw_role_state_machine(struct cdns3 *cdns)
 	dev_dbg(cdns->dev, "role %d -> %d\n", cdns->role, role);
 
 	return role;
-
-not_otg:
-	if (cdns3_is_host(cdns))
-		role = USB_ROLE_HOST;
-	if (cdns3_is_device(cdns))
-		role = USB_ROLE_DEVICE;
-
-	return role;
 }
 
 static int cdns3_idle_role_start(struct cdns3 *cdns)
-- 
2.17.1

