Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FC1C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 497432177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="K86+a7us";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="zTYapV0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgH0QRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:17:13 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:25070 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726197AbgH0QRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:17:10 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RGC6Yg005478;
        Thu, 27 Aug 2020 09:17:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=1Kgj7Pzlp8BbbX9rCNXXFcHIU3lHVjyRKEYMIK0MvXQ=;
 b=K86+a7us49m8xUoAWXVXKi00Dl0xc84PLnnZFfbo2JCiUBUGtET3TSFn/JWbJtXVzEql
 zk24ndPmiR4sb8Z39uhdChlHP05uxNYzjpVEWqWrf3ArGeeRZW09kVQgU9Qq080anwa/
 2w3PzUnvDWC/66DJuIQVNaglDUMbGQImKDgVjarjc4K2auFmgMt4bLi3PUr/t7xH4kar
 AkIEMG8qYrVzLbpCCKUzL5ArICRP20uTCriNdbw8/4YCvuLgFb4b6TWbz3xcsCd8Cb67
 vvBvkAIeuc8IPAhnpbvkRIthOnZHMEo85r6Wh0ymfb/fnYpdYWESI+z1lBQ3uVoums+C Ig== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0a-0014ca01.pphosted.com with ESMTP id 332yww4tqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 09:17:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJ28PfCIlSjrr/mbu54wkOnleJ5sQKxKngkyqxjdtaj+CC+nmgeWbECH6gUkYmJMz2Wr4MU5Y18PoxNZ83ppQeBfiUqw0eWjD7IAC1oRmwloOo9SmZuSsazLVVFKEwpr7CdTwQQ+bL8YXlFcL2h8B4IhGO5ybpoD0NdJ/mDYCkgmh1zaCnPavyTSihEKIitiFRK5WvLxfnn2pTA7Mpi7u+h7xB8PQfAJqDFwX7CepK7GY9UaIOPKNPW520f/663hU5o49jtkdsFFbQLdAfH1xAVaL2hxb6vkHBVN3+zYXNr17ViKQLzD3+KCvH6aGyk/lZ8stHoGvulTRbRUN0j9hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Kgj7Pzlp8BbbX9rCNXXFcHIU3lHVjyRKEYMIK0MvXQ=;
 b=knsfSYCf0Y8bf1RDyuHzYcdmMPqqRP6vqhFpQCWqRiRnbOdfg6XK88TDJ9vvCW0T+NQGQgqoF2qG8z9t2Zlh/7Z2TvzXEjFnS6uHX9wFm+2i2PS89d0h/wmSOcYRI3EH98OwZwfy9g6p0+T8ITrahsMbrvbqd2RPMau5XA6tcyoF5rVcz1qqpKDcEtxBo1On8EjXVoNe8bHlT9GufM9Zd2XN1jBb/BacBEQb1J8q61Ir2UhoKo6APvK/JXg/3TJsAT0+/YlHwRgkQt7y76NExl5lZzrMEtG/VSw9sDJIz2OqOARXSMPI+recVfOw3r9KiiaDFMGKJNmI8wvkMxNJ8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Kgj7Pzlp8BbbX9rCNXXFcHIU3lHVjyRKEYMIK0MvXQ=;
 b=zTYapV0SGJ3/G1abTVH2/G5YpDQPdIOs+GQWBuQjQshg0vas0biCLgLCgzQnzx7JjFbNarF+iBzDNTskI85OH4MDfTEBSNygQlaNPLRFm7jDBDmquSlBueTwIFZvhklr+IJDqzbA/LxFydQjonEDt9Xtc895iElACp99mMc89Qg=
Received: from DM5PR13CA0057.namprd13.prod.outlook.com (2603:10b6:3:117::19)
 by DM5PR07MB3115.namprd07.prod.outlook.com (2603:10b6:3:eb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 27 Aug
 2020 16:17:02 +0000
Received: from DM6NAM12FT016.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::1d) by DM5PR13CA0057.outlook.office365.com
 (2603:10b6:3:117::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend
 Transport; Thu, 27 Aug 2020 16:17:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT016.mail.protection.outlook.com (10.13.178.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 16:17:01 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 07RGGquJ016160
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 27 Aug 2020 12:16:58 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 27 Aug 2020 18:16:52 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 27 Aug 2020 18:16:52 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 07RGGq20031833;
        Thu, 27 Aug 2020 18:16:52 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 07RGGqfr031832;
        Thu, 27 Aug 2020 18:16:52 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v2 04/13] dt-bindings: phy: Add PHY_TYPE_QSGMII definition
Date:   Thu, 27 Aug 2020 18:16:42 +0200
Message-ID: <1598545011-31772-5-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1598545011-31772-1-git-send-email-sjakhade@cadence.com>
References: <1598545011-31772-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e95b13c-be90-427d-8acd-08d84aa4a148
X-MS-TrafficTypeDiagnostic: DM5PR07MB3115:
X-Microsoft-Antispam-PRVS: <DM5PR07MB311539383E5550813ED35B79C5550@DM5PR07MB3115.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W9jeEC4suwWXJ6MAkM0MM3BtAxOPBWUAhHRM/uqVjvANrQ7Ek8mxRLtM0HbXEj05iH/9XHTVosCh0f1867IksbEYPXFsq3yqXznVuzrzlmtZ8ye7cjQ6i5/KSPJq2t+dM4sBNfmF4tvBUOwBfXPG2OmKKPFW1dDeICj6Csb0a9ZD4+dwnfSnyLu4e9vgCayCVXQBjHwKavbVC6JrRuc1C9EKg3SbWMsX+kHgZn42LE0Y479OnwhDmnVkzWdPqoak0+i41e52k9C96G/KXSBGWzErikEEjDIshhAndqfvcu7f5SvcDo27zRShsPifaQ8qni5JSjvJJJmOXQaIYTAVdjmFUHvXBAiaqTlMxnibig5A9huaHbjAhojoN2q5NUE0uiPzJfXClvR1FzZLMB8LGO+1OpThGrpgYPzjfqCXCHs=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(36092001)(46966005)(356005)(316002)(110136005)(81166007)(54906003)(82310400002)(36756003)(42186006)(186003)(86362001)(426003)(26005)(336012)(2616005)(6666004)(82740400003)(70586007)(70206006)(47076004)(4744005)(2906002)(8936002)(5660300002)(8676002)(4326008)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 16:17:01.3233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e95b13c-be90-427d-8acd-08d84aa4a148
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT016.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3115
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_08:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 bulkscore=0 mlxlogscore=882 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add definition for QSGMII phy type.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/phy/phy.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/phy/phy.h b/include/dt-bindings/phy/phy.h
index 36e8c241cf48..887a31b250a8 100644
--- a/include/dt-bindings/phy/phy.h
+++ b/include/dt-bindings/phy/phy.h
@@ -19,5 +19,6 @@
 #define PHY_TYPE_DP		6
 #define PHY_TYPE_XPCS		7
 #define PHY_TYPE_SGMII		8
+#define PHY_TYPE_QSGMII		9
 
 #endif /* _DT_BINDINGS_PHY */
-- 
2.26.1

