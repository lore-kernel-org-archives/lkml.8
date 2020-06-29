Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40DDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F63D20672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SNdaqvxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730468AbgF2Tiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387442AbgF2Tho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:37:44 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20630.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386D7C02F01B;
        Mon, 29 Jun 2020 07:52:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPXnD/EIZLhjTPgl1k7p5GB0r6xUKthbJci1JEZJh909nBABfq8NPKbD/10k10MMwAkJOLZ+kSqGHdz15/hlDJM20IJKC3Y8XSTV0tJho+ygMC7D81q+a4mmZ7Rrfm1yWt4zqUKThlHpOtjsHYvs1QdAGitMqhWXL18Ug4jEh1zesWNTqQ3xnXB5PYJisPrLG+i9/mR8dQ85HLfPRqoNzBEpuEOUu94HogVe0UsV81h1Wm5yqTUpVw9m39e1CNkXhMvwkon8F5dpYP9/Kp/P4ZPH6hiJWt+NBHlolTniOv+OcJysYG+7BEph3QFQHEq4w0zCmuh9THC+t0476OWjiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAPcWO7VbEYvaAmLyoXT1ETqMvhrBeFgVMaMDQEHIy4=;
 b=PbUTj1VvMFaaERxG5dAOU5xZxzViEwt8aPD81Sj4wF7ztV4WkbpF1E8cAbuP2j6Do24l50bGSlBft+84yLTzgM7Ynt5h5BOK982vRMbWkqx/BjCL5/i57btNeHL7LsaNvuy8/7vSHfJb8kOa9Fh51RhoUuqDk4yAjR2rQrcRVbu674VuT7eA8vb/eeFx2kup1A6k5dtC8h7sGYWhliOJ7SIz345QppaycuCTLDn5W9rCR6v5spFl3HpQmETPs2r+kPxrDPxIJJrGbMpitbiWCumzEJTwXlg3nFjzV/BpxYuwmkxkiBFUE+xWia0973C5GKPHwqGPAU3HUpkg1G+ABw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAPcWO7VbEYvaAmLyoXT1ETqMvhrBeFgVMaMDQEHIy4=;
 b=SNdaqvxIUUXmMEAHQp43KEygJW4xWN8F75vRnUlGd6ojdSCzzaqx+/k91Ksc0WJ1+1Y9SkHEV/h63o7c3xo9118hwYRGrrJYTEDMEZP7Zlkqs7ksVJS/OGLY85EV9hIm50/OvLREWfYfx52bLUAvH29E2fDAqc3dy8Xo/SMcZ1I=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB6PR04MB3125.eurprd04.prod.outlook.com (2603:10a6:6:11::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Mon, 29 Jun
 2020 14:52:10 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 14:52:10 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
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
Thread-Index: AQHWTdthV6wfzmMopU6pSRFnxqvg3qjvd4YAgAACQ6CAABqKgIAAAHBg
Date:   Mon, 29 Jun 2020 14:52:09 +0000
Message-ID: <DB3PR0402MB39167D9A3897C3CE327EBDDBF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
 <1593410042-10598-5-git-send-email-Anson.Huang@nxp.com>
 <CAK8P3a2yXFbGxuSRoC5_dYBujnAtVoEMXe50V7QYjPYhqra7nA@mail.gmail.com>
 <DB3PR0402MB39160335642AFBAC4B38C511F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a0CcijnVxJws_kMiaOBbc4Uox40W4=-dX+BG6OeMYtFpw@mail.gmail.com>
In-Reply-To: <CAK8P3a0CcijnVxJws_kMiaOBbc4Uox40W4=-dX+BG6OeMYtFpw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3d81c5c1-b002-4beb-f8db-08d81c3c0036
x-ms-traffictypediagnostic: DB6PR04MB3125:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR04MB312507369056695B66144D53F56E0@DB6PR04MB3125.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rphpfB/tIn22/eVV9JYkyJX5Yd8wTUymjxy/pXySrbyKorV/fB0rm8z0EFxha2mzGlO4vh6mA6t/QfEBOeXG0igDQYd/qZTsc4EPH1t4IrrPmfUvhQ92HOKaGXM84CIvMUNXPlArZAI6hv/fff0i100RaLbc7HYTAxABE+EuOQhNQvhhUjfnW85TNqNzlnK2Gjiq1k6eKVOqLuR/vrfXeOlTfXiWIAQzCpS2yYd29xCO+nIymvjpczL1FvbiRcAz1gpSh49dLJK3zATIa3g+7IudGa6qbU6Zw3hIBms8YfmQRZ2lMjZq6gqmkhi+YyRX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(71200400001)(478600001)(55016002)(5660300002)(33656002)(7696005)(76116006)(52536014)(54906003)(316002)(9686003)(66946007)(8936002)(8676002)(7416002)(6916009)(83380400001)(4326008)(66476007)(44832011)(53546011)(86362001)(2906002)(64756008)(66556008)(6506007)(66446008)(186003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: kLiV3osParn0uTlZH1q+zy6d0fqXUqPPKGvxLOWq6TjtZ0tYFrf8DU4DN+Hx3bXOzdN4lHCDJfE2ylx+9rvax8149M+dkRyfrHYdwPevF0dC6XAL5yQIAmk05DKZzhaFf5frh/tgzXXMgy2zr9aK9cFyChB6+mhlZTn9EX5ksNOmroEQGUykAdxZA8RGbrTnAskz238N+ZNocj0Z10OL92zYPRDdlX6kxzbQGgQtvUm006EnS5xEAy7aVj6FPsWl1spvfHnpC1k2h+Gl2xxOJtwkFWthTms2c8LxWbdjE98NDibM8iMvxWVzNT68fzi70kqvOqNZ+dicX6YnQ3WxRtXSEcP+LSjj5KqDyeLZn9HMQ513u7HokwwgWI+oXbOlabF6WOpA4ya3cdPZOmMqhdn8ZxlbNOugNyqAZNjdu4CqCwdI0TutWfy0MjwJ9dsNkrTRrttpdNtGaMHd9SGb4LuipPk1gp9AI+7lM9O9mPkzvC8VBV42JBlbV0WCkSMz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d81c5c1-b002-4beb-f8db-08d81c3c0036
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 14:52:09.6255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X91ugvUzT3OuWFwFoYmWNip6G5TlITPogYtH11pcyU57l7dbmXs/xYDVr3vR/rtHYtxUG3c/w8d6QPIwYdOObQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFybmQNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDA0LzEwXSBjbGs6IGlteDogU3Vw
cG9ydCBidWlsZGluZyBTQ1UgY2xvY2sgZHJpdmVyIGFzDQo+IG1vZHVsZQ0KPiANCj4gT24gTW9u
LCBKdW4gMjksIDIwMjAgYXQgMjo1MyBQTSBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNv
bT4NCj4gd3JvdGU6DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDA0LzEwXSBjbGs6IGlt
eDogU3VwcG9ydCBidWlsZGluZyBTQ1UgY2xvY2sNCj4gPiA+IGRyaXZlciBhcyBtb2R1bGUNCj4g
PiA+DQo+ID4gPiBPbiBNb24sIEp1biAyOSwgMjAyMCBhdCA4OjA2IEFNIEFuc29uIEh1YW5nIDxB
bnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+ID4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gPiAtLS0gYS9k
cml2ZXJzL2Nsay9pbXgvTWFrZWZpbGUNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9jbGsvaW14L01h
a2VmaWxlDQo+ID4gPiA+IEBAIC0yMSw5ICsyMSw5IEBAIG9iai0kKENPTkZJR19NWENfQ0xLKSAr
PSBcDQo+ID4gPiA+ICAgICAgICAgY2xrLXNzY2ctcGxsLm8gXA0KPiA+ID4gPiAgICAgICAgIGNs
ay1wbGwxNHh4Lm8NCj4gPiA+ID4NCj4gPiA+ID4gLW9iai0kKENPTkZJR19NWENfQ0xLX1NDVSkg
Kz0gXA0KPiA+ID4gPiAtICAgICAgIGNsay1zY3UubyBcDQo+ID4gPiA+IC0gICAgICAgY2xrLWxw
Y2ctc2N1Lm8NCj4gPiA+ID4gK214Yy1jbGstc2N1LW9ianMgKz0gY2xrLWxwY2ctc2N1Lm8gbXhj
LWNsay1zY3Utb2JqcyArPSBjbGstc2N1Lm8NCj4gPiA+ID4gK29iai0kKENPTkZJR19NWENfQ0xL
X1NDVSkgKz0gbXhjLWNsay1zY3Uubw0KPiA+ID4NCj4gPiA+IEl0IGxvb2tzIGxpa2UgdGhlIHR3
byBtb2R1bGVzIGFyZSB0aWdodGx5IGNvbm5lY3RlZCwgb25lIGlzIHVzZWxlc3MNCj4gPiA+IHdp
dGhvdXQgdGhlIG90aGVyLiBIb3cgYWJvdXQgbGlua2luZyB0aGVtIGludG8gYSBjb21iaW5lZCBt
b2R1bGUgYW5kDQo+ID4gPiBkcm9wcGluZyB0aGUgZXhwb3J0IHN0YXRlbWVudD8NCj4gPiA+DQo+
ID4NCj4gPiBGcm9tIEhXIHBlcnNwZWN0aXZlLCB0aGUgU0NVIGNsb2NrIGRyaXZlciBhbmQgTFBD
RyBTQ1UgY2xvY2sgZHJpdmVyDQo+ID4gYXJlIGRpZmZlcmVudCwgU0NVIGNsb2NrIGRyaXZlciBp
cyBmb3IgdGhvc2UgY2xvY2tzIGNvbnRyb2xsZWQgYnkNCj4gPiBzeXN0ZW0gY29udHJvbGxlciAo
TTQgd2hpY2ggcnVucyBhIGZpcm13YXJlKSwgd2hpbGUgTFBDRyBTQ1UgY2xvY2sgaXMNCj4gPiBm
b3IgdGhvc2UgY2xvY2sgZ2F0ZXMgaW5zaWRlIG1vZHVsZSwgd2hpY2ggbWVhbnMgQVAgY29yZSBj
YW4gY29udHJvbCBpdA0KPiBkaXJlY3RseSB2aWEgcmVnaXN0ZXIgYWNjZXNzLCBubyBuZWVkIHRv
IHZpYSBTQ1UgQVBJLg0KPiANCj4gU29ycnksIEkgbWlzcmVhZCB0aGUgcGF0Y2ggaW4gbXVsdGlw
bGUgd2F5cy4gRmlyc3Qgb2YgYWxsLCB5b3UgYWxyZWFkeSBwdXQNCj4gY2xrLXNjdS5vIGFuZCBj
bGstbHBjZy1zY3UubyBmaWxlcyBpbnRvIGEgY29tYmluZWQgbG9hZGFibGUgbW9kdWxlLCBhbmQg
SSBoYWQNCj4gb25seSBsb29rZWQgYXQgY2xrLXNjdS5jLg0KPiANCj4gV2hhdCBJIGFjdHVhbGx5
IG1lYW50IGhlcmUgd2FzIHRvIGxpbmsgY2xrLXNjdS5vIHRvZ2V0aGVyIHdpdGggY2xrLWlteDhx
eHAubw0KPiAoYW5kIHBvc3NpYmx5IGZ1dHVyZSBjaGlwLXNwZWNpZmljIGZpbGVzKSBpbnRvIGEg
bG9hZGFibGUgbW9kdWxlIGFuZCBkcm9wIHRoZQ0KPiBleHBvcnQuDQoNClNvcnJ5LCBjb3VsZCB5
b3UgcGxlYXNlIGFkdmlzZSBtb3JlIGRldGFpbHMgYWJvdXQgaG93IHRvIGRvIGl0IGluIE1ha2Vm
aWxlPw0KSSB0cmllZCBiZWxvdyBidXQgaXQgbG9va3MgbGlrZSBOT1Qgd29ya2luZy4gbXVsdGlw
bGUgZGVmaW5pdGlvbiBvZiBtb2R1bGVfaW5pdCgpIGVycm9yIHJlcG9ydGVkLg0KDQpvYmotJChD
T05GSUdfTVhDX0NMS19TQ1UpIDo9IGNsay1pbXgubw0KY2xrLWlteC15ICs9IGNsay1zY3UubyBj
bGstbHBjZy1zY3Uubw0KY2xrLWlteC0kKENPTkZJR19DTEtfSU1YOFFYUCkgKz0gY2xrLWlteDhx
eHAubyBjbGstaW14OHF4cC1scGNnLm8NCg0KVGhhbmtzLA0KQW5zb24NCg==
