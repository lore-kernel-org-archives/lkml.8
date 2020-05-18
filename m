Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7DAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96DF620787
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="feglcC9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgERGEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 02:04:45 -0400
Received: from mail-eopbgr50071.outbound.protection.outlook.com ([40.107.5.71]:46725
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726040AbgERGEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 02:04:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvbyfZR8ur6s3HxWU/0ovQ1+Z0OhpGTrnw3V2gZwakGvuOXjDs249EH5TH14yAWSaUDp79z/zmIU9qLqNSHR/GFrVPb0frWoq8CNMuvnlV0BWD3OJ2B5hDxlAUYzRu7hWLa8MReWNc7DUAK2SiGHWakt3NLMZVDQ9VoO2upT9+jKGU+4P6yyxI8DS1y9q6T3Ie7BVpwr27vGPteFM3mjmX+ccA+LxE2nVU+hJv9E5UR4csK+KkcyhvPi76IAIxpQ1y4kwi1cnrk6exElacfB6YQ4IXn1BpUupzUpqGM+SBVa+oa63DiN1EaLmz/c7aFDf9mo6YZilfmRaQ+M+ODNYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PrflyRysGKtoZE9Klrsf6ztDe0QyNa/FLktqJibxCI=;
 b=gZhubsT6283PUMQSzK4exLA95R887OaLPKXqG1GP2Iw1CVsu8T4esrtdIElxr4E0hIbbDFPAy11o5fjPf69XszCkIqRtZ9UCsM5tqPIGKJ/NjRmCYxQv2mDsN7XF5LtyykNuZFb3saHkfUj4zCCD79bgEcBl05W7woGjJjwDxKSzQ52Zy6LceIjOeLpaGJN4lzLq//hKif90XRgti1J2d9x97bMSFgeCCVf9TRoQCO5hCaHkWlfBVG9O2odfZAKTGFseIniriPjao/JUJcynBHxJKd+2rO52OoEnSdMFzher/zoNDVUrcJ+UiEc+HEJYWdnLirBob7KxqyhmtZj5pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PrflyRysGKtoZE9Klrsf6ztDe0QyNa/FLktqJibxCI=;
 b=feglcC9bpcBJNX3aAy/cRdDVm42DPfYqVNCBUx+7m04C7/WnPBbagW0USJeE9lY+EctF4/xa49aqZ3mmSkmVHvVoekN68CMwD//kOVfWjaKgdwFWOraBehTOo8f1n0VMuvnBIuo5fPkizGzZeGvD1T4CC6Dni3bgUtFE1VtwfNM=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4280.eurprd04.prod.outlook.com (2603:10a6:209:42::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 06:04:41 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 06:04:41 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "maz@kernel.org" <maz@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] dt-bindings: interrupt-controller: Convert imx irqsteer
 to json-schema
Thread-Topic: [PATCH] dt-bindings: interrupt-controller: Convert imx irqsteer
 to json-schema
Thread-Index: AQHWLLrj2zkAZPZ1ZEqhceYmXEBXFqitMkdAgAAcRoCAAAug4A==
Date:   Mon, 18 May 2020 06:04:41 +0000
Message-ID: <AM6PR04MB496682951EE8049C97A288A380B80@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589767841-4213-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB4966C2A615086069F9C05B7780B80@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916609EB361691CA3254D23F5B80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916609EB361691CA3254D23F5B80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aa7210dd-d9cf-4def-9568-08d7faf15ac4
x-ms-traffictypediagnostic: AM6PR04MB4280:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB42808F6386C8AE9BE4B79D3280B80@AM6PR04MB4280.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:632;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vPzO9Q0K9GXRYcMSLLf9grKszZPTsAy0TU4xUilRY4UXeWB8YMDGYpNLAx9FKfZKqyU+vqvIFdFm+lOkuevUnbGIfcwl8v5fdz+Y10OXwfZujW4jJZR2zjPKBEQN/0Tr6SYs/t1ahUR9U2qF27jCNV7GLFQ7KSmzKmVEWzS5oMpdFgh2c5M4wiQY8EvHfvrh0NCP7BkGXltQxqPB18rqgWRfpVrSXsWPTJ+d5tmVrAf9ayOumJwq5vg0XPw2/XAanD6xRpDGv3l2pSIoLLH+r4H0MwDYAoVhWHggu009xnickEbNuV4nr/jDazDVQl4XjT2yhGe8yKLVnTGPLmCYSoA/b8pMP2KAaLh06SyRCFDxoSqz1Wkdve8fUjsfb9Xbt2/m6+ONqspWByX24te2GyDe41G8CZZf2F4VC/zF9J3KpJgm/fYfblnLN4NlQwRL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(66556008)(5660300002)(33656002)(66946007)(53546011)(66446008)(8936002)(316002)(86362001)(66476007)(110136005)(478600001)(9686003)(4326008)(55016002)(52536014)(71200400001)(26005)(7696005)(64756008)(186003)(4744005)(44832011)(6506007)(8676002)(2906002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: u5WtUI38VCXneTqLqJAKCLRIOqR13BFC/JQzp/RnFMjdQyGykqo/jIJgQmol8oUVMsV9pQXpWEJaRmoroBNUX6dmFtU/S1kSt+9nnNQdY0dHe96f0dgcLYA0i9mTb18vKwTto8xeY8d30dCyaDGumokmCitU/QZ0YA0A5k3hoe9weeDoa4NSHF8rrx/i+ycZ/fLQoPYKLyFTzutU/Ay5YHiU4wi9T2lvulemLEWUdRSe/WI9B/uerW5Y1Lkq//j5jNea+0Ort/TZzsLCbXxws+ooOeZOM1oRodymheVbB4yv/Sa9+GrXlqepS3TWafSDwGccPJEBw298ixWLiRzFJSEw88BvPa0H73os5Wv9cnwaHfql3rsV4VoCvnBczJzZXLyhVatWt+jEYPZBLTQ3Q0XSlF0vBtqew8oUQB3T4qV3OpfxRtCt5n/Knf1Ebrz87aogvHySJPgTBALz8/YxrCiSdTbRnvBB+VejMPJJPZM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7210dd-d9cf-4def-9568-08d7faf15ac4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 06:04:41.1930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UA5XpgunQfB3EBpiQbMy8uPRgIjzcNlfFVyw4wf09O38bAWoNRrqa0CTTT1vo6xrcjC2uDZVwqpdNobJMrEPPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4280
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gU2VudDogTW9uZGF5
LCBNYXkgMTgsIDIwMjAgMToyMCBQTQ0KPiANCj4gPiBTdWJqZWN0OiBSRTogW1BBVENIXSBkdC1i
aW5kaW5nczogaW50ZXJydXB0LWNvbnRyb2xsZXI6IENvbnZlcnQgaW14DQo+ID4gaXJxc3RlZXIg
dG8ganNvbi1zY2hlbWENCj4gPg0KPiA+IC4uLg0KPiA+ID4gKw0KPiA+ID4gK3RpdGxlOiBGcmVl
c2NhbGUgSVJRU1RFRVIgSW50ZXJydXB0IG11bHRpcGxleGVyDQo+ID4gPiArDQo+ID4gPiArbWFp
bnRhaW5lcnM6DQo+ID4gPiArICAtIEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRl
Pg0KPiA+ID4gKw0KPiA+ID4gK3Byb3BlcnRpZXM6DQo+ID4gPiArICBjb21wYXRpYmxlOg0KPiA+
ID4gKyAgICBjb25zdDogZnNsLGlteC1pcnFzdGVlcg0KPiA+DQo+ID4gWW91IGNoYW5nZWQgYmlu
ZGluZyBoZXJlIHdpdGhvdXQgY29tbWVudHM/DQo+IA0KPiBJdCBpcyBiZWNhdXNlIGRyaXZlcnMv
aXJxY2hpcC9pcnEtaW14LWlycXN0ZWVyLmMgT05MWSBoYXMgImZzbCxpbXgtaXJxc3RlZXIiIGFz
IHZhbGlkDQo+IGNvbXBhdGlibGUsIHNvIHRha2UgdGhpcyBjaGFuY2UgdG8gZml4IGl0IGluIHRo
aXMgcGF0Y2guDQoNCk5vcGUuIFlvdSBtaWdodCBiZSBtaXN1bmRlcnN0b29kIGFib3V0IGR0LWJp
bmRpbmcuIEl0J3MgSFcgZGVzY3JpcHRpb24gbGFuZ3VhZ2UuDQpEcml2ZXJzIGRvZXMgbm90IGRl
ZmluZSBiaW5kaW5ncywgZHJpdmVycyBvbmx5IGltcGxlbWVudCBiaW5kaW5ncy4NCg0KUmVnYXJk
cw0KQWlzaGVuZw0KDQo+IA0KPiBBbnNvbg0KDQo=
