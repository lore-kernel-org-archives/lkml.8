Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA52C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 02:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 637772078D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 02:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ibXdIM20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbgIKCf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 22:35:28 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:41913 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725300AbgIKCf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 22:35:26 -0400
X-UUID: c52ce2491d904385a2e9bf67c644ec12-20200911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=7MYSoZ5QxzUzH8hLs5rwGOWaWX5IAIFzofz6EFN77nw=;
        b=ibXdIM20AUuJL2p9ifojfLSaYFPXfaicGvwMuHr+bsVD8ndq8a4jlwQhlRpxhjD/ECPPdWT3k/hMMKALsXy9B+d/hFlMuX00mNFpQiLkZ8VvFuvuac8DX9XNA9PdbC67AIlBVlbzkPBjCV9dUmfyf1P+Zze7XMOrM15/EYHlRm8=;
X-UUID: c52ce2491d904385a2e9bf67c644ec12-20200911
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 51367424; Fri, 11 Sep 2020 10:35:19 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 11 Sep
 2020 10:35:16 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Sep 2020 10:35:13 +0800
Message-ID: <1599791601.24609.5.camel@mhfsdcap03>
Subject: Re: [PATCH RESEND v3 04/11] usb: xhci-rcar: convert to
 readl_poll_timeout_atomic()
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Jason Yan <yanaijie@huawei.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date:   Fri, 11 Sep 2020 10:33:21 +0800
In-Reply-To: <20200910131212.wm7zskxvcesl652c@holly.lan>
References: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
         <1599726112-4439-4-git-send-email-chunfeng.yun@mediatek.com>
         <20200910131212.wm7zskxvcesl652c@holly.lan>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 0656D636ED552509600E962FFCC7659B588E3C6D24BA40A07694E3B2815115EF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA5LTEwIGF0IDE0OjEyICswMTAwLCBEYW5pZWwgVGhvbXBzb24gd3JvdGU6
DQo+IE9uIFRodSwgU2VwIDEwLCAyMDIwIGF0IDA0OjIxOjQ1UE0gKzA4MDAsIENodW5mZW5nIFl1
biB3cm90ZToNCj4gPiBVc2UgcmVhZGxfcG9sbF90aW1lb3V0X2F0b21pYygpIHRvIHNpbXBsaWZ5
IGNvZGUNCj4gPiANCj4gPiBDYzogTWF0aGlhcyBOeW1hbiA8bWF0aGlhcy5ueW1hbkBsaW51eC5p
bnRlbC5jb20+DQo+ID4gQ2M6IFlvc2hpaGlybyBTaGltb2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51
aEByZW5lc2FzLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5n
Lnl1bkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gdjJ+djM6IG5vIGNoYW5nZXMNCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy91c2IvaG9zdC94aGNpLXJjYXIuYyB8IDQzICsrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGlu
c2VydGlvbnMoKyksIDMxIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3VzYi9ob3N0L3hoY2ktcmNhci5jIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLXJjYXIuYw0K
PiA+IGluZGV4IGMxMDI1ZDMuLjc0ZjgzNmYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91c2Iv
aG9zdC94aGNpLXJjYXIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1yY2FyLmMN
Cj4gPiBAQCAtNiw2ICs2LDcgQEANCj4gPiAgICovDQo+ID4gIA0KPiA+ICAjaW5jbHVkZSA8bGlu
dXgvZmlybXdhcmUuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2lvcG9sbC5oPg0KPiA+ICAjaW5j
bHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZp
Y2UuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ID4gQEAgLTEyNyw4ICsxMjgsNyBA
QCBzdGF0aWMgaW50IHhoY2lfcmNhcl9kb3dubG9hZF9maXJtd2FyZShzdHJ1Y3QgdXNiX2hjZCAq
aGNkKQ0KPiA+ICAJdm9pZCBfX2lvbWVtICpyZWdzID0gaGNkLT5yZWdzOw0KPiA+ICAJc3RydWN0
IHhoY2lfcGxhdF9wcml2ICpwcml2ID0gaGNkX3RvX3hoY2lfcHJpdihoY2QpOw0KPiA+ICAJY29u
c3Qgc3RydWN0IGZpcm13YXJlICpmdzsNCj4gPiAtCWludCByZXR2YWwsIGluZGV4LCBqLCB0aW1l
Ow0KPiA+IC0JaW50IHRpbWVvdXQgPSAxMDAwMDsNCj4gPiArCWludCByZXR2YWwsIGluZGV4LCBq
Ow0KPiA+ICAJdTMyIGRhdGEsIHZhbCwgdGVtcDsNCj4gPiAgCXUzMiBxdWlya3MgPSAwOw0KPiA+
ICAJY29uc3Qgc3RydWN0IHNvY19kZXZpY2VfYXR0cmlidXRlICphdHRyOw0KPiA+IEBAIC0xNjYs
MzIgKzE2NiwxOSBAQCBzdGF0aWMgaW50IHhoY2lfcmNhcl9kb3dubG9hZF9maXJtd2FyZShzdHJ1
Y3QgdXNiX2hjZCAqaGNkKQ0KPiA+ICAJCXRlbXAgfD0gUkNBUl9VU0IzX0RMX0NUUkxfRldfU0VU
X0RBVEEwOw0KPiA+ICAJCXdyaXRlbCh0ZW1wLCByZWdzICsgUkNBUl9VU0IzX0RMX0NUUkwpOw0K
PiA+ICANCj4gPiAtCQlmb3IgKHRpbWUgPSAwOyB0aW1lIDwgdGltZW91dDsgdGltZSsrKSB7DQo+
ID4gLQkJCXZhbCA9IHJlYWRsKHJlZ3MgKyBSQ0FSX1VTQjNfRExfQ1RSTCk7DQo+ID4gLQkJCWlm
ICgodmFsICYgUkNBUl9VU0IzX0RMX0NUUkxfRldfU0VUX0RBVEEwKSA9PSAwKQ0KPiA+IC0JCQkJ
YnJlYWs7DQo+ID4gLQkJCXVkZWxheSgxKTsNCj4gPiAtCQl9DQo+ID4gLQkJaWYgKHRpbWUgPT0g
dGltZW91dCkgew0KPiA+IC0JCQlyZXR2YWwgPSAtRVRJTUVET1VUOw0KPiA+ICsJCXJldHZhbCA9
IHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMocmVncyArIFJDQVJfVVNCM19ETF9DVFJMLA0KPiA+
ICsJCQkJdmFsLCAhKHZhbCAmIFJDQVJfVVNCM19ETF9DVFJMX0ZXX1NFVF9EQVRBMCksDQo+ID4g
KwkJCQkxLCAxMDAwMCk7DQo+ID4gKwkJaWYgKHJldHZhbCA8IDApDQo+ID4gIAkJCWJyZWFrOw0K
PiA+IC0JCX0NCj4gPiAgCX0NCj4gPiAgDQo+ID4gIAl0ZW1wID0gcmVhZGwocmVncyArIFJDQVJf
VVNCM19ETF9DVFJMKTsNCj4gPiAgCXRlbXAgJj0gflJDQVJfVVNCM19ETF9DVFJMX0VOQUJMRTsN
Cj4gPiAgCXdyaXRlbCh0ZW1wLCByZWdzICsgUkNBUl9VU0IzX0RMX0NUUkwpOw0KPiA+ICANCj4g
PiAtCWZvciAodGltZSA9IDA7IHRpbWUgPCB0aW1lb3V0OyB0aW1lKyspIHsNCj4gPiAtCQl2YWwg
PSByZWFkbChyZWdzICsgUkNBUl9VU0IzX0RMX0NUUkwpOw0KPiA+IC0JCWlmICh2YWwgJiBSQ0FS
X1VTQjNfRExfQ1RSTF9GV19TVUNDRVNTKSB7DQo+ID4gLQkJCXJldHZhbCA9IDA7DQo+ID4gLQkJ
CWJyZWFrOw0KPiA+IC0JCX0NCj4gPiAtCQl1ZGVsYXkoMSk7DQo+ID4gLQl9DQo+ID4gLQlpZiAo
dGltZSA9PSB0aW1lb3V0KQ0KPiA+IC0JCXJldHZhbCA9IC1FVElNRURPVVQ7DQo+ID4gKwlyZXR2
YWwgPSByZWFkbF9wb2xsX3RpbWVvdXRfYXRvbWljKChyZWdzICsgUkNBUl9VU0IzX0RMX0NUUkwp
LA0KPiA+ICsJCQl2YWwsICh2YWwgJiBSQ0FSX1VTQjNfRExfQ1RSTF9GV19TVUNDRVNTKSwgMSwg
MTAwMDApOw0KPiANCj4gRGlyZWN0bHkgYXNzaWduaW5nIHRvIHJldHZhbCBhdCB0aGlzIHBvaW50
IHdpbGwgY2xvYmJlciBhIHByZXZpb3VzDQo+IC1FVElNRURPVVQgZXJyb3IuDQo+IA0KPiBJbiBv
dGhlciB3b3JkcyBpZiB0aGVyZSBpcyBhIHRpbWVvdXQgd2FpdGluZyBmb3IgRldfU0VUX0RBVEEw
LCBidXQgbm90IGZvcg0KPiBEV19TVUNDRVNTLCB0aGVuIHdlIHdpbGwgcmV0dXJuIHRoZSB3cm9u
ZyByZXR1cm4gdmFsdWUuDQpZZXMsIGFncmVlIHdpdGggeW91LCBidXQgc2VlbXMgSSBrZWVwIGl0
cyBvcmlnaW5hbCBsb2dpYyB1bmNoYW5nZWQuDQoNCkhpIFlvc2hpaGlybywNCg0KICBXaGF0IGRv
IHRoaW5rIGFib3V0IERhbmllbCdzIHN1Z2dlc3Rpb24/IHNob3VsZCBJIGZpeCBpdCB1cD8NCg0K
PiANCj4gDQo+IERhbmllbC4NCj4gDQo+IA0KPiA+ICANCj4gPiAgCXJlbGVhc2VfZmlybXdhcmUo
ZncpOw0KPiA+ICANCj4gPiBAQCAtMjAwLDE4ICsxODcsMTIgQEAgc3RhdGljIGludCB4aGNpX3Jj
YXJfZG93bmxvYWRfZmlybXdhcmUoc3RydWN0IHVzYl9oY2QgKmhjZCkNCj4gPiAgDQo+ID4gIHN0
YXRpYyBib29sIHhoY2lfcmNhcl93YWl0X2Zvcl9wbGxfYWN0aXZlKHN0cnVjdCB1c2JfaGNkICpo
Y2QpDQo+ID4gIHsNCj4gPiAtCWludCB0aW1lb3V0ID0gMTAwMDsNCj4gPiArCWludCByZXR2YWw7
DQo+ID4gIAl1MzIgdmFsLCBtYXNrID0gUkNBUl9VU0IzX0FYSF9TVEFfUExMX0FDVElWRV9NQVNL
Ow0KPiA+ICANCj4gPiAtCXdoaWxlICh0aW1lb3V0ID4gMCkgew0KPiA+IC0JCXZhbCA9IHJlYWRs
KGhjZC0+cmVncyArIFJDQVJfVVNCM19BWEhfU1RBKTsNCj4gPiAtCQlpZiAoKHZhbCAmIG1hc2sp
ID09IG1hc2spDQo+ID4gLQkJCXJldHVybiB0cnVlOw0KPiA+IC0JCXVkZWxheSgxKTsNCj4gPiAt
CQl0aW1lb3V0LS07DQo+ID4gLQl9DQo+ID4gLQ0KPiA+IC0JcmV0dXJuIGZhbHNlOw0KPiA+ICsJ
cmV0dmFsID0gcmVhZGxfcG9sbF90aW1lb3V0X2F0b21pYyhoY2QtPnJlZ3MgKyBSQ0FSX1VTQjNf
QVhIX1NUQSwNCj4gPiArCQkJdmFsLCAoKHZhbCAmIG1hc2spID09IG1hc2spLCAxLCAxMDAwKTsN
Cj4gPiArCXJldHVybiAhIXJldHZhbDsNCj4gDQo+IFRoaXMgZnVuY3Rpb24gcmV0dXJucyBhIGJv
b2wgc28gISEgaXMgZWl0aGVyIHdyb25nIG9yIHJlZHVuZGFudC4uLiBJDQo+IHRoaW5rIGluIHRo
aXMgY2FzZSBpdCBpcyB3cm9uZyBhbmQgc2hvdWxkIGJlIGEgc2luZ2xlICEgLg0KWWVzLCB3aWxs
IGZpeCBpdA0KDQpUaGFua3MgYSBsb3QNCj4gDQo+IA0KPiBEYW5pZWwuDQoNCg==

