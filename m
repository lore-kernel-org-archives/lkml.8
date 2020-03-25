Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E39C54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 200052070A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="X85t4PCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgCYIN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:13:27 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:27755 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726073AbgCYIN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:13:26 -0400
X-UUID: bebe5870d7f74a618749838f14b263ff-20200325
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=RBJRLpRZWMcTql+U1JsklmMlj2x8JdOtzIR7NmCLfes=;
        b=X85t4PCQMdOyXQHLbV5uy/GiOgzvbVBkXzHxq6c+pgQaYfrZ/0qqUXi3njade9uC3SgFPakp+wSbOTkKNACrhm6sLBn7uF1YEYdlZwO4ilF2pluj5lOVyP/9FGxkjwEitMac2gcNVDicPcNLiuOkXVHMiVeyWjK3hnWUOA3oECc=;
X-UUID: bebe5870d7f74a618749838f14b263ff-20200325
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <hanks.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1495431; Wed, 25 Mar 2020 16:13:21 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 25 Mar 2020 16:13:19 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 25 Mar 2020 16:13:19 +0800
From:   Hanks Chen <hanks.chen@mediatek.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>
CC:     Andy Teng <andy.teng@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Subject: [PATCH v4 0/6] Add basic SoC Support for Mediatek MT6779 SoC
Date:   Wed, 25 Mar 2020 16:12:38 +0800
Message-ID: <1585123964-10791-1-git-send-email-hanks.chen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlIHNpbmNlIHY0Og0KMS4gZml4IGZvcm1hdCBvZiBwaW5jdHJsIGJpbmRpbmdzDQoNCg0K
Q2hhbmdlIHNpbmNlIHYzOg0KMS4gYWRkIGJpbmRpbmdzIGZvciAibWVkaWF0ZWssbXQ2Nzc5LXBp
bmN0cmwiDQoyLiBhZGQgc29tZSBjb21tZW50cyBpbnRvIHRoZSBjb2RlIChlLmcuIHZpcnR1YWwg
Z3BpbyAuLi4pIDMuIGFkZCBBY2tlZC1ieSB0YWdzIDQuIGFkZCBwbXUgbm9kZSBpbnRvIGR0cyA1
LiBzdXBwb3J0IHBwaSBwYXJ0aXRpb24gYW5kIGZpeCBiYXNlIGFkZHJlc3MgaW4gZ2ljIG5vZGUg
b2YgZHRzDQoNCltub3RlXQ0KWzFdIG5lZWQgYmluZGluZ3MgZm9yICJhcm0sY29ydGV4LWE3NSIg
aW4gcGF0Y2ggNg0KPiBBbHJlYWR5IGluIFJvYidzIHRyZWUgaGVyZToNCg0KDQpDaGFuZ2Ugc2lu
Y2UgdjI6DQoxLiBhZGQgUmV2aWV3ZWQtYnkgdGFncw0KMi4gZml4IGNoZWNrcGF0Y2ggd2Fybmlu
Z3Mgd2l0aCBzdHJpY3QgbGV2ZWwNCg0KDQpDaGFuZ2Ugc2luY2UgdjE6DQpmaXJzdCBwYXRjaHNl
dA0KDQoNCg0KDQpBbmR5IFRlbmcgKDEpOg0KICBkdC1iaW5kaW5nczogcGluY3RybDogYWRkIGJp
bmRpbmdzIGZvciBNZWRpYVRlayBNVDY3NzkgU29DDQoNCkhhbmtzIENoZW4gKDUpOg0KICBwaW5j
dHJsOiBtZWRpYXRlazogdXBkYXRlIHBpbm11eCBkZWZpbml0aW9ucyBmb3IgbXQ2Nzc5DQogIHBp
bmN0cmw6IG1lZGlhdGVrOiBhdm9pZCB2aXJ0dWFsIGdwaW8gdHJ5aW5nIHRvIHNldCByZWcNCiAg
cGluY3RybDogbWVkaWF0ZWs6IGFkZCBwaW5jdHJsIHN1cHBvcnQgZm9yIE1UNjc3OSBTb0MNCiAg
cGluY3RybDogbWVkaWF0ZWs6IGFkZCBtdDY3NzkgZWludCBzdXBwb3J0DQogIGFybTY0OiBkdHM6
IGFkZCBkdHMgbm9kZXMgZm9yIE1UNjc3OQ0KDQogLi4uL2JpbmRpbmdzL3BpbmN0cmwvbWVkaWF0
ZWssbXQ2Nzc5LXBpbmN0cmwueWFtbCAgfCAgMjA4ICsrDQogYXJjaC9hcm02NC9ib290L2R0cy9t
ZWRpYXRlay9NYWtlZmlsZSAgICAgICAgICAgICAgfCAgICAxICsNCiBhcmNoL2FybTY0L2Jvb3Qv
ZHRzL21lZGlhdGVrL210Njc3OS1ldmIuZHRzICAgICAgICB8ICAgMzEgKw0KIGFyY2gvYXJtNjQv
Ym9vdC9kdHMvbWVkaWF0ZWsvbXQ2Nzc5LmR0c2kgICAgICAgICAgIHwgIDI2NSArKysNCiBkcml2
ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvS2NvbmZpZyAgICAgICAgICAgICAgICAgICB8ICAgIDcgKw0K
IGRyaXZlcnMvcGluY3RybC9tZWRpYXRlay9NYWtlZmlsZSAgICAgICAgICAgICAgICAgIHwgICAg
MSArDQogZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3BpbmN0cmwtbXQ2Nzc5LmMgICAgICAgICAg
fCAgNzgzICsrKysrKysrDQogZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3BpbmN0cmwtbXRrLWNv
bW1vbi12Mi5jICAgfCAgIDI4ICsNCiBkcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1t
dGstY29tbW9uLXYyLmggICB8ICAgIDEgKw0KIGRyaXZlcnMvcGluY3RybC9tZWRpYXRlay9waW5j
dHJsLW10ay1tdDY3NzkuaCAgICAgIHwgMjA4NSArKysrKysrKysrKysrKysrKysrKw0KIGRyaXZl
cnMvcGluY3RybC9tZWRpYXRlay9waW5jdHJsLXBhcmlzLmMgICAgICAgICAgIHwgICAgNyArDQog
aW5jbHVkZS9kdC1iaW5kaW5ncy9waW5jdHJsL210Njc3OS1waW5mdW5jLmggICAgICAgfCAxMjQy
ICsrKysrKysrKysrKw0KIDEyIGZpbGVzIGNoYW5nZWQsIDQ2NTkgaW5zZXJ0aW9ucygrKQ0KIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGluY3Ry
bC9tZWRpYXRlayxtdDY3NzktcGluY3RybC55YW1sDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gv
YXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ2Nzc5LWV2Yi5kdHMNCiBjcmVhdGUgbW9kZSAxMDA2
NDQgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDY3NzkuZHRzaQ0KIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBkcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1tdDY3NzkuYw0KIGNyZWF0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1tdGstbXQ2Nzc5
LmgNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9kdC1iaW5kaW5ncy9waW5jdHJsL210Njc3
OS1waW5mdW5jLmg=

