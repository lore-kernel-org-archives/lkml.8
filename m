Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4F6C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 05:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22E8246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 05:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MJOYlIcb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgB1FWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 00:22:39 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:42729 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725468AbgB1FWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 00:22:38 -0500
X-UUID: b2212b16be1444048ae1fc61997b4f42-20200228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=hx1vyqreUaDlEd+O0J9QdTAoM6IYl0gynpL7Q9O9Mlg=;
        b=MJOYlIcbx/ux/oed26fnrJM2ODTP3daokZbLpSFi7RhBsb7fGj4/fzuIjqLcmm6lD5Eb4424BjzBahwCZEfpZcO6zkVTiTkjMKnb9iJchR5mTDIqaM0qDB98wPqRxDmDVvSMt97WXXe3E8iuaxZDKuDFDcqcOyQAHr9idV6FM8Y=;
X-UUID: b2212b16be1444048ae1fc61997b4f42-20200228
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1498666084; Fri, 28 Feb 2020 13:21:38 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 28 Feb
 2020 13:20:15 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Fri, 28 Feb 2020 13:22:01 +0800
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
Subject: [PATCH v10 0/5] mt8183 dpi supports dual edge and pin mode swap
Date:   Fri, 28 Feb 2020 13:21:23 +0800
Message-ID: <20200228052128.82136-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 6739D98E80EC8480B023BD5CC93BFF3800F14F27309F76845A651EE097CB8D112000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2OToNCiAtIHJlbmFtZSBwaW5jdHJsLW5hbWVzID0gImdwaW9tb2RlIiwg
ImRwaW1vZGUiIHRvICJhY3RpdmUiLCAiaWRsZSIuDQogLSBmaXggc29tZSB0eXBvLg0KDQpDaGFu
Z2VzIHNpbmNlIHY4Og0KIC0gZHJvcCBwY2xrLXNhbXBsZSByZWRlZmluZSBpbiBtZWRpYXRlayxk
cGkudHh0DQogLSBvbmx5IGdldCB0aGUgZ3Bpb21vZGUgYW5kIGRwaW1vZGUgd2hlbiBkcGktPnBp
bmN0cmwgaXMgc3VjY2Vzc2Z1bC4NCg0KQ2hhbmdlcyBzaW5jZSB2NzoNCiAtIHNlcGFyYXRlIGR0
LWJpbmRpbmdzIHRvIGluZGVwZW5kZW50IHBhdGNoZXMuDQogLSBtb3ZlIGRwaSBkdWFsIGVkZ2Ug
dG8gb25lIHBhdGNoLg0KDQpDaGFuZ2VzIHNpbmNlIHY2Og0KIC0gY2hhbmdlIGR1YWxfZWRnZSB0
byBwY2xrLXNhbXBsZQ0KIC0gcmVtb3ZlIGRwaV9waW5fbW9kZV9zd2FwIGFuZA0KDQpDaGFuZ2Vz
IHNpbmNlIHY1Og0KIC0gZmluZSB0dW5lIHRoZSBkdC1iaW5kaW5ncyBjb21taXQgbWVzc2FnZS4N
Cg0KQ2hhbmdlcyBzaW5jZSB2NDoNCiAtIG1vdmUgcGluIG1vZGUgY29udHJvbCBhbmQgZHVhbCBl
ZGdlIGNvbnRyb2wgdG8gZGV2ZWljZSB0cmVlLg0KIC0gdXBkYXRlIGR0LWJpbmRpbmdzIGRvY3Vt
ZW50IGZvciBwaW4gbW9kZSBzd2FwIGFuZCBkdWFsIGVkZ2UgY29udHJvbC4NCg0KQ2hhbmdlcyBz
aW5jZSB2MzoNCiAtIGFkZCBkcGkgcGluIG1vZGUgY29udHJvbCB3aGVuIGRwaSBvbiBvciBvZmYu
DQogLSB1cGRhdGUgZHBpIGR1YWwgZWRnZSBjb21tZW50Lg0KDQpDaGFuZ2VzIHNpbmNlIHYyOg0K
IC0gdXBkYXRlIGR0LWJpbmRpbmdzIGRvY3VtZW50IGZvciBtdDgxODMgZHBpLg0KIC0gc2VwYXJh
dGUgZHVhbCBlZGdlIG1vZGZpY2F0aW9uIGFzIGluZGVwZW5kZW50IHBhdGNoLg0KDQpKaXRhbyBT
aGkgKDUpOg0KICBkdC1iaW5kaW5nczogbWVkaWE6IGFkZCBwY2xrLXNhbXBsZSBkdWFsIGVkZ2Ug
cHJvcGVydHkNCiAgZHQtYmluZGluZ3M6IGRpc3BsYXk6IG1lZGlhdGVrOiBjb250cm9sIGRwaSBw
aW5zIG1vZGUgdG8gYXZvaWQgbGVha2FnZQ0KICBkdC1iaW5kaW5nczogZGlzcGxheTogbWVkaWF0
ZWs6IGRwaSBzYW1wbGUgZGF0YSBpbiBkdWFsIGVkZ2Ugc3VwcG9ydA0KICBkcm0vbWVkaWF0ZWs6
IGRwaSBzYW1wbGUgbW9kZSBzdXBwb3J0DQogIGRybS9tZWRpYXRlazogc2V0IGRwaSBwaW4gbW9k
ZSB0byBncGlvIGxvdyB0byBhdm9pZCBsZWFrYWdlIGN1cnJlbnQNCg0KIC4uLi9kaXNwbGF5L21l
ZGlhdGVrL21lZGlhdGVrLGRwaS50eHQgICAgICAgICB8ICA5ICsrKysNCiAuLi4vYmluZGluZ3Mv
bWVkaWEvdmlkZW8taW50ZXJmYWNlcy50eHQgICAgICAgfCAgNCArLQ0KIGRyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHBpLmMgICAgICAgICAgICB8IDQ5ICsrKysrKysrKysrKysrKysrKy0N
CiAzIGZpbGVzIGNoYW5nZWQsIDU4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCi0t
IA0KMi4yMS4wDQo=

