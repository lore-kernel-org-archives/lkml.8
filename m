Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8A1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A3BF20758
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B2+R53pD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgESFJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 01:09:02 -0400
Received: from mail-am6eur05on2057.outbound.protection.outlook.com ([40.107.22.57]:6180
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726272AbgESFJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 01:09:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBSzeJPMERKc1JqARQEViZarPnzsUP1pIlnfa2TQ+ou308DCLaqVG5lIRxg6wFaDmYTKrujHzH5dZm9CMqUqHGpQdrbg99Reli/QFQbSRDQmMVmSliFQscM9hoTQNag+xo8AeHBOF2zS7bwAc8DkHxYzHiNwh0sfHALxnjUa5kRcz4/2qx87oi3TgEBjfGdIzDzgu9v6fJmus5rNxZGj/xn+z3F6d/QJqbgIik4AIAzrOvlj0KnSNvnhbX2Sc2aREVu3ZY7+6WKdCAwn3Vunu2NdaH7/JZA2HiNSFuwb2qMEBS63zkQQi4kC++ohFadBv0P685Jcf3PWZUSYCuVifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91Uc/DfEXaDArSf0XmpGuOK3J/viFCqd3xsfGU8vRpk=;
 b=Ne2O0C/Zk2ApX6fKD/M1Decbgdl+TZJfUk4XjvG2Fzkq4cxusx/vYznOc97As5g/+T4pFEAxRYRY5myqRa0XWsGHdE/oOmUEwaxUj33BxZZn+swFzSM+wxgdL8NlC5siOq8aV6YM3++xyX45CE4DYGucITaVE4OAnfmfREYqyc7nworqPaoVT2sdbMf7PniVYw/aRduWNBM7JcIM6riqiadY58rphIaZ8hC0bwHNVx+W65kI6TJEDyYKqfahjCXYYfeIgglEJ8SGARpQxU/swyVnYkdhrhz9er6IK+4Px47u/i8jdSmsdD8sGe736WvRi7NDVRQalZANWJytHIBOVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91Uc/DfEXaDArSf0XmpGuOK3J/viFCqd3xsfGU8vRpk=;
 b=B2+R53pDmTgyMDhLdBqm3+aHG67x7EXraSjQOhaybf8nmuMziYj3gnMUGIzYsvuf43tjDh91zbP8I1Qz5y6FxkBtRUBqp692wv2fF1uYssb71cylIUqbJPChQx+JvRWPEPjXcmDZPWQsMjl38xNWvyMx4adGBN0/3XKevY2ODEc=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5031.eurprd04.prod.outlook.com (2603:10a6:20b:f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.31; Tue, 19 May
 2020 05:08:58 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 05:08:58 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 1/3] dt-bindings: timer: Convert i.MX GPT to
 json-schema
Thread-Topic: [PATCH V2 1/3] dt-bindings: timer: Convert i.MX GPT to
 json-schema
Thread-Index: AQHWLZLAPsM6FoMGIkCRdX41U1i3AKiu29xA
Date:   Tue, 19 May 2020 05:08:57 +0000
Message-ID: <AM6PR04MB4966AC2D4664B8A9FE7A205380B90@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589860547-3207-1-git-send-email-Anson.Huang@nxp.com>
 <1589860547-3207-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1589860547-3207-2-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dd0ce018-c9e3-4922-e61a-08d7fbb2bc70
x-ms-traffictypediagnostic: AM6PR04MB5031:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB5031EC23D21BB30D93F77D8180B90@AM6PR04MB5031.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:254;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kyBwzQzeQSstUWFbfkl0Almd7bhURHmkfV1cICnhJsva15ja0jOxkwoXPf18t4zO2SgOQNTWsB5J69CyC/R8ontRfrPv+6VFYEDqBXv76bq7LhSCQDTyUva1D4LK0FehDkslNCoa4nIztnRaqyItzdWVE6r5pENYZVOB5YwK3fA8zIaqLYw5ERI+7iLeVXH81fOtEmuVXkem5k5ejMEcJiNWWXyIhvFZdL0vABIAAGVCsAtoi72L0bHs4W8oJK5cLjouanlEaLAwUUkCuGRcpHlzHvthgahYDNV3uFekrWrNftw4Rd6tpvqq6SpcTF171Ljdz0Iy4N1vlVs8UXpCFOSvMPE3RLAAE+0ORFT6zXD88rI5ODi+o0MeIr3cDkGNpKcqIc0ArzY88bKnvCLz+Fp2jKuhekFpNMX3kKvZ1hS9/TZIa4SNbHkIxzdNdsdYf3R+fFzlB8WpkFd6j1R7uMkYRSOOe0HclO5fOuGXjGo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(26005)(316002)(66446008)(64756008)(66556008)(66476007)(66946007)(52536014)(33656002)(8936002)(8676002)(110136005)(2906002)(71200400001)(478600001)(86362001)(7416002)(9686003)(5660300002)(7696005)(4326008)(186003)(55016002)(558084003)(44832011)(6506007)(76116006)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2IOc59xYbe6FmKTorrXB4MVuD/+TU9sSD9Jf9AKMaTVfgUqkxVZONnHwWAIyXeW5vgL7SCagIO9eR7NZHFBOrwiJA4E5Fe4BIhB4CPRnuWv6HRpGleoUjFY2YV8elpNItl0ihQOdZqn2KdhFtL22VNGwzkwA+q+2bf8tCBKs87VRyQmGU0Jr07Rxk3BweatcWh7qi6yh/QxocU1Z689P2bbSshdJ0MhHP1/IRRSwulOhFr5ogT2T2IY+gbqyw/fcGSXVTt050a4Gcy73mgXoxUDXcO1HCHvirQSJgzWQNmv3crZbhM03OpNKirznCoeUV8s9UONHXe9onxTxUPGazG85FIxVnltyXnAGGIuOctQJ6qbGYfCgMRCK9MkVmeFrXCq73AHUCscewYSWdQEmtaNq2NP4DRsmlrM+J/Cm2vATsuWE/zQ9HXg7l2r/C2PzTRjlPQfDaYBwPSzBfYF+RQcaobEb1cMc4+BdQ0KaUmSw3weI2xD38CXDYdZuysey
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0ce018-c9e3-4922-e61a-08d7fbb2bc70
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 05:08:57.7722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PqEl9lA1NXkU10o0JJeozsZh6Ns2KGANqq/kYzKfjTIUoxxRem4SroqGTFxuTIt0isUVmRdw3x3kdy8e/tYUdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogVHVlc2Rh
eSwgTWF5IDE5LCAyMDIwIDExOjU2IEFNDQo+IA0KPiBDb252ZXJ0IHRoZSBpLk1YIEdQVCBiaW5k
aW5nIHRvIERUIHNjaGVtYSBmb3JtYXQgdXNpbmcganNvbi1zY2hlbWEuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCg0KUmV2aWV3ZWQtYnk6
IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQoNClJlZ2FyZHMNCkFpc2hlbmcN
Cg==
