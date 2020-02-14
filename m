Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E720C3B195
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 05:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370A824670
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 05:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mMe46RpU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgBNFy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 00:54:26 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:57502 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725975AbgBNFy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 00:54:26 -0500
X-UUID: 2f93630e4c93494287119bf1f6cf5044-20200214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=aq4/Nt3mOflR2npqJVwKlN7pvDCRb3THFi/XCc/6prY=;
        b=mMe46RpU4MjD2/b8VIVSeyNJUVQtNlvo29DivMBMaZABa5+ulVjBWlyS6pRPov5Zj1Sx24FixOiVzMCoy6eUHux3xbhw7osEs1jBHyO/Pa3KHUL2rjYYM6xGhe/7VujW95IYDoClV4NwTjDKfATudJxdZQaIL7cqC/rkR1wz7p4=;
X-UUID: 2f93630e4c93494287119bf1f6cf5044-20200214
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2024173249; Fri, 14 Feb 2020 13:54:20 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Feb 2020 13:52:44 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Feb 2020 13:53:40 +0800
Message-ID: <1581659650.12440.5.camel@mtksdaap41>
Subject: Re: [PATCH 2/3] mailbox: mediatek: remove implementation related to
 atomic_exec
From:   CK Hu <ck.hu@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>
Date:   Fri, 14 Feb 2020 13:54:10 +0800
In-Reply-To: <20200214043325.16618-3-bibby.hsieh@mediatek.com>
References: <20200214043325.16618-1-bibby.hsieh@mediatek.com>
         <20200214043325.16618-3-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: C8DF138582729314102426D84EB054128BA229A57B171B48E715190E688E887C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJpYmJ5Og0KDQpPbiBGcmksIDIwMjAtMDItMTQgYXQgMTI6MzMgKzA4MDAsIEJpYmJ5IEhz
aWVoIHdyb3RlOg0KPiBBZnRlciBpbXBsZW1lbnQgZmx1c2gsIGNsaWVudCBjYW4gZmx1c2ggdGhl
IGV4ZWN1dGluZw0KPiBjb21tYW5kIGJ1ZmZlciBvciBhYm9ydCB0aGUgc3RpbGwgd2FpdGluZyBm
b3IgZXZlbnQNCj4gY29tbWFuZCBidWZmZXIsIHNvIGNvbnRyb2xsZXIgZG8gbm90IG5lZWQgdG8g
aW1wbGVtZW50DQo+IGF0b21pY19leGUgZmVhdHVyZS4gcmVtb3ZlIGl0Lg0KPiANCg0KUmV2aWV3
ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gU2lnbmVkLW9mZi1ieTogQmli
YnkgSHNpZWggPGJpYmJ5LmhzaWVoQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL21h
aWxib3gvbXRrLWNtZHEtbWFpbGJveC5jIHwgNzYgKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA2OCBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jIGIv
ZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiBpbmRleCAwM2U1OGZmNjIwMDcu
LjNjZTc3NzAwMWFhNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1h
aWxib3guYw0KPiArKysgYi9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+IEBA
IC01Nyw3ICs1Nyw2IEBAIHN0cnVjdCBjbWRxX3RocmVhZCB7DQo+ICAJdm9pZCBfX2lvbWVtCQkq
YmFzZTsNCj4gIAlzdHJ1Y3QgbGlzdF9oZWFkCXRhc2tfYnVzeV9saXN0Ow0KPiAgCXUzMgkJCXBy
aW9yaXR5Ow0KPiAtCWJvb2wJCQlhdG9taWNfZXhlYzsNCj4gIH07DQo+ICANCj4gIHN0cnVjdCBj
bWRxX3Rhc2sgew0KPiBAQCAtMTYzLDQ4ICsxNjIsMTEgQEAgc3RhdGljIHZvaWQgY21kcV90YXNr
X2luc2VydF9pbnRvX3RocmVhZChzdHJ1Y3QgY21kcV90YXNrICp0YXNrKQ0KPiAgCWNtZHFfdGhy
ZWFkX2ludmFsaWRhdGVfZmV0Y2hlZF9kYXRhKHRocmVhZCk7DQo+ICB9DQo+ICANCj4gLXN0YXRp
YyBib29sIGNtZHFfY29tbWFuZF9pc193ZmUodTY0IGNtZCkNCj4gLXsNCj4gLQl1NjQgd2ZlX29w
dGlvbiA9IENNRFFfV0ZFX1VQREFURSB8IENNRFFfV0ZFX1dBSVQgfCBDTURRX1dGRV9XQUlUX1ZB
TFVFOw0KPiAtCXU2NCB3ZmVfb3AgPSAodTY0KShDTURRX0NPREVfV0ZFIDw8IENNRFFfT1BfQ09E
RV9TSElGVCkgPDwgMzI7DQo+IC0JdTY0IHdmZV9tYXNrID0gKHU2NClDTURRX09QX0NPREVfTUFT
SyA8PCAzMiB8IDB4ZmZmZmZmZmY7DQo+IC0NCj4gLQlyZXR1cm4gKChjbWQgJiB3ZmVfbWFzaykg
PT0gKHdmZV9vcCB8IHdmZV9vcHRpb24pKTsNCj4gLX0NCj4gLQ0KPiAtLyogd2UgYXNzdW1lIHRh
c2tzIGluIHRoZSBzYW1lIGRpc3BsYXkgR0NFIHRocmVhZCBhcmUgd2FpdGluZyB0aGUgc2FtZSBl
dmVudC4gKi8NCj4gLXN0YXRpYyB2b2lkIGNtZHFfdGFza19yZW1vdmVfd2ZlKHN0cnVjdCBjbWRx
X3Rhc2sgKnRhc2spDQo+IC17DQo+IC0Jc3RydWN0IGRldmljZSAqZGV2ID0gdGFzay0+Y21kcS0+
bWJveC5kZXY7DQo+IC0JdTY0ICpiYXNlID0gdGFzay0+cGt0LT52YV9iYXNlOw0KPiAtCWludCBp
Ow0KPiAtDQo+IC0JZG1hX3N5bmNfc2luZ2xlX2Zvcl9jcHUoZGV2LCB0YXNrLT5wYV9iYXNlLCB0
YXNrLT5wa3QtPmNtZF9idWZfc2l6ZSwNCj4gLQkJCQlETUFfVE9fREVWSUNFKTsNCj4gLQlmb3Ig
KGkgPSAwOyBpIDwgQ01EUV9OVU1fQ01EKHRhc2stPnBrdCk7IGkrKykNCj4gLQkJaWYgKGNtZHFf
Y29tbWFuZF9pc193ZmUoYmFzZVtpXSkpDQo+IC0JCQliYXNlW2ldID0gKHU2NClDTURRX0pVTVBf
QllfT0ZGU0VUIDw8IDMyIHwNCj4gLQkJCQkgIENNRFFfSlVNUF9QQVNTOw0KPiAtCWRtYV9zeW5j
X3NpbmdsZV9mb3JfZGV2aWNlKGRldiwgdGFzay0+cGFfYmFzZSwgdGFzay0+cGt0LT5jbWRfYnVm
X3NpemUsDQo+IC0JCQkJICAgRE1BX1RPX0RFVklDRSk7DQo+IC19DQo+IC0NCj4gIHN0YXRpYyBi
b29sIGNtZHFfdGhyZWFkX2lzX2luX3dmZShzdHJ1Y3QgY21kcV90aHJlYWQgKnRocmVhZCkNCj4g
IHsNCj4gIAlyZXR1cm4gcmVhZGwodGhyZWFkLT5iYXNlICsgQ01EUV9USFJfV0FJVF9UT0tFTikg
JiBDTURRX1RIUl9JU19XQUlUSU5HOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgdm9pZCBjbWRxX3Ro
cmVhZF93YWl0X2VuZChzdHJ1Y3QgY21kcV90aHJlYWQgKnRocmVhZCwNCj4gLQkJCQkgdW5zaWdu
ZWQgbG9uZyBlbmRfcGEpDQo+IC17DQo+IC0Jc3RydWN0IGRldmljZSAqZGV2ID0gdGhyZWFkLT5j
aGFuLT5tYm94LT5kZXY7DQo+IC0JdW5zaWduZWQgbG9uZyBjdXJyX3BhOw0KPiAtDQo+IC0JaWYg
KHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWModGhyZWFkLT5iYXNlICsgQ01EUV9USFJfQ1VSUl9B
RERSLA0KPiAtCQkJY3Vycl9wYSwgY3Vycl9wYSA9PSBlbmRfcGEsIDEsIDIwKSkNCj4gLQkJZGV2
X2VycihkZXYsICJHQ0UgdGhyZWFkIGNhbm5vdCBydW4gdG8gZW5kLlxuIik7DQo+IC19DQo+IC0N
Cj4gIHN0YXRpYyB2b2lkIGNtZHFfdGFza19leGVjX2RvbmUoc3RydWN0IGNtZHFfdGFzayAqdGFz
aywgZW51bSBjbWRxX2NiX3N0YXR1cyBzdGEpDQo+ICB7DQo+ICAJc3RydWN0IGNtZHFfdGFza19j
YiAqY2IgPSAmdGFzay0+cGt0LT5hc3luY19jYjsNCj4gQEAgLTM4NCwzNiArMzQ2LDE1IEBAIHN0
YXRpYyBpbnQgY21kcV9tYm94X3NlbmRfZGF0YShzdHJ1Y3QgbWJveF9jaGFuICpjaGFuLCB2b2lk
ICpkYXRhKQ0KPiAgCQlXQVJOX09OKGNtZHFfdGhyZWFkX3N1c3BlbmQoY21kcSwgdGhyZWFkKSA8
IDApOw0KPiAgCQljdXJyX3BhID0gcmVhZGwodGhyZWFkLT5iYXNlICsgQ01EUV9USFJfQ1VSUl9B
RERSKTsNCj4gIAkJZW5kX3BhID0gcmVhZGwodGhyZWFkLT5iYXNlICsgQ01EUV9USFJfRU5EX0FE
RFIpOw0KPiAtDQo+IC0JCS8qDQo+IC0JCSAqIEF0b21pYyBleGVjdXRpb24gc2hvdWxkIHJlbW92
ZSB0aGUgZm9sbG93aW5nIHdmZSwgaS5lLiBvbmx5DQo+IC0JCSAqIHdhaXQgZXZlbnQgYXQgZmly
c3QgdGFzaywgYW5kIHByZXZlbnQgdG8gcGF1c2Ugd2hlbiBydW5uaW5nLg0KPiAtCQkgKi8NCj4g
LQkJaWYgKHRocmVhZC0+YXRvbWljX2V4ZWMpIHsNCj4gLQkJCS8qIEdDRSBpcyBleGVjdXRpbmcg
aWYgY29tbWFuZCBpcyBub3QgV0ZFICovDQo+IC0JCQlpZiAoIWNtZHFfdGhyZWFkX2lzX2luX3dm
ZSh0aHJlYWQpKSB7DQo+IC0JCQkJY21kcV90aHJlYWRfcmVzdW1lKHRocmVhZCk7DQo+IC0JCQkJ
Y21kcV90aHJlYWRfd2FpdF9lbmQodGhyZWFkLCBlbmRfcGEpOw0KPiAtCQkJCVdBUk5fT04oY21k
cV90aHJlYWRfc3VzcGVuZChjbWRxLCB0aHJlYWQpIDwgMCk7DQo+IC0JCQkJLyogc2V0IHRvIHRo
aXMgdGFzayBkaXJlY3RseSAqLw0KPiAtCQkJCXdyaXRlbCh0YXNrLT5wYV9iYXNlLA0KPiAtCQkJ
CSAgICAgICB0aHJlYWQtPmJhc2UgKyBDTURRX1RIUl9DVVJSX0FERFIpOw0KPiAtCQkJfSBlbHNl
IHsNCj4gLQkJCQljbWRxX3Rhc2tfaW5zZXJ0X2ludG9fdGhyZWFkKHRhc2spOw0KPiAtCQkJCWNt
ZHFfdGFza19yZW1vdmVfd2ZlKHRhc2spOw0KPiAtCQkJCXNtcF9tYigpOyAvKiBtb2RpZnkganVt
cCBiZWZvcmUgZW5hYmxlIHRocmVhZCAqLw0KPiAtCQkJfQ0KPiArCQkvKiBjaGVjayBib3VuZGFy
eSAqLw0KPiArCQlpZiAoY3Vycl9wYSA9PSBlbmRfcGEgLSBDTURRX0lOU1RfU0laRSB8fA0KPiAr
CQkgICAgY3Vycl9wYSA9PSBlbmRfcGEpIHsNCj4gKwkJCS8qIHNldCB0byB0aGlzIHRhc2sgZGly
ZWN0bHkgKi8NCj4gKwkJCXdyaXRlbCh0YXNrLT5wYV9iYXNlLA0KPiArCQkJICAgICAgIHRocmVh
ZC0+YmFzZSArIENNRFFfVEhSX0NVUlJfQUREUik7DQo+ICAJCX0gZWxzZSB7DQo+IC0JCQkvKiBj
aGVjayBib3VuZGFyeSAqLw0KPiAtCQkJaWYgKGN1cnJfcGEgPT0gZW5kX3BhIC0gQ01EUV9JTlNU
X1NJWkUgfHwNCj4gLQkJCSAgICBjdXJyX3BhID09IGVuZF9wYSkgew0KPiAtCQkJCS8qIHNldCB0
byB0aGlzIHRhc2sgZGlyZWN0bHkgKi8NCj4gLQkJCQl3cml0ZWwodGFzay0+cGFfYmFzZSwNCj4g
LQkJCQkgICAgICAgdGhyZWFkLT5iYXNlICsgQ01EUV9USFJfQ1VSUl9BRERSKTsNCj4gLQkJCX0g
ZWxzZSB7DQo+IC0JCQkJY21kcV90YXNrX2luc2VydF9pbnRvX3RocmVhZCh0YXNrKTsNCj4gLQkJ
CQlzbXBfbWIoKTsgLyogbW9kaWZ5IGp1bXAgYmVmb3JlIGVuYWJsZSB0aHJlYWQgKi8NCj4gLQkJ
CX0NCj4gKwkJCWNtZHFfdGFza19pbnNlcnRfaW50b190aHJlYWQodGFzayk7DQo+ICsJCQlzbXBf
bWIoKTsgLyogbW9kaWZ5IGp1bXAgYmVmb3JlIGVuYWJsZSB0aHJlYWQgKi8NCj4gIAkJfQ0KPiAg
CQl3cml0ZWwodGFzay0+cGFfYmFzZSArIHBrdC0+Y21kX2J1Zl9zaXplLA0KPiAgCQkgICAgICAg
dGhyZWFkLT5iYXNlICsgQ01EUV9USFJfRU5EX0FERFIpOw0KPiBAQCAtNDk1LDcgKzQzNiw2IEBA
IHN0YXRpYyBzdHJ1Y3QgbWJveF9jaGFuICpjbWRxX3hsYXRlKHN0cnVjdCBtYm94X2NvbnRyb2xs
ZXIgKm1ib3gsDQo+ICANCj4gIAl0aHJlYWQgPSAoc3RydWN0IGNtZHFfdGhyZWFkICopbWJveC0+
Y2hhbnNbaW5kXS5jb25fcHJpdjsNCj4gIAl0aHJlYWQtPnByaW9yaXR5ID0gc3AtPmFyZ3NbMV07
DQo+IC0JdGhyZWFkLT5hdG9taWNfZXhlYyA9IChzcC0+YXJnc1syXSAhPSAwKTsNCj4gIAl0aHJl
YWQtPmNoYW4gPSAmbWJveC0+Y2hhbnNbaW5kXTsNCj4gIA0KPiAgCXJldHVybiAmbWJveC0+Y2hh
bnNbaW5kXTsNCg0K

