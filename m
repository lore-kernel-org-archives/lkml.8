Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD03CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A03A620672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i0lNFku2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389188AbgF2UkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731705AbgF2TOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:11 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on0603.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe02::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A32C00E3F0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:09:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYL7647K+uJqw5IssZ3mMnH88LSwQrbDKe/sHMyrWwP7RbVt5/Jy6pbT1fJrXRq+Or5u+j89E8JWaD4CMWkvMDEmfVKFHGi2hdP6FatKWbFBTgX4nvMHZF8RjJGUHkG7fTj7Mo/fskQDmn5wMncRVni/BQfspNCGWA+DK1UjWvZk6OGTuAl0irmNO4Axm1+rsJQBJ+YAwC0Kd8ore7aceitp+Z3GGTykuKn7W6Qxt+oiOSOLUxH2hOWbxokUgQVjO9/OUJVNGlJTdWj/GcHzOR+lYgw9zSBpqYYrTTyKKp0/xAemogQ+2ViVimWcbUrpk+H1CeSXYuEwYJpuwAwYYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+J90+noiUB860mIJ/y+c/vqYXnzMOyH6iXSrRMUxq5A=;
 b=Jpr8iMChFdAXTeWHUzKM/y0vnVPiuuGZaqRIIVkLuLpLr698TSiemU1lDg8dMAJmVcIhdwwcF7ZE9m7x+BnLIB6cvcppH56vS2WyvPuESBCVLOrM8Y8AD962b08Lih3IRlD5S/QEGi1i9T+SZDdmawrbACYEv2VzCcj1FToU8QlWi3TRq+kxDupIUoYAxUxbkvqYx4RJ+VrcYJPc5J3krQgUcubsZGHsmc1rJJ7hkP12r0FzjZl92o3UFmzJeUEJT5KXgnmqveK4NrgN4SAW4WyQoYXsG9KE4DQojLYk0bkTBVJdQ13JAM/smcQgIr8yAMxUfMmJ2vWAAHRJssLMWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+J90+noiUB860mIJ/y+c/vqYXnzMOyH6iXSrRMUxq5A=;
 b=i0lNFku2HjhHPSA08ylBOSb+CjiSTks7K4jXDuE/1hU7en5S9h1um2115b+tT1kBX793Qet3kklWIH5gPfg2dmqLe7oKO4MqQpiBIDSzM4stZz5dKtHjJKyyeF6hyWH1NBOHv42FOjOL/UuZq9rc8imqh6fD3uxWZgrCy1j5FaE=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3660.eurprd04.prod.outlook.com (2603:10a6:8:c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Mon, 29 Jun
 2020 12:09:35 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 12:09:35 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stefan Agner <stefan.agner@toradex.com>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/3] arm64: defconfig: Select CONFIG_RESET_IMX7 by default
Thread-Topic: [PATCH 2/3] arm64: defconfig: Select CONFIG_RESET_IMX7 by
 default
Thread-Index: AQHWTf+gaUMc2TSOQkGGQmWO3bqF1KjvdP0AgAAA96CAAAXtAIAAAtMg
Date:   Mon, 29 Jun 2020 12:09:35 +0000
Message-ID: <DB3PR0402MB3916192607A09C7061740087F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1593425623-31810-1-git-send-email-Anson.Huang@nxp.com>
 <1593425623-31810-2-git-send-email-Anson.Huang@nxp.com>
 <CAK8P3a31coESQTssW1mndGuZ1pvxXSRRpY=XT1ZO+pkj9aabxg@mail.gmail.com>
 <DB3PR0402MB3916987E13C37013ACF59EB1F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a3Ar3TnSuxpUUMj4NjCK0Qb0pD9cVbcFUcdeGa85m2fUQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3Ar3TnSuxpUUMj4NjCK0Qb0pD9cVbcFUcdeGa85m2fUQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1803c34f-2f0b-41e1-39d6-08d81c2549fd
x-ms-traffictypediagnostic: DB3PR0402MB3660:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB36607588F7D00335A9D46EB8F56E0@DB3PR0402MB3660.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qYVRzSJpmgVYCuwrifhVQ4cUfCotZqurm0NxHYfZ5UpucYj/2C56xBrBlctVVMTicBI43tXZ5//xynTLkL0E5w+3Unntwse0zDq6U1pPakOv0muNZjTqBNkhsXrJAkYmqLLpik0DBZhyrU/6clUiozC3PERrckR0kx2QJtG7rAxin1//xD7I2Kutuql6FszdNPW6oKqgBv/TX2/QFGsQDbClYtb5RLgIbxG5xuEDDeSJeEp5MTwQyPiZ9iqnFWyFOulnw22C1Mttmg1YduHS5b2ZReIz0RUwTVk4qHfn1vyLnny05mrwKgtOOJsOwkHPBU7MHjmD/KhsZ/o5j0FU9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(478600001)(186003)(33656002)(8936002)(6506007)(53546011)(83380400001)(4326008)(86362001)(76116006)(6916009)(9686003)(64756008)(66556008)(66946007)(66446008)(26005)(66476007)(2906002)(55016002)(8676002)(71200400001)(5660300002)(52536014)(54906003)(44832011)(316002)(7696005)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: n08gK+2z6DtdkdIH6UUtMULvWnpl3RVwqlFM3Fxf5r2IEuUw2PPrYMdGnhF2+ZqpxUpF/wVtYr9+Tlw5+VqRDzUBC9u7ypQ3UMuWYFjwOwu4X39ihvR+sf8baP2TnpwexS3EAGKlctl0XQEAhn/umvdvhgx7ng2Na9axbIfsjo4UWk/ek+QrJbN5yPOyCb+tBE225R11m0NoE3SvLQRGuf4ayQ4hhlgxHvDEWgwSNc5Z2VqqG9AUWXR9au71ieVCoeqMEkXSq7aOlwOh8OQcEGSoiP0o+W61vKuBRxNSGTVuJHQhZNR+Dcxo460xQdxFsZo8eVXFykBVKw8YOqnHGLL+/mnq5guoUzqsiPCXvczsz6iAr3yOuRKUHBxZJ6iS/uRB/ZnMxZPNGWba7OkW/sk9Nway4DPNz+TTgiNUZu/0EPwVH0PkRgdI0oP0QgeN/WkjHTpreR5AhgOA1M4plMVQxQ747zQWmycutwTDFoz+AbsGxe4NXm5kL3sfqSPm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1803c34f-2f0b-41e1-39d6-08d81c2549fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 12:09:35.2085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K/hMv1deXKkRQ7vp2fyBZ295A6vIKOQniGoV9V8shV0EmIYE9JPi/vgRCYWx/YlLJK2ftLlhyQ6px+P0oUQcPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3660
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFybmQNCg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8zXSBhcm02NDogZGVmY29uZmln
OiBTZWxlY3QgQ09ORklHX1JFU0VUX0lNWDcgYnkNCj4gZGVmYXVsdA0KPiANCj4gT24gTW9uLCBK
dW4gMjksIDIwMjAgYXQgMTozNCBQTSBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4N
Cj4gd3JvdGU6DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvM10gYXJtNjQ6IGRlZmNvbmZp
ZzogU2VsZWN0IENPTkZJR19SRVNFVF9JTVg3DQo+ID4gPiBieSBkZWZhdWx0DQo+ID4gPg0KPiA+
ID4gT24gTW9uLCBKdW4gMjksIDIwMjAgYXQgMTI6MjUgUE0gQW5zb24gSHVhbmcNCj4gPEFuc29u
Lkh1YW5nQG54cC5jb20+DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gaS5NWDcgcmVz
ZXQgZHJpdmVyIG5vdyBzdXBwb3J0cyBtb2R1bGUgYnVpbGQsIGl0IGlzIG5vIGxvbmdlcg0KPiA+
ID4gPiBidWlsdCBpbiBieSBkZWZhdWx0LCBuZWVkIHRvIHNlbGVjdCBpdCBleHBsaWNpdGx5Lg0K
PiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdA
bnhwLmNvbT4NCj4gPiA+DQo+ID4gPiBXaHkgbm90IG1ha2UgaXQgPW0gbm93IHRoYXQgdGhpcyBp
cyBwb3NzaWJsZT8NCj4gPg0KPiA+IEl0IGlzIGJlY2F1c2Ugc29tZSBkcml2ZXJzIGRlcGVuZHMg
b24gdGhpcyByZXNldCBkcml2ZXIgdG8gd29yaywgc3VjaA0KPiA+IGFzIFBDSWUsIElmIGJ5IGRl
ZmF1bHQgbWFrZSBpdCA9bSwgaXQgbWF5IGltcGFjdCBQQ0llJ3MgZnVuY3Rpb24sDQo+ID4gYWRk
aW5nIG1vZHVsZSBzdXBwb3J0IGF0IHRoaXMgcG9pbnQgaXMgdHJ5IHRvIHByb3ZpZGUgZnVuY3Rp
b24gb2YNCj4gPiBsb2FkYWJsZSBtb2R1bGUgZm9yIEFuZHJvaWQsIGJ1dCBkb24ndCB3YW50IHRv
IGltcGFjdCBhbnkgZnVuY3Rpb24gd2hpY2ggaXMNCj4gd29ya2luZyBwcmV2aW91c2x5Lg0KPiAN
Cj4gSXQgc291bmRzIGxpa2UgeW91ciBwYXRjaCAxLzMgaXMgbm90IHJlYWR5IHRvIGJlIG1lcmdl
ZCB0aGVuLg0KPiANCj4gUGxlYXNlIG1ha2Ugc3VyZSB0aGF0IGxvYWRpbmcgaXQgbGF0ZXIgZG9l
cyBub3QgYnJlYWsgb3RoZXIgZHJpdmVycyB0aGF0IGRlcGVuZA0KPiBvbiBpdC4gT3RoZXIgZHJp
dmVycyBkb24ndCBoYXZlIHRvIGJlIGFibGUgdG8gZGVhbCB3aXRoIG1pc3NpbmcgZGVwZW5kZW5j
aWVzIGlmDQo+IHRoaXMgb25lIGlzIG5ldmVyIGxvYWRlZCBvciBkaXNhYmxlZCBhdCBjb21waWxl
LXRpbWUuIEhvd2V2ZXIgYmVmb3JlIHlvdQ0KPiBtYWtlIGl0IHBvc3NpYmxlIHRvIHR1cm4gdGhp
cyBpbnRvIGEgbG9hZGFibGUgbW9kdWxlLCBhbnl0aGluZyB0aGF0IGRlcGVuZHMgb24NCj4gaXQg
bXVzdCBiZSBhYmxlIHRvIGRlYWwgd2l0aCB0aGUgbW9kdWxlcyBnZXR0aW5nIGxvYWRlZCBpbiBh
IHJhbmRvbSBvcmRlcg0KPiBmaXJzdC4NCj4gDQpJIHNlYXJjaGVkIGFsbCBkcml2ZXIgd2hpY2gg
dXNlcyB0aGlzIHJlc2V0IGRyaXZlciwgbG9va3MgbGlrZSBPTkxZIGkuTVg2IFBDSWUgaXMgdXNp
bmcgaXQgYW5kDQppdCBPTkxZIHN1cHBvcnRzIGJ1aWx0LWluLCBhbmQgaW5zaWRlIHRoaXMgZHJp
dmVyLCBpdCBkb2VzIE5PVCBzdXBwb3J0IGRlZmVyIHByb2JlIGV0Yy4sDQpzaW5jZSBJIGFtIE5P
VCBzdXJlIHdoZW4gdGhpcyBQQ0llIGRyaXZlciB3aWxsIGFkZCBtb2R1bGUgc3VwcG9ydCwgc28g
ZG8geW91IHRoaW5rIGlmIEkNCmNhbiBtYWtlIFBDSV9JTVg2IHNlbGVjdCBSRVNFVF9JTVg3LCB0
aGVuIGl0IHdvbid0IGJyZWFrIHRoZSBQQ0llIGZ1bmN0aW9uIGV2ZW4NClJFU0VUX0lNWDcgaXMg
c2V0IHRvID1tIGluIGRlZmNvbmZpZywgYXMgd2hlbiBQQ0lfSU1YNiBpcyBlbmFibGVkIGFzID15
LCBSRVNFVF9JTVg3IHdpbGwNCmJlIGFsc28gPXkuDQoNCmNvbmZpZyBQQ0lfSU1YNg0KICAgICAg
ICBib29sICJGcmVlc2NhbGUgaS5NWDYvNy84IFBDSWUgY29udHJvbGxlciINCiAgICAgICAgZGVw
ZW5kcyBvbiBBUkNIX01YQyB8fCBDT01QSUxFX1RFU1QNCiAgICAgICAgZGVwZW5kcyBvbiBQQ0lf
TVNJX0lSUV9ET01BSU4NCiAgICAgICAgc2VsZWN0IFBDSUVfRFdfSE9TVA0KDQpUaGFua3MsDQpB
bnNvbg0K
