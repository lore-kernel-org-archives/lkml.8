Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F79FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B8DF20715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bpdw7SWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgERGI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 02:08:26 -0400
Received: from mail-eopbgr10059.outbound.protection.outlook.com ([40.107.1.59]:27526
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726040AbgERGI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 02:08:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBEwOUE2GBau38gk9JTXzx/LwAfk0zu3s0zxyKL4Z9yNhZu31ktDpuF+JsttvErSHE4Io7CE0ofZglx1VDo0wseNgpDWAH0XlNvrrzbOn4SC/aSPYE/WU2N+TQwOX3MHneEumt4TRMkI/dQIDjmiHj7msPUq1zmBjL+e9hY/ARwp89MYgtTzUVsiollvVRN82ADmsbyTcLDs9Lbcj+CLg273604rogC44PYDf7MymsfzqJ2xOEHuJWCEN3poBIQjggXshyLn8qqr8B4r9uzQdt4DO/kn0Rxq8HCBFz1DoaE6VuYA0SDJy5liHrZISyQZcXfzNXjd7JV7FmX9ZLLcxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Pdlw9uhVFXgCDDxMAziNFrZ4BTkNVvR4z7wX8+zbpE=;
 b=SMLbnsFbOKaxVOsvtwnsgEV/m52Rrq56+rz4EXku8e0qAwGTumTCNIyo0t5IFL0Lj66SiDWR85l3bY3ueh5Mn4BCi5UPaf8u5hSQYeF0yu5ijEe2aTy19OoJPeN9zbt3RSu3SmGf7lg3rG04mtMBITj+o3BoP0QLPyCvo2rQgX792cGZzsHe+RV0hOhft9NEl+89lsl+KC7gycOD2FRQ4O1vIfvSiXloI6ayFwOeqIF8QYYGIGRwH4LFaclzPM0okibvOMzLC++rmN2cSMMXjELlPfSIWcIi7yDxMTz32KODCzMJTViFOGMYCosk40kYwpEO9tWiR6T62uf+cVYUUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Pdlw9uhVFXgCDDxMAziNFrZ4BTkNVvR4z7wX8+zbpE=;
 b=bpdw7SWzowpfXJLPH0qT2u/bBlAl3RZr2CrLG2FfJ9GMlePSwOy4y5LmvdhoAkRu1SdzifLZ69ruPyUYWNOh8bT2mHeJWBn/iSFvitIYxuQ/FdNj0bDYkkwvi6MgPIDbmoCh0i/LHpWPoEVcw6DA2rCC7OoWZjaUhqpfszHCKtY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3834.eurprd04.prod.outlook.com (2603:10a6:8:e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Mon, 18 May
 2020 06:08:21 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3000.033; Mon, 18 May 2020
 06:08:21 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
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
Thread-Index: AQHWLLrjNbk2hqU7XkKTiiG/WSwz26itMpIAgAAbZACAAA0EgIAAAN7Q
Date:   Mon, 18 May 2020 06:08:21 +0000
Message-ID: <DB3PR0402MB3916B16A46FB9275CE5544C1F5B80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1589767841-4213-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB4966C2A615086069F9C05B7780B80@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916609EB361691CA3254D23F5B80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM6PR04MB496682951EE8049C97A288A380B80@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB496682951EE8049C97A288A380B80@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 91abfde7-cf82-44c1-cfe5-08d7faf1de12
x-ms-traffictypediagnostic: DB3PR0402MB3834:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB38349FE8C3D77165B3EC62DFF5B80@DB3PR0402MB3834.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:632;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GgdrDfu+Y38n2rGJAgVttH7/vRF+eH7vnpcv1drgHIg1Zrxx/KwR00eg9Eu9r0Mah11yC8P/fpb6RRCrVZTRHUAnNOsbHL3XGGUhFcvmiG5NPfAC/PK4VzNIx07Xfe2Y8hnr7aggHj5oali14Kof+RJ/mGqA0ZK91uM74dlWnOlaUS5kAzuert4co/t9v1vCCKTlUYE/WA/dpYk/4TyOmXP1eDfrtOlZj2YOGDmqmIts/YlSNX01G/lcZ08DgyFK0sQ6nbRS/t09sIUKUhlIALySGcF6hSqNAEn2eeld6Gl41UpdSnuE+c5GY9smJbe9xr7UrQAxtwoiDNkwbHlh3BTtZl2HUBvs9jNQwT4+WD0ZRkXnqekC7Xq1/oSPncj2FN/vG+IW9KJkQ2Kzh87dowCa6fuhkzBOWDIfClm4K/Sdjv/1iPZfq2wrysSGb1U4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(2906002)(8676002)(55016002)(71200400001)(4744005)(33656002)(7696005)(8936002)(9686003)(478600001)(5660300002)(86362001)(26005)(52536014)(44832011)(186003)(6506007)(53546011)(316002)(4326008)(66476007)(110136005)(66946007)(66556008)(64756008)(66446008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: MbrUb3NxRIaVOaIsdXmuY7kTa56e4mrmcoy0gum5nXwWHRV5lQkKrGNWhSsDcB0cxWW7/OkxPlQD+PDIQKBO6Idb8LQozzNMgbuRrhp/RrKj10sF6LrzRFig+LCrRaz+x1BT5nrmAPg9xfWuO0EnIhdASfd3/ALs0H0AhpnZu2O0ydXm1oN51fh7Ikm7+csDDbGzCZBVZhXHK7JqRGmOCdZADSNrWRJkbRpP1vbtl/cYl2YH5TCRJNE/Vbzb4LPCsh47NO7AOBr2vz599/CapEzNq78Y5tA4YNGayMVFvDjG3rCkN/ygFBf+8Hhim18qML/38rEB9k76r9mWwQa1UJuDcgS2xOB58fTMOqjT37tmCwEsNO1HEARXv9Wk2BAkpPXJyiLBGgWuS2jQa5j5DHrw/05h/Uf3xifxFfY+cQrtePjOc0RJwbRp1+ProCYsx3H6uN97w7Gh7bENCp9wqEWpAumDLdSYVaVuuksij8xNnc8gb8Z9TeWnEknXWY3y
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91abfde7-cf82-44c1-cfe5-08d7faf1de12
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 06:08:21.2893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Khwknah3ToNP0jLiR9Y7AaG2gbw+rOvj967em06ckMtI/WdC9Pk8aTm8dwmdXbBGTJtySCaX2RjyYmc0K3Tdsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3834
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIGR0LWJpbmRpbmdzOiBpbnRlcnJ1cHQtY29udHJvbGxl
cjogQ29udmVydCBpbXggaXJxc3RlZXIgdG8NCj4ganNvbi1zY2hlbWENCj4gDQo+ID4gRnJvbTog
QW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+ID4gU2VudDogTW9uZGF5LCBNYXkg
MTgsIDIwMjAgMToyMCBQTQ0KPiA+DQo+ID4gPiBTdWJqZWN0OiBSRTogW1BBVENIXSBkdC1iaW5k
aW5nczogaW50ZXJydXB0LWNvbnRyb2xsZXI6IENvbnZlcnQgaW14DQo+ID4gPiBpcnFzdGVlciB0
byBqc29uLXNjaGVtYQ0KPiA+ID4NCj4gPiA+IC4uLg0KPiA+ID4gPiArDQo+ID4gPiA+ICt0aXRs
ZTogRnJlZXNjYWxlIElSUVNURUVSIEludGVycnVwdCBtdWx0aXBsZXhlcg0KPiA+ID4gPiArDQo+
ID4gPiA+ICttYWludGFpbmVyczoNCj4gPiA+ID4gKyAgLSBMdWNhcyBTdGFjaCA8bC5zdGFjaEBw
ZW5ndXRyb25peC5kZT4NCj4gPiA+ID4gKw0KPiA+ID4gPiArcHJvcGVydGllczoNCj4gPiA+ID4g
KyAgY29tcGF0aWJsZToNCj4gPiA+ID4gKyAgICBjb25zdDogZnNsLGlteC1pcnFzdGVlcg0KPiA+
ID4NCj4gPiA+IFlvdSBjaGFuZ2VkIGJpbmRpbmcgaGVyZSB3aXRob3V0IGNvbW1lbnRzPw0KPiA+
DQo+ID4gSXQgaXMgYmVjYXVzZSBkcml2ZXJzL2lycWNoaXAvaXJxLWlteC1pcnFzdGVlci5jIE9O
TFkgaGFzDQo+ID4gImZzbCxpbXgtaXJxc3RlZXIiIGFzIHZhbGlkIGNvbXBhdGlibGUsIHNvIHRh
a2UgdGhpcyBjaGFuY2UgdG8gZml4IGl0IGluIHRoaXMNCj4gcGF0Y2guDQo+IA0KPiBOb3BlLiBZ
b3UgbWlnaHQgYmUgbWlzdW5kZXJzdG9vZCBhYm91dCBkdC1iaW5kaW5nLiBJdCdzIEhXIGRlc2Ny
aXB0aW9uDQo+IGxhbmd1YWdlLg0KPiBEcml2ZXJzIGRvZXMgbm90IGRlZmluZSBiaW5kaW5ncywg
ZHJpdmVycyBvbmx5IGltcGxlbWVudCBiaW5kaW5ncy4NCg0KT0ssIHdpbGwgYWRkIGl0IGJhY2su
DQoNCkFuc29uDQoNCg==
