Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92193C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 03:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57BFE2074F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 03:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a2BNaPcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgDXDJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 23:09:32 -0400
Received: from mail-eopbgr30041.outbound.protection.outlook.com ([40.107.3.41]:51779
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725840AbgDXDJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 23:09:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ed37Mup+iKPyoQw25W0A5coTdgFyjGkpPYdGUgASmeSAt3eMSDxufKKEX9MDMjhSc3zKuAKe+Ak6oCo1gOwPsOOJZzTlKmLsTHmDVV+aExXBqBA5zPO9k+gXB6D5CmOKz89Xg76625Klc6G+4MDhhC/tVAgBBqZsLOVkWDHKDORJ00YwxDB4xt068VMxudNn/bW8AtBvCFLhAHqy7fTYrLhchpHzRleXD3VrbCNbCk8LZba8jV34B7iOGMz5kzpx6A8GDQhWAGO5rFXwJm+RWtVNV7AAp8Yr6wJ2iuy8Se5gKXDl5SgLcboNa4yhangOsL0O2vfvFJxVs/B0T/Cdyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5U6BhGj52TRORxNjTNCcW/dF80j4n0y30WhI+y+pm48=;
 b=PPp5a31EN8Q9gKv+GDfVBp9BUERa0kjP3AMac8migA6PY79RZ4EZ8o3GVifha10QkkI9YyyalKGnpn6SV0tji7wQc/3kScBnbNHjoxQ9bWpmRpY3ee0QI95upsaYZ+m6VhZW0EJReeysBJkajJ9VnzzHcGTfd1D7fuLXfJ9vDnL/8KDmMv44+QvxPw4rvXh43dhsbXkAPPVnW6ZYtJoPVARGGY/3kSiy9aeNLGfyEGgZZqo3Sv+b1XmedGDkF5CSdKkuuzkpZ0GqAW41ds8lF1AJKOVkIzWiUikeMasgfiiQAnCOicGEAgqjvHYx5xke+Y14ayZK37ylznsYbj2Vhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5U6BhGj52TRORxNjTNCcW/dF80j4n0y30WhI+y+pm48=;
 b=a2BNaPcKkJNCVkCZXCEDhtLp3jwnXovbqX6Qe3lmDYnaBa58sAJb4cm5PJRz98qTZ6INQN27XE50VLPZMQWUOMUGXHJ5Xm2omMemMrWi0QOlBw7vavwwtVaBcZE3jVWLHntqm4S3TgPQDMKYBQtu2W4EiGc+6ykP+RyQwerVQVg=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3802.eurprd04.prod.outlook.com (2603:10a6:8:f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 24 Apr
 2020 03:09:25 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2921.035; Fri, 24 Apr 2020
 03:09:25 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] mailbox: imx: Add context save/restore for suspend/resume
Thread-Topic: [PATCH] mailbox: imx: Add context save/restore for
 suspend/resume
Thread-Index: AQHWGcRI3NaCUTtP70667RBGRFojq6iHjCeAgAAAeYCAAAouAIAAAIOw
Date:   Fri, 24 Apr 2020 03:09:25 +0000
Message-ID: <DB3PR0402MB39164CB0791AB259CE62EC4EF5D00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1587682871-528-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB49666D6A0B015FD1DF3A20B480D00@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916D588A9432A9F1D1F99BAF5D00@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM6PR04MB496671BFF3496FD1C4C51E7E80D00@AM6PR04MB4966.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB496671BFF3496FD1C4C51E7E80D00@AM6PR04MB4966.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 98e4914a-7049-499f-7741-08d7e7fce4f5
x-ms-traffictypediagnostic: DB3PR0402MB3802:|DB3PR0402MB3802:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB38029DD99F2EA3E6C57A80CEF5D00@DB3PR0402MB3802.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:644;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(478600001)(66446008)(64756008)(66476007)(66556008)(66946007)(6506007)(7696005)(26005)(8676002)(33656002)(52536014)(53546011)(8936002)(81156014)(15650500001)(55016002)(71200400001)(86362001)(9686003)(5660300002)(4326008)(76116006)(2906002)(186003)(110136005)(44832011)(316002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KwdI7S5Ueme+Cowpb78uCGqeoDWZ8EUtJlEHL32cqDjdhNIlUmsb307HahJ/WCo1HQgmI7pgfuA5Ti5kXlTiPbhptrLzcJyxQdMv7TSBv3s1HTbxdwu8K0H1uSYGS0RGPFxEvwueYl1vB9QyeiaHHnfMQ4VydPO6SZ5pFZW4petXIxNDcwdQz8OEtP0cKOcV4gg+xDxtY0RYRhvQ+7ZLQBJNvtKVUvjd8IVHl0ahqu8CPwPL1EoL9Jybq9GneComVei9383WTDgPUcS1yX97h19vx0+zZR2IM1x7+Xh3ti425S+Yqkw6w68c7vmGlLjTJui1H+E9rqQY/iFa9CB2ACmjn5M7YGKyx0p8ttbar/GAQPugv9yMDv113iG5uwennc4Sawr78g7YAKhzLdNW7jt1JOvNOF5YUkLaiSWlQSucw0ndpx2sSqy7txkqMruY
x-ms-exchange-antispam-messagedata: RPgKxgY2t2NpMxuK0KWiEu1+7OZpphLOEwj0BwoP3HSG3pUXPFWOK2lPDzhEI5r2PdZX+geaNk8Q2qNCBaBpMkk4Oen5CX5zqvFhM1/YkitserqLumwPB/qwmXer6qyRVtU13gpKU+c3jQvMd7nfeAVJN12TacWNBqAn7QgkJPrDqWLIloHz28qBhyB6vwWe3Ip8ua/YswZfYzXov1ouYW8QWSTYByCvOvJYaYy3j2ZCXseFvafaSlQr9hMZZxsYLXKbf+eJiN1nHGMM5CNdSmHgrflTqcmcNhF7bmPvXcqYX02zDuYQ+F+z7ZXgZkmQ/LGut6HxdHWWK2V0ZKxVgmtlzmb2W1EE3oOVtp8uL23p1QmW/0hD6pLvEfd1XRvfh6tECGtv0PfsDcuWnM9xxF8ReSX5t/rkcNhHAHImifGuipADu5C9cx5CCRD7X6ijuoOGD4eANuxrxG6uXjQ69gM8L/X1BzQxdRT0hUtz7JGNWPs6U4xsmnDjGYa9HVeDHYplBxouvfpHORGmc5uiIDc17EHLh0T2+OiZJElp/hXTHVlx9HcwNZ9dHCqEpjvTXbrPDnIFHAyDHhD+PV1cHEbn4vtvvjltdr/IPmgWb0UQizdsyEqnydUvEHtrtxiX2cb+wPyOsAvtQqNBEL11+ui+wwP614iphXQGFjTUXhHa92qtnpvGrezKfR2VbBVHtnL02VvgnYXEz7OSJtYAIDF9HBsOdbK34zIScFX5FbcaV1+U+qpKnOCl2X68H+VVi+tv8Wi3l5poWbK1+Zu3DuTwkRWIVFqU5rKbsaDHmXA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e4914a-7049-499f-7741-08d7e7fce4f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 03:09:25.4252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: erIWSvAJZr+kGV0ui4gz6Ii4OM3OaLQpUb9OW+65po5m12vIwe6h00LSDAeTt/0Xa8HvmSnbI+uuwUlpAqSxvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3802
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gbWFpbGJveDogaW14OiBBZGQgY29udGV4dCBzYXZl
L3Jlc3RvcmUgZm9yDQo+IHN1c3BlbmQvcmVzdW1lDQo+IA0KPiA+IEZyb206IEFuc29uIEh1YW5n
IDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiA+IFNlbnQ6IEZyaWRheSwgQXByaWwgMjQsIDIwMjAg
MTA6MzMgQU0NCj4gPg0KPiA+ID4gU3ViamVjdDogUkU6IFtQQVRDSF0gbWFpbGJveDogaW14OiBB
ZGQgY29udGV4dCBzYXZlL3Jlc3RvcmUgZm9yDQo+ID4gPiBzdXNwZW5kL3Jlc3VtZQ0KPiA+ID4N
Cj4gPiA+ID4gRnJvbTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gPiA+
IFNlbnQ6IEZyaWRheSwgQXByaWwgMjQsIDIwMjAgNzowMSBBTQ0KPiA+ID4gPg0KPiA+ID4gPiBG
b3IgIm1lbSIgbW9kZSBzdXNwZW5kIG9uIGkuTVg4IFNvQ3MsIE1VIHNldHRpbmdzIGNvdWxkIGJl
IGxvc3QNCj4gPiA+ID4gYmVjYXVzZSBpdHMgcG93ZXIgaXMgb2ZmLCBzbyBzYXZlL3Jlc3RvcmUg
aXMgbmVlZGVkIGZvciBNVQ0KPiA+ID4gPiBzZXR0aW5ncyBkdXJpbmcNCj4gPiA+IHN1c3BlbmQv
cmVzdW1lLg0KPiA+ID4gPiBIb3dldmVyLCB0aGUgcmVzdG9yZSBjYW4gT05MWSBiZSBkb25lIHdo
ZW4gTVUgc2V0dGluZ3MgYXJlDQo+ID4gPiA+IGFjdHVhbGx5IGxvc3QsIGZvciB0aGUgc2NlbmFy
aW8gb2Ygc2V0dGluZ3MgTk9UIGxvc3QgaW4gImZyZWV6ZSINCj4gPiA+ID4gbW9kZSBzdXNwZW5k
LCBzaW5jZSB0aGVyZSBjb3VsZCBiZSBzdGlsbCBJUEMgZ29pbmcgb24gbXVsdGlwbGUNCj4gPiA+
ID4gQ1BVcywgcmVzdG9yaW5nIHRoZSBNVSBzZXR0aW5ncyBjb3VsZCBvdmVyd3JpdGUgdGhlIFRJ
RSBieSBtaXN0YWtlDQo+ID4gPiA+IGFuZCBjYXVzZSBzeXN0ZW0gZnJlZXplLCBzbyBuZWVkIHRv
IG1ha2Ugc3VyZSBPTkxZIHJlc3RvcmUgdGhlIE1VDQo+ID4gPiA+IHNldHRpbmdzIHdoZW4gaXQg
aXMNCj4gPiA+IHBvd2VyZWQgb2ZmLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBB
bnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiA+DQo+ID4gPiBBcyBtZW50aW9u
ZWQgYmVmb3JlLCB3ZSdkIGJldHRlciBrZWVwIHRoZSBvcmlnaW5hbCBhdXRob3IuDQo+ID4gPg0K
PiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMvbWFpbGJveC9pbXgtbWFpbGJveC5jIHwgMzUN
Cj4gPiA+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL21haWxib3gvaW14LW1haWxib3guYw0KPiA+ID4gPiBiL2RyaXZlcnMvbWFp
bGJveC9pbXgtbWFpbGJveC5jIGluZGV4IDk3YmYwYWMuLmI1M2NmNjMgMTAwNjQ0DQo+ID4gPiA+
IC0tLSBhL2RyaXZlcnMvbWFpbGJveC9pbXgtbWFpbGJveC5jDQo+ID4gPiA+ICsrKyBiL2RyaXZl
cnMvbWFpbGJveC9pbXgtbWFpbGJveC5jDQo+ID4gPiA+IEBAIC02Nyw2ICs2Nyw4IEBAIHN0cnVj
dCBpbXhfbXVfcHJpdiB7DQo+ID4gPiA+ICAJc3RydWN0IGNsawkJKmNsazsNCj4gPiA+ID4gIAlp
bnQJCQlpcnE7DQo+ID4gPiA+DQo+ID4gPiA+ICsJdTMyIHhjcjsNCj4gPiA+ID4gKw0KPiA+ID4g
PiAgCWJvb2wJCQlzaWRlX2I7DQo+ID4gPiA+ICB9Ow0KPiA+ID4gPg0KPiA+ID4gPiBAQCAtNTgz
LDEyICs1ODUsNDUgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQNCj4gPiA+ID4g
aW14X211X2R0X2lkc1tdID0geyAgfTsgIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGlteF9tdV9k
dF9pZHMpOw0KPiA+ID4gPg0KPiA+ID4gPiArc3RhdGljIGludCBpbXhfbXVfc3VzcGVuZF9ub2ly
cShzdHJ1Y3QgZGV2aWNlICpkZXYpIHsNCj4gPiA+ID4gKwlzdHJ1Y3QgaW14X211X3ByaXYgKnBy
aXYgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCXByaXYtPnhj
ciA9IGlteF9tdV9yZWFkKHByaXYsIHByaXYtPmRjZmctPnhDUik7DQo+ID4gPiA+ICsNCj4gPiA+
ID4gKwlyZXR1cm4gMDsNCj4gPiA+ID4gK30NCj4gPiA+ID4gKw0KPiA+ID4gPiArc3RhdGljIGlu
dCBpbXhfbXVfcmVzdW1lX25vaXJxKHN0cnVjdCBkZXZpY2UgKmRldikgew0KPiA+ID4gPiArCXN0
cnVjdCBpbXhfbXVfcHJpdiAqcHJpdiA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+ID4gPiAr
DQo+ID4gPiA+ICsJLyoNCj4gPiA+ID4gKwkgKiBPTkxZIHJlc3RvcmUgTVUgd2hlbiBjb250ZXh0
IGxvc3QsIHRoZSBUSUUgY291bGQNCj4gPiA+ID4gKwkgKiBiZSBzZXQgZHVyaW5nIG5vaXJxIHJl
c3VtZSBhcyB0aGVyZSBpcyBNVSBkYXRhDQo+ID4gPiA+ICsJICogY29tbXVuaWNhdGlvbiBnb2lu
ZyBvbiwgYW5kIHJlc3RvcmUgdGhlIHNhdmVkDQo+ID4gPiA+ICsJICogdmFsdWUgd2lsbCBvdmVy
d3JpdGUgdGhlIFRJRSBhbmQgY2F1c2UgTVUgZGF0YQ0KPiA+ID4gPiArCSAqIHNlbmQgZmFpbGVk
LCBtYXkgbGVhZCB0byBzeXN0ZW0gZnJlZXplLiBUaGlzIGlzc3VlDQo+ID4gPiA+ICsJICogaXMg
b2JzZXJ2ZWQgYnkgdGVzdGluZyBmcmVlemUgbW9kZSBzdXNwZW5kLg0KPiA+ID4gPiArCSAqLw0K
PiA+ID4gPiArCWlmICghaW14X211X3JlYWQocHJpdiwgcHJpdi0+ZGNmZy0+eENSKSkNCj4gPiA+
ID4gKwkJaW14X211X3dyaXRlKHByaXYsIHByaXYtPnhjciwgcHJpdi0+ZGNmZy0+eENSKTsNCj4g
PiA+DQo+ID4gPiBUaGlzIGNvdWxkIGJlIHNlcGFyYXRlIHBhdGNoIGlmIGl0IGFpbXMgdG8gZml4
IGEgc3BlY2lmaWMgY29ybmVyIGNhc2UuDQo+ID4NCj4gPiBUaGlzIGlzIE5PVCBjb3JuZXIgY2Fz
ZSwgaXQgY2FuIGJlIHJlcHJvZHVjZWQgd2l0aCBvdXIgaW14XzUuNC55IHZlcnkNCj4gPiBlYXNp
bHksIGFuZCB0aGlzIGlzc3VlIGNhdXNlIG1lIG1hbnkgZGF5cyB0byBkZWJ1Zy4uLkFsc28gY2F1
c2UNCj4gPiBDbGFyaydzIGVmZm9ydCB0byBoZWxwIHRlc3QgaXQgYSBsb3QgZm9yIG1hbnkgZGF5
cy4uLg0KPiA+DQo+IA0KPiBJcyB0aGlzIGlzc3VlIG9ubHkgaGFwcGVuIGZvciBub24tc3RhdGUg
bG9zdCBjYXNlIChlZy4gRnJlZXplIG1vZGUpPw0KPiBJZiB5ZXMsIGl0J3MgYSBzcGVjaWZpYyBj
YXNlIGFuZCB3b3J0aCBhIHNlcGFyYXRlIHBhdGNoIHRvIGhpZ2hsaWdodCBpdCBJTUhPLg0KPiAN
Cj4gQlRXLCBpdCBzZWVtcyBtb3N0IGRyaXZlcnMgaGF2ZSB0aGlzIGlzc3VlIGluIGN1cnJlbnQg
a2VybmVsIGJlY2F1c2UgdGhleSBkb24ndA0KPiBrbm93IHdoZXRoZXIgdGhlIHN0YXRlIGFyZSBy
ZWFsbHkgbG9zdCwgaXQgc2VlbXMgbGlrZSBrZXJuZWwgc3RpbGwgZG9lc24ndCBzdXBwb3J0DQo+
IHRoaXMgd2VsbC4NCj4gDQo+ID4gSSBkbyBOT1QgdGhpbmsgaXQgbWFrZXMgc2Vuc2UgdG8gZmly
c3Qgc2VuZCBvdXQgeW91ciBwYXRjaCB3aXRoIGJ1Zw0KPiA+IGZvciByZXZpZXcsIEFuZCB0aGVu
IGFkZCBhbm90aGVyIHBhdGNoIHRvIGZpeCBpdC4gMSBwYXRjaCBpcyBlbm91Z2ggZm9yIHRoaXMN
Cj4gZmVhdHVyZS4NCj4gPg0KPiANCj4gQW55d2F5LCBpZiB5b3UgcmVhbGx5IHdhbnQgdG8gZ28g
d2l0aCBvbmUgcGF0Y2gsIGZvciB0aGlzIGNhc2UsIHdlIHVzdWFsbHkgY291bGQNCj4ga2VlcCBv
cmlnaW5hbCBhdXRob3IgYW5kIGFkZCBhIHNtYWxsIGZpeCBub3RlIGluIGNvbW1pdCBtZXNzYWdl
Lg0KPiAoWW91IGNvdWxkIHNlZSBtYW55IGNvbW11bml0eSBndXlzIGRvIGxpa2UgdGhpcyBpZiB5
b3Ugc2VhcmNoIGtlcm5lbCBjb21taXQNCj4gbG9nKQ0KPiANCj4gQmFzaWNhbGx5IHdlIHRyeSBv
dXIgYmVzdCB0byBrZWVwIG9yaWdpbiBhdXRob3IgaW4gb3JkZXIgdG8gcmVzcGVjdCBvdGhlcnMn
IHdvcmsNCj4gZm9yIGNvbW11bml0eSB3b3JrLg0KDQpJIGFtIGZpbmUgd2l0aCB3aG9ldmVyIGlz
IHRoZSBhdXRob3IsIG15IGZvY3VzIGlzIHRoZSBpc3N1ZSBmaXggYW5kIGVhc3kgcmViYXNlLg0K
SWYgbWFpbnRhaW5lciBhZ3JlZXMgdGhhdCBpbnRyb2R1Y2UgYSBwYXRjaCB3aXRoIGJ1ZyBhbmQg
YWRkIGFub3RoZXIgcGF0Y2ggdG8gZml4IGlzIE9LLCB0aGVuIEkgY2FuDQpyZXdvcmsgdGhlIHBh
dGNoIGludG8gMiBwYXRjaGVzLg0KDQpBbnNvbg0KDQo=
