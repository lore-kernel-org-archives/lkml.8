Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DBBC54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 983B62087E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q3d4rXOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbgDWPNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:13:47 -0400
Received: from mail-am6eur05on2059.outbound.protection.outlook.com ([40.107.22.59]:6024
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729013AbgDWPNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:13:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfa0IK6xH94nJW1hecaAd0nSPsBdWcy5rsLukqwAI1kM100J17s/3+UjuZBgDi3u9G4Kl3HIhEqqR9z7G5HZvKo13MA58IrvvKoI/ijpLIgfhUkrJEYU6u9d8Nbxoonrl/3lmFFGo8HS5U3wgNueMqRDIH9Te3FejpssJdqZwlHzCVHeau9OJ5gJOdRQezKGxDph2e1tKb/Es1r6ALtnrDi0+6ncIvp8m+XEt/ngNADfeuD9b6GzM0WmSQ/RuCWW0MC0Qw+/1S34LdcaBG1pZls2r0CtP9L38D3vZH0aqxw+CasWlmV6/w09RqXjERmptN3tcX4ReWBMHT9+WNvBlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfKMt9U54UidDZNSYbwSfk5TSJFD890lozB5/YerqB0=;
 b=M0SlX/JjjhAOGnXXnVekmIOvusCk3L7N7woLHzA0Eko+TfRHqif0B/W8R4ZAezbla204i8f6gRlpnzbQSfhUbkpckVFcCCtOgHo1+2EJbuMqm5SYn27POwedlf252noSh402BxFRSGT0bSUOFJsiif98xZxGP8/c/FRG5xDvsOdO4nLWor7nOhZSnv4E4Hg0Cxic1PbV+cLb2veQzmenV9AHD9gmXX3U1iK3xjzS93ZecboreBEIV3T16PCksIdaErraPl8omoj4d4RSdvHjsj8J9ByWhcomOGr35mhCwinWzkoeV98yJOaHdRqzzKhT7qjKs0lgyVZpqqWNaBe+7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfKMt9U54UidDZNSYbwSfk5TSJFD890lozB5/YerqB0=;
 b=Q3d4rXOVcBMcCHfwDhQxna8/RoDteQDQZBWWNNcv0cKtnh58h8jzsHINGflLtbjaR31B1uiXPQE20aShtL6tnHYoe6btOzdYImBghbTCmIRrdSgHTtKKvb+RjzbEyeE34P1JGyWb0Gjwz3qbfBVQZaluX2odxlqaEKUDemIlW5M=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5288.eurprd04.prod.outlook.com (2603:10a6:20b:5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Thu, 23 Apr
 2020 15:13:44 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::d9f7:5527:e89d:1ae3%7]) with mapi id 15.20.2921.032; Thu, 23 Apr 2020
 15:13:43 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        Peng Fan <peng.fan@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org0001-dt-bindings-firmware-imx-Move-system-control-into-dt.patch" 
        <linux-pm@vger.kernel.org0001-dt-bindings-firmware-imx-Move-system-control-into-dt.patch>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/3] firmware: imx: Remove unused include of
 linux/firmware/imx/types.h
Thread-Topic: [PATCH 2/3] firmware: imx: Remove unused include of
 linux/firmware/imx/types.h
Thread-Index: AQHWGXikllCxH492tkWmUtYS8ArEHqiG0H/Q
Date:   Thu, 23 Apr 2020 15:13:43 +0000
Message-ID: <AM6PR04MB49667E0135A0675CC5ADE1EF80D30@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1587650382-18586-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1587650382-18586-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 15ace320-ecdc-4485-2087-08d7e798e9ce
x-ms-traffictypediagnostic: AM6PR04MB5288:|AM6PR04MB5288:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB52887F1E33D687D310E01EE080D30@AM6PR04MB5288.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(4326008)(186003)(4744005)(8936002)(5660300002)(71200400001)(8676002)(33656002)(52536014)(9686003)(7416002)(478600001)(2906002)(81156014)(55016002)(6506007)(26005)(316002)(76116006)(7696005)(66476007)(64756008)(110136005)(66556008)(66946007)(44832011)(66446008)(86362001)(921003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gxddJABAXmUFpNFmGQCGJ0TbNxQFzMmMWABA6434CPaSL314FpxDTxwX9YP8B30G2z7OEUY0FszTNH5hpmM3N5nt9BbFBPeJtwEw3KIhRUCnfImh9ByPOOnIz9q2VoKGYkSBxbYM4Rb+xi8pjHtLXffWTdevM7HOIRha8vTy2s549PL+jEMAHVuM9gcL2DGW2qfFPm8KUqo/iDDA+wM/L8DkEJvNtfSdovWjFzXP+ZNZyRRuth7CHSLT/I0YzQOUzI6h1+xzj6G37EL94g0OqXQME9Cq2RIgS15KEbGKNh0FHEdWLAu828AiQuqp/uAb/mk3CgCqAsWY4ADoqO0p65iPxKVvlAAzPSmjoY00mHmw3Wj51vzuW79nPLGr2jekN2YUPEnj0SRQpsHF/7mLQnsR0jyqf9yki6rPY0rWKUAE4R9jMfWSiuFgoP1Ebqh3KqE3mAoSrQPET+2Pvan4Ir9HZQFLrhj4RIMvTvOxltE=
x-ms-exchange-antispam-messagedata: WScZD+nEp7fAs7fthusdcOG5dvRU1joXlMJAbfIVz41hidrL7/BS5tX4SpgOT1rXIDKLs/mzTNYZBpLvbndsZbeVQ028hWP3UpDTgJT8QHiwhkJn/S39og+Q+J6TmAwlXllfxYEIuEUweS/UUfSHWA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ace320-ecdc-4485-2087-08d7e798e9ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 15:13:43.9380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ESjMqJqzvJhNYK8IP8hnnmIeKFkm+xLDb7raqndpZwAgPewAh5Rw8Zv37FV/ZtudokiPhoV5SNScbEy6jmTDsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5288
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogVGh1cnNk
YXksIEFwcmlsIDIzLCAyMDIwIDEwOjAwIFBNDQo+IA0KPiBOb3cgdGhhdCBsaW51eC9maXJtd2Fy
ZS9pbXgvdHlwZXMuaCBpcyByZW1vdmVkLCByZW1vdmUgaXQgZnJvbSB0aGUgaW5jbHVkZSBsaXN0
DQo+IGluIGlteC1zY3UuYyBkcml2ZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFu
ZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCg0KWW91IG5lZWQgY29tYmluZSB0aGVtIGluIG9yZGVy
IHRvIG5vdCBicmVhayBiaXNlY3QuDQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0KPiAtLS0NCj4gIGRy
aXZlcnMvZmlybXdhcmUvaW14L2lteC1zY3UuYyB8IDEgLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL2lteC9pbXgt
c2N1LmMgYi9kcml2ZXJzL2Zpcm13YXJlL2lteC9pbXgtc2N1LmMNCj4gaW5kZXggZjcxZWFhNS4u
ZjMzNDBmYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9maXJtd2FyZS9pbXgvaW14LXNjdS5jDQo+
ICsrKyBiL2RyaXZlcnMvZmlybXdhcmUvaW14L2lteC1zY3UuYw0KPiBAQCAtOCw3ICs4LDYgQEAN
Cj4gICAqLw0KPiANCj4gICNpbmNsdWRlIDxsaW51eC9lcnIuaD4NCj4gLSNpbmNsdWRlIDxsaW51
eC9maXJtd2FyZS9pbXgvdHlwZXMuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9maXJtd2FyZS9pbXgv
aXBjLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvZmlybXdhcmUvaW14L3NjaS5oPg0KPiAgI2luY2x1
ZGUgPGxpbnV4L2ludGVycnVwdC5oPg0KPiAtLQ0KPiAyLjcuNA0KDQo=
