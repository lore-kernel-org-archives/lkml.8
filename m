Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068EFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C436520768
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="h9hf8FsY";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Hv62P+YY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgFZE6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 00:58:23 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:14256 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726196AbgFZE6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 00:58:22 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05Q4nAaa017331;
        Thu, 25 Jun 2020 21:55:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=73PlbA8OKmuTjud0nYldFleXBXwBiYfEJgHydsmCHjk=;
 b=h9hf8FsYyepyx/sRm7e90Gw2L1QQS4twpr6uYWQAjQgwt1UP07pUbR9+ip8GLQ9lyael
 lcL1FeWL42Nav9vcv+o1OZ46LVt7SLhBl6Rm6mFyUEAmrvGktnAcIwE1669UPhCfee18
 hrBs/NUWWSbyDqCsBKDZdNi65iaSFomXtdnEX6/krHaqHFOsq9muYiXPFkZvzTHYdpQw
 /xli1F+JZ8SxpAJk4rztHXyq/UCykBlknehPz2dCzDTB5hzKc4E8wtLFNaHQt16x7BGP
 GbOVhriu1Y5Ky5SZhEAfRKHEgZW83h15eDSwYwp7huZzk+GMgEqk2IYXZrDH4o7Q8lXA iA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by mx0b-0014ca01.pphosted.com with ESMTP id 31uuqbhk0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 21:55:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4nwtcn+eQx3IrhZI54ZfpMonnTzPkYBSoJtXrdgkQFEX3zh1DizmEyNrTXZFIYcsuqCjotn6f6gWM6dHZlYOSjTcp+aAyNSSQ2jsYqDjQM2tZA9QqVpje+qnFdfu62RD6BlYo1A4ZfJRwmfG3e9hgkTdVf52K8QiMFmePEWKZFXb3VrnkGKf/c3JeJhmHTUcKlZYFTyhGPwbS4YiYMWHJL7zmyhzP76wEA8nzlx+nWyyQPm3EMyKgGHZ9AWtYVSo71/LylxaWEmWNVEe5ypA9yw4ijhBqTO0l3NniFg9RJGs3tmmAipTwa8C/znpjREC7Cr9X3OXOdpFV6gWl1lgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73PlbA8OKmuTjud0nYldFleXBXwBiYfEJgHydsmCHjk=;
 b=ktPYenz9h1bXC9efRte9dBSA6GZlLf2kn3BvMrwOHNMPRHGaWppG1rPZPU1wB3jCtmDdwmt7STrRRsyG7lH0yyUjPOuLWt2e2L9jCN4Fop2+VLZIRbvCg7WSkKR273qq/olGzoIunHmlaMbm2blRS6NJ4eK87NVoipdXP1L5Ognmx/ilsmdlENhTexM49VILSKNnU4vxPwLN7BZ7ZZwWqtmkouzyIDtzg/XsIGwgrTaUn0Tok5ThGAsEyqO0SXgmHrHE+xrR+PoqVRY9PM9rt4vTaPf9pI5tNrTYNHO+wY3864dqISxdbNfoUxZEQYEYJvWd14f1EL8zJDApJX9XRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73PlbA8OKmuTjud0nYldFleXBXwBiYfEJgHydsmCHjk=;
 b=Hv62P+YYW9BgKEgN/Re8bNizeZeQ9+gZUwshMDZEY7dh1YuHBRmjiMExskDQSk+To1pih+t/uHPAlOW3ygBitiVIzMY+bT90qupCSlbJ+xugFfUG0dLqHOFFCMPDsQAiOB7RIxuP0uDBNlXEpXzF11AQa8vEpp5K/Scon94kZno=
Received: from DM5PR07CA0135.namprd07.prod.outlook.com (2603:10b6:3:13e::25)
 by BN7PR07MB4724.namprd07.prod.outlook.com (2603:10b6:406:f0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Fri, 26 Jun
 2020 04:55:54 +0000
Received: from DM6NAM12FT064.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::10) by DM5PR07CA0135.outlook.office365.com
 (2603:10b6:3:13e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Fri, 26 Jun 2020 04:55:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT064.mail.protection.outlook.com (10.13.178.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.13 via Frontend Transport; Fri, 26 Jun 2020 04:55:53 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 05Q4tnkA202776
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Thu, 25 Jun 2020 21:55:52 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 26 Jun 2020 06:55:49 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 26 Jun 2020 06:55:49 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 05Q4tnj3010926;
        Fri, 26 Jun 2020 06:55:49 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 05Q4tnBp010925;
        Fri, 26 Jun 2020 06:55:49 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <balbi@kernel.org>, <devicetree@vger.kernel.org>
CC:     <dan.carpenter@oracle.com>, <ben.dooks@codethink.co.uk>,
        <colin.king@canonical.com>, <rogerq@ti.com>, <peter.chen@nxp.com>,
        <weiyongjun1@huawei.com>, <jpawar@cadence.com>,
        <kurahul@cadene.com>, <sparmar@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH RFC 1/5] dt-bindings: add binding for CDNSP-DRD controller
Date:   Fri, 26 Jun 2020 06:54:46 +0200
Message-ID: <20200626045450.10205-2-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200626045450.10205-1-pawell@cadence.com>
References: <20200626045450.10205-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:unused.mynethost.com;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(36092001)(46966005)(4326008)(47076004)(7416002)(2906002)(82740400003)(107886003)(478600001)(82310400002)(6666004)(81166007)(26005)(70206006)(356005)(86362001)(186003)(5660300002)(1076003)(70586007)(316002)(110136005)(8936002)(2616005)(8676002)(42186006)(36756003)(426003)(54906003)(336012)(36906005);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eaa7e0ae-8522-4312-f91d-08d8198d348a
X-MS-TrafficTypeDiagnostic: BN7PR07MB4724:
X-Microsoft-Antispam-PRVS: <BN7PR07MB4724AE07BEC95B7A516B0A4CDD930@BN7PR07MB4724.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pZeP+stwoso0qppnxfm7OnkQIHMEYGnP82IWyfZv3MRvu3UaP5kyB+BQERQQ1ySZgvHeefuMiHpRQtg1I9KoiDXlj6fHYt727NzZvclgs9LUQW66mVZrT7j3ib7SJtgzSK6sebk8wLSIKzf+cTMNm8j//hVE28mGxM54ZLIpwDeYaNP4S1+WevhObHKWMYOZsh9Npw8dnV2g4LEc7Wz1RqHBbn3VKZooJq28fsPZU3GXJ9DV74qKPRSjD27cjhx8iU9NKcmtX5b0vspVkPoZ2IRQ+knbgs37vrV1nWrYQ1DhM9va2vxij3sbCQNULg1p2axh0lsr0+ClQbefonxmOHEOp63zq+xP9S5Y4YjdS21KFUNy1z8awE6BAKBfQChu4KS84CVEZ/V3l2/Qj/8km5T7DkHOg8/JxXUfD8LA2FSvAwH6fL8uo1WGebsgtbNUW2V/mRAMFkne8rJtCMA2m8wfuMkvwuSCfrIsnrrEjJWwQgtFBITf0wzmEGn4y6SC
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 04:55:53.4451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa7e0ae-8522-4312-f91d-08d8198d348a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT064.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4724
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-26_01:2020-06-26,2020-06-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=836 adultscore=0
 clxscore=1015 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006260034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch aim at documenting USB related dt-bindings for the
Cadence CDNSP-DRD controller.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 .../devicetree/bindings/usb/cdns-cdnsp.yaml   | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/cdns-cdnsp.yaml

diff --git a/Documentation/devicetree/bindings/usb/cdns-cdnsp.yaml b/Documentation/devicetree/bindings/usb/cdns-cdnsp.yaml
new file mode 100644
index 000000000000..83d353711e31
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/cdns-cdnsp.yaml
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/cdns-cdnsp.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title:  Device tree binding for Cadence CDNSP (Super Speed Plus) controller
+
+maintainers:
+  - Pawel Laszczak <pawell@cadence.com>
+
+description:
+  The Cadence CDNSP controller support Host, Device and DRD mode.
+  It also supports Full Speed, Hight Speed, Super Speed and
+  Super Speed Plus protocols.
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - cdns,usbssp
+
+  reg:
+    description: Physical base address and size of the
+                 controller's register areas. Controller has
+                 three  different regions.
+    minItems: 2
+    maxItems: 3
+    items:
+      - description: HOST registers area.
+      - description: DEVICE registers area.
+      - description: OTG/DRD registers area.
+
+  reg-names:
+    items:
+      - const: xhci
+      - const: dev
+      - const: otg
+
+  interrupts:
+    minItems: 2
+    maxItems: 3
+    items:
+      - description: Interrupt used by XHCI driver.
+      - description: Interrupt used by device driver.
+      - description: Interrupt used by DRD part of driver.
+
+  interrupt-names:
+    items:
+      - const: host
+      - const: peripheral
+      - const: otg
+
+  maximum-speed:
+    enum:
+      - full-speed
+      - high-speed
+      - super-speed
+      - super-speed-plus
+
+  dr_mode:
+    enum:
+      - host
+      - peripheral
+      - otg
+
+  phys:
+    description:
+      Reference to the USB PHY.
+      Must contain an entry for each entry in phy-names.
+      See ../phy/phy-bindings.txt for details.
+
+  phy-names:
+    items:
+      - const: cdnsp,usb2-phy
+      - const: cdnsp,usb3-phy
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    usb_otg: usb@f3000000 {
+      compatible = "cdns,usbssp";
+      reg = <0x00 0x01c13000 0x00 0x0400>,
+            <0x00 0xf3010000 0x00 0x10000>,
+            <0x00 0xf3020000 0x00 0x10000>;
+      reg-names = "xhci", "dev", "otg";
+      interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "host", "peripheral", "otg";
+      phys = <&usbphy 0>;
+      phy-names = "cdnsp,usb2-phy", "cdnsp,usb3-phy";
+      dr_mode = "peripheral";
+    };
+
+...
-- 
2.17.1

