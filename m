Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092DFC433F2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2DFF20758
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="m2vHGB+L";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Jb+vg6rx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgGMKGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 06:06:39 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:62178 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729671AbgGMKGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 06:06:36 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06DA359p026892;
        Mon, 13 Jul 2020 03:06:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=CPf1zSv7IVfODNLFsJAw7lDiExMuKFA9g1MD17728bg=;
 b=m2vHGB+L6fQrhJuRV4wkcVg3DRTaJthqFO54ze/TGNjqb9aOj9KfmU6tz/3g5JhXgBSe
 ZT3eV4MNqX+n4TNG0X82k4It/0e5fZLt2CXFQxPrajZ40HPChy5N61skbv83u027/aHz
 jfPIcKa+EonexkvQJyr8y0KlDWsf9GF8VoXctJ9jhqnnHDB/yNVg5pW2bWYaXi3D4egE
 wsdis7LBp3W6mrowhHsdGVnHS1X2VxAiNNXc3/oacA+ze7l9jwgZBGG5IfkOqivHcL4m
 sknnTiWCMhCpf4de2nbUf+AK8CxJgwlIPuECIq2Mz3Mg04NEmUj4LKqwz42ArykBXnYK mA== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2052.outbound.protection.outlook.com [104.47.36.52])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3279yud6c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 03:06:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fo/fzdlcOhG/687PAGlJrAYrlvt3D4Yco5AzEs72uLhg0Fx4aQSnSpNgqu46G0MM6QuwPorG7/vxANVyWb3AhN+PtRqQYLGoJtAbT9kyk6GB8QZ9ITf+yv4r5SAVgZQjZneJZICCT//zj+OMaEM7inDMKcFrhY8kXVjWn6hjw2Pr/KxUsw1xSvQ6mTlWsjLloaat9m9TDsseae5h0z2HsieY6ICGB30NMakROzswK2oqu8yIlv2eqyEp/AXXPRJf2u3AYIO9f46sPlt2YpUvPp9XWo5lGDulchK0wslJIUB/vCjtZNEoTzJl5EPRctq9+6iq4tj/FQH+MLTkX7dnsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPf1zSv7IVfODNLFsJAw7lDiExMuKFA9g1MD17728bg=;
 b=k9CzyqxQW0t6bTpAba83aOEAsJ0F7XWFYjoFUi2J4tszJmphnDF+cZIcQLgPe4VcIyLOKdVcHwjL0jgKWRD83g//EAZABsl9GaQqhpF3zSAhlV9bUmQkuC4cAOhONPvVLrGoCkII2aTrMmlTD8OsxU7ivuo67Eqegnb1yPwNe02V+HbR++EFxtnp1Vhb8yyR1ycX+7S39VKdolV0VxeyqbInE0y2bFqPSe0eJKE/wV7bsTyz0x6/EUi66h04e5SGCVIigbuNWIvOhb5jFClgRYa7X0SuEqQU4hMPfHzCo2O8gC/U4ibzgb8HsAfB9rOWm+DVQHHC6Y+HL/ApwDwEzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPf1zSv7IVfODNLFsJAw7lDiExMuKFA9g1MD17728bg=;
 b=Jb+vg6rxHMh4LT50jvn2V0oOqwsVJqxGzH3+7JVk4xVWRdq0N5HdLC+DozU0fqEgRixr4ePWqg7qu22eGVfoVtoj017KR4gtwN7bFUNlIijq2fE6XI/SNfmSUami7tvMFY1sAejgNiSvVzMSNcXIRTNeJlRpCQLZjr6jjCOT4ok=
Received: from DM5PR05CA0006.namprd05.prod.outlook.com (2603:10b6:3:d4::16) by
 SN4PR0701MB3712.namprd07.prod.outlook.com (2603:10b6:803:4a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Mon, 13 Jul
 2020 10:06:08 +0000
Received: from DM6NAM12FT046.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::2e) by DM5PR05CA0006.outlook.office365.com
 (2603:10b6:3:d4::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.10 via Frontend
 Transport; Mon, 13 Jul 2020 10:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT046.mail.protection.outlook.com (10.13.178.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Mon, 13 Jul 2020 10:06:08 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 06DA63Yo013926
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 13 Jul 2020 06:06:05 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 13 Jul 2020 12:06:03 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 13 Jul 2020 12:06:03 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 06DA637x028623;
        Mon, 13 Jul 2020 12:06:03 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 06DA62MW028618;
        Mon, 13 Jul 2020 12:06:02 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rogerq@ti.com>, <peter.chen@nxp.com>
CC:     <dan.carpenter@oracle.com>, <heikki.krogerus@linux.intel.com>,
        <colin.king@canonical.com>, <jpawar@cadence.com>,
        <ben.dooks@codethink.co.uk>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2 0/9] usb: cdns3: Improvements for cdns3 DRD code
Date:   Mon, 13 Jul 2020 12:05:45 +0200
Message-ID: <20200713100554.28530-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(36092001)(46966005)(70586007)(86362001)(6666004)(47076004)(8936002)(7416002)(2616005)(1076003)(426003)(42186006)(82310400002)(54906003)(83380400001)(356005)(4326008)(110136005)(316002)(2906002)(336012)(5660300002)(107886003)(36906005)(8676002)(81166007)(70206006)(26005)(36756003)(82740400003)(186003)(478600001);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f755aabd-ac49-4004-7b57-08d827145cd7
X-MS-TrafficTypeDiagnostic: SN4PR0701MB3712:
X-Microsoft-Antispam-PRVS: <SN4PR0701MB3712026B9C371BD1C6462694DD600@SN4PR0701MB3712.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YXEZH2NpVZMZb2OX3zMOkaCN0jNnKDh4LHuRjeZ9bRW34J0g4rl8s1/vYusTR+QQWqSq9gVrR9XA40Yx8iCFWhzMBrK1eR/bBJ23g2MxVR8m6zU7YLp7dRBxDz61fQi+WStyfpEg4io415LAlgI3thezMdp6bAvJuxH6t+0/adTeV4hhGXQ4e05Jl1xyShlD96agZN0mpSPI4GaybuuXiv4GfYOjl4K1xrOPZ12UCqcyWqviR+mL6gUD0/ni81BQ8XcSkzRExPD5QSGLqwrlfvYi09ejxvjDd8o2BfHfk6h5dJbn7Pb5n4fh8Nbm2z/2xM1M9ABg0wql8SXqO6q+EN+7ldmxXCFK+ONZ+YUVUWoFoC5uSpFL8X9RZQLFeocWtAezxDtMtMN9aaiLHipqT8nzdFmymo4JWfrpFXKnEZs=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 10:06:08.2640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f755aabd-ac49-4004-7b57-08d827145cd7
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT046.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0701MB3712
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_07:2020-07-13,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 mlxlogscore=867
 mlxscore=0 phishscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007130075
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
some improvements.

Changes for v2:
 - Change patch titles as sugested by Peter Chen.
 - Remove typos in patch 5 and patch 7.
 - Add reviewed-by Peter Chen tag [Patch 1, patch 8 and Patch 9].

Pawel Laszczak (9):
  usb: cdns3: core: removed cdns3_get_current_role_driver function
  usb: cdns3: drd: removed not needed variables initialization
  usb: cnds3: drd: deleted !=
  usb: cdns3: drd: return IRQ_NONE explicitly.
  usb: cdns3: drd: changed return type from int to bool
  usb: cdns3: Added CDNS3_ID_PERIPHERAL and CDNS3_ID_HOST
  usb: cdns3: core: removed 'goto not_otg'
  usb: cdns3: core: removed overwriting some error code
  usb: cdns3: drd: simplify *switch_gadet and *switch_host

 drivers/usb/cdns3/core.c   |  39 +++------
 drivers/usb/cdns3/drd.c    | 165 ++++++++++++++++++++-----------------
 drivers/usb/cdns3/drd.h    |  13 ++-
 drivers/usb/cdns3/gadget.c |   4 +-
 drivers/usb/cdns3/host.c   |   4 +-
 5 files changed, 114 insertions(+), 111 deletions(-)

-- 
2.17.1

