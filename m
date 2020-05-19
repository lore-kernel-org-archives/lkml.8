Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8A8C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98EF22075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dRt1REJS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgESCwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 22:52:13 -0400
Received: from mail-eopbgr10062.outbound.protection.outlook.com ([40.107.1.62]:45475
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726417AbgESCwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 22:52:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+tImLjypJdUYoxinvONaKlzUkmhbl5jW22qbNTwShQv85noayOy+nKMIB2eccms9PKaHd9GCDYwR0Nlj0uYumZbodIjJlse+uT3wWE0lmCk23vYQ1FpQk9XJhcH6cjiluDWERrdd6MIUX6OfXgRCT6ZM+TNQD5GqYag7y35y3644eNTcVZJyG2cxVdvNR7OioWoVOaGudJDr8Gs9YtYYikiXirzUVdOrqER5Um/Jp63yyxm809pJpuwHcfl1toDT22edLey7haxq3CW6w3tYMPSnPRo2D8JVgFAd7n/I09C6q96ugc38D55ruMfkk7o2vXul5vP7YhK2+Rjo33HEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfS3wnXt8n+gmfL+5U0TSIrTn/Ii8p/2F4+ryA56y80=;
 b=H8eROt9oxFbAEfQlnTZp4LwV3woE3SPb35GkmBLpVHzOXwEdnDGffg1hMawHFQ10qq/fLspCBp3LqdH7j8xx5epz6amisf090+Acksu2v+nVk3hsusGhRbOTLcDc4ZBxaGk9VW+tPDwP9WMKQmdlY9daGTOqDYeA6Ob9mAVXor9lI/eV5SeV+2DfxbM+LnPNEwUOVqcQ5Vy8b+1VrKQ4TthnNmoPQGzxUupVaYAIzYhlMDdaWlyPiLjkSd+4PXDmco1/8Tu7IH0XKGyrDfAy2hj8Vn0AdQVDtBgtuQeo6MZpdJGo4qoxYlZPBs3V6chR60grdgydvxyJbnoXEq7KxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfS3wnXt8n+gmfL+5U0TSIrTn/Ii8p/2F4+ryA56y80=;
 b=dRt1REJSaqr2rheYTtrcfqa5t9/I1vqPvY3gcGk9CWaw9n6JAM0Bdcj2SSWcJCw3oG2FBAIkmR8Rmtt+BSd3sE67XtpYHrdULPlk9UksRRb1PbMl9qh+337KBBZt5GHDCb16DBS89eZdRjgrc573I+PWfaPlJ7Juh+VilwWxJX8=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4150.eurprd04.prod.outlook.com (2603:10a6:209:43::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Tue, 19 May
 2020 02:52:07 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 02:52:07 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] ARM: dts: imx: make src node name generic
Thread-Topic: [PATCH] ARM: dts: imx: make src node name generic
Thread-Index: AQHWLRLKO6MQZuvP8UGLsHrjKwg3HKiutrFg
Date:   Tue, 19 May 2020 02:52:07 +0000
Message-ID: <AM6PR04MB49664D39DBFCD2525D30C70C80B90@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589805593-14164-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1589805593-14164-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1957db49-1ce4-483c-a008-08d7fb9f9ed7
x-ms-traffictypediagnostic: AM6PR04MB4150:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB41506A3B5F3B1857E62BD13080B90@AM6PR04MB4150.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UyikRMSQ6CDZ7WeUA0HWaIy9/jZGg5O0Rrh7lC7afU9wwv+olhsdm4P4Q6ZAUj8RofIZbeEYyvDhtSFuZWcEFouE+TO96hrkDsaPb8sl+jNbSnlyQ/8zVDp64e9zmqxs3wdLYViZXwRNzbBJrqK2r4UB4PKZ6Mm2TD6B/+QRT/ZqI0NkdezxJCaQ806COuifQJMUcw1XYDQ9Bkq1c17WCReQnp0RXkt9Qd9xiO1BFkmnpwta2M+K9Xa3NsQiOyv4dm527tlFjWDfrTZAqMsdrvyD/KZYaJt/eNYoSRUQjI4bclvHDg8trMLh7E3tYpQ1xgNx3HiECA7k2b8crgb0OfvXmyB58LFvkZjdchorlrsiSjMcKLA/qwPX3dGS03zhaca4q7p9pu+qm8wj0qP62COCZJqo8ljuFUOSLLxLaJzV0eVNfC8ayXbS9LyFsAEtsA4861C7don4dnxZMDSKV9Q1WzIaHAff/Rz9B9uU0S/Eq97VGIPDWOpR40wPAjyO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(316002)(66446008)(110136005)(52536014)(86362001)(9686003)(6506007)(4326008)(8676002)(64756008)(478600001)(71200400001)(186003)(5660300002)(26005)(76116006)(66556008)(66476007)(66946007)(2906002)(44832011)(55016002)(8936002)(7696005)(33656002)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: MSnE9B4/hrE5IFAqqqv+AQ+1bTzEzUtSytRRpv+76RmfD47FqMx/Xwfa2AbgB2UWChslmXxG6xW5RMUxbFlhkUV1SE3vFafnVDZvHbAC1eWsNgKsKfiwsL5LyMUQsvIVgey//yFEdccpqAcoFG3h6ubsrY22DARLp+64ZGhBlpsv1PmUDiDgbXNF6V5iAZ5oA9WuKW8p0dIjR+G8JcC3XXO3YS/Ekvi799YcVLnJKLKfbB1aKwN8c3VxaWGNMplYMca3+8MFDrKQi7MV0XK3dPP6D+PN+1kuFuF/mxLCJSAwZApRMxDdadi8ABcUyVOymULtOGusGRliRrk2mcnrTL6V0n8HFIHnUYufaEOT538AOku7aQchUKP0gU3b9obDmrUmCaH1ASDOdVMIB0/aEUahM/IAx5FrZc4bNneVqKTYaIe8KhKx0KsQ2nrlXkI5tj9+74ty2C4jGV7BMGSMvTMDlgxk4FKBbgrX1XhERtjzYELAi3tTmO2g8K/J/2yo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1957db49-1ce4-483c-a008-08d7fb9f9ed7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 02:52:07.9057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NWJtaQEWH2Tc3rRIhNd8LcK+UkDqkiGodCWoUoLyo123ZFkk5FBdocEXoan6quUleEweSUj51JE+q5orWpiFaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogTW9uZGF5
LCBNYXkgMTgsIDIwMjAgODo0MCBQTQ0KPiANCj4gTm9kZSBuYW1lIHNob3VsZCBiZSBnZW5lcmlj
LCB1c2UgInJlc2V0LWNvbnRyb2xsZXIiIGluc3RlYWQgb2YgInNyYyIgZm9yDQo+IGkuTVg2L2ku
TVg3IFNvQ3Mgc3JjIG5vZGVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFu
c29uLkh1YW5nQG54cC5jb20+DQoNClJldmlld2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcu
ZG9uZ0BueHAuY29tPg0KDQpSZWdhcmRzDQpBaXNoZW5nDQoNCj4gLS0tDQo+ICBhcmNoL2FybS9i
b290L2R0cy9pbXg2cWRsLmR0c2kgfCAyICstDQo+ICBhcmNoL2FybS9ib290L2R0cy9pbXg2c2wu
ZHRzaSAgfCAyICstDQo+ICBhcmNoL2FybS9ib290L2R0cy9pbXg2c3guZHRzaSAgfCAyICstDQo+
ICBhcmNoL2FybS9ib290L2R0cy9pbXg2dWwuZHRzaSAgfCAyICstDQo+ICBhcmNoL2FybS9ib290
L2R0cy9pbXg3cy5kdHNpICAgfCAyICstDQo+ICA1IGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9u
cygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0
cy9pbXg2cWRsLmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2cWRsLmR0c2kNCj4gaW5kZXgg
MTc2M2MyYi4uMzlkNGFmZCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFk
bC5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwuZHRzaQ0KPiBAQCAtODU4
LDcgKzg1OCw3IEBADQo+ICAJCQkJaW50ZXJydXB0cyA9IDwwIDU3IElSUV9UWVBFX0xFVkVMX0hJ
R0g+Ow0KPiAgCQkJfTsNCj4gDQo+IC0JCQlzcmM6IHNyY0AyMGQ4MDAwIHsNCj4gKwkJCXNyYzog
cmVzZXQtY29udHJvbGxlckAyMGQ4MDAwIHsNCj4gIAkJCQljb21wYXRpYmxlID0gImZzbCxpbXg2
cS1zcmMiLCAiZnNsLGlteDUxLXNyYyI7DQo+ICAJCQkJcmVnID0gPDB4MDIwZDgwMDAgMHg0MDAw
PjsNCj4gIAkJCQlpbnRlcnJ1cHRzID0gPDAgOTEgSVJRX1RZUEVfTEVWRUxfSElHSD4sIGRpZmYg
LS1naXQNCj4gYS9hcmNoL2FybS9ib290L2R0cy9pbXg2c2wuZHRzaSBiL2FyY2gvYXJtL2Jvb3Qv
ZHRzL2lteDZzbC5kdHNpIGluZGV4DQo+IGZjYjg0ZmUuLjkxMWQ4Y2YgMTAwNjQ0DQo+IC0tLSBh
L2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZzbC5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRz
L2lteDZzbC5kdHNpDQo+IEBAIC02NzgsNyArNjc4LDcgQEANCj4gIAkJCQlpbnRlcnJ1cHRzID0g
PDAgNTcgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ICAJCQl9Ow0KPiANCj4gLQkJCXNyYzogc3Jj
QDIwZDgwMDAgew0KPiArCQkJc3JjOiByZXNldC1jb250cm9sbGVyQDIwZDgwMDAgew0KPiAgCQkJ
CWNvbXBhdGlibGUgPSAiZnNsLGlteDZzbC1zcmMiLCAiZnNsLGlteDUxLXNyYyI7DQo+ICAJCQkJ
cmVnID0gPDB4MDIwZDgwMDAgMHg0MDAwPjsNCj4gIAkJCQlpbnRlcnJ1cHRzID0gPDAgOTEgSVJR
X1RZUEVfTEVWRUxfSElHSD4sIGRpZmYgLS1naXQNCj4gYS9hcmNoL2FybS9ib290L2R0cy9pbXg2
c3guZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZzeC5kdHNpIGluZGV4DQo+IGQ2ZjgzMTcu
LmUwMzEzMzcgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZzeC5kdHNpDQo+
ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZzeC5kdHNpDQo+IEBAIC03NTQsNyArNzU0LDcg
QEANCj4gIAkJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgNTcgSVJRX1RZUEVfTEVWRUxfSElHSD47
DQo+ICAJCQl9Ow0KPiANCj4gLQkJCXNyYzogc3JjQDIwZDgwMDAgew0KPiArCQkJc3JjOiByZXNl
dC1jb250cm9sbGVyQDIwZDgwMDAgew0KPiAgCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDZzeC1z
cmMiLCAiZnNsLGlteDUxLXNyYyI7DQo+ICAJCQkJcmVnID0gPDB4MDIwZDgwMDAgMHg0MDAwPjsN
Cj4gIAkJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgOTEgSVJRX1RZUEVfTEVWRUxfSElHSD4sIGRp
ZmYgLS1naXQNCj4gYS9hcmNoL2FybS9ib290L2R0cy9pbXg2dWwuZHRzaSBiL2FyY2gvYXJtL2Jv
b3QvZHRzL2lteDZ1bC5kdHNpIGluZGV4DQo+IDJjY2Y2N2MuLjM1ZTczMDEgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bC5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3Qv
ZHRzL2lteDZ1bC5kdHNpDQo+IEBAIC02NzYsNyArNjc2LDcgQEANCj4gIAkJCQlpbnRlcnJ1cHRz
ID0gPEdJQ19TUEkgNTcgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ICAJCQl9Ow0KPiANCj4gLQkJ
CXNyYzogc3JjQDIwZDgwMDAgew0KPiArCQkJc3JjOiByZXNldC1jb250cm9sbGVyQDIwZDgwMDAg
ew0KPiAgCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDZ1bC1zcmMiLCAiZnNsLGlteDUxLXNyYyI7
DQo+ICAJCQkJcmVnID0gPDB4MDIwZDgwMDAgMHg0MDAwPjsNCj4gIAkJCQlpbnRlcnJ1cHRzID0g
PEdJQ19TUEkgOTEgSVJRX1RZUEVfTEVWRUxfSElHSD4sIGRpZmYgLS1naXQNCj4gYS9hcmNoL2Fy
bS9ib290L2R0cy9pbXg3cy5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14N3MuZHRzaSBpbmRl
eA0KPiA3NmUzZmZiLi44YmFjNDkxIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9p
bXg3cy5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDdzLmR0c2kNCj4gQEAgLTYy
NCw3ICs2MjQsNyBAQA0KPiAgCQkJCWNsb2NrLW5hbWVzID0gImNraWwiLCAib3NjIjsNCj4gIAkJ
CX07DQo+IA0KPiAtCQkJc3JjOiBzcmNAMzAzOTAwMDAgew0KPiArCQkJc3JjOiByZXNldC1jb250
cm9sbGVyQDMwMzkwMDAwIHsNCj4gIAkJCQljb21wYXRpYmxlID0gImZzbCxpbXg3ZC1zcmMiLCAi
c3lzY29uIjsNCj4gIAkJCQlyZWcgPSA8MHgzMDM5MDAwMCAweDEwMDAwPjsNCj4gIAkJCQlpbnRl
cnJ1cHRzID0gPEdJQ19TUEkgODkgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+IC0tDQo+IDIuNy40
DQoNCg==
