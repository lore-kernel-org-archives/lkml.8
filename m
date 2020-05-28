Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0053C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8FE62063A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="Xzunluz/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgE1IjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 04:39:09 -0400
Received: from mail-db8eur05on2099.outbound.protection.outlook.com ([40.107.20.99]:64289
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726955AbgE1IjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 04:39:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmpbcpGPeoFTHMPbX+/qJV52jk+NWnZ24igZvD6pJuHwEvYX230+qCvD1i7R3OWODX/IDSXIwpIL9fvnfSdyWU6O+n8O2octgn/aWumyB8Ip13cO2KOojiaQGh6WkH5FVcurgglRgxrPg01uYFxlV7k4pVMtyQXUSoIi5Kx3g2bQXXikMBMe3EjZacnVUDFNGfAdIvBDZrCDKO9qFY9kh8W8iYedeN1Ll3fqiW+0RPcstv0nx22unCVAI8o2srh9g1EHD7UmY59HVdQlRc6k5MH3KKXebUzZlbHGh2fJE62p/bhNKvGjS4VS8dYtj1VCZvFm5s3nQPu/MEE6aHdmuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OvteShdIKq1FLDE58pe9AmSlNo+QnO61GfCu0H607U=;
 b=l665YubIy/ccJ+OAPQhhkJOE/dxyqem14RyoumbX9Oasyxp4eEZH/g1S5qrARLJfY4Fj3RmQcBKmCtQQZiM7MPlunhxJYLzneVIdETAC+5Crx8nz+H/Hp48EKaZdfSgGdUHHSEaOPbmTP9adNy4fQbS6F45lfL45nG3OXJH6VQw7rkWVi+hWntP4chGp00CtaCFoA/XKrLcw63v/NwFHpuay6gD+tt1AJdHe6azo0YQ3JUcnHdB3bwH1TcH1THwUTC949PJlTZGa2vUGZR4MF/Ik5h+bRwTVzPQwrrqaQEZ+M7IrDKrZb5ro//Frmy6yGTzQ3KoI2SkcUT4ChpK1ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OvteShdIKq1FLDE58pe9AmSlNo+QnO61GfCu0H607U=;
 b=Xzunluz/dk1rZKYqVd1Go7oMGlCj1LJFlZ8pnEv6cJ3l/esd7OgC5i+pUqscqSisGnllYpPcBdbN/ErDG/mBC96iwvAkGtVWiSfEaD317vabdfqOpvRFOFeUgd+B2xBKKmhs6bjaBhbMXBVLwBhYwCbQf2/FE0eBQrJpiIDq+kA=
Received: from AM0P193MB0596.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:169::22)
 by AM0P193MB0306.EURP193.PROD.OUTLOOK.COM (2603:10a6:208:56::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Thu, 28 May
 2020 08:39:02 +0000
Received: from AM0P193MB0596.EURP193.PROD.OUTLOOK.COM
 ([fe80::49f2:e189:1b3a:85c8]) by AM0P193MB0596.EURP193.PROD.OUTLOOK.COM
 ([fe80::49f2:e189:1b3a:85c8%3]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 08:39:02 +0000
From:   "Enderborg, Peter" <Peter.Enderborg@sony.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] debugfs: Add mount restriction option
Thread-Topic: [PATCH] debugfs: Add mount restriction option
Thread-Index: AQHWNMYbZWEseia5ik2nhGfub1cbHai9KjaAgAADHYA=
Date:   Thu, 28 May 2020 08:39:02 +0000
Message-ID: <3e1be4dc-01d4-7fc5-1c82-1c792d3fbc11@sony.com>
References: <20200528080031.24149-1-peter.enderborg@sony.com>
 <20200528082753.GA2920930@kroah.com>
In-Reply-To: <20200528082753.GA2920930@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=sony.com;
x-originating-ip: [37.139.156.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf19331d-16dd-4e11-fc7a-08d802e29301
x-ms-traffictypediagnostic: AM0P193MB0306:
x-microsoft-antispam-prvs: <AM0P193MB0306ABC52B684113EF5D451F868E0@AM0P193MB0306.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r3TuvJDA1VNOusi7lflkzZbWp8WnbemnVEMbbGFGQh+IeAIgBsXbZaRwJfab2A32zz1r1d6kEyG1cx32aQ5rVnabMxaFTlny2DV4EXA0k+asQbWCs50ZY1wOEatv4v85yWv9j0YeW1ZOD4jHWSKR9O4Wi7R/ceqYXpVdcz2GHQLT083muljkWq1I/csHR4hx5KHpCIsYO+p3qvXfR5qIJy8UUBK0OVE0XpHjACOQ9TFKlNZoEbxQw7OSgGRfEmVS5nMa6mHptq1OQLD1cB5ZV4REhzhQ783QTKqFCmAqF+BZvgSqiJ6laORHd1l4HTIfFnFVa5qd88pRl/++TJjdZi/074Gjugwl6/wTiKzBc+HDwWJ0kaV+jctMeIgefYNS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P193MB0596.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(2616005)(186003)(8676002)(6506007)(53546011)(5660300002)(8936002)(66556008)(66446008)(66946007)(66476007)(64756008)(478600001)(76116006)(71200400001)(54906003)(86362001)(6916009)(6512007)(4326008)(316002)(31686004)(36756003)(6486002)(2906002)(83380400001)(31696002)(26005)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: hNHrugS0hoD+fmXJRoBwAaAqS/J18XXb7c9uigqAhJktO+8k+9Dqd2/YfpyOaueaXLxvi4WpIyxtk5++8WUZ/pn/515DnYzlhx5kIO80YJsl69li+LdZOlFJoQB5uNBBKkschrA3bPSePFCmQe3BRGNspfdcWWrMm8ekNjDepZ0807Ryok7Is3EkLvjx9sZ7cFUOemhlbsVjL91+/RzvARSwh5QJJLk9OEk3IvQL4bPpkr/DweGp9ebpZN/Ut4zqPZTOzjAHGEIuPCKB6kw+WlQr92IFHT0DkBHt2Gz9z13R8e01PWTALx8bo8X63M9vlJcpCqxnhSyjq1dBZ0nCzGbEj4sT3jG9/EZyR/3eo6wx747SSIl8fpEhBtFpmm/39Tc/JbEhwjBPVy2ilYXsqAixlyHyZ1/64Fxp4lAyFWMQN5SyBiBGqZMgQg5ms97qk8nSrotD7b00KTddotyGyz/lXzlK6/2kC+94n0YHWOc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5317639B2E36840920A70D07F42AA9B@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf19331d-16dd-4e11-fc7a-08d802e29301
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 08:39:02.4135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MTyLHBrdjcxoYcWM4sacsGs+quLQ2XVu1YfN+w3mn4eZ7VyFYfh5UUXhXm50oY5K5lAUzlQ18Q35fGTPX3VYWFUUX3LQsIysumHNLzWIerU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0306
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yOC8yMCAxMDoyNyBBTSwgR3JlZyBLcm9haC1IYXJ0bWFuIHdyb3RlOg0KPiBPbiBUaHUs
IE1heSAyOCwgMjAyMCBhdCAxMDowMDozMUFNICswMjAwLCBQZXRlciBFbmRlcmJvcmcgd3JvdGU6
DQo+PiBTaW5jZSBkZWJ1Z2ZzIGluY2x1ZGUgc2Vuc2l0aXZlIGluZm9ybWF0aW9uIGl0IG5lZWQg
dG8gYmUgdHJlYXRlZA0KPj4gY2FyZWZ1bGx5LiBCdXQgaXQgYWxzbyBoYXMgbWFueSB2ZXJ5IHVz
ZWZ1bCBkZWJ1ZyBmdW5jdGlvbnMgZm9yIHVzZXJzcGFjZS4NCj4+IFdpdGggdGhpcyBvcHRpb24g
d2UgY2FuIGhhdmUgc2FtZSBjb25maWd1cmF0aW9uIGZvciBzeXN0ZW0gd2l0aA0KPj4gbmVlZCBv
ZiBkZWJ1Z2ZzIGFuZCBhIHdheSB0byB0dXJuIGl0IG9mZi4gSXQgaXMgbmVlZGVkIG5ldw0KPj4g
a2VybmVsIGNvbW1hbmQgbGluZSBwYXJhbWV0ZXIgdG8gYmUgYWN0aXZhdGVkLg0KPiBCeSAiY29u
ZmlndXJhdGlvbiIgZG8geW91IG1lYW4gImtlcm5lbCBjb25maWd1cmF0aW9uIj8gIFdoYXQgaXMg
d3JvbmcNCj4gd2l0aCByZWx5aW5nIG9uIHRoZSBidWlsZCBvcHRpb24gbGlrZSB3ZSBkbyB0b2Rh
eT8NCj4NCj4gWW91IG1pZ2h0IHdhbnQgdG8gcmV3b3JkIGFsbCBvZiB0aGlzIHRvIG1ha2UgbW9y
ZSBzZW5zZSBhYm91dCB0aGUNCj4gInByb2JsZW0iIHlvdSBhcmUgdHJ5aW5nIHRvIHNvbHZlIGhl
cmUsIGFzIEkgZG9uJ3QgcmVhbGx5IHVuZGVyc3RhbmQgaXQsDQo+IHNvcnJ5Lg0KPg0KPg0KPj4g
U2lnbmVkLW9mZi1ieTogUGV0ZXIgRW5kZXJib3JnIDxwZXRlci5lbmRlcmJvcmdAc29ueS5jb20+
DQo+PiAtLS0NCj4+ICBmcy9kZWJ1Z2ZzL2lub2RlLmMgfCAxNyArKysrKysrKysrKysrKysrLQ0K
Pj4gIGxpYi9LY29uZmlnLmRlYnVnICB8IDEwICsrKysrKysrKysNCj4+ICAyIGZpbGVzIGNoYW5n
ZWQsIDI2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gTm8gZG9jdW1lbnRhdGlvbiB1
cGRhdGU/ICBUaGF0J3Mgbm90IGdvb2QgOigNCj4NCj4NCj4+IGRpZmYgLS1naXQgYS9mcy9kZWJ1
Z2ZzL2lub2RlLmMgYi9mcy9kZWJ1Z2ZzL2lub2RlLmMNCj4+IGluZGV4IGI3ZjJlOTcxZWNiYy4u
YmRlMzdkYWI3N2UwIDEwMDY0NA0KPj4gLS0tIGEvZnMvZGVidWdmcy9pbm9kZS5jDQo+PiArKysg
Yi9mcy9kZWJ1Z2ZzL2lub2RlLmMNCj4+IEBAIC03ODYsMTAgKzc4NiwyNSBAQCBib29sIGRlYnVn
ZnNfaW5pdGlhbGl6ZWQodm9pZCkNCj4+ICB9DQo+PiAgRVhQT1JUX1NZTUJPTF9HUEwoZGVidWdm
c19pbml0aWFsaXplZCk7DQo+PiAgDQo+PiArc3RhdGljIGludCBhbGxvd19kZWJ1Z2ZzOw0KPj4g
Kw0KPj4gK3N0YXRpYyBpbnQgX19pbml0IGRlYnVnZnNfa2VybmVsKGNoYXIgKnN0cikNCj4+ICt7
DQo+PiArCWlmIChzdHIgJiYgIXN0cmNtcChzdHIsICJ0cnVlIikpDQo+PiArCQlhbGxvd19kZWJ1
Z2ZzID0gdHJ1ZTsNCj4+ICsNCj4+ICsJcmV0dXJuIDA7DQo+PiArDQo+PiArfQ0KPj4gK2Vhcmx5
X3BhcmFtKCJkZWJ1Z2ZzIiwgZGVidWdmc19rZXJuZWwpOw0KPj4gKw0KPj4gIHN0YXRpYyBpbnQg
X19pbml0IGRlYnVnZnNfaW5pdCh2b2lkKQ0KPj4gIHsNCj4+ICAJaW50IHJldHZhbDsNCj4+IC0N
Cj4+ICsjaWZkZWYgQ09ORklHX0RFQlVHX0ZTX01PVU5UX1JFU1RSSUNURUQNCj4+ICsJaWYgKCFh
bGxvd19kZWJ1Z2ZzKQ0KPj4gKwkJcmV0dXJuIC1FUEVSTTsNCj4+ICsjZW5kaWYNCj4gQnV0IHlv
dSBhcmUgbm90IHJlc3RyaWN0aW5nIHRoZSBhYmlsaXR5IHRvIG1vdW50IGl0IGhlcmUsIHlvdSBh
cmUNCj4gcmVtb3ZpbmcgdGhlIGFiaWxpdHkgZm9yIGl0IHRvIGV2ZW4gc3RhcnQgdXAgYXQgYWxs
LiAgV2hhdCBkb2VzIHRoaXMNCj4gYnJlYWsgZm9yIGNvZGUgdGhhdCB0aGlua3MgdGhlIGZpbGVz
eXN0ZW0gaXMgcmVnaXN0ZXJlZCAoaS5lLiB0aGUgY2FsbA0KPiB0byBzaW1wbGVfcGluX2ZzKCkg
aW4gc3RhcnRfY3JlYXRpbmcoKSBpbiBmcy9kZWJ1Z2ZzL2lub2RlLmM/DQo+DQpJZiBpdCBkb2Vz
LCB0aGUgbGluZXMgYmVsb3cgaXMgYWxzbyBjYXVzZSB0aGUgc2FtZSBwcm9ibGVtLg0KDQoNCj4N
Cj4+ICAJcmV0dmFsID0gc3lzZnNfY3JlYXRlX21vdW50X3BvaW50KGtlcm5lbF9rb2JqLCAiZGVi
dWciKTsNCj4+ICAJaWYgKHJldHZhbCkNCj4+ICAJCXJldHVybiByZXR2YWw7DQo+PiBkaWZmIC0t
Z2l0IGEvbGliL0tjb25maWcuZGVidWcgYi9saWIvS2NvbmZpZy5kZWJ1Zw0KPj4gaW5kZXggMjFk
OWM1ZjZlN2VjLi5kM2EzMzM4NzQwZDIgMTAwNjQ0DQo+PiAtLS0gYS9saWIvS2NvbmZpZy5kZWJ1
Zw0KPj4gKysrIGIvbGliL0tjb25maWcuZGVidWcNCj4+IEBAIC00NDMsNiArNDQzLDE2IEBAIGNv
bmZpZyBERUJVR19GUw0KPj4gIA0KPj4gIAkgIElmIHVuc3VyZSwgc2F5IE4uDQo+PiAgDQo+PiAr
Y29uZmlnIERFQlVHX0ZTX01PVU5UX1JFU1RSSUNURUQNCj4+ICsJYm9vbCAiRGVidWcgRmlsZXN5
c3RlbSBtb3VudCByZXN0cmljdGVkIg0KPj4gKwlkZXBlbmRzIG9uIERFQlVHX0ZTDQo+PiArCWhl
bHANCj4+ICsJICBUaGlzIGlzIGFuIGFkZGl0aW9uYWwgcmVzdHJpY3Rpb24gZm9yIG1vdW50aW5n
IGRlYnVnZnMuIEl0IGFsbG93cw0KPj4gKwkgIHRoZSBrZXJuZWwgdG8gaGF2ZSBkZWJ1Z2ZzIGNv
bXBpbGVkLCBidXQgcmVxdWlyZXMgdGhhdCBrZXJuZWwgY29tbWFuZA0KPj4gKwkgIGxpbmUgaGFz
IGEgZGVidWdmcyBwYXJhbWV0ZXIgdG8gcmVnaXN0ZXIgYXMgYSBmaWxlc3lzdGVtLg0KPj4gKw0K
Pj4gKwkgIElmIHVuc3VyZSwgc2F5IE4uDQo+IE5vIGhpbnQgYXMgdG8gd2hhdCB0aGUgY29tbWFu
ZCBsaW5lIG9wdGlvbiBpcz8gIEFuZCBhZ2FpbiwgaXQncyBub3QgYQ0KPiByZXN0cmljdGlvbiBm
b3IgbW91bnRpbmcgaXQsIHlvdSBhcmUgcHJldmVudGluZyBpdCBmcm9tIGluaXRpYWxpemluZw0K
PiBlbnRpcmVseS4NCj4NCj4gV2hpY2gsIGFzIEkgaGF2ZSBmb3VuZCBvdXQgb3ZlciB0aW1lLCBj
YW4gaGFkIHNpZGUgYWZmZWN0cyBmb3IgY29kZXBhdGhzDQo+IHRoYXQgdHJ5IHRvIGNoZWNrIHRo
ZSByZXR1cm4gdmFsdWUgb2YgZGVidWdmcyBjYWxscywgYW5kIGlmIHRoZXkgZmFpbCB0bw0KPiBz
dWNjZWVkLCBhYm9ydCB0aGUgd2hvbGUgZHJpdmVyL3N1YnN5c3RlbS93aGF0ZXZlciBpbml0aWFs
aXphaW9uIHBhdGgsDQo+IHdoaWNoIGlzIG5vdCB3aGF0IEkgdGhpbmsgeW91IHdhbnQgdG8gZG8g
aGVyZSBhdCBhbGwuDQo+DQo+IHRoYW5rcywNCj4NCj4gZ3JlZyBrLWgNCg0K
