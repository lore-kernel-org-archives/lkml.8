Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78877C2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 05:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51BE921D91
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 05:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uf+XpTVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgDQFe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 01:34:57 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:24169 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725298AbgDQFe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 01:34:57 -0400
X-UUID: c9a7a2fb22524b9b862c1592da84e80e-20200417
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=bUFVZsbh1IFtMkOupYY4so6J8bYhLyH6LTR/8vJHYYg=;
        b=uf+XpTVjXJS+lrsK/5Qf5Z0yXIvGYvYw932ay1v4cGU/vHmZOADuSKTptFKEtl8pnz7bRBa6nC9XNtEdKM4CYsyXjPK3Zbg1GBalU6HFmxKEfyvbPX7T+HDqIBYsOqACe27O+bX6DGjhHh1Vo2fCgwGN5niziDLsmJMUpSF/kKQ=;
X-UUID: c9a7a2fb22524b9b862c1592da84e80e-20200417
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 886313153; Fri, 17 Apr 2020 13:34:50 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 17 Apr
 2020 13:34:47 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Apr 2020 13:34:47 +0800
Message-ID: <1587101661.28772.40.camel@mhfsdcap03>
Subject: Re: [PATCH 2/2] phy: phy-mtk-tphy: introduce force_vbus for u2 phy
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Macpaul Lin <macpaul.lin@mediatek.com>
CC:     Min Guo <min.Guo@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>
Date:   Fri, 17 Apr 2020 13:34:21 +0800
In-Reply-To: <1587100986-3104-2-git-send-email-macpaul.lin@mediatek.com>
References: <1587100986-3104-1-git-send-email-macpaul.lin@mediatek.com>
         <1587100986-3104-2-git-send-email-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: BF05952D618A127CD5818E03CF14DCD593C923CD996704F9E83F26F467CE44782000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFjcGF1bCwNCg0KT24gRnJpLCAyMDIwLTA0LTE3IGF0IDEzOjIzICswODAwLCBNYWNwYXVs
IExpbiB3cm90ZToNCj4gRm9yIHNvbWUgcGxhdGZvcm1zLCB0aGV5IGRvbid0IGhhdmUgdmJ1cyBw
aW4gY29ubmVjdGlvbiBiZXR3ZWVuIHVzYiBwaHkgYW5kDQo+IG1hYy4gSGVuY2Ugd2UgbmVlZCB0
byBjb250cm9sIGZvcmNlX3ZidXMgcmVsYXRlZCByZWdpc3RlcnMgdG8ga2VlcCBoYXJkd2FyZQ0K
PiB3b3JrcyBub3JtYWwuDQo+IFRoaXMgcGF0Y2ggYWRkIGNvcnJlc3BvbmRpbmcgYmVoYXZpb3Ig
b2YgZm9yY2UgdmJ1cyBpbiB1MiBwaHkgcmVsYXRlZA0KPiBmdW5jdGlvbnMuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBNYWNwYXVsIExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KTkFDSywg
SSB0cmllZCB0byBzdXBwb3J0IGl0IGVhcmx5LCBidXQgZm91bmQgdGhpcyB3aWxsIGNhdXNlIHNv
bWUgaXNzdWUNCmZvciBTUy9TU1AgZGV2aWNlIG9ubHkgbW9kZSwgc28gcGxlYXNlIGFiYW5kb24g
dGhpcyBwYXRjaCwgdGhhbmtzDQoNCg0KPiAtLS0NCj4gIGRyaXZlcnMvcGh5L21lZGlhdGVrL3Bo
eS1tdGstdHBoeS5jIHwgMTYgKysrKysrKysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE1
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3BoeS9tZWRpYXRlay9waHktbXRrLXRwaHkuYyBiL2RyaXZlcnMvcGh5L21lZGlhdGVrL3BoeS1t
dGstdHBoeS5jDQo+IGluZGV4IGNkYmNjNDlmNzExNS4uNDZmMGZlYTE3NWU1IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLXRwaHkuYw0KPiArKysgYi9kcml2ZXJz
L3BoeS9tZWRpYXRlay9waHktbXRrLXRwaHkuYw0KPiBAQCAtOTksNiArOTksNyBAQA0KPiAgDQo+
ICAjZGVmaW5lIFUzUF9VMlBIWURUTTEJCTB4MDZDDQo+ICAjZGVmaW5lIFAyQ19SR19VQVJUX0VO
CQkJQklUKDE2KQ0KPiArI2RlZmluZSBQMkNfRk9SQ0VfVkJVU1ZBTElECQlCSVQoMTMpDQo+ICAj
ZGVmaW5lIFAyQ19GT1JDRV9JRERJRwkJQklUKDkpDQo+ICAjZGVmaW5lIFAyQ19SR19WQlVTVkFM
SUQJCUJJVCg1KQ0KPiAgI2RlZmluZSBQMkNfUkdfU0VTU0VORAkJCUJJVCg0KQ0KPiBAQCAtMzE4
LDYgKzMxOSw3IEBAIHN0cnVjdCBtdGtfdHBoeSB7DQo+ICAJaW50IG5waHlzOw0KPiAgCWludCBz
cmNfcmVmX2NsazsgLyogTUhaLCByZWZlcmVuY2UgY2xvY2sgZm9yIHNsZXcgcmF0ZSBjYWxpYnJh
dGUgKi8NCj4gIAlpbnQgc3JjX2NvZWY7IC8qIGNvZWZmaWNpZW50IGZvciBzbGV3IHJhdGUgY2Fs
aWJyYXRlICovDQo+ICsJYm9vbCBmb3JjZV92YnVzOw0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIHZv
aWQgaHNfc2xld19yYXRlX2NhbGlicmF0ZShzdHJ1Y3QgbXRrX3RwaHkgKnRwaHksDQo+IEBAIC02
MTEsMTMgKzYxMywyMCBAQCBzdGF0aWMgdm9pZCB1Ml9waHlfaW5zdGFuY2Vfc2V0X21vZGUoc3Ry
dWN0IG10a190cGh5ICp0cGh5LA0KPiAgCXN3aXRjaCAobW9kZSkgew0KPiAgCWNhc2UgUEhZX01P
REVfVVNCX0RFVklDRToNCj4gIAkJdG1wIHw9IFAyQ19GT1JDRV9JRERJRyB8IFAyQ19SR19JRERJ
RzsNCj4gKwkJaWYgKHRwaHktPmZvcmNlX3ZidXMpDQo+ICsJCQl0bXAgfD0gUDJDX1JHX1ZCVVNW
QUxJRCB8IFAyQ19GT1JDRV9WQlVTVkFMSUQ7DQo+ICAJCWJyZWFrOw0KPiAgCWNhc2UgUEhZX01P
REVfVVNCX0hPU1Q6DQo+ICAJCXRtcCB8PSBQMkNfRk9SQ0VfSURESUc7DQo+IC0JCXRtcCAmPSB+
UDJDX1JHX0lERElHOw0KPiArCQlpZiAodHBoeS0+Zm9yY2VfdmJ1cykNCj4gKwkJCXRtcCAmPSB+
KFAyQ19SR19WQlVTVkFMSUQgfCBQMkNfRk9SQ0VfVkJVU1ZBTElEKTsNCj4gKwkJZWxzZQ0KPiAr
CQkJdG1wICY9IH5QMkNfUkdfSURESUc7DQo+ICAJCWJyZWFrOw0KPiAgCWNhc2UgUEhZX01PREVf
VVNCX09URzoNCj4gIAkJdG1wICY9IH4oUDJDX0ZPUkNFX0lERElHIHwgUDJDX1JHX0lERElHKTsN
Cj4gKwkJaWYgKHRwaHktPmZvcmNlX3ZidXMpDQo+ICsJCQl0bXAgJj0gfihQMkNfUkdfVkJVU1ZB
TElEIHwgUDJDX0ZPUkNFX1ZCVVNWQUxJRCk7DQo+ICAJCWJyZWFrOw0KPiAgCWRlZmF1bHQ6DQo+
ICAJCXJldHVybjsNCj4gQEAgLTExODcsNiArMTE5NiwxMSBAQCBzdGF0aWMgaW50IG10a190cGh5
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJCQlyZXR2YWwgPSBQVFJf
RVJSKGluc3RhbmNlLT5kYV9yZWZfY2xrKTsNCj4gIAkJCWdvdG8gcHV0X2NoaWxkOw0KPiAgCQl9
DQo+ICsNCj4gKwkJLyoNCj4gKwkJICogT24gc29tZSBwbGF0Zm9ybSwgdmJ1cyBpcyBkaXMtY29u
bmVjdGVkIGJldHdlZW4gUEhZIGFuZCBNQUMuDQo+ICsJCSAqLw0KPiArCQl0cGh5LT5mb3JjZV92
YnVzID0gZGV2aWNlX3Byb3BlcnR5X3JlYWRfYm9vbChkZXYsICJmb3JjZV92YnVzIik7DQo+ICAJ
fQ0KPiAgDQo+ICAJcHJvdmlkZXIgPSBkZXZtX29mX3BoeV9wcm92aWRlcl9yZWdpc3RlcihkZXYs
IG10a19waHlfeGxhdGUpOw0KDQo=

