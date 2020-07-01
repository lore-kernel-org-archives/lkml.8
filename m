Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C39EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5827620747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="hVVr8O3t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbgGAKwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:52:54 -0400
Received: from mail-vi1eur05on2107.outbound.protection.outlook.com ([40.107.21.107]:7872
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729892AbgGAKwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 06:52:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7Nsax19pJujQ98AMjlVwgz75p6QHzUz/E+Yq0+lSAKvg1hHa8WqDowzXf996o+8ZuzlltCXJOOJEffH19vYaGWQdVsmc6pLoXxWdJnQzNi4RIPia6BqI0YCKneUm8WfnCY54Y+JK11QWGBSo61br8Le4nWpkO0kUbK1k36rLgfY24VY7KJQE3vW+IB/yqLCDFn+JfCvXhMTuwX5OqWmBmVhAV3o8C0cJ7hYj56DV/mBpAi+WuBVx091TaZfYt8YGUPOO4n8zSM8a1qMGHtlHT0rHnPAl7xAlB91iKMI4xyK0t7f6+V7VRt5xq+3LF79whH9G01M2b9Vm44btm3vyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9KRnUBsphRIByOn0qLg8k2kVonp8ERS1wgFEtTykgQ=;
 b=CUV9B/8ep+LyBGXEvBZUinsgdipP0bcTWANgiznq9hmiJgTovwYbqkQUDsbkWgwoGoOvsh5Ef/m0Ax+o0AwXtc9ssg+G7rxM5RpAjN9pjFM9HTVK4MBtvjnCWSkztaAHfiaO7VwXTwWxn+tlkGv6nhN/OzPOuT33UqgAbwJVmU9y+W/ofiDrCpWhpRGiJep3oDSwSWBzrDeiqujcLmssiAJMAYmMawy01Ij8Fuw1Zcj3bp2wL9RMfo8IXjXBp8SKLhQKqgNhRwICKn4JKh1gZU8HQsqc3ufhk1ObyX/291GyoTPZkyDh9p+Nc+y98NvLJygSOg3c/NebWNw7PBS6Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9KRnUBsphRIByOn0qLg8k2kVonp8ERS1wgFEtTykgQ=;
 b=hVVr8O3tSz39xfVHD9SIYfMijETZrHpbSNARmw/LwG1VOYl28zXYAUkcvFk6d+PRTe59yJDCg70bmPFpnXOQnLm30AO58pDsfW3mPTFpS4bRDIm4pbhS4Nl32wUeHlO5ox6OSgap0mxCjbZJdQBA7EvNI3BdjMXDW9LXByh8Ldg=
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com (2603:10a6:20b:a8::25)
 by AM6PR05MB6568.eurprd05.prod.outlook.com (2603:10a6:20b:73::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Wed, 1 Jul
 2020 10:52:47 +0000
Received: from AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d]) by AM6PR05MB6120.eurprd05.prod.outlook.com
 ([fe80::1d81:6a9b:8c26:3b7d%4]) with mapi id 15.20.3153.023; Wed, 1 Jul 2020
 10:52:47 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "peter.chen@nxp.com" <peter.chen@nxp.com>
CC:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Stefan Agner <stefan.agner@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: chipidea: fix ci_irq for role-switching use-case
Thread-Topic: [PATCH] usb: chipidea: fix ci_irq for role-switching use-case
Thread-Index: AQHWS6lpDotuJDHYTE6xfL+NZ7/3sKjvNfGAgAAsA4CAAPWIAIAAvRgAgAD5RwCAAF8YgIAACHyAgAAewAA=
Date:   Wed, 1 Jul 2020 10:52:47 +0000
Message-ID: <978462c57836a20454386c5c477f721416e71583.camel@toradex.com>
References: <20200626110311.221596-1-philippe.schenker@toradex.com>
         <20200629072703.GC30684@b29397-desktop>
         <88f0a5bf564eded8b210457204facdf2c7a9c5dc.camel@toradex.com>
         <20200630004323.GA12443@b29397-desktop>
         <7ee055810cb7c4a06bf978f3d443c908f237c006.camel@toradex.com>
         <20200701025223.GA11041@b29397-desktop>
         <b5c61ae5f17b74624c1e2e4b08fc2fdcd1fb53f6.camel@toradex.com>
         <20200701090305.GB22478@b29397-desktop>
In-Reply-To: <20200701090305.GB22478@b29397-desktop>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.3 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=toradex.com;
x-originating-ip: [31.10.206.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4dea777c-00e8-4992-02fa-08d81dace425
x-ms-traffictypediagnostic: AM6PR05MB6568:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR05MB6568C8525CB1FC11B13E5B56F46C0@AM6PR05MB6568.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RXenQjWSGseprvPu4qKXwCkBzBmPZyi0K2ppCvoyWaM4aWs6Aq7AoYHxVXH+BueCMXpXqms88V5Pf7/UJSjbqTQOHtwvJ9Drykx9w5qJSEYbEFAAgPhcTRLhikrLrR2UVOhvD6C9yAErGr3oaE9kn3L7UtyvtMsiI9v29Osdyy5E0h4CCkm0tF8C5nBkvcx1Zy3cp57OeGXegcr5QbmRhgUifWLpZSywYDDBYTQopm9HAscKEdJ7rNrjQMj3Hu9Jn46035nnIcRGa+HopqNtmQfxMYit/0cn2BRWnV3mGQYKeeX58WXzh3N0Z2Eh73QXIDO6ahuFIXAYcYupJ0wWQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR05MB6120.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(136003)(396003)(39850400004)(83380400001)(44832011)(4326008)(316002)(5660300002)(86362001)(186003)(36756003)(2906002)(6486002)(8936002)(54906003)(66946007)(66476007)(66556008)(64756008)(66446008)(6512007)(26005)(71200400001)(478600001)(91956017)(76116006)(53546011)(2616005)(6506007)(8676002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: aATB9ju/BaCQcwjYQy0GHi+YzdKFMxIbOh114nbLHifs8AdELby8GA4DUuJqZvLNZrwyES0Gayk2MRcrMfe32eSufZ9ajPelTLiO8fynOYIgfiBezPUlWYao+ZzIc2kEnijAKcW+dyQhsWeYpi7vwTs/9ukW4xn8IgFvNNkkA1qubnhnu3dEB9FevJp+8zGIQIRcFstXOJlIIQdcKBzH8qLUxjhRLrK78BH4FLmy6w/pxXvHjBXMgwNmoZiP0JpefvV1e27rTrm4tJnqhCjk3BJNRgIO9v8dRFp66XAtUe8847PfOaSpL1wLWDrk4mGx3/SU4VeXFl7hn6sLi2i6eYAQ86PUcebBC7TtQdVqC1sW1xj+1Nx/rLQySAB4gr3IjjBFgh6+b4U/uft3RvlVXr/hgd0FqNt0oMcaJ1ix6gwXcTHNVWIPAw7EjbRpx72rS0t5lr5mskpWs+e9qN47G/MXecYKL1vpGZyjDy6kiAQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10C4562E9E44DA4697C7117D0CD7B9AA@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR05MB6120.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dea777c-00e8-4992-02fa-08d81dace425
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 10:52:47.0937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: drgnyCdrDFWJoi7NNtpzkgmKHnuGxkmgkRs4lHzNiHZN2Zz53WL+Ye4OKgpPm2ivyq4IOtBW1s1m1IW/5vHVQG+vePYAxl5JHXzSkhgf46Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6568
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA3LTAxIGF0IDA5OjAyICswMDAwLCBQZXRlciBDaGVuIHdyb3RlOg0KPiBP
biAyMC0wNy0wMSAwODozMjoyMiwgUGhpbGlwcGUgU2NoZW5rZXIgd3JvdGU6DQo+ID4gT24gV2Vk
LCAyMDIwLTA3LTAxIGF0IDAyOjUyICswMDAwLCBQZXRlciBDaGVuIHdyb3RlOg0KPiA+ID4gT24g
MjAtMDYtMzAgMTE6NTk6NDksIFBoaWxpcHBlIFNjaGVua2VyIHdyb3RlOg0KPiA+ID4gPiBPbiBU
dWUsIDIwMjAtMDYtMzAgYXQgMDA6NDMgKzAwMDAsIFBldGVyIENoZW4gd3JvdGU6DQo+ID4gPiA+
ID4gT24gMjAtMDYtMjkgMTA6MDQ6MTMsIFBoaWxpcHBlIFNjaGVua2VyIHdyb3RlOg0KPiA+ID4g
PiA+ID4gT24gTW9uLCAyMDIwLTA2LTI5IGF0IDA3OjI2ICswMDAwLCBQZXRlciBDaGVuIHdyb3Rl
Og0KPiA+ID4gPiA+ID4gPiBPbiAyMC0wNi0yNiAxMzowMzoxMSwgUGhpbGlwcGUgU2NoZW5rZXIg
d3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gSWYgdGhlIGhhcmR3YXJlIGlzIGluIGxvdy1wb3dlci1t
b2RlIGFuZCBvbmUgcGx1Z3MgaW4NCj4gPiA+ID4gPiA+ID4gPiBkZXZpY2UNCj4gPiA+ID4gPiA+
ID4gPiBvcg0KPiA+ID4gPiA+ID4gPiA+IGhvc3QNCj4gPiA+ID4gPiA+ID4gPiBpdCBkaWQgbm90
IHN3aXRjaCB0aGUgbW9kZSBkdWUgdG8gdGhlIGVhcmx5IGV4aXQgb3V0IG9mDQo+ID4gPiA+ID4g
PiA+ID4gdGhlDQo+ID4gPiA+ID4gPiA+ID4gaW50ZXJydXB0Lg0KPiA+ID4gPiA+ID4gPiANCj4g
PiA+ID4gPiA+ID4gRG8geW91IG1lYW4gdGhlcmUgaXMgbm8gY29taW5nIGNhbGwgZm9yIHJvbGUt
c3dpdGNoPyBDb3VsZA0KPiA+ID4gPiA+ID4gPiB5b3UNCj4gPiA+ID4gPiA+ID4gcGxlYXNlDQo+
ID4gPiA+ID4gPiA+IHNoYXJlDQo+ID4gPiA+ID4gPiA+IHlvdXIgZHRzIGNoYW5nZXM/IFRyeSBi
ZWxvdyBwYXRjaDoNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSGVyZSBhcmUgbXkgRFRTIGNo
YW5nZXM6DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9i
b290L2R0cy9pbXg3LWNvbGlicmktZXZhbC12My5kdHNpDQo+ID4gPiA+ID4gPiBiL2FyY2gvYXJt
L2Jvb3QvZHRzL2lteDctY29saWJyaS1ldmFsLXYzLmR0c2kNCj4gPiA+ID4gPiA+IGluZGV4IDk3
NjAxMzc1ZjI2NDAuLmM0MjRmNzA3YTFhZmEgMTAwNjQ0DQo+ID4gPiA+ID4gPiAtLS0gYS9hcmNo
L2FybS9ib290L2R0cy9pbXg3LWNvbGlicmktZXZhbC12My5kdHNpDQo+ID4gPiA+ID4gPiArKysg
Yi9hcmNoL2FybS9ib290L2R0cy9pbXg3LWNvbGlicmktZXZhbC12My5kdHNpDQo+ID4gPiA+ID4g
PiBAQCAtMTMsNiArMTMsMTMgQEANCj4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICBzdGRvdXQt
cGF0aCA9ICJzZXJpYWwwOjExNTIwMG44IjsNCj4gPiA+ID4gPiA+ICAgICAgICAgfTsNCj4gPiA+
ID4gPiA+ICANCj4gPiA+ID4gPiA+ICsgICAgICAgZXh0Y29uX3VzYmNfZGV0OiB1c2JjX2RldCB7
DQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJsaW51eCxleHRjb24t
dXNiLWdwaW8iOw0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIGlkLWdwaW8gPSA8JmdwaW83
IDE0IEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICAgIHBpbmN0
cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgcGluY3Ry
bC0wID0gPCZwaW5jdHJsX3VzYmNfZGV0PjsNCj4gPiA+ID4gPiA+ICsgICAgICAgfTsNCj4gPiA+
ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICAgICAgICAgLyogZml4ZWQgY3J5c3RhbCBkZWRpY2F0ZWQg
dG8gbXBjMjU4eCAqLw0KPiA+ID4gPiA+ID4gICAgICAgICBjbGsxNm06IGNsazE2bSB7DQo+ID4g
PiA+ID4gPiAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJmaXhlZC1jbG9jayI7DQo+ID4g
PiA+ID4gPiBAQCAtMTc0LDYgKzE4MSw3IEBADQo+ID4gPiA+ID4gPiAgfTsNCj4gPiA+ID4gPiA+
ICANCj4gPiA+ID4gPiA+ICAmdXNib3RnMSB7DQo+ID4gPiA+ID4gPiArICAgICAgIGV4dGNvbiA9
IDwmZXh0Y29uX3VzYmNfZGV0PiwgPCZleHRjb25fdXNiY19kZXQ+Ow0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IElmIHlvdSBoYXZlIG9ubHkgSUQgZXh0Y29uLCBidXQgbm8gVkJVUyBleHRjb24sIHlv
dSBvbmx5IG5lZWQNCj4gPiA+ID4gPiB0bw0KPiA+ID4gPiA+IGFkZCBvbmx5IHBoYW5kbGUsIHNl
ZSBkdC1iaW5kaW5nIGZvciBkZXRhaWwgcGxlYXNlLg0KPiA+ID4gPiANCj4gPiA+ID4gWW91IHdo
ZXJlIHJpZ2h0IGFnYWluISBUaGFua3MsIHRoaXMgYWN0dWFsbHkgc29sdmVzIHRoZSBSTkRJUw0K
PiA+ID4gPiBpc3N1ZQ0KPiA+ID4gPiBmb3INCj4gPiA+ID4gb3VyIGNvbGlicmktaW14NyBib2Fy
ZDoNCj4gPiA+ID4gDQo+ID4gPiA+ICsgICAgICAgZXh0Y29uID0gPDA+LCA8JmV4dGNvbl91c2Jj
X2RldD47DQo+ID4gPiA+IA0KPiA+ID4gPiBIb3dldmV2ZXIgb24gdGhpcyBpTVg3IGJvYXJkIHdl
IGhhdmUgVkJVUyBob29rZWQgdXAgdG8gdGhlIFNvQywNCj4gPiA+ID4gdGhhdCdzDQo+ID4gPiA+
IHdoeSBpdCB3b3JrcyBvbmx5IHdpdGggSUQuDQo+ID4gPiA+IA0KPiA+ID4gPiBPbiBDb2xpYnJp
LWlNWDZVTEwgd2UgZG8gbm90IGhhdmUgVkJVUyBob29rZWQgdXAuDQo+ID4gPiANCj4gPiA+IFNv
LCB0aGVyZSBpcyBubyBhbnkgZXZlbnRzIGZvciBjb25uZWN0aW5nIHRvIEhvc3Q/IElmIGl0IGlz
LCB0aGUNCj4gPiA+IHdvcmthcm91bmQgZm9yIHRoaXMgYm9hcmQgaXMgZGlzYWJsZSBydW50aW1l
IHBtLiBBbmQgeW91IG9ubHkgbmVlZA0KPiA+ID4gdG8NCj4gPiA+IHdyaXRlIG9uZSBleHRjb24g
cGhhbmRsZSBmb3IgSUQgc2luY2UgeW91IGhhdmUgZXh0ZXJuYWwgZXZlbnQgZm9yDQo+ID4gPiBJ
RCwNCj4gPiA+IGJ1dCBubyBldmVudCBmb3IgVkJVUy4gSUQgZXZlbnQgaXMgbm90IHRoZSBzYW1l
IHdpdGggVkJVUywgZm9yDQo+ID4gPiBleGFtcGxlLA0KPiA+ID4gaWYgeW91IHBsdWcgY2FibGUg
aW50byBob3N0LCB5b3Ugd2lsbCBub3QgZ2V0IHRoZSBJRCBldmVudCwgeW91DQo+ID4gPiBjb3Vs
ZA0KPiA+ID4gb25seSBnZXQgVkJVUyBldmVudCBpZiB0aGVyZSBpcyBhbiBldmVudCAoZWcsIHRo
cm91Z2ggR1BJTykgZm9yDQo+ID4gPiBpdC4NCj4gPiA+IA0KPiA+ID4gUGV0ZXINCj4gPiANCj4g
PiBObyB3ZSBkb24ndCBoYXZlIGV4dHJhIEhvc3QgZXZlbnRzLiBXZSBoYXZlIG9uZSBHUElPLCBp
ZiBpdCBpcyBoaWdoDQo+ID4gVVNCDQo+ID4gc2hvdWxkIGJlIGluIGdhZGdldCBtb2RlIGFuZCBp
ZiB0aGUgR1BJTyBpcyBsb3cgVVNCIHNob3VsZCBiZSBpbg0KPiA+IGhvc3QNCj4gPiBtb2RlLg0K
PiA+IA0KPiA+IElzIHRoZXJlIG5vIHdheSB3ZSBjYW4gYWNoaWV2ZSB0aGlzIG9uIG1haW5saW5l
IHdpdGhvdXQgZGlzYWJsaW5nDQo+ID4gcnVudGltZSBQTT8NCj4gPiANCj4gDQo+IEF0IGxlYXN0
IEkgdGhpbmsgc28sIHNpbmNlIHlvdSBkb24ndCBoYXZlIGFueSBldmVudHMgdG8gbGV0IHRoZQ0K
PiBTVyBrbm93IHlvdSBjb25uZWN0cyB0byBob3N0IGlmIHRoZSBjb250cm9sbGVyIGlzIGluIGxv
dyBwb3dlciBtb2RlLg0KPiANCj4gUGV0ZXINCg0Kb2theSwgZ29vZCB0byBrbm93LiBUaGFuayB5
b3UgdmVyeSBtdWNoIGZvciB5b3VyIGhlbHAhIEkgd2lsbCB0cnkgbm93DQp3aXRoIGEgZHVtbXkt
Z3BpbyBJIGd1ZXNzIHRoYXQgY291bGQgYmUgYSBuaWNlIHdvcmthcm91bmQgZm9yIHRoZSBVTEwu
DQoNCkJlc3QgUmVnYXJkcywNClBoaWxpcHBlDQoNCj4gDQo+ID4gUGhpbGlwcGUNCj4gPiANCj4g
PiA+ID4gU28gZGV2aWNlL2hvc3QNCj4gPiA+ID4gc3dpdGNoaW5nIHdvcmtzIG9ubHkgd2l0aCAn
ZXh0Y29uID0gPCZleHRjb25fdXNiY19kZXQ+LA0KPiA+ID4gPiA8JmV4dGNvbl91c2JjX2RldD47
JyBidXQgdGhlbiBSTkRJUyBhbmQgYWxzbyBhIG5vcm1hbCB0aHVtYi0NCj4gPiA+ID4gZHJpdmUN
Cj4gPiA+ID4gZG9lcw0KPiA+ID4gPiBub3Qgd29yay4gSG93IGNvdWxkIEkgd29yayBhcm91bmQg
dGhpcyBmYWN0PyBBIGR1bW15LWdwaW8gdGhhdA0KPiA+ID4gPiB3b3VsZA0KPiA+ID4gPiBhbHdh
eXMgcmVhZCAiaGlnaCIgZm9yIHZidXMgd291bGQgYmUgYSBzb2x1dGlvbiBmb3IgbWUuDQo+ID4g
PiA+IA0KPiA+ID4gPiBQaGlsaXBwZQ0KPiA+ID4gPiANCg==
