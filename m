Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2794DC3B18B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F37D82073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=KoCoConnector.onmicrosoft.com header.i=@KoCoConnector.onmicrosoft.com header.b="EEvCzfPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgBMOqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 09:46:09 -0500
Received: from mail-am6eur05on2087.outbound.protection.outlook.com ([40.107.22.87]:13790
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726282AbgBMOqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 09:46:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHFcOjm7PFUyppLt9qNY99DY8wnkCDhK79pR7mkpDa6/p2AeXwaUtascMIOw17z8JvFySdwl56u1taNVk7oN8LL2/PU9BCl0I8jiv2K6G8vNwDCQbBfNYnYzf2KiwQz6gTWSTaVITeSnZEX4T4voxig0Lkxu1wDTwItULzJvrx13jq8lvolp5xwF8ndZ65OCydJqbw4QhC1k6exVIsGXieAxB1HFKEYAznFCdngjfJ5GakjQBbFeWKe33OhwlOiJZq0p5dEBpFodMaxDTgV54hKgdt0vCv64xo8GJEDub97o0K+zUak1paE9+kX3oz0D3ScFH7CTOfdhX9zrGuM25w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBg84B6nB4eQ1UUMZirmp02kNykjg6R0cbBRnCBPXQI=;
 b=VGNaO4wvsQQ45xUxPJZ9PY2AJtrUn95m3tAMAWSvAqZM3r5fk8NuJRGBZ+BrpfYnP+N3xEz7sqaDi++Kfn9s+NGTbXnN9FkOWAK0Ajvj2GN8FVyCoT1zyiCtbRm/kso0wxo+lkAy+0+iZaDkCM4kaMP6x4GxMifo1nU9jy1JJiUWshXvcyV3LB3Hvv3SYFm2DeeSiVFyLmSyyRJo9mTv2pwJht0+u48rMDsbf3O/CZ8W/ZkhhYocLvClP2FSiuxlp4gFdeB6DyXwzlkkXsmyeHMvuzeToYe41AxlSZqo6xRju8LdQL7jQQgi9d6zbo6nSkO/tzNsyf2uLsLn0Ver1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kococonnector.com; dmarc=pass action=none
 header.from=kococonnector.com; dkim=pass header.d=kococonnector.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBg84B6nB4eQ1UUMZirmp02kNykjg6R0cbBRnCBPXQI=;
 b=EEvCzfPWHJJzoSLP4AjYFALD7R9wCSNYnFi2YKdKDnHMFsakzbuN9STZ6ZHY7MdD7PAsCyYiYenyxUfqJCtqd4CmtCx3nEYDu0TJPpcBvKjmtmS9u5c++eAtIh2MNVciUFZ27xnq7pKOSUfr6cXZLOVCJorxMLBGS32FmiVDD1o=
Received: from DB6PR0902MB2072.eurprd09.prod.outlook.com (10.170.212.23) by
 DB6PR0902MB2038.eurprd09.prod.outlook.com (10.170.213.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 13 Feb 2020 14:46:05 +0000
Received: from DB6PR0902MB2072.eurprd09.prod.outlook.com
 ([fe80::406b:dddb:f0d2:7ea7]) by DB6PR0902MB2072.eurprd09.prod.outlook.com
 ([fe80::406b:dddb:f0d2:7ea7%7]) with mapi id 15.20.2729.025; Thu, 13 Feb 2020
 14:46:05 +0000
Received: from localhost (193.47.161.132) by AM4PR0501CA0052.eurprd05.prod.outlook.com (2603:10a6:200:68::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.24 via Frontend Transport; Thu, 13 Feb 2020 14:46:04 +0000
From:   Oliver Graute <oliver.graute@kococonnector.com>
To:     "aisheng.dong@nxp.com" <aisheng.dong@nxp.com>
CC:     "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?iso-8859-1?Q?Jonathan_Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] dt-bindings: arm64: imx: Add board binding for i.MX8QM MEK
 Board
Thread-Topic: [PATCH v1] dt-bindings: arm64: imx: Add board binding for
 i.MX8QM MEK Board
Thread-Index: AQHV4nxRs2kDGa0OcEWFKtzPa5a5Tg==
Date:   Thu, 13 Feb 2020 14:46:05 +0000
Message-ID: <20200213144451.31455-1-oliver.graute@kococonnector.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR0501CA0052.eurprd05.prod.outlook.com
 (2603:10a6:200:68::20) To DB6PR0902MB2072.eurprd09.prod.outlook.com
 (2603:10a6:6:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oliver.graute@kococonnector.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-patchwork-bot: notify
x-originating-ip: [193.47.161.132]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcff7765-e81e-4c54-63b5-08d7b0937395
x-ms-traffictypediagnostic: DB6PR0902MB2038:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0902MB20389369B1CC04BC2052D7F1EB1A0@DB6PR0902MB2038.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39840400004)(376002)(346002)(396003)(199004)(189003)(6916009)(71200400001)(4744005)(36756003)(2616005)(64756008)(66476007)(956004)(66556008)(508600001)(966005)(6486002)(66446008)(66946007)(5660300002)(52116002)(6496006)(7416002)(186003)(54906003)(26005)(81156014)(16526019)(2906002)(86362001)(4326008)(44832011)(8676002)(8936002)(316002)(1076003)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0902MB2038;H:DB6PR0902MB2072.eurprd09.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: kococonnector.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /N/kXS4R+bfVHIqbj5IfXz7k/1NSk065GBpmxydmt4QkdsYRLP8QGe3tc3StZW0er8K81Zj626pTJTCyiIzLVFLNa1YZu2GvsfUrgiBizm+cGUlrTFyqGy9l6ZZdo45UjRF6RyYPVKbZcJvPs+XaUQzAJi6OAOAy4EIWVSBU9olicsvKmljTCd5c84n+RMGitJPNLw1qwiDaGTDKT7lJ2VbpS0LzjHMQFupNyvzsxR7wuT74ot0o0PcmJ5+PVjMe5tubZX8NkYYI0SiUxnM8j4UtM9X+eG5ETUtLnOfx7xah808a61HEtA47yXsTkkwuZTOZFpKgBSCCA+ajdFDWR6CpOlrmKYfg0L/IJFmzILriKwjGr9S7YQrhid6S0rqCIvc7pgOH/n2LeOUe70UUFoJUUel7MP4GLg/Wy6Ifmx+N6oWJ5wGkLWE79X+6axT6eXkMI5XnU3Rvyic47KgEgpUaaLH7JklT/Q2/dcl+YwFq2p+/KabgRNTSaP8mw4apeCBmmFWTl9otKUgkXqI5Jg==
x-ms-exchange-antispam-messagedata: p1ZCW01HQa1qn5l/uEl4CpzDKbO+M1Gx6xF6xtiKfnJ9WWIfqwVA1iHzRa93OjwyRqYJdjLsBLx87PzitdjCMF2mrWHqNf8JSnOsIN0mHjT7rHj41LhrU65tWcrMXvhMUF4tOkyd0GU6ALQA0JRBsw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcff7765-e81e-4c54-63b5-08d7b0937395
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 14:46:05.3239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oC8oRy59O0hYD/EkYZstaEro9bhmt04eOlO8KIJUU7SQYNhOrLK9CabSLhgI5UkafoKyLKUTkaTIlO1dXZLksBkNojqgaNNO2CBBHWVpCVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0902MB2038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add board binding for i.MX8QM MEK Board

Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
---

 this patch should belong to this series:

 https://patchwork.kernel.org/patch/10824573/

 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation=
/devicetree/bindings/arm/fsl.yaml
index a8e0b4a813ed..8b75ee13006d 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -336,6 +336,12 @@ properties:
               - technexion,pico-pi-imx8m  # TechNexion PICO-PI-8M evk
           - const: fsl,imx8mq
=20
+      - description: i.MX8QM based Boards
+        items:
+          - enum:
+              - fsl,imx8qm-mek  # i.MX8QM MEK Board
+          - const: fsl,imx8qm
+
       - description: i.MX8QXP based Boards
         items:
           - enum:
--=20
2.17.1

