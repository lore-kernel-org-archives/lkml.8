Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C535C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E2632078D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Lkz++Zn4";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="TIJvOLGK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgGAGXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:23:42 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:25298 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727843AbgGAGXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:23:24 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0616FbUV012536;
        Tue, 30 Jun 2020 23:22:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=gGy+JOpbJbLzh9foRZUfWng5NVvSJm+B3jjxKZ5H8Wg=;
 b=Lkz++Zn4sAbr5XL3A/hayZb5dRg32lvhELUU2IitrSPxo2n1Llsl8P7703tkK6EIEkGA
 62OLgVceUNvd1ATR9FzjPltk/aBBAduIkW16YbX4F1GUicd+h6bRDT9wSHufIWBW5NFk
 dWJxDTz5Tfk9Gwd674LpANxYqJHADJosKILvTqScsQlBz9VrtipoddrPV7ozvSroDe9l
 2pG0imf7gEZ9rD/b/nPa8PRzuT9PQxK4JHW15ACqTgDZLuqXrhzGvxIeNjDCuzIyi0rR
 8rJ6IwfzjWhvUzlK4Wa1raGC0XrsSHL26uJj5Wd/An4c7ShdxsX6NXeerygCPZF4mjwH eA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0b-0014ca01.pphosted.com with ESMTP id 31x1pyq6s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 23:22:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTPsQYOs1hbpbrtHGqUM0BTh04xLaTsC4te1S0XpOdYizUxiPWs2kcWcmdEpTg5iKjY/t7CoQ0AzimwKwGubMVvNBhsHds7w+izkSYh1Ih6Js5xjd7Xg/YaunnDcTuMjnpdKUiUZC4dnRpJgOU6czV6JkMYYl4/kGeCCysKQalvKFrEoFRXYIr8pTRkwqINs3fwMY2HU7c8+x+Q1jxmBt8qRqT7NEXjOOnYCxvH3JLn0PekrJMx3Fh6b5kRG5E/MFigo6gXdGnxBdRDc/MEBMgUoII/cWqLyr5R8U6GrRjNEIL8/cYnrPTU5IcwzRNed0YUYpE6G9oj5jLW4xImQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGy+JOpbJbLzh9foRZUfWng5NVvSJm+B3jjxKZ5H8Wg=;
 b=RAjT9U4icNFxya8msDg3ziRichOIZjb7vJdgurxoEegOl5b7lCgxI94lD2Apvg2hzCZlwVdCUTQXDwlLpybdRQlpwAcSE1zU5aiMc3JX/grV10oSn6KuJTugTKJfX+GzNW6zd1xBWbO89hpVSvm6QjAX7jzl+Fd97n2/A7KQaZsRHn6lPmcqQ5Ns5beZfhLx8Tpksvw+0H+VgkIvPMi/EGdKqJWNgRyJRr3eQ0a/Tsj1+jDWP4Zhgs1+aDDHXvlErnGvjWzqnh9az8UsHeHOEVxVIyQJX03RYCtbn99IUsbWaw4s4KzI2f9DKNKeSOa4Ph5qbTc8WQIBkBmCvriFfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGy+JOpbJbLzh9foRZUfWng5NVvSJm+B3jjxKZ5H8Wg=;
 b=TIJvOLGK82CbhKzWOtHaSnC+XNE+Hx0aOt/xdzWP4c2qdadu7SEAsPv2cxr1627Jz8Qd6VqXnWefk6KhRRJz74KhGsPEGkfGn2kIahG5WQqyq95sGwZPmEYIGiBxGtYmCoOV2mkzy1fz49kczsQYPoLXl24koMJXWXHjwTNbEYk=
Received: from BN6PR04CA0081.namprd04.prod.outlook.com (2603:10b6:404:8d::31)
 by DM5PR07MB2956.namprd07.prod.outlook.com (2603:10b6:3:c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.24; Wed, 1 Jul 2020 06:22:50 +0000
Received: from BN8NAM12FT020.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:8d:cafe::aa) by BN6PR04CA0081.outlook.office365.com
 (2603:10b6:404:8d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Wed, 1 Jul 2020 06:22:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT020.mail.protection.outlook.com (10.13.182.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.17 via Frontend Transport; Wed, 1 Jul 2020 06:22:48 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0616MjiM092304
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 23:22:46 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 1 Jul 2020 08:22:44 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 1 Jul 2020 08:22:44 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0616MiuD030573;
        Wed, 1 Jul 2020 08:22:44 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0616Mhx7030562;
        Wed, 1 Jul 2020 08:22:43 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rogerq@ti.com>, <peter.chen@nxp.com>
CC:     <dan.carpenter@oracle.com>, <heikki.krogerus@linux.intel.com>,
        <colin.king@canonical.com>, <jpawar@cadence.com>,
        <ben.dooks@codethink.co.uk>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH 0/9] usb: cdns3: Improvements for cdns3 DRD code
Date:   Wed, 1 Jul 2020 08:19:55 +0200
Message-ID: <20200701062004.29908-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(36092001)(46966005)(8936002)(70586007)(6666004)(2906002)(70206006)(4326008)(356005)(82310400002)(42186006)(2616005)(26005)(5660300002)(86362001)(36906005)(8676002)(316002)(36756003)(1076003)(107886003)(186003)(81166007)(47076004)(7416002)(336012)(82740400003)(110136005)(54906003)(478600001)(426003)(83380400001);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08dc5afe-adaa-4df3-6935-08d81d872d0e
X-MS-TrafficTypeDiagnostic: DM5PR07MB2956:
X-Microsoft-Antispam-PRVS: <DM5PR07MB2956616EBB4A09594EBEDCC0DD6C0@DM5PR07MB2956.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qd8NQM7Ne2Suq+n8mAIU5IAVHad21o4WD2C+ome64JI+gQWov/aPPqiLL/QlN6E/ndQxEKyX9/9OrC4WutndP3cNnJ5hb+0xA1mlvxfz51GIdoBVWocr+VCcsfr7QVrRCv2pG418nHtlYELGtMWmenVSFP6QvWyCSIwgjWATKhuyzaEqhPuiuOtYUNrMtHx+QescIwHrEcmDC7YRwTzH0cK9CukJ3mi5MLsQ3y8OUiCfk9JC56vMaI0nA1gs46FSnPpLoYO2zAFxY/5q715wL1YO+F0kcTBfPwwEPmlXl+VsOa9vxj/pfnfXPLY+OouizknkgAHvUAfwcfxX2oRLu93132KJd+ETGxzsOmW0N+YkrnTvr2+aoBbZhudVL3DTrg5G6z8WZptGfN16IIogfEHqiazqYLncNNXffylem28=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 06:22:48.5105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08dc5afe-adaa-4df3-6935-08d81d872d0e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT020.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB2956
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_03:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 malwarescore=0 cotscore=-2147483648 bulkscore=0 adultscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=588 spamscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007010045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Series introduce some improvements to drd.c, drd.h and core.c files of 
cdns3 driver.

Except for the first (1/9) patch that removes not needed function,
the rest patches make improvements suggested by Dan Carpenter
during reviewing CDNSP driver.
CDNSP is the next Cadence USBSSP  driver which will be upstreamed.
The DRD part is similar for both CDNS3 and CDNSP and Greg suggested
to merge the similar part of DRD code. As first step I want to merge 
some improvemnts.

Pawel Laszczak (9):
  usb: cdns3: Improvement: removed cdns3_get_current_role_driver
    function.
  usb: cdns3: Improvement: removed not needed variables initialization
  usb: cnds3: Improvement: deleted !=
  usb: cdns3: Improvement: return IRQ_NONE explicitly.
  usb: cdns3: Improvement: changed return type from int to bool
  usb: cdns3: Added CDNS3_ID_PERIPHERAL and CDNS3_ID_HOST
  usb: cdns3: Improvement: removed 'goto not_otg'
  usb: cdns3: Improvement: removed overwriting some error code
  usb: cdns3: Impovement: simplify *switch_gadet and *switch_host

 drivers/usb/cdns3/core.c   |  39 +++------
 drivers/usb/cdns3/drd.c    | 165 ++++++++++++++++++++-----------------
 drivers/usb/cdns3/drd.h    |  13 ++-
 drivers/usb/cdns3/gadget.c |   4 +-
 drivers/usb/cdns3/host.c   |   4 +-
 5 files changed, 114 insertions(+), 111 deletions(-)

-- 
2.17.1

