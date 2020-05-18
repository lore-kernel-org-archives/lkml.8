Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5F1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 03:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F28E820825
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 03:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A51oTY5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgERDkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 23:40:32 -0400
Received: from mail-am6eur05on2058.outbound.protection.outlook.com ([40.107.22.58]:6133
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726680AbgERDkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 23:40:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVTpS5DHURFpPrwyexOabaqDDFxFn21hXqbW05HISumyOh+91C4a8nj/IXV/ikUjAJRdP7Z4Sbr9+bcaxuiFecbgIcE2WyY1ACXOC2R06ML76C9/ClJ9zVMKL2J53f0Ts7jP8l4A/dMuFhVGQugazIXYpS9oIGRis3NtOlC4QZ+MoTV/uYgf4gBdF1r5yYy1EPZVu8HziqEa7snQyaVw/caOX8rvTS/7QmZwXsdPGRZeJmCbUvzKcw9J08NVSh2UHTwpecyZAgsm/oZOGatJ8s56j3OeLmu1jMTOLNYL2G82x4NC2fM0hj8Rw4p0yl30A/yH9DksrbLzT+0CSuYOWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCXY+WR981rC9J70Q/8erlOftz4+c4ZUOzJuCJW4kbs=;
 b=DZjzyoJ3sLIQ2tHs5POeO3Js0P0QwKSWTkAaSiLbSnv8f4ThGWwvJCgb6/MHLQa6c5RLTbqelDrrTWyP0NYExzyxr+ifw9gZGUS1pm1Bbt87PxEWvE6t95JbuzzZzUo/+jbdjPYtqKn9Tz4uvAgtLbg4JbgVLpQvdxKtNsK4OGlRiDjLM3/Y8adgtSSOvhEkT5QdGGsfEtKAgRO4tB/dDZbEW4waS7WERvZ4izpJHo1AwRVJ75LwPRiW9i/boaOf/zxbXqvI7ILXE+Buq2vyPke0E4wYvcceW5vACU+o/O+z1ehf0dWOqivHazciXlzkLPe1soSVyz0b15oHYg8awA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCXY+WR981rC9J70Q/8erlOftz4+c4ZUOzJuCJW4kbs=;
 b=A51oTY5qqTN/0Nd9EvFwHZ47u5iUxC1EMTMRspFtCsaSmRg9fENnjpWOtNbtvjWKo411eHwxx6YCxjuzyoKX8njnhbUQdYu+0G7KDOUO7fQCc9gwhFgdKAO2Ugt/0Q9/PLq5OBGuaYzB/dfApUbFGPtHHJsckL5IfQUHiiEB7wk=
Received: from VE1PR04MB6768.eurprd04.prod.outlook.com (2603:10a6:803:129::26)
 by VE1PR04MB6701.eurprd04.prod.outlook.com (2603:10a6:803:124::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Mon, 18 May
 2020 03:40:27 +0000
Received: from VE1PR04MB6768.eurprd04.prod.outlook.com
 ([fe80::48b0:7f65:3d24:7733]) by VE1PR04MB6768.eurprd04.prod.outlook.com
 ([fe80::48b0:7f65:3d24:7733%7]) with mapi id 15.20.3000.022; Mon, 18 May 2020
 03:40:27 +0000
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [patch v2 1/2] ls1043ardb: add qe node to ls1043ardb
Thread-Topic: [patch v2 1/2] ls1043ardb: add qe node to ls1043ardb
Thread-Index: AQHWHf+6WR0ydwyWgE+NfjSu7IxryqisbcIAgADdPoA=
Date:   Mon, 18 May 2020 03:40:27 +0000
Message-ID: <VE1PR04MB6768BB89F83787A8C6AAB2F791B80@VE1PR04MB6768.eurprd04.prod.outlook.com>
References: <20200429082052.18519-1-qiang.zhao@nxp.com>
 <20200517141011.GB25973@dragon>
In-Reply-To: <20200517141011.GB25973@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b79f715-3d49-4844-834a-08d7fadd34d0
x-ms-traffictypediagnostic: VE1PR04MB6701:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6701F2997CBA1EAC6434B06691B80@VE1PR04MB6701.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:972;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YpovD9nbwWtrnnKDYi3RleY8BYS6KERhqG/l3cZmmNI2Rl6up0/tbNXkgV+sIBm7vG/fCDJQTq5+vm+5Xb3JiEYWfnL5591gA27w3KZrg+nFxURIRrwOHOr5VZ0EOLPRAV1CBvteAPEvWhZkuDz9rGEiSLxG8xqPob5Y2L4GqDAm3gsPSWxUIpCqfAUvme1aWmiBqrilHb5Xvi7xQJGk65/uZyDyEYDandLTqEETAaMdxccWd7G5iG/9lyhAmgNCiw3ngL3QEhoGPDRvzVv5pjLsLhZhyLfqFTBqaycNzi9a1Ipwp9x464DbzlzPWv6Xa1AMlN15TkrlLBfR4wSE3vmA1G8rT4lxbeVSQwcphku6mTMNkdRxPDFLX6t85GT9kBQrJ9ni6FgevJp4Xjb4Fv/dz8XdRJB+ky0ZCOMuMc70RCVBdqXO9JPTEx7BAEse
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6768.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(366004)(186003)(6506007)(478600001)(9686003)(53546011)(64756008)(66446008)(52536014)(33656002)(66556008)(66476007)(26005)(44832011)(6916009)(8936002)(86362001)(55016002)(66946007)(5660300002)(8676002)(54906003)(7696005)(2906002)(71200400001)(76116006)(4326008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: rCfks8eSX+CGCa6q6h4B6rdilXqF0S1UQQOVc2lRiiE119XJBN9cGBSV4sSkvZhbaf4wcF1e8TD4ngywtRVqZjO/DhBsVyjI9cl5OFfEALOZ3gsM7ja2dzCYJqZELgH6IVGrUbNlmhK45QFwaueOV0+dcIE+kfdMV6OVki2XtFe9ybVx21EPVozEcbhaKtjMReJMaEJLZgzrHB5vz8oo98SgHOTjB4EUacNsR4vnk7Su4VDGiqA9kScCshvS5bnOslPJj6+nY6AcdC18e5ii+gBrPkLks3dHkYVke1aaEt0flcQ/+UoH5QnlguMSvfgKaKtRJ11qJBhVa3zY08SFJz3uw7mvQ+Lhsn2QoISAcIRyVP0Fy/EOeEclz4BRQ8BBf4IXjO3i1JkkiroCXaowC7p7LMWRx3zRLJN1HLoUG831A7fckdyVaJ8q6bMfMNn5NCLwSZZcd+aesO1vjfbRBWfsv8xY5LwK+C11Sc5ic9o=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b79f715-3d49-4844-834a-08d7fadd34d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 03:40:27.6011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qy8SMCNw0g0Gw4C5P/GKUA+yYybsX9AiZSPTfUTsTRHn8n0Lbx7VshmqNumfRENbr3DAd1UjPNjnwRyO+tzFWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6701
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBcHIgMjksIDIwMjAgYXQgMDQ6MjA6NTFQTSArMDgwMCwgU2hhd24gR3VvIDxzaGF3
bmd1b0BrZXJuZWwub3JnPiB3cm90ZToNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjDE6jXU
wjE3yNUgMjI6MTANCj4gVG86IFFpYW5nIFpoYW8gPHFpYW5nLnpoYW9AbnhwLmNvbT4NCj4gQ2M6
IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtwYXRjaCB2
MiAxLzJdIGxzMTA0M2FyZGI6IGFkZCBxZSBub2RlIHRvIGxzMTA0M2FyZGINCj4gDQo+IE9uIFdl
ZCwgQXByIDI5LCAyMDIwIGF0IDA0OjIwOjUxUE0gKzA4MDAsIFFpYW5nIFpoYW8gd3JvdGU6DQo+
ID4gRnJvbTogWmhhbyBRaWFuZyA8cWlhbmcuemhhb0BueHAuY29tPg0KPiA+DQo+ID4gQWRkIHFl
IG5vZGUgdG8gZnNsLWxzMTA0M2EuZHRzaSBhbmQgZnNsLWxzMTA0M2EtcmRiLmR0cw0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogWmhhbyBRaWFuZyA8cWlhbmcuemhhb0BueHAuY29tPg0KPiANCj4g
U3ViamVjdCBwcmVmaXggc2hvdWxkIGJlIGxpa2UgJ2FybTY0OiBkdHM6IC4uLicNCj4gDQo+IA0K
PiA+IC0tLQ0KPiA+IHYyOg0KPiA+IC0gYWRkIGNvbW1pdCBtc2cgYW5kIGRyb3AgYSBuZXcgYmxh
bmsgbGluZQ0KPiA+DQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEw
NDNhLXJkYi5kdHMgfCAxNiArKysrKysNCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvZnNsLWxzMTA0M2EuZHRzaSAgICB8IDY1DQo+ICsrKysrKysrKysrKysrKysrKysrKysrDQo+
ID4gIDIgZmlsZXMgY2hhbmdlZCwgODEgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gKwkJCWNvbXBh
dGlibGUgPSAiZnNsLHFlIiwgInNpbXBsZS1idXMiOw0KPiA+ICsJCQlyYW5nZXMgPSA8MHgwIDB4
MCAweDI0MDAwMDAgMHg0MDAwMD47DQo+ID4gKwkJCXJlZyA9IDwweDAgMHgyNDAwMDAwIDB4MCAw
eDQ4MD47DQo+ID4gKwkJCWJyZy1mcmVxdWVuY3kgPSA8MTAwMDAwMDAwPjsNCj4gPiArCQkJYnVz
LWZyZXF1ZW5jeSA9IDwyMDAwMDAwMDA+Ow0KPiA+ICsJCQlmc2wscWUtbnVtLXJpc2NzID0gPDE+
Ow0KPiA+ICsJCQlmc2wscWUtbnVtLXNudW1zID0gPDI4PjsNCj4gPiArDQo+ID4gKwkJCXFlaWM6
IHFlaWNAODAgew0KPiA+ICsJCQkJY29tcGF0aWJsZSA9ICJmc2wscWUtaWMiOw0KPiA+ICsJCQkJ
cmVnID0gPDB4ODAgMHg4MD47DQo+ID4gKwkJCQkjYWRkcmVzcy1jZWxscyA9IDwwPjsNCj4gPiAr
CQkJCWludGVycnVwdC1jb250cm9sbGVyOw0KPiA+ICsJCQkJI2ludGVycnVwdC1jZWxscyA9IDwx
PjsNCj4gPiArCQkJCWludGVycnVwdHMgPSA8MCA3NyAweDA0IDAgNzcgMHgwND47DQo+IA0KPiBU
d28gaWRlbnRpY2FsIGludGVycnVwdHM/DQoNClRoYW5rIHlvdSBmb3IgY29tbWVudHMuDQoNCk9u
IHNvbWUgYm9hcmRzIGZvciBRRSwgVGhlcmUgYXJlIHR3byBkaWZmZXJlbnQgaW50ZXJydXB0cy4N
CkFuZCBPbiBvdGhlcnMsIHRoZXJlIGlzIG9ubHkgb25lIGludGVycnVwdC4NCkluIG9yZGVyIHRv
IG1ha2UgaXQgY29tcGF0aWJsZSwgUUUgaW50ZXJydXB0cyB1c2VkIHRvIGJlIHdyb3RlIGxpa2Ug
dGhpcy4NClRoZSBkcml2ZXIgYWxzbyBoYW5kbGUgdGhlIHNpdHVhdGlvbiBsaWtlIHRoaXMuICAN
Cg0KQmVzdCBSZWdhcmRzDQpRaWFuZyBaaGFvDQo=
