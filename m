Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FBBC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31DAC2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ALExibe9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgIKJ3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 05:29:33 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:35611 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725710AbgIKJ3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 05:29:30 -0400
X-UUID: 42361a4cbe834d3abe5571584c2425bd-20200911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=9Aq51FOERNaMNDKcW34Pu/zomNrhFzlYyLddBNePP8k=;
        b=ALExibe9LPrFBRIDdSl5C+fsVdRhfjs87JPMOMWOnntyUzlm/tiK/gnvTDCZ+ePfYf4l2WnqiFEdq6GIGyfaCEP0QnnNk7L4Pkb9JHnGQ98MqclE7aPGVJgKOBALJ6TRI8perZ9NtOFYRg4jGl3SljVW27nncXkESKbQyHtXNcM=;
X-UUID: 42361a4cbe834d3abe5571584c2425bd-20200911
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1583240714; Fri, 11 Sep 2020 17:29:19 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 11 Sep
 2020 17:29:17 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Sep 2020 17:29:17 +0800
Message-ID: <1599816442.29909.10.camel@mhfsdcap03>
Subject: Re: [PATCH RESEND v3 04/11] usb: xhci-rcar: convert to
 readl_poll_timeout_atomic()
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
CC:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Jason Yan <yanaijie@huawei.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Ben Dooks" <ben.dooks@codethink.co.uk>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Date:   Fri, 11 Sep 2020 17:27:22 +0800
In-Reply-To: <20200911083421.g5cidlnwfiksggvk@holly.lan>
References: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
         <1599726112-4439-4-git-send-email-chunfeng.yun@mediatek.com>
         <20200910131212.wm7zskxvcesl652c@holly.lan>
         <1599791601.24609.5.camel@mhfsdcap03>
         <20200911083421.g5cidlnwfiksggvk@holly.lan>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: D9BF7DBA819C0CCA0CE8880A27C525BF3E313AFA5C9FA45D086E4A91339CB2422000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTA5LTExIGF0IDA5OjM0ICswMTAwLCBEYW5pZWwgVGhvbXBzb24gd3JvdGU6
DQo+IE9uIEZyaSwgU2VwIDExLCAyMDIwIGF0IDEwOjMzOjIxQU0gKzA4MDAsIENodW5mZW5nIFl1
biB3cm90ZToNCj4gPiBPbiBUaHUsIDIwMjAtMDktMTAgYXQgMTQ6MTIgKzAxMDAsIERhbmllbCBU
aG9tcHNvbiB3cm90ZToNCj4gPiA+IE9uIFRodSwgU2VwIDEwLCAyMDIwIGF0IDA0OjIxOjQ1UE0g
KzA4MDAsIENodW5mZW5nIFl1biB3cm90ZToNCj4gPiA+ID4gVXNlIHJlYWRsX3BvbGxfdGltZW91
dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQo+ID4gPiA+IA0KPiA+ID4gPiBDYzogTWF0aGlh
cyBOeW1hbiA8bWF0aGlhcy5ueW1hbkBsaW51eC5pbnRlbC5jb20+DQo+ID4gPiA+IENjOiBZb3No
aWhpcm8gU2hpbW9kYSA8eW9zaGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+DQo+ID4gPiA+
IFNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4N
Cj4gPiA+ID4gLS0tDQo+ID4gPiA+IHYyfnYzOiBubyBjaGFuZ2VzDQo+ID4gPiA+IC0tLQ0KPiA+
ID4gPiAgZHJpdmVycy91c2IvaG9zdC94aGNpLXJjYXIuYyB8IDQzICsrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBp
bnNlcnRpb25zKCspLCAzMSBkZWxldGlvbnMoLSkNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktcmNhci5jIGIvZHJpdmVycy91c2IvaG9zdC94aGNp
LXJjYXIuYw0KPiA+ID4gPiBpbmRleCBjMTAyNWQzLi43NGY4MzZmIDEwMDY0NA0KPiA+ID4gPiAt
LS0gYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktcmNhci5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMv
dXNiL2hvc3QveGhjaS1yY2FyLmMNCj4gPiA+ID4gQEAgLTYsNiArNiw3IEBADQo+ID4gPiA+ICAg
Ki8NCj4gPiA+ID4gIA0KPiA+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L2Zpcm13YXJlLmg+DQo+ID4g
PiA+ICsjaW5jbHVkZSA8bGludXgvaW9wb2xsLmg+DQo+ID4gPiA+ICAjaW5jbHVkZSA8bGludXgv
bW9kdWxlLmg+DQo+ID4gPiA+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+
ID4gPiA+ICAjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4gPiA+ID4gQEAgLTEyNyw4ICsxMjgsNyBA
QCBzdGF0aWMgaW50IHhoY2lfcmNhcl9kb3dubG9hZF9maXJtd2FyZShzdHJ1Y3QgdXNiX2hjZCAq
aGNkKQ0KPiA+ID4gPiAgCXZvaWQgX19pb21lbSAqcmVncyA9IGhjZC0+cmVnczsNCj4gPiA+ID4g
IAlzdHJ1Y3QgeGhjaV9wbGF0X3ByaXYgKnByaXYgPSBoY2RfdG9feGhjaV9wcml2KGhjZCk7DQo+
ID4gPiA+ICAJY29uc3Qgc3RydWN0IGZpcm13YXJlICpmdzsNCj4gPiA+ID4gLQlpbnQgcmV0dmFs
LCBpbmRleCwgaiwgdGltZTsNCj4gPiA+ID4gLQlpbnQgdGltZW91dCA9IDEwMDAwOw0KPiA+ID4g
PiArCWludCByZXR2YWwsIGluZGV4LCBqOw0KPiA+ID4gPiAgCXUzMiBkYXRhLCB2YWwsIHRlbXA7
DQo+ID4gPiA+ICAJdTMyIHF1aXJrcyA9IDA7DQo+ID4gPiA+ICAJY29uc3Qgc3RydWN0IHNvY19k
ZXZpY2VfYXR0cmlidXRlICphdHRyOw0KPiA+ID4gPiBAQCAtMTY2LDMyICsxNjYsMTkgQEAgc3Rh
dGljIGludCB4aGNpX3JjYXJfZG93bmxvYWRfZmlybXdhcmUoc3RydWN0IHVzYl9oY2QgKmhjZCkN
Cj4gPiA+ID4gIAkJdGVtcCB8PSBSQ0FSX1VTQjNfRExfQ1RSTF9GV19TRVRfREFUQTA7DQo+ID4g
PiA+ICAJCXdyaXRlbCh0ZW1wLCByZWdzICsgUkNBUl9VU0IzX0RMX0NUUkwpOw0KPiA+ID4gPiAg
DQo+ID4gPiA+IC0JCWZvciAodGltZSA9IDA7IHRpbWUgPCB0aW1lb3V0OyB0aW1lKyspIHsNCj4g
PiA+ID4gLQkJCXZhbCA9IHJlYWRsKHJlZ3MgKyBSQ0FSX1VTQjNfRExfQ1RSTCk7DQo+ID4gPiA+
IC0JCQlpZiAoKHZhbCAmIFJDQVJfVVNCM19ETF9DVFJMX0ZXX1NFVF9EQVRBMCkgPT0gMCkNCj4g
PiA+ID4gLQkJCQlicmVhazsNCj4gPiA+ID4gLQkJCXVkZWxheSgxKTsNCj4gPiA+ID4gLQkJfQ0K
PiA+ID4gPiAtCQlpZiAodGltZSA9PSB0aW1lb3V0KSB7DQo+ID4gPiA+IC0JCQlyZXR2YWwgPSAt
RVRJTUVET1VUOw0KPiA+ID4gPiArCQlyZXR2YWwgPSByZWFkbF9wb2xsX3RpbWVvdXRfYXRvbWlj
KHJlZ3MgKyBSQ0FSX1VTQjNfRExfQ1RSTCwNCj4gPiA+ID4gKwkJCQl2YWwsICEodmFsICYgUkNB
Ul9VU0IzX0RMX0NUUkxfRldfU0VUX0RBVEEwKSwNCj4gPiA+ID4gKwkJCQkxLCAxMDAwMCk7DQo+
ID4gPiA+ICsJCWlmIChyZXR2YWwgPCAwKQ0KPiA+ID4gPiAgCQkJYnJlYWs7DQo+ID4gPiA+IC0J
CX0NCj4gPiA+ID4gIAl9DQo+ID4gPiA+ICANCj4gPiA+ID4gIAl0ZW1wID0gcmVhZGwocmVncyAr
IFJDQVJfVVNCM19ETF9DVFJMKTsNCj4gPiA+ID4gIAl0ZW1wICY9IH5SQ0FSX1VTQjNfRExfQ1RS
TF9FTkFCTEU7DQo+ID4gPiA+ICAJd3JpdGVsKHRlbXAsIHJlZ3MgKyBSQ0FSX1VTQjNfRExfQ1RS
TCk7DQo+ID4gPiA+ICANCj4gPiA+ID4gLQlmb3IgKHRpbWUgPSAwOyB0aW1lIDwgdGltZW91dDsg
dGltZSsrKSB7DQo+ID4gPiA+IC0JCXZhbCA9IHJlYWRsKHJlZ3MgKyBSQ0FSX1VTQjNfRExfQ1RS
TCk7DQo+ID4gPiA+IC0JCWlmICh2YWwgJiBSQ0FSX1VTQjNfRExfQ1RSTF9GV19TVUNDRVNTKSB7
DQo+ID4gPiA+IC0JCQlyZXR2YWwgPSAwOw0KSGVyZSB3aWxsIHNldCBpdCAwIHRvbw0KDQo+ID4g
PiA+IC0JCQlicmVhazsNCj4gPiA+ID4gLQkJfQ0KPiA+ID4gPiAtCQl1ZGVsYXkoMSk7DQo+ID4g
PiA+IC0JfQ0KPiA+ID4gPiAtCWlmICh0aW1lID09IHRpbWVvdXQpDQo+ID4gPiA+IC0JCXJldHZh
bCA9IC1FVElNRURPVVQ7DQo+ID4gPiA+ICsJcmV0dmFsID0gcmVhZGxfcG9sbF90aW1lb3V0X2F0
b21pYygocmVncyArIFJDQVJfVVNCM19ETF9DVFJMKSwNCj4gPiA+ID4gKwkJCXZhbCwgKHZhbCAm
IFJDQVJfVVNCM19ETF9DVFJMX0ZXX1NVQ0NFU1MpLCAxLCAxMDAwMCk7DQo+ID4gPiANCj4gPiA+
IERpcmVjdGx5IGFzc2lnbmluZyB0byByZXR2YWwgYXQgdGhpcyBwb2ludCB3aWxsIGNsb2JiZXIg
YSBwcmV2aW91cw0KPiA+ID4gLUVUSU1FRE9VVCBlcnJvci4NCj4gPiA+IA0KPiA+ID4gSW4gb3Ro
ZXIgd29yZHMgaWYgdGhlcmUgaXMgYSB0aW1lb3V0IHdhaXRpbmcgZm9yIEZXX1NFVF9EQVRBMCwg
YnV0IG5vdCBmb3INCj4gPiA+IERXX1NVQ0NFU1MsIHRoZW4gd2Ugd2lsbCByZXR1cm4gdGhlIHdy
b25nIHJldHVybiB2YWx1ZS4NCj4gPg0KPiA+IFllcywgYWdyZWUgd2l0aCB5b3UsIGJ1dCBzZWVt
cyBJIGtlZXAgaXRzIG9yaWdpbmFsIGxvZ2ljIHVuY2hhbmdlZC4NCj4gDQo+IEkgZGlzYWdyZWUu
DQo+IA0KPiBZb3VyIHBhdGNoIGRvZXMgbm90IHByZXNlcnZlIHRoZSBvcmlnaW5hbCBsb2dpYy4g
WW91ciBwYXRjaCBleHBsaWNpdGx5DQo+IHNldHMgcmV0dmFsIHRvIHplcm8gaWYgdGhlIHNlY29u
ZCBsb29wIHN1Y2NlZWRzLiBUaGUgb3JpZ2luYWwgY29kZSBkb2VzDQo+IG5vdCBkbyB0aGlzLiBB
cyBhIHJlc3VsdCB0aGVyZSBpcyBhIGNoYW5nZSBvZiByZXR1cm4gY29kZSBmb3Igb25lIG9mIHRo
ZQ0KPiBlcnJvciBwYXRocy4NCj4gDQo+IA0KPiBEYW5pZWwuDQoNCg==

