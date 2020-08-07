Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D52DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D89112075D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="YgGjELde";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="dipOJooK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgHGLqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 07:46:31 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:12908 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727783AbgHGLq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 07:46:29 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 077BhO1T011150;
        Fri, 7 Aug 2020 04:46:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=DYsKn1aOnKpLqJ0DlGanpW9unfAJnnZiELnORBWZSD4=;
 b=YgGjELdecskDwS9rz+MC+KhrJVS7EHZfNX892MeNL7TQkrZrlnh8NQ217pFIm1zpF6A3
 1GQWoVH7ymRqMQNs4uLzwuZt7nRWeR3M3/TffC9pH345zXAXR6RNzM2K0HK0UjBy0Xw+
 nj8LPEI015r7NXWwXhCs5yKnhzuLB+T87ZSiV+tue+cdQ+ECoKJaJBkeZSCMripWCQB5
 ercELIIKQDhnlKup2hmxAZ/WSVlkFjxXFC9CYiJPNnpQTY5YrvAPtcIHL2sM/q52eHGg
 KtrX3roJ2+vUBy9Ye2hobv4QnfNyPoUJQsEYqGU2ecKzi5urWcdb1LGFsDbuKRECnnNX wA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0a-0014ca01.pphosted.com with ESMTP id 32nme0mc39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 04:46:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrNW4fA1+v39zh/udvVciwMve+NNBStH8lY6spDjl0SmwtQdUPI8bFuFq+b8qIwsyy5OHoyOfkAO+MYb/dukcZkr42npcYLDx87fnbDdITiWef01BeZyKOdBzHTqzYqu2eJwXc6KYi9SVQjD8PcH5xFXVgWcK6wjT8ngI3LEXXjkryQcssPtkoD+NiNPQxYx44L0MVMm3EsvCSx7OILLE7C6w40W0SUSZmJfPt7c+MT/It+DOnO4rjPF5DTA0uFIFpSzOe+Ysr7b4UHvfHimV/ZUyWd9P78WiCMvUgjasHRuDFXdYJwymqkjvFAQxcsOJmqeO/ZHfRBe2jrdJOblJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYsKn1aOnKpLqJ0DlGanpW9unfAJnnZiELnORBWZSD4=;
 b=PLA9okadL2N7U62MBdFbJf/EPwgxY/5yixbv+RwEAqjxlHVBd9ClwcVcogAOjSKNAowDGTSobUEvc7i2Fi/SfGynwVdGGWlpZwP5L+YGWhNY07xOtM0o3t+UHFA6K7h/xk5VmoOXAxBXV07m/iyEfSxvq78KhQIqueOeAGipsGE9WxwsqxEOGJyja8OCjjUFpkg9gszsFSWeamup4/LDcSXMNxIX4fqVr3WSSpJimepiYQQxPzCAEkRWJtnHGuGthKemH1X1xisSYswtXDp48pikMIM2kpfDEBQURvW23JO42Bq+d6ZORTPN3aZe8gITLu/r9AldEYMpH0r7l72V1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYsKn1aOnKpLqJ0DlGanpW9unfAJnnZiELnORBWZSD4=;
 b=dipOJooKPmAXqoe4RNP1IOw5u5VP9qSp60ngHzdYCdECbQ65D71pzCmfO3yMG7HQ8ZdGM81ciJPnXlnz+2gYk3VjB8cuqKFt/PPX60yQgFUPS+/Dxqrbs3nKB/kiusrNK0puaCqgAXSARyVPUXxCufxyGmzF6lMkndYRww4JvUk=
Received: from DM5PR04CA0025.namprd04.prod.outlook.com (2603:10b6:3:12b::11)
 by DM6PR07MB5001.namprd07.prod.outlook.com (2603:10b6:5:20::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Fri, 7 Aug
 2020 11:46:16 +0000
Received: from DM6NAM12FT050.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::a5) by DM5PR04CA0025.outlook.office365.com
 (2603:10b6:3:12b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19 via Frontend
 Transport; Fri, 7 Aug 2020 11:46:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT050.mail.protection.outlook.com (10.13.178.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Fri, 7 Aug 2020 11:46:16 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 077Bk9P8029785
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 7 Aug 2020 07:46:15 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 7 Aug 2020 13:46:09 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 7 Aug 2020 13:46:09 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 077Bk8Vw000840;
        Fri, 7 Aug 2020 13:46:08 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 077Bk8F4000839;
        Fri, 7 Aug 2020 13:46:08 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v1 04/13] dt-bindings: phy: Add PHY_TYPE_QSGMII definition
Date:   Fri, 7 Aug 2020 13:45:58 +0200
Message-ID: <1596800767-784-5-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1596800767-784-1-git-send-email-sjakhade@cadence.com>
References: <1596800767-784-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 995c994b-09b2-4863-ef34-08d83ac77e43
X-MS-TrafficTypeDiagnostic: DM6PR07MB5001:
X-Microsoft-Antispam-PRVS: <DM6PR07MB5001D4A69A9F77805AA33EA1C5490@DM6PR07MB5001.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vazfED5KQvW3DRdwJPyGUIb+5PvE+zm3p7dtUat3BHShMnZQz+44FuwbGcSbhp0yrUkzuI3HwevNA0aPk9pRvq52Ybo10Zk9o24cX9Cb+GOEht37C++jMmovyy9gC3nQSq0bnrM6aeFdrh8LePNX40micxKyGjWs9LtlkGXS/pk3ppwHUfX3mu3Fp7YjUV01tj0BQRPQaSnIdTIp4mZzJ/vB0TFgZ1iDzLBnr9uNMTVAhxJl6poYHnZllXqj/Ola6HkoDGlIFXFiBmpqEhol6BJ+WifOEVK1Hhkli+dtCegDe2jg6iS1j4JAe8ekyoIc6FoeutCGe5COHeJTkohi5tmi++RndVwryzqZ7sHC/nrPPRfj7CWW+oCPve6R2JSeUS4O5ZHQCZKmRnDiuYVvlO9IDH+zGxxAhcZMMGxq7vw=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(36092001)(46966005)(82740400003)(2906002)(8936002)(47076004)(82310400002)(70206006)(70586007)(8676002)(5660300002)(356005)(81166007)(6666004)(2616005)(42186006)(316002)(36906005)(110136005)(54906003)(4326008)(336012)(86362001)(26005)(186003)(36756003)(426003)(4744005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 11:46:16.3539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 995c994b-09b2-4863-ef34-08d83ac77e43
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT050.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5001
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_08:2020-08-06,2020-08-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 phishscore=0 mlxlogscore=841 mlxscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008070085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add definition for QSGMII phy type.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
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

