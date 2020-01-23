Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C95C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D5520661
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="ulCfqUpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgAWNjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 08:39:06 -0500
Received: from mail-db8eur05on2123.outbound.protection.outlook.com ([40.107.20.123]:37600
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726792AbgAWNjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 08:39:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNrdRN+2DvfRUQM1GOfuLizIQ24dly///1lZmavqfalSoPwUiolQ5N4vOHv781TPBfcRgOhpxUrcyt10GjBQkZwlQ3lkB68g7OXyQJzSh6nHZx+o4nvdXNYMLbA2NQMeoyvnjPqggNq3tgxHdB+FZncEDHQfE9b9LfS4Wj50HS+AP8Fd1uYs0lvHaQjrtTR6omsNAv3X1o5xrz/i9rLMlTRfto+kQh32dMtB3lwYr2C0QcSUR++bH6KVDTZmrGzk7VAzX2zS+oMSjt4bdHNSxaoSZtpJWjFmp8qmweQ5WuZAd8ErF7Ifog4a3G02Gl1Yl94gW6RVCURVaEC27Qi6PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2s3tlYFhgdSiLQm4ik4h3D6zxaVWhtbGDckbK+wvSM0=;
 b=j91O9VmFE4mGMJgj7gGspIcOrix5X4Y8RIXWyYw2rR7feZlxcqcvuK8+Mkpgw1M7vw0rh27RGjIzPj7vtPusTj8WbB8bqxvYkwHheTji0cOeM1pZDCLVWOuvze/SyZe8C5vsQ2tSnqI4br3KlIsqdUHDU6NDMHLqDRxdn0lesiknMMDi7tseY7u/FL6koIXtkPwbLpIdgAu41uFnlqji9sHVg/p+oixt9RZHY3QCyrP18vsWSyh69jI2M4syUpKQhAVkzUO+7qhcdHG7oiOX7xR1atmIrM24TDeIOvHWaPPO+D1PHe/UeOYIEnzM5Q+PxSaOkS2YKZrZPRV4AEBcnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2s3tlYFhgdSiLQm4ik4h3D6zxaVWhtbGDckbK+wvSM0=;
 b=ulCfqUpWGBTStMKXFhbIIdwq/6CFYg0v2JNr3r64xD2B5JiHHyfnARmYzm/qrclrW1aEWXzYkLmSiJ2gZhPUkRQkGDsuNX8hwxfp0jnyf2T4XAaE1a6WP2iIOYFu2TJXqkylB9b2dN/7ifL9wHUW0St0R+mL3OxF5XXtN0HuATw=
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB4720.eurprd05.prod.outlook.com (20.176.6.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.22; Thu, 23 Jan 2020 13:39:01 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52%7]) with mapi id 15.20.2644.027; Thu, 23 Jan 2020
 13:39:01 +0000
Received: from mail-qk1-f170.google.com (209.85.222.170) by MN2PR19CA0008.namprd19.prod.outlook.com (2603:10b6:208:178::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend Transport; Thu, 23 Jan 2020 13:39:01 +0000
Received: by mail-qk1-f170.google.com with SMTP id k6so3408174qki.5;        Thu, 23 Jan 2020 05:39:01 -0800 (PST)
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "info@logictechno.com" <info@logictechno.com>,
        "j.bauer@endrich.com" <j.bauer@endrich.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: panel-simple: add bindings for logic
 technologies displays
Thread-Topic: [PATCH v4 2/3] dt-bindings: panel-simple: add bindings for logic
 technologies displays
Thread-Index: AQHV0fGSiCgG8q+p4k6l4T/A2wrxsg==
Date:   Thu, 23 Jan 2020 13:39:01 +0000
Message-ID: <CAGgjyvGJr+Yvn6D8i6k7N=uTNq7uWAqyJQv-Bn+samMn_km2BA@mail.gmail.com>
References: <20200120080100.170294-1-marcel@ziswiler.com>
 <20200120080100.170294-2-marcel@ziswiler.com>
In-Reply-To: <20200120080100.170294-2-marcel@ziswiler.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR19CA0008.namprd19.prod.outlook.com
 (2603:10b6:208:178::21) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-gm-message-state: APjAAAWaAm7NT5gF60b2ul6il9X2xGNq5rstrvpl8V8UoU/jDkC3Yc0u
        JkOJnSwM3O0M2S0Ntf7WbOGmymTivAnsUNKSMDA=
x-google-smtp-source: APXvYqwHdoIm2gkZNB9+mft6eWjNU94wAAqcKZh4qyseww49f2rOVJB/HGbiuT0g+joW6oQL6DibWmbKodut6OB/6BM=
x-received: by 2002:ac8:1851:: with SMTP id
 n17mr16327905qtk.305.1579786367031; Thu, 23 Jan 2020 05:32:47 -0800 (PST)
x-gmail-original-message-id: <CAGgjyvGJr+Yvn6D8i6k7N=uTNq7uWAqyJQv-Bn+samMn_km2BA@mail.gmail.com>
x-originating-ip: [209.85.222.170]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6387b1dd-30e6-4f98-f8ca-08d7a0099b34
x-ms-traffictypediagnostic: VI1PR05MB4720:
x-microsoft-antispam-prvs: <VI1PR05MB4720849EB3AA918746EE5660F90F0@VI1PR05MB4720.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:400;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(199004)(189003)(54906003)(9686003)(42186006)(966005)(5660300002)(66476007)(66556008)(81166006)(81156014)(66946007)(450100002)(66446008)(6862004)(4326008)(64756008)(498600001)(8676002)(55446002)(186003)(8936002)(44832011)(86362001)(71200400001)(52116002)(26005)(53546011)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB4720;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OLo/7dYqO6LflEtCe5NSsjE5wJ4fn60fQ3mevdUfwJH4chyR317KXUbph4BgolpKXZFoWTXsNMlifshb/MA4EotT8ZkXqAOKWkKG4iyKOvIi0x+qG91RwNATlxUYkM8N8ah70onSv2q6ru00Ne1usOMwS1IMHXe5xyCpR5ObcSxFoLEEk+i53EuWJOMHy9faPS/8C2Ge1e9iCWaQ0huDem0Ww0mYIryGwCLcIVe33br5ucldaerxJNB6YBDCS8K811CEENr/5mc8W56uaQozeU2ADNiI7TdtTbyQgyzy30vxFG2HXNsq0NCFcd/InuU34K/TNMULEbF8klL7g2HyWmSpqyaBxdT5N0Hj1FUpWhXAKAPuq4w/u1el/YDgWTxUt4tRR5s8A6ffALKZq2CN3Ha0AmDZQjj9sYGxwws+uXL06H+JPE9lq51gzYeAONP1ZSpOvXuhKpRLASJIlC7TfWz89ktlhZLFLCOhW8kepjg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F68E9E049C34E14ABAE2A88B01C7EAB3@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6387b1dd-30e6-4f98-f8ca-08d7a0099b34
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 13:39:01.7073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XUfXuN9mSw6VSSjiQCbiCuPKAnW9p9vsJO8/uxStFH5kJEMx8NqNrKR7d3OtV3diykGK8HG7qIv1SDB4oq2fZwEBBj6xc95jwgfVfyc6/Mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4720
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBKYW4gMjAsIDIwMjAgYXQgMTA6MDIgQU0gTWFyY2VsIFppc3dpbGVyIDxtYXJjZWxA
emlzd2lsZXIuY29tPiB3cm90ZToNCj4NCj4gRnJvbTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwu
emlzd2lsZXJAdG9yYWRleC5jb20+DQo+DQo+IEFkZCBiaW5kaW5ncyBmb3IgdGhlIGZvbGxvd2lu
ZyAzIHRvIGJlIGFkZGVkIGRpc3BsYXkgcGFuZWxzIG1hbnVmYWN0dXJlZA0KPiBieSBMb2dpYyBU
ZWNobm9sb2dpZXMgTGltaXRlZDoNCj4NCj4gLSBMVDE2MTAxMC0yTkhDIGUuZy4gYXMgZm91bmQg
aW4gdGhlIFRvcmFkZXggQ2FwYWNpdGl2ZSBUb3VjaCBEaXNwbGF5DQo+IDciIFBhcmFsbGVsIFsx
XQ0KPiAtIExUMTYxMDEwLTJOSFIgZS5nLiBhcyBmb3VuZCBpbiB0aGUgVG9yYWRleCBSZXNpc3Rp
dmUgVG91Y2ggRGlzcGxheSA3Ig0KPiBQYXJhbGxlbCBbMl0NCj4gLSBMVDE3MDQxMC0yV0hDIGUu
Zy4gYXMgZm91bmQgaW4gdGhlIFRvcmFkZXggQ2FwYWNpdGl2ZSBUb3VjaCBEaXNwbGF5DQo+IDEw
LjEiIExWRFMgWzNdDQo+DQo+IFRob3NlIHBhbmVscyBtYXkgYWxzbyBiZSBkaXN0cmlidXRlZCBi
eSBFbmRyaWNoIEJhdWVsZW1lbnRlIFZlcnRyaWVicw0KPiBHbWJIIFs0XS4NCj4NCj4gWzFdIGh0
dHBzOi8vZG9jcy50b3JhZGV4LmNvbS8xMDQ0OTctNy1pbmNoLXBhcmFsbGVsLWNhcGFjaXRpdmUt
dG91Y2gtZGlzcGxheS04MDB4NDgwLWRhdGFzaGVldC5wZGYNCj4gWzJdIGh0dHBzOi8vZG9jcy50
b3JhZGV4LmNvbS8xMDQ0OTgtNy1pbmNoLXBhcmFsbGVsLXJlc2lzdGl2ZS10b3VjaC1kaXNwbGF5
LTgwMHg0ODAucGRmDQo+IFszXSBodHRwczovL2RvY3MudG9yYWRleC5jb20vMTA1OTUyLTEwLTEt
aW5jaC1sdmRzLWNhcGFjaXRpdmUtdG91Y2gtZGlzcGxheS0xMjgweDgwMC1kYXRhc2hlZXQucGRm
DQo+IFs0XSBodHRwczovL3d3dy5lbmRyaWNoLmNvbS9pc2k1MF9pc2kzMF90ZnQtZGlzcGxheXMv
bHQxNzA0MTAtMXdoY19pc2kzMA0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJjZWwgWmlzd2lsZXIg
PG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NClJldmlld2VkLWJ5OiBPbGVrc2FuZHIgU3V2
b3JvdiA8b2xla3NhbmRyLnN1dm9yb3ZAdG9yYWRleC5jb20+DQo+DQo+IC0tLQ0KPg0KPiBDaGFu
Z2VzIGluIHY0Og0KPiAtIFJlLW9yZGVyZWQgY29tbWl0cyBhcyBzdWdnZXN0ZWQgYnkgU2FtIGFu
ZCByZS13b3JkZWQgY29tbWl0IG1lc3NhZ2UuDQo+DQo+IENoYW5nZXMgaW4gdjM6DQo+IC0gQWRk
IGl0IHRvIHJlY2VudGx5IGludHJvZHVjZWQgcGFuZWwtc2ltcGxlLnlhbWwgaW5zdGVhZCBhcyBz
dWdnZXN0ZWQNCj4gICBieSBTYW0uDQo+DQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gTmV3IHBhdGNo
IGFkZGluZyBkaXNwbGF5IHBhbmVsIGJpbmRpbmdzIGFzIHdlbGwgYXMgc3VnZ2VzdGVkIGJ5IFJv
Yi4NCj4NCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvcGFuZWwvcGFuZWwtc2lt
cGxlLnlhbWwgICAgIHwgNiArKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KykNCj4NCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9k
aXNwbGF5L3BhbmVsL3BhbmVsLXNpbXBsZS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2Rpc3BsYXkvcGFuZWwvcGFuZWwtc2ltcGxlLnlhbWwNCj4gaW5kZXggNGE4MDY0
ZTMxNzkzLi5mMzNjNWQ5NzlmOTYgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9kaXNwbGF5L3BhbmVsL3BhbmVsLXNpbXBsZS55YW1sDQo+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L3BhbmVsL3BhbmVsLXNpbXBs
ZS55YW1sDQo+IEBAIC00MSw2ICs0MSwxMiBAQCBwcm9wZXJ0aWVzOg0KPiAgICAgICAgLSBmcmlk
YSxmcmQzNTBoNTQwMDQNCj4gICAgICAgICAgIyBHaWFudFBsdXMgR1BNOTQwQjAgMy4wIiBRVkdB
IFRGVCBMQ0QgcGFuZWwNCj4gICAgICAgIC0gZ2lhbnRwbHVzLGdwbTk0MGIwDQo+ICsgICAgICAg
ICMgTG9naWMgVGVjaG5vbG9naWVzIExUMTYxMDEwLTJOSEMgNyIgV1ZHQSBURlQgQ2FwIFRvdWNo
IE1vZHVsZQ0KPiArICAgICAgLSBsb2dpY3RlY2hubyxsdDE2MTAxMC0ybmhjDQo+ICsgICAgICAg
ICMgTG9naWMgVGVjaG5vbG9naWVzIExUMTYxMDEwLTJOSFIgNyIgV1ZHQSBURlQgUmVzaXN0aXZl
IFRvdWNoIE1vZHVsZQ0KPiArICAgICAgLSBsb2dpY3RlY2hubyxsdDE2MTAxMC0ybmhyDQo+ICsg
ICAgICAgICMgTG9naWMgVGVjaG5vbG9naWVzIExUMTcwNDEwLTJXSEMgMTAuMSIgMTI4MHg4MDAg
SVBTIFRGVCBDYXAgVG91Y2ggTW9kLg0KPiArICAgICAgLSBsb2dpY3RlY2hubyxsdDE3MDQxMC0y
d2hjDQo+ICAgICAgICAgICMgU2F0b3ogU0FUMDUwQVQ0MEgxMlIyIDUuMCIgV1ZHQSBURlQgTENE
IHBhbmVsDQo+ICAgICAgICAtIHNhdG96LHNhdDA1MGF0NDBoMTJyMg0KPiAgICAgICAgICAjIFNo
YXJwIExTMDIwQjFERDAxRCAyLjAiIEhRVkdBIFRGVCBMQ0QgcGFuZWwNCj4gLS0NCj4gMi4yNC4x
DQo+DQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMNCk9sZWtzYW5kciBTdXZvcm92DQoNClRvcmFkZXgg
QUcNCkFsdHNhZ2Vuc3RyYXNzZSA1IHwgNjA0OCBIb3J3L0x1emVybiB8IFN3aXR6ZXJsYW5kIHwg
VDogKzQxIDQxIDUwMA0KNDgwMCAobWFpbiBsaW5lKQ0K
