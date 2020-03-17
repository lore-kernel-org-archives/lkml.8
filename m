Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D79C4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6828420757
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Da5NAWj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgCQOG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:06:57 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:37271 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726016AbgCQOG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:06:57 -0400
X-UUID: af9a83612fb74d998298334f2647494d-20200317
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=AGQJ9ca+jEWLEkXtTwRFZVcl4oKYY1P9wsWPmVMGq1o=;
        b=Da5NAWj8M1SschSHqYpWgQ8asn9BERoG2SvUFR7F6fDspg8jfNEZzTkbcuQCATlqwhINYt1AlWz9XOHiK3ffwxdCsA5VCy+hz1Gf+Uo8920Sw1Yn0clg2lbNmkguoarXlDcf3RcofurtyF7vzmptNWUp11k31Qp6al1u8DD6P7E=;
X-UUID: af9a83612fb74d998298334f2647494d-20200317
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <hanks.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 533329754; Tue, 17 Mar 2020 22:06:51 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 17 Mar 2020 22:05:49 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 17 Mar 2020 22:06:04 +0800
From:   Hanks Chen <hanks.chen@mediatek.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>
CC:     Andy Teng <andy.teng@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Subject: [PATCH v3 0/6] Add basic SoC Support for Mediatek MT6779 SoC
Date:   Tue, 17 Mar 2020 22:06:41 +0800
Message-ID: <1584454007-2115-1-git-send-email-hanks.chen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaHNldCBpcyBiYXNlZCBvbiB2NS42LXJjMS4gQmFzaWMgU29DIHN1cHBvcnQgZm9y
IHRoZSBuZXcgTWVkaWF0ZWsNClNvQywgTVQ2Nzc5LCB3aGljaCB0YXJnZXRzIGZvciBzbWFydHBo
b25lLg0KDQpJdCBwcm92aWRlcyBjY2YsIHBpbmN0cmwsIHVhcnQsIHRpbWVyLCBnaWMuLi5ldGMu
DQoNCkNoYW5nZSBIaXN0b3J5Og0KDQpDaGFuZ2Ugc2luY2UgdjM6DQoxLiBhZGQgYmluZGluZ3Mg
Zm9yICJtZWRpYXRlayxtdDY3NzktcGluY3RybCINCjIuIGFkZCBzb21lIGNvbW1lbnRzIGludG8g
dGhlIGNvZGUgKGUuZy4gdmlydHVhbCBncGlvIC4uLikNCjMuIGFkZCBBY2tlZC1ieSB0YWdzDQo0
LiBhZGQgcG11IG5vZGUgaW50byBkdHMNCjUuIHN1cHBvcnQgcHBpIHBhcnRpdGlvbiBhbmQgZml4
IGJhc2UgYWRkcmVzcyBpbiBnaWMgbm9kZSBvZiBkdHMNCg0KW25vdGVdDQpbMV0gbmVlZCBiaW5k
aW5ncyBmb3IgImFybSxjb3J0ZXgtYTc1IiBpbiBwYXRjaCA2DQo+IEFscmVhZHkgaW4gUm9iJ3Mg
dHJlZSBoZXJlOg0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVs
L2dpdC9yb2JoL2xpbnV4LmdpdC9jb21taXQvP2g9ZHQvbmV4dCZpZD01YzI2MTRlOTk1ZGUwN2I0
MWViMzU1MTU1ZWI1ZTBlM2Q1OTM3MThiDQoNCg0KQ2hhbmdlIHNpbmNlIHYyOg0KMS4gYWRkIFJl
dmlld2VkLWJ5IHRhZ3MNCjIuIGZpeCBjaGVja3BhdGNoIHdhcm5pbmdzIHdpdGggc3RyaWN0IGxl
dmVsDQoNCkNoYW5nZSBzaW5jZSB2MToNCmZpcnN0IHBhdGNoc2V0DQoNCg0KQW5keSBUZW5nICgx
KToNCiAgZHQtYmluZGluZ3M6IHBpbmN0cmw6IGFkZCBiaW5kaW5ncyBmb3IgTWVkaWFUZWsgTVQ2
Nzc5IFNvQw0KDQpIYW5rcyBDaGVuICg1KToNCiAgcGluY3RybDogbWVkaWF0ZWs6IHVwZGF0ZSBw
aW5tdXggZGVmaW5pdGlvbnMgZm9yIG10Njc3OQ0KICBwaW5jdHJsOiBtZWRpYXRlazogYXZvaWQg
dmlydHVhbCBncGlvIHRyeWluZyB0byBzZXQgcmVnDQogIHBpbmN0cmw6IG1lZGlhdGVrOiBhZGQg
cGluY3RybCBzdXBwb3J0IGZvciBNVDY3NzkgU29DDQogIHBpbmN0cmw6IG1lZGlhdGVrOiBhZGQg
bXQ2Nzc5IGVpbnQgc3VwcG9ydA0KICBhcm02NDogZHRzOiBhZGQgZHRzIG5vZGVzIGZvciBNVDY3
NzkNCg0KIC4uLi9iaW5kaW5ncy9waW5jdHJsL21lZGlhdGVrLG10Njc3OS1waW5jdHJsLnlhbWwg
IHwgIDIwOCArKw0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvTWFrZWZpbGUgICAgICAg
ICAgICAgIHwgICAgMSArDQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDY3NzktZXZi
LmR0cyAgICAgICAgfCAgIDMxICsNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210Njc3
OS5kdHNpICAgICAgICAgICB8ICAyNjUgKysrDQogZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL0tj
b25maWcgICAgICAgICAgICAgICAgICAgfCAgICA3ICsNCiBkcml2ZXJzL3BpbmN0cmwvbWVkaWF0
ZWsvTWFrZWZpbGUgICAgICAgICAgICAgICAgICB8ICAgIDEgKw0KIGRyaXZlcnMvcGluY3RybC9t
ZWRpYXRlay9waW5jdHJsLW10Njc3OS5jICAgICAgICAgIHwgIDc4MyArKysrKysrKw0KIGRyaXZl
cnMvcGluY3RybC9tZWRpYXRlay9waW5jdHJsLW10ay1jb21tb24tdjIuYyAgIHwgICAyOCArDQog
ZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3BpbmN0cmwtbXRrLWNvbW1vbi12Mi5oICAgfCAgICAx
ICsNCiBkcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1tdGstbXQ2Nzc5LmggICAgICB8
IDIwODUgKysrKysrKysrKysrKysrKysrKysNCiBkcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGlu
Y3RybC1wYXJpcy5jICAgICAgICAgICB8ICAgIDcgKw0KIGluY2x1ZGUvZHQtYmluZGluZ3MvcGlu
Y3RybC9tdDY3NzktcGluZnVuYy5oICAgICAgIHwgMTI0MiArKysrKysrKysrKysNCiAxMiBmaWxl
cyBjaGFuZ2VkLCA0NjU5IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BpbmN0cmwvbWVkaWF0ZWssbXQ2Nzc5LXBpbmN0
cmwueWFtbA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVr
L210Njc3OS1ldmIuZHRzDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMv
bWVkaWF0ZWsvbXQ2Nzc5LmR0c2kNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9waW5jdHJs
L21lZGlhdGVrL3BpbmN0cmwtbXQ2Nzc5LmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9w
aW5jdHJsL21lZGlhdGVrL3BpbmN0cmwtbXRrLW10Njc3OS5oDQogY3JlYXRlIG1vZGUgMTAwNjQ0
IGluY2x1ZGUvZHQtYmluZGluZ3MvcGluY3RybC9tdDY3NzktcGluZnVuYy5o

