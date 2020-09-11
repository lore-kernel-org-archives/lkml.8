Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DDDC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5497221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DPW2ckUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbgIKLuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 07:50:07 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:33534 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725856AbgIKLsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 07:48:43 -0400
X-UUID: 887f81f17e1f4ce78be8edd0f1deee06-20200911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=DLomLN9zNFDunBiob0rT4DbaL1hDl/x0cwjtBBhXfp4=;
        b=DPW2ckUZgxbhLZKMBNG5B73uVyd+dCYzxhJcl0RiAeniEXV/kGXem/hXlxpSWbeISKjN7f0e06/76F1Em1VnHK/L/sW33XEBXboiCYm/kvoSPPaTOm/B7YYkLldRxC4AswbW3PfWtfOz3I++BGtkBv8RNw8OshSP04kUZVo+zwg=;
X-UUID: 887f81f17e1f4ce78be8edd0f1deee06-20200911
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 398076138; Fri, 11 Sep 2020 19:48:26 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 11 Sep
 2020 19:48:24 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Sep 2020 19:48:24 +0800
Message-ID: <1599824789.29909.11.camel@mhfsdcap03>
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
Date:   Fri, 11 Sep 2020 19:46:29 +0800
In-Reply-To: <OSAPR01MB3683A8CE38F900DC0CA5D472D8240@OSAPR01MB3683.jpnprd01.prod.outlook.com>
References: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
         <1599726112-4439-4-git-send-email-chunfeng.yun@mediatek.com>
         <20200910131212.wm7zskxvcesl652c@holly.lan>
         <1599791601.24609.5.camel@mhfsdcap03>
         <OSAPR01MB3683CA015AB25BC00D8459EBD8240@OSAPR01MB3683.jpnprd01.prod.outlook.com>
         <1599797572.24609.8.camel@mhfsdcap03>
         <OSAPR01MB3683A8CE38F900DC0CA5D472D8240@OSAPR01MB3683.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 4C6ED5B7AE39852F8B74E88F4557590F378A11ACC86403F44D061AA00A2F8FBC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTA5LTExIGF0IDA0OjU3ICswMDAwLCBZb3NoaWhpcm8gU2hpbW9kYSB3cm90
ZToNCj4gSGkgQ2h1bmZlbmcsDQo+IA0KPiA+IEZyb206IENodW5mZW5nIFl1biwgU2VudDogRnJp
ZGF5LCBTZXB0ZW1iZXIgMTEsIDIwMjAgMToxMyBQTQ0KPiA+IA0KPiA+IE9uIEZyaSwgMjAyMC0w
OS0xMSBhdCAwMzoxMyArMDAwMCwgWW9zaGloaXJvIFNoaW1vZGEgd3JvdGU6DQo+ID4gPiBIaSBE
YW5pZWwsIENodW5mZW5nLA0KPiA+ID4NCj4gPiA+ID4gRnJvbTogQ2h1bmZlbmcgWXVuLCBTZW50
OiBGcmlkYXksIFNlcHRlbWJlciAxMSwgMjAyMCAxMTozMyBBTQ0KPiA+ID4gPg0KPiA+ID4gPiBP
biBUaHUsIDIwMjAtMDktMTAgYXQgMTQ6MTIgKzAxMDAsIERhbmllbCBUaG9tcHNvbiB3cm90ZToN
Cj4gPiA+ID4gPiBPbiBUaHUsIFNlcCAxMCwgMjAyMCBhdCAwNDoyMTo0NVBNICswODAwLCBDaHVu
ZmVuZyBZdW4gd3JvdGU6DQo+ID4gPiA+ID4gPiBVc2UgcmVhZGxfcG9sbF90aW1lb3V0X2F0b21p
YygpIHRvIHNpbXBsaWZ5IGNvZGUNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBDYzogTWF0aGlh
cyBOeW1hbiA8bWF0aGlhcy5ueW1hbkBsaW51eC5pbnRlbC5jb20+DQo+ID4gPiA+ID4gPiBDYzog
WW9zaGloaXJvIFNoaW1vZGEgPHlvc2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29tPg0KPiA+
ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0
ZWsuY29tPg0KPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiB2Mn52Mzogbm8gY2hhbmdlcw0K
PiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiAgZHJpdmVycy91c2IvaG9zdC94aGNpLXJjYXIu
YyB8IDQzICsrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+
ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMzEgZGVsZXRpb25zKC0p
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3Qv
eGhjaS1yY2FyLmMgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktcmNhci5jDQo+ID4gPiA+ID4gPiBp
bmRleCBjMTAyNWQzLi43NGY4MzZmIDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy91
c2IvaG9zdC94aGNpLXJjYXIuYw0KPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy91c2IvaG9zdC94
aGNpLXJjYXIuYw0KPiA+ID4gPiA+ID4gQEAgLTYsNiArNiw3IEBADQo+ID4gPiA+ID4gPiAgICov
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gICNpbmNsdWRlIDxsaW51eC9maXJtd2FyZS5oPg0K
PiA+ID4gPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9pb3BvbGwuaD4NCj4gPiA+ID4gPiA+ICAjaW5j
bHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gPiA+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L3BsYXRm
b3JtX2RldmljZS5oPg0KPiA+ID4gPiA+ID4gICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiA+ID4g
PiA+ID4gQEAgLTEyNyw4ICsxMjgsNyBAQCBzdGF0aWMgaW50IHhoY2lfcmNhcl9kb3dubG9hZF9m
aXJtd2FyZShzdHJ1Y3QgdXNiX2hjZCAqaGNkKQ0KPiA+ID4gPiA+ID4gIAl2b2lkIF9faW9tZW0g
KnJlZ3MgPSBoY2QtPnJlZ3M7DQo+ID4gPiA+ID4gPiAgCXN0cnVjdCB4aGNpX3BsYXRfcHJpdiAq
cHJpdiA9IGhjZF90b194aGNpX3ByaXYoaGNkKTsNCj4gPiA+ID4gPiA+ICAJY29uc3Qgc3RydWN0
IGZpcm13YXJlICpmdzsNCj4gPiA+ID4gPiA+IC0JaW50IHJldHZhbCwgaW5kZXgsIGosIHRpbWU7
DQo+ID4gPiA+ID4gPiAtCWludCB0aW1lb3V0ID0gMTAwMDA7DQo+ID4gPiA+ID4gPiArCWludCBy
ZXR2YWwsIGluZGV4LCBqOw0KPiA+ID4gPiA+ID4gIAl1MzIgZGF0YSwgdmFsLCB0ZW1wOw0KPiA+
ID4gPiA+ID4gIAl1MzIgcXVpcmtzID0gMDsNCj4gPiA+ID4gPiA+ICAJY29uc3Qgc3RydWN0IHNv
Y19kZXZpY2VfYXR0cmlidXRlICphdHRyOw0KPiA+ID4gPiA+ID4gQEAgLTE2NiwzMiArMTY2LDE5
IEBAIHN0YXRpYyBpbnQgeGhjaV9yY2FyX2Rvd25sb2FkX2Zpcm13YXJlKHN0cnVjdCB1c2JfaGNk
ICpoY2QpDQo+ID4gPiA+ID4gPiAgCQl0ZW1wIHw9IFJDQVJfVVNCM19ETF9DVFJMX0ZXX1NFVF9E
QVRBMDsNCj4gPiA+ID4gPiA+ICAJCXdyaXRlbCh0ZW1wLCByZWdzICsgUkNBUl9VU0IzX0RMX0NU
UkwpOw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IC0JCWZvciAodGltZSA9IDA7IHRpbWUgPCB0
aW1lb3V0OyB0aW1lKyspIHsNCj4gPiA+ID4gPiA+IC0JCQl2YWwgPSByZWFkbChyZWdzICsgUkNB
Ul9VU0IzX0RMX0NUUkwpOw0KPiA+ID4gPiA+ID4gLQkJCWlmICgodmFsICYgUkNBUl9VU0IzX0RM
X0NUUkxfRldfU0VUX0RBVEEwKSA9PSAwKQ0KPiA+ID4gPiA+ID4gLQkJCQlicmVhazsNCj4gPiA+
ID4gPiA+IC0JCQl1ZGVsYXkoMSk7DQo+ID4gPiA+ID4gPiAtCQl9DQo+ID4gPiA+ID4gPiAtCQlp
ZiAodGltZSA9PSB0aW1lb3V0KSB7DQo+ID4gPiA+ID4gPiAtCQkJcmV0dmFsID0gLUVUSU1FRE9V
VDsNCj4gPiA+ID4gPiA+ICsJCXJldHZhbCA9IHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMocmVn
cyArIFJDQVJfVVNCM19ETF9DVFJMLA0KPiA+ID4gPiA+ID4gKwkJCQl2YWwsICEodmFsICYgUkNB
Ul9VU0IzX0RMX0NUUkxfRldfU0VUX0RBVEEwKSwNCj4gPiA+ID4gPiA+ICsJCQkJMSwgMTAwMDAp
Ow0KPiA+ID4gPiA+ID4gKwkJaWYgKHJldHZhbCA8IDApDQo+ID4gSG93IGFib3V0IGZyZWUgZmly
bXdhcmUgYW5kIHJldHVybiBlcnJvciBudW1iZXIgaGVyZSA/IGluc3RlYWQgb2YgYnJlYWsNCj4g
DQo+IEkgdGhpbmsgY2xlYXJpbmcgQ1RSTF9FTkFCTEUgY29kZSBiZWxvdyBpcyBuZWVkZWQuDQo+
IEFuZCwgSSB0aGluayB0aGlzIHBhdGNoIHNob3VsZCBub3QgY2hhbmdlIGEgbG90IG9mIHRoaW5n
cy4uLg0KT2ssIHRoYW5rcw0KDQo+IA0KPiA+ID4gPiA+ID4gIAkJCWJyZWFrOw0KPiA+ID4gPiA+
ID4gLQkJfQ0KPiA+ID4gPiA+ID4gIAl9DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gIAl0ZW1w
ID0gcmVhZGwocmVncyArIFJDQVJfVVNCM19ETF9DVFJMKTsNCj4gPiA+ID4gPiA+ICAJdGVtcCAm
PSB+UkNBUl9VU0IzX0RMX0NUUkxfRU5BQkxFOw0KPiA+ID4gPiA+ID4gIAl3cml0ZWwodGVtcCwg
cmVncyArIFJDQVJfVVNCM19ETF9DVFJMKTsNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAtCWZv
ciAodGltZSA9IDA7IHRpbWUgPCB0aW1lb3V0OyB0aW1lKyspIHsNCj4gPiA+ID4gPiA+IC0JCXZh
bCA9IHJlYWRsKHJlZ3MgKyBSQ0FSX1VTQjNfRExfQ1RSTCk7DQo+ID4gPiA+ID4gPiAtCQlpZiAo
dmFsICYgUkNBUl9VU0IzX0RMX0NUUkxfRldfU1VDQ0VTUykgew0KPiA+ID4gPiA+ID4gLQkJCXJl
dHZhbCA9IDA7DQo+ID4gPiA+ID4gPiAtCQkJYnJlYWs7DQo+ID4gPiA+ID4gPiAtCQl9DQo+ID4g
PiA+ID4gPiAtCQl1ZGVsYXkoMSk7DQo+ID4gPiA+ID4gPiAtCX0NCj4gPiA+ID4gPiA+IC0JaWYg
KHRpbWUgPT0gdGltZW91dCkNCj4gPiA+ID4gPiA+IC0JCXJldHZhbCA9IC1FVElNRURPVVQ7DQo+
ID4gPiA+ID4gPiArCXJldHZhbCA9IHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKHJlZ3MgKyBS
Q0FSX1VTQjNfRExfQ1RSTCksDQo+ID4gPiA+ID4gPiArCQkJdmFsLCAodmFsICYgUkNBUl9VU0Iz
X0RMX0NUUkxfRldfU1VDQ0VTUyksIDEsIDEwMDAwKTsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IERp
cmVjdGx5IGFzc2lnbmluZyB0byByZXR2YWwgYXQgdGhpcyBwb2ludCB3aWxsIGNsb2JiZXIgYSBw
cmV2aW91cw0KPiA+ID4gPiA+IC1FVElNRURPVVQgZXJyb3IuDQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBJbiBvdGhlciB3b3JkcyBpZiB0aGVyZSBpcyBhIHRpbWVvdXQgd2FpdGluZyBmb3IgRldfU0VU
X0RBVEEwLCBidXQgbm90IGZvcg0KPiA+ID4gPiA+IERXX1NVQ0NFU1MsIHRoZW4gd2Ugd2lsbCBy
ZXR1cm4gdGhlIHdyb25nIHJldHVybiB2YWx1ZS4NCj4gPiA+DQo+ID4gPiBUaGFuayB5b3UgZm9y
IHlvdXIgY29tbWVudCEgSSBkaWRuJ3QgcmVhbGl6ZWQgdGhpcy4NCj4gPiA+DQo+ID4gPiA+IFll
cywgYWdyZWUgd2l0aCB5b3UsIGJ1dCBzZWVtcyBJIGtlZXAgaXRzIG9yaWdpbmFsIGxvZ2ljIHVu
Y2hhbmdlZC4NCj4gPiA+ID4gSGkgWW9zaGloaXJvLA0KPiA+ID4gPg0KPiA+ID4gPiAgIFdoYXQg
ZG8gdGhpbmsgYWJvdXQgRGFuaWVsJ3Mgc3VnZ2VzdGlvbj8gc2hvdWxkIEkgZml4IGl0IHVwPw0K
PiA+ID4NCj4gPiA+IEkgdGhpbmsgeW91IHNob3VsZCBmaXggaXQgdXAgbGlrZSBiZWxvdzoNCj4g
PiA+DQo+ID4gPiBpZiAocmVhZGxfcG9sbF90aW1lb3V0X2F0b21pYyhyZWdzICsgUkNBUl9VU0Iz
X0RMX0NUUkwsDQo+ID4gPiAJCXZhbCwgdmFsICYgUkNBUl9VU0IzX0RMX0NUUkxfRldfU1VDQ0VT
UywgMSwgMTAwMDApIDwgMCkNCj4gPiA+IAlyZXR2YWwgPSAtRVRJTUVPVVQ7CS8qIE92ZXJ3cml0
ZSByZXR2YWwgaWYgdGltZW91dCBvY2N1cnJlZCAqLw0KPiA+IA0KPiA+IHJlYWRsX3BvbGxfdGlt
ZW91dF9hdG9taWMoKSBvbmx5IHJldHVybiAtRVRJTUVPVVQgZXJyb3IgbnVtYmVyLCBzbyB0aGlz
DQo+ID4gbGlrZXMgd2hhdCBJIGRpZCwgZG9lc24ndCBmaXggaXQuDQo+IA0KPiByZWFkbF9wb2xs
X3RpbWVvdXRfYXRvbWljKCkgcmV0dXJucyAwIGlmIHRpbWVvdXQgZG9lc24ndCBoYXBwZW4uDQo+
IFNvLCB3aGVuIG15IHN1Z2dlc3Rpb24gY29kZSBydW5zLCB0aGUgcmV0dmFsIGlzIG5vdCBvdmVy
d3JpdHRlbiBpZg0KPiB0aGUgcmVhZGxfcG9sbF90aW1lb3V0X2F0b21pYyhyZWdzICsgUkNBUl9V
U0IzX0RMX0NUUkwuLi4pIHJldHVybnMgMC4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gWW9zaGlo
aXJvIFNoaW1vZGENCj4gDQoNCg==

