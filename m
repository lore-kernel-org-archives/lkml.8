Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41264C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B012207E8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gbygk4yK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgGBGmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 02:42:35 -0400
Received: from mail-eopbgr130089.outbound.protection.outlook.com ([40.107.13.89]:34372
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726092AbgGBGme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 02:42:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0BSkjPFHwOWwQgyoJBwnCEPjAu072MXKkJLdBOFq7vnN3t1ci3nKxSd353gwZcor7lmEijSXWfjyQtNtPnKX/8Ri1Uo0vvBZ+3vidernjmGyoNUvQtg/gsvXrdjsk8nPuGqyEB1/1eBzpqSwTVRR3drIxD3p6aqImCIZJLhUjJp1lHzcqpZfNhEqNz8A2BurXRwqyVq7e9YGCdO3opxQhJG/bLZ9YVSc7Pd6XR/BWWMoHdN4ywrRIJP4AGO8Q1QusLF9lS9svgdNjAs9t3oWcek84iMlJf+1d5HqDaJfMsmJR7PUtDzLtWkaw7s3pytlsxWPDThU6UCdeGkVCvV4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3B3j+lPWgUqBqWSYhJ6EkuerVX6SSBtcX3C9hozVp6M=;
 b=k+4CB46YxSlSFXscnZmAiZKbtu2hZhhwIFT1izYbE563MQcNo3+et7l3smIfxW9r/1jIF07JiAKgsRHHcBrnHKTpAYZBABJR/u56828aHlmmb0w6gpVjfRGH62YklcxynVyjcBcqGEpiSnvldNH/oALHTFHDTfLaBoZj72+qWnDz3JI1ctH5LQkuROiiNXLwQpPXAik9lj5JsoHKYRkZx+sOFYdoMbLZlS/itlf4Vlv3LEnc1LI0lbU5BwT1Dey0F/iJVpvSXr1FapaT7eugW9atlxhtPnEcaJnT70+Idzeep33SrVkp4zGx0m9J9KCrooraQLB7Vb/+W5cilt6igQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3B3j+lPWgUqBqWSYhJ6EkuerVX6SSBtcX3C9hozVp6M=;
 b=gbygk4yKPo5lFxDpBWBDQCsG+9hvyAGuOSU8x3U/G5x9kvLuBBRcIuOGsnO8ZS+nGBT7y+7kNy0uGVX0QBONMoXDyP1ZuFE6Nowax0O0wY2JCS0SoyNp4DaKaiwfVFD9jqJ6UJ7Ru/81L9Z8uAMlfnuWu6N+SGdjoGisIisbAPM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3659.eurprd04.prod.outlook.com (2603:10a6:8:5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Thu, 2 Jul
 2020 06:42:28 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3131.036; Thu, 2 Jul 2020
 06:42:28 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Dong Aisheng <dongas86@gmail.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Peng Fan <peng.fan@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 3/5] clk: imx: Support building i.MX common clock
 driver as module
Thread-Topic: [PATCH V4 3/5] clk: imx: Support building i.MX common clock
 driver as module
Thread-Index: AQHWUBb/eaArIN5lW0eg3m9Qeje+NajzluoAgAAJBACAACXUAIAABbYggAAHpQCAAAQnIA==
Date:   Thu, 2 Jul 2020 06:42:28 +0000
Message-ID: <DB3PR0402MB391633332EFC1A9B9B62FA76F56D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1593656074-10092-1-git-send-email-Anson.Huang@nxp.com>
 <1593656074-10092-4-git-send-email-Anson.Huang@nxp.com>
 <CAA+hA=S0G7Na0ieEpPq3aN6GN1BEHtYp9vbF9x2tjmknDSVjZw@mail.gmail.com>
 <DB3PR0402MB391610595D40C11CF26CD990F56D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAA+hA=Rtkm_FpkoBvHNnB0TSeTrqXaRVwOzkywsL7QO6ec_K7Q@mail.gmail.com>
 <AM6PR0402MB3911049CC1B136327345F11CF56D0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
 <CAA+hA=S9ENXtD7q362=y84qKAtR090pZOd6MF6uN8W223UK-+Q@mail.gmail.com>
In-Reply-To: <CAA+hA=S9ENXtD7q362=y84qKAtR090pZOd6MF6uN8W223UK-+Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 58d15653-2cfc-418a-342b-08d81e5316e1
x-ms-traffictypediagnostic: DB3PR0402MB3659:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB36590920F8C5CA84F9D51524F56D0@DB3PR0402MB3659.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kAktfD4AllG0IJ9G8Zqr06HlYTSap4UTyYe+3XNAf+439OaPI34gccOAHvbLUbNTRVhbfHbbcdme29Ply5fMgsITKlFOJG3DTYk0gh5ms67I+pmjOBBX+UdUuGAibNNl4bFYm5uA0NDlo2DaU2mYmsr7IYGEG1HbWze/0OizYuAujyfvoAU6PPgIadZDCdQeT1zDT9fKVi7ihLH963a1wCKnT9RnxuGyBE1p0EdpJTMFq5cMrJK+3q3ul7wU8GYIk9ju0Zk5TCZwC+uQvIHiImJ9yvuq09v0L5Dj48hdNVNy9RSi8VSTQFlCNe0uY0ey1sVIEopvJ67fwYqnCiT52Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(76116006)(26005)(9686003)(83380400001)(54906003)(316002)(86362001)(478600001)(6916009)(7696005)(7416002)(8936002)(4326008)(71200400001)(8676002)(33656002)(52536014)(66946007)(64756008)(66556008)(66446008)(66476007)(186003)(53546011)(6506007)(2906002)(55016002)(44832011)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ctfR4s3GQkShl7m7hvTWXFO04AGnkPXssTBI2m09n8/WCFLlwgkvyyL66I/OoXcxj/RXZ5D9aMoyvL7wW3XZGxhsCT+oeD3DCh7gY+aWFn1oFKstoGU4vcyiMn8Cp09vpFnB7ViqU5vxcGI0i/MzdJz8zb0eanuN8OhsFxjfYB+ThLgPZ3LtdhRgH2q1B3KeRtLCY9qE2stecyTYEQfyp/7C5ckcbzzZ62EjtzvBJCE53amGcN86GynJ3QB+uzz4QUuWgNuLG/qnDxHhCwFZpIx8oUznWCW8u4uW+0TkDM8twL+jlcfxaogfFRQ/wSugtie6b4wtAtNv43g6NXxxD+hRLIq8Sd5Y0lMzK3h3+8oFzT+MxC6s+gweM0pOlYX/iTxaSh6OL7FLD2RU7wGr0y/UVqnBCe5CDlf2Tymo86xI3MfnwOublYAXWCblKmlgEKeL6fdBDDpPTZ4pzau8yx4duZKMrx4q5YKJkFdFt8MZONWu7XtjSH4I8UR7g3dq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d15653-2cfc-418a-342b-08d81e5316e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 06:42:28.6582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pdMTF1byIq3boBfLY05d9YKNdwSSqXpKDQYO/XtKh/8KSzG/GaM+9JDVniY6gXvpsAOToOf6jPiRxdZme8pwSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWNCAzLzVdIGNsazogaW14OiBTdXBwb3J0IGJ1aWxk
aW5nIGkuTVggY29tbW9uIGNsb2NrDQo+IGRyaXZlciBhcyBtb2R1bGUNCj4gDQo+IE9uIFRodSwg
SnVsIDIsIDIwMjAgYXQgMjoxMSBQTSBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4g
d3JvdGU6DQo+ID4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjQgMy81XSBjbGs6IGlteDog
U3VwcG9ydCBidWlsZGluZyBpLk1YIGNvbW1vbg0KPiA+ID4gY2xvY2sgZHJpdmVyIGFzIG1vZHVs
ZQ0KPiA+ID4NCj4gPiA+IE9uIFRodSwgSnVsIDIsIDIwMjAgYXQgMTE6MjYgQU0gQW5zb24gSHVh
bmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+ID4gPiB3cm90ZToNCj4gPiA+IFsuLi5dDQo+ID4g
PiA+ID4gPiBAQCAtMTQzLDE2ICsxNDgsMTggQEAgdm9pZCBpbXhfY3NjbXIxX2ZpeHVwKHUzMiAq
dmFsKSAgc3RhdGljDQo+ID4gPiA+ID4gPiBpbnQgaW14X2tlZXBfdWFydF9jbG9ja3M7ICBzdGF0
aWMgc3RydWN0IGNsayAqKiBjb25zdA0KPiA+ID4gPiA+ID4gKmlteF91YXJ0X2Nsb2NrczsNCj4g
PiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAtc3RhdGljIGludCBfX2luaXQgaW14X2tlZXBfdWFydF9j
bG9ja3NfcGFyYW0oY2hhciAqc3RyKQ0KPiA+ID4gPiA+ID4gK3N0YXRpYyBpbnQgX19tYXliZV91
bnVzZWQgaW14X2tlZXBfdWFydF9jbG9ja3NfcGFyYW0oY2hhcg0KPiA+ID4gPiA+ID4gKypzdHIp
DQo+ID4gPiA+ID4gPiAgew0KPiA+ID4gPiA+ID4gICAgICAgICBpbXhfa2VlcF91YXJ0X2Nsb2Nr
cyA9IDE7DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gICAgICAgICByZXR1cm4gMDsNCj4gPiA+
ID4gPiA+ICB9DQo+ID4gPiA+ID4gPiArI2lmbmRlZiBNT0RVTEUNCj4gPiA+ID4gPiA+ICBfX3Nl
dHVwX3BhcmFtKCJlYXJseWNvbiIsIGlteF9rZWVwX3VhcnRfZWFybHljb24sDQo+ID4gPiA+ID4g
PiAgICAgICAgICAgICAgIGlteF9rZWVwX3VhcnRfY2xvY2tzX3BhcmFtLCAwKTsNCj4gPiA+ID4g
PiA+IF9fc2V0dXBfcGFyYW0oImVhcmx5cHJpbnRrIiwgaW14X2tlZXBfdWFydF9lYXJseXByaW50
aywNCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgaW14X2tlZXBfdWFydF9jbG9ja3NfcGFyYW0s
IDApOw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSSBmZWVsIG5vdCBvbmx5IHRoZSBfX3NldHVwX3Bh
cmFtLCB0aGUgd2hvbGUgbG9naWMgb2YNCj4gPiA+ID4gPiBrZWVwX3VhcnRfY2xvY2tzIGFyZSBu
b3QgbmVlZGVkIGZvciBNb2R1bGUgY2FzZS4gSXMgaXQgdHJ1ZT8NCj4gPiA+ID4NCj4gPiA+ID4g
WWVzLCBidXQgdGhlICdrZWVwX3VhcnRfY2xvY2tzJyBpcyBmYWxzZSBieSBkZWZhdWx0IGFuZCB0
aGUNCj4gPiA+ID4gZnVuY3Rpb24NCj4gPiA+ID4gaW14X2tlZXBfdWFydF9jbG9ja3NfcGFyYW0o
KSBhbHJlYWR5IGhhcyAnX19tYXliZV91bnVzZWQnLCBpdCBkb2VzDQo+ID4gPiA+IE5PVCBpbXBh
Y3QgYW55dGhpbmcgaWYgaXQgaXMgZm9yIG1vZHVsZSBidWlsZCwgc28gSSBkaWQgTk9UIGFkZA0K
PiA+ID4gPiB0aGUgI2lmbmRlZiBjaGVjaw0KPiA+ID4gZm9yIHRoZW0sIGp1c3QgdG8ga2VlcCBj
b2RlIGVhc3kgYW5kIGNsZWFuLg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IElNSE8gZG8gbm90IGNv
bXBpbGUgdGhlbSBpcyBhIG1vcmUgZWFzeSBhbmQgY2xlYW4gd2F5LiBUaGVuIHVzZXJzDQo+ID4g
PiBkb24ndCBoYXZlIHRvIGxvb2sgaW50byB0aGUgY29kZSBsb2dpYyB3aGljaCBpcyBtZWFpbmds
ZXNzIGZvciBNb2R1bGUgY2FzZS4NCj4gPiA+DQo+ID4gPiBCVFcsIGl0IHJlYWxseSBkb2VzIG5v
dCBtYWtlIGFueSBzZW5zZSB0byBvbmx5IGNvbmRpb25hbGx5IGNvbXBpbGUNCj4gPiA+IF9fc2V0
dXBfcGFybSgpIGJ1dCBsZWZ0DQo+ID4gPiB0aGUgcGFyYW0gZnVuY3Rpb25zIGRlZmluaXRpb24g
dG8gYmUgaGFuZGxlZCBieSBfX21heWJlX3VubnVzZWQuDQo+ID4gPiBUaGV5J3JlIHRvZ2V0aGVy
IHBhcnQgb2YgY29kZSwgYXJlbid0IHRoZXk/DQo+ID4NCj4gPiBJIGFtIGZpbmUgb2YgYWRkaW5n
IHRoZSAnI2lmbmRlZiBNT0RVTEUnIHRvIGlteF9jbGtfZGlzYWJsZV91YXJ0KCkgYW5kDQo+ID4g
aW14X2tlZXBfdWFydF9jbG9ja3NfcGFyYW0oKSBhcyB3ZWxsIGluIG5leHQgcGF0Y2ggc2VyaWVz
LiBPdGhlcnMgbGlrZQ0KPiA+ICcgaW14X2tlZXBfdWFydF9jbG9ja3MgJyBhbmQgaW14X3JlZ2lz
dGVyX3VhcnRfY2xvY2tzKCkgbmVlZCB0byBiZSBrZXB0DQo+IGFsd2F5cyBidWlsdCwgc2luY2Ug
dGhleSBhcmUgdXNlZCBieSBlYWNoIGNsb2NrIGRyaXZlciBubyBtYXR0ZXIgYnVpbHQtaW4gb3IN
Cj4gbW9kdWxlIGJ1aWxkLg0KPiA+DQo+ID4gU28gdGhhdCBtZWFucyBJIGhhdmUgdG8gYWRkIGFu
b3RoZXIgJ2lmbmRlZiBNT0RVTEUnIG9yIEkgbmVlZCB0bw0KPiA+IGFkanVzdCBzb21lIGNvZGUg
c2VxdWVuY2UgdG8gbWFrZSB0aG9zZSBjb2RlIGNhbiBiZSBidWlsdC1vdXQgaW4gc2FtZQ0KPiA+
IGJsb2NrIGFuZCBqdXN0IHVzZSBzaW5nbGUgJ2lmbmRlZiBNT0RVTEUnLCBJIHRoaW5rIGFkanVz
dCB0aGUgY29kZSBzZXF1ZW5jZQ0KPiBzaG91bGQgYmUgYmV0dGVyLCB3aWxsIGdvIHdpdGggdGhp
cyB3YXkuDQo+IA0KPiBXaGF0IGlmIHdlICBjb25kaW9uYWxseSBjb21waWxlIGl0IGluIGNsay5o
PyBXaWxsIHRoYXQgYmUgZWFzaXNlcj8NCg0KQWRqdXN0IHRoZSBmdW5jdGlvbiBzZXF1ZW5jZSBs
b29rcyBsaWtlIE5PVCBjb21wbGljYXRlZCwganVzdCBuZWVkIHRvIGV4Y2hhbmdlIHRoZQ0KaW14
X3JlZ2lzdGVyX3VhcnRfY2xvY2tzKCkgYW5kIGlteF9jbGtfZGlzYWJsZV91YXJ0KCksIHRoZW4g
SSBjYW4gdXNlIHNpbmdsZSAnI2lmbmRlZiBNT0RVTEUnLA0Kd2lsbCBnbyB3aXRoIHRoaXMgd2F5
IGluIFY1Lg0KDQpBbnNvbg0K
