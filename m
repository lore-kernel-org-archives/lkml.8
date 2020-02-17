Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60812C761A1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4EB20718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lOV+nQz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgBQJFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:05:43 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:54642 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728272AbgBQJFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:05:42 -0500
X-UUID: 277c51c42f2745b5b5fc1ebce71bacee-20200217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=TH2Ce9vmxpcBg+uja+1cRFMB0hG0JtrMLOaW8Iql/R8=;
        b=lOV+nQz2bpgM8/GGsBM1mzyYU3/NmoBU0CFGxj+pQEJGnN5JRYwG8MMci60p1P+M1GnzODIQr0I00u6XRc9zWn5B9weLakOt37YI2rv9Z6bTKeozmVqszuhPpDktg4NcHRdtTcnwnpbvFxe2yxBxnYyu51ZY0v6463vKZRDhC/Y=;
X-UUID: 277c51c42f2745b5b5fc1ebce71bacee-20200217
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 296785312; Mon, 17 Feb 2020 17:05:35 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 17 Feb 2020 17:04:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Feb 2020 17:03:35 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH v1 0/3] Remove atomic_exec
Date:   Mon, 17 Feb 2020 17:05:29 +0800
Message-ID: <20200217090532.16019-1-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGF0b21pY19leGVjIHdhcyBkZXNpZ25lZCBmb3IgcHJvY2Vzc2luZyBjb250aW51b3VzDQpw
YWNrZXRzIG9mIGNvbW1hbmRzIGluIGF0b21pYyB3YXkgZm9yIE1lZGlhdGVrIERSTSBkcml2ZXIu
DQoNCkFmdGVyIHdlIGltcGxlbWVudCBmbHVzaCBmdW5jdGlvbiwgTWVkaWF0ZWsgRFJNIGRyaXZl
cg0KZG9lc24ndCBuZWVkIGF0b21pY19leGVjLCB0aGUgcHJpbWFyeSBjb25jZXB0IGlzIHRvIGxl
dA0KTWVkaWF0ZWsgRFJNIGRyaXZlciBjYW4gbWFrZSBzdXJlIHByZXZpb3VzIG1lc3NhZ2UgZG9u
ZSBvcg0KYmUgYWJvcnRlZCAoaWYgdGhlIG1lc3NhZ2UgaGFzIG5vdCBzdGFydGVkIHlldCkgYmVm
b3JlIHRoZXkNCnNlbmQgbmV4dCBtZXNzYWdlLg0KDQpDaGFuZ2VzIHNpbmNlIHYwOg0KIC0gbW92
ZSB0aGUgYmluZGluZyBjaGFuZ2VzIHRvIGZpcnN0DQogLSByZW1vdmUgdW5uZWNlc3NhcnkgY2hh
bmdlcw0KDQpCaWJieSBIc2llaCAoMyk6DQogIGR0LWJpbmRpbmc6IGdjZTogcmVtb3ZlIGF0b21p
Y19leGVjIGluIG1ib3hlcyBwcm9wZXJ0eQ0KICBtYWlsYm94OiBtZWRpYXRlazogaW1wbGVtZW50
IGZsdXNoIGZ1bmN0aW9uDQogIG1haWxib3g6IG1lZGlhdGVrOiByZW1vdmUgaW1wbGVtZW50YXRp
b24gcmVsYXRlZCB0byBhdG9taWNfZXhlYw0KDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbWFp
bGJveC9tdGstZ2NlLnR4dCAgIHwgIDEwICstDQogZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1h
aWxib3guYyAgICAgICAgICAgIHwgMTI4ICsrKysrKysrLS0tLS0tLS0tLQ0KIDIgZmlsZXMgY2hh
bmdlZCwgNjQgaW5zZXJ0aW9ucygrKSwgNzQgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4xOC4wDQo=

