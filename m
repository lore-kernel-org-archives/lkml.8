Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E68C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 02:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BD7E20E65
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 02:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Oh5d6HrL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388570AbgFXC3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 22:29:48 -0400
Received: from mail-am6eur05on2075.outbound.protection.outlook.com ([40.107.22.75]:2753
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388526AbgFXC3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 22:29:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hl/RJCfC10UIm4Zap4Jg/zT3JguRUt9B6G8axRS606pTkfSCqhl5z1psNmXzqRkl6LVt65E1spY4biEzPnm5s/v3AzD5KmcH23HGvSTjWLGQ4HoMr7G7ri9+kXVAV48ViX3xylr2fGT1N2xp39P38Y+RwJtT/5HTPIb1IvI/KAM/922V9a5ftoiHhz6XzVNVtJJrGFxstvXOX2z3S3WzkAkIuQhzZEIajNLmoSAo3VJ6QQkCiBb8bOpBOmmvCxf6XLIyJt5PPlNmU1saU0ta4yNZg8F3PwUMD0nF5l3Qtk8k7SWMbyYl7k8Mx/axZGk0W/B7TpMgYMqC2GEtWZXWkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkuplaufq4eeSfWdONnErJqumr2c0/bQ7n7m55GgpOA=;
 b=GHAO0pfU17u+1g112GUyn1R3Q+28UVfQ32d+e1wgYsOHQUvW+/9yE82VxbDLLoexoeK/XWynonQqlASn3I35ubJktqLMwru3iKKM8ITBzCaZ9S7pfRb415wzT8WKCtnHBcTJ/MeXJG8KnXohLZ5ARmTfIo0HnF3i+Wm+WIoShMe56K3rkUoar7r42zFHQljv/qcG/qK1s2974hcw6d+E1wA5+Kkt2/S254iFJqFFPEz4W0KCHq231M6dnihQxifYcnQjLu9/enmvPPzg1p8T6Hjdr/p22tnlhdQcODllUjSlRrTSOA6tALdRBIrYuut+IAcNIBZLECxFbIcy9BAsQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkuplaufq4eeSfWdONnErJqumr2c0/bQ7n7m55GgpOA=;
 b=Oh5d6HrL5h94zPNapyYT6l+yLdWiUxaG4+nQEEIEEC6m6a6+c8igJNxVxm5VtSItIAZrfGWgxJsWaJOqPx1lUcSjVPMHYRx9HN26fHG6DGQxaGjGAkeDJQfALey4kMOo2AjaF7TgABzkOA8tONX854yYIkbUx8sT/OlYBbydfzM=
Received: from VE1PR04MB6768.eurprd04.prod.outlook.com (2603:10a6:803:129::26)
 by VE1PR04MB6605.eurprd04.prod.outlook.com (2603:10a6:803:124::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 24 Jun
 2020 02:29:42 +0000
Received: from VE1PR04MB6768.eurprd04.prod.outlook.com
 ([fe80::48b0:7f65:3d24:7733]) by VE1PR04MB6768.eurprd04.prod.outlook.com
 ([fe80::48b0:7f65:3d24:7733%7]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 02:29:42 +0000
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [RESEND PATCH] arm64: dts: ls1028a: Add DSPI nodes
Thread-Topic: [RESEND PATCH] arm64: dts: ls1028a: Add DSPI nodes
Thread-Index: AQHWSHA0e6hoaKFjZEKBoKtNx3KlU6jm1oqAgAA2j6A=
Date:   Wed, 24 Jun 2020 02:29:42 +0000
Message-ID: <VE1PR04MB6768816DF1ABD1FDAF23F18A91950@VE1PR04MB6768.eurprd04.prod.outlook.com>
References: <20200622082909.42254-1-qiang.zhao@nxp.com>
 <AM0PR04MB667637011B99FCC3883AC5A78F940@AM0PR04MB6676.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB667637011B99FCC3883AC5A78F940@AM0PR04MB6676.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 99a24353-4be6-4673-b136-08d817e673ce
x-ms-traffictypediagnostic: VE1PR04MB6605:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6605F6EDEA240296B21B8C5391950@VE1PR04MB6605.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ru20B+XDJ35Ba7PNcKndqcatApdusaTYL0feaz6PClB1K3WPQR7JAq+dsQh6XzbCN/bkZpkjJI4iBfAnpabO2DW6Ue2whh2trNg4Me2qrkS7Xem3onp+B56E6BAARzt4DeEMcwIZKqXruGuA22RIT9bTlfxK/szkLvlpb0nzKjqWLNj/5f0yz/BAofFfJABX7+3AAzICz6+9GV0eVQKn8oAt9hwgrqDgkg01sCRTS2hcJz0Ocna+DPl73XF+j4VM8Hv5elIqYeiBz8Nrj4YWDxUtSLU9QzKaITiLgdWpb6KIZxcr1e3wLhOB6x+hcqyq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6768.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(186003)(44832011)(54906003)(316002)(64756008)(110136005)(66556008)(66446008)(76116006)(66476007)(66946007)(9686003)(478600001)(83380400001)(71200400001)(33656002)(8676002)(2906002)(5660300002)(4326008)(52536014)(55016002)(8936002)(6506007)(7696005)(53546011)(86362001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: S16dexbeL818ylCu4ANT0MLYZLqz4sQf0s+aSbnHB1eBcyCt3gDhsm8tTpkIo37tDvA/aYJXYyCvECHXsXLxeyS8N6GuiTK9k2jDybGLNbSzGhoAmKqqgax9+fV/sJ64kD2Fm6Jhll4cvDlyQQPWGgWeHxyDoGMUPgFFlJEDlVUs6R/WOg+O0HoaDFZsdGUY1fjPDLdqL84glLa/ue1vqkyCLspKdgSy4ZYLeP0bfOhv3bfaF/xaIDPSZf0NIQWYVcKa98JkmzsUxFLwUlnETN+raA/W+u1ipdGtqnK8TYSuYt0A/7k19jM5c0e9ouCnUVOXPW26EeodxysVYrhPV3CzZDOMbd7ZFz1eO8bVSKa39c0Hb1RyprmGxOQUcqgD20Ou798hbspp9d5vpTbrqBoPsHgE9n+RISDQdcymNE0sewpeoqN8Sf0YZbKRmvkp9d8WU2bemx0cEdmPnl4GZcvGLSQblzGJmQryhlbik0Y=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a24353-4be6-4673-b136-08d817e673ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 02:29:42.4408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +WWlmWWSWN+YwSNsOSR95Vxd9EL0IWN2gUuX/U6MY49Lftr59O2A2hC1rIAw0s1LkIAJzuNQC+ba8nUk8Kkc8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6605
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMC82LzI0LCBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT4gd3JvdGU6DQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGVvIExpIDxsZW95YW5nLmxpQG54cC5j
b20+DQo+IFNlbnQ6IDIwMjDE6jbUwjI0yNUgNzoxMg0KPiBUbzogUWlhbmcgWmhhbyA8cWlhbmcu
emhhb0BueHAuY29tPjsgc2hhd25ndW9Aa2VybmVsLm9yZw0KPiBDYzogZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFFpYW5nIFpoYW8NCj4g
PHFpYW5nLnpoYW9AbnhwLmNvbT47IFhpYW93ZWkgQmFvIDx4aWFvd2VpLmJhb0BueHAuY29tPg0K
PiBTdWJqZWN0OiBSRTogW1JFU0VORCBQQVRDSF0gYXJtNjQ6IGR0czogbHMxMDI4YTogQWRkIERT
UEkgbm9kZXMNCj4gDQo+IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
IEZyb206IFFpYW5nIFpoYW8gPHFpYW5nLnpoYW9AbnhwLmNvbT4NCj4gPiBTZW50OiBNb25kYXks
IEp1bmUgMjIsIDIwMjAgMzoyOSBBTQ0KPiA+IFRvOiBzaGF3bmd1b0BrZXJuZWwub3JnDQo+ID4g
Q2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBMZW8gTGkNCj4gPiA8bGVveWFuZy5saUBueHAuY29tPjsgUWlhbmcgWmhhbyA8cWlhbmcu
emhhb0BueHAuY29tPjsgWGlhb3dlaSBCYW8NCj4gPiA8eGlhb3dlaS5iYW9AbnhwLmNvbT4NCj4g
PiBTdWJqZWN0OiBbUkVTRU5EIFBBVENIXSBhcm02NDogZHRzOiBsczEwMjhhOiBBZGQgRFNQSSBu
b2Rlcw0KPiANCj4gVGhpcyBwYXRjaCBpcyBhY3R1YWxseSBkZWZpbmluZyBkc3BpIGZsYXNoIG5v
ZGVzIGZvciBMUzEwMjhhLXFkcyBib2FyZCBpbnN0ZWFkDQo+IG9mIGFkZGluZyBkc3BpIG5vZGVz
IGZvciB0aGUgc29jLg0KDQpUaGFuayB5b3UhIFdpbGwgY29ycmVjdCBuZXh0IHZlcnNpb24uIA0K
DQo+IA0KPiA+DQo+ID4gRnJvbTogWGlhb3dlaSBCYW8gPHhpYW93ZWkuYmFvQG54cC5jb20+DQo+
ID4NCj4gPiBBZGQgdGhlIERTUEkgbm9kZXMgZm9yIGxzMTAyOGEuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBYaWFvd2VpIEJhbyA8eGlhb3dlaS5iYW9AbnhwLmNvbT4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBaaGFvIFFpYW5nIDxxaWFuZy56aGFvQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLXFkcy5kdHMgfCA4NQ0KPiA+ICsr
KysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4NSBpbnNlcnRpb25z
KCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
ZnNsLWxzMTAyOGEtcWRzLmR0cw0KPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
ZnNsLWxzMTAyOGEtcWRzLmR0cw0KPiA+IGluZGV4IGRkNjljNWIuLmU0ZjAwYzIgMTAwNjQ0DQo+
ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEtcWRzLmR0
cw0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLXFk
cy5kdHMNCj4gPiBAQCAtMTA3LDYgKzEwNyw5MSBAQA0KPiA+ICAJfTsNCj4gPiAgfTsNCj4gPg0K
PiA+ICsmZHNwaTAgew0KPiA+ICsJYnVzLW51bSA9IDwwPjsNCj4gPiArCXN0YXR1cyA9ICJva2F5
IjsNCj4gPiArDQo+ID4gKwlmbGFzaEAwIHsNCj4gPiArCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsN
Cj4gPiArCQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4gPiArCQljb21wYXRpYmxlID0gImplZGVjLHNw
aS1ub3IiOw0KPiA+ICsJCXNwaS1jcG9sOw0KPiA+ICsJCXNwaS1jcGhhOw0KPiA+ICsJCXJlZyA9
IDwwPjsNCj4gPiArCQlzcGktbWF4LWZyZXF1ZW5jeSA9IDwxMDAwMDAwMD47DQo+ID4gKwl9Ow0K
PiA+ICsNCj4gPiArCWZsYXNoQDEgew0KPiA+ICsJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+
ICsJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiA+ICsJCWNvbXBhdGlibGUgPSAiamVkZWMsc3BpLW5v
ciI7DQo+ID4gKwkJc3BpLWNwb2w7DQo+ID4gKwkJc3BpLWNwaGE7DQo+ID4gKwkJcmVnID0gPDE+
Ow0KPiA+ICsJCXNwaS1tYXgtZnJlcXVlbmN5ID0gPDEwMDAwMDAwPjsNCj4gPiArCX07DQo+ID4g
Kw0KPiA+ICsJZmxhc2hAMiB7DQo+ID4gKwkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gKwkJ
I3NpemUtY2VsbHMgPSA8MT47DQo+ID4gKwkJY29tcGF0aWJsZSA9ICJqZWRlYyxzcGktbm9yIjsN
Cj4gPiArCQlzcGktY3BvbDsNCj4gPiArCQlzcGktY3BoYTsNCj4gPiArCQlyZWcgPSA8Mj47DQo+
ID4gKwkJc3BpLW1heC1mcmVxdWVuY3kgPSA8MTAwMDAwMDA+Ow0KPiA+ICsJfTsNCj4gPiArfTsN
Cj4gPiArDQo+ID4gKyZkc3BpMSB7DQo+ID4gKwlidXMtbnVtID0gPDE+Ow0KPiA+ICsJc3RhdHVz
ID0gIm9rYXkiOw0KPiA+ICsNCj4gPiArCWZsYXNoQDAgew0KPiA+ICsJCSNhZGRyZXNzLWNlbGxz
ID0gPDE+Ow0KPiA+ICsJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiANCj4gVGhlc2UgcHJvYmFibHkg
YXJlIG5vdCBuZWVkZWQgd2hlbiBubyBzdWIgbm9kZXMgYXJlIGRlZmluZWQuDQo+IA0KPiA+ICsJ
CWNvbXBhdGlibGUgPSAiamVkZWMsc3BpLW5vciI7DQo+ID4gKwkJc3BpLWNwb2w7DQo+ID4gKwkJ
c3BpLWNwaGE7DQo+ID4gKwkJcmVnID0gPDA+Ow0KPiA+ICsJCXNwaS1tYXgtZnJlcXVlbmN5ID0g
PDEwMDAwMDAwPjsNCj4gPiArCX07DQo+ID4gKw0KPiA+ICsJZmxhc2hAMSB7DQo+ID4gKwkJI2Fk
ZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gKwkJI3NpemUtY2VsbHMgPSA8MT47DQo+ID4gKwkJY29t
cGF0aWJsZSA9ICJqZWRlYyxzcGktbm9yIjsNCj4gPiArCQlzcGktY3BvbDsNCj4gPiArCQlzcGkt
Y3BoYTsNCj4gPiArCQlyZWcgPSA8MT47DQo+ID4gKwkJc3BpLW1heC1mcmVxdWVuY3kgPSA8MTAw
MDAwMDA+Ow0KPiA+ICsJfTsNCj4gPiArDQo+ID4gKwlmbGFzaEAyIHsNCj4gPiArCQkjYWRkcmVz
cy1jZWxscyA9IDwxPjsNCj4gPiArCQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4gPiArCQljb21wYXRp
YmxlID0gImplZGVjLHNwaS1ub3IiOw0KPiA+ICsJCXNwaS1jcG9sOw0KPiA+ICsJCXNwaS1jcGhh
Ow0KPiA+ICsJCXJlZyA9IDwyPjsNCj4gPiArCQlzcGktbWF4LWZyZXF1ZW5jeSA9IDwxMDAwMDAw
MD47DQo+ID4gKwl9Ow0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArJmRzcGkyIHsNCj4gPiArCWJ1cy1u
dW0gPSA8Mj47DQo+ID4gKwlzdGF0dXMgPSAib2theSI7DQo+ID4gKw0KPiA+ICsJZmxhc2hAMCB7
DQo+ID4gKwkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gKwkJI3NpemUtY2VsbHMgPSA8MT47
DQo+ID4gKwkJY29tcGF0aWJsZSA9ICJqZWRlYyxzcGktbm9yIjsNCj4gPiArCQlzcGktY3BvbDsN
Cj4gPiArCQlzcGktY3BoYTsNCj4gPiArCQlyZWcgPSA8MD47DQo+ID4gKwkJc3BpLW1heC1mcmVx
dWVuY3kgPSA8MTAwMDAwMDA+Ow0KPiA+ICsJfTsNCj4gPiArfTsNCj4gPiArDQo+ID4gICZkdWFy
dDAgew0KPiA+ICAJc3RhdHVzID0gIm9rYXkiOw0KPiA+ICB9Ow0KPiA+IC0tDQo+ID4gMi43LjQN
Cg0KQmVzdCBSZWdhcmRzDQpRaWFuZyBaaGFvDQo=
