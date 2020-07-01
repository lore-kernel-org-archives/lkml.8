Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC3DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 180B120747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rVKHbKSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgGAJkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:40:11 -0400
Received: from mail-eopbgr70079.outbound.protection.outlook.com ([40.107.7.79]:32173
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726353AbgGAJkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:40:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGO1ej8EtWzGILxkegRAjj4lVK83NCE2b4H7h7z/WLNjn9h/7VHKL2FzdmzDes6by4ppWhnKUkFRN6YwZ5u5UyfG2iaCLYy+aB3Ah279i05DuVq4aKA7I/f/8aO10fUv3VJAdhnmZgdmLgSiAboU0zb5cpivofTqHE/ty20usMJnNGFWwzP4Itx823KG8YP7PgjsAClWxutN5qSO4Ln2JY6aKC+h5t23cwWu3+sBEv7KO/3xC1MHDHpqiUoClfl6DWUimTtIs7ohLw44kJFNT3eG7smi4Wh1qJB915pDYpzNS3vSmlxNm3JWsrmTc4GuhSw0FzJqyMVuTEkWda7kQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6b7c+w6apo+r80Mi741Mb3bP2l8gu8FlchAQlT7grMM=;
 b=AnQlifwtrrzJnShy/WPt3UIAbGQ1Bii+sOrH2FyrgMp++2xqZuxgQThroFayARPtncPjl8dbNGs4wiw0SySanjfIQMceyRyzLp5JRqcas2Ay5uCGQkdpCHl7c9iesFOcSFi7xKZ8RsMTtzREd1kmEcPqhpwN7JMuVmILsYPN3iM4p5YxpNnP1EN9wcOdfS+wf/22ZeVLUNPRh6aFA7YMiBipQeJkkYCW+r/a0SO3gFXRG3H4IS/MbXdp8Sd81Hj1oGg6k7oB432GmNr3DkoQ+qgFH/8E0CJEIs8r1/1Z5lL+n+PJd0dNvLCM5HtyJajf+3qRcjEKi0pej7HYO3qXfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6b7c+w6apo+r80Mi741Mb3bP2l8gu8FlchAQlT7grMM=;
 b=rVKHbKStXe/xAYK6wfsrEy35U6QVOw/soSMBOYyOEvsWWgwzFDnRWMbXX0vniDYmwSrSz+Ftj54w/67RDvdyd+ZwycO7zNOIj0xXgPqr/UjWP5feeLJNQfzNykWCFATB0YkO4fB7QEZLKE9FH3R6NlGBHr86vU1ETg3SImLqDMo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB7PR04MB4762.eurprd04.prod.outlook.com (2603:10a6:10:16::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Wed, 1 Jul
 2020 09:40:04 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3131.030; Wed, 1 Jul 2020
 09:40:04 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Dong Aisheng <dongas86@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
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
Thread-Index: AQHWTdthV6wfzmMopU6pSRFnxqvg3qjvd4YAgAACQ6CAABqKgIAAAHBggAAdugCAAAKowIAA09MAgAHHMmCAABw9AIAAC3rggAACoRA=
Date:   Wed, 1 Jul 2020 09:40:04 +0000
Message-ID: <DB3PR0402MB3916461E26540B6ACFB54AFFF56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
 <1593410042-10598-5-git-send-email-Anson.Huang@nxp.com>
 <CAK8P3a2yXFbGxuSRoC5_dYBujnAtVoEMXe50V7QYjPYhqra7nA@mail.gmail.com>
 <DB3PR0402MB39160335642AFBAC4B38C511F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a0CcijnVxJws_kMiaOBbc4Uox40W4=-dX+BG6OeMYtFpw@mail.gmail.com>
 <DB3PR0402MB39167D9A3897C3CE327EBDDBF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a1cYsgJu+JCrmQw-VQyAKpyOz7fpOf3jBZ7QKc=urUFtw@mail.gmail.com>
 <DB3PR0402MB39167F7746B4B3794600FC7FF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAA+hA=TYuSk=P4D_D0_Rv1O2AAB3UvYrNXToptPJjEsjECquUw@mail.gmail.com>
 <DB3PR0402MB3916E820EA1E9884DD0A08CFF56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a1nxtFqytyTZjte-9UJQEZWp0eKF64v=E1LpgsG8R0h9w@mail.gmail.com>
 <DB3PR0402MB3916B16516474F8D17EF9DA3F56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916B16516474F8D17EF9DA3F56C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.9.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b326c8c4-fdf1-495d-4a42-08d81da2bbc1
x-ms-traffictypediagnostic: DB7PR04MB4762:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB4762ED130719EB1C9C1557F9F56C0@DB7PR04MB4762.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rG47DL6VqBSX5gqyBvcsVX14lQRtKAMq5Dwlgs+os+B4Ys/5BC4y25ds5OmaiBF7osk/9oSCSHfqRHwHYxCg8xUOZtHQlvjD1Xc6aN8a+zXI8fruSnohPRQi0GQUYHuzBgmyKfJQDBMji/htke7Vj5wwBdpCThhfcx28FMV/VuglIB/YEhsh9HwGmHx9t6K0xAMPg5PfqUcG6HMTV/FmoQZN7Cw7IxRYkhXCoUqgtSCzsDeNcKwLErDXkb6OPdjnyWb0sD+8lxGqzfzy458tmDuqCtkL99FBRpgk/7eEtW7yGivlMUEJZr3zPgd3zfcnphJQhlFwS5FF5yx4ZdIDkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(66556008)(7696005)(64756008)(478600001)(66446008)(52536014)(8936002)(19627235002)(66476007)(33656002)(6506007)(53546011)(4326008)(5660300002)(8676002)(9686003)(6916009)(2940100002)(186003)(55016002)(44832011)(66946007)(71200400001)(26005)(86362001)(316002)(54906003)(76116006)(83380400001)(7416002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: zeyBAXk70cVBfTOFI+A8P+/6mJ1hModpLBrL/P1bUdne62WssrRgVys5Uaa3fq3Yof7nkfsLgFEhBo7LQvRTz7hsLoUKn02Pg0DrfTV7bUFQemBtqadjBL/FDCLTJUD76rZ9hkNZEa2bWMx8mZSVC725p4tKSJFaAdQLPX+YunGPnYvMpIZ3oOyLt9JD1rb6++jOuPY61FIQ9uutN2oJ9uT2AnV/EinDAsYQFrscgu5LVk9fRdu4sDcRPbrMnOhKx5UL5MMDyYUMVVvKUgtFnnlfmebqgr4HiU9C9RGkSsNQ/AZKfwJLWrZ0w5Hee1amPBYB3rWwDSz2Xov84kMXTppfET5PajmC6AQbcqmsQpsWd19hQaBo/6V8BKrFnzGkfK4p1h3NsKNe6WnF05az7Nfo3xr9WNakYQaGs+hdxVJihcYysHOVR2/5HWHcsw/1CoRreRFzRts4475yk0g6Uxg5Vza8mYJXAdp5/TknxUQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b326c8c4-fdf1-495d-4a42-08d81da2bbc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 09:40:04.3650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vHhIKHYGE/Y+s3I9JUjxzFXHlX1Am3j8+G49KR6QhUmewPA0kgxFCkgXTiG2icnZiOyM66/ygbK5mvmkq4D1iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4762
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFybmQNCg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIFYzIDA0LzEwXSBjbGs6IGlteDogU3Vw
cG9ydCBidWlsZGluZyBTQ1UgY2xvY2sgZHJpdmVyIGFzDQo+IG1vZHVsZQ0KPiANCj4gSGksIEFy
bmQNCj4gDQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCBWMyAwNC8xMF0gY2xrOiBpbXg6IFN1cHBv
cnQgYnVpbGRpbmcgU0NVIGNsb2NrDQo+ID4gZHJpdmVyIGFzIG1vZHVsZQ0KPiA+DQo+ID4gT24g
V2VkLCBKdWwgMSwgMjAyMCBhdCA5OjE5IEFNIEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAu
Y29tPg0KPiA+IHdyb3RlOg0KPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDA0LzEwXSBj
bGs6IGlteDogU3VwcG9ydCBidWlsZGluZyBTQ1UgY2xvY2sNCj4gPiA+ID4gZHJpdmVyIGFzIG1v
ZHVsZSBPbiBUdWUsIEp1biAzMCwgMjAyMCBhdCA1OjE2IEFNIEFuc29uIEh1YW5nDQo+ID4gPGFu
c29uLmh1YW5nQG54cC5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBTQ1UgY2xvY2sgZHJp
dmVyIGlzIGEgY29tbW9uIGRyaXZlciBmb3IgYWxsIFNDVSBiYXNlZCBwbGF0Zm9ybXMuDQo+ID4g
PiA+IEN1cnJlbnQgaS5NWDhRWFAgU0NVIGNsb2NrIGRyaXZlciB3aWxsIGJlIGV4dGVuZGVkIHRv
IHN1cHBvcnQgYWxsDQo+ID4gPiA+IGZ1dHVyZSBTQ1UgYmFzZWQgcGxhdGZvcm1zLg0KPiA+ID4g
PiBTbyB0aGVvcmV0aWNhbGx5IGNsay1zY3UubyBhbmQgY2xrLWlteDhxeHAubyBjYW4gYmUgY29t
YmluZWQuIExQQ0cNCj4gPiA+ID4gaXMgc2ltaWxhci4NCj4gPiA+ID4gTWF5YmUgeW91IGNhbiBn
aXZlIGEgdHJ5IGFzIEFybmQgc3VnZ2VzdGVkLg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IERvIHdl
IHJlYWxseSBuZWVkIHRvIGxpbmsgY2xrLXNjdSBhbmQgaS5NWDhRWFAgY2xvY2sgZHJpdmVyIHRv
Z2V0aGVyDQo+ID4gPiBqdXN0IHRvDQo+ID4gYXZvaWQgc29tZSBleHBvcnQ/DQo+ID4NCj4gPiBJ
dCB3YXMganVzdCBtZWFudCB0byBiZSBlYXNpZXIgdGhhbiBleHBvcnRpbmcgYSBzeW1ib2wgYW5k
IGRlYWxpbmcNCj4gPiB3aXRoIG1vZHVsZSBkZXBlbmRlbmNpZXMuIElmIGl0J3Mgbm90IGVhc2ll
ciwgdGhlbiBkb24ndC4NCj4gPg0KPiA+ID4gSSBtZXQgc29tZSBidWlsZCBpc3N1ZXMgaWYgdXNp
bmcgdGhpcyBtZXRob2QsIHRoZSBpLk1YOFFYUCBtb2R1bGUNCj4gPiA+IGJ1aWxkIGlzIE9LLCBi
dXQgb3RoZXIgcGxhdGZvcm1zIGxpa2UNCj4gPiBpLk1YOE1NL2kuTVg4TU4vaS5NWDhNUS9pLk1Y
OE1QDQo+ID4gPiBjbG9jayBkcml2ZXJzIGFyZSBqdXN0IHNraXBwZWQgZm9yIGJ1aWxkLCBldmVu
IHRoZXNlIGkuTVg4TSBjbG9jaw0KPiA+ID4gY29uZmlnIGFyZSBleGlzdGluZyBpbiAuY29uZmln
LCBhbnlvbmUga25vdyB3aHk/IExvb2tzIGxpa2UgdGhlDQo+ID4gPiBjaGFuZ2UgaW4NCj4gPiBN
YWtlZmlsZSBmb3IgaS5NWDhRWFAgY2xvY2sgZHJpdmVyIGludHJvZHVjZSB0aGlzIGlzc3VlLg0K
PiA+DQo+ID4gWW91IGhhdmUgYSAiOj0iIGluc3RlYWQgb2YgIis9IiB0eXBvLCBzbyBhbGwgZWFy
bGllciAiKz0iIGFyZSBpZ25vcmVkOg0KPiA+DQo+ID4gPiBvYmotJChDT05GSUdfQ0xLX0lNWDhN
TSkgKz0gY2xrLWlteDhtbS5vDQo+ID4gPiBvYmotJChDT05GSUdfQ0xLX0lNWDhNTikgKz0gY2xr
LWlteDhtbi5vDQo+ID4gPiBvYmotJChDT05GSUdfQ0xLX0lNWDhNUCkgKz0gY2xrLWlteDhtcC5v
DQo+ID4gPiBvYmotJChDT05GSUdfQ0xLX0lNWDhNUSkgKz0gY2xrLWlteDhtcS5vDQo+ID4gPg0K
PiA+ID4gb2JqLSQoQ09ORklHX01YQ19DTEtfU0NVKSA6PSBjbGstaW14LXNjdS5vIGNsay1pbXgt
bHBjZy1zY3Uubw0KPiA+DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBe
Xl5eXl5eXg0KPiANCj4gVGhhbmtzLCBJIHdpbGwgZ2l2ZSBhbm90aGVyIHRyeSwgSSB3aWxsIG1h
a2UgdGhlIGNvbW1vbiBjbGsgcGFydCBhbGwgbGlua2VkIGludG8NCj4gZWFjaCBwbGF0Zm9ybSdz
IGNsb2NrIGRyaXZlciwgdGhlbiBtYW55IGV4cG9ydHMgY2FuIGJlIHNhdmVkLg0KDQpKdXN0IHRy
aWVkLCBpdCB3b3JrcyBmb3IgaS5NWDhRWFAsIGFuZGNvcnJlY3Qgb25lIHRoaW5nLCBvdGhlciBw
bGF0Zm9ybXMNCm5lZWQgbW9yZSBjb21wbGljYXRlZCBjaGFuZ2UgaWYgd2FudCB0byBzdXBwb3J0
IHRoZW0gaW4gdGhlIHNhbWUgd2F5LCBzbyBJDQpwbGFuIHRvIE9OTFkgZG8gdGhpcyBjaGFuZ2Ug
Zm9yIGkuTVg4UVhQIGlmIGl0IGlzIGFjY2VwdGFibGUuDQoNClRoYW5rcywNCkFuc29uDQo=
