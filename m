Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908B7C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 08:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63E7D20719
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 08:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jdh9vUaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgG0IwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 04:52:10 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:50531 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726302AbgG0IwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 04:52:09 -0400
X-UUID: 4faa5b68767544c988f8a5078b80dc23-20200727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=q34zqKlfJT1egqrpS4Z0LW4UkZCQFjyQJ1hrO1Kt++w=;
        b=jdh9vUaEP2PlzjKm/2oker36hCtrU4F+ZAjB2yirdFYudZ0SNBA/h8ra30CPxk0Ue1jRLD4gswLnpoiX55DNLLt/CyNcWkR7bbJP6M7fWkjviEmKFUfhgUhXzYw5KnBSmjHDkaW1c8U96XW23RwYiLj5bdomeApnwD0X0MVlMbg=;
X-UUID: 4faa5b68767544c988f8a5078b80dc23-20200727
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1620473155; Mon, 27 Jul 2020 16:52:02 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 27 Jul 2020 16:51:59 +0800
Received: from [10.15.20.246] (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 27 Jul 2020 16:51:58 +0800
Message-ID: <1595839778.2350.4.camel@mbjsdccf07>
Subject: Re: [PATCH 11/21] iommu/mediatek: Add power-domain operation
From:   chao hao <Chao.Hao@mediatek.com>
To:     Yong Wu <yong.wu@mediatek.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <cui.zhang@mediatek.com>,
        <ming-fan.chen@mediatek.com>, chao hao <"Chao. Hao"@mediatek.com>
Date:   Mon, 27 Jul 2020 16:49:38 +0800
In-Reply-To: <20200711064846.16007-12-yong.wu@mediatek.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
         <20200711064846.16007-12-yong.wu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIwLTA3LTExIGF0IDE0OjQ4ICswODAwLCBZb25nIFd1IHdyb3RlOg0KPiBJbiB0
aGUgcHJldmlvdXMgU29DLCB0aGUgTTRVIEhXIGlzIGluIHRoZSBFTUkgcG93ZXIgZG9tYWluIHdo
aWNoIGlzDQo+IGFsd2F5cyBvbi4gdGhlIGxhdGVzdCBNNFUgaXMgaW4gdGhlIGRpc3BsYXkgcG93
ZXIgZG9tYWluIHdoaWNoIG1heSBiZQ0KPiB0dXJuZWQgb24vb2ZmLCB0aHVzIHdlIGhhdmUgdG8g
YWRkIHBtX3J1bnRpbWUgaW50ZXJmYWNlIGZvciBpdC4NCj4gDQo+IHdlIHNob3VsZCBlbmFibGUg
aXRzIHBvd2VyIGJlZm9yZSBNNFUgaHcgaW5pdGlhbC4gYW5kIGRpc2FibGUgaXQgYWZ0ZXIgSFcN
Cj4gaW5pdGlhbGl6ZS4NCj4gDQo+IFdoZW4gdGhlIGVuZ2luZSB3b3JrLCB0aGUgZW5naW5lIGFs
d2F5cyBlbmFibGUgdGhlIHBvd2VyIGFuZCBjbG9ja3MgZm9yDQo+IHNtaS1sYXJiL3NtaS1jb21t
b24sIHRoZW4gdGhlIE00VSdzIHBvd2VyIHdpbGwgYWx3YXlzIGJlIHBvd2VyZWQgb24NCj4gYXV0
b21hdGljYWxseSB2aWEgdGhlIGRldmljZSBsaW5rIHdpdGggc21pLWNvbW1vbi4NCj4gDQo+IE5v
dGU6IHdlIGRvbid0IGVuYWJsZSB0aGUgTTRVIHBvd2VyIGluIGlvbW11X21hcC91bm1hcCBmb3Ig
dGxiIGZsdXNoLg0KPiBJZiBpdHMgcG93ZXIgYWxyZWFkeSBpcyBvbiwgb2YgY291cnNlIGl0IGlz
IG9rLiBpZiB0aGUgcG93ZXIgaXMgb2ZmLA0KPiB0aGUgbWFpbiB0bGIgd2lsbCBiZSByZXNldCB3
aGlsZSBNNFUgcG93ZXIgb24sIHRodXMgdGhlIHRsYiBmbHVzaCB3aGlsZQ0KPiBtNHUgcG93ZXIg
b2ZmIGlzIHVubmVjZXNzYXJ5LCBqdXN0IHNraXAgaXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZ
b25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2lvbW11L210
a19pb21tdS5jIHwgNTQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVycy9pb21tdS9t
dGtfaW9tbXUuYw0KPiBpbmRleCA5MzFmZGQxOWM4ZjMuLjAzYTZkNjZmNGJlZiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiArKysgYi9kcml2ZXJzL2lvbW11L210
a19pb21tdS5jDQo+IEBAIC0yMCw2ICsyMCw3IEBADQo+ICAjaW5jbHVkZSA8bGludXgvb2ZfaXJx
Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvb2ZfcGxhdGZvcm0uaD4NCj4gICNpbmNsdWRlIDxsaW51
eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+DQo+
ICAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3NwaW5sb2NrLmg+
DQo+ICAjaW5jbHVkZSA8YXNtL2JhcnJpZXIuaD4NCj4gQEAgLTE3Miw2ICsxNzMsMTkgQEAgc3Rh
dGljIHN0cnVjdCBtdGtfaW9tbXVfZG9tYWluICp0b19tdGtfZG9tYWluKHN0cnVjdCBpb21tdV9k
b21haW4gKmRvbSkNCj4gIAlyZXR1cm4gY29udGFpbmVyX29mKGRvbSwgc3RydWN0IG10a19pb21t
dV9kb21haW4sIGRvbWFpbik7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBpbnQgbXRrX2lvbW11X3Jw
bV9nZXQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiArew0KPiArCWlmIChwbV9ydW50aW1lX2VuYWJs
ZWQoZGV2KSkNCj4gKwkJcmV0dXJuIHBtX3J1bnRpbWVfZ2V0X3N5bmMoZGV2KTsNCj4gKwlyZXR1
cm4gMDsNCj4gK30NCj4gKw0KPiArc3RhdGljIHZvaWQgbXRrX2lvbW11X3JwbV9wdXQoc3RydWN0
IGRldmljZSAqZGV2KQ0KPiArew0KPiArCWlmIChwbV9ydW50aW1lX2VuYWJsZWQoZGV2KSkNCj4g
KwkJcG1fcnVudGltZV9wdXRfYXV0b3N1c3BlbmQoZGV2KTsNCj4gK30NCj4gKw0KPiAgc3RhdGlj
IHZvaWQgbXRrX2lvbW11X3RsYl9mbHVzaF9hbGwodm9pZCAqY29va2llKQ0KPiAgew0KPiAgCXN0
cnVjdCBtdGtfaW9tbXVfZGF0YSAqZGF0YSA9IGNvb2tpZTsNCj4gQEAgLTE5Myw2ICsyMDcsMTEg
QEAgc3RhdGljIHZvaWQgbXRrX2lvbW11X3RsYl9mbHVzaF9yYW5nZV9zeW5jKHVuc2lnbmVkIGxv
bmcgaW92YSwgc2l6ZV90IHNpemUsDQo+ICAJdTMyIHRtcDsNCj4gIA0KPiAgCWZvcl9lYWNoX200
dShkYXRhKSB7DQo+ICsJCS8qIHNraXAgdGxiIGZsdXNoIHdoZW4gcG0gaXMgbm90IGFjdGl2ZSAq
Lw0KPiArCQlpZiAocG1fcnVudGltZV9lbmFibGVkKGRhdGEtPmRldikgJiYNCj4gKwkJICAgICFw
bV9ydW50aW1lX2FjdGl2ZShkYXRhLT5kZXYpKQ0KPiArCQkJY29udGludWU7DQo+ICsNCj4gIAkJ
c3Bpbl9sb2NrX2lycXNhdmUoJmRhdGEtPnRsYl9sb2NrLCBmbGFncyk7DQo+ICAJCXdyaXRlbF9y
ZWxheGVkKEZfSU5WTERfRU4xIHwgRl9JTlZMRF9FTjAsDQo+ICAJCQkgICAgICAgZGF0YS0+YmFz
ZSArIGRhdGEtPnBsYXRfZGF0YS0+aW52X3NlbF9yZWcpOw0KPiBAQCAtMzc3LDE1ICszOTYsMjAg
QEAgc3RhdGljIGludCBtdGtfaW9tbXVfYXR0YWNoX2RldmljZShzdHJ1Y3QgaW9tbXVfZG9tYWlu
ICpkb21haW4sDQo+ICB7DQo+ICAJc3RydWN0IG10a19pb21tdV9kYXRhICpkYXRhID0gZGV2X2lv
bW11X3ByaXZfZ2V0KGRldik7DQo+ICAJc3RydWN0IG10a19pb21tdV9kb21haW4gKmRvbSA9IHRv
X210a19kb21haW4oZG9tYWluKTsNCj4gKwlpbnQgcmV0Ow0KPiAgDQo+ICAJaWYgKCFkYXRhKQ0K
PiAgCQlyZXR1cm4gLUVOT0RFVjsNCj4gIA0KPiAgCS8qIFVwZGF0ZSB0aGUgcGd0YWJsZSBiYXNl
IGFkZHJlc3MgcmVnaXN0ZXIgb2YgdGhlIE00VSBIVyAqLw0KPiAgCWlmICghZGF0YS0+bTR1X2Rv
bSkgew0KPiArCQlyZXQgPSBtdGtfaW9tbXVfcnBtX2dldChkZXYpOw0KPiArCQlpZiAocmV0IDwg
MCkNCj4gKwkJCXJldHVybiByZXQ7DQo+ICAJCWRhdGEtPm00dV9kb20gPSBkb207DQo+ICAJCXdy
aXRlbChkb20tPmNmZy5hcm1fdjdzX2NmZy50dGJyICYgTU1VX1BUX0FERFJfTUFTSywNCj4gIAkJ
ICAgICAgIGRhdGEtPmJhc2UgKyBSRUdfTU1VX1BUX0JBU0VfQUREUik7DQo+ICsJCW10a19pb21t
dV9ycG1fcHV0KGRldik7DQo+ICAJfQ0KPiAgDQo+ICAJbXRrX2lvbW11X2NvbmZpZyhkYXRhLCBk
ZXYsIHRydWUpOw0KPiBAQCAtNTQzLDEwICs1NjcsMTQgQEAgc3RhdGljIGludCBtdGtfaW9tbXVf
aHdfaW5pdChjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEpDQo+ICAJdTMyIHJlZ3Zh
bDsNCj4gIAlpbnQgcmV0Ow0KPiAgDQo+IC0JcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGRhdGEt
PmJjbGspOw0KPiAtCWlmIChyZXQpIHsNCj4gLQkJZGV2X2VycihkYXRhLT5kZXYsICJGYWlsZWQg
dG8gZW5hYmxlIGlvbW11IGJjbGsoJWQpXG4iLCByZXQpOw0KPiAtCQlyZXR1cm4gcmV0Ow0KPiAr
CS8qIGJjbGsgd2lsbCBiZSBlbmFibGVkIGluIHBtIGNhbGxiYWNrIGluIHBvd2VyLWRvbWFpbiBj
YXNlLiAqLw0KPiArCWlmICghcG1fcnVudGltZV9lbmFibGVkKGRhdGEtPmRldikpIHsNCj4gKwkJ
cmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGRhdGEtPmJjbGspOw0KPiArCQlpZiAocmV0KSB7DQo+
ICsJCQlkZXZfZXJyKGRhdGEtPmRldiwgIkZhaWxlZCB0byBlbmFibGUgaW9tbXUgYmNsayglZClc
biIsDQo+ICsJCQkJcmV0KTsNCj4gKwkJCXJldHVybiByZXQ7DQo+ICsJCX0NCj4gIAl9DQo+ICAN
Cj4gIAlpZiAoZGF0YS0+cGxhdF9kYXRhLT5tNHVfcGxhdCA9PSBNNFVfTVQ4MTczKSB7DQo+IEBA
IC03MjgsNyArNzU2LDE1IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICANCj4gIAlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBk
YXRhKTsNCj4gIA0KPiArCWlmIChkZXYtPnBtX2RvbWFpbikNCj4gKwkJcG1fcnVudGltZV9lbmFi
bGUoZGV2KTsNCg0KaGkgeW9uZywNCg0KSWYgeW91IHB1dCAicG1fcnVudGltZV9lbmFibGUiIGhl
cmUsIGl0IG1heWJlIG5vdCBkZXZpY2VfbGluayB3aXRoDQpzbWlfY29tbW9uIGZvciBwcmV2aW91
cyBwYXRjaDogDQppZihpIHx8ICFwbV9ydW50aW1lX2VuYWJsZWQoZGV2KSkNCiAgICBjb250aW51
ZTsNCg0KV2hldGhlciBwdXQgaXQgdXAgZnJvbnQ/DQoNCmJlc3QgcmVnYXJkcywNCmNoYW8NCg0K
PiArDQo+ICsJcmV0ID0gbXRrX2lvbW11X3JwbV9nZXQoZGV2KTsNCj4gKwlpZiAocmV0IDwgMCkN
Cj4gKwkJcmV0dXJuIHJldDsNCj4gKw0KPiAgCXJldCA9IG10a19pb21tdV9od19pbml0KGRhdGEp
Ow0KPiArCW10a19pb21tdV9ycG1fcHV0KGRldik7DQo+ICAJaWYgKHJldCkNCj4gIAkJcmV0dXJu
IHJldDsNCj4gIA0KPiBAQCAtODAxLDYgKzgzNywxMCBAQCBzdGF0aWMgaW50IF9fbWF5YmVfdW51
c2VkIG10a19pb21tdV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgCQlkZXZfZXJyKGRh
dGEtPmRldiwgIkZhaWxlZCB0byBlbmFibGUgY2xrKCVkKSBpbiByZXN1bWVcbiIsIHJldCk7DQo+
ICAJCXJldHVybiByZXQ7DQo+ICAJfQ0KPiArDQo+ICsJLyogQXZvaWQgZmlyc3QgcmVzdW1lIHRv
IGFmZmVjdCB0aGUgZGVmYXVsdCB2YWx1ZSBvZiByZWdpc3RlcnMgYmVsb3cuICovDQo+ICsJaWYg
KCFtNHVfZG9tKQ0KPiArCQlyZXR1cm4gMDsNCj4gIAl3cml0ZWxfcmVsYXhlZChyZWctPndyX2xl
bl9jdHJsLCBiYXNlICsgUkVHX01NVV9XUl9MRU5fQ1RSTCk7DQo+ICAJd3JpdGVsX3JlbGF4ZWQo
cmVnLT5taXNjX2N0cmwsIGJhc2UgKyBSRUdfTU1VX01JU0NfQ1RSTCk7DQo+ICAJd3JpdGVsX3Jl
bGF4ZWQocmVnLT5kY21fZGlzLCBiYXNlICsgUkVHX01NVV9EQ01fRElTKTsNCj4gQEAgLTgwOSwx
MyArODQ5LDEzIEBAIHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgbXRrX2lvbW11X3Jlc3VtZShz
dHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAJd3JpdGVsX3JlbGF4ZWQocmVnLT5pbnRfbWFpbl9jb250
cm9sLCBiYXNlICsgUkVHX01NVV9JTlRfTUFJTl9DT05UUk9MKTsNCj4gIAl3cml0ZWxfcmVsYXhl
ZChyZWctPml2cnBfcGFkZHIsIGJhc2UgKyBSRUdfTU1VX0lWUlBfUEFERFIpOw0KPiAgCXdyaXRl
bF9yZWxheGVkKHJlZy0+dmxkX3BhX3JuZywgYmFzZSArIFJFR19NTVVfVkxEX1BBX1JORyk7DQo+
IC0JaWYgKG00dV9kb20pDQo+IC0JCXdyaXRlbChtNHVfZG9tLT5jZmcuYXJtX3Y3c19jZmcudHRi
ciAmIE1NVV9QVF9BRERSX01BU0ssDQo+IC0JCSAgICAgICBiYXNlICsgUkVHX01NVV9QVF9CQVNF
X0FERFIpOw0KPiArCXdyaXRlbChtNHVfZG9tLT5jZmcuYXJtX3Y3c19jZmcudHRiciAmIE1NVV9Q
VF9BRERSX01BU0ssDQo+ICsJICAgICAgIGJhc2UgKyBSRUdfTU1VX1BUX0JBU0VfQUREUik7DQo+
ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29w
cyBtdGtfaW9tbXVfcG1fb3BzID0gew0KPiArCVNFVF9SVU5USU1FX1BNX09QUyhtdGtfaW9tbXVf
c3VzcGVuZCwgbXRrX2lvbW11X3Jlc3VtZSwgTlVMTCkNCj4gIAlTRVRfTk9JUlFfU1lTVEVNX1NM
RUVQX1BNX09QUyhtdGtfaW9tbXVfc3VzcGVuZCwgbXRrX2lvbW11X3Jlc3VtZSkNCj4gIH07DQo+
ICANCg0K

