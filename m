Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3643C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 09:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E892222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 09:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ERFjVhJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgAOJO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 04:14:26 -0500
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:20885
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726472AbgAOJOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 04:14:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TX02DQt4F3C85T+OSX45qXpQ4/N/pzuKtfd2aAt9SV+gVW4fumYLdTEkuImRq1jIPqsVwUMH/Md7W7q0CiHDvxIlnj6IaCN0s67OO45nSq1qQuQzSKqF2c2fOGAN0E2JD6OrOWNz5K2oNhE2H+Vo2OiH/Z+nxVHTREAIDom2VT1VAs1krwgsVT+PLkP+l0pmdyfOdTV4YWypDFGLlLToTnV1k9Cxj9/GQPGce/slAjpH0geU7YUQF27ph3xa0c0+q+4lbK4hKW3CIJMIxys/yhe9FcBn8N9bvQcAsGDhViVxf4yuY5SvJwNRxj98gSjpngL3aDn/fHWjwtXxW2SfxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+VApoI90aCR5uJ5qRi1FH6HYnxgZsGSCNsM8GQyhBo=;
 b=daRV/MabKiSCEnIg9mVMEz0/HctcPK84suTQIc1V858+g4e5KdgNlKPseW/+CBE1Dx4QFx7ApR/vYPA9YzWGU2AM6na0R9hyf/luF0F6wFcu7NHiCa68WZoajLeZO94uwhkmSWlA34YW7vqhXwHJU7a4FPvjvDpYLfxPcRKFRxTAqqBu5Jip4x7D7bBci7L7epRNUknzzaQlP2GZlBXJkx6t8C5ofmKBAszEuayT+DGmPpFmjycf3OboNBHhQwcl6FKNotn6d7Bpt9AnPWBlB+OncJb/Z+BR+NlqzOjcz1bpTL7ibNyRMMMOxTCHw32hTwM4wrK9ED3+uwxngTYxIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+VApoI90aCR5uJ5qRi1FH6HYnxgZsGSCNsM8GQyhBo=;
 b=ERFjVhJVNsRirsBO0zW/fONtyglkVhttlE0gbg3MQacAzgRlF8HLv6ne0e9CpNl3DSYGiyZ8CK5E7ua2grYAU3k3FkQpU2XIhQwDOz/9SIraUx8+ojO/xP+uo1TPrsMrPjhRNAoTKtxFy3/6kCfmmKagl2i1RIlFVNw7Z6J9v2w=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5539.eurprd04.prod.outlook.com (20.178.113.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.12; Wed, 15 Jan 2020 09:14:20 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::6d52:5678:e02f:95f4]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::6d52:5678:e02f:95f4%3]) with mapi id 15.20.2623.015; Wed, 15 Jan 2020
 09:14:20 +0000
Received: from localhost (89.37.124.34) by AM5P190CA0006.EURP190.PROD.OUTLOOK.COM (2603:10a6:206:14::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Wed, 15 Jan 2020 09:14:20 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Horia Geanta <horia.geanta@nxp.com>
CC:     Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: clock: imx8mn: add SNVS clock
Thread-Topic: [PATCH 1/3] dt-bindings: clock: imx8mn: add SNVS clock
Thread-Index: AQHVy3/EUCcWFKJUfUCi5MhN1UqJ1afrcVWA
Date:   Wed, 15 Jan 2020 09:14:20 +0000
Message-ID: <20200115091419.grdz67mef5mkm4mt@fsr-ub1664-175>
References: <20200115084225.30464-1-horia.geanta@nxp.com>
 <20200115084225.30464-2-horia.geanta@nxp.com>
In-Reply-To: <20200115084225.30464-2-horia.geanta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::19) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5e5e1c55-4a49-4e47-91a8-08d7999b4e15
x-ms-traffictypediagnostic: AM0PR04MB5539:|AM0PR04MB5539:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5539CA39A1E63E4D67A40844F6370@AM0PR04MB5539.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(199004)(189003)(81156014)(478600001)(81166006)(8676002)(6486002)(33716001)(64756008)(66476007)(16526019)(66446008)(66556008)(6862004)(66946007)(26005)(6496006)(186003)(52116002)(1076003)(956004)(4326008)(8936002)(7416002)(71200400001)(53546011)(5660300002)(316002)(2906002)(9686003)(44832011)(6636002)(54906003)(86362001)(4744005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5539;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jLmVass1jlZZPKfCLB0mz7QHx2Jz93nu83FKOF78yuCpdec8NYlKn5XA/PaLw91qRFWwB4KYquI0yV3afasvGt+9ZiGciM3O75i54nUErb7JWybPaVoWiByCz3zYR5hERlAbmP8D8exT8nKnZjkIN9+dybmR/DoqaGc28LVLsE1XTHwGJso1I27EpbXoAQS6XiutRzVLaSkm4sjTbYi5Ihfm4K8+zUEaZPLu9FsVENG3xXAf/8Sp49xUjbsm6oxvQ2AC8LVCVPByFCOzmHqtddt0ac4IL9SOowemR1Zm8ogIwOCl0+Pe50PntKvQt5i2RtN3b6k/uH+RcbPcn2BeZ4ntWL0KZDBJ+c79XY7Phd/fufWXQPNPn/5nySZtBYunMvnvxrv2Me47MejYRC0lymQv0+OmgmK0bGsgou+yCJojDvThhw42MEKFXnpGMJZqjdfFrakqbjKoxY8KkpU48iccNHwNXpGDUP31amVRepk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9929C85D2C788B46A82BFA6DED278892@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5e1c55-4a49-4e47-91a8-08d7999b4e15
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 09:14:20.7630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6m89QR9ilNasrAY4ECucnSUobH0QW3XakMlmqaBl+SfrzyBUGtSU1DElxGo2wiyr0Hg84Xnq/5sauX5ogf0eGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5539
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAtMDEtMTUgMTA6NDI6MjMsIEhvcmlhIEdlYW50xIMgd3JvdGU6DQo+IFNpZ25lZC1vZmYt
Ynk6IEhvcmlhIEdlYW50xIMgPGhvcmlhLmdlYW50YUBueHAuY29tPg0KDQpBZGQgYSBjb21taXQg
bWVzc2FnZSBwbGVhc2UuDQoNCk5vdGUsIHRoaXMgbW9kaWZpZXMgdGhlIGRldmljZXRyZWUgQUJJ
Lg0KDQo+IC0tLQ0KPiAgaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9pbXg4bW4tY2xvY2suaCB8
IDQgKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svaW14OG1uLWNs
b2NrLmggYi9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2lteDhtbi1jbG9jay5oDQo+IGluZGV4
IDBmMmI4NDIzY2UxZC4uNDM4ODNmZTY1ZGI1IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2R0LWJp
bmRpbmdzL2Nsb2NrL2lteDhtbi1jbG9jay5oDQo+ICsrKyBiL2luY2x1ZGUvZHQtYmluZGluZ3Mv
Y2xvY2svaW14OG1uLWNsb2NrLmgNCj4gQEAgLTIyOCw2ICsyMjgsOCBAQA0KPiAgI2RlZmluZSBJ
TVg4TU5fU1lTX1BMTDJfMzMzTV9DRwkJCTIwOQ0KPiAgI2RlZmluZSBJTVg4TU5fU1lTX1BMTDJf
NTAwTV9DRwkJCTIxMA0KPiAgDQo+IC0jZGVmaW5lIElNWDhNTl9DTEtfRU5ECQkJCTIxMQ0KPiAr
I2RlZmluZSBJTVg4TU5fQ0xLX1NOVlNfUk9PVAkJCTIxMQ0KPiArDQo+ICsjZGVmaW5lIElNWDhN
Tl9DTEtfRU5ECQkJCTIxMg0KPiAgDQo+ICAjZW5kaWYNCj4gLS0gDQo+IDIuMTcuMQ0KPiANCg==
