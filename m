Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35B4C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 06:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE2B21556
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 06:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ck/AapoJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgBYGq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 01:46:57 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:49265 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726936AbgBYGq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 01:46:57 -0500
X-UUID: 3c0d9069fd684f3d9dfc58c87e7f9afc-20200225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=pmuf7vvzpu765ixMqbePyvDNsg3g6qbRoBiCP+4dj5U=;
        b=Ck/AapoJGvrRJ1GzlazX/beX0BYj5Zd5f2SeF7I6TkfGPjrR5xamq+06BK5EMM6c4eDAOfCw9Jzn7tudpXD/3e+vE2zboMc4o/Iva3TUAH/OkF0kVPIkYaF9cSoE8f6VRQwh3mZe1naQrp3hNg8eRZDBij4UXDb3Tp8OnOS+3c4=;
X-UUID: 3c0d9069fd684f3d9dfc58c87e7f9afc-20200225
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1945666165; Tue, 25 Feb 2020 14:46:48 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 25 Feb
 2020 14:47:20 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 25 Feb 2020 14:45:25 +0800
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
Subject: [PATCH v7 0/4] add mt8183 dpi driver
Date:   Tue, 25 Feb 2020 14:46:34 +0800
Message-ID: <20200225064638.112282-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A756B05E682182D02D9E9B215338CD2D8D14BDB3747DC244107AB7A279AE734D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2NjoNCiAtIGNoYW5nZSBkdWFsX2VkZ2UgdG8gcGNsay1zYW1wbGUNCiAt
IHJlbW92ZSBkcGlfcGluX21vZGVfc3dhcCBhbmQNCg0KQ2hhbmdlcyBzaW5jZSB2NToNCiAtIGZp
bmUgdHVuZSB0aGUgZHQtYmluZGluZ3MgY29tbWl0IG1lc3NhZ2UuDQoNCkNoYW5nZXMgc2luY2Ug
djQ6DQogLSBtb3ZlIHBpbiBtb2RlIGNvbnRyb2wgYW5kIGR1YWwgZWRnZSBjb250cm9sIHRvIGRl
dmVpY2UgdHJlZS4NCiAtIHVwZGF0ZSBkdC1iaW5kaW5ncyBkb2N1bWVudCBmb3IgcGluIG1vZGUg
c3dhcCBhbmQgZHVhbCBlZGdlIGNvbnRyb2wuDQoNCkNoYW5nZXMgc2luY2UgdjM6DQogLSBhZGQg
ZHBpIHBpbiBtb2RlIGNvbnRyb2wgd2hlbiBkcGkgb24gb3Igb2ZmLg0KIC0gdXBkYXRlIGRwaSBk
dWFsIGVkZ2UgY29tbWVudC4NCg0KQ2hhbmdlcyBzaW5jZSB2MjoNCiAtIHVwZGF0ZSBkdC1iaW5k
aW5ncyBkb2N1bWVudCBmb3IgbXQ4MTgzIGRwaS4NCiAtIHNlcGFyYXRlIGR1YWwgZWRnZSBtb2Rm
aWNhdGlvbiBhcyBpbmRlcGVuZGVudCBwYXRjaC4NCg0KSml0YW8gU2hpICg0KToNCiAgZHQtYmlu
ZGluZ3M6IGRpc3BsYXk6IG1lZGlhdGVrOiB1cGRhdGUgZHBpIHN1cHBvcnRlZCBjaGlwcw0KICBk
cm0vbWVkaWF0ZWs6IGRwaSBzYW1wbGUgbW9kZSBzdXBwb3J0DQogIGRybS9tZWRpYXRlazogYWRk
IG10ODE4MyBkcGkgY2xvY2sgZmFjdG9yDQogIGRybS9tZWRpYXRlazogc2V0IGRwaSBwaW4gbW9k
ZSB0byBncGlvIGxvdyB0byBhdm9pZCBsZWFrYWdlIGN1cnJlbnQNCg0KIC4uLi9kaXNwbGF5L21l
ZGlhdGVrL21lZGlhdGVrLGRwaS50eHQgICAgICAgICB8IDEwICsrKw0KIGRyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHBpLmMgICAgICAgICAgICB8IDY1ICsrKysrKysrKysrKysrKysrKy0N
CiAyIGZpbGVzIGNoYW5nZWQsIDczIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCi0t
IA0KMi4yMS4wDQo=

