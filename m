Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ECCC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AA5A207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rohmsemiconductoreurope.onmicrosoft.com header.i=@rohmsemiconductoreurope.onmicrosoft.com header.b="wr0/uKkI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgIJFBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 01:01:54 -0400
Received: from mail-eopbgr50053.outbound.protection.outlook.com ([40.107.5.53]:10985
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725372AbgIJFBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 01:01:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rg4hnV8xoHB9qRS+OmXREtR/nfZS6jwzKTbxa2RLPl/DfkZ1cvkimvzWvuqpJVM+KVu1nCaRhQXze6tIJ9mcBe0DBRBifYTf58T91gPRq4uZgWwgydua1WZNBckZStwu2XczWuMEJEr8IP6S8N6creDg7s3JIZUB3bOSTUbtwihkGFNxk6f7RVb03suf1Fy3drqJ2AHOyPltEjJKNJBJybjNYiwc+W28ojT55+GHvm8wL0pdhNem8cP4W54+8n+7CzAmkoahhyijg+R9H1HvQBgT/cBLwVw970B18wd6ybpGq/FDDuwFT+Td7o1+h+Q6/kl+gWbOiDC5uujftRzEKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAEgQwKZDlKzb7QKdIQEFlGXK4hKMKS3CPcLrcNoUB8=;
 b=OeD8WACyTs1cRRws8cioy6ubPRscf0M6I3WpGFLzSFSCz1rs9HcCgjlSv52IvymYoFATFKpeEoZrf4RRfEoz8KF00Ey4AuTWPKlS/5AJxarnEHVNhfKLXszZY0T6Xf2AraEq/QmQJxgzF2GBUv5xi+acMOvEypFjH/eu8mV9SD8ZPElHbiIS/bJ6YrFsvm9iZTpFXwDDWxDT7CuX9Ip8z0A9rODxqjsrsfYkCVrjk9omRgrDsx/jHoRqC6ymGQIEjxcNwFIaeHYz6WzwmBeTY2AVCekdso6+X1ab8aqz1RdxDTwhiX3cWH+8nZFUCI5i5eK9JyF2VTFNUhfTkkHzIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAEgQwKZDlKzb7QKdIQEFlGXK4hKMKS3CPcLrcNoUB8=;
 b=wr0/uKkIzMF3Mnwf3Fn/7K8UXhYmEJLkC/ziyrDfeMzmGEHdpLKymaZMAfGJiN+VxUkYtt+lFkLaxt5ARa+yZYerj6C7UPQp3c6CM/WWp5oQSaSKN6JrzkYcyKiJ+B9JqKOcBIC+UEQHBCpuEL6/2M9OKK8QWK5Z0lRN1zVV9gA=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR03MB2889.eurprd03.prod.outlook.com (2603:10a6:7:5f::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Thu, 10 Sep 2020 05:01:41 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::3d81:df5c:63de:a527]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::3d81:df5c:63de:a527%6]) with mapi id 15.20.3348.019; Thu, 10 Sep 2020
 05:01:41 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     linux-power <linux-power@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] regulator: bd718x7: Make some variable static
Thread-Topic: [PATCH -next] regulator: bd718x7: Make some variable static
Thread-Index: AQHWhySAzo2XNgsU40OQKE4F/+c1NalhUJ8A
Date:   Thu, 10 Sep 2020 05:01:40 +0000
Message-ID: <1e6a24a6474c0dd4309d7b16febbe933ddcd30dd.camel@fi.rohmeurope.com>
References: <20200910034240.37268-1-yuehaibing@huawei.com>
In-Reply-To: <20200910034240.37268-1-yuehaibing@huawei.com>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [62.78.225.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9992e46e-da91-4b11-83ca-08d855469b3f
x-ms-traffictypediagnostic: HE1PR03MB2889:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR03MB28895B03C9C4EC11AA82B856AD270@HE1PR03MB2889.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:185;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lo4MW16bPlAmah8PKHxl5cupkpxfrsEUoZ8SwP3O1JtcwU8iYaoUEyrgsXuKyEzV//Dc2QTkIYQBwxMZ2Gy/KwxN6mNjmJHx3cPn0NqZRNW+Zvsi1RqlkpaukarUziaqZj/wOqtczmJed74Fx/7H+uT9fS98AwRn/5wHo8b/dyHhGwGq2MOZyXtBCCb3bjMLRv9/GDLU7KApK7DwxX6aNgo7AD2vPTk7M96upY4ALSmiTAoQLtDaMFPj+o9FAtYDq5EJB67VKVSHNETiHoxIqaeKKJrhy2MrK6i7HT6/ZsiXdM3SktnZZY+VJW/6iD9CSqTnlWImXXThuJum1AoAeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39850400004)(366004)(396003)(66476007)(76116006)(66946007)(8936002)(5660300002)(64756008)(66556008)(66446008)(71200400001)(2906002)(6506007)(3450700001)(26005)(86362001)(4326008)(6512007)(186003)(478600001)(2616005)(316002)(110136005)(6486002)(83380400001)(8676002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: V5Fez3En8JYRazQNs2urxFsyPXfpq1hs9BODoDoZLuU13UF3Z9b7WPC2NqduIqOcxv7Fd3uTeb70CPIbQcs/t3x/zztCPR1Cs8RBzFAvLLEAQtlzM67lX0It5RnF1jTKdgw2urRji07HuGY5n3VDUbafhMBoqklODy8U5FVqL2QBXVgcbiGACLtpLvNYJq036Qx3otc3WQ4ScV9uzg1YvV2n2rcIB+rTvbf4jedazbWDpSNe29gs6uKbUrMZJXhBPEVxY7DXHjMyKKVKruMSnQi+s5DcHjo3naegy2IZVVzNVfQpfqzJ+3FwA4ofSHWqXW6DepHKd5XewozqnbuxXBRk5CRAoAMROGjRWFzsl2s8mBM5DZUdNtsC+hRsCGEr1mWT6fOdJiMbV4zP+i7nLZGkqZTFJb2MBzBJCD8m+rzJcvNXb7s4n4tRPgnNuAf/2k6lXyWJ3rr2v4BVZVHuQI2EOOIfLHrQTSVUwf2+AZLvd94Mr69++HQgbD8q1iYDYV9sNlkzTOP/Rg7S6zyXqv1uWcwHXMiKue+7wjcZ/THEvRqdiLCBZry4EAPQ9HJSp2vpEGevJzBfTRe5AqRKdyT/2v8K2C/n9yFn0KfKRuCJQHpy+VW9SbewUB951x8112trhNgPBhax3BPbu1EcUQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7D2940E437B074D8E7BDBF0D1CE5F5A@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9992e46e-da91-4b11-83ca-08d855469b3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2020 05:01:41.2528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cQIfjSaYlafIky64tNwFQ7/ekbcs6aQ9OtZIgGViofUuos2WaGEkylrjU1+dS24Zdy/VvmtFL1sA4dduyvPHr5F94dPhtKqAFZ7K/gFL5Y9wgwHX5l9sVqhLhBXJ4JYw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR03MB2889
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBUaHUsIDIwMjAtMDktMTAgYXQgMTE6NDIgKzA4MDAsIFl1ZUhhaWJpbmcgd3JvdGU6DQo+
IEZpeCBzcGFyc2Ugd2FybmluZ3M6DQo+IA0KPiBkcml2ZXJzL3JlZ3VsYXRvci9iZDcxOHg3LXJl
Z3VsYXRvci5jOjU3NjoyODogd2FybmluZzogc3ltYm9sDQo+ICdiZDcxODQ3X3N3Y29udHJvbF9v
cHMnIHdhcyBub3QgZGVjbGFyZWQuIFNob3VsZCBpdCBiZSBzdGF0aWM/DQo+IGRyaXZlcnMvcmVn
dWxhdG9yL2JkNzE4eDctcmVndWxhdG9yLmM6NTg1OjI4OiB3YXJuaW5nOiBzeW1ib2wNCj4gJ2Jk
NzE4NDdfaHdjb250cm9sX29wcycgd2FzIG5vdCBkZWNsYXJlZC4gU2hvdWxkIGl0IGJlIHN0YXRp
Yz8NCj4gZHJpdmVycy9yZWd1bGF0b3IvYmQ3MTh4Ny1yZWd1bGF0b3IuYzo5MDI6Mjg6IHdhcm5p
bmc6IHN5bWJvbA0KPiAnYmQ3MTgzN19zd2NvbnRyb2xfb3BzJyB3YXMgbm90IGRlY2xhcmVkLiBT
aG91bGQgaXQgYmUgc3RhdGljPw0KPiBkcml2ZXJzL3JlZ3VsYXRvci9iZDcxOHg3LXJlZ3VsYXRv
ci5jOjkxMzoyODogd2FybmluZzogc3ltYm9sDQo+ICdiZDcxODM3X2h3Y29udHJvbF9vcHMnIHdh
cyBub3QgZGVjbGFyZWQuIFNob3VsZCBpdCBiZSBzdGF0aWM/DQo+IA0KPiBSZXBvcnRlZC1ieTog
SHVsayBSb2JvdCA8aHVsa2NpQGh1YXdlaS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFl1ZUhhaWJp
bmcgPHl1ZWhhaWJpbmdAaHVhd2VpLmNvbT4NCg0KQWNrZWQtQnk6IE1hdHRpIFZhaXR0aW5lbiA8
bWF0dGkudmFpdHRpbmVuQGZpLnJvaG1ldXJvcGUuY29tPg0KDQpUaGFua3MgZm9yIHRha2luZyBj
YXJlIG9mIHRoaXMhDQoNCj4gLS0tDQo+ICBkcml2ZXJzL3JlZ3VsYXRvci9iZDcxOHg3LXJlZ3Vs
YXRvci5jIHwgOCArKysrLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3JlZ3VsYXRvci9iZDcx
OHg3LXJlZ3VsYXRvci5jDQo+IGIvZHJpdmVycy9yZWd1bGF0b3IvYmQ3MTh4Ny1yZWd1bGF0b3Iu
Yw0KPiBpbmRleCAxNTljOTE3YjljNGMuLjA3NzQ0Njc5OTRmYiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9yZWd1bGF0b3IvYmQ3MTh4Ny1yZWd1bGF0b3IuYw0KPiArKysgYi9kcml2ZXJzL3JlZ3Vs
YXRvci9iZDcxOHg3LXJlZ3VsYXRvci5jDQo+IEBAIC01NzMsNyArNTczLDcgQEAgc3RhdGljIGlu
dCBidWNrX3NldF9od19kdnNfbGV2ZWxzKHN0cnVjdA0KPiBkZXZpY2Vfbm9kZSAqbnAsDQo+ICAJ
cmV0dXJuIHJvaG1fcmVndWxhdG9yX3NldF9kdnNfbGV2ZWxzKCZkYXRhLT5kdnMsIG5wLCBkZXNj
LCBjZmctDQo+ID5yZWdtYXApOw0KPiAgfQ0KPiAgDQo+IC1jb25zdCBzdHJ1Y3QgcmVndWxhdG9y
X29wcyAqYmQ3MTg0N19zd2NvbnRyb2xfb3BzW10gPSB7DQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0
IHJlZ3VsYXRvcl9vcHMgKmJkNzE4NDdfc3djb250cm9sX29wc1tdID0gew0KPiAgCSZiZDcxOHh4
X2R2c19idWNrX3JlZ3VsYXRvcl9vcHMsDQo+ICZiZDcxOHh4X2R2c19idWNrX3JlZ3VsYXRvcl9v
cHMsDQo+ICAJJmJkNzE4eHhfcGlja2FibGVfcmFuZ2VfYnVja19vcHMsDQo+ICZiZDcxOHh4X3Bp
Y2thYmxlX3JhbmdlX2J1Y2tfb3BzLA0KPiAgCSZiZDcxOHh4X2J1Y2tfcmVndWxhdG9yX25vbGlu
ZWFyX29wcywNCj4gJmJkNzE4eHhfYnVja19yZWd1bGF0b3Jfb3BzLA0KPiBAQCAtNTgyLDcgKzU4
Miw3IEBAIGNvbnN0IHN0cnVjdCByZWd1bGF0b3Jfb3BzDQo+ICpiZDcxODQ3X3N3Y29udHJvbF9v
cHNbXSA9IHsNCj4gIAkmYmQ3MTh4eF9waWNrYWJsZV9yYW5nZV9sZG9fb3BzLCAmYmQ3MTh4eF9s
ZG9fcmVndWxhdG9yX29wcywNCj4gIH07DQo+ICANCj4gLWNvbnN0IHN0cnVjdCByZWd1bGF0b3Jf
b3BzICpiZDcxODQ3X2h3Y29udHJvbF9vcHNbXSA9IHsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
cmVndWxhdG9yX29wcyAqYmQ3MTg0N19od2NvbnRyb2xfb3BzW10gPSB7DQo+ICAJJkJENzE4WFhf
SFdPUE5BTUUoYmQ3MTh4eF9kdnNfYnVja19yZWd1bGF0b3Jfb3BzKSwNCj4gIAkmQkQ3MThYWF9I
V09QTkFNRShiZDcxOHh4X2R2c19idWNrX3JlZ3VsYXRvcl9vcHMpLA0KPiAgCSZCRDcxOFhYX0hX
T1BOQU1FKGJkNzE4eHhfcGlja2FibGVfcmFuZ2VfYnVja19vcHMpLA0KPiBAQCAtODk5LDcgKzg5
OSw3IEBAIHN0YXRpYyBzdHJ1Y3QgYmQ3MTh4eF9yZWd1bGF0b3JfZGF0YQ0KPiBiZDcxODQ3X3Jl
Z3VsYXRvcnNbXSA9IHsNCj4gIAl9LA0KPiAgfTsNCj4gIA0KPiAtY29uc3Qgc3RydWN0IHJlZ3Vs
YXRvcl9vcHMgKmJkNzE4Mzdfc3djb250cm9sX29wc1tdID0gew0KPiArc3RhdGljIGNvbnN0IHN0
cnVjdCByZWd1bGF0b3Jfb3BzICpiZDcxODM3X3N3Y29udHJvbF9vcHNbXSA9IHsNCj4gIAkmYmQ3
MTh4eF9kdnNfYnVja19yZWd1bGF0b3Jfb3BzLA0KPiAmYmQ3MTh4eF9kdnNfYnVja19yZWd1bGF0
b3Jfb3BzLA0KPiAgCSZiZDcxOHh4X2R2c19idWNrX3JlZ3VsYXRvcl9vcHMsDQo+ICZiZDcxOHh4
X2R2c19idWNrX3JlZ3VsYXRvcl9vcHMsDQo+ICAJJmJkNzE4MzdfcGlja2FibGVfcmFuZ2VfYnVj
a19vcHMsICZiZDcxODM3X2J1Y2tfcmVndWxhdG9yX29wcywNCj4gQEAgLTkxMCw3ICs5MTAsNyBA
QCBjb25zdCBzdHJ1Y3QgcmVndWxhdG9yX29wcw0KPiAqYmQ3MTgzN19zd2NvbnRyb2xfb3BzW10g
PSB7DQo+ICAJJmJkNzE4MzdfbGRvX3JlZ3VsYXRvcl9vcHMsDQo+ICB9Ow0KPiAgDQo+IC1jb25z
dCBzdHJ1Y3QgcmVndWxhdG9yX29wcyAqYmQ3MTgzN19od2NvbnRyb2xfb3BzW10gPSB7DQo+ICtz
dGF0aWMgY29uc3Qgc3RydWN0IHJlZ3VsYXRvcl9vcHMgKmJkNzE4MzdfaHdjb250cm9sX29wc1td
ID0gew0KPiAgCSZCRDcxOFhYX0hXT1BOQU1FKGJkNzE4eHhfZHZzX2J1Y2tfcmVndWxhdG9yX29w
cyksDQo+ICAJJkJENzE4WFhfSFdPUE5BTUUoYmQ3MTh4eF9kdnNfYnVja19yZWd1bGF0b3Jfb3Bz
KSwNCj4gIAkmYmQ3MTgzN19idWNrMzRfb3BzX2h3Y3RybCwgJmJkNzE4MzdfYnVjazM0X29wc19o
d2N0cmwsDQoNCg==
