Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48829C3F2D8
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2135020848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="to2V9PU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCFDeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 22:34:00 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:12355 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726162AbgCFDeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 22:34:00 -0500
X-UUID: 45b2bf6554584c88bcd01bf3712092c2-20200306
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=itlYgQ45be2Ssn2Nzi2Lg0iTSRTOtSvZl1uOUtpZGFQ=;
        b=to2V9PU8Ie1oJRyCv/CXkuG0op/0lQp9T6MXTLPZsW/Ds+40Glvq9zHlwcXd9slUyHq6/aEwa8G/qF2+iR47I1xzioLYjZ1nMo6J22L9DktjuWbza2O5MoLFDGQ/jwhR098DbOxPktOpxee4H6DWGXNWs+aSKTFOHco59dr4l2M=;
X-UUID: 45b2bf6554584c88bcd01bf3712092c2-20200306
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <eason.yen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 926651444; Fri, 06 Mar 2020 11:33:55 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 6 Mar 2020 11:33:01 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 6 Mar 2020 11:33:55 +0800
From:   Eason Yen <eason.yen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <eason.yen@mediatek.com>, <jiaxin.yu@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Subject: [PATCH 0/2] Add mediatek codec mt6359 driver
Date:   Fri, 6 Mar 2020 11:33:40 +0800
Message-ID: <1583465622-16628-1-git-send-email-eason.yen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIG1lZGlhdGVrIGNvZGVjIChNVDYzNTkpIGRyaXZlcg0KDQpNVDYzNTkgc3VwcG9ydCBwbGF5
YmFjaywgY2FwdHVyZSBhbmQgdm93IGZlYXR1cmUuDQoNCk9uIGRvd25saW5rIHBhdGgsIGl0IGlu
Y2x1ZGVzIHRocmVlIERBQ3MgZm9yIGhhbmRzZXQsIGhlYWRzZXQsDQphbmQgbGluZW91dCBwYXRo
LiBPbiB1bmxpbmsgcGF0aCwgaXQgaW5jbHVkZWRzIHRocmVlIEFEQ3MgZm9yDQptYWluIG1pYywg
c2Vjb25kIG1pYywgM3JkIG1pYywgYW5kIGhlYWRzZXQgbWljLg0KDQpCeSBzY2VuYXJpbywgc2Vs
ZWN0ICpfTVVYIHdpZGdldCB0byBjcmVhdGUgZGFtcCBwYXRoLg0KQW5kIGJ5IHNlbGVjdCBtaWNf
dHlwZV9tdXggdG8gY2hvb3NlIERNSUMvQU1JQy8uLi4uDQoNCkZvciBleGFtcGxlLCBzZWxlY3Qg
dGhlc2UgTVVYIHdpZGdldCB0byBjcmVhdGUgaGVhZHNldCBwYXRoDQooMSkgREFDIEluIE11eCAt
LT4gIk5vcm1hbCBQYXRoIg0KKDIpIEhQTCBNdXggLS0+ICJBdWRpbyBQbGF5YmFjayINCigzKSBI
UFIgTXV4IC0tPiAiQXVkaW8gUGxheWJhY2siDQoNCg0KRWFzb24gWWVuICgyKToNCiAgQVNvQzog
bWVkaWF0ZWs6IG10NjM1OTogYWRkIGNvZGVjIGRvY3VtZW50DQogIEFTb0M6IGNvZGVjOiBtZWRp
YXRlazogYWRkIG10NjM1OSBjb2RlYyBkcml2ZXINCg0KIERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9zb3VuZC9tdDYzNTkudHh0IHwgICAxNiArDQogc291bmQvc29jL2NvZGVjcy9L
Y29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICA5ICsNCiBzb3VuZC9zb2MvY29k
ZWNzL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDIgKw0KIHNvdW5kL3Nv
Yy9jb2RlY3MvbXQ2MzU5LmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgNDIxNyArKysrKysr
KysrKysrKysrKysrKw0KIHNvdW5kL3NvYy9jb2RlY3MvbXQ2MzU5LmggICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgMzIxMiArKysrKysrKysrKysrKysNCiA1IGZpbGVzIGNoYW5nZWQsIDc0NTYg
aW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc291bmQvbXQ2MzU5LnR4dA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3VuZC9z
b2MvY29kZWNzL210NjM1OS5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IHNvdW5kL3NvYy9jb2RlY3Mv
bXQ2MzU5LmgNCg0KLS0gDQoxLjkuMQ0K

