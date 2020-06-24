Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE81BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2B4820738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jnbqvi/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388896AbgFXJSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 05:18:36 -0400
Received: from mail-eopbgr00072.outbound.protection.outlook.com ([40.107.0.72]:16515
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728637AbgFXJSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 05:18:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDtwVrl4wDhx9eLpxLW63XijhktHd0NRkxUBptg58ahTfDBbIpzHynQ7WHIO2yfGQquEe/Y+OIuLGBHKXvL2ULXu2FrFi+QqlR03B/Wx9ZDWRpq5aHhZvJm5ttf/ilc4sUdJSuMhgAj1OJ6+NMyN8wGi3c874+fZSnuLFDSuV/eIBqe/rx4QBMiMdT23gn1cFU/DmvMLaputVj9k0XHPWeagwPpLGhyqZe+zkicGhaXdqOSaOKnflb53n66urfgfxtCIJKdymRmblLkY0smTU1NKqWJqoCFyPdXwXvq/b3UAia8JiQciZ5rHHWbHNgi3q9ueypmSQBixyrj39UsSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDK6sbG40WFx+q4pAfckp+HL3eEPtBrHC2iM1KZQeJQ=;
 b=Nd9ckoZzmEu9XzwEz7Gv1SwMudJXflB7cM1QB2/GQyK4tlVh8UsUd8YndqLvgvpbdiWr5G/aKv8PEddHgEzvHfinHq0utnFk4ROkbB21uSizavHKIls0BXJyN0y1RFrKdTueyQbIFZAqQIZVZBjwUVtv53nyKsCeIQyDeJSk39liVuMLUbyuqAPBD9z39UVcyvjAgNGjL9YeRH/3XHex3io+NTkh4VDshmAVK32VQSDK6sBUsQJ03bnQVNcb5MRNvqiSOWOYHyZhBXL20qO8eiw6CGY2wAU++jlWPcqCw6fa0tYivUXzk1DeAg7ytFweAmKdUBBs32br/gks1qJq8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDK6sbG40WFx+q4pAfckp+HL3eEPtBrHC2iM1KZQeJQ=;
 b=Jnbqvi/2Z+WiURL24iAgGpf1btuvaIG8VxKic3SWFEG68+4hjgZZCfT9RcIlpeKKR5Ezi7gHjBw/wxpVMD/+kG57wll0g4h389+suPfsaRYUi2AlBTf3BG4+oQ1BkMTyaKvCSzRMwWXkQitA5yX7x0aXKekQtnveioXf5vmBaVs=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5063.eurprd04.prod.outlook.com (2603:10a6:20b:a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 24 Jun
 2020 09:18:30 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 09:18:30 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "info@metux.net" <info@metux.net>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2 3/9] clk: imx: Support building SCU clock driver as
 module
Thread-Topic: [PATCH V2 3/9] clk: imx: Support building SCU clock driver as
 module
Thread-Index: AQHWPjGl8KdpudYoFUWSs6/zaZS5vqjcqcVQgAAe9YCAAOIhAIADPk4AgASxvPCAAFrbAIAAAT6wgAERl4CAABTeEIAAXWqAgAAUgdA=
Date:   Wed, 24 Jun 2020 09:18:29 +0000
Message-ID: <AM6PR04MB4966D2D5DBA5DEB0E0DEA51380950@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com>
 <1591687933-19495-4-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB49660A10856A3746C7103394809A0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB39163BC04E4E5F4F6A22F6D4F59A0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM6PR04MB4966B94CFAE642E6AF5AEF79809B0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <159262367025.62212.11651547971712516448@swboyd.mtv.corp.google.com>
 <AM6PR04MB496690A045E0BFFF3D03AE0380940@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <159290125202.62212.13172213909023205615@swboyd.mtv.corp.google.com>
 <AM6PR04MB49664A8400CA0B0F7321EDDE80940@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <159296027133.62212.18074403520585879907@swboyd.mtv.corp.google.com>
 <AM6PR04MB4966BA60F25AE60ABA8F883180950@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <CAK8P3a21gJg-iVNupx94WZjcpNtHPLJhDM_Uh7E_4yGjSH_pJg@mail.gmail.com>
In-Reply-To: <CAK8P3a21gJg-iVNupx94WZjcpNtHPLJhDM_Uh7E_4yGjSH_pJg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c150f849-47fd-4b9a-aae4-08d8181f8f4a
x-ms-traffictypediagnostic: AM6PR04MB5063:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB5063C938B9165B91EC0B3A5980950@AM6PR04MB5063.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vMHk4h8BvAY+jhLBxNCo1nWXkhLSS5Oq+k5PuRSIYAf6krdeDrq2VWymSjL+/sdJ7MVJEfrZ5QBDRTPZYPJOLXWArvEnrUngxVEs4FxHg1bgo1JQPQmuJFPOUPUTu3vStYc8GUDu1tVa0gl48iU24ZEscxRoGPm7fAXlpxgxPPRkzNfSNdbg9Datq3ozMYzVpDQyWD7UGrZbbtU4ILgbHdxYdzzdHP1IGnXJwnhnWZQSNqO6ecUJcK038y5Pey8DkGXVmReerVfKM4UPDHBvOO8hmjfNKejO8cnv6kcK28TAWAuodfJyeUu05hMb6Iz4ZNjXxWQAoDH/CL/d/5dVbTtbfJGj+kKIAf0NcxuF+p4jq5r484Ao+XE5EjwbPaeL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(478600001)(44832011)(2906002)(7696005)(4326008)(54906003)(7416002)(71200400001)(316002)(86362001)(9686003)(55016002)(6506007)(8936002)(83380400001)(53546011)(76116006)(26005)(66946007)(66476007)(52536014)(186003)(64756008)(66446008)(66556008)(33656002)(8676002)(5660300002)(6916009)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: b36kqd6BwxxjPSvXlnA9njrn9Ax2gDWLpbjn4KBaAnn7aXTgjPXvaPvgTkVNduKlii4AFILSjbWXjJspPdOnmrnJagj/AsT/8mm2RGAgAOaEY0y+L9qMdjxH7SZzacv1WuMNxUwsyhkwXmI4aTTi/r/9w4t+7S0fk8aCJcnoqOnaDa6FA1XSTvq0xZOjkpO6+FT28UVLlduyr/QS/cEhr5MwnZkwucb5ZMmLUcP6CM8TLumPiN/sCk1EIYCYqYw9xYFIqkj4DyJQO5KwL1pw48/XUFEHXinKiQCGbS/n5GaKHq1x9lAbF2TDN1uHyN8pkeyhCIeFjkuO6PZj5ZtxRZy5oadTgjng9aVJ77076my1TAsVH31BgxE9/1W74u0vUQd5jGhtOt5x93jkeLoCCyqgIGlZjLoWs552KdQ536EdoKqouHbAIpA/cM5DPp13LFUwzD9yOYR8KbsSLOEtJJ8DvLMB2xnphXK2519BVt8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c150f849-47fd-4b9a-aae4-08d8181f8f4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 09:18:29.8654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ViZPvoXn88vXWIK7YfLNV8LMi/st1QhvjipW9SK7Hb0P584vpm10KXjvG4iW03qSs/YX9acTBubr7tWfdYm+Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPiBTZW50OiBXZWRuZXNkYXks
IEp1bmUgMjQsIDIwMjAgMzo0NyBQTQ0KPiANCj4gT24gV2VkLCBKdW4gMjQsIDIwMjAgYXQgNDox
OSBBTSBBaXNoZW5nIERvbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KPiB3cm90ZToNCj4gPiA+
IElzbid0IHRoYXQgd2hhdCB3ZSB3YW50Pw0KPiA+DQo+ID4gTm8sIGlmIHVzZXIgc2V0IE1YQ19D
TEsgdG8gbSwgdGhlIGJ1aWxkIHdpbGwgYnJlYWsgZm9yIGkuTVg2JjcuDQo+ID4NCj4gPiA+IFdo
eSBkb2VzIEFSQ0hfTVhDIGJlaW5nIGVuYWJsZWQgbWFuZGF0ZSB0aGF0IGl0IGlzIGJ1aWx0aW4/
IElzIHNvbWUNCj4gPiA+IGFyY2hpdGVjdHVyZSBsZXZlbCBjb2RlIGNhbGxpbmcgaW50byB0aGUg
Y2xrIGRyaXZlcj8NCj4gPg0KPiA+DQo+ID4gSXQncyBtYWlubHkgYmVjYXVzZSB0aGVyZSdzIG5v
IEtjb25maWcgb3B0aW9ucyBmb3IgaS5NWDYgJjcgY2xvY2sgZHJpdmVycy4NCj4gPiBJdCBqdXN0
IHJldXNlcyBBUkNIIGNvbmZpZyBDT05GSUdfU09DX1hYWCB3aGljaCBjYW4gb25seSBiZSB5Lg0K
PiA+IGUuZy4NCj4gPiBvYmotJChDT05GSUdfU09DX0lNWDZRKSAgKz0gY2xrLWlteDZxLm8NCj4g
PiBvYmotJChDT05GSUdfU09DX0lNWDZTTCkgKz0gY2xrLWlteDZzbC5vDQo+ID4gb2JqLSQoQ09O
RklHX1NPQ19JTVg3VUxQKSArPSBjbGstaW14N3VscC5vDQo+ID4gb2JqLSQoQ09ORklHX1NPQ19W
RjYxMCkgICs9IGNsay12ZjYxMC5vIC4uDQo+ID4NCj4gPiBJZiBzZXR0aW5nIE1YQ19DTEsgdG8g
bSwgdGhlIHBsYXRmb3JtIGNsb2NrIGRyaXZlcnMgd2lsbCBmYWlsIHRvIGJ1aWxkDQo+ID4gZHVl
IHRvIG1pc3MgdG8gZmluZCBzeW1ib2xzIGRlZmluZWQgaW4gdGhlIGNvbW1vbiBjbG9jayBsaWJy
YXJ5IGJ5DQo+IENPTkZJR19NWENfQ0xLLg0KPiA+IFNvIHdlIGhhdmUgdG8gYXZvaWQgdXNlcnMg
dG8gYmUgYWJsZSB0byBjb25maWcgTVhDX0NMSyB0byBtIGZvciBpLk1YNiY3Lg0KPiA+IE9ubHkg
ZGVwZW5kcyBvbiBBUkNIX01YQyBtZWFuIHVzZXIgc3RpbGwgY2FuIHNldCBpdCB0byBtLg0KPiAN
Cj4gVGhlIGxpbmsgZXJyb3IgY2FuIGJlIGVhc2lseSBhdm9pZGVkIGJ5IGJ1aWxkaW5nIGFsbCB0
aGUgY2xrIHN1cHBvcnQgaW50byBhIHNpbmdsZQ0KPiBsb2FkYWJsZSBtb2R1bGUgbGlrZSBiZWxv
dy4NCj4gDQo+IEhvd2VyIHRoaXMgb25seSB3b3JrcyBpZiBhbGwgZHJpdmVycyB0aGF0IGhhdmUg
YSBydW50aW1lIGRlcGVuZGVuY3kgb24gdGhlIGNsaw0KPiBkcml2ZXIgc3VwcG9ydCBkZWZlcnJl
ZCBwcm9iaW5nIG9yIGFyZSBidWlsdCBhcyBsb2FkYWJsZSBtb2R1bGVzIGFzIHdlbGwgYW5kIGdl
dA0KPiBsb2FkZWQgYWZ0ZXIgdGhlIGNsayBkcml2ZXIuDQo+IA0KDQpUaGFua3MgZm9yIHRoZSBp
bmZvLg0KQ3VycmVudGx5IGFsbCBpLk1YNiY3L1ZGIGNsb2NrcyBkcml2ZXIgYXJlIG5vdCBsb2Fk
YWJsZSBtb2R1bGVzICh0aGV5J3JlIHVzaW5nIENMS19PRl9ERUNMQVJFKSwNCnNvIGNhbid0IGJl
IGJ1aWx0IGFzIG0uDQoNCklmIHdlIHJlYWxseSB3YW50IHRvIGJ1aWxkIGkuTVggY29tbW9uIGNs
b2NrIGxpYnJhcmllcyBpbnRvIG1vZHVsZSwgSSBndWVzcyB0aGUgZWFzaWVzdCB3YXkNCklzIGFz
IHdoYXQgUGF0Y2ggWzIvOV0gZG9lcywgc2VsZWN0IGl0IGJ5IEFSQ0hfTVhDLg0KVGhlbiB1c2Vy
cyBoYXZlIG5vIGNoYW5jZSB0byBidWlsZCBpdCBhcyBtb2R1bGUsIHNvIG5vIGJ1aWxkIGlzc3Vl
cy4NCg0KUmVnYXJkcw0KQWlzaGVuZw0KDQo+ICAgICAgQXJuZA0KPiANCj4gODwtLS0NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9NYWtlZmlsZSBiL2RyaXZlcnMvY2xrL2lteC9NYWtl
ZmlsZSBpbmRleA0KPiA5MjhmODc0YzczZDIuLjYzOGJjMDBmNTczMSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9jbGsvaW14L01ha2VmaWxlDQo+ICsrKyBiL2RyaXZlcnMvY2xrL2lteC9NYWtlZmls
ZQ0KPiBAQCAtMSw2ICsxLDggQEANCj4gICMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjANCj4gDQo+IC1vYmotJChDT05GSUdfTVhDX0NMSykgKz0gXA0KPiArb2JqLSQoQ09ORklHX01Y
Q19DTEspIDo9IGNsay1pbXgua28NCj4gKw0KPiArY2xrLWlteC15ICs9IFwNCj4gICAgICAgICBj
bGsubyBcDQo+ICAgICAgICAgY2xrLWJ1c3kubyBcDQo+ICAgICAgICAgY2xrLWNvbXBvc2l0ZS04
bS5vIFwNCj4gQEAgLTI1LDI0ICsyNywyNCBAQCBvYmotJChDT05GSUdfTVhDX0NMS19TQ1UpICs9
IFwNCj4gICAgICAgICBjbGstc2N1Lm8gXA0KPiAgICAgICAgIGNsay1scGNnLXNjdS5vDQo+IA0K
PiAtb2JqLSQoQ09ORklHX0NMS19JTVg4TU0pICs9IGNsay1pbXg4bW0ubw0KPiAtb2JqLSQoQ09O
RklHX0NMS19JTVg4TU4pICs9IGNsay1pbXg4bW4ubw0KPiAtb2JqLSQoQ09ORklHX0NMS19JTVg4
TVApICs9IGNsay1pbXg4bXAubw0KPiAtb2JqLSQoQ09ORklHX0NMS19JTVg4TVEpICs9IGNsay1p
bXg4bXEubw0KPiAtb2JqLSQoQ09ORklHX0NMS19JTVg4UVhQKSArPSBjbGstaW14OHF4cC5vIGNs
ay1pbXg4cXhwLWxwY2cubw0KPiArY2xrLWlteC0kKENPTkZJR19DTEtfSU1YOE1NKSArPSBjbGst
aW14OG1tLm8NCj4gK2Nsay1pbXgtJChDT05GSUdfQ0xLX0lNWDhNTikgKz0gY2xrLWlteDhtbi5v
DQo+ICtjbGstaW14LSQoQ09ORklHX0NMS19JTVg4TVApICs9IGNsay1pbXg4bXAubw0KPiArY2xr
LWlteC0kKENPTkZJR19DTEtfSU1YOE1RKSArPSBjbGstaW14OG1xLm8NCj4gK2Nsay1pbXgtJChD
T05GSUdfQ0xLX0lNWDhRWFApICs9IGNsay1pbXg4cXhwLm8gY2xrLWlteDhxeHAtbHBjZy5vDQo+
IA0KPiAtb2JqLSQoQ09ORklHX1NPQ19JTVgxKSAgICs9IGNsay1pbXgxLm8NCj4gLW9iai0kKENP
TkZJR19TT0NfSU1YMjEpICArPSBjbGstaW14MjEubw0KPiAtb2JqLSQoQ09ORklHX1NPQ19JTVgy
NSkgICs9IGNsay1pbXgyNS5vDQo+IC1vYmotJChDT05GSUdfU09DX0lNWDI3KSAgKz0gY2xrLWlt
eDI3Lm8NCj4gLW9iai0kKENPTkZJR19TT0NfSU1YMzEpICArPSBjbGstaW14MzEubw0KPiAtb2Jq
LSQoQ09ORklHX1NPQ19JTVgzNSkgICs9IGNsay1pbXgzNS5vDQo+IC1vYmotJChDT05GSUdfU09D
X0lNWDUpICAgKz0gY2xrLWlteDUubw0KPiAtb2JqLSQoQ09ORklHX1NPQ19JTVg2USkgICs9IGNs
ay1pbXg2cS5vDQo+IC1vYmotJChDT05GSUdfU09DX0lNWDZTTCkgKz0gY2xrLWlteDZzbC5vDQo+
IC1vYmotJChDT05GSUdfU09DX0lNWDZTTEwpICs9IGNsay1pbXg2c2xsLm8NCj4gLW9iai0kKENP
TkZJR19TT0NfSU1YNlNYKSArPSBjbGstaW14NnN4Lm8NCj4gLW9iai0kKENPTkZJR19TT0NfSU1Y
NlVMKSArPSBjbGstaW14NnVsLm8NCj4gLW9iai0kKENPTkZJR19TT0NfSU1YN0QpICArPSBjbGst
aW14N2Qubw0KPiAtb2JqLSQoQ09ORklHX1NPQ19JTVg3VUxQKSArPSBjbGstaW14N3VscC5vDQo+
IC1vYmotJChDT05GSUdfU09DX1ZGNjEwKSAgKz0gY2xrLXZmNjEwLm8NCj4gK2Nsay1pbXgtJChD
T05GSUdfU09DX0lNWDEpICAgKz0gY2xrLWlteDEubw0KPiArY2xrLWlteC0kKENPTkZJR19TT0Nf
SU1YMjEpICArPSBjbGstaW14MjEubw0KPiArY2xrLWlteC0kKENPTkZJR19TT0NfSU1YMjUpICAr
PSBjbGstaW14MjUubw0KPiArY2xrLWlteC0kKENPTkZJR19TT0NfSU1YMjcpICArPSBjbGstaW14
Mjcubw0KPiArY2xrLWlteC0kKENPTkZJR19TT0NfSU1YMzEpICArPSBjbGstaW14MzEubw0KPiAr
Y2xrLWlteC0kKENPTkZJR19TT0NfSU1YMzUpICArPSBjbGstaW14MzUubw0KPiArY2xrLWlteC0k
KENPTkZJR19TT0NfSU1YNSkgICArPSBjbGstaW14NS5vDQo+ICtjbGstaW14LSQoQ09ORklHX1NP
Q19JTVg2USkgICs9IGNsay1pbXg2cS5vDQo+ICtjbGstaW14LSQoQ09ORklHX1NPQ19JTVg2U0wp
ICs9IGNsay1pbXg2c2wubw0KPiArY2xrLWlteC0kKENPTkZJR19TT0NfSU1YNlNMTCkgKz0gY2xr
LWlteDZzbGwubw0KPiArY2xrLWlteC0kKENPTkZJR19TT0NfSU1YNlNYKSArPSBjbGstaW14NnN4
Lm8NCj4gK2Nsay1pbXgtJChDT05GSUdfU09DX0lNWDZVTCkgKz0gY2xrLWlteDZ1bC5vDQo+ICtj
bGstaW14LSQoQ09ORklHX1NPQ19JTVg3RCkgICs9IGNsay1pbXg3ZC5vDQo+ICtjbGstaW14LSQo
Q09ORklHX1NPQ19JTVg3VUxQKSArPSBjbGstaW14N3VscC5vDQo+ICtjbGstaW14LSQoQ09ORklH
X1NPQ19WRjYxMCkgICs9IGNsay12ZjYxMC5vDQo=
