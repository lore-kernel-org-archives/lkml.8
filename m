Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799ADC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50A39206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rx4lbNu4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390449AbgF2VMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730148AbgF2S5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:44 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on0617.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::617])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386C3C030788;
        Mon, 29 Jun 2020 08:19:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtSIUnc/94xwpwIngO+fN4QFxEnVEc0iYSoIdDd0lVJs8XTysvBMKF0wW2uEZ9iNmVw57B3HAqniIXeuseqsgUExvVvYQIo4KiRU3pe4qPdrkD/TVHD6It2L9/hCQYb0YJPbCsh6AQ/mHM9LwqKE5dyF6jlXU4BYrR98B1QUh5TJEvYmfTKyrSFDgU6JUxwhx85K3350Sz9mMBoNV2v3deRCW3kIMK5zsJiulcsqgPxTabVwCNWSuUWyhtXR0GAFP6mfE3Y9prg4AdXHbLlk/EP2jNdALfPIoxcu8kQWXPpeCGV2uNdsupIFqT5NvnJKHE78BI494X7Pay7zjY/q7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuVFX/JVlgPGs+AumHwTkGbvcOmUuPB3sEXjAHYCwdM=;
 b=MC2QBStoLGS6CyWVj35M9NU2jJTeaLMHVb1cCFoDlTxCV8w/EqZMVfpipW4ZjxvBP3Cqa+cVPJ5JS8eHo6ti4V1IIbZ/q55MZw33hlQG2mfHp2e/TU8xdI9Z+Bi3LP2tiFdOSt5x+WYe7IO8MAxNyAHRdtB85PrZv7/aMdv8qWpxehtmB38icwBbtYQn4Hdx7Z3jvugEd9KAkJug1u+TNIya9koiFqn+96iRaO6oGeVcJ/vVMg/dJIQpl193Lx4t4i1UP1EeR1JLehyxbxoMeDuWAGS3U8UQFHbuVU/35kh1TmkzTs6iPw11sxoYJKj8MQ25cFlfLYcMY5CxAWW4GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuVFX/JVlgPGs+AumHwTkGbvcOmUuPB3sEXjAHYCwdM=;
 b=Rx4lbNu4EjG2JoeIs/ha6qL5y7k4CNf1fO0jgob8siI/F0VFb5SjQNCRONdQhLGsBQ0wE8msz/gxfhx1CKPa4pObtl/TTbEWwIOhZSYR/wsCHvOtgJdsM/kwuigWnvbR5pTIh3aSFTPoyd1S7wTFrede/WZFhuOGmqH5xxyhaCU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB7PR04MB4091.eurprd04.prod.outlook.com (2603:10a6:5:1e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Mon, 29 Jun
 2020 15:19:26 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 15:19:26 +0000
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
Thread-Index: AQHWTdthV6wfzmMopU6pSRFnxqvg3qjvd4YAgAACQ6CAABqKgIAAAHBggAAdugCAAAKowA==
Date:   Mon, 29 Jun 2020 15:19:26 +0000
Message-ID: <DB3PR0402MB39167F7746B4B3794600FC7FF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1593410042-10598-1-git-send-email-Anson.Huang@nxp.com>
 <1593410042-10598-5-git-send-email-Anson.Huang@nxp.com>
 <CAK8P3a2yXFbGxuSRoC5_dYBujnAtVoEMXe50V7QYjPYhqra7nA@mail.gmail.com>
 <DB3PR0402MB39160335642AFBAC4B38C511F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a0CcijnVxJws_kMiaOBbc4Uox40W4=-dX+BG6OeMYtFpw@mail.gmail.com>
 <DB3PR0402MB39167D9A3897C3CE327EBDDBF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a1cYsgJu+JCrmQw-VQyAKpyOz7fpOf3jBZ7QKc=urUFtw@mail.gmail.com>
In-Reply-To: <CAK8P3a1cYsgJu+JCrmQw-VQyAKpyOz7fpOf3jBZ7QKc=urUFtw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ea7c7ad0-d837-4918-364d-08d81c3fcfdf
x-ms-traffictypediagnostic: DB7PR04MB4091:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB4091CED7B398120DF19CDD43F56E0@DB7PR04MB4091.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cnrkKr8XG5s9zDylc+TEZKS+1v6BgE6VDComTUMTIowijji+5swsewpK8NLSmEncsmFmujfM8scjOjf0aPvEUR31Q5gxXoehZ1rsFjgK18Od2s0EI+sFN6nPuLMxudAEVoECCsx2Nqzrktop7JcUQx0QcgbgkGkfHSn7Tmd1CmkjsSJylZN9Qi2DlcEdIZbxxqnbtObD/DietiZyHf3o2DwhOSDmVA2ynPSvzi+oLDlrgVrEg+WUZQwFjM9QcBK+PC086blayeImjLVMog8ipUngxkJ2mneQ8HbLyaAbS+b4CijOaVFADoZcEYyd/fnhmgwLW+66ZWnQsxwkIKsSxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(6916009)(76116006)(44832011)(7696005)(7416002)(86362001)(26005)(6506007)(53546011)(186003)(83380400001)(8936002)(54906003)(316002)(71200400001)(5660300002)(66946007)(66476007)(66556008)(64756008)(66446008)(8676002)(52536014)(2906002)(9686003)(33656002)(55016002)(4326008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 5YFszmwIoV/aMwba8eohGObaRYYZAAMtHk5QoYSa1Z9oZNhSFmbJOjAydYklTQUrMMywoGWkXuFJcE5ivTDWDAT50T11+4XH2S2lkl3zCUi58TE3mFv2M6Aw8sHxjDlI00tB7FWkTRK/N93nwoeKpK+7+nHy2jG7MrDk2WYM1V2PaOb6H7BMcBudUm8NfDoyneUgfJYA9E2vrZCNmq5X70qWMDukYFiMPbTuETBJP9zgyUihzb7mLUrCjUGsYo1B6uF14xhVAtAlyBgnUsxU6Pkmifk7a8lv8YhCw06y6cOYxaOh23u2WuC6Vd+tUyfU6S12RZUHld5JC08f818c6eeSZmkuOndwHKg8w245B0BEB+QeFsWsfUbpi/PyrqTiZ+fnjb5wj7OfrHqqEZhYrSOc5dIWwgNX3jlImoiencSeAFfQFhOE9UyuS5raLjsFwUSxk3p66VO9URbx6iFoBXlV9sZY/GLDB2x17g35JBbEFBmUbpbXVI1FXQCHVSMH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea7c7ad0-d837-4918-364d-08d81c3fcfdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 15:19:26.8055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DBTO7dI9CXySL683PcHBvYAEUjxEq7zVu25q+J4CHhA4ruJhAQ5iiIzKeIJGra7mCwZR1q2Oi0w0uI4M9/0Mpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFybmQNCg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMDQvMTBdIGNsazogaW14OiBT
dXBwb3J0IGJ1aWxkaW5nIFNDVSBjbG9jayBkcml2ZXIgYXMNCj4gbW9kdWxlDQo+IA0KPiBPbiBN
b24sIEp1biAyOSwgMjAyMCBhdCA0OjUyIFBNIEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAu
Y29tPg0KPiB3cm90ZToNCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMDQvMTBdIGNsazog
aW14OiBTdXBwb3J0IGJ1aWxkaW5nIFNDVSBjbG9jaw0KPiA+ID4gZHJpdmVyIGFzIG1vZHVsZSBP
biBNb24sIEp1biAyOSwgMjAyMCBhdCAyOjUzIFBNIEFuc29uIEh1YW5nDQo+IDxhbnNvbi5odWFu
Z0BueHAuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBTb3JyeSwgSSBtaXNyZWFkIHRoZSBwYXRj
aCBpbiBtdWx0aXBsZSB3YXlzLiBGaXJzdCBvZiBhbGwsIHlvdQ0KPiA+ID4gYWxyZWFkeSBwdXQg
Y2xrLXNjdS5vIGFuZCBjbGstbHBjZy1zY3UubyBmaWxlcyBpbnRvIGEgY29tYmluZWQNCj4gPiA+
IGxvYWRhYmxlIG1vZHVsZSwgYW5kIEkgaGFkIG9ubHkgbG9va2VkIGF0IGNsay1zY3UuYy4NCj4g
PiA+DQo+ID4gPiBXaGF0IEkgYWN0dWFsbHkgbWVhbnQgaGVyZSB3YXMgdG8gbGluayBjbGstc2N1
Lm8gdG9nZXRoZXIgd2l0aA0KPiA+ID4gY2xrLWlteDhxeHAubyAoYW5kIHBvc3NpYmx5IGZ1dHVy
ZSBjaGlwLXNwZWNpZmljIGZpbGVzKSBpbnRvIGENCj4gPiA+IGxvYWRhYmxlIG1vZHVsZSBhbmQg
ZHJvcCB0aGUgZXhwb3J0Lg0KPiA+DQo+ID4gU29ycnksIGNvdWxkIHlvdSBwbGVhc2UgYWR2aXNl
IG1vcmUgZGV0YWlscyBhYm91dCBob3cgdG8gZG8gaXQgaW4gTWFrZWZpbGU/DQo+ID4gSSB0cmll
ZCBiZWxvdyBidXQgaXQgbG9va3MgbGlrZSBOT1Qgd29ya2luZy4gbXVsdGlwbGUgZGVmaW5pdGlv
biBvZg0KPiBtb2R1bGVfaW5pdCgpIGVycm9yIHJlcG9ydGVkLg0KPiA+DQo+ID4gb2JqLSQoQ09O
RklHX01YQ19DTEtfU0NVKSA6PSBjbGstaW14Lm8gY2xrLWlteC15ICs9IGNsay1zY3Uubw0KPiA+
IGNsay1scGNnLXNjdS5vDQo+ID4gY2xrLWlteC0kKENPTkZJR19DTEtfSU1YOFFYUCkgKz0gY2xr
LWlteDhxeHAubyBjbGstaW14OHF4cC1scGNnLm8NCj4gDQo+IFJpZ2h0LCB5b3UgY2FuJ3QgaGF2
ZSBtdWx0aXBsZSBtb2R1bGVfaW5pdCgpIGluIGEgbW9kdWxlLCBzbyB3aGF0IEkgc3VnZ2VzdGVk
DQo+IGVhcmxpZXIgd29uJ3Qgd29yayBhbnkgbW9yZSBhcyBzb29uIGFzIHlvdSBhZGQgYSBzZWNv
bmQgY2hpcCB0aGF0IHVzZXMgdGhlDQo+IGNsay1zY3UgZHJpdmVyLCBhbmQgdGhlbiB5b3UgaGF2
ZSB0byB1c2Ugc2VwYXJhdGUgbW9kdWxlcywgb3Igc29tZSBoYWNrIHRoYXQNCj4gY2FsbHMgdGhl
IGluaXQgZnVuY3Rpb25zIG9uZSBhdCBhIHRpbWUsIHdoaWNoIGlzIHByb2JhYmx5IHdvcnNlLg0K
PiANCj4gSWYgaXQncyBvbmx5IGlteDhxeHAsIHlvdSBjYW4gZG8gaXQgbGlrZSB0aGlzOg0KPiAN
Cj4gb2JqLSQoQ09ORklHX01YQ19DTEtfU0NVKSA6PSBjbGstaW14LXNjdS5vIGNsay1pbXgtbHBj
Zy5vDQo+IGNsay1pbXgtc2N1LXkgICAgICAgICArPSBjbGstc2N1Lm8gY2xrLWlteDhxeHAubw0K
PiBjbGstaW14LWxwY3Etc2N1LXkgKz0gY2xrLWxwY2ctc2N1Lm8gY2xrLWlteDhxeHAtbHBjZy5v
DQo+IA0KPiBJZiB5b3UgYWxyZWFkeSBrbm93IHRoYXQgdGhlIHNjdSBkcml2ZXIgaXMgZ29pbmcg
dG8gYmUgdXNlZCBpbiBmdXR1cmUgY2hpcHMsIHRoZW4NCj4ganVzdCBzdGF5IHdpdGggd2hhdCB5
b3UgaGF2ZSBub3csIHVzaW5nIGEgc2VwYXJhdGUgbW9kdWxlIHBlciBmaWxlLCBleHBvcnRpbmcN
Cj4gdGhlIHN5bWJvbHMgYXMgbmVlZGVkLg0KPiANCg0KVGhhbmtzLCBhbmQgeWVzLCBJIGtub3cg
dGhhdCBzY3UgY2xrIGRyaXZlciB3aWxsIGJlIHVzZWQgZm9yIGZ1dHVyZSBpLk1YOFggY2hpcHMg
d2l0aA0KU0NVIGluc2lkZSwgdGhlIGN1cnJlbnQgaS5NWDhRWFAgY2xvY2sgZHJpdmVyIGNhbiBO
T1QgY292ZXIgYWxsIGkuTVg4WCBjaGlwcywgc28NCkkgd2lsbCBzdGF5IHdpdGggdGhlIGV4cG9y
dGluZyBzeW1ib2xzLg0KDQpUaGFua3MsDQpBbnNvbg0K
