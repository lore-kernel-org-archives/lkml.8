Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B0AC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCBD12073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PAHmiiN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgDUHmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 03:42:47 -0400
Received: from mail-db8eur05on2082.outbound.protection.outlook.com ([40.107.20.82]:6090
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726052AbgDUHmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 03:42:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+8y0+/QGMfEMIT4fGvzI3G81gqJXU5TDDP2SON62a6CJrlqh15iSxn7RYanjF36j1QGpWDUSUBs8Gi4aWMl/4cgzVAb78TCYRnR4zskTrm4ZAYCvcrxWDZgHLsQwOHONzUguXBZ4XrIG6EKOg1TwZbij9Xty8jjROmnFJitg+z5IbSSG9jU8WLr4Zy0G4n/OqDsTVxOYrBRHXTdo8BVhFvTg/F4uVYbW2BjtOg7PgQWFhI2bRiaQC/tXunanblyZZt+EuHznOUgvVprsKImct19NB+/DhUZF9JfNujzK1lJrjYfVSO/Lq3u/GPaljZ6HV1tIrEpLURwW99P+BNg1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdNTXLKgu1vsBPxMBFrkFAvbyx9l+LfvCwbYqa+cFv0=;
 b=dAQocKLdFu1j4mA4y45FMkpZvw/WawV9sJMqu1FIF61rNCNmxKHSSClHLl0NMjUXnMijpmtTMR8HEoUhI4OQInuJI9y/qcvm0rhfWkegqN0wyeJQZeCOajIPr1e60ynEXDVSbv+b/UtszCYqLgmTEu6tlMToWxTBt7BJReBuUxaxrXisDmXVfep15Zve8QxmHgr3g2D5a+AwB2FpjhTAALXztDCT0C9Ba7mY9hhTB2kIlVe4+XtunhYqu/hNOqrIDNnNyCU/B77HuO7WzHXIUgAjJ3gAVgdVHgxdDuui9yKc9sIfN2NIqUmzmsxMzUdFiFqhqmmqOBcg8/x0MjArPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdNTXLKgu1vsBPxMBFrkFAvbyx9l+LfvCwbYqa+cFv0=;
 b=PAHmiiN/L5l+Ea0UYLNbIE4ZfCAqgyaaYlrVfyJfH2bgYRfhp1lrRNuCzQZDUhsfxok3Kkgxo2OMMaEOz5MJmSShmuWq1PHf/4zHu/PdZ36ulCbGfnCAGX5flf87ztSuXrA1Z5Kkq0GYtrBmiGb6rDEUd1Z8+12sM82rD+LZdgM=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2759.eurprd04.prod.outlook.com (2603:10a6:4:a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 07:42:41 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 07:42:41 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Suman Anna <s-anna@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     "ohad@wizery.com" <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] remoteproc: drop memset when loading elf segments
Thread-Topic: [PATCH 1/2] remoteproc: drop memset when loading elf segments
Thread-Index: AQHWDkksD911aIjfYEmeF50HneT1dahxj+QAgAAA5uCAAZn1AIADm4TQgAbL8ACABbGmwA==
Date:   Tue, 21 Apr 2020 07:42:41 +0000
Message-ID: <DB6PR0402MB2760A0F6D7BC0F5AC7207E1188D50@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1586420572-28353-1-git-send-email-peng.fan@nxp.com>
 <20200410012034.GU20625@builder.lan>
 <AM0PR04MB44816C59A9BE84465AC8F2C388DE0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200411015104.GJ576963@builder.lan>
 <AM0PR04MB4481CF4ACD86C69B329D5F2188DD0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <07eb5b9f-60cd-6555-1904-7b348bdc43f2@ti.com>
In-Reply-To: <07eb5b9f-60cd-6555-1904-7b348bdc43f2@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c4819df9-3f33-405f-dbb7-08d7e5c7929c
x-ms-traffictypediagnostic: DB6PR0402MB2759:|DB6PR0402MB2759:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB2759EA61C95F36CFFC6DA83B88D50@DB6PR0402MB2759.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(53546011)(316002)(86362001)(478600001)(26005)(8676002)(33656002)(6506007)(7696005)(81156014)(44832011)(71200400001)(54906003)(110136005)(8936002)(5660300002)(4326008)(66446008)(64756008)(55016002)(66556008)(2906002)(186003)(66476007)(66946007)(76116006)(52536014)(9686003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VDnjS8bdX5h9rJ6nVB3a5AqIV9ca1NPFQ2MBXcvl5iRIGeco+1Q3wOFIl/rkBnqHSV6lF8pkgCkLczzqIu8LK1r3+5BYZy4TrH+oxoea9wQFjHWaBJcMTHja0LLm1B4oVVC3uoRDgU+4v2PWi0LcWk3jCk9rPlrU+DWxMQaGQhNoPN5XcVmqFZ92G85ribDnD4HQQHCgnOL+kf2gW2AUCxpT+ctw1kKSvmHBW1wrmzEQrmpseaUWRcYC+F+0fRUSyrvcXZX0HJqcx2q+LjNuOuJoJ2qQdR0eCigap8vf1GCdZEUQc3LaP8Bm8rtnC5mgpEXEFREAF15aPU/XDLkBRQjKDWy3mKTLcjcUCV79gzfm33RwBjtJgkZbr7w6D2Ce3oGP5Sq5mkK6KqwBJuKjznCKIV3Zp7Nfjd4Q0tjlqyNvcjbxWQ82KUYJDxPS9oZy
x-ms-exchange-antispam-messagedata: bqmfP/6v28HKuJm457FJTLIkC7lp7BZkUle8yQuk0zTqSdtPfAnNl/3iBt66dkMYiT9mhhmmf5xUvp2zOSWDNEqzAUTXjIdpA9Mr+RLEBiPq7Xh2t/2fKxtYz9peODiLoOIZnhX1rHB8VBOcjGOoag==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4819df9-3f33-405f-dbb7-08d7e5c7929c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 07:42:41.6091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LJdSboXRyLJ1p1XdyMwOcEcyrPwwvmgp4718J6ftM41i3jqj+gUuPOJ763RlipWqkfN8ckN3+K3yAzkNpndr3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2759
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gcmVtb3RlcHJvYzogZHJvcCBtZW1zZXQgd2hlbiBs
b2FkaW5nIGVsZg0KPiBzZWdtZW50cw0KPiANCj4gT24gNC8xMy8yMCA0OjA1IEFNLCBQZW5nIEZh
biB3cm90ZToNCj4gPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gcmVtb3RlcHJvYzog
ZHJvcCBtZW1zZXQgd2hlbiBsb2FkaW5nIGVsZg0KPiA+PiBzZWdtZW50cw0KPiA+Pg0KPiA+PiBP
biBUaHUgMDkgQXByIDE4OjI5IFBEVCAyMDIwLCBQZW5nIEZhbiB3cm90ZToNCj4gPj4NCj4gPj4+
IEhpIEJqb3JuLA0KPiA+Pj4NCj4gPj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gcmVtb3Rl
cHJvYzogZHJvcCBtZW1zZXQgd2hlbiBsb2FkaW5nIGVsZg0KPiA+Pj4+IHNlZ21lbnRzDQo+ID4+
Pj4NCj4gPj4+PiBPbiBUaHUgMDkgQXByIDAxOjIyIFBEVCAyMDIwLCBQZW5nIEZhbiB3cm90ZToN
Cj4gPj4+Pg0KPiA+Pj4+PiBUbyBhcm02NCwgImRjICAgICAgenZhLCBkc3QiIGlzIHVzZWQgaW4g
bWVtc2V0Lg0KPiA+Pj4+PiBQZXIgQVJNIERESSAwNDg3QS5qLCBjaGFwdGVyIEM1LjMuOCBEQyBa
VkEsIERhdGEgQ2FjaGUgWmVybyBieSBWQSwNCj4gPj4+Pj4NCj4gPj4+Pj4gIklmIHRoZSBtZW1v
cnkgcmVnaW9uIGJlaW5nIHplcm9lZCBpcyBhbnkgdHlwZSBvZiBEZXZpY2UgbWVtb3J5LA0KPiA+
Pj4+PiB0aGlzIGluc3RydWN0aW9uIGNhbiBnaXZlIGFuIGFsaWdubWVudCBmYXVsdCB3aGljaCBp
cyBwcmlvcml0aXplZA0KPiA+Pj4+PiBpbiB0aGUgc2FtZSB3YXkgYXMgb3RoZXIgYWxpZ25tZW50
IGZhdWx0cyB0aGF0IGFyZSBkZXRlcm1pbmVkIGJ5DQo+ID4+Pj4+IHRoZSBtZW1vcnkgdHlwZS4i
DQo+ID4+Pj4+DQo+ID4+Pj4+IE9uIGkuTVggcGxhdGZvcm1zLCB3aGVuIGVsZiBpcyBsb2FkZWQg
dG8gb25jaGlwIFRDTSBhcmVhLCB0aGUNCj4gPj4+Pj4gcmVnaW9uIGlzIGlvcmVtYXBwZWQsIHNv
ICJkYyB6dmEsIGRzdCIgd2lsbCB0cmlnZ2VyIGFib3J0Lg0KPiA+Pj4+Pg0KPiA+Pj4+PiBTaW5j
ZSBtZW1zZXQgaXMgbm90IHN0cmljdGx5IHJlcXVpcmVkLCBsZXQncyBkcm9wIGl0Lg0KPiA+Pj4+
Pg0KPiA+Pj4+DQo+ID4+Pj4gVGhpcyB3b3VsZCBpbXBseSB0aGF0IHdlIHRydXN0IHRoYXQgdGhl
IGZpcm13YXJlIGRvZXNuJ3QgZXhwZWN0DQo+ID4+Pj4gcmVtb3RlcHJvYyB0byB6ZXJvIG91dCB0
aGUgbWVtb3J5LCB3aGljaCB3ZSd2ZSBhbHdheXMgZG9uZS4gU28gSQ0KPiA+Pj4+IGRvbid0IHRo
aW5rIHdlIGNhbiBzYXkgdGhhdCBpdCdzIG5vdCByZXF1aXJlZC4NCj4gPj4+DQo+ID4+PiBTYXlp
bmcgYW4gaW1hZ2UgcnVucyBvbiBhIHJlbW90ZSBjb3JlIG5lZWRzIExpbnV4IHRvIGhlbHAgemVy
byBvdXQNCj4gPj4+IEJTUyBzZWN0aW9uLCB0aGlzIG5vdCBtYWtlIHNlbnNlIHRvIG1lLg0KPiA+
Pg0KPiA+PiBNYXliZSBub3QsIGJ1dCBpdCBoYXMgYWx3YXlzIGRvbmUgaXQsIHNvIGlmIHRoZXJl
J3MgZmlybXdhcmUgb3V0DQo+ID4+IHRoZXJlIHRoYXQgZGVwZW5kcyBvbiBpdCBzdWNoIGNoYW5n
ZSB3b3VsZCBicmVhayB0aGVtLi4NCj4gPg0KPiA+IEdvdCBpdC4NCj4gPg0KPiA+Pg0KPiA+Pj4g
TXkgY2FzZSBpcyBhcyBmb2xsb3dpbmcsIEkgbmVlZCB0byBsb2FkIHNlY3Rpb24gNyBkYXRhLg0K
PiA+Pj4gSSBubyBuZWVkIHRvIGxldCByZW1vdGVwcm9jIHRvIG1lbXNldCBzZWN0aW9uIDgvOS8x
MC8xMS8xMiwgdGhlDQo+ID4+PiBmaXJtd2FyZSBpdHNlbGYgY291bGQgaGFuZGxlIHRoYXQuIEp1
c3QgYmVjYXVzZSB0aGUgbWVtc3ogaXMgbGFyZ2VyDQo+ID4+PiB0aGFuIGZpbGVzeiwgcmVtb3Jl
cHJvYyBtdXN0IG1lbXNldD8NCj4gPj4NCj4gPj4gQnkgaGF2aW5nIGEgUFRfTE9BRCBzZWdtZW50
IGNvdmVyaW5nIHRoZXNlIEkgdGhpbmsgaXQncyByZWFzb25hYmxlIHRvDQo+ID4+IGFzc3VtZSB0
aGF0IHRoZSBFTEYgbG9hZGVyIHNob3VsZCBiZSBhYmxlIHRvIHRvdWNoIHRoZSBhc3NvY2lhdGVk
DQo+IG1lbW9yeS4NCj4gPj4NCj4gPj4+IFNlY3Rpb24gSGVhZGVyczoNCj4gPj4+ICAgIFtOcl0g
TmFtZSAgICAgICAgICAgICAgVHlwZSAgICAgICAgICAgIEFkZHIgICAgIE9mZg0KPiBTaXplDQo+
ID4+IEVTIEZsZyBMayBJbmYgQWwNCj4gPj4+ICAgIFsgMF0gICAgICAgICAgICAgICAgICAgTlVM
TCAgICAgICAgICAgIDAwMDAwMDAwIDAwMDAwMA0KPiA+PiAwMDAwMDAgMDAgICAgICAwICAgMCAg
MA0KPiA+Pj4gICAgWyAxXSAuaW50ZXJydXB0cyAgICAgICBQUk9HQklUUyAgICAgICAgMWZmZTAw
MDAgMDEwMDAwIDAwMDI0MA0KPiAwMA0KPiA+PiBBICAwICAgMCAgNA0KPiA+Pj4gICAgWyAyXSAu
cmVzb3VyY2VfdGFibGUgICBQUk9HQklUUyAgICAgICAgMWZmZTAyNDAgMDEwMjQwIDAwMDA1OA0K
PiAwMA0KPiA+PiBBICAwICAgMCAgMQ0KPiA+Pj4gICAgWyAzXSAudGV4dCAgICAgICAgICAgICBQ
Uk9HQklUUyAgICAgICAgMWZmZTAyYTAgMDEwMmEwDQo+IDAwOWNjYyAwMA0KPiA+PiBBWCAgMCAg
IDAgMTYNCj4gPj4+ICAgIFsgNF0gLkFSTSAgICAgICAgICAgICAgQVJNX0VYSURYICAgICAgIDFm
ZmU5ZjZjIDAxOWY2Yw0KPiAwMDAwMDgNCj4gPj4gMDAgIEFMICAzICAgMCAgNA0KPiA+Pj4gICAg
WyA1XSAuaW5pdF9hcnJheSAgICAgICBJTklUX0FSUkFZICAgICAgMWZmZTlmNzQgMDE5Zjc0IDAw
MDAwNA0KPiAwNA0KPiA+PiBXQSAgMCAgIDAgIDQNCj4gPj4+ICAgIFsgNl0gLmZpbmlfYXJyYXkg
ICAgICAgRklOSV9BUlJBWSAgICAgIDFmZmU5Zjc4IDAxOWY3OCAwMDAwMDQNCj4gMDQNCj4gPj4g
V0EgIDAgICAwICA0DQo+ID4+PiAgICBbIDddIC5kYXRhICAgICAgICAgICAgIFBST0dCSVRTICAg
ICAgICAxZmZmOTI0MCAwMjkyNDANCj4gMDAwMDg0DQo+ID4+IDAwICBXQSAgMCAgIDAgIDQNCj4g
Pj4+ICAgIFsgOF0gLm5jYWNoZS5pbml0ICAgICAgUFJPR0JJVFMgICAgICAgIDFmZmY5MmM0IDAy
OTJjNCAwMDAwMDANCj4gMDANCj4gPj4gVyAgMCAgIDAgIDENCj4gPj4+ICAgIFsgOV0gLm5jYWNo
ZSAgICAgICAgICAgTk9CSVRTICAgICAgICAgIDFmZmY5MmM0IDAyOTJjNA0KPiAwMDBhODANCj4g
Pj4gMDAgIFdBICAwICAgMCAgNA0KPiA+Pj4gICAgWzEwXSAuYnNzICAgICAgICAgICAgICBOT0JJ
VFMgICAgICAgICAgMWZmZjlkNDQgMDI5MmM0DQo+IDAxZjVjMA0KPiA+PiAwMCAgV0EgIDAgICAw
ICA0DQo+ID4+PiAgICBbMTFdIC5oZWFwICAgICAgICAgICAgIE5PQklUUyAgICAgICAgICAyMDAx
OTMwNCAwMjkyYzQNCj4gMDAwNDA0DQo+ID4+IDAwICBXQSAgMCAgIDAgIDENCj4gPj4+ICAgIFsx
Ml0gLnN0YWNrICAgICAgICAgICAgTk9CSVRTICAgICAgICAgIDIwMDE5NzA4IDAyOTJjNA0KPiAw
MDA0MDANCj4gPj4gMDAgIFdBICAwICAgMCAgMQ0KPiA+Pj4NCj4gPj4+Pg0KPiA+Pj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPj4+Pj4gLS0tDQo+ID4+
Pj4+ICAgZHJpdmVycy9yZW1vdGVwcm9jL3JlbW90ZXByb2NfZWxmX2xvYWRlci5jIHwgNyArKy0t
LS0tDQo+ID4+Pj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkNCj4gPj4+Pj4NCj4gPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVtb3RlcHJvYy9y
ZW1vdGVwcm9jX2VsZl9sb2FkZXIuYw0KPiA+Pj4+PiBiL2RyaXZlcnMvcmVtb3RlcHJvYy9yZW1v
dGVwcm9jX2VsZl9sb2FkZXIuYw0KPiA+Pj4+PiBpbmRleCAxNmUyYzQ5NmZkNDUuLmNjNTBmZTcw
ZDUwYyAxMDA2NDQNCj4gPj4+Pj4gLS0tIGEvZHJpdmVycy9yZW1vdGVwcm9jL3JlbW90ZXByb2Nf
ZWxmX2xvYWRlci5jDQo+ID4+Pj4+ICsrKyBiL2RyaXZlcnMvcmVtb3RlcHJvYy9yZW1vdGVwcm9j
X2VsZl9sb2FkZXIuYw0KPiA+Pj4+PiBAQCAtMjM4LDE0ICsyMzgsMTEgQEAgaW50IHJwcm9jX2Vs
Zl9sb2FkX3NlZ21lbnRzKHN0cnVjdCBycHJvYw0KPiA+Pj4+PiAqcnByb2MsDQo+ID4+Pj4gY29u
c3Qgc3RydWN0IGZpcm13YXJlICpmdykNCj4gPj4+Pj4gICAJCQltZW1jcHkocHRyLCBlbGZfZGF0
YSArIG9mZnNldCwgZmlsZXN6KTsNCj4gPj4+Pj4NCj4gPj4+Pj4gICAJCS8qDQo+ID4+Pj4+IC0J
CSAqIFplcm8gb3V0IHJlbWFpbmluZyBtZW1vcnkgZm9yIHRoaXMgc2VnbWVudC4NCj4gPj4+Pj4g
KwkJICogTm8gbmVlZCB6ZXJvIG91dCByZW1haW5pbmcgbWVtb3J5IGZvciB0aGlzIHNlZ21lbnQu
DQo+ID4+Pj4+ICAgCQkgKg0KPiA+Pj4+PiAgIAkJICogVGhpcyBpc24ndCBzdHJpY3RseSByZXF1
aXJlZCBzaW5jZSBkbWFfYWxsb2NfY29oZXJlbnQNCj4gYWxyZWFkeQ0KPiA+Pj4+PiAtCQkgKiBk
aWQgdGhpcyBmb3IgdXMuIGFsYmVpdCBoYXJtbGVzcywgd2UgbWF5IGNvbnNpZGVyIHJlbW92aW5n
DQo+ID4+Pj4+IC0JCSAqIHRoaXMuDQo+ID4+Pj4+ICsJCSAqIGRpZCB0aGlzIGZvciB1cy4NCj4g
Pj4+Pg0KPiA+Pj4+IEluIHRoZSBjYXNlIG9mIHJlY292ZXJ5IHRoaXMgY29tbWVudCBpcyB3cm9u
Zywgd2UgZG8gbm90DQo+ID4+Pj4gZG1hX2FsbG9jX2NvaGVyZW50KCkgdGhlIGNhcnZlb3V0IGR1
cmluZyBhIHJlY292ZXJ5Lg0KPiA+Pj4NCj4gPj4+IElzbid0IHRoZSBpdCB0aGUgZmlybXdhcmUn
cyBqb2IgdG8gbWVtc2V0IHRoZSByZWdpb24/DQo+ID4+Pg0KPiA+Pg0KPiA+PiBJJ20gbm90IGF3
YXJlIG9mIHRoaXMgYmVpbmcgYSBkb2N1bWVudGVkIHJlcXVpcmVtZW50LCB3ZSd2ZSBhbHdheXMN
Cj4gPj4gZG9uZSBpdCBoZXJlIGZvciB0aGVtLCBzbyByZW1vdmluZyB0aGlzIGNhbGwgd291bGQg
YmUgYSBjaGFuZ2UgaW4gYmVoYXZpb3IuDQo+ID4+DQo+ID4+Pj4NCj4gPj4+PiBBbmQgaW4geW91
ciBjYXNlIHlvdSBpb3JlbWFwcGVkIGV4aXN0aW5nIFRDTSwgc28gaXQncyBuZXZlciB0cnVlLg0K
PiA+Pj4+DQo+ID4+Pj4+ICAgCQkgKi8NCj4gPj4+Pj4gLQkJaWYgKG1lbXN6ID4gZmlsZXN6KQ0K
PiA+Pj4+PiAtCQkJbWVtc2V0KHB0ciArIGZpbGVzeiwgMCwgbWVtc3ogLSBmaWxlc3opOw0KPiA+
Pj4+DQo+ID4+Pj4gU28gSSB0aGluayB5b3UgZG8gd2FudCB0byB6ZXJvIG91dCB0aGlzIHJlZ2lv
bi4gUXVlc3Rpb24gaXMgaG93IHdlIGRvIGl0Li4uDQo+ID4+Pg0KPiA+Pj4gSSBoYXZlIGNvbnRh
Y3RlZCBvdXIgTTQgb3duZXJzLCB3ZSBubyBuZWVkIGNsZWFyIGl0IGZyb20gTGludXggc2lkZS4N
Cj4gPj4NCj4gPj4gQW5kIEkgdGhpbmsgX21vc3RfIGZpcm13YXJlIG91dCB0aGVyZSwgbGlrZSB5
b3VycywgZG9lcyBjbGVhciBCU1MgZXRjDQo+ID4+IGR1cmluZyBpbml0aWFsaXphdGlvbi4NCj4g
Pj4NCj4gPj4+IFdlIGFsc28gc3VwcG9ydCBib290aW5nIG00IGJlZm9yZSBib290aW5nIExpbnV4
LCBhdCB0aGF0IGNhc2UsIExpbnV4DQo+ID4+PiBoYXMgbm90aW5nIHRvIGRvIHdpdGggbWVtc2V0
LiBJdCBpcyBqdXN0IEkgdHJ5IGxvYWRpbmcgbTQgaW1hZ2Ugd2l0aA0KPiA+Pj4gTGludXgsIGFu
ZCBtZXQgdGhlIGlzc3VlIHRoYXQgbWVtc2V0IHRyaWdnZXIgYWJvcnQuDQo+ID4+Pg0KPiA+Pg0K
PiA+PiBQbGVhc2Ugc2VlIHRoZSBwcm9wb3NhbCBmb3IgYXR0YWNoaW5nIHRvIGFscmVhZHkgcnVu
bmluZyByZW1vdGVwcm9jJ3MNCj4gPj4gZnJvbSBNYXRoaWV1LiBJIGRvbid0IGV4cGVjdCB0aGF0
IHlvdSB3YW50IHRvIGxvYWQgeW91ciBQUk9HQklUUw0KPiA+PiBlaXRoZXIgaW4gdGhpcyBjYXNl
Pw0KPiA+DQo+ID4gTm8gbmVlZCB0byBsb2FkIGZvciBlYXJseSBib290IGNhc2UuIEl0IGlzIGp1
c3QgdXNlcnNwYWNlIGxvYWQgdHJpZ2dlcg0KPiA+IGtlcm5lbCBwYW5pYywgYmVjYXVzZSBtZW1z
ZXQgYXJtNjQgY291bGQgbm90IHdvcmsgZm9yIGlvcmVtYXBwZWQNCj4gbWVtb3J5Lg0KPiA+DQo+
ID4gSG93IGFib3V0IGFkZGluZyBvcHMgaG9va3MgZm9yIG1lbXNldCBhbmQgbWVtY3B5IHRvIGxl
dCBkcml2ZXIgaGF2ZQ0KPiA+IHRoZWlyIG93biBpbXBsZW1lbnRhdGlvbj8NCj4gDQo+IEhpIFBl
bmcsDQo+IA0KPiBUaGUgdHJpY2sgaXMgdG8gdXNlIHRoZSBpb3JlbWFwX3djKCkgdmFyaWFudCBp
bnN0ZWFkIG9mIGlvcmVtYXAoKSBpbiB5b3VyDQo+IHBsYXRmb3JtIGRyaXZlciB3aGlsZSBtYXBw
aW5nIHRoZSBUQ01zLiBJIGtub3cgbXVsdGlwbGUgZm9sa3MgaGF2ZSBydW4gaW50bw0KPiB0aGlz
IGlzc3VlLiBUaGlzIGlzIHdoYXQgbW9zdCBvZiB0aGUgcmVtb3RlcHJvYyBkcml2ZXJzIHVzZSwg
YW5kIG1taW8tc3JhbQ0KPiBkcml2ZXIgYWxzbyB1c2VzIHRoZSBzYW1lLg0KDQpUQ00gaXMgZGlm
ZmVyZW50IGZyb20gT0NSQU0gaW4gaS5NWCBjaGlwcy4NCmlvcmVtYXBfd2Mgbm90IHdvcmsgZm9y
IFRDTSBtZW1vcnksIEkganVzdCB0cmllZCB0aGF0Lg0KDQpJIGFtIHRoaW5raW5nIHdlIGNoYW5n
ZSBtZW1zZXQvbWVtY3B5IHRvIHVzZQ0KbWVtc2V0X2lvL21lbWNweV9mcm9taW8vbWVtY3B5X3Rv
aW8gZm9yIHJlbW90ZXByb2MgY29tbW9uIGNvZGUsDQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+
IHJlZ2FyZHMNCj4gU3VtYW4NCg==
