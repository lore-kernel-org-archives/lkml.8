Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62138C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 070E5206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Verisilicon.com header.i=@Verisilicon.com header.b="CU8pHD4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgFAG5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 02:57:14 -0400
Received: from shasxm05.verisilicon.com ([101.89.135.45]:36785 "EHLO
        shasxm03.verisilicon.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725831AbgFAG5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 02:57:13 -0400
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; d=Verisilicon.com; s=default;
        c=simple/simple; t=1590994614; h=from:subject:to:date:message-id;
        bh=4qG349RdAzrAc07AyF8vX5lCfbp3MpRzTmtg0uuXliw=;
        b=CU8pHD4wyBq4jER9Q/2XFVkUi2/sS0FQWxnUBf9KSERbvzbY5vg5Ehw35sfVOUsLCzPp0i7c8Ro
        X9Nc8iobBvC3KUNjwyzPWFGgneEeePGi6fY8/nT2LYptgdgzyUCIIk8QPcMUymd3cl4pUO03SN99X
        ST+uUjPmWMtIEpWnVt4=
Received: from SHASXM03.verisilicon.com ([fe80::938:4dda:a2f9:38aa]) by
 SHASXM06.verisilicon.com ([fe80::59a8:ce34:dc14:ddda%16]) with mapi id
 14.03.0123.003; Mon, 1 Jun 2020 14:56:52 +0800
From:   "Zhu, Joe" <Chunguang.Zhu@verisilicon.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        "joe_zhuchg@126.com" <joe_zhuchg@126.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIG1haWxib3g6IG5vIGVycm9yIGxvZyBpbiBtYm94?=
 =?utf-8?B?X2NsaWVudF90eGRvbmUoKSBmb3IgdHggZG9uZSBieSBpcnE=?=
Thread-Topic: [PATCH] mailbox: no error log in mbox_client_txdone() for tx
 done by irq
Thread-Index: AQHWJ1gmr9JSgHr8iEWJjpKwhpOmKqjAq/+AgALArsA=
Date:   Mon, 1 Jun 2020 06:56:51 +0000
Message-ID: <5564B50DC8FF8945812290C7B168B6C770148717@SHASXM03.verisilicon.com>
References: <20200511055052.23868-1-joe_zhuchg@126.com>
 <CABb+yY0qBk_BgexswYOaBf4qac605KBwYxah2yD4nYeADi8Phg@mail.gmail.com>
In-Reply-To: <CABb+yY0qBk_BgexswYOaBf4qac605KBwYxah2yD4nYeADi8Phg@mail.gmail.com>
Accept-Language: zh-CN, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.3.87]
x-tm-as-product-ver: SMEX-11.0.0.4179-8.100.1062-25454.001
x-tm-as-result: No--11.209900-0.000000-31
x-tm-as-user-approved-sender: Yes
x-tm-as-user-blocked-sender: No
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFzc2ksDQogIENsaWVudCBjYW4gbm90IGtub3cgaG93IG1haWxib3ggY29udHJvbGxlciBp
bXBsZW1lbnRzIFRYIGRvbmUuIFRoZXJlIGlzIG5vIEFQSSBpbiBtYWlsYm94X2NsaWVudC5oIHRv
IGdldCB0aGlzIGluZm9ybWF0aW9uLg0KICBJIHRoaW5rIGl0IGlzIGZyYW1ld29yaycgcmVzcG9u
c2liaWxpdHksIG5vdCBjbGllbnQsIHRvIGhhbmRsZSBjb250cm9sbGVyJyBkaWZmZXJlbnQgYmVo
YXZpb3IuIFRoYW5rcyENCg0KUmVnYXJkcywNCkpvZQ0KDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0t
LS0NCuWPkeS7tuS6ujogSmFzc2kgQnJhciBbbWFpbHRvOmphc3Npc2luZ2hicmFyQGdtYWlsLmNv
bV0gDQrlj5HpgIHml7bpl7Q6IDIwMjDlubQ15pyIMzHml6UgNDoyNQ0K5pS25Lu25Lq6OiBqb2Vf
emh1Y2hnQDEyNi5jb20NCuaKhOmAgTogTGludXggS2VybmVsIE1haWxpbmcgTGlzdDsgWmh1LCBK
b2UNCuS4u+mimDogUmU6IFtQQVRDSF0gbWFpbGJveDogbm8gZXJyb3IgbG9nIGluIG1ib3hfY2xp
ZW50X3R4ZG9uZSgpIGZvciB0eCBkb25lIGJ5IGlycQ0KDQpPbiBNb24sIE1heSAxMSwgMjAyMCBh
dCAxMjo1MiBBTSA8am9lX3podWNoZ0AxMjYuY29tPiB3cm90ZToNCj4NCj4gRnJvbTogSm9lIFpo
dSA8Q2h1bmd1YW5nLlpodUB2ZXJpc2lsaWNvbi5jb20+DQo+DQo+IGNsaWVudCBkb2VzIG5vdCBr
bm93IGFuZCBub3QgY2FyZSBhYm91dCBob3cgY29udHJvbGxlciBpbXBsZW1lbnQgdHggZG9uZS4N
Cj4gbWJveF9jbGllbnRfdHhkb25lKCkgbWF5IGJlIGNhbGxlZCB3aGVuIGNvbnRyb2xsZXIgdXNl
cyBpcnEgbWV0aG9kLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb2UgWmh1IDxDaHVuZ3VhbmcuWmh1
QHZlcmlzaWxpY29uLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL21haWxib3gvbWFpbGJveC5jIHwg
NCArKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21haWxib3gvbWFpbGJveC5jIGIvZHJpdmVycy9t
YWlsYm94L21haWxib3guYw0KPiBpbmRleCAwYjgyMWE1YjJkYjguLjExNjEyNGFkZjE4OCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9tYWlsYm94L21haWxib3guYw0KPiArKysgYi9kcml2ZXJzL21h
aWxib3gvbWFpbGJveC5jDQo+IEBAIC0xODksNyArMTg5LDkgQEAgRVhQT1JUX1NZTUJPTF9HUEwo
bWJveF9jaGFuX3R4ZG9uZSk7DQo+ICB2b2lkIG1ib3hfY2xpZW50X3R4ZG9uZShzdHJ1Y3QgbWJv
eF9jaGFuICpjaGFuLCBpbnQgcikNCj4gIHsNCj4gICAgICAgICBpZiAodW5saWtlbHkoIShjaGFu
LT50eGRvbmVfbWV0aG9kICYgVFhET05FX0JZX0FDSykpKSB7DQo+IC0gICAgICAgICAgICAgICBk
ZXZfZXJyKGNoYW4tPm1ib3gtPmRldiwgIkNsaWVudCBjYW4ndCBydW4gdGhlIFRYIHRpY2tlclxu
Iik7DQo+ICsgICAgICAgICAgICAgICBpZiAodW5saWtlbHkoIShjaGFuLT50eGRvbmVfbWV0aG9k
ICYgVFhET05FX0JZX0lSUSkpKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKGNo
YW4tPm1ib3gtPmRldiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJDbGllbnQg
Y2FuJ3QgcnVuIHRoZSBUWCB0aWNrZXJcbiIpOw0KPiAgICAgICAgICAgICAgICAgcmV0dXJuOw0K
PiAgICAgICAgIH0NCklmIGl0IGlzIG5vdCBieSBBQ0ssIGNsaWVudCBzaG91bGQgbm90IGNhbGwg
dHhkb25lKCkgc28gd2Ugc2hvdXQNCmltbWVkaWF0ZWx5LiBPdGhlcndpc2Ugc29tZXRoaW5nIGlz
IHdyb25nLg0KDQp0aGFua3MuDQo=
