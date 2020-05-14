Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19859C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D48F2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JFQDRTde"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgENBjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 21:39:13 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:14344 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725925AbgENBjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 21:39:13 -0400
X-UUID: 4b3c483eabb647ccac6f02e4391850e8-20200514
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=c6lbM5ORaD1df0n3V09w+vUyABWL3OC0bP3q4G96Tcg=;
        b=JFQDRTdeKMXmptoNuzltVULKMmUll5JnMpZe+S/kxnVb3BXqfeqP1ULq3AwK4EnwxqfzDmXQxK0c+nkNkt3zagqihn2OJNX4bii+4inY22I5mQiBsFyUAKCdcVlVLezmo+Tym+beCV4iNcHRGN9BS7j1Cv5UcwLflgjVM0szfMI=;
X-UUID: 4b3c483eabb647ccac6f02e4391850e8-20200514
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 127096153; Thu, 14 May 2020 09:39:07 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 14 May
 2020 09:39:04 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 May 2020 09:39:03 +0800
Message-ID: <1589420265.5899.0.camel@mhfsdcap03>
Subject: Re: [PATCH 3/3] usb: dwc3: keystone: Turn on USB3 PHY before
 controller
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     <balbi@kernel.org>, <robh+dt@kernel.org>, <vigneshr@ti.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Date:   Thu, 14 May 2020 09:37:45 +0800
In-Reply-To: <20200513130709.10239-4-rogerq@ti.com>
References: <20200513130709.10239-1-rogerq@ti.com>
         <20200513130709.10239-4-rogerq@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 3195E2F93C14396777CFF1A5A593F242391F9645814601659A98E9F49774BB9F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA1LTEzIGF0IDE2OjA3ICswMzAwLCBSb2dlciBRdWFkcm9zIHdyb3RlOg0K
PiBUaGUgTG9jYWwgUG93ZXIgU2xlZXAgQ29udHJvbGxlciAoTFBTQykgZGVwZW5kZW5jeSBvbiBB
TTY1DQo+IHJlcXVpcmVzIFNFUkRFUzAgdG8gYmUgcG93ZXJlZCBvbiBiZWZvcmUgVVNCLg0KPiAN
Cj4gV2UgbmVlZCB0byBwb3dlciB1cCBTRVJERVMwIHBvd2VyIGRvbWFpbiBhbmQgaG9sZCBpdCBv
bg0KPiB0aHJvdWdob3V0IHRoZSByZXNldCwgaW5pdCwgcG93ZXIgb24gc2VxdWVuY2UuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBSb2dlciBRdWFkcm9zIDxyb2dlcnFAdGkuY29tPg0KPiAtLS0NCj4g
IGRyaXZlcnMvdXNiL2R3YzMvZHdjMy1rZXlzdG9uZS5jIHwgNDcgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLWtleXN0
b25lLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2R3YzMta2V5c3RvbmUuYw0KPiBpbmRleCAxZTE0YTZm
NDg4NGIuLjQ2ZDQ2ZjM1MDdmYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9kd2Mz
LWtleXN0b25lLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9kd2MzLWtleXN0b25lLmMNCj4g
QEAgLTE0LDYgKzE0LDcgQEANCj4gICNpbmNsdWRlIDxsaW51eC9kbWEtbWFwcGluZy5oPg0KPiAg
I2luY2x1ZGUgPGxpbnV4L2lvLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvb2ZfcGxhdGZvcm0uaD4N
Cj4gKyNpbmNsdWRlIDxsaW51eC9waHkvcGh5Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvcG1fcnVu
dGltZS5oPg0KPiAgDQo+ICAvKiBVU0JTUyByZWdpc3RlciBvZmZzZXRzICovDQo+IEBAIC0zNCw2
ICszNSw3IEBADQo+ICBzdHJ1Y3QgZHdjM19rZXlzdG9uZSB7DQo+ICAJc3RydWN0IGRldmljZQkJ
CSpkZXY7DQo+ICAJdm9pZCBfX2lvbWVtCQkJKnVzYnNzOw0KPiArCXN0cnVjdCBwaHkJCQkqdXNi
M19waHk7DQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgaW5saW5lIHUzMiBrZHdjM19yZWFkbCh2b2lk
IF9faW9tZW0gKmJhc2UsIHUzMiBvZmZzZXQpDQo+IEBAIC05NSw4ICs5Nyw0NCBAQCBzdGF0aWMg
aW50IGtkd2MzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJaWYgKElT
X0VSUihrZHdjLT51c2JzcykpDQo+ICAJCXJldHVybiBQVFJfRVJSKGtkd2MtPnVzYnNzKTsNCj4g
IA0KPiAtCXBtX3J1bnRpbWVfZW5hYmxlKGtkd2MtPmRldik7DQo+ICsJLyogUFNDIGRlcGVuZGVu
Y3kgb24gQU02NSBuZWVkcyBTRVJERVMwIHRvIGJlIHBvd2VyZWQgYmVmb3JlIFVTQjAgKi8NCj4g
KwlrZHdjLT51c2IzX3BoeSA9IGRldm1fcGh5X2dldChkZXYsICJ1c2IzLXBoeSIpOw0KVXNlIGRl
dm1fcGh5X29wdGlvbmFsX2dldCgpIGluc3RlYWQ/DQoNCj4gKwlpZiAoSVNfRVJSKGtkd2MtPnVz
YjNfcGh5KSkgew0KPiArCQllcnJvciA9IFBUUl9FUlIoa2R3Yy0+dXNiM19waHkpOw0KPiArCQlp
ZiAoZXJyb3IgPT0gLUVOT1NZUyB8fCBlcnJvciA9PSAtRU5PREVWKSB7DQo+ICsJCQlrZHdjLT51
c2IzX3BoeSA9IE5VTEw7DQo+ICsJCX0gZWxzZSB7DQo+ICsJCQlpZiAoZXJyb3IgIT0gLUVQUk9C
RV9ERUZFUikgew0KPiArCQkJCWRldl9lcnIoZGV2LCAiY291bGRuJ3QgZ2V0IHVzYjMgcGh5OiAl
ZFxuIiwNCj4gKwkJCQkJZXJyb3IpOw0KPiArCQkJfQ0KPiArDQo+ICsJCQlyZXR1cm4gZXJyb3I7
DQo+ICsJCX0NCj4gKwl9DQo+ICsNCj4gKwlwaHlfcG1fcnVudGltZV9nZXRfc3luYyhrZHdjLT51
c2IzX3BoeSk7DQo+ICsNCj4gKwllcnJvciA9IHBoeV9yZXNldChrZHdjLT51c2IzX3BoeSk7DQo+
ICsJaWYgKGVycm9yIDwgMCkgew0KPiArCQlkZXZfZXJyKGRldiwgInVzYjMgcGh5IHJlc2V0IGZh
aWxlZDogJWRcbiIsIGVycm9yKTsNCj4gKwkJcmV0dXJuIGVycm9yOw0KPiArCX0NCj4gKw0KPiAr
CWVycm9yID0gcGh5X2luaXQoa2R3Yy0+dXNiM19waHkpOw0KPiArCWlmIChlcnJvciA8IDApIHsN
Cj4gKwkJZGV2X2VycihkZXYsICJ1c2IzIHBoeSBpbml0IGZhaWxlZDogJWRcbiIsIGVycm9yKTsN
Cj4gKwkJcmV0dXJuIGVycm9yOw0KPiArCX0NCj4gIA0KPiArCWVycm9yID0gcGh5X3Bvd2VyX29u
KGtkd2MtPnVzYjNfcGh5KTsNCj4gKwlpZiAoZXJyb3IgPCAwKSB7DQo+ICsJCWRldl9lcnIoZGV2
LCAidXNiMyBwaHkgcG93ZXIgb24gZmFpbGVkOiAlZFxuIiwgZXJyb3IpOw0KPiArCQlwaHlfZXhp
dChrZHdjLT51c2IzX3BoeSk7DQo+ICsJCXJldHVybiBlcnJvcjsNCj4gKwl9DQo+ICsNCj4gKwlw
bV9ydW50aW1lX2VuYWJsZShrZHdjLT5kZXYpOw0KPiAgCWVycm9yID0gcG1fcnVudGltZV9nZXRf
c3luYyhrZHdjLT5kZXYpOw0KPiAgCWlmIChlcnJvciA8IDApIHsNCj4gIAkJZGV2X2VycihrZHdj
LT5kZXYsICJwbV9ydW50aW1lX2dldF9zeW5jIGZhaWxlZCwgZXJyb3IgJWRcbiIsDQo+IEBAIC0x
MzgsNiArMTc2LDkgQEAgc3RhdGljIGludCBrZHdjM19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPiAgZXJyX2lycToNCj4gIAlwbV9ydW50aW1lX3B1dF9zeW5jKGtkd2MtPmRl
dik7DQo+ICAJcG1fcnVudGltZV9kaXNhYmxlKGtkd2MtPmRldik7DQo+ICsJcGh5X3Bvd2VyX29m
ZihrZHdjLT51c2IzX3BoeSk7DQo+ICsJcGh5X2V4aXQoa2R3Yy0+dXNiM19waHkpOw0KPiArCXBo
eV9wbV9ydW50aW1lX3B1dF9zeW5jKGtkd2MtPnVzYjNfcGh5KTsNCj4gIA0KPiAgCXJldHVybiBl
cnJvcjsNCj4gIH0NCj4gQEAgLTE2Myw2ICsyMDQsMTAgQEAgc3RhdGljIGludCBrZHdjM19yZW1v
dmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlwbV9ydW50aW1lX3B1dF9zeW5j
KGtkd2MtPmRldik7DQo+ICAJcG1fcnVudGltZV9kaXNhYmxlKGtkd2MtPmRldik7DQo+ICANCj4g
KwlwaHlfcG93ZXJfb2ZmKGtkd2MtPnVzYjNfcGh5KTsNCj4gKwlwaHlfZXhpdChrZHdjLT51c2Iz
X3BoeSk7DQo+ICsJcGh5X3BtX3J1bnRpbWVfcHV0X3N5bmMoa2R3Yy0+dXNiM19waHkpOw0KPiAr
DQo+ICAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgTlVMTCk7DQo+ICANCj4gIAlyZXR1cm4g
MDsNCg0K

