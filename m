Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BD1C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB10A20739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="XOM19Loz";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="jBlcU7I1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgCTNtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:49:53 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:25680 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726843AbgCTNtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:49:53 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02KDn8Ob020241;
        Fri, 20 Mar 2020 06:49:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=YCa+Uwq0E3cRLvhLX2IrgODuAIK3E3o0EX8i3r7nTec=;
 b=XOM19LozkizZWzjad1WQrdLWGkl+ix/aLr5QFSS4Y55yEp4tCM5JdCsIa8GqxJt+XDql
 5ErNi0ZfXELrnxwKGu4X2AgZ/Ygum8dFp4wMxFGC8wuMIFS2eVYfayi4ywICRiKWZSBn
 qpt52zIzwPzoNW1r2ZZJMhhZR/EkObO8MoXLJgu1/0wd7bCchCgXp4Q6NPuwODRhUKIT
 qh8YVKCT0hF3+dvPZeSvUmBBBkuVt1H7/FNumPdVENONUCEJkss0y1jFvgoPXMGZgaa8
 bu2bp+HQ1RLdgE2rxAGu4wz348/MQJLyftoyRN036U4JmH4B0PIgtOoym5cnyOe2VBnG VQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2yu71enm83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Mar 2020 06:49:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiKs2vvkM0FFLuf4otp7EeR7B0lbeEheB3P1a+Ut2y6dyNPbhGsfU1RYauqFbvblNpcyEp34D29pu2gk74Xyi/YeHzBS1Tjz97i3bIy+95JHKuFM5DXigca+LI9zMm7DdnPG1d42zfM9BmIuSe6iwgrP5g0d8odqbFOQY0YSmQtmeKAm4BnDIaZOPTQSJ31T3ZRFeC+zhbj+dQq0eBdDTg9a+rOMvEEsA+rAUlePytiCaItNBxfEBm5jMFZfEfhRJmkH9X/BOUc4khYfztabs50f8q8ZMVZ/hLOEdqDzmxSdCzMeOO4az7V+CKZlItda902aABjnVbDovrJLnsJoQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCa+Uwq0E3cRLvhLX2IrgODuAIK3E3o0EX8i3r7nTec=;
 b=d6LNzFKPrWeklWRx77Gh97IfDqguMRXhsaU1kpxcqxVacTeaAiITmLPAlzip+/fE1phEfQp8HBdcB7kX9VlemREllJUx3wYy4ASmrUBfsck+lC8dpr81cQUOCn6EokTbU2OdM2JIRaC8ThQo5q55XAFh0uFCZKqPXMGhBqlwP6uxWrTbARYarCiznCpzhX9wLczKUwhsxDv3m7SoZS4pFKSFVH5CANUdwFMsJK60dVqIPsowvgnlPxg4ZtuLRQ0VjcGRPK2B7q6t1tTYNc3RKSRRo/eLm9+SzNo08zVgrWt4Gx05AsRmHHN7f2nXv9A9ggxB//Am6AFbjBzxtJ5acw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCa+Uwq0E3cRLvhLX2IrgODuAIK3E3o0EX8i3r7nTec=;
 b=jBlcU7I1HFau0TyJTAR9UYp258qyoU+opRdEkNu7lDE3FYBZrssvecLOTJeGcV2RJ4Fjng5qOBYoqTHhbkv9JYtxAp2eWmzmgrrfau7dAZ8RoY86042k41YlIt0egelfszY2YN87k3O+C45KcXjE/hSFAofvzYeQvmSx+uOPMZ4=
Received: from MN2PR02CA0028.namprd02.prod.outlook.com (2603:10b6:208:fc::41)
 by MN2PR07MB5903.namprd07.prod.outlook.com (2603:10b6:208:105::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21; Fri, 20 Mar
 2020 13:49:39 +0000
Received: from BN8NAM12FT063.eop-nam12.prod.protection.outlook.com
 (2603:10b6:208:fc:cafe::be) by MN2PR02CA0028.outlook.office365.com
 (2603:10b6:208:fc::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22 via Frontend
 Transport; Fri, 20 Mar 2020 13:49:39 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT063.mail.protection.outlook.com (10.13.182.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.6 via Frontend Transport; Fri, 20 Mar 2020 13:49:39 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 02KDnX1B021391
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 20 Mar 2020 09:49:35 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 20 Mar 2020 14:49:33 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 20 Mar 2020 14:49:33 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 02KDnXwS027670;
        Fri, 20 Mar 2020 14:49:33 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 02KDnV4M027669;
        Fri, 20 Mar 2020 14:49:31 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v1] dt-bindings: phy: cadence-torrent: Fix YAML check error
Date:   Fri, 20 Mar 2020 14:49:31 +0100
Message-ID: <1584712171-27632-1-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.23;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(39860400002)(136003)(376002)(36092001)(199004)(46966005)(110136005)(47076004)(186003)(70586007)(2616005)(426003)(316002)(36756003)(107886003)(26005)(478600001)(4326008)(54906003)(5660300002)(81166006)(81156014)(8676002)(336012)(966005)(26826003)(86362001)(8936002)(4744005)(42186006)(356004)(2906002)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR07MB5903;H:rmmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea480fa9-639a-4c7e-a635-08d7ccd588ce
X-MS-TrafficTypeDiagnostic: MN2PR07MB5903:
X-Microsoft-Antispam-PRVS: <MN2PR07MB59033314E9637669E0927975D2F50@MN2PR07MB5903.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 03484C0ABF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ou8r80wfd/1/XfAWDPO9ADRnujjZNZd8km5t2dybppXp111OTXajFJZGM0E8Ixyn+NXrFqPmBWAznjwJAZKy60MoxiMtXbJ5LbPXekJsg097MeaL2/QuNi9kb9KM7hzjvsTUR0zICf0m2/NBah6zVCN55D9ph/VXoiHme66S194y84OAmplpzYkkzO4+KtTjEl7K1XPRu7ZTT0D3YT9RBoFfetmHp5v3GrGvjMMycLwu+oE9I8tfu7zNpagCJW7SJuf02dOaZfmNOCgYv4eeLKUlMmSksJJt6qOggryL36GqEeElFyxV1IMrUpU/iRRNB6j6MgvzTkz268BcY8gZ6hfEsO/q983xP+Q1vi9xXMHZvaIj68sEi54D1E8qbwBbOLC/GWFn6JN0fPfgnX+ArFFYmzpkXxOpwS1LBb2Ctv8daqoE5XMRk1dcKxOt6dQ2khkqSM1B5COSEKn3FEV/A1NLYuDUGIOuj3ho6u6fdLCrWuEMzVIEOSdcrsbVSvBxZVG6z0YJt69/AQ99B4kFNf1S49wU/nE5l27+fdGPxekM5DzZUmnt9xgyRNb+eWCROyy+7YPU7W/66Vv5+irFGObqRTquYN/IBN1sgfkE6SJZopJd9GvOg3ztGEkmaLk2
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 13:49:39.1209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea480fa9-639a-4c7e-a635-08d7ccd588ce
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB5903
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-20_04:2020-03-20,2020-03-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=870
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 phishscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003200058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix YAML check error by renaming node name from "phy" to
"torrent-phy" as this node is not a phy_provider.

Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
---

This fix patch is in reference to Rob's comment given below:

https://lkml.org/lkml/2020/3/11/1091

 Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index 9f94be1..c779a3c 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -120,7 +120,7 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/phy/phy.h>
-    torrent_phy: phy@f0fb500000 {
+    torrent_phy: torrent-phy@f0fb500000 {
           compatible = "cdns,torrent-phy";
           reg = <0xf0 0xfb500000 0x0 0x00100000>,
                 <0xf0 0xfb030a00 0x0 0x00000040>;
-- 
2.7.4

