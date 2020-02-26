Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2588CC4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFC6222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mfHqkRTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgBZFeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 00:34:50 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:7046 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726192AbgBZFeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 00:34:50 -0500
X-UUID: 6acf35494bce4e22b2c96d6ae987c16b-20200226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=5MWVenA/3bD64AhsKi4vtHVGeSoOPX0Q/oWUMScWAE4=;
        b=mfHqkRTQlPWPqCHBHQb6fE4mSIOPS3DLOg2+M+44wCP1jNbdTpZFSzrWwIkKfU1W7xOXIRaJJagJOYqNAN9vStzdq+oUlkCAqyZunIz5EBkbC6bdgdrRrL4Ci9/1QpRcGs2OfB+ccSTNbcOKokkuhfbd3fC0ffGbFiNu/EFcnwc=;
X-UUID: 6acf35494bce4e22b2c96d6ae987c16b-20200226
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2104228046; Wed, 26 Feb 2020 13:32:46 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 26 Feb
 2020 13:28:46 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 26 Feb 2020 13:31:21 +0800
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
Subject: [PATCH v9 0/5] mt8183 dpi supports dual edge and pin mode swap
Date:   Wed, 26 Feb 2020 13:32:33 +0800
Message-ID: <20200226053238.31646-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8B1DA2906832716D9B5D1A46C9C82527DC5F0B3376B202AE0A940E238FC2F7A62000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2ODoNCiAtIGRyb3AgcGNsay1zYW1wbGUgcmVkZWZpbmUgaW4gbWVkaWF0
ZWssZHBpLnR4dA0KIC0gb25seSBnZXQgdGhlIGdwaW9tb2RlIGFuZCBkcGltb2RlIHdoZW4gZHBp
LT5waW5jdHJsIGlzIHN1Y2Nlc3NmdWwuDQoNCkNoYW5nZXMgc2luY2Ugdjc6DQogLSBzZXBhcmF0
ZSBkdC1iaW5kaW5ncyB0byBpbmRlcGVuZGVudCBwYXRjaGVzLg0KIC0gbW92ZSBkcGkgZHVhbCBl
ZGdlIHRvIG9uZSBwYXRjaC4NCg0KQ2hhbmdlcyBzaW5jZSB2NjoNCiAtIGNoYW5nZSBkdWFsX2Vk
Z2UgdG8gcGNsay1zYW1wbGUNCiAtIHJlbW92ZSBkcGlfcGluX21vZGVfc3dhcCBhbmQNCg0KQ2hh
bmdlcyBzaW5jZSB2NToNCiAtIGZpbmUgdHVuZSB0aGUgZHQtYmluZGluZ3MgY29tbWl0IG1lc3Nh
Z2UuDQoNCkNoYW5nZXMgc2luY2UgdjQ6DQogLSBtb3ZlIHBpbiBtb2RlIGNvbnRyb2wgYW5kIGR1
YWwgZWRnZSBjb250cm9sIHRvIGRldmVpY2UgdHJlZS4NCiAtIHVwZGF0ZSBkdC1iaW5kaW5ncyBk
b2N1bWVudCBmb3IgcGluIG1vZGUgc3dhcCBhbmQgZHVhbCBlZGdlIGNvbnRyb2wuDQoNCkNoYW5n
ZXMgc2luY2UgdjM6DQogLSBhZGQgZHBpIHBpbiBtb2RlIGNvbnRyb2wgd2hlbiBkcGkgb24gb3Ig
b2ZmLg0KIC0gdXBkYXRlIGRwaSBkdWFsIGVkZ2UgY29tbWVudC4NCg0KQ2hhbmdlcyBzaW5jZSB2
MjoNCiAtIHVwZGF0ZSBkdC1iaW5kaW5ncyBkb2N1bWVudCBmb3IgbXQ4MTgzIGRwaS4NCiAtIHNl
cGFyYXRlIGR1YWwgZWRnZSBtb2RmaWNhdGlvbiBhcyBpbmRlcGVuZGVudCBwYXRjaC4NCg0KSml0
YW8gU2hpICg1KToNCiAgZHQtYmluZGluZ3M6IG1lZGlhOiBhZGQgcGNsay1zYW1wbGUgZHVhbCBl
ZGdlIHByb3BlcnR5DQogIGR0LWJpbmRpbmdzOiBkaXNwbGF5OiBtZWRpYXRlazogY29udHJvbCBk
cGkgcGlucyBtb2RlIHRvIGF2b2lkIGxlYWthZ2UNCiAgZHQtYmluZGluZ3M6IGRpc3BsYXk6IG1l
ZGlhdGVrOiBkcGkgc2FtcGxlIGRhdGEgaW4gZHVhbCBlZGdlIHN1cHBvcnQNCiAgZHJtL21lZGlh
dGVrOiBkcGkgc2FtcGxlIG1vZGUgc3VwcG9ydA0KICBkcm0vbWVkaWF0ZWs6IHNldCBkcGkgcGlu
IG1vZGUgdG8gZ3BpbyBsb3cgdG8gYXZvaWQgbGVha2FnZSBjdXJyZW50DQoNCiAuLi4vZGlzcGxh
eS9tZWRpYXRlay9tZWRpYXRlayxkcGkudHh0ICAgICAgICAgfCAgOSArKysrDQogLi4uL2JpbmRp
bmdzL21lZGlhL3ZpZGVvLWludGVyZmFjZXMudHh0ICAgICAgIHwgIDQgKy0NCiBkcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jICAgICAgICAgICAgfCA0OSArKysrKysrKysrKysrKysr
KystDQogMyBmaWxlcyBjaGFuZ2VkLCA1OCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0K
DQotLSANCjIuMjEuMA0K

