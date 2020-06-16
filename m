Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFA4C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F6CF2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="X0s6uLih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgFPGKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:10:36 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:12501 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725775AbgFPGKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:10:35 -0400
X-UUID: 1626b7beed3549a1b48b01ff9235c2d0-20200616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=o0aNLsq8928JAJ6+k5VSSOBMViWOoytBxgKCL5V42kA=;
        b=X0s6uLihh9WJQAq/QIZNlCXHitKpRwdbPhnw+XF6brmzFjactGUBFSdTz53YEy3L3qchs5zE86v0IbjeH3h+t3Ly+/p92p9gxq+5yt37Y6249a1bxQxBk1VsP/LpQiE1Q6ErPQM54xRpKxC0JYJZ15Bdx6/c91S5+70LK+zMR1w=;
X-UUID: 1626b7beed3549a1b48b01ff9235c2d0-20200616
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1405085909; Tue, 16 Jun 2020 14:10:31 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 16 Jun 2020 14:10:26 +0800
Received: from [10.15.20.246] (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Jun 2020 14:10:28 +0800
Message-ID: <1592287811.29899.3.camel@mbjsdccf07>
Subject: Re: [PATCH v3 3/7] iommu/mediatek: Disable STANDARD_AXI_MODE in
 MISC_CTRL
From:   chao hao <Chao.Hao@mediatek.com>
To:     Yong Wu <yong.wu@mediatek.com>
CC:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        FY Yang <fy.yang@mediatek.com>, Jun Yan <jun.yan@mediatek.com>
Date:   Tue, 16 Jun 2020 14:10:11 +0800
In-Reply-To: <1590387275.13912.7.camel@mhfsdcap03>
References: <20200509083654.5178-1-chao.hao@mediatek.com>
         <20200509083654.5178-4-chao.hao@mediatek.com>
         <1590387275.13912.7.camel@mhfsdcap03>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA1LTI1IGF0IDE0OjE0ICswODAwLCBZb25nIFd1IHdyb3RlOg0KPiBPbiBT
YXQsIDIwMjAtMDUtMDkgYXQgMTY6MzYgKzA4MDAsIENoYW8gSGFvIHdyb3RlOg0KPiA+IEluIG9y
ZGVyIHRvIGltcHJvdmUgcGVyZm9ybWFuY2UsIHdlIGFsd2F5cyBkaXNhYmxlIFNUQU5EQVJEX0FY
SV9NT0RFIGluDQo+ID4gTUlTQ19DVFJMLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IENoYW8g
SGFvIDxjaGFvLmhhb0BtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvaW9tbXUv
bXRrX2lvbW11LmMgfCA4ICsrKysrKystDQo+ID4gIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11Lmgg
fCAxICsNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBiL2Ry
aXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPiBpbmRleCBlN2U3Yzc2OTVlZDEuLjllZGUzMjdh
NDE4ZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+ID4gKysr
IGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+IEBAIC00Miw2ICs0Miw4IEBADQo+ID4g
ICNkZWZpbmUgRl9JTlZMRF9FTjEJCQkJQklUKDEpDQo+ID4gIA0KPiA+ICAjZGVmaW5lIFJFR19N
TVVfTUlTQ19DVFJMCQkJMHgwNDgNCj4gPiArI2RlZmluZSBGX01NVV9TVEFOREFSRF9BWElfTU9E
RV9CSVQJCShCSVQoMykgfCBCSVQoMTkpKQ0KPiA+ICsNCj4gPiAgI2RlZmluZSBSRUdfTU1VX0RD
TV9ESVMJCQkJMHgwNTANCj4gPiAgDQo+ID4gICNkZWZpbmUgUkVHX01NVV9DVFJMX1JFRwkJCTB4
MTEwDQo+ID4gQEAgLTU4NSw3ICs1ODcsMTEgQEAgc3RhdGljIGludCBtdGtfaW9tbXVfaHdfaW5p
dChjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEpDQo+ID4gIAl9DQo+ID4gIAl3cml0
ZWxfcmVsYXhlZCgwLCBkYXRhLT5iYXNlICsgUkVHX01NVV9EQ01fRElTKTsNCj4gPiAgDQo+ID4g
LQlpZiAoZGF0YS0+cGxhdF9kYXRhLT5yZXNldF9heGkpIHsNCj4gPiArCWlmIChkYXRhLT5wbGF0
X2RhdGEtPmhhc19taXNjX2N0cmwpIHsNCj4gPiArCQlyZWd2YWwgPSByZWFkbF9yZWxheGVkKGRh
dGEtPmJhc2UgKyBSRUdfTU1VX01JU0NfQ1RSTCk7DQo+ID4gKwkJcmVndmFsICY9IH5GX01NVV9T
VEFOREFSRF9BWElfTU9ERV9CSVQ7DQo+ID4gKwkJd3JpdGVsX3JlbGF4ZWQocmVndmFsLCBkYXRh
LT5iYXNlICsgUkVHX01NVV9NSVNDX0NUUkwpOw0KPiA+ICsJfSBlbHNlIGlmIChkYXRhLT5wbGF0
X2RhdGEtPnJlc2V0X2F4aSkgew0KPiA+ICAJCS8qIFRoZSByZWdpc3RlciBpcyBjYWxsZWQgU1RB
TkRBUkRfQVhJX01PREUgaW4gdGhpcyBjYXNlICovDQo+ID4gIAkJd3JpdGVsX3JlbGF4ZWQoMCwg
ZGF0YS0+YmFzZSArIFJFR19NTVVfTUlTQ19DVFJMKTsNCj4gPiAgCX0NCj4gDQo+IA0KPiAweDQ4
IGlzIGVpdGhlciBTVEFOREFSRF9BWElfTU9ERSBvciBNSVNDX0NUUkwuDQo+IA0KPiBUaHVzLCAN
Cj4gDQo+IGlmIChkYXRhLT5wbGF0X2RhdGEtPnJlc2V0X2F4aSkgew0KPiAgICB4eHgNCj4gfSBl
bHNlIHsgIC8qIE1JU0NfQ1RSTCAqLw0KPiAgICB4eHgNCj4gfQ0KPiANCj4gTm8gbmVlZCBhZGQg
Imhhc19taXNjX2N0cmwiLg0KDQpUaGFua3MgZm9yIHlvdSBjb21tZW50Lg0KT25seSBtbV9pb21t
dS9tNHUgbmVlZHMgdG8gc2V0IE1JU0NfQ1RSTCByZWdpc3RlciBhbmQgYXB1X2lvbW11IGRvbid0
DQpuZWVkIHRvIHNldCBpdC4gU28gSSB0aGluayB3ZSBuZWVkIHRvIHVzZSBoYXNfbWlzY19jdHJs
IHRvIGRpc3Rpbmd1aXNoDQppdC4NCg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21t
dS9tdGtfaW9tbXUuaCBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCj4gPiBpbmRleCAxYjZl
YTgzOWI5MmMuLmQ3MTFhYzYzMDAzNyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L210
a19pb21tdS5oDQo+ID4gKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KPiA+IEBAIC00
MCw2ICs0MCw3IEBAIHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIHsNCj4gPiAgDQo+ID4gIAkv
KiBIVyB3aWxsIHVzZSB0aGUgRU1JIGNsb2NrIGlmIHRoZXJlIGlzbid0IHRoZSAiYmNsayIuICov
DQo+ID4gIAlib29sICAgICAgICAgICAgICAgIGhhc19iY2xrOw0KPiA+ICsJYm9vbAkJICAgIGhh
c19taXNjX2N0cmw7DQo+ID4gIAlib29sICAgICAgICAgICAgICAgIGhhc192bGRfcGFfcm5nOw0K
PiA+ICAJYm9vbCAgICAgICAgICAgICAgICByZXNldF9heGk7DQo+ID4gIAl1bnNpZ25lZCBjaGFy
ICAgICAgIGxhcmJpZF9yZW1hcFtNVEtfTEFSQl9OUl9NQVhdOw0KPiANCj4gDQoNCg==

