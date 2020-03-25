Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7E0C54FD4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA63720714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GoWcF0zD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgCYJbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:31:48 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:64661 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726264AbgCYJbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:31:48 -0400
X-UUID: d4bc137d4f9d46b99969eaf8c30ff0c9-20200325
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=MZRE5IuUAHJ3uyH5dFlPu22uprTKmxEnYCiMJ+PTVw4=;
        b=GoWcF0zDhv9DsbKr+99AcB9XHJjYMjpCDUiSTrlU3JW6K7OZiH7+Ntpd7fGqFpyZ9o2cRiCxTZPTPOwAr2OVKb+VIbDzas9sr6MfwuURcuRDq0ugKqoh3vwug5f2yzRMsXrPLXCRYu58Z1TtjRVSTjHNp6ImdXcKiKhdJsmISSg=;
X-UUID: d4bc137d4f9d46b99969eaf8c30ff0c9-20200325
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <hanks.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 300832674; Wed, 25 Mar 2020 17:31:43 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 25 Mar 2020 17:31:41 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 25 Mar 2020 17:31:41 +0800
From:   Hanks Chen <hanks.chen@mediatek.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>
CC:     Andy Teng <andy.teng@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Subject: [PATCH v5 0/6] Add basic SoC Support for Mediatek MT6779 SoC
Date:   Wed, 25 Mar 2020 17:31:28 +0800
Message-ID: <1585128694-13881-1-git-send-email-hanks.chen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlIHNpbmNlIHY1Og0KMS4gcmVtb3ZlIHVubmVjZXNzYXJ5IHN0cmluZyBpbiBjb21taXQg
bWVzc2FnZQ0KDQoNCkNoYW5nZSBzaW5jZSB2NDoNCjEuIGZpeCBmb3JtYXQgb2YgcGluY3RybCBi
aW5kaW5ncw0KDQoNCkNoYW5nZSBzaW5jZSB2MzoNCjEuIGFkZCBiaW5kaW5ncyBmb3IgIm1lZGlh
dGVrLG10Njc3OS1waW5jdHJsIg0KMi4gYWRkIHNvbWUgY29tbWVudHMgaW50byB0aGUgY29kZSAo
ZS5nLiB2aXJ0dWFsIGdwaW8gLi4uKSAzLiBhZGQgQWNrZWQtYnkgdGFncyA0LiBhZGQgcG11IG5v
ZGUgaW50byBkdHMgNS4gc3VwcG9ydCBwcGkgcGFydGl0aW9uIGFuZCBmaXggYmFzZSBhZGRyZXNz
IGluIGdpYyBub2RlIG9mIGR0cw0KW25vdGVdDQpbMV0gbmVlZCBiaW5kaW5ncyBmb3IgImFybSxj
b3J0ZXgtYTc1IiBpbiBwYXRjaCA2DQo+IEFscmVhZHkgaW4gUm9iJ3MgdHJlZSBoZXJlOg0KDQoN
CkNoYW5nZSBzaW5jZSB2MjoNCjEuIGFkZCBSZXZpZXdlZC1ieSB0YWdzDQoyLiBmaXggY2hlY2tw
YXRjaCB3YXJuaW5ncyB3aXRoIHN0cmljdCBsZXZlbA0KDQoNCkNoYW5nZSBzaW5jZSB2MToNCmZp
cnN0IHBhdGNoc2V0DQoNCg0KQW5keSBUZW5nICgxKToNCiAgZHQtYmluZGluZ3M6IHBpbmN0cmw6
IGFkZCBiaW5kaW5ncyBmb3IgTWVkaWFUZWsgTVQ2Nzc5IFNvQw0KDQpIYW5rcyBDaGVuICg1KToN
CiAgcGluY3RybDogbWVkaWF0ZWs6IHVwZGF0ZSBwaW5tdXggZGVmaW5pdGlvbnMgZm9yIG10Njc3
OQ0KICBwaW5jdHJsOiBtZWRpYXRlazogYXZvaWQgdmlydHVhbCBncGlvIHRyeWluZyB0byBzZXQg
cmVnDQogIHBpbmN0cmw6IG1lZGlhdGVrOiBhZGQgcGluY3RybCBzdXBwb3J0IGZvciBNVDY3Nzkg
U29DDQogIHBpbmN0cmw6IG1lZGlhdGVrOiBhZGQgbXQ2Nzc5IGVpbnQgc3VwcG9ydA0KICBhcm02
NDogZHRzOiBhZGQgZHRzIG5vZGVzIGZvciBNVDY3NzkNCg0KIC4uLi9iaW5kaW5ncy9waW5jdHJs
L21lZGlhdGVrLG10Njc3OS1waW5jdHJsLnlhbWwgIHwgIDIwOCArKw0KIGFyY2gvYXJtNjQvYm9v
dC9kdHMvbWVkaWF0ZWsvTWFrZWZpbGUgICAgICAgICAgICAgIHwgICAgMSArDQogYXJjaC9hcm02
NC9ib290L2R0cy9tZWRpYXRlay9tdDY3NzktZXZiLmR0cyAgICAgICAgfCAgIDMxICsNCiBhcmNo
L2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210Njc3OS5kdHNpICAgICAgICAgICB8ICAyNjUgKysr
DQogZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL0tjb25maWcgICAgICAgICAgICAgICAgICAgfCAg
ICA3ICsNCiBkcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvTWFrZWZpbGUgICAgICAgICAgICAgICAg
ICB8ICAgIDEgKw0KIGRyaXZlcnMvcGluY3RybC9tZWRpYXRlay9waW5jdHJsLW10Njc3OS5jICAg
ICAgICAgIHwgIDc4MyArKysrKysrKw0KIGRyaXZlcnMvcGluY3RybC9tZWRpYXRlay9waW5jdHJs
LW10ay1jb21tb24tdjIuYyAgIHwgICAyOCArDQogZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3Bp
bmN0cmwtbXRrLWNvbW1vbi12Mi5oICAgfCAgICAxICsNCiBkcml2ZXJzL3BpbmN0cmwvbWVkaWF0
ZWsvcGluY3RybC1tdGstbXQ2Nzc5LmggICAgICB8IDIwODUgKysrKysrKysrKysrKysrKysrKysN
CiBkcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1wYXJpcy5jICAgICAgICAgICB8ICAg
IDcgKw0KIGluY2x1ZGUvZHQtYmluZGluZ3MvcGluY3RybC9tdDY3NzktcGluZnVuYy5oICAgICAg
IHwgMTI0MiArKysrKysrKysrKysNCiAxMiBmaWxlcyBjaGFuZ2VkLCA0NjU5IGluc2VydGlvbnMo
KykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3BpbmN0cmwvbWVkaWF0ZWssbXQ2Nzc5LXBpbmN0cmwueWFtbA0KIGNyZWF0ZSBtb2RlIDEwMDY0
NCBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210Njc3OS1ldmIuZHRzDQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ2Nzc5LmR0c2kNCiBjcmVh
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3BpbmN0cmwtbXQ2Nzc5LmMN
CiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3BpbmN0cmwtbXRr
LW10Njc3OS5oDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvZHQtYmluZGluZ3MvcGluY3Ry
bC9tdDY3NzktcGluZnVuYy5o

