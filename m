Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6170C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCE9B21924
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MHeeNIj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgFRJev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:34:51 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:44297 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728568AbgFRJeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:34:50 -0400
X-UUID: 855350d237af447598937a20df6f1057-20200618
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=fazQeAs8inAvGwYcQXqBGXqOlhYwCeTQdth0t/3tLpc=;
        b=MHeeNIj++emO1PxnCKYQiheDFmpZ4QBACfg0h4/OsDUonE38uDizhI+ibfWfeYHrZWzdKmqjA4pspetmXciZRh0aMpC3nZVDYa6Z/T8lj5eJdfJoht83VIS8lU3VV4mz8emEXDFGXanQq7R5q4LS8CnMUfrDFmNHFsNV7hCie9k=;
X-UUID: 855350d237af447598937a20df6f1057-20200618
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1739908511; Thu, 18 Jun 2020 17:34:39 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 18 Jun
 2020 17:34:36 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Jun 2020 17:34:33 +0800
Message-ID: <1592472725.20080.12.camel@mhfsdcap03>
Subject: Re: [PATCH v4 06/17] media: mtk-jpeg: Get rid of
 mtk_smi_larb_get/put
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rick Chang <rick.chang@mediatek.com>
CC:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        "Evan Green" <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Tomasz Figa" <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>, <anan.sun@mediatek.com>,
        <cui.zhang@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>, <eizan@chromium.org>,
        <acourbot@chromium.org>, Rick Chang <rick.chang@mediatek.com>,
        <xia.jiang@mediatek.com>
Date:   Thu, 18 Jun 2020 17:32:05 +0800
In-Reply-To: <1590826218-23653-7-git-send-email-yong.wu@mediatek.com>
References: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
         <1590826218-23653-7-git-send-email-yong.wu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: EAA0222707355DB3D9C41720DD63D68CCECEA4A8CC20861737BF3012552CC6C52000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KyBSaWNrDQoNCk9uIFNhdCwgMjAyMC0wNS0zMCBhdCAxNjoxMCArMDgwMCwgWW9uZyBXdSB3cm90
ZToNCj4gTWVkaWFUZWsgSU9NTVUgaGFzIGFscmVhZHkgYWRkZWQgZGV2aWNlX2xpbmsgYmV0d2Vl
biB0aGUgY29uc3VtZXINCj4gYW5kIHNtaS1sYXJiIGRldmljZS4gSWYgdGhlIGpwZyBkZXZpY2Ug
Y2FsbCB0aGUgcG1fcnVudGltZV9nZXRfc3luYywNCj4gdGhlIHNtaS1sYXJiJ3MgcG1fcnVudGlt
ZV9nZXRfc3luYyBhbHNvIGJlIGNhbGxlZCBhdXRvbWF0aWNhbGx5Lg0KPiANCj4gQ0M6IFJpY2sg
Q2hhbmcgPHJpY2suY2hhbmdAbWVkaWF0ZWsuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBZb25nIFd1
IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEV2YW4gR3JlZW4gPGV2Z3Jl
ZW5AY2hyb21pdW0ub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLWpw
ZWcvbXRrX2pwZWdfY29yZS5jIHwgMjIgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgZHJpdmVy
cy9tZWRpYS9wbGF0Zm9ybS9tdGstanBlZy9tdGtfanBlZ19jb3JlLmggfCAgMiAtLQ0KPiAgMiBm
aWxlcyBjaGFuZ2VkLCAyNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L21lZGlhL3BsYXRmb3JtL210ay1qcGVnL210a19qcGVnX2NvcmUuYyBiL2RyaXZlcnMvbWVkaWEv
cGxhdGZvcm0vbXRrLWpwZWcvbXRrX2pwZWdfY29yZS5jDQo+IGluZGV4IGY4MmE4MWEuLjIxZmJh
NmYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLWpwZWcvbXRrX2pw
ZWdfY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLWpwZWcvbXRrX2pw
ZWdfY29yZS5jDQo+IEBAIC0yMSw3ICsyMSw2IEBADQo+ICAjaW5jbHVkZSA8bWVkaWEvdjRsMi1p
b2N0bC5oPg0KPiAgI2luY2x1ZGUgPG1lZGlhL3ZpZGVvYnVmMi1jb3JlLmg+DQo+ICAjaW5jbHVk
ZSA8bWVkaWEvdmlkZW9idWYyLWRtYS1jb250aWcuaD4NCj4gLSNpbmNsdWRlIDxzb2MvbWVkaWF0
ZWsvc21pLmg+DQo+ICANCj4gICNpbmNsdWRlICJtdGtfanBlZ19ody5oIg0KPiAgI2luY2x1ZGUg
Im10a19qcGVnX2NvcmUuaCINCj4gQEAgLTg5MywxMSArODkyLDYgQEAgc3RhdGljIGludCBtdGtf
anBlZ19xdWV1ZV9pbml0KHZvaWQgKnByaXYsIHN0cnVjdCB2YjJfcXVldWUgKnNyY192cSwNCj4g
IA0KPiAgc3RhdGljIHZvaWQgbXRrX2pwZWdfY2xrX29uKHN0cnVjdCBtdGtfanBlZ19kZXYgKmpw
ZWcpDQo+ICB7DQo+IC0JaW50IHJldDsNCj4gLQ0KPiAtCXJldCA9IG10a19zbWlfbGFyYl9nZXQo
anBlZy0+bGFyYik7DQo+IC0JaWYgKHJldCkNCj4gLQkJZGV2X2VycihqcGVnLT5kZXYsICJtdGtf
c21pX2xhcmJfZ2V0IGxhcmJ2ZGVjIGZhaWwgJWRcbiIsIHJldCk7DQo+ICAJY2xrX3ByZXBhcmVf
ZW5hYmxlKGpwZWctPmNsa19qZGVjX3NtaSk7DQo+ICAJY2xrX3ByZXBhcmVfZW5hYmxlKGpwZWct
PmNsa19qZGVjKTsNCj4gIH0NCj4gQEAgLTkwNiw3ICs5MDAsNiBAQCBzdGF0aWMgdm9pZCBtdGtf
anBlZ19jbGtfb2ZmKHN0cnVjdCBtdGtfanBlZ19kZXYgKmpwZWcpDQo+ICB7DQo+ICAJY2xrX2Rp
c2FibGVfdW5wcmVwYXJlKGpwZWctPmNsa19qZGVjKTsNCj4gIAljbGtfZGlzYWJsZV91bnByZXBh
cmUoanBlZy0+Y2xrX2pkZWNfc21pKTsNCj4gLQltdGtfc21pX2xhcmJfcHV0KGpwZWctPmxhcmIp
Ow0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgaXJxcmV0dXJuX3QgbXRrX2pwZWdfZGVjX2lycShpbnQg
aXJxLCB2b2lkICpwcml2KQ0KPiBAQCAtMTA1MSwyMSArMTA0NCw2IEBAIHN0YXRpYyBpbnQgbXRr
X2pwZWdfcmVsZWFzZShzdHJ1Y3QgZmlsZSAqZmlsZSkNCj4gIA0KPiAgc3RhdGljIGludCBtdGtf
anBlZ19jbGtfaW5pdChzdHJ1Y3QgbXRrX2pwZWdfZGV2ICpqcGVnKQ0KPiAgew0KPiAtCXN0cnVj
dCBkZXZpY2Vfbm9kZSAqbm9kZTsNCj4gLQlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2Ow0K
PiAtDQo+IC0Jbm9kZSA9IG9mX3BhcnNlX3BoYW5kbGUoanBlZy0+ZGV2LT5vZl9ub2RlLCAibWVk
aWF0ZWssbGFyYiIsIDApOw0KPiAtCWlmICghbm9kZSkNCj4gLQkJcmV0dXJuIC1FSU5WQUw7DQo+
IC0JcGRldiA9IG9mX2ZpbmRfZGV2aWNlX2J5X25vZGUobm9kZSk7DQo+IC0JaWYgKFdBUk5fT04o
IXBkZXYpKSB7DQo+IC0JCW9mX25vZGVfcHV0KG5vZGUpOw0KPiAtCQlyZXR1cm4gLUVJTlZBTDsN
Cj4gLQl9DQo+IC0Jb2Zfbm9kZV9wdXQobm9kZSk7DQo+IC0NCj4gLQlqcGVnLT5sYXJiID0gJnBk
ZXYtPmRldjsNCj4gLQ0KPiAgCWpwZWctPmNsa19qZGVjID0gZGV2bV9jbGtfZ2V0KGpwZWctPmRl
diwgImpwZ2RlYyIpOw0KPiAgCWlmIChJU19FUlIoanBlZy0+Y2xrX2pkZWMpKQ0KPiAgCQlyZXR1
cm4gUFRSX0VSUihqcGVnLT5jbGtfamRlYyk7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlh
L3BsYXRmb3JtL210ay1qcGVnL210a19qcGVnX2NvcmUuaCBiL2RyaXZlcnMvbWVkaWEvcGxhdGZv
cm0vbXRrLWpwZWcvbXRrX2pwZWdfY29yZS5oDQo+IGluZGV4IDk5OWJkMTQuLjg1Nzk0OTQgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLWpwZWcvbXRrX2pwZWdfY29y
ZS5oDQo+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLWpwZWcvbXRrX2pwZWdfY29y
ZS5oDQo+IEBAIC00Nyw3ICs0Nyw2IEBAIGVudW0gbXRrX2pwZWdfY3R4X3N0YXRlIHsNCj4gICAq
IEBkZWNfcmVnX2Jhc2U6CUpQRUcgcmVnaXN0ZXJzIG1hcHBpbmcNCj4gICAqIEBjbGtfamRlYzoJ
CUpQRUcgaHcgd29ya2luZyBjbG9jaw0KPiAgICogQGNsa19qZGVjX3NtaToJSlBFRyBTTUkgYnVz
IGNsb2NrDQo+IC0gKiBAbGFyYjoJCVNNSSBkZXZpY2UNCj4gICAqLw0KPiAgc3RydWN0IG10a19q
cGVnX2RldiB7DQo+ICAJc3RydWN0IG11dGV4CQlsb2NrOw0KPiBAQCAtNjEsNyArNjAsNiBAQCBz
dHJ1Y3QgbXRrX2pwZWdfZGV2IHsNCj4gIAl2b2lkIF9faW9tZW0JCSpkZWNfcmVnX2Jhc2U7DQo+
ICAJc3RydWN0IGNsawkJKmNsa19qZGVjOw0KPiAgCXN0cnVjdCBjbGsJCSpjbGtfamRlY19zbWk7
DQo+IC0Jc3RydWN0IGRldmljZQkJKmxhcmI7DQo+ICB9Ow0KPiAgDQo+ICAvKioNCg0K

