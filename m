Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE09C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBFF24697
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="Rn/4Dgdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgB1QuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:50:08 -0500
Received: from mail-vi1eur05on2108.outbound.protection.outlook.com ([40.107.21.108]:48769
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725886AbgB1QuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:50:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2/V114B/YV2ZHV/jOQgD49/6bo0zQjqwvEP6Rwl9pKHVYoxWsueO/Wftoe9b8IoGdq0/mtzn3l3aOy463djXthBw8DYXS8dF5BZi6ijd4rCVfzVGGw8B8zcAQF8i+5MgQdw6VnESneSlGZZGwInbtk6R6sMX/+oCnt80sqtzXUA2nIWIQ5FC4kTUC7A2Y+5YryaJuYjZLpphkeLQcjLJyPlVC7ZcqXZt4Q1acy4SCi0vsjYHha1sV5GMJovmsuN/vRvSYr3OQwXxb4r0bArwjvDkLYL3MAP133stIRS7YuKDUFBIWTZkgb/DiHmYgEmDNN7gA8s83Io7wbOebjscQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMVs4NarvVntfDSCWY+JnqDCgnazupZMO+VX+fHFbLM=;
 b=SWdhAOaEOwb3mjfp4u5NYOnUQHqp1dX3+W7WuetGoud/Z4mWk8ednGGPlUXeYmiizCLlvoQgve1OnN5XG+gZWR5CpNvhw3jKCBICy1M4Fsv1+qpsugzbUmOoFn/f/YqGgKcVznPUMUtPU5LkmFynrpy8oXMvMJDfaZLjczBDM6Lb6pfR16TMZmvScNGR4CzGQ79veMIOVb8MPJSHbQ9kJvG+aXJ7tKE9KKOswBj7kgR3zhhyw3A9rDkRno2nwYrgWOZ02xbXYtSLNExLwV8Vra7jS6wyQ4JgbcojeTUnvlsJ72hQLY8F0WivI0YnKk4Gg20wiBnraQ2ZS8PFWDv0pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMVs4NarvVntfDSCWY+JnqDCgnazupZMO+VX+fHFbLM=;
 b=Rn/4DgdvR3ASjNnxWb2b3ATQnmI/MGsuFtV93B81jwo3FxnwZY2lqwg9P8Kx8zTDEN8sXkBIOVXdFJCnI6n6cz0veZ5+6W/eaJJPL1H/XjF5ljdy9wKQPdD//JpXfN6HNQSlTfVPNXqO8N/CLoPWsfjIl3YG5PB4M5AXWxKWMEY=
Received: from VI1PR05MB6845.eurprd05.prod.outlook.com (10.186.163.80) by
 VI1PR05MB5566.eurprd05.prod.outlook.com (20.177.203.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.22; Fri, 28 Feb 2020 16:49:28 +0000
Received: from VI1PR05MB6845.eurprd05.prod.outlook.com
 ([fe80::c13:1d07:fa02:6eeb]) by VI1PR05MB6845.eurprd05.prod.outlook.com
 ([fe80::c13:1d07:fa02:6eeb%7]) with mapi id 15.20.2772.018; Fri, 28 Feb 2020
 16:49:28 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "igor.opaniuk@gmail.com" <igor.opaniuk@gmail.com>
CC:     Max Krummenacher <max.krummenacher@toradex.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Igor Opanyuk <igor.opanyuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Stefan Agner <stefan.agner@toradex.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/5] arm: dts: imx7: toradex: use
 SPDX-License-Identifier
Thread-Topic: [PATCH v1 2/5] arm: dts: imx7: toradex: use
 SPDX-License-Identifier
Thread-Index: AQHV6zhsWAnAhBt5tU6VbDcnIzSSGKgw16MA
Date:   Fri, 28 Feb 2020 16:49:28 +0000
Message-ID: <7b84445d42f4f6522c25a92353408a72c4255b06.camel@toradex.com>
References: <1582565548-20627-1-git-send-email-igor.opaniuk@gmail.com>
         <1582565548-20627-2-git-send-email-igor.opaniuk@gmail.com>
In-Reply-To: <1582565548-20627-2-git-send-email-igor.opaniuk@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [81.221.74.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 208c16a3-729a-4d49-a481-08d7bc6e2d27
x-ms-traffictypediagnostic: VI1PR05MB5566:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB556621B266CA1A786591DCF1FBE80@VI1PR05MB5566.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(39850400004)(366004)(136003)(376002)(189003)(199004)(5660300002)(2906002)(8936002)(44832011)(110136005)(6512007)(71200400001)(316002)(6486002)(81156014)(81166006)(2616005)(7416002)(36756003)(8676002)(54906003)(86362001)(66556008)(6506007)(4326008)(66476007)(66446008)(66946007)(26005)(91956017)(64756008)(76116006)(478600001)(186003)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5566;H:VI1PR05MB6845.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: POk7lTFX3gL5eofFUAZtH8aKn4NoVHLYQSlRtLdGt88wJvApT8YUFKnX4B69vo/g+dcARCaTZt4hURTuuddBg940DvMz+OWjuHi7PxenlrzeF1ore5xoCbGI0VxSwakuX/CYAi4bpo/QVZFKjpTSKuCwQDoSLVqsUPYsaNO7UJcN/I7u45j6/Ecvyuvg8NtwoLw1E0iJsM0N1BzvFxQtB0bcqsChNBHOOGCEYggWxgB3u4BhdzpthZnoqbzvbPSkZwM7N6bclHUJguGVIbhhbaROea0tAsrNuzArk5yamMglFEUVyH21nndi4BGKvtlhzemXiq8BGPj2Q7t/k6QTmfQ/ZUwPjlT4T/bcwcll7/przerXnpHZJ5t6Lt1/03boo9/9JQtW1S7F0adO8UaUxy7/UJKhmUc0UJ0lepoHHFLdNOPagblBmrkgO6LxEkdZOg8PlGSM7j9HmJ2ya9YFULUMo8Y24qEEX9KGh0DsXl8=
x-ms-exchange-antispam-messagedata: KqSZretZks2ayz0FGXKkZ9z0PlybMDgOT+xSFNHEou6SEnPczpLeJ425gSC04P/HnNACIcWsFYcKpmph/mVVeIkFGXNX8p9Uu+F8s5YLyp+cF6khiCHjRGJRuq13RwfuZ6JWrnE87dFq9uHviO0ikA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <89113E4E5F601749B7686475940CDB8E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 208c16a3-729a-4d49-a481-08d7bc6e2d27
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 16:49:28.5186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y1c/hwdMv9CMRyVy2Wetp9IJbu3scEAHonrRAuoR1seGUl9TYD4CZW2PIDtRMqm+iUKDUncilT0TAVO9lxMazFzJC0A74LEON8zSaLu/ags=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5566
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSWdvcg0KDQpPbiBNb24sIDIwMjAtMDItMjQgYXQgMTk6MzIgKzAyMDAsIElnb3IgT3Bhbml1
ayB3cm90ZToNCj4gRnJvbTogSWdvciBPcGFuaXVrIDxpZ29yLm9wYW5pdWtAdG9yYWRleC5jb20+
DQo+IA0KPiAxLiBSZXBsYWNlIGJvaWxlciBwbGF0ZSBsaWNlbnNlcyB0ZXh0cyB3aXRoIHRoZSBT
UERYIGxpY2Vuc2UNCj4gaWRlbnRpZmllcnMgaW4gVG9yYWRleCBpLk1YNy1iYXNlZCBTb00gZGV2
aWNlIHRyZWVzLg0KPiAyLiBBcyBYMTEgaXMgaWRlbnRpY2FsIHRvIHRoZSBNSVQgTGljZW5zZSwg
YnV0IHdpdGggYW4gZXh0cmEgc2VudGVuY2UNCj4gdGhhdCBwcm9oaWJpdHMgdXNpbmcgdGhlIGNv
cHlyaWdodCBob2xkZXJzJyBuYW1lcyBmb3IgYWR2ZXJ0aXNpbmcgb3INCj4gcHJvbW90aW9uYWwg
cHVycG9zZXMgd2l0aG91dCB3cml0dGVuIHBlcm1pc3Npb24sIHVzZSBNSVQgbGljZW5zZQ0KPiBp
bnN0ZWFkDQo+IG9mIFgxMSAoJ3MvWDExL01JVC9nJykuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBJ
Z29yIE9wYW5pdWsgPGlnb3Iub3Bhbml1a0B0b3JhZGV4LmNvbT4NCj4gLS0tDQo+IA0KPiAgYXJj
aC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJpLWV2YWwtdjMuZHRzaSB8IDQxICsrLS0tLS0tLS0t
LS0tLS0tLS0NCj4gLS0tLS0tLS0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJp
LmR0c2kgICAgICAgICB8IDQxICsrLS0tLS0tLS0tLS0tLS0tLS0NCj4gLS0tLS0tLS0tLQ0KPiAg
YXJjaC9hcm0vYm9vdC9kdHMvaW14N2QtY29saWJyaS1ldmFsLXYzLmR0cyB8IDQxICsrLS0tLS0t
LS0tLS0tLS0tLS0NCj4gLS0tLS0tLS0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14N2QtY29s
aWJyaS5kdHNpICAgICAgICB8IDQxICsrLS0tLS0tLS0tLS0tLS0tLS0NCj4gLS0tLS0tLS0tLQ0K
PiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14N3MtY29saWJyaS1ldmFsLXYzLmR0cyB8IDQxICsrLS0t
LS0tLS0tLS0tLS0tLS0NCj4gLS0tLS0tLS0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14N3Mt
Y29saWJyaS5kdHNpICAgICAgICB8IDQxICsrLS0tLS0tLS0tLS0tLS0tLS0NCj4gLS0tLS0tLS0t
LQ0KPiAgNiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAyMzQgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14Ny1jb2xpYnJpLWV2YWwt
djMuZHRzaQ0KPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDctY29saWJyaS1ldmFsLXYzLmR0c2kN
Cj4gaW5kZXggNmFhMTIzYy4uMGVjMmI4MSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9k
dHMvaW14Ny1jb2xpYnJpLWV2YWwtdjMuZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9p
bXg3LWNvbGlicmktZXZhbC12My5kdHNpDQo+IEBAIC0xLDQzICsxLDYgQEANCj4gKy8vIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKyBPUiBNSVQNCj4gIC8qDQo+IC0gKiBDb3B5cmln
aHQgMjAxNiBUb3JhZGV4IEFHDQo+IC0gKg0KPiAtICogVGhpcyBmaWxlIGlzIGR1YWwtbGljZW5z
ZWQ6IHlvdSBjYW4gdXNlIGl0IGVpdGhlciB1bmRlciB0aGUgdGVybXMNCj4gLSAqIG9mIHRoZSBH
UEwgb3IgdGhlIFgxMSBsaWNlbnNlLCBhdCB5b3VyIG9wdGlvbi4gTm90ZSB0aGF0IHRoaXMNCj4g
ZHVhbA0KPiAtICogbGljZW5zaW5nIG9ubHkgYXBwbGllcyB0byB0aGlzIGZpbGUsIGFuZCBub3Qg
dGhpcyBwcm9qZWN0IGFzIGENCj4gLSAqIHdob2xlLg0KPiAtICoNCj4gLSAqICBhKSBUaGlzIGZp
bGUgaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yDQo+IC0g
KiAgICAgbW9kaWZ5IGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGlj
IExpY2Vuc2UNCj4gYXMNCj4gLSAqICAgICBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUg
Rm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMg0KPiBvZiB0aGUNCj4gLSAqICAgICBMaWNlbnNl
LCBvciAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9uLg0KPiAtICoNCj4gLSAqICAg
ICBUaGlzIGZpbGUgaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVz
ZWZ1bCwNCj4gLSAqICAgICBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0
aGUgaW1wbGllZCB3YXJyYW50eQ0KPiBvZg0KPiAtICogICAgIE1FUkNIQU5UQUJJTElUWSBvciBG
SVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUNCj4gLSAqICAgICBHTlUg
R2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLg0KPiAtICoNCj4gLSAqIE9y
LCBhbHRlcm5hdGl2ZWx5LA0KPiAtICoNCj4gLSAqICBiKSBQZXJtaXNzaW9uIGlzIGhlcmVieSBn
cmFudGVkLCBmcmVlIG9mIGNoYXJnZSwgdG8gYW55IHBlcnNvbg0KPiAtICogICAgIG9idGFpbmlu
ZyBhIGNvcHkgb2YgdGhpcyBzb2Z0d2FyZSBhbmQgYXNzb2NpYXRlZA0KPiBkb2N1bWVudGF0aW9u
DQo+IC0gKiAgICAgZmlsZXMgKHRoZSAiU29mdHdhcmUiKSwgdG8gZGVhbCBpbiB0aGUgU29mdHdh
cmUgd2l0aG91dA0KPiAtICogICAgIHJlc3RyaWN0aW9uLCBpbmNsdWRpbmcgd2l0aG91dCBsaW1p
dGF0aW9uIHRoZSByaWdodHMgdG8gdXNlLA0KPiAtICogICAgIGNvcHksIG1vZGlmeSwgbWVyZ2Us
IHB1Ymxpc2gsIGRpc3RyaWJ1dGUsIHN1YmxpY2Vuc2UsIGFuZC9vcg0KPiAtICogICAgIHNlbGwg
Y29waWVzIG9mIHRoZSBTb2Z0d2FyZSwgYW5kIHRvIHBlcm1pdCBwZXJzb25zIHRvIHdob20NCj4g
dGhlDQo+IC0gKiAgICAgU29mdHdhcmUgaXMgZnVybmlzaGVkIHRvIGRvIHNvLCBzdWJqZWN0IHRv
IHRoZSBmb2xsb3dpbmcNCj4gLSAqICAgICBjb25kaXRpb25zOg0KPiAtICoNCj4gLSAqICAgICBU
aGUgYWJvdmUgY29weXJpZ2h0IG5vdGljZSBhbmQgdGhpcyBwZXJtaXNzaW9uIG5vdGljZSBzaGFs
bA0KPiBiZQ0KPiAtICogICAgIGluY2x1ZGVkIGluIGFsbCBjb3BpZXMgb3Igc3Vic3RhbnRpYWwg
cG9ydGlvbnMgb2YgdGhlDQo+IFNvZnR3YXJlLg0KPiAtICoNCj4gLSAqICAgICBUSEUgU09GVFdB
UkUgSVMgUFJPVklERUQgIkFTIElTIiwgV0lUSE9VVCBXQVJSQU5UWSBPRiBBTlkNCj4gS0lORCwN
Cj4gLSAqICAgICBFWFBSRVNTIE9SIElNUExJRUQsIElOQ0xVRElORyBCVVQgTk9UIExJTUlURUQg
VE8gVEhFDQo+IFdBUlJBTlRJRVMNCj4gLSAqICAgICBPRiBNRVJDSEFOVEFCSUxJVFksIEZJVE5F
U1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFIEFORA0KPiAtICogICAgIE5PTklORlJJTkdFTUVO
VC4gSU4gTk8gRVZFTlQgU0hBTEwgVEhFIEFVVEhPUlMgT1IgQ09QWVJJR0hUDQo+IC0gKiAgICAg
SE9MREVSUyBCRSBMSUFCTEUgRk9SIEFOWSBDTEFJTSwgREFNQUdFUyBPUiBPVEhFUiBMSUFCSUxJ
VFksDQo+IC0gKiAgICAgV0hFVEhFUiBJTiBBTiBBQ1RJT04gT0YgQ09OVFJBQ1QsIFRPUlQgT1Ig
T1RIRVJXSVNFLCBBUklTSU5HDQo+IC0gKiAgICAgRlJPTSwgT1VUIE9GIE9SIElOIENPTk5FQ1RJ
T04gV0lUSCBUSEUgU09GVFdBUkUgT1IgVEhFIFVTRSBPUg0KPiAtICogICAgIE9USEVSIERFQUxJ
TkdTIElOIFRIRSBTT0ZUV0FSRS4NCj4gKyAqIENvcHlyaWdodCAyMDE2LTIwMjAgVG9yYWRleCBB
Rw0KDQpKdXN0IGRyb3AgdGhlIEFHIGhlcmUgYW5kIGluIGFsbCBvdGhlciBmaWxlcy4NCg0KVGhh
bmtzIQ0KDQpDaGVlcnMNCg0KTWFyY2VsDQo=
