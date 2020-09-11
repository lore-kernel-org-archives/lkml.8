Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982A9C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 02:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B002074B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 02:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ifxPbdLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgIKCXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 22:23:30 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:52219 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725306AbgIKCX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 22:23:26 -0400
X-UUID: 9fdb824f6e5441d7877e2223230e97a6-20200911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=PwCD43rd691vuKeYiP0pJUixc3+a3XIXXvJJKbF9gm4=;
        b=ifxPbdLl1SVMJJaoX1SotthH28/Ax2A21ouPXsKAw7LnBdTF1YQcJgartXsVw+VUoISMAfmnm6sOt19hjzpH+k5Iu0a75P9y45JIpwnZPGhbByqE27/ZUFybazbWzvZNKmH37QtNDhFFb1LvPuvzcKNMWuEJSBB5eIvujKco3FA=;
X-UUID: 9fdb824f6e5441d7877e2223230e97a6-20200911
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 980902723; Fri, 11 Sep 2020 10:23:12 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 11 Sep
 2020 10:23:09 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Sep 2020 10:23:09 +0800
Message-ID: <1599790874.24085.4.camel@mhfsdcap03>
Subject: Re: [PATCH RESEND v3 04/11] usb: xhci-rcar: convert to
 readl_poll_timeout_atomic()
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Jason Yan <yanaijie@huawei.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Ben Dooks" <ben.dooks@codethink.co.uk>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Date:   Fri, 11 Sep 2020 10:21:14 +0800
In-Reply-To: <TY2PR01MB369214103C701DC5E78D56F9D8270@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
         <1599726112-4439-4-git-send-email-chunfeng.yun@mediatek.com>
         <TY2PR01MB369214103C701DC5E78D56F9D8270@TY2PR01MB3692.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: E726212FDA9BF31E90C2592A545596892CFBE2F964F285D5C4390154E2FF3CEF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA5LTEwIGF0IDEyOjU2ICswMDAwLCBZb3NoaWhpcm8gU2hpbW9kYSB3cm90
ZToNCj4gSGkgQ2h1bmZlbmcsDQo+IA0KPiBUaGFuayB5b3UgZm9yIHRoZSBwYXRjaCENCj4gDQo+
ID4gRnJvbTogQ2h1bmZlbmcgWXVuLCBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDEwLCAyMDIw
IDU6MjIgUE0NCj4gPiANCj4gPiBVc2UgcmVhZGxfcG9sbF90aW1lb3V0X2F0b21pYygpIHRvIHNp
bXBsaWZ5IGNvZGUNCj4gPiANCj4gPiBDYzogTWF0aGlhcyBOeW1hbiA8bWF0aGlhcy5ueW1hbkBs
aW51eC5pbnRlbC5jb20+DQo+ID4gQ2M6IFlvc2hpaGlybyBTaGltb2RhIDx5b3NoaWhpcm8uc2hp
bW9kYS51aEByZW5lc2FzLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNo
dW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gdjJ+djM6IG5vIGNoYW5nZXMN
Cj4gPiAtLS0NCj4gPiAgZHJpdmVycy91c2IvaG9zdC94aGNpLXJjYXIuYyB8IDQzICsrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDEyIGluc2VydGlvbnMoKyksIDMxIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktcmNhci5jIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLXJj
YXIuYw0KPiA+IGluZGV4IGMxMDI1ZDMuLjc0ZjgzNmYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy91c2IvaG9zdC94aGNpLXJjYXIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1y
Y2FyLmMNCj4gPiBAQCAtNiw2ICs2LDcgQEANCj4gPiAgICovDQo+ID4gDQo+ID4gICNpbmNsdWRl
IDxsaW51eC9maXJtd2FyZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvaW9wb2xsLmg+DQo+ID4g
ICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3Jt
X2RldmljZS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4gPiBAQCAtMTI3LDggKzEy
OCw3IEBAIHN0YXRpYyBpbnQgeGhjaV9yY2FyX2Rvd25sb2FkX2Zpcm13YXJlKHN0cnVjdCB1c2Jf
aGNkICpoY2QpDQo+ID4gIAl2b2lkIF9faW9tZW0gKnJlZ3MgPSBoY2QtPnJlZ3M7DQo+ID4gIAlz
dHJ1Y3QgeGhjaV9wbGF0X3ByaXYgKnByaXYgPSBoY2RfdG9feGhjaV9wcml2KGhjZCk7DQo+ID4g
IAljb25zdCBzdHJ1Y3QgZmlybXdhcmUgKmZ3Ow0KPiA+IC0JaW50IHJldHZhbCwgaW5kZXgsIGos
IHRpbWU7DQo+ID4gLQlpbnQgdGltZW91dCA9IDEwMDAwOw0KPiA+ICsJaW50IHJldHZhbCwgaW5k
ZXgsIGo7DQo+ID4gIAl1MzIgZGF0YSwgdmFsLCB0ZW1wOw0KPiA+ICAJdTMyIHF1aXJrcyA9IDA7
DQo+ID4gIAljb25zdCBzdHJ1Y3Qgc29jX2RldmljZV9hdHRyaWJ1dGUgKmF0dHI7DQo+ID4gQEAg
LTE2NiwzMiArMTY2LDE5IEBAIHN0YXRpYyBpbnQgeGhjaV9yY2FyX2Rvd25sb2FkX2Zpcm13YXJl
KHN0cnVjdCB1c2JfaGNkICpoY2QpDQo+ID4gIAkJdGVtcCB8PSBSQ0FSX1VTQjNfRExfQ1RSTF9G
V19TRVRfREFUQTA7DQo+ID4gIAkJd3JpdGVsKHRlbXAsIHJlZ3MgKyBSQ0FSX1VTQjNfRExfQ1RS
TCk7DQo+ID4gDQo+ID4gLQkJZm9yICh0aW1lID0gMDsgdGltZSA8IHRpbWVvdXQ7IHRpbWUrKykg
ew0KPiA+IC0JCQl2YWwgPSByZWFkbChyZWdzICsgUkNBUl9VU0IzX0RMX0NUUkwpOw0KPiA+IC0J
CQlpZiAoKHZhbCAmIFJDQVJfVVNCM19ETF9DVFJMX0ZXX1NFVF9EQVRBMCkgPT0gMCkNCj4gPiAt
CQkJCWJyZWFrOw0KPiA+IC0JCQl1ZGVsYXkoMSk7DQo+ID4gLQkJfQ0KPiA+IC0JCWlmICh0aW1l
ID09IHRpbWVvdXQpIHsNCj4gPiAtCQkJcmV0dmFsID0gLUVUSU1FRE9VVDsNCj4gPiArCQlyZXR2
YWwgPSByZWFkbF9wb2xsX3RpbWVvdXRfYXRvbWljKHJlZ3MgKyBSQ0FSX1VTQjNfRExfQ1RSTCwN
Cj4gPiArCQkJCXZhbCwgISh2YWwgJiBSQ0FSX1VTQjNfRExfQ1RSTF9GV19TRVRfREFUQTApLA0K
PiA+ICsJCQkJMSwgMTAwMDApOw0KPiA+ICsJCWlmIChyZXR2YWwgPCAwKQ0KPiA+ICAJCQlicmVh
azsNCj4gPiAtCQl9DQo+ID4gIAl9DQo+ID4gDQo+ID4gIAl0ZW1wID0gcmVhZGwocmVncyArIFJD
QVJfVVNCM19ETF9DVFJMKTsNCj4gPiAgCXRlbXAgJj0gflJDQVJfVVNCM19ETF9DVFJMX0VOQUJM
RTsNCj4gPiAgCXdyaXRlbCh0ZW1wLCByZWdzICsgUkNBUl9VU0IzX0RMX0NUUkwpOw0KPiA+IA0K
PiA+IC0JZm9yICh0aW1lID0gMDsgdGltZSA8IHRpbWVvdXQ7IHRpbWUrKykgew0KPiA+IC0JCXZh
bCA9IHJlYWRsKHJlZ3MgKyBSQ0FSX1VTQjNfRExfQ1RSTCk7DQo+ID4gLQkJaWYgKHZhbCAmIFJD
QVJfVVNCM19ETF9DVFJMX0ZXX1NVQ0NFU1MpIHsNCj4gPiAtCQkJcmV0dmFsID0gMDsNCj4gPiAt
CQkJYnJlYWs7DQo+ID4gLQkJfQ0KPiA+IC0JCXVkZWxheSgxKTsNCj4gPiAtCX0NCj4gPiAtCWlm
ICh0aW1lID09IHRpbWVvdXQpDQo+ID4gLQkJcmV0dmFsID0gLUVUSU1FRE9VVDsNCj4gPiArCXJl
dHZhbCA9IHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKHJlZ3MgKyBSQ0FSX1VTQjNfRExfQ1RS
TCksDQo+ID4gKwkJCXZhbCwgKHZhbCAmIFJDQVJfVVNCM19ETF9DVFJMX0ZXX1NVQ0NFU1MpLCAx
LCAxMDAwMCk7DQo+IA0KPiBTb21lIHBhcmVudGhlc2VzIGFyZSBub3QgbmVlZGVkIGxpa2UgYmVs
b3c6DQo+IA0KPiAJcmV0dmFsID0gcmVhZGxfcG9sbF90aW1lb3V0X2F0b21pYyhyZWdzICsgUkNB
Ul9VU0IzX0RMX0NUUkwsDQo+IAkJCXZhbCwgdmFsICYgUkNBUl9VU0IzX0RMX0NUUkxfRldfU1VD
Q0VTUywgMSwgMTAwMDApOw0KPiANCk9rLCB3aWxsIG1vZGlmeSBpdA0KDQo+IA0KPiA+ICAJcmVs
ZWFzZV9maXJtd2FyZShmdyk7DQo+ID4gDQo+ID4gQEAgLTIwMCwxOCArMTg3LDEyIEBAIHN0YXRp
YyBpbnQgeGhjaV9yY2FyX2Rvd25sb2FkX2Zpcm13YXJlKHN0cnVjdCB1c2JfaGNkICpoY2QpDQo+
ID4gDQo+ID4gIHN0YXRpYyBib29sIHhoY2lfcmNhcl93YWl0X2Zvcl9wbGxfYWN0aXZlKHN0cnVj
dCB1c2JfaGNkICpoY2QpDQo+ID4gIHsNCj4gPiAtCWludCB0aW1lb3V0ID0gMTAwMDsNCj4gPiAr
CWludCByZXR2YWw7DQo+ID4gIAl1MzIgdmFsLCBtYXNrID0gUkNBUl9VU0IzX0FYSF9TVEFfUExM
X0FDVElWRV9NQVNLOw0KPiA+IA0KPiA+IC0Jd2hpbGUgKHRpbWVvdXQgPiAwKSB7DQo+ID4gLQkJ
dmFsID0gcmVhZGwoaGNkLT5yZWdzICsgUkNBUl9VU0IzX0FYSF9TVEEpOw0KPiA+IC0JCWlmICgo
dmFsICYgbWFzaykgPT0gbWFzaykNCj4gPiAtCQkJcmV0dXJuIHRydWU7DQo+ID4gLQkJdWRlbGF5
KDEpOw0KPiA+IC0JCXRpbWVvdXQtLTsNCj4gPiAtCX0NCj4gPiAtDQo+ID4gLQlyZXR1cm4gZmFs
c2U7DQo+ID4gKwlyZXR2YWwgPSByZWFkbF9wb2xsX3RpbWVvdXRfYXRvbWljKGhjZC0+cmVncyAr
IFJDQVJfVVNCM19BWEhfU1RBLA0KPiA+ICsJCQl2YWwsICgodmFsICYgbWFzaykgPT0gbWFzayks
IDEsIDEwMDApOw0KPiANCj4gTGlrZXdpc2UgYWJvdmU6DQo+IAlyZXR2YWwgPSByZWFkbF9wb2xs
X3RpbWVvdXRfYXRvbWljKGhjZC0+cmVncyArIFJDQVJfVVNCM19BWEhfU1RBLA0KPiAJCQl2YWws
ICh2YWwgJiBtYXNrKSA9PSBtYXNrLCAxLCAxMDAwKTsNCj4gDQo+ID4gKwlyZXR1cm4gISFyZXR2
YWw7DQo+IA0KPiBUaGlzIGJyZWFrcyB0aGUgY29kZS4gSWYgSSBjaGFuZ2VkIHRoaXMgdG8gInJl
dHVybiByZXR2YWwgPCAwID8gZmFsc2UgOiB0cnVlOyIsDQo+IGl0IHdvcmtzIGFnYWluLg0KT29w
cywgbXkgYmFkLCB3aWxsIGZpeCBpdA0KDQpUaGFua3MgYSBsb3QNCg0KPiANCj4gQmVzdCByZWdh
cmRzLA0KPiBZb3NoaWhpcm8gU2hpbW9kYQ0KPiANCg0K

