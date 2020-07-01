Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A493CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75B9E20663
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="YYI9vgHH";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="lUZTHtt1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgGAGXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:23:19 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:45098 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726615AbgGAGXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:23:14 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0616Ff4F012562;
        Tue, 30 Jun 2020 23:22:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=xZto3yDE74aRxXazV/yNAF+o9WnIWRMTIfRYscNdEWA=;
 b=YYI9vgHHw38REwRojmMzxW/TqFNuTGtySHTx7O89h6tquql/BRVKDbLbJUvwfLfcN0r9
 ZcfezP6xCT3X+7owS4jKy4a6tlp6VPAs3F2LpBRDaodmQx6CwQJMpAZFO9VWFBeCBTES
 lktnOgw+4wvvkt2e9IKeBjmLBpwlLi+7LTCLbfWw5BD74jraWw5n3Zd+2VoY2KaHZR9G
 6ou3EhhSYRIqRdGEFp/zL+JzEwxK1lglcRdcsI5j4RLUhwtFxBtYhLTeFiQdE6/zMalG
 Ogef2B0rKerfC3FYfikTld8nDxCMRaG/S2xPNEKil7k0vOgUQJMfV99S/GVrfVS1OYn5 4w== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by mx0b-0014ca01.pphosted.com with ESMTP id 31x1pyq6s4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 23:22:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFdyeJ4aPd9BYQv7J7mCy6BEpoQOXV84yh+HpvEl1WvblViFA8pfTw6Gk47JJORBM150fz0OUpFBR4OcVjh33/U+bNxzKvHTpPOM1WhL9DZ5jh1Xs1INFQgi7z4VMMq+yPqjZkL/2DGuhCjwNybAHz+udpUoUkhFArGDDEDEjqzhymUOt5uNxNc2HymEayIWXkW5fjffMiHq+M+7km5PgiXS7ueHmogS4NJOSh3pEi88uZqqWbEVF2Q2/Hej6FssWSLnpXUIFkwH/tnbXqwCMu13W47BclJFd8FsTH6l1tvCjDqrIxYgG/c9DMmduLnLoyw0xvxZoLW46CE3DeeiZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZto3yDE74aRxXazV/yNAF+o9WnIWRMTIfRYscNdEWA=;
 b=BxB5ZR/Fws4bveliMnygoSNUkY2kZfg+FiNPcc3X2IrxAcfGkPt/AlNgBzISJXRbKku7junSnBmSXkQIvzDbVASsvpXR/Iy2hJgVUbnnK6WsZam7hszJWt3JkESU86zflUyl6hgBhVrvNCHVpv8OracsH5inLtSiV4cnNVtUJty/zszJw5WqKKgiLcUkR4jzDeUZeew2pSpji0IdarYmkW2ENcIXCQkQ6HkYvwBeOUmluDMuTZcxYOj0jXGfQKkBhkio1hduS1tI4jg9/fIiS9jS+heMzw4Fhr4A6XCvE31vcjRqlShvz8DtxSM1AyOcXqRV0W9ykpm34XvF3vRgOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZto3yDE74aRxXazV/yNAF+o9WnIWRMTIfRYscNdEWA=;
 b=lUZTHtt1f791XUbMqu7PPib1WLCx4SXUGVK7yM0GYBCrip2TsVLHAxvayHtfgryMFGqcqwGTlBR3NwLHdIN91jyqQ8s+94H2i4rpLYRRhoeeVU+rdS0VCqqQ7jrFlsA6BBD+h9mBIT6uzVqnmb+apaFRflhXThAMtH8G1lkjB04=
Received: from BN1PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:e1::17)
 by MW2PR07MB4121.namprd07.prod.outlook.com (2603:10b6:907:9::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Wed, 1 Jul
 2020 06:22:51 +0000
Received: from BN8NAM12FT007.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::53) by BN1PR12CA0012.outlook.office365.com
 (2603:10b6:408:e1::17) with Microsoft SMTP Server (version=TLS1_2,
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
 BN8NAM12FT007.mail.protection.outlook.com (10.13.182.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.17 via Frontend Transport; Wed, 1 Jul 2020 06:22:48 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0616MjiN092304
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 23:22:47 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 1 Jul 2020 08:22:44 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 1 Jul 2020 08:22:44 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0616Miel030583;
        Wed, 1 Jul 2020 08:22:44 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0616Mihw030582;
        Wed, 1 Jul 2020 08:22:44 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rogerq@ti.com>, <peter.chen@nxp.com>
CC:     <dan.carpenter@oracle.com>, <heikki.krogerus@linux.intel.com>,
        <colin.king@canonical.com>, <jpawar@cadence.com>,
        <ben.dooks@codethink.co.uk>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH 1/9] usb: cdns3: Improvement: removed cdns3_get_current_role_driver function.
Date:   Wed, 1 Jul 2020 08:19:56 +0200
Message-ID: <20200701062004.29908-2-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200701062004.29908-1-pawell@cadence.com>
References: <20200701062004.29908-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(36092001)(46966005)(2906002)(70206006)(107886003)(8936002)(7416002)(70586007)(8676002)(4326008)(186003)(336012)(2616005)(110136005)(26005)(316002)(42186006)(54906003)(36906005)(426003)(478600001)(5660300002)(1076003)(4744005)(81166007)(83380400001)(36756003)(82310400002)(47076004)(356005)(82740400003)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 406bbf3b-4454-44fe-5622-08d81d872d36
X-MS-TrafficTypeDiagnostic: MW2PR07MB4121:
X-Microsoft-Antispam-PRVS: <MW2PR07MB41218EDF2273858E2A0C5EE1DD6C0@MW2PR07MB4121.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pH8K0I+MdC6npA0cxFHKTQajswmWS+tQQO6JQU+AMyZ1styOsvvxNwN62uVcIiHK/TAK7UEa82kcywTpWQhK795hV10c0N/zQ0eOoWHncmPpQyX/q060iGj4eUIe0g9DPhARzyuxPX2DFbHTdkaUO1ujHUNK+uGx15WZhz0hmOTtx3BdMer21sqvouuaJLopCh8cUooZWSwgRsZ3aTn+1yYXQiZ3BpFnxtOct7LPNHqUm7uE0yTr8j3v63qDr11TvQDlsdLL1u5+EEX+GWQlGNNpg3uVTUrZi6mZrkURI8/4MdoejaJiZYaQVu1wn9TuyTYjYlAupHN/bxx96NIwaYBOqBAxIKDgZU3GbKuLukL8x1ZmGcHPwNnLRJ/tvHCTessqvdA+sJZlUMJhOx+b6tvQqiWx7eGn/IFd5pDRnZk=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 06:22:48.7722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 406bbf3b-4454-44fe-5622-08d81d872d36
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT007.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB4121
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_03:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 malwarescore=0 cotscore=-2147483648 bulkscore=0 adultscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=711 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007010045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function is not used in driver so it can be removed.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 19bbb5b7e6b6..eaafa6bd2a50 100644
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

