Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6D5C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 04:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7FCD206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 04:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="M+bUlxzf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbgIKEP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 00:15:29 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:52503 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725283AbgIKEP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 00:15:28 -0400
X-UUID: 6eb9bf8afc2c4b4099bbb2c51450e210-20200911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=S8V5Akl7eiGW/k+oP2VPh5gqJCICXAtbHzsKCE8cyBY=;
        b=M+bUlxzfH0khcXVKgizt0+HQ0SOHVBO4vIRgS4tiaQYUxXo+4U6D0Iqr5U39e9CZsKr94sBCxMBV2n4rvCbqK91Pc6hltjAY1/o6WUZGlkDkpewkG4ZepFk84GRNnFMcp7y7LaB/Hwpt5sInc66AeHmZumt+OjusTdJ91ijckz8=;
X-UUID: 6eb9bf8afc2c4b4099bbb2c51450e210-20200911
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1742903327; Fri, 11 Sep 2020 12:14:50 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 11 Sep
 2020 12:14:47 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Sep 2020 12:14:48 +0800
Message-ID: <1599797572.24609.8.camel@mhfsdcap03>
Subject: Re: [PATCH RESEND v3 04/11] usb: xhci-rcar: convert to
 readl_poll_timeout_atomic()
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
CC:     Daniel Thompson <daniel.thompson@linaro.org>,
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
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Date:   Fri, 11 Sep 2020 12:12:52 +0800
In-Reply-To: <OSAPR01MB3683CA015AB25BC00D8459EBD8240@OSAPR01MB3683.jpnprd01.prod.outlook.com>
References: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
         <1599726112-4439-4-git-send-email-chunfeng.yun@mediatek.com>
         <20200910131212.wm7zskxvcesl652c@holly.lan>
         <1599791601.24609.5.camel@mhfsdcap03>
         <OSAPR01MB3683CA015AB25BC00D8459EBD8240@OSAPR01MB3683.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 4BBBF29723D19EFB7DEBE93A32BA78B9759C1FC910FE727AC46D1BE3BA4A1A0F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTA5LTExIGF0IDAzOjEzICswMDAwLCBZb3NoaWhpcm8gU2hpbW9kYSB3cm90
ZToNCj4gSGkgRGFuaWVsLCBDaHVuZmVuZywNCj4gDQo+ID4gRnJvbTogQ2h1bmZlbmcgWXVuLCBT
ZW50OiBGcmlkYXksIFNlcHRlbWJlciAxMSwgMjAyMCAxMTozMyBBTQ0KPiA+IA0KPiA+IE9uIFRo
dSwgMjAyMC0wOS0xMCBhdCAxNDoxMiArMDEwMCwgRGFuaWVsIFRob21wc29uIHdyb3RlOg0KPiA+
ID4gT24gVGh1LCBTZXAgMTAsIDIwMjAgYXQgMDQ6MjE6NDVQTSArMDgwMCwgQ2h1bmZlbmcgWXVu
IHdyb3RlOg0KPiA+ID4gPiBVc2UgcmVhZGxfcG9sbF90aW1lb3V0X2F0b21pYygpIHRvIHNpbXBs
aWZ5IGNvZGUNCj4gPiA+ID4NCj4gPiA+ID4gQ2M6IE1hdGhpYXMgTnltYW4gPG1hdGhpYXMubnlt
YW5AbGludXguaW50ZWwuY29tPg0KPiA+ID4gPiBDYzogWW9zaGloaXJvIFNoaW1vZGEgPHlvc2hp
aGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29tPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVu
ZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4g
PiB2Mn52Mzogbm8gY2hhbmdlcw0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMvdXNiL2hv
c3QveGhjaS1yY2FyLmMgfCA0MyArKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMzEgZGVs
ZXRpb25zKC0pDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0
L3hoY2ktcmNhci5jIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLXJjYXIuYw0KPiA+ID4gPiBpbmRl
eCBjMTAyNWQzLi43NGY4MzZmIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3VzYi9ob3N0
L3hoY2ktcmNhci5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1yY2FyLmMN
Cj4gPiA+ID4gQEAgLTYsNiArNiw3IEBADQo+ID4gPiA+ICAgKi8NCj4gPiA+ID4NCj4gPiA+ID4g
ICNpbmNsdWRlIDxsaW51eC9maXJtd2FyZS5oPg0KPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L2lv
cG9sbC5oPg0KPiA+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ID4gPiAgI2lu
Y2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiA+ID4gPiAgI2luY2x1ZGUgPGxpbnV4
L29mLmg+DQo+ID4gPiA+IEBAIC0xMjcsOCArMTI4LDcgQEAgc3RhdGljIGludCB4aGNpX3JjYXJf
ZG93bmxvYWRfZmlybXdhcmUoc3RydWN0IHVzYl9oY2QgKmhjZCkNCj4gPiA+ID4gIAl2b2lkIF9f
aW9tZW0gKnJlZ3MgPSBoY2QtPnJlZ3M7DQo+ID4gPiA+ICAJc3RydWN0IHhoY2lfcGxhdF9wcml2
ICpwcml2ID0gaGNkX3RvX3hoY2lfcHJpdihoY2QpOw0KPiA+ID4gPiAgCWNvbnN0IHN0cnVjdCBm
aXJtd2FyZSAqZnc7DQo+ID4gPiA+IC0JaW50IHJldHZhbCwgaW5kZXgsIGosIHRpbWU7DQo+ID4g
PiA+IC0JaW50IHRpbWVvdXQgPSAxMDAwMDsNCj4gPiA+ID4gKwlpbnQgcmV0dmFsLCBpbmRleCwg
ajsNCj4gPiA+ID4gIAl1MzIgZGF0YSwgdmFsLCB0ZW1wOw0KPiA+ID4gPiAgCXUzMiBxdWlya3Mg
PSAwOw0KPiA+ID4gPiAgCWNvbnN0IHN0cnVjdCBzb2NfZGV2aWNlX2F0dHJpYnV0ZSAqYXR0cjsN
Cj4gPiA+ID4gQEAgLTE2NiwzMiArMTY2LDE5IEBAIHN0YXRpYyBpbnQgeGhjaV9yY2FyX2Rvd25s
b2FkX2Zpcm13YXJlKHN0cnVjdCB1c2JfaGNkICpoY2QpDQo+ID4gPiA+ICAJCXRlbXAgfD0gUkNB
Ul9VU0IzX0RMX0NUUkxfRldfU0VUX0RBVEEwOw0KPiA+ID4gPiAgCQl3cml0ZWwodGVtcCwgcmVn
cyArIFJDQVJfVVNCM19ETF9DVFJMKTsNCj4gPiA+ID4NCj4gPiA+ID4gLQkJZm9yICh0aW1lID0g
MDsgdGltZSA8IHRpbWVvdXQ7IHRpbWUrKykgew0KPiA+ID4gPiAtCQkJdmFsID0gcmVhZGwocmVn
cyArIFJDQVJfVVNCM19ETF9DVFJMKTsNCj4gPiA+ID4gLQkJCWlmICgodmFsICYgUkNBUl9VU0Iz
X0RMX0NUUkxfRldfU0VUX0RBVEEwKSA9PSAwKQ0KPiA+ID4gPiAtCQkJCWJyZWFrOw0KPiA+ID4g
PiAtCQkJdWRlbGF5KDEpOw0KPiA+ID4gPiAtCQl9DQo+ID4gPiA+IC0JCWlmICh0aW1lID09IHRp
bWVvdXQpIHsNCj4gPiA+ID4gLQkJCXJldHZhbCA9IC1FVElNRURPVVQ7DQo+ID4gPiA+ICsJCXJl
dHZhbCA9IHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMocmVncyArIFJDQVJfVVNCM19ETF9DVFJM
LA0KPiA+ID4gPiArCQkJCXZhbCwgISh2YWwgJiBSQ0FSX1VTQjNfRExfQ1RSTF9GV19TRVRfREFU
QTApLA0KPiA+ID4gPiArCQkJCTEsIDEwMDAwKTsNCj4gPiA+ID4gKwkJaWYgKHJldHZhbCA8IDAp
DQpIb3cgYWJvdXQgZnJlZSBmaXJtd2FyZSBhbmQgcmV0dXJuIGVycm9yIG51bWJlciBoZXJlID8g
aW5zdGVhZCBvZiBicmVhaw0KDQo+ID4gPiA+ICAJCQlicmVhazsNCj4gPiA+ID4gLQkJfQ0KPiA+
ID4gPiAgCX0NCj4gPiA+ID4NCj4gPiA+ID4gIAl0ZW1wID0gcmVhZGwocmVncyArIFJDQVJfVVNC
M19ETF9DVFJMKTsNCj4gPiA+ID4gIAl0ZW1wICY9IH5SQ0FSX1VTQjNfRExfQ1RSTF9FTkFCTEU7
DQo+ID4gPiA+ICAJd3JpdGVsKHRlbXAsIHJlZ3MgKyBSQ0FSX1VTQjNfRExfQ1RSTCk7DQo+ID4g
PiA+DQo+ID4gPiA+IC0JZm9yICh0aW1lID0gMDsgdGltZSA8IHRpbWVvdXQ7IHRpbWUrKykgew0K
PiA+ID4gPiAtCQl2YWwgPSByZWFkbChyZWdzICsgUkNBUl9VU0IzX0RMX0NUUkwpOw0KPiA+ID4g
PiAtCQlpZiAodmFsICYgUkNBUl9VU0IzX0RMX0NUUkxfRldfU1VDQ0VTUykgew0KPiA+ID4gPiAt
CQkJcmV0dmFsID0gMDsNCj4gPiA+ID4gLQkJCWJyZWFrOw0KPiA+ID4gPiAtCQl9DQo+ID4gPiA+
IC0JCXVkZWxheSgxKTsNCj4gPiA+ID4gLQl9DQo+ID4gPiA+IC0JaWYgKHRpbWUgPT0gdGltZW91
dCkNCj4gPiA+ID4gLQkJcmV0dmFsID0gLUVUSU1FRE9VVDsNCj4gPiA+ID4gKwlyZXR2YWwgPSBy
ZWFkbF9wb2xsX3RpbWVvdXRfYXRvbWljKChyZWdzICsgUkNBUl9VU0IzX0RMX0NUUkwpLA0KPiA+
ID4gPiArCQkJdmFsLCAodmFsICYgUkNBUl9VU0IzX0RMX0NUUkxfRldfU1VDQ0VTUyksIDEsIDEw
MDAwKTsNCj4gPiA+DQo+ID4gPiBEaXJlY3RseSBhc3NpZ25pbmcgdG8gcmV0dmFsIGF0IHRoaXMg
cG9pbnQgd2lsbCBjbG9iYmVyIGEgcHJldmlvdXMNCj4gPiA+IC1FVElNRURPVVQgZXJyb3IuDQo+
ID4gPg0KPiA+ID4gSW4gb3RoZXIgd29yZHMgaWYgdGhlcmUgaXMgYSB0aW1lb3V0IHdhaXRpbmcg
Zm9yIEZXX1NFVF9EQVRBMCwgYnV0IG5vdCBmb3INCj4gPiA+IERXX1NVQ0NFU1MsIHRoZW4gd2Ug
d2lsbCByZXR1cm4gdGhlIHdyb25nIHJldHVybiB2YWx1ZS4NCj4gDQo+IFRoYW5rIHlvdSBmb3Ig
eW91ciBjb21tZW50ISBJIGRpZG4ndCByZWFsaXplZCB0aGlzLg0KPiANCj4gPiBZZXMsIGFncmVl
IHdpdGggeW91LCBidXQgc2VlbXMgSSBrZWVwIGl0cyBvcmlnaW5hbCBsb2dpYyB1bmNoYW5nZWQu
DQo+ID4gSGkgWW9zaGloaXJvLA0KPiA+IA0KPiA+ICAgV2hhdCBkbyB0aGluayBhYm91dCBEYW5p
ZWwncyBzdWdnZXN0aW9uPyBzaG91bGQgSSBmaXggaXQgdXA/DQo+IA0KPiBJIHRoaW5rIHlvdSBz
aG91bGQgZml4IGl0IHVwIGxpa2UgYmVsb3c6DQo+IA0KPiBpZiAocmVhZGxfcG9sbF90aW1lb3V0
X2F0b21pYyhyZWdzICsgUkNBUl9VU0IzX0RMX0NUUkwsDQo+IAkJdmFsLCB2YWwgJiBSQ0FSX1VT
QjNfRExfQ1RSTF9GV19TVUNDRVNTLCAxLCAxMDAwMCkgPCAwKQ0KPiAJcmV0dmFsID0gLUVUSU1F
T1VUOwkvKiBPdmVyd3JpdGUgcmV0dmFsIGlmIHRpbWVvdXQgb2NjdXJyZWQgKi8NCg0KcmVhZGxf
cG9sbF90aW1lb3V0X2F0b21pYygpIG9ubHkgcmV0dXJuIC1FVElNRU9VVCBlcnJvciBudW1iZXIs
IHNvIHRoaXMNCmxpa2VzIHdoYXQgSSBkaWQsIGRvZXNuJ3QgZml4IGl0Lg0KDQo+IA0KPiBPdGhl
cndpc2UsIHRoZSB4aGNpX3JjYXJfZG93bmxvYWRfZmlybXdhcmUoKSBjYW5ub3QgcmV0dXJuIC1F
VElNRURPVVQgaWYNCj4gdGltZW91dCBoYXBwZW5lZCBvbiB0aGUgcHJldmlvdXMgcG9sbCBbMV0u
DQo+IA0KPiBbMV0NCj4gKwkJcmV0dmFsID0gcmVhZGxfcG9sbF90aW1lb3V0X2F0b21pYyhyZWdz
ICsgUkNBUl9VU0IzX0RMX0NUUkwsDQo+ICsJCQkJdmFsLCAhKHZhbCAmIFJDQVJfVVNCM19ETF9D
VFJMX0ZXX1NFVF9EQVRBMCksDQo+ICsJCQkJMSwgMTAwMDApOw0KPiANCj4gQmVzdCByZWdhcmRz
LA0KPiBZb3NoaWhpcm8gU2hpbW9kYQ0KPiANCg0K

