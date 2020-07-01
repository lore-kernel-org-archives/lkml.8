Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398BCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08966206BE
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lrYAFvpr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgGAHTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:19:54 -0400
Received: from mail-eopbgr150058.outbound.protection.outlook.com ([40.107.15.58]:63397
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727847AbgGAHTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:19:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMWhN6p6jVR+KyNDggKXRhJ7jep3Ljqq412DAVv8FClSRN4bfoy523sor0T00qLbZVfmHYpYsI0wSyc073WqZufzZKQShNKrd8JhPi4LBLbvNXIs95HGKJCmknjtsQ0pB9mJK80hDYCmnw364OjlxKF8cgtXOoYqYjLqb86O04vS/6k82aCkTJueopnK439Eo7sYN15tUNlb017ws6Ptx/QquxWmIUzvV09KQecTdfv+9Z3PQOHeSje9wjzNqq344RdWJNOtg/S5tpOkkmu37fBCgJ8CBneSWiCykrOr7G4vkQ+9B1SZkiOV1Px46McnELVC6G5PKXXvkna+C9jt0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogIImbqG2AQrZhSLwbqU/8sZKaux18Y8A0it8+enT7Q=;
 b=GOg7p6tOAiaJnxfaKiwnYBNtF/hAl0eMFxmINNtjlZ3L0sNkQLnQJaJ/tagwBqGASjIeLxYz3YRxKRpl9iGGlWw8YMULVnpLl2nOnb6gnmKuO2yF8+78v2X4pgPrkad/JB70OtVhLYCL59PQwNBwUWPbvSZDx3R1KqWBYlBXsXc8t/vjvzhqxxnhttunvb2/j872vRmVcoz275Q8ddGQ126XD1eTHiRUlgyo2smYrQFlLIEJDbnXpI1Vr6taw9fBsVvYOMHXXo6NATcAbiG6s2IlgU3F0r3fXtRbYhgrTxYQAc9yi1ISqOgORzYmz8weZ/rYgB0BbV3BBfBI65d3dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogIImbqG2AQrZhSLwbqU/8sZKaux18Y8A0it8+enT7Q=;
 b=lrYAFvpr2KDijN8oH+jiwpvrAy56GtPq8NwozkFwSa1pvNI2uRGNcPhtRjV0Cg5tDo95kVMKGgZ6tDmxq2Q3nCfkGzvMC/rxgtAWO8bU3UzYKO2jfcGnCWpmI2zro7RiMvPtzMqdj0q4aIqX3qsblRXT9tKMGi/mxwzB1Z7iODw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB8PR04MB7180.eurprd04.prod.outlook.com (2603:10a6:10:12c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Wed, 1 Jul
 2020 07:19:47 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3131.030; Wed, 1 Jul 2020
 07:19:47 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Dong Aisheng <dongas86@gmail.com>, Arnd Bergmann <arnd@arndb.de>
CC:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Peng Fan <peng.fan@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 04/10] clk: imx: Support building SCU clock driver as
 module
Thread-Topic: [PATCH V3 04/10] clk: imx: Support building SCU clock driver as
 module
Thread-Index: AQHWTdthV6wfzmMopU6pSRFnxqvg3qjvd4YAgAACQ6CAABqKgIAAAHBggAAdugCAAAKowIAA09MAgAHHMmA=
Date:   Wed, 1 Jul 2020 07:19:47 +0000
Message-ID: <DB3PR0402MB3916E820EA1E9884DD0A08CFF56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
 <1593410042-10598-5-git-send-email-Anson.Huang@nxp.com>
 <CAK8P3a2yXFbGxuSRoC5_dYBujnAtVoEMXe50V7QYjPYhqra7nA@mail.gmail.com>
 <DB3PR0402MB39160335642AFBAC4B38C511F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a0CcijnVxJws_kMiaOBbc4Uox40W4=-dX+BG6OeMYtFpw@mail.gmail.com>
 <DB3PR0402MB39167D9A3897C3CE327EBDDBF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a1cYsgJu+JCrmQw-VQyAKpyOz7fpOf3jBZ7QKc=urUFtw@mail.gmail.com>
 <DB3PR0402MB39167F7746B4B3794600FC7FF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAA+hA=TYuSk=P4D_D0_Rv1O2AAB3UvYrNXToptPJjEsjECquUw@mail.gmail.com>
In-Reply-To: <CAA+hA=TYuSk=P4D_D0_Rv1O2AAB3UvYrNXToptPJjEsjECquUw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 45d07724-9fce-4477-7400-08d81d8f22de
x-ms-traffictypediagnostic: DB8PR04MB7180:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB718065573AC4EEA68A09BFD0F56C0@DB8PR04MB7180.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R79WF1DVt0W3syPhw28JafpPdxBdsrzhmPOznOf5epspXtYvlw1xl4lztNaudpyjlvP7ULE97U8Akuq6GYBzoA84SqJLImxu7aaGW7otZax0Ttz1nZ+aJFyz0WG4r4A6qJNGzA7ubLRE9KvP0Us7iVoySFvDlnsGq7XhWqiYnsfiLMo/KyUnrzQ7YcGFllpf+Y9XEmL5i55Qqdq+xwV++qPwShaC1yy0A8IuT1WuxPD0J9sVxk8XrnMB4WEi6U6isOPCUwIO0EMmegMCeCJyobYwBAh/sRdlcy7p3Z+tNvUnMyb2DJwrY8dROVW7cr/U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(44832011)(110136005)(7416002)(316002)(54906003)(2906002)(66446008)(7696005)(9686003)(19627235002)(5660300002)(55016002)(6506007)(86362001)(52536014)(478600001)(53546011)(71200400001)(66946007)(66556008)(64756008)(66476007)(8936002)(83380400001)(26005)(8676002)(4326008)(186003)(76116006)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: KJp7aZiUx0VC+ci7tOtUs/QnkRAlnLHYjTEoQKwu9WiMCL5JAvDOHvN9CNWhSa2k0MMzw1v4lUMgNXfu+Q/WglhneH10FKWozTaxnrs6f83g+MuVY+qec8S2tjR9g0ZJSEQFzQEjsw4xCqPgJB4jf4p7YxInbOG2DqwZVS37XrtwazMy/fwFDU6T0n8WVttgjZLmyjFcie6madkKRA6M0vG4w/tuv2ah/RK0OK0h/DEKmzxuGin5t8qphIvo3c+6Cgp6g823QpXrQMUmotmPrpKoKCDvIO/VveClBsdaTq7fSf2f8qCGbIUzdxx5BIgz+6f+FdkKh4qCpjd5jgnkBWDJGImy06sjFI9w5xuzJfOMvQAIKVKCCRQ5futk2mYHQrHrDS13cB/bxi8hd8Ns+EBJSxhD7Cq0bCncf/hvEMvI0w0hTRrWvByN7u3jO8ZcCVy26jb2ZO8eEOqdr8gPXDC4jM3wY/WDR0RzA1/9ymQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d07724-9fce-4477-7400-08d81d8f22de
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 07:19:47.3958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PM9SZJ0AeOXH+T5E4KVV2ozjSaxSC6NZmOsHn5XK4m+u8goKy1/x0L/E08Nq1/SVZw+TQrejzZ7oYmidGF3F5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFybmQNCg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMDQvMTBdIGNsazogaW14OiBT
dXBwb3J0IGJ1aWxkaW5nIFNDVSBjbG9jayBkcml2ZXIgYXMNCj4gbW9kdWxlDQo+IA0KPiBPbiBU
dWUsIEp1biAzMCwgMjAyMCBhdCA1OjE2IEFNIEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAu
Y29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IEhpLCBBcm5kDQo+ID4NCj4gPg0KPiA+ID4gU3ViamVj
dDogUmU6IFtQQVRDSCBWMyAwNC8xMF0gY2xrOiBpbXg6IFN1cHBvcnQgYnVpbGRpbmcgU0NVIGNs
b2NrDQo+ID4gPiBkcml2ZXIgYXMgbW9kdWxlDQo+ID4gPg0KPiA+ID4gT24gTW9uLCBKdW4gMjks
IDIwMjAgYXQgNDo1MiBQTSBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gPiA+
IHdyb3RlOg0KPiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMDQvMTBdIGNsazogaW14
OiBTdXBwb3J0IGJ1aWxkaW5nIFNDVQ0KPiA+ID4gPiA+IGNsb2NrIGRyaXZlciBhcyBtb2R1bGUg
T24gTW9uLCBKdW4gMjksIDIwMjAgYXQgMjo1MyBQTSBBbnNvbg0KPiA+ID4gPiA+IEh1YW5nDQo+
ID4gPiA8YW5zb24uaHVhbmdAbnhwLmNvbT4gd3JvdGU6DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBT
b3JyeSwgSSBtaXNyZWFkIHRoZSBwYXRjaCBpbiBtdWx0aXBsZSB3YXlzLiBGaXJzdCBvZiBhbGws
IHlvdQ0KPiA+ID4gPiA+IGFscmVhZHkgcHV0IGNsay1zY3UubyBhbmQgY2xrLWxwY2ctc2N1Lm8g
ZmlsZXMgaW50byBhIGNvbWJpbmVkDQo+ID4gPiA+ID4gbG9hZGFibGUgbW9kdWxlLCBhbmQgSSBo
YWQgb25seSBsb29rZWQgYXQgY2xrLXNjdS5jLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gV2hhdCBJ
IGFjdHVhbGx5IG1lYW50IGhlcmUgd2FzIHRvIGxpbmsgY2xrLXNjdS5vIHRvZ2V0aGVyIHdpdGgN
Cj4gPiA+ID4gPiBjbGstaW14OHF4cC5vIChhbmQgcG9zc2libHkgZnV0dXJlIGNoaXAtc3BlY2lm
aWMgZmlsZXMpIGludG8gYQ0KPiA+ID4gPiA+IGxvYWRhYmxlIG1vZHVsZSBhbmQgZHJvcCB0aGUg
ZXhwb3J0Lg0KPiA+ID4gPg0KPiA+ID4gPiBTb3JyeSwgY291bGQgeW91IHBsZWFzZSBhZHZpc2Ug
bW9yZSBkZXRhaWxzIGFib3V0IGhvdyB0byBkbyBpdCBpbg0KPiBNYWtlZmlsZT8NCj4gPiA+ID4g
SSB0cmllZCBiZWxvdyBidXQgaXQgbG9va3MgbGlrZSBOT1Qgd29ya2luZy4gbXVsdGlwbGUgZGVm
aW5pdGlvbg0KPiA+ID4gPiBvZg0KPiA+ID4gbW9kdWxlX2luaXQoKSBlcnJvciByZXBvcnRlZC4N
Cj4gPiA+ID4NCj4gPiA+ID4gb2JqLSQoQ09ORklHX01YQ19DTEtfU0NVKSA6PSBjbGstaW14Lm8g
Y2xrLWlteC15ICs9IGNsay1zY3Uubw0KPiA+ID4gPiBjbGstbHBjZy1zY3Uubw0KPiA+ID4gPiBj
bGstaW14LSQoQ09ORklHX0NMS19JTVg4UVhQKSArPSBjbGstaW14OHF4cC5vIGNsay1pbXg4cXhw
LWxwY2cubw0KPiA+ID4NCj4gPiA+IFJpZ2h0LCB5b3UgY2FuJ3QgaGF2ZSBtdWx0aXBsZSBtb2R1
bGVfaW5pdCgpIGluIGEgbW9kdWxlLCBzbyB3aGF0IEkNCj4gPiA+IHN1Z2dlc3RlZCBlYXJsaWVy
IHdvbid0IHdvcmsgYW55IG1vcmUgYXMgc29vbiBhcyB5b3UgYWRkIGEgc2Vjb25kDQo+ID4gPiBj
aGlwIHRoYXQgdXNlcyB0aGUgY2xrLXNjdSBkcml2ZXIsIGFuZCB0aGVuIHlvdSBoYXZlIHRvIHVz
ZSBzZXBhcmF0ZQ0KPiA+ID4gbW9kdWxlcywgb3Igc29tZSBoYWNrIHRoYXQgY2FsbHMgdGhlIGlu
aXQgZnVuY3Rpb25zIG9uZSBhdCBhIHRpbWUsIHdoaWNoIGlzDQo+IHByb2JhYmx5IHdvcnNlLg0K
PiA+ID4NCj4gPiA+IElmIGl0J3Mgb25seSBpbXg4cXhwLCB5b3UgY2FuIGRvIGl0IGxpa2UgdGhp
czoNCj4gPiA+DQo+ID4gPiBvYmotJChDT05GSUdfTVhDX0NMS19TQ1UpIDo9IGNsay1pbXgtc2N1
Lm8gY2xrLWlteC1scGNnLm8NCj4gPiA+IGNsay1pbXgtc2N1LXkgICAgICAgICArPSBjbGstc2N1
Lm8gY2xrLWlteDhxeHAubw0KPiA+ID4gY2xrLWlteC1scGNxLXNjdS15ICs9IGNsay1scGNnLXNj
dS5vIGNsay1pbXg4cXhwLWxwY2cubw0KPiA+ID4NCj4gPiA+IElmIHlvdSBhbHJlYWR5IGtub3cg
dGhhdCB0aGUgc2N1IGRyaXZlciBpcyBnb2luZyB0byBiZSB1c2VkIGluDQo+ID4gPiBmdXR1cmUg
Y2hpcHMsIHRoZW4ganVzdCBzdGF5IHdpdGggd2hhdCB5b3UgaGF2ZSBub3csIHVzaW5nIGENCj4g
PiA+IHNlcGFyYXRlIG1vZHVsZSBwZXIgZmlsZSwgZXhwb3J0aW5nIHRoZSBzeW1ib2xzIGFzIG5l
ZWRlZC4NCj4gPiA+DQo+ID4NCj4gPiBUaGFua3MsIGFuZCB5ZXMsIEkga25vdyB0aGF0IHNjdSBj
bGsgZHJpdmVyIHdpbGwgYmUgdXNlZCBmb3IgZnV0dXJlDQo+ID4gaS5NWDhYIGNoaXBzIHdpdGgg
U0NVIGluc2lkZSwgdGhlIGN1cnJlbnQgaS5NWDhRWFAgY2xvY2sgZHJpdmVyIGNhbg0KPiA+IE5P
VCBjb3ZlciBhbGwgaS5NWDhYIGNoaXBzLCBzbyBJIHdpbGwgc3RheSB3aXRoIHRoZSBleHBvcnRp
bmcgc3ltYm9scy4NCj4gPg0KPiANCj4gU0NVIGNsb2NrIGRyaXZlciBpcyBhIGNvbW1vbiBkcml2
ZXIgZm9yIGFsbCBTQ1UgYmFzZWQgcGxhdGZvcm1zLg0KPiBDdXJyZW50IGkuTVg4UVhQIFNDVSBj
bG9jayBkcml2ZXIgd2lsbCBiZSBleHRlbmRlZCB0byBzdXBwb3J0IGFsbCBmdXR1cmUgU0NVDQo+
IGJhc2VkIHBsYXRmb3Jtcy4NCj4gU28gdGhlb3JldGljYWxseSBjbGstc2N1Lm8gYW5kIGNsay1p
bXg4cXhwLm8gY2FuIGJlIGNvbWJpbmVkLiBMUENHICBpcw0KPiBzaW1pbGFyLg0KPiBNYXliZSB5
b3UgY2FuIGdpdmUgYSB0cnkgYXMgQXJuZCBzdWdnZXN0ZWQuDQo+IA0KDQpEbyB3ZSByZWFsbHkg
bmVlZCB0byBsaW5rIGNsay1zY3UgYW5kIGkuTVg4UVhQIGNsb2NrIGRyaXZlciB0b2dldGhlciBq
dXN0IHRvIGF2b2lkIHNvbWUgZXhwb3J0Pw0KSSBtZXQgc29tZSBidWlsZCBpc3N1ZXMgaWYgdXNp
bmcgdGhpcyBtZXRob2QsIHRoZSBpLk1YOFFYUCBtb2R1bGUgYnVpbGQgaXMgT0ssIGJ1dCBvdGhl
ciBwbGF0Zm9ybXMNCmxpa2UgaS5NWDhNTS9pLk1YOE1OL2kuTVg4TVEvaS5NWDhNUCBjbG9jayBk
cml2ZXJzIGFyZSBqdXN0IHNraXBwZWQgZm9yIGJ1aWxkLCBldmVuIHRoZXNlDQppLk1YOE0gY2xv
Y2sgY29uZmlnIGFyZSBleGlzdGluZyBpbiAuY29uZmlnLCBhbnlvbmUga25vdyB3aHk/IExvb2tz
IGxpa2UgdGhlIGNoYW5nZSBpbiBNYWtlZmlsZSBmb3INCmkuTVg4UVhQIGNsb2NrIGRyaXZlciBp
bnRyb2R1Y2UgdGhpcyBpc3N1ZS4NCg0KSSB0aGluayBkb2luZyBzdWNoIGJpZyBjaGFuZ2UgaW4g
b3JkZXIgdG8gc2F2ZSBzb21lIGV4cG9ydHMgbG9va3MgbGlrZSBOT1QgdGhhdCB3b3J0aCwgaXMg
aXQgYWNjZXB0YWJsZQ0KdG8ganVzdCBrZWVwIHRoZSBvcmlnaW5hbCBvbmUgaW4gTWFrZWZpbGUs
IGp1c3QgdG8gaGF2ZSBteGMtY2xrLmtvLCBjbGstc2N1LmtvIGFuZCBjbGstaW14OHF4cC5rbyBl
dGMuLg0KDQp0aGFua3MsDQpBbnNvbg0KDQouY29uZmlnOg0KQ09ORklHX01YQ19DTEs9bQ0KQ09O
RklHX01YQ19DTEtfU0NVPW0NCkNPTkZJR19DTEtfSU1YOE1NPW0NCkNPTkZJR19DTEtfSU1YOE1O
PW0NCkNPTkZJR19DTEtfSU1YOE1QPW0NCkNPTkZJR19DTEtfSU1YOE1RPW0NCkNPTkZJR19DTEtf
SU1YOFFYUD1tDQoNCk1ha2VmaWxlOg0KbXhjLWNsay1vYmpzICs9IGNsay1maXh1cC1tdXgubw0K
bXhjLWNsay1vYmpzICs9IGNsay1mcmFjLXBsbC5vDQpteGMtY2xrLW9ianMgKz0gY2xrLWdhdGUy
Lm8NCm14Yy1jbGstb2JqcyArPSBjbGstZ2F0ZS1leGNsdXNpdmUubw0KbXhjLWNsay1vYmpzICs9
IGNsay1wZmQubw0KbXhjLWNsay1vYmpzICs9IGNsay1wZmR2Mi5vDQpteGMtY2xrLW9ianMgKz0g
Y2xrLXBsbHYxLm8NCm14Yy1jbGstb2JqcyArPSBjbGstcGxsdjIubw0KbXhjLWNsay1vYmpzICs9
IGNsay1wbGx2My5vDQpteGMtY2xrLW9ianMgKz0gY2xrLXBsbHY0Lm8NCm14Yy1jbGstb2JqcyAr
PSBjbGstcGxsMTR4eC5vDQpteGMtY2xrLW9ianMgKz0gY2xrLXNzY2ctcGxsLm8NCm9iai0kKENP
TkZJR19NWENfQ0xLKSArPSBteGMtY2xrLm8NCg0Kb2JqLSQoQ09ORklHX0NMS19JTVg4TU0pICs9
IGNsay1pbXg4bW0ubw0Kb2JqLSQoQ09ORklHX0NMS19JTVg4TU4pICs9IGNsay1pbXg4bW4ubw0K
b2JqLSQoQ09ORklHX0NMS19JTVg4TVApICs9IGNsay1pbXg4bXAubw0Kb2JqLSQoQ09ORklHX0NM
S19JTVg4TVEpICs9IGNsay1pbXg4bXEubw0KDQpvYmotJChDT05GSUdfTVhDX0NMS19TQ1UpIDo9
IGNsay1pbXgtc2N1Lm8gY2xrLWlteC1scGNnLXNjdS5vDQpjbGstaW14LXNjdS0kKENPTkZJR19D
TEtfSU1YOFFYUCkgKz0gY2xrLXNjdS5vIGNsay1pbXg4cXhwLm8NCmNsay1pbXgtbHBjZy1zY3Ut
JChDT05GSUdfQ0xLX0lNWDhRWFApICs9IGNsay1scGNnLXNjdS5vIGNsay1pbXg4cXhwLWxwY2cu
bw0KDQo=
