Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3AEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31AEE20776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=necglobal.onmicrosoft.com header.i=@necglobal.onmicrosoft.com header.b="Q+9/YU5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404904AbgE2CMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 22:12:33 -0400
Received: from mail-eopbgr1310087.outbound.protection.outlook.com ([40.107.131.87]:52480
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404580AbgE2CMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:12:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clAHRbqpEqh+I/+r2zngz4uLOsxSAcsxBELIB5zqSS0TECa0l478lAa8THzuvhLMHy7lRlXi86RoflOlAHUD/C3YlCCPCYitLBr2KATMvYNOiAaUGZkMjG/QnPdsac0tgw3fj/r2XL/veBEAvlwbU2q9WgFtvNkTpxCRl5RCzN7jh8y17WPp5+eU6sme54bsnwup8XwTltRUTZY/SAPOaNKBWy2Z1yZITdn1uY1GgHDdnR9sTy3wsbhsNMTncogxg9CIxwLge9SdkjsQyCq2O1r+CksSyGfout07reBX1W1jC31E0v8D+ggfwK900scqH8IuynhqBwKDZoAIB1hQqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hL7mltVcdWdzEB6b8QrUtmM5A7d5n/y8uOpB7hMDuv8=;
 b=C0fSfiMUW/bn3M52IaZj7AmGnXCw1ydG+18Ty2CVzvtr3cFD1FbrKHb6JCRLxMTUrRY1dSKS75lfNtMjttv77+cdx1nRIfH6KgUhlw01LKBbqBLHjbY5xYy6KMWsYPlEk09nDs5Eh5RukUnk2NbVAg7NTOomMCF2KAFwmBWvuWrt+mckCN1KZg58FU6df+E/jWXjsFB3ri92HCFlonMrrzku3O17fQVE8y4+P8KBE6BHkSXZ+w3ulJWqzVoEfBeZ88JSK9rvYpf+8HJyTQ7CazghFRWbF2KQgEC2PSrm/rL7JsOYdp9v6UsCMTFyg4peQw+Qr8EXwqsRUKchaPDQJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hL7mltVcdWdzEB6b8QrUtmM5A7d5n/y8uOpB7hMDuv8=;
 b=Q+9/YU5GWGpkRObKD5Plnww93UrjeZfINnH06lSD5ot7bm1w3+u8T9z9aX6/sMKRXjEKRNFTmP7vuTMKUYfN9WGk0f6MEbriweZl97NHccxSil8tA+g68UOULFjcj1wFC/SW5G76vboiMpJThtGdMtgMkGOMljxgsM0NnP6NBCg=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TY2PR01MB1947.jpnprd01.prod.outlook.com (2603:1096:404:e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Fri, 29 May
 2020 02:12:24 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::3841:ec9f:5cdf:f58]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::3841:ec9f:5cdf:f58%5]) with mapi id 15.20.3021.030; Fri, 29 May 2020
 02:12:24 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     wetp <wetp.zy@linux.alibaba.com>
CC:     "n-horiguchi@ah.jp.nec.com" <n-horiguchi@ah.jp.nec.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, memory_failure: only send BUS_MCEERR_AO to early-kill
 process
Thread-Topic: [PATCH] mm, memory_failure: only send BUS_MCEERR_AO to
 early-kill process
Thread-Index: AQHWMyxBK5FsG+fd5ka/mAnJKqbKvKi8x2GAgABKu4CAAUS6AA==
Date:   Fri, 29 May 2020 02:12:24 +0000
Message-ID: <20200529021224.GA345@hori.linux.bs1.fc.nec.co.jp>
References: <1590476801-19882-1-git-send-email-wetp.zy@linux.alibaba.com>
 <20200528022241.GA1401@hori.linux.bs1.fc.nec.co.jp>
 <881b990a-2198-8e80-036e-bfa6f88070ff@linux.alibaba.com>
In-Reply-To: <881b990a-2198-8e80-036e-bfa6f88070ff@linux.alibaba.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2cb8c5e5-5c51-489a-6392-08d80375ba89
x-ms-traffictypediagnostic: TY2PR01MB1947:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB1947B6887ADE6465D0EF5C0DE78F0@TY2PR01MB1947.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04180B6720
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B7KGvO92i0Jjo6s+CA/pOKsaefdPmb5DmhaOwNDsx+T76ImMGTcT7g/2wYtcQyabjRlXAJGvOtpFTWfyhYBxhpY2u0T1ndIxZeOZ9iyVUb78ptiONcJ8KcUEAbxE0uVjOcNWH+7UfoZe9THtyjn/+NC+04qdry0pmDJHoB0uc3qhdRH2vGv7q0uM/hgRikfvFOcC4UuIOjjFDjAX2X1ZFfhdM4WVDG+Zjj+bU5/sjFxxOys4a0UFg9FK0XcvT0yVOWJYILNk2t4OR3oobcNt4VLN1J+mFiIhCYYH4ZVZXKH1/SJ1Ogf3owTm6b4aFdS/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(6916009)(66476007)(64756008)(66556008)(66446008)(2906002)(8676002)(85182001)(55236004)(8936002)(71200400001)(6506007)(54906003)(478600001)(1076003)(66946007)(76116006)(86362001)(9686003)(5660300002)(33656002)(6512007)(4326008)(83380400001)(6486002)(26005)(316002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: cb0qpfuvHrXPEXjUoKuG1GRO988oYLcnxlgSEVoxn9+kPm6vY0/riS8hFVkiXxo1jcBc+gQeCeRMq1FM/Ftmsjnp7N5LIqE7NvziQpmZOqP1a2LlJ0I6kp79rOVK6edilIUE9OH7c8/AaslcqrRat9qZZpVEvBKJgIMSvriDQus9dYiAWaKglS9+bSm3Q8wSEKPzKbZmMnmtV6G8OA2UEynhZn0oqwdmTvnrro9n5jx/Zi4n6IUcpx7rrqE3uok4zgE4/XNh4TZWPBXx+ioNfWioTgu4K5lGz7j/50MRO52mV5cqN6CSSbFx8Pvp1oLvv8mVlL5VLGqzMkD1OlWXzhTPg3Hr5vp53+Rv43Ymiks8OYTMwrG3Kzh0bXqE+92EIRM7FQY8OaP912njCnR1gwzoOV//894TkhQk23QJAg/Km0qqt5kMsT4B3h7oHitFmsFhZUqlaTcs6tIq2PukSPfIsfsdfrAGIBlHxWEZ6jjd2IwLt+Js4xLLhNV+br2v
Content-Type: text/plain; charset="utf-8"
Content-ID: <1484C21B0EAAD148AE69E3814FA4F12C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb8c5e5-5c51-489a-6392-08d80375ba89
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2020 02:12:24.8188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J/cpm0BX7TlXn9Q9/xDgSPxIsloNs71jmncbbmSBH/H/n8IMy1muM12nUh3toQYxBu5G+3Q6EiPbejeSLAWbRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB1947
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBNYXkgMjgsIDIwMjAgYXQgMDI6NTA6MDlQTSArMDgwMCwgd2V0cCB3cm90ZToNCj4g
DQo+IE9uIDIwMjAvNS8yOCDkuIrljYgxMDoyMiwgSE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7Tk
uZ8pIHdyb3RlOg0KPiA+IEhpIFpoYW5nLA0KPiA+IA0KPiA+IFNvcnJ5IGZvciBteSBsYXRlIHJl
c3BvbnNlLg0KPiA+IA0KPiA+IE9uIFR1ZSwgTWF5IDI2LCAyMDIwIGF0IDAzOjA2OjQxUE0gKzA4
MDAsIFdldHAgWmhhbmcgd3JvdGU6DQo+ID4gPiBGcm9tOiBaaGFuZyBZaSA8d2V0cHp5QGdtYWls
LmNvbT4NCj4gPiA+IA0KPiA+ID4gSWYgYSBwcm9jZXNzIGRvbid0IG5lZWQgZWFybHkta2lsbCwg
aXQgbWF5IG5vdCBjYXJlIHRoZSBCVVNfTUNFRVJSX0FPLg0KPiA+ID4gTGV0IHRoZSBwcm9jZXNz
IHRvIGJlIGtpbGxlZCB3aGVuIGl0IHJlYWxseSBhY2Nlc3MgdGhlIGNvcnJ1cHRlZCBtZW1vcnku
DQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFpoYW5nIFlpIDx3ZXRwenlAZ21haWwuY29t
Pg0KPiA+IFRoYW5rIHlvdSBmb3IgcG9pbnRpbmcgdGhpcy4gVGhpcyBsb29rcyB0byBtZSBhIGJ1
ZyAocGVyLXByb2Nlc3MgZmxhZw0KPiA+IGlzIGlnbm9yZWQgd2hlbiBzeXN0ZW0td2lkZSBmbGFn
IGlzIHNldCkuDQo+IA0KPiBUaGUgZmxhZyBpcyBub3QgcHJvYmxlbSBmb3IgbWUuDQo+IA0KPiBJ
biBteSBjYXNlLCB0d28gcHJvY2Vzc2VzIHNoYXJlIG1lbW9yeSB3aXRoIG5vIGFueSBmbGFnIHNl
dHRpbmcsIGJvdGggd2lsbA0KPiBiZSBraWxsZWQgd2hlbiBvbmx5IG9uZQ0KPiANCj4gYWNjZXNz
IHRoZSBmYWlsIG1lbW9yeS4NCg0KVGhhbmtzLCBub3cgeW91ciBwcm9ibGVtIHNlZW1zIGNsZWFy
ZXIuDQoNCkl0IHNlZW1zIHRoYXQgdGhpcyBoYXBwZW5zIGJlY2F1c2UgaW4gIkFjdGlvbiBSZXF1
aXJlZCIgY2FzZSBraWxsX3Byb2MoKQ0KdGFrZXMgdGhlIGZpcnN0IGJyYW5jaCBmb3IgY3VycmVu
dCBwcm9jZXNzLCB3aGlsZSBpdCB0YWtlcyB0aGUgZWxzZSBicmFuY2gNCmZvciBvdGhlciBhZmZl
Y3RlZCBwcm9jZXNzZXM6DQoNCiAgICBzdGF0aWMgaW50IGtpbGxfcHJvYyhzdHJ1Y3QgdG9fa2ls
bCAqdGssIHVuc2lnbmVkIGxvbmcgcGZuLCBpbnQgZmxhZ3MpDQogICAgew0KICAgICAgICAgICAg
Li4uDQogICAgDQogICAgICAgICAgICBpZiAoKGZsYWdzICYgTUZfQUNUSU9OX1JFUVVJUkVEKSAm
JiB0LT5tbSA9PSBjdXJyZW50LT5tbSkgew0KICAgICAgICAgICAgICAgICAgICByZXQgPSBmb3Jj
ZV9zaWdfbWNlZXJyKEJVU19NQ0VFUlJfQVIsICh2b2lkIF9fdXNlciAqKXRrLT5hZGRyLA0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFkZHJfbHNiKTsNCiAgICAg
ICAgICAgIH0gZWxzZSB7DQogICAgICAgICAgICAgICAgICAgIC8qDQogICAgICAgICAgICAgICAg
ICAgICAqIERvbid0IHVzZSBmb3JjZSBoZXJlLCBpdCdzIGNvbnZlbmllbnQgaWYgdGhlIHNpZ25h
bA0KICAgICAgICAgICAgICAgICAgICAgKiBjYW4gYmUgdGVtcG9yYXJpbHkgYmxvY2tlZC4NCiAg
ICAgICAgICAgICAgICAgICAgICogVGhpcyBjb3VsZCBjYXVzZSBhIGxvb3Agd2hlbiB0aGUgdXNl
ciBzZXRzIFNJR0JVUw0KICAgICAgICAgICAgICAgICAgICAgKiB0byBTSUdfSUdOLCBidXQgaG9w
ZWZ1bGx5IG5vIG9uZSB3aWxsIGRvIHRoYXQ/DQogICAgICAgICAgICAgICAgICAgICAqLw0KICAg
ICAgICAgICAgICAgICAgICByZXQgPSBzZW5kX3NpZ19tY2VlcnIoQlVTX01DRUVSUl9BTywgKHZv
aWQgX191c2VyICopdGstPmFkZHIsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBhZGRyX2xzYiwgdCk7ICAvKiBzeW5jaHJvbm91cz8gKi8NCiAgICAgICAgICAgIH0N
Cg0KU2VuZGluZyBTSUdCVVMgd2l0aCBCVVNfTUNFRVJSX0FPIGZvciBhY3Rpb24gb3B0aW9uYWwg
ZXJyb3IgaXMgc3RyYW5nZSwgc28NCm1heWJlIHRoaXMgbG9naWMgc2hvdWxkIGJlIGxpa2UgdGhp
czoNCg0KDQogICAgICAgICAgICBpZiAoZmxhZ3MgJiBNRl9BQ1RJT05fUkVRVUlSRUQpIHsNCiAg
ICAgICAgICAgICAgICAgICAgaWYgKHQtPm1tID09IGN1cnJlbnQtPm1tKQ0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHJldCA9IGZvcmNlX3NpZ19tY2VlcnIoQlVTX01DRUVSUl9BUiwgKHZv
aWQgX191c2VyICopdGstPmFkZHIsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgYWRkcl9sc2IpOw0KICAgICAgICAgICAgICAgICAgICAvKiBzZW5kIG5vIHNpZ25h
bCB0byBub24tY3VycmVudCBwcm9jZXNzZXMgKi8NCiAgICAgICAgICAgIH0gZWxzZSB7DQogICAg
ICAgICAgICAgICAgICAgIC8qDQogICAgICAgICAgICAgICAgICAgICAqIERvbid0IHVzZSBmb3Jj
ZSBoZXJlLCBpdCdzIGNvbnZlbmllbnQgaWYgdGhlIHNpZ25hbA0KICAgICAgICAgICAgICAgICAg
ICAgKiBjYW4gYmUgdGVtcG9yYXJpbHkgYmxvY2tlZC4NCiAgICAgICAgICAgICAgICAgICAgICog
VGhpcyBjb3VsZCBjYXVzZSBhIGxvb3Agd2hlbiB0aGUgdXNlciBzZXRzIFNJR0JVUw0KICAgICAg
ICAgICAgICAgICAgICAgKiB0byBTSUdfSUdOLCBidXQgaG9wZWZ1bGx5IG5vIG9uZSB3aWxsIGRv
IHRoYXQ/DQogICAgICAgICAgICAgICAgICAgICAqLw0KICAgICAgICAgICAgICAgICAgICByZXQg
PSBzZW5kX3NpZ19tY2VlcnIoQlVTX01DRUVSUl9BTywgKHZvaWQgX191c2VyICopdGstPmFkZHIs
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhZGRyX2xzYiwgdCk7
ICAvKiBzeW5jaHJvbm91cz8gKi8NCiAgICAgICAgICAgIH0NCg0KPiANCj4gPiA+IC0tLQ0KPiA+
ID4gICBtbS9tZW1vcnktZmFpbHVyZS5jIHwgNyArKysrLS0tDQo+ID4gPiAgIDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYg
LS1naXQgYS9tbS9tZW1vcnktZmFpbHVyZS5jIGIvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiA+ID4g
aW5kZXggYTk2MzY0YmU4YWI0Li4yZGIxM2Q0ODg2NWMgMTAwNjQ0DQo+ID4gPiAtLS0gYS9tbS9t
ZW1vcnktZmFpbHVyZS5jDQo+ID4gPiArKysgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQo+ID4gPiBA
QCAtMjEwLDcgKzIxMCw3IEBAIHN0YXRpYyBpbnQga2lsbF9wcm9jKHN0cnVjdCB0b19raWxsICp0
aywgdW5zaWduZWQgbG9uZyBwZm4sIGludCBmbGFncykNCj4gPiA+ICAgew0KPiA+ID4gICAJc3Ry
dWN0IHRhc2tfc3RydWN0ICp0ID0gdGstPnRzazsNCj4gPiA+ICAgCXNob3J0IGFkZHJfbHNiID0g
dGstPnNpemVfc2hpZnQ7DQo+ID4gPiAtCWludCByZXQ7DQo+ID4gPiArCWludCByZXQgPSAwOw0K
PiA+ID4gDQo+ID4gPiAgIAlwcl9lcnIoIk1lbW9yeSBmYWlsdXJlOiAlI2x4OiBTZW5kaW5nIFNJ
R0JVUyB0byAlczolZCBkdWUgdG8gaGFyZHdhcmUgbWVtb3J5IGNvcnJ1cHRpb25cbiIsDQo+ID4g
PiAgIAkJcGZuLCB0LT5jb21tLCB0LT5waWQpOw0KPiA+ID4gQEAgLTIyNSw4ICsyMjUsOSBAQCBz
dGF0aWMgaW50IGtpbGxfcHJvYyhzdHJ1Y3QgdG9fa2lsbCAqdGssIHVuc2lnbmVkIGxvbmcgcGZu
LCBpbnQgZmxhZ3MpDQo+ID4gPiAgIAkJICogVGhpcyBjb3VsZCBjYXVzZSBhIGxvb3Agd2hlbiB0
aGUgdXNlciBzZXRzIFNJR0JVUw0KPiA+ID4gICAJCSAqIHRvIFNJR19JR04sIGJ1dCBob3BlZnVs
bHkgbm8gb25lIHdpbGwgZG8gdGhhdD8NCj4gPiA+ICAgCQkgKi8NCj4gPiA+IC0JCXJldCA9IHNl
bmRfc2lnX21jZWVycihCVVNfTUNFRVJSX0FPLCAodm9pZCBfX3VzZXIgKil0ay0+YWRkciwNCj4g
PiA+IC0JCQkJICAgICAgYWRkcl9sc2IsIHQpOyAgLyogc3luY2hyb25vdXM/ICovDQo+ID4gPiAr
CQlpZiAoKHQtPmZsYWdzICYgUEZfTUNFX1BST0NFU1MpICYmICh0LT5mbGFncyAmIFBGX01DRV9F
QVJMWSkpDQo+ID4gPiArCQkJcmV0ID0gc2VuZF9zaWdfbWNlZXJyKEJVU19NQ0VFUlJfQU8sDQo+
ID4gPiArCQkJCSh2b2lkIF9fdXNlciAqKXRrLT5hZGRyLCBhZGRyX2xzYiwgdCk7DQo+ID4ga2ls
bF9wcm9jKCkgY291bGQgYmUgY2FsbGVkIG9ubHkgZm9yIHByb2Nlc3NlcyB0aGF0IGFyZSBzZWxl
Y3RlZCBieQ0KPiA+IGNvbGxlY3RfcHJvY3MoKSB3aXRoIHRhc2tfZWFybHlfa2lsbCgpLiAgU28g
SSB0aGluayB0aGF0IHdlIHNob3VsZCBmaXgNCj4gPiB0YXNrX2Vhcmx5X2tpbGwoKSwgbWF5YmUg
YnkgcmVvcmRlcmluZyBzeXNjdGxfbWVtb3J5X2ZhaWx1cmVfZWFybHlfa2lsbA0KPiA+IGNoZWNr
IGFuZCBmaW5kX2Vhcmx5X2tpbGxfdGhyZWFkKCkgY2hlY2suDQo+ID4gDQo+ID4gICAgICBzdGF0
aWMgc3RydWN0IHRhc2tfc3RydWN0ICp0YXNrX2Vhcmx5X2tpbGwoc3RydWN0IHRhc2tfc3RydWN0
ICp0c2ssDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgaW50IGZvcmNlX2Vhcmx5KQ0KPiA+ICAgICAgew0KPiA+ICAgICAgICAgICAgICBzdHJ1Y3Qg
dGFza19zdHJ1Y3QgKnQ7DQo+ID4gICAgICAgICAgICAgIGlmICghdHNrLT5tbSkNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsNCj4gPiAgICAgICAgICAgICAgaWYgKGZvcmNl
X2Vhcmx5KQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgIHJldHVybiB0c2s7DQo+IA0KPiBUaGUg
Zm9yY2VfZWFybHkgaXMgcmVseSB0aGUgZmxhZyBNRl9BQ1RJT05fUkVRVUlSRUQsIHNvIGl0IGlz
IGFsd2F5cyB0cnVlDQo+IHdoZW4gTUNFIG9jY3Vycy4NCj4gDQo+IFRoaXMgbGVhZHMgYWx3YXlz
IHNlbmRpbmcgU0lHQlVTIHRvIHByb2Nlc3NlcyBldmVuIGlmIHRob3NlIGFyZSBub3QgY3VycmVu
dA0KPiBvciBubyBmbGFnIHNldHRpbmcuDQo+IA0KPiDCoEkgdGhpbmsgaXQgY291bGQga2VlcCB0
aGUgbm9uLWN1cnJlbnQgcHJvY2Vzc2VzIHdoaWNoIGhhcyBubyBmbGFnIHNldHRpbmcNCj4gcnVu
bmluZy4NCj4gDQo+IA0KPiBCZXNpZGVzLCBiYXNlIG9uIHlvdXIgcmVjb21tZW5kYXRpb24gSSBy
ZW9yZGVyIHRoZSBmb3JjZV9lYXJseSBjaGVjayBhbmQNCj4gZmluZF9lYXJseV9raWxsX3RocmVh
ZCgpDQo+IA0KPiBjaGVjaywgdG8gc2VuZCB0aGUgc2lnbmFsIHRvIHRoZSByaWdodCB0aHJlYWQu
DQoNClNvcnJ5LCBteSBwcmV2aW91cyBjb21tZW50IGFyb3VuZCB0YXNrX2Vhcmx5X2tpbGwoKSBp
cyBmb3IgYSBzZXBhcmF0ZSBwcm9ibGVtLA0Kc28gSSdsbCB0cnkgc29tZSBmaXggb24gdGhpcyBs
YXRlci4NCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hp
