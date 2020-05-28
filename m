Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66825C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3516820707
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="wBaXzVLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389810AbgE1Mld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 08:41:33 -0400
Received: from mail-eopbgr70100.outbound.protection.outlook.com ([40.107.7.100]:12342
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389773AbgE1Mlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 08:41:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+WQg5+bxi8umGcpPoCuAF3N6GbrhHwceZH58zgmSATv2L2yvEmpkPrSJZjUwOwrm3Hr/B7+lEfqfo5bwirPIDmnKGoBmL9jUiWOxIIu51H0f0ftLH0xQbbGROLR34jYxOXzptY14IgrIShiPunrVde15LQszOOYX5xWyXZwMDPOi1Tz+cf/bGa1YdwHwE49uZoofOG/1QbY5oE7vc79awDkCeI0KiXqbS+9T3MLlGSrbOYhbObb/jAHKnfTpD/d9kd0SS5aVZkQA4GtlHUlEUeuT7mOMlLonD56+7A6x6Z44quEfPWAzBVMEUaeOWZjH5l36oVIokc6kGAYb/iMSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLL5nzq5Kw7k1Ne0OcyWatOzyMwIHzvwEPu0CUZc5LU=;
 b=fXjprqKZ2g/gn6pPW/i/JADdzBX0nDi/4z1j4IXeAs9BL7FPzd5hmfyEewHV0IlmSEbSlXd0nmbfS8ObOD2SSakAj/zWmrkeo5RtDFBs3bthOkxkjTMfYRCCRiaaX8sULH8S2yKWrhBw5YvoHP2gvedWlyGIbQjepXsRsxGYgY/+HZz/5jzYVDWR9egKvdMjeg6sA/xQeGzrh64nSNGkAMb/97ShBEDw+K4NoiPxW8XEMAe3BWijaW405F/+Q2lsSxMi0AA3bdR38KERwoDISUBUPF2KHcxv7/HhinU8TiMM4+Nu71ivQSlE/wU6nENwn3VPR4FF2M3bfReHjjPklQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLL5nzq5Kw7k1Ne0OcyWatOzyMwIHzvwEPu0CUZc5LU=;
 b=wBaXzVLkWIeXQNhsqAR01lDknZ+BCQ+y0mhoc6THY2aj3pT3pT5P3mypwi4gS7IWN9aObTqKlWvJ5YEwy4Mff0o+reXVODb/H1MqX4r3f2KBYiaypv+z1EGyRO4DtSpPdyb9EoSagN8Y5Xl7hGma9lqP0hhA+1EOnz9TzGsxpX8=
Received: from AM0P193MB0596.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:169::22)
 by AM0P193MB0466.EURP193.PROD.OUTLOOK.COM (2603:10a6:208:61::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Thu, 28 May
 2020 12:41:27 +0000
Received: from AM0P193MB0596.EURP193.PROD.OUTLOOK.COM
 ([fe80::49f2:e189:1b3a:85c8]) by AM0P193MB0596.EURP193.PROD.OUTLOOK.COM
 ([fe80::49f2:e189:1b3a:85c8%3]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 12:41:27 +0000
From:   "Enderborg, Peter" <Peter.Enderborg@sony.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] debugfs: Add mount restriction option
Thread-Topic: [PATCH] debugfs: Add mount restriction option
Thread-Index: AQHWNMYbZWEseia5ik2nhGfub1cbHai9KjaAgAADHYCAAA2ggIAAK7sAgAAFY4CAAAT9AA==
Date:   Thu, 28 May 2020 12:41:27 +0000
Message-ID: <ff47071f-3716-5f22-0212-26f59a16373f@sony.com>
References: <20200528080031.24149-1-peter.enderborg@sony.com>
 <20200528082753.GA2920930@kroah.com>
 <3e1be4dc-01d4-7fc5-1c82-1c792d3fbc11@sony.com>
 <20200528092747.GA3007208@kroah.com>
 <1611bed3-8c55-3ba0-af59-c75ad8eeedcc@sony.com>
 <20200528122335.GA3258226@kroah.com>
In-Reply-To: <20200528122335.GA3258226@kroah.com>
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
x-ms-office365-filtering-correlation-id: f1c3baff-3f1c-40ef-9d64-08d803047041
x-ms-traffictypediagnostic: AM0P193MB0466:
x-microsoft-antispam-prvs: <AM0P193MB0466E8CB1A7CFCCB829BD028868E0@AM0P193MB0466.EURP193.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ewr/uCaON3ZzsIVxQEZ7+sXj78SqzHH7cuBzaSpZu/WSX538lxwvdhTVADxul0GVZAeGQu8NfvB+OrzGC6Wlk8OlX8Raee1EzfTg9rCgR/HJDZn1Ympk5rj9j1ALFkeLe/nh2FaXEpPi1o4S71XLOTl+iVF1rCq4EXpBZ9lCyiHJEYjIbseWBWYWAFCW4o3wRUV5cPZXYboZETBpKHd1Vx7e0XVqqynIcDU/cp+BM8p5OpSyQ4L3vxVNDE/k//V6RUPGO9uDlec/1UUrXvGe8P2b9I/q10/HdPIJI2IR3slX2p8k7wBm5d9Fh4O4hSOAlHk4zz4Ad24SX9XPs7sCMxD0V4ifu5rHcttOhqVWh+IoXGw66oRMLpvyOoAH0agO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P193MB0596.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(8936002)(91956017)(86362001)(31696002)(6916009)(6486002)(31686004)(4326008)(83380400001)(478600001)(316002)(54906003)(36756003)(76116006)(6506007)(53546011)(66946007)(2616005)(2906002)(5660300002)(26005)(186003)(71200400001)(8676002)(66476007)(66556008)(6512007)(64756008)(66446008)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: GLgMtuOwp0cYbo797qKyu1Us1RX10kxiihTYQuBe5ue4P5nfGnyB7O8efV6bxeFI3t4efhNEnpAtQCU0UdbiTPQwOm7gax5OUKd0leZdljw+8eFzFD8eTJhaS2qR7G9r7Io+ixxOcLSj8z3HIpoRFQQXhiwZJLn4ijwiYeO+z5O9FdVpEu6x4ufTS3BUx0qlVi3eqXZ+Uf2m/cfwmbegWhDnsy/lsgGMzLpwDo8Vl0QPqH1C/Ce2CQZTHG41DRaBh/ff33WoLl/4DXI+zVx1+Pxd31SNKl466qsVclb5JV/ANBNIICyS5Cz1DYWtOFOudk/Jpk31X/YQA/BlEWKSrxu7BmXUP4yHHs7ouJxzQqafKFJkyqGq3nAEzrTWK3N2lXP0WKJtLvU5iDnQ/ME1EbRpbayB5WQ38wob+MHUmpi/MP3ubk4ysFKTaYSxEdp7+yAgw0hTqjX2/0++NPIhVFo7jjovKlgW/u/eVyVWMnw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FD933BCC4C38449968FDA02C2CDEFDC@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c3baff-3f1c-40ef-9d64-08d803047041
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 12:41:27.0647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zyQJdOFpfjtUlOyPMVsoDQEgFk6po+3kMT8DIynFrAgAGms7fgrDfNgoZ41Ljn0toZSCLSUia5SVe56is01WQ99Av6uUJedgCgL4SxkPhNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0466
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yOC8yMCAyOjIzIFBNLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6DQo+IE9uIFRodSwg
TWF5IDI4LCAyMDIwIGF0IDEyOjA0OjMyUE0gKzAwMDAsIEVuZGVyYm9yZywgUGV0ZXIgd3JvdGU6
DQo+PiBPbiA1LzI4LzIwIDExOjI3IEFNLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6DQo+Pj4g
T24gVGh1LCBNYXkgMjgsIDIwMjAgYXQgMDg6Mzk6MDJBTSArMDAwMCwgRW5kZXJib3JnLCBQZXRl
ciB3cm90ZToNCj4+Pj4gT24gNS8yOC8yMCAxMDoyNyBBTSwgR3JlZyBLcm9haC1IYXJ0bWFuIHdy
b3RlOg0KPj4+Pj4gT24gVGh1LCBNYXkgMjgsIDIwMjAgYXQgMTA6MDA6MzFBTSArMDIwMCwgUGV0
ZXIgRW5kZXJib3JnIHdyb3RlOg0KPj4+Pj4+IFNpbmNlIGRlYnVnZnMgaW5jbHVkZSBzZW5zaXRp
dmUgaW5mb3JtYXRpb24gaXQgbmVlZCB0byBiZSB0cmVhdGVkDQo+Pj4+Pj4gY2FyZWZ1bGx5LiBC
dXQgaXQgYWxzbyBoYXMgbWFueSB2ZXJ5IHVzZWZ1bCBkZWJ1ZyBmdW5jdGlvbnMgZm9yIHVzZXJz
cGFjZS4NCj4+Pj4+PiBXaXRoIHRoaXMgb3B0aW9uIHdlIGNhbiBoYXZlIHNhbWUgY29uZmlndXJh
dGlvbiBmb3Igc3lzdGVtIHdpdGgNCj4+Pj4+PiBuZWVkIG9mIGRlYnVnZnMgYW5kIGEgd2F5IHRv
IHR1cm4gaXQgb2ZmLiBJdCBpcyBuZWVkZWQgbmV3DQo+Pj4+Pj4ga2VybmVsIGNvbW1hbmQgbGlu
ZSBwYXJhbWV0ZXIgdG8gYmUgYWN0aXZhdGVkLg0KPj4+Pj4gQnkgImNvbmZpZ3VyYXRpb24iIGRv
IHlvdSBtZWFuICJrZXJuZWwgY29uZmlndXJhdGlvbiI/ICBXaGF0IGlzIHdyb25nDQo+Pj4+PiB3
aXRoIHJlbHlpbmcgb24gdGhlIGJ1aWxkIG9wdGlvbiBsaWtlIHdlIGRvIHRvZGF5Pw0KPj4+Pj4N
Cj4+Pj4+IFlvdSBtaWdodCB3YW50IHRvIHJld29yZCBhbGwgb2YgdGhpcyB0byBtYWtlIG1vcmUg
c2Vuc2UgYWJvdXQgdGhlDQo+Pj4+PiAicHJvYmxlbSIgeW91IGFyZSB0cnlpbmcgdG8gc29sdmUg
aGVyZSwgYXMgSSBkb24ndCByZWFsbHkgdW5kZXJzdGFuZCBpdCwNCj4+Pj4+IHNvcnJ5Lg0KPj4+
Pj4NCj4+Pj4+DQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgRW5kZXJib3JnIDxwZXRlci5l
bmRlcmJvcmdAc29ueS5jb20+DQo+Pj4+Pj4gLS0tDQo+Pj4+Pj4gIGZzL2RlYnVnZnMvaW5vZGUu
YyB8IDE3ICsrKysrKysrKysrKysrKystDQo+Pj4+Pj4gIGxpYi9LY29uZmlnLmRlYnVnICB8IDEw
ICsrKysrKysrKysNCj4+Pj4+PiAgMiBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+Pj4+PiBObyBkb2N1bWVudGF0aW9uIHVwZGF0ZT8gIFRoYXQncyBub3Qg
Z29vZCA6KA0KPj4+Pj4NCj4+Pj4+DQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2ZzL2RlYnVnZnMvaW5v
ZGUuYyBiL2ZzL2RlYnVnZnMvaW5vZGUuYw0KPj4+Pj4+IGluZGV4IGI3ZjJlOTcxZWNiYy4uYmRl
MzdkYWI3N2UwIDEwMDY0NA0KPj4+Pj4+IC0tLSBhL2ZzL2RlYnVnZnMvaW5vZGUuYw0KPj4+Pj4+
ICsrKyBiL2ZzL2RlYnVnZnMvaW5vZGUuYw0KPj4+Pj4+IEBAIC03ODYsMTAgKzc4NiwyNSBAQCBi
b29sIGRlYnVnZnNfaW5pdGlhbGl6ZWQodm9pZCkNCj4+Pj4+PiAgfQ0KPj4+Pj4+ICBFWFBPUlRf
U1lNQk9MX0dQTChkZWJ1Z2ZzX2luaXRpYWxpemVkKTsNCj4+Pj4+PiAgDQo+Pj4+Pj4gK3N0YXRp
YyBpbnQgYWxsb3dfZGVidWdmczsNCj4+Pj4+PiArDQo+Pj4+Pj4gK3N0YXRpYyBpbnQgX19pbml0
IGRlYnVnZnNfa2VybmVsKGNoYXIgKnN0cikNCj4+Pj4+PiArew0KPj4+Pj4+ICsJaWYgKHN0ciAm
JiAhc3RyY21wKHN0ciwgInRydWUiKSkNCj4+Pj4+PiArCQlhbGxvd19kZWJ1Z2ZzID0gdHJ1ZTsN
Cj4+Pj4+PiArDQo+Pj4+Pj4gKwlyZXR1cm4gMDsNCj4+Pj4+PiArDQo+Pj4+Pj4gK30NCj4+Pj4+
PiArZWFybHlfcGFyYW0oImRlYnVnZnMiLCBkZWJ1Z2ZzX2tlcm5lbCk7DQo+Pj4+Pj4gKw0KPj4+
Pj4+ICBzdGF0aWMgaW50IF9faW5pdCBkZWJ1Z2ZzX2luaXQodm9pZCkNCj4+Pj4+PiAgew0KPj4+
Pj4+ICAJaW50IHJldHZhbDsNCj4+Pj4+PiAtDQo+Pj4+Pj4gKyNpZmRlZiBDT05GSUdfREVCVUdf
RlNfTU9VTlRfUkVTVFJJQ1RFRA0KPj4+Pj4+ICsJaWYgKCFhbGxvd19kZWJ1Z2ZzKQ0KPj4+Pj4+
ICsJCXJldHVybiAtRVBFUk07DQo+Pj4+Pj4gKyNlbmRpZg0KPj4+Pj4gQnV0IHlvdSBhcmUgbm90
IHJlc3RyaWN0aW5nIHRoZSBhYmlsaXR5IHRvIG1vdW50IGl0IGhlcmUsIHlvdSBhcmUNCj4+Pj4+
IHJlbW92aW5nIHRoZSBhYmlsaXR5IGZvciBpdCB0byBldmVuIHN0YXJ0IHVwIGF0IGFsbC4gIFdo
YXQgZG9lcyB0aGlzDQo+Pj4+PiBicmVhayBmb3IgY29kZSB0aGF0IHRoaW5rcyB0aGUgZmlsZXN5
c3RlbSBpcyByZWdpc3RlcmVkIChpLmUuIHRoZSBjYWxsDQo+Pj4+PiB0byBzaW1wbGVfcGluX2Zz
KCkgaW4gc3RhcnRfY3JlYXRpbmcoKSBpbiBmcy9kZWJ1Z2ZzL2lub2RlLmM/DQo+Pj4+Pg0KPj4+
PiBJZiBpdCBkb2VzLCB0aGUgbGluZXMgYmVsb3cgaXMgYWxzbyBjYXVzZSB0aGUgc2FtZSBwcm9i
bGVtLg0KPj4+IEluIGEgd29ya2luZyBzeXN0ZW0sIGVycm9ycyBpbiB0aGUgbGluZXMgYmVsb3cg
d2lsbCBuZXZlciBoYXBwZW4gOikNCj4+IEkgdGhpbmsgaXQgaXMgbm90IHVucmVhc29uYWJsZSB0
byBleHBlY3QgdGhhdCBkZWJ1ZyBmdW5jdGlvbmFsaXR5IGFyZSByb2J1c3QgZW5vdWdoIHRvIGhh
bmRsZQ0KPj4gc3lzdGVtIHdoZXJlIG5vdCBldmVyeXRoaW5nIGlzIHdvcmtpbmcgc21vb3RobHku
DQo+IEkgZG8gbm90IGRpc2FncmVlLCBidXQgaGF2ZSB5b3UgdGVzdGVkIHRoaXMgdG8gZW5zdXJl
IHRoYXQgeW91ciBrZXJuZWwNCj4gc3RpbGwgd29ya3Mgd2hlbiB5b3UgZGlzYWJsZSBkZWJ1Z2Zz
IGluIHRoaXMgbWFubmVyPw0KDQpTbyBmYXIgb25seSB0ZXN0ZWQgb24gZmVkb3JhIGYzMiAoeDg2
XzY0KSBhbmQgb2xkZXIgYXJtNjQgc3lzdGVtcy4NCg0KU28gZmFyIG9ubHkgenN3YXAgdGhhdCBw
cmludHMgb3V0IHRoYXQgImRlYnVnZnMgaW5pdGlhbGl6YXRpb24gZmFpbGVkIiBhbmQgaXQgc3Rp
bGwgd29ya3MgZmluZS4NCg0KDQo+IElmIHNvLCBncmVhdCEgIEp1c3QgdHJ5aW5nIHRvIHBvaW50
IG91dCBhIHBvdGVudGlhbCBwcm9ibGVtLi4uDQoNCg0KV2lsbCBkbyBuZXcgcGF0Y2hzZXQsIGlt
IHdhaXRpbmcgYSBiaXQgbG9uZ2VyIHRvIHNlZSBpZiB0aGVyZSBzb21lIG90aGVyIGNvbW1lbnRz
IGZpcnN0Lg0KDQoNCj4gdGhhbmtzLA0KPg0KPiBncmVnIGstaA0KDQo=
