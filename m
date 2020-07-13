Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5557FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F40920722
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="poSvg9IU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgGMCna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:43:30 -0400
Received: from mail-db8eur05on2058.outbound.protection.outlook.com ([40.107.20.58]:6166
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725892AbgGMCn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 22:43:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kL8uPcBbvAiAoHIHfKQ4larykC2JoaqK0jdGd2lJA4gSYWcOW6zySL7K4mt+H4F3509R9NnUIjKcIv6lwmUu9U+/duh8TALbOIb2OT8LDxTIP/KUglBioELP+ohhfax/w8WH3lO0kvlDPR9IxYXoInLLnNIENsPn/KcAZ9o9LKJTEjIZa2Qyd8+HM0oc4bKQQJf+TQcR49hn6R57kU6rXabvlhiN0rIIuVE/oYt/JLayTNg1opa2jGNOkBIjrQZDaqoZGx+RATXo7gqjGbVAz20VbOqhnNxyjOJ+5SXgb4wXewv+frnnlmv1zz8w212dDyIqLnFbP1Dd2CmNS2EPxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=391kPGVLd72yUWLZHuSeuJMm2bTaXN/YQbrAM4ZakOU=;
 b=WGMTQgRW2gnzjaZDjYMqwcrST7M+JHQrXNk29nmwmrDwlfjRY1FLUbFxgmwf/45ltcoCwQIxZe21Qv8ltWmQjYyHhHoYM9w5L+zkE4jHyTywihOz7k2xJfWEq4ICQqtrd1/EwKXmqmPnOMQrTd6QILsvSext4FtnKZBcgvWe5mAtNk9ZuI8sc5PKFypMglI+Vth9n6lX+CNEzF6VKYEVZuonhvxHKgB1wirRp6+fmWPGHncPgaV/bJjlaX/UhLimLcuefwEOCPshk8sa/t3pIYMD6OSyXpkZE5G2ElkEdT7iT4uyomqQmjesM7zkl336V3CBW6N3k3Vwha+VDhaKGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=391kPGVLd72yUWLZHuSeuJMm2bTaXN/YQbrAM4ZakOU=;
 b=poSvg9IUNj8J50GejIquOfxx8pb6/dPP+u3dytYAFNVHrbQLsO10px7p44ENYPhlmZUkAWRt5jMVKOFWz+ycYrVNlzw7vvhJRxjE2swhaYYp59TQNOcFMX3kraYRadFGyk3ItviHH37GvlbBOLDFiUXPlVEPwuCV0UmqgEPGZ7w=
Received: from VE1PR04MB6768.eurprd04.prod.outlook.com (2603:10a6:803:129::26)
 by VI1PR0402MB3853.eurprd04.prod.outlook.com (2603:10a6:803:16::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Mon, 13 Jul
 2020 02:43:24 +0000
Received: from VE1PR04MB6768.eurprd04.prod.outlook.com
 ([fe80::9149:1826:669a:4d6f]) by VE1PR04MB6768.eurprd04.prod.outlook.com
 ([fe80::9149:1826:669a:4d6f%7]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 02:43:24 +0000
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        Chuanhua Han <chuanhua.han@nxp.com>
Subject: RE: [RESEND PATCH 1/2] arm64: dts: lx2160a: add dspi controller DT
 nodes
Thread-Topic: [RESEND PATCH 1/2] arm64: dts: lx2160a: add dspi controller DT
 nodes
Thread-Index: AQHWSHBMeS+h15IFnkmI5bwfeXsC2akCjMqAgAJfh7A=
Date:   Mon, 13 Jul 2020 02:43:23 +0000
Message-ID: <VE1PR04MB6768FC3E6C7E9529CF67517591600@VE1PR04MB6768.eurprd04.prod.outlook.com>
References: <20200622083109.3441-1-qiang.zhao@nxp.com>
 <20200711142322.GI21277@dragon>
In-Reply-To: <20200711142322.GI21277@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f49a8b01-58c7-4b8c-a77f-08d826d68356
x-ms-traffictypediagnostic: VI1PR0402MB3853:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB3853FF4913DAD3E2BCFC973E91600@VI1PR0402MB3853.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 62pi/Bx+YD92qZqJDRxFtz1fRyEW9CXtahzr9rl9wsvZpbxLQupFfFmar/CdPLicLtjjdkBVXrIDOabK+iKPwtR2LJS0cAvXOvWmFg6oGdupWEvDPmx0BDex9hC2hIzKGQZraRMJXwU/p46LvtR5znJ0CWu1BXSDHRvfN8UvkfBcb4T5WBNFKkXvvMMUPSDeFlQO+fUgXEZDUQKKIssPfVSgysetR55S6HRfWwU6qgorrcw5eyCMushmOmEHeFdRhGZmpdL7lALaWw6wja+NtOw5QPPaZLbBr80iSAaEfSE7YjsAAorVINuEHIU5eyqr3Q7o8naw1YtllGrtjMuKxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6768.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(8936002)(5660300002)(33656002)(478600001)(54906003)(7696005)(86362001)(8676002)(83380400001)(4326008)(6916009)(2906002)(26005)(6506007)(55016002)(52536014)(64756008)(66446008)(66946007)(316002)(66556008)(66476007)(44832011)(186003)(53546011)(9686003)(76116006)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: e0SLPBRDhwbHlSNGQ4BbFp0Py4UgnfC00wJz88iD4VVNQ/hsh/BoX0TMSa/46oGJqpTa5EMrbYZ8BdVkqWKt9ZbcGmuClgx5k1W9/4HhHq1Pr0FGHR802xzT1vcCeMGrIzkT8O4tMmQEca9cJ79DtDgfhbYKdYO6i2MUxlVRXMsb9VsIg6PvxFLi3krfE9s3I01dP4gbA5A3V1Fr2Y7kXadWmojNZC15DEauUcEZKY6Xa84l7v3gIVuTmY8RavO4DQNYeBGhmNSHspqoC+Bu/q0gQTYwcGLNYgi+soOnOAka+FrxpXzpTwgUwV3fs86vLbt1ZWGWoxa4ElPvV/hjMSsQzImEOmWLyS3ZSAiyYzxUfox1gSuEZcQs5BgaTF/W9lY58BwUfhta1l99HUAr9UDFJYX4IE8BJrmqk36ap71P+mRs6eZb+c5Ayuadwk8ZcxJL117ji/oq4cgxxCZQWYrTT/dMgs3sHUeXxbtHh34=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6768.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f49a8b01-58c7-4b8c-a77f-08d826d68356
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 02:43:23.9667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZiE+n9pTsRcrPyD2cx0VflE/ONP00tbhFnJIH2BvDoo1hk7lp+JQrbFV6vOryBFOjFVvHG8HKDmA8n2NkBPQUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3853
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBKdWx5IDExLCAyMDIwIGF0IDIyOjIzUE0gKzA4MDAsIFNoYXduIEd1byA8c2hhd25n
dW9Aa2VybmVsLm9yZz4gd3JvdGU6DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIwxOo31MIx
McjVIDIyOjIzDQo+IFRvOiBRaWFuZyBaaGFvIDxxaWFuZy56aGFvQG54cC5jb20+DQo+IENjOiBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
TGVvIExpDQo+IDxsZW95YW5nLmxpQG54cC5jb20+OyBDaHVhbmh1YSBIYW4gPGNodWFuaHVhLmhh
bkBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1JFU0VORCBQQVRDSCAxLzJdIGFybTY0OiBkdHM6
IGx4MjE2MGE6IGFkZCBkc3BpIGNvbnRyb2xsZXIgRFQNCj4gbm9kZXMNCj4gDQo+IE9uIE1vbiwg
SnVuIDIyLCAyMDIwIGF0IDA0OjMxOjA4UE0gKzA4MDAsIFFpYW5nIFpoYW8gd3JvdGU6DQo+ID4g
RnJvbTogQ2h1YW5odWEgSGFuIDxjaHVhbmh1YS5oYW5AbnhwLmNvbT4NCj4gPg0KPiA+IEFkZCB0
aGUgZHNwaSBzdXBwb3J0IG9uIGx4MjE2MA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1YW5o
dWEgSGFuIDxjaHVhbmh1YS5oYW5AbnhwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCYW8gWGlh
b3dlaSA8eGlhb3dlaS5iYW9AbnhwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIb3UgWmhpcWlh
bmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFpoYW8gUWlhbmcg
PHFpYW5nLnpoYW9AbnhwLmNvbT4NCj4gDQo+IFdoZW4geW91IHJlc2VuZCBwYXRjaGVzLCBwbGVh
c2Ugc3RhdGUgd2h5LiAgU2hvdWxkIEkgZHJvcCB0aGUgcGF0Y2hlcyBJIGp1c3QNCj4gYXBwbGll
ZCBhbmQgcGljayB1cCB0aGlzIHZlcnNpb24gaW5zdGVhZD8NCj4gDQpTb3JyeSBmb3IgdGhhdCwg
SSByZXNlbmQganVzdCBiZWNhdXNlIEkgZm9yZ290IHRvIGFkZCBteXNlbGYgaW4gY2MgbGlzdC4N
Cg0KPiANCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4
MjE2MGEuZHRzaSB8IDM5DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS5kdHNpDQo+ID4gYi9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS5kdHNpDQo+ID4gaW5kZXggYWJhZWI1
OC4uZjU2MTcyZiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9mc2wtbHgyMTYwYS5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvZnNsLWx4MjE2MGEuZHRzaQ0KPiA+IEBAIC03NzcsNiArNzc3LDQ1IEBADQo+ID4gIAkJCXN0
YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4gIAkJfTsNCj4gPg0KPiA+ICsJCWRzcGkwOiBzcGlAMjEw
MDAwMCB7DQo+ID4gKwkJCWNvbXBhdGlibGUgPSAiZnNsLGx4MjE2MGEtZHNwaSIsICJmc2wsbHMy
MDg1YS1kc3BpIjsNCj4gPiArCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gKwkJCSNzaXpl
LWNlbGxzID0gPDA+Ow0KPiA+ICsJCQlyZWcgPSA8MHgwIDB4MjEwMDAwMCAweDAgMHgxMDAwMD47
DQo+ID4gKwkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAyNiBJUlFfVFlQRV9MRVZFTF9ISUdIPjsN
Cj4gPiArCQkJY2xvY2tzID0gPCZjbG9ja2dlbiA0IDc+Ow0KPiA+ICsJCQljbG9jay1uYW1lcyA9
ICJkc3BpIjsNCj4gPiArCQkJc3BpLW51bS1jaGlwc2VsZWN0cyA9IDw1PjsNCj4gPiArCQkJYnVz
LW51bSA9IDwwPjsNCj4gPiArCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiArCQl9Ow0KPiA+
ICsNCj4gPiArCQlkc3BpMTogc3BpQDIxMTAwMDAgew0KPiA+ICsJCQljb21wYXRpYmxlID0gImZz
bCxseDIxNjBhLWRzcGkiLCAiZnNsLGxzMjA4NWEtZHNwaSI7DQo+ID4gKwkJCSNhZGRyZXNzLWNl
bGxzID0gPDE+Ow0KPiA+ICsJCQkjc2l6ZS1jZWxscyA9IDwwPjsNCj4gPiArCQkJcmVnID0gPDB4
MCAweDIxMTAwMDAgMHgwIDB4MTAwMDA+Ow0KPiA+ICsJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkg
MjYgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ID4gKwkJCWNsb2NrcyA9IDwmY2xvY2tnZW4gNCA3
PjsNCj4gPiArCQkJY2xvY2stbmFtZXMgPSAiZHNwaSI7DQo+ID4gKwkJCXNwaS1udW0tY2hpcHNl
bGVjdHMgPSA8NT47DQo+ID4gKwkJCWJ1cy1udW0gPSA8MT47DQo+ID4gKwkJCXN0YXR1cyA9ICJk
aXNhYmxlZCI7DQo+ID4gKwkJfTsNCj4gPiArDQo+ID4gKwkJZHNwaTI6IHNwaUAyMTIwMDAwIHsN
Cj4gPiArCQkJY29tcGF0aWJsZSA9ICJmc2wsbHgyMTYwYS1kc3BpIiwgImZzbCxsczIwODVhLWRz
cGkiOw0KPiA+ICsJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gPiArCQkJI3NpemUtY2VsbHMg
PSA8MD47DQo+ID4gKwkJCXJlZyA9IDwweDAgMHgyMTIwMDAwIDB4MCAweDEwMDAwPjsNCj4gPiAr
CQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDI0MSBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gPiAr
CQkJY2xvY2tzID0gPCZjbG9ja2dlbiA0IDc+Ow0KPiA+ICsJCQljbG9jay1uYW1lcyA9ICJkc3Bp
IjsNCj4gPiArCQkJc3BpLW51bS1jaGlwc2VsZWN0cyA9IDw1PjsNCj4gPiArCQkJYnVzLW51bSA9
IDwyPjsNCj4gPiArCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiArCQl9Ow0KPiA+ICsNCj4g
PiAgCQllc2RoYzA6IGVzZGhjQDIxNDAwMDAgew0KPiA+ICAJCQljb21wYXRpYmxlID0gImZzbCxl
c2RoYyI7DQo+ID4gIAkJCXJlZyA9IDwweDAgMHgyMTQwMDAwIDB4MCAweDEwMDAwPjsNCj4gPiAt
LQ0KPiA+IDIuNy40DQo+ID4NCg0KQmVzdCBSZWdhcmRzDQpRaWFuZyBaaGFvDQo=
