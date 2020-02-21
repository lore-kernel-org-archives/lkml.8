Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E13C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A370208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kXK6lRau"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgBUL2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:28:45 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:13977 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727039AbgBUL2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:28:44 -0500
X-UUID: e7882cf78e704a66978959e01bcd9da8-20200221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=WqPXsEqYilGj+Se9aLiobnNaBsVbzCQKOya7+P5P4dk=;
        b=kXK6lRaunl7/UWOwtZbJMinLn9Pk7NfLiwoe+htins+csdOl4IeXIFEe82u1oJ6R8mIrUVlCrBxTdM4HXQAsxN02J3XyMszYOcOBAtMMEbOHv01Cp13WpS59BTWZz2+GS7iPsxMdX0RPczaVkkk0eCyoSFHxFirEE8pwsBceTlc=;
X-UUID: e7882cf78e704a66978959e01bcd9da8-20200221
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1701413800; Fri, 21 Feb 2020 19:28:34 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 21 Feb
 2020 19:27:13 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Fri, 21 Feb 2020 19:27:32 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, <huijuan.xie@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v6 0/4] add mt8183 dpi driver
Date:   Fri, 21 Feb 2020 19:28:24 +0800
Message-ID: <20200221112828.55837-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 65587B8808C753827096943E733EBABAA07D4FF1005ED706468AEEA59267476E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2NToNCiAtIGZpbmUgdHVuZSB0aGUgZHQtYmluZGluZ3MgY29tbWl0IG1l
c3NhZ2UuDQoNCkNoYW5nZXMgc2luY2UgdjQ6DQogLSBtb3ZlIHBpbiBtb2RlIGNvbnRyb2wgYW5k
IGR1YWwgZWRnZSBjb250cm9sIHRvIGRldmVpY2UgdHJlZS4NCiAtIHVwZGF0ZSBkdC1iaW5kaW5n
cyBkb2N1bWVudCBmb3IgcGluIG1vZGUgc3dhcCBhbmQgZHVhbCBlZGdlIGNvbnRyb2wuDQoNCkNo
YW5nZXMgc2luY2UgdjM6DQogLSBhZGQgZHBpIHBpbiBtb2RlIGNvbnRyb2wgd2hlbiBkcGkgb24g
b3Igb2ZmLg0KIC0gdXBkYXRlIGRwaSBkdWFsIGVkZ2UgY29tbWVudC4NCg0KQ2hhbmdlcyBzaW5j
ZSB2MjoNCiAtIHVwZGF0ZSBkdC1iaW5kaW5ncyBkb2N1bWVudCBmb3IgbXQ4MTgzIGRwaS4NCiAt
IHNlcGFyYXRlIGR1YWwgZWRnZSBtb2RmaWNhdGlvbiBhcyBpbmRlcGVuZGVudCBwYXRjaC4NCg0K
Sml0YW8gU2hpICg0KToNCiAgZHQtYmluZGluZ3M6IGRpc3BsYXk6IG1lZGlhdGVrOiB1cGRhdGUg
ZHBpIHN1cHBvcnRlZCBjaGlwcw0KICBkcm0vbWVkaWF0ZWs6IGRwaSBkdWFsIGVkZ2Ugc3VwcG9y
dA0KICBkcm0vbWVkaWF0ZWs6IGFkZCBtdDgxODMgZHBpIGNsb2NrIGZhY3Rvcg0KICBkcm0vbWVk
aWF0ZWs6IHNldCBkcGkgcGluIG1vZGUgdG8gZ3BpbyBsb3cgdG8gYXZvaWQgbGVha2FnZSBjdXJy
ZW50DQoNCiAuLi4vZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkudHh0ICAgICAgICAgfCAx
MSArKysNCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jICAgICAgICAgICAgfCA2
OSArKysrKysrKysrKysrKysrKystDQogMiBmaWxlcyBjaGFuZ2VkLCA3OSBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQoNCi0tIA0KMi4yMS4wDQo=

