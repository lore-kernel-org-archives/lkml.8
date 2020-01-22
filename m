Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229BFC33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3093205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="J989AgKp";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="qolyDa0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgAVKrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:47:08 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:5126 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729546AbgAVKpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:45:40 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00MAgqZX009274;
        Wed, 22 Jan 2020 02:45:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=aDZTj+AW7EWerKl6gX+Oo7n8H0sTItxLWX7ygMcX7zs=;
 b=J989AgKp9xR1nqcpPS9O/m6oFqveVrZKCvxxOJI/ks4bx05h7tiWSMuZ2MzIqJgyvFEL
 xSvAYUJgSU5S1DF0YlKGR/qXn8g2B5DoF2BaRMIXPu/EIZSEh1CYlkxs0Thg23AgqaV/
 S3dmu2jSzrwp/YfAXDIPdq4fScI3JEvvh4xNRkM4ih4d9Gnz45H9DewwE5oEiD2ew70E
 cD5YLnyi0DChZMg5Snrkj7GBkji3N0MJ5syfMrUDaq/vxOA4SGA+ZJ10LRYM5eOxvXBD
 D1I7TWUtCCExSh8zt5Qomc/KbXfgFmuNchdugcgAUIyNhbu+vYTZygZfVBKCmoMnMHDm 9g== 
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2051.outbound.protection.outlook.com [104.47.45.51])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2xkyf5mgyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jan 2020 02:45:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EB7AM29ZYB6yxPswSSbpEqpg/UfZJ+SMFLWzPbqPOQOd/g3IVnPOhJ077O1OeWxY6HOESm+y3Onzg/1Q0KDly11Xdhqe4pVGO9sn+oNMHP2JGeKKJT0MBiN56+l+kQIqIu9tlwwJq/bHA1NR4pRUKSs98SiU8aK6CgCKJ/JAmdwaIcR28Ch+vfjhxpBLNPUNw0p8nqaaryWYG6U96WcmvCoe361bfw9tld3BesBxFgds3QtlXPke3YkdUVyhIMz/aDjKe0QqwgmJGY0n3yaEUEzSI0P/55PH8vzybiIeKRSw9FKSKF7X6G5I6fOL+NnmKsJ5n8+6dwb6Ln5rcQ72YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDZTj+AW7EWerKl6gX+Oo7n8H0sTItxLWX7ygMcX7zs=;
 b=JRrjLp66sRjTLScHMWYFxeEMPJNY4ERcH1gI0c//cYHcc9qOQjbUzbzF1PYOWQMVE2nqY6yXg736Nee4BAVOXUWiXNGK4zgEtCi5Fa3JjH485rov4OVVT00PYfJwWM8z+hMROkfrY8vFsYlsMRg/SJa2jHOSXf3THjg77hbswxHwfjOv06ekhaXNl6BH+hAt1qA8HOpuW9iI5Lwo8zn8wuFq4Wj0IUtM6Y3nOf8lcc+C1G/FrYrQ8b0ADcHJPTUTpOBKoNh10Qky7Lv4Jq+O8gTPvJ6fftBf49JocjsmQSZst7p2HhDVYj7Bxqpp+z/w3OFRexkePP8cmCvWyDXO4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.28) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDZTj+AW7EWerKl6gX+Oo7n8H0sTItxLWX7ygMcX7zs=;
 b=qolyDa0xvMFyMfhHjim1Py5VhtgNmI0D71cQ5osZ88RywJGVjrvRQArJfOPJll9k03e9czM5sD9EPCNZI+LApdH+Ai87FxJY1mnL2Ilo09rHgcqveq0Y4vf/e1OIp4GYNtr1gDuYEX+Q15bsNTb+onmJU6se/k+fT4NLSoupQRg=
Received: from BYAPR07CA0030.namprd07.prod.outlook.com (2603:10b6:a02:bc::43)
 by MWHPR0701MB3772.namprd07.prod.outlook.com (2603:10b6:301:7b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.21; Wed, 22 Jan
 2020 10:45:30 +0000
Received: from BN8NAM12FT009.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5b::207) by BYAPR07CA0030.outlook.office365.com
 (2603:10b6:a02:bc::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Wed, 22 Jan 2020 10:45:30 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.28; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BN8NAM12FT009.mail.protection.outlook.com (10.13.182.242) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.6 via Frontend Transport; Wed, 22 Jan 2020 10:45:29 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 00MAjKBK001726
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 22 Jan 2020 02:45:28 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 22 Jan 2020 11:45:23 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 22 Jan 2020 11:45:23 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 00MAjNUA007327;
        Wed, 22 Jan 2020 11:45:23 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 00MAjNu8007326;
        Wed, 22 Jan 2020 11:45:23 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v3 11/14] dt-bindings: phy: phy-cadence-torrent: Add platform dependent compatible string
Date:   Wed, 22 Jan 2020 11:45:15 +0100
Message-ID: <1579689918-7181-12-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1579689918-7181-1-git-send-email-yamonkar@cadence.com>
References: <1579689918-7181-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(396003)(36092001)(199004)(189003)(4744005)(86362001)(5660300002)(36756003)(2906002)(42186006)(316002)(186003)(54906003)(110136005)(26005)(336012)(426003)(2616005)(8936002)(7636002)(246002)(356004)(6666004)(478600001)(8676002)(107886003)(4326008)(26826003)(70586007)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0701MB3772;H:sjmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:corp.Cadence.COM;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75737e47-dfd8-4671-883a-08d79f2832f7
X-MS-TrafficTypeDiagnostic: MWHPR0701MB3772:
X-Microsoft-Antispam-PRVS: <MWHPR0701MB37724FEEF8DA1AF459E6BC2FD20C0@MWHPR0701MB3772.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 029097202E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b+44m9GxOpcNdlQetLaAvFAgaGR2i9nu99kUgS0mt/dCdJf1FFQlPXh7YgUHq6xY7hjHOHOhuBEUN7CK9H5GC6fNRJLa7/VaudmXU5eGg8LYEkCTAXppgnv6yZNnlDFsC9fx0MOfZ5SKbWLTM7a/yGOprNarftFElQBhM2VUevfgiiIQ2Udg41Hcg2qiAdSftTLFxtuDTrqzaMpSf9O6K0Ujgyen4yN8fo1apGpzNir/NxmHna4S1LOEjm0Y03zk+QjSt/R312/1IlKVB7piKwe9o2p3KCB9CQ0eQG43zyDWCK7dCoJUathmkItx8P07sNXR+gQEwf9lf1v03OlwJkhc4QoT39kL+9z2Myx4P7hvHLv1mTBJ3PJt1EZF9oE5c+YMtXerIWY8/rHV24p9J7MX9UOCyq5Apb3Gu347SfMNaO3c56jcghvo8c4TlpitUwhjdsuKUTuhgG9GrqYvkN2O8yyCBmfUCrHUmaeidJCjlxSyN7TYCD4c95cnfSRK
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 10:45:29.7416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75737e47-dfd8-4671-883a-08d79f2832f7
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0701MB3772
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 spamscore=0 impostorscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001220098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new compatible string used for TI SoCs using Torrent PHY.

Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index eb633d7..dbb8aa5 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -15,7 +15,9 @@ maintainers:
 
 properties:
   compatible:
-    const: cdns,torrent-phy
+    enum:
+      - cdns,torrent-phy
+      - ti,j721e-serdes-10g
 
   clocks:
     maxItems: 1
-- 
2.4.5

