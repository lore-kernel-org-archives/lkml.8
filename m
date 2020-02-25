Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65D0C35DFB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B68220656
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SveXSn/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbgBYJl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 04:41:29 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:30095 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729375AbgBYJl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 04:41:26 -0500
X-UUID: 4913ed4b5260480c8865f8a84e38d1ca-20200225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=oF3KkNvoJzVvadlbuzGhS17OQKGLGXOb9PVV5s1StUY=;
        b=SveXSn/UY8WFNZyic+RRhVR9SAbCrOepcUhWVwxV35SviGXamMtUj9DiZE1d82zDUKZmYn1WkGJobwe4xxAVnltstDqSZyt578YDQr6umwB7KtDjIVnXgaEfnhToMEHWvymTjhUidlCZ7akfe/2iF1rMWVXZ5GqFr4B5MFspzE8=;
X-UUID: 4913ed4b5260480c8865f8a84e38d1ca-20200225
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1046475812; Tue, 25 Feb 2020 17:41:06 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 25 Feb
 2020 17:41:40 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 25 Feb 2020 17:39:44 +0800
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
Subject: [PATCH v8 0/7] mt8183 dpi supports dual edge and pin mode swap
Date:   Tue, 25 Feb 2020 17:40:50 +0800
Message-ID: <20200225094057.120144-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F3C968FD0E0DDA35E1DE23740DCC57F0475410075039E4474043D353505D68422000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2NzoNCiAtIHNlcGFyYXRlIGR0LWJpbmRpbmdzIHRvIGluZGVwZW5kZW50
IHBhdGNoZXMuDQogLSBtb3ZlIGRwaSBkdWFsIGVkZ2UgdG8gb25lIHBhdGNoLg0KDQpDaGFuZ2Vz
IHNpbmNlIHY2Og0KIC0gY2hhbmdlIGR1YWxfZWRnZSB0byBwY2xrLXNhbXBsZQ0KIC0gcmVtb3Zl
IGRwaV9waW5fbW9kZV9zd2FwIGFuZA0KDQpDaGFuZ2VzIHNpbmNlIHY1Og0KIC0gZmluZSB0dW5l
IHRoZSBkdC1iaW5kaW5ncyBjb21taXQgbWVzc2FnZS4NCg0KQ2hhbmdlcyBzaW5jZSB2NDoNCiAt
IG1vdmUgcGluIG1vZGUgY29udHJvbCBhbmQgZHVhbCBlZGdlIGNvbnRyb2wgdG8gZGV2ZWljZSB0
cmVlLg0KIC0gdXBkYXRlIGR0LWJpbmRpbmdzIGRvY3VtZW50IGZvciBwaW4gbW9kZSBzd2FwIGFu
ZCBkdWFsIGVkZ2UgY29udHJvbC4NCg0KQ2hhbmdlcyBzaW5jZSB2MzoNCiAtIGFkZCBkcGkgcGlu
IG1vZGUgY29udHJvbCB3aGVuIGRwaSBvbiBvciBvZmYuDQogLSB1cGRhdGUgZHBpIGR1YWwgZWRn
ZSBjb21tZW50Lg0KDQpDaGFuZ2VzIHNpbmNlIHYyOg0KIC0gdXBkYXRlIGR0LWJpbmRpbmdzIGRv
Y3VtZW50IGZvciBtdDgxODMgZHBpLg0KIC0gc2VwYXJhdGUgZHVhbCBlZGdlIG1vZGZpY2F0aW9u
IGFzIGluZGVwZW5kZW50IHBhdGNoLg0KDQpKaXRhbyBTaGkgKDcpOg0KICBkdC1iaW5kaW5nczog
bWVkaWE6IGFkZCBwY2xrLXNhbXBsZSBkdWFsIGVkZ2UgcHJvcGVydHkNCiAgZHQtYmluZGluZ3M6
IGRpc3BsYXk6IG1lZGlhdGVrOiB1cGRhdGUgZHBpIHN1cHBvcnRlZCBjaGlwcw0KICBkdC1iaW5k
aW5nczogZGlzcGxheTogbWVkaWF0ZWs6IGNvbnRyb2wgZHBpIHBpbnMgbW9kZSB0byBhdm9pZCBs
ZWFrYWdlDQogIGR0LWJpbmRpbmdzOiBkaXNwbGF5OiBtZWRpYXRlazogZHBpIHNhbXBsZSBkYXRh
IGluIGR1YWwgZWRnZSBzdXBwb3J0DQogIGRybS9tZWRpYXRlazogZHBpIHNhbXBsZSBtb2RlIHN1
cHBvcnQNCiAgZHJtL21lZGlhdGVrOiBhZGQgbXQ4MTgzIGRwaSBjbG9jayBmYWN0b3INCiAgZHJt
L21lZGlhdGVrOiBzZXQgZHBpIHBpbiBtb2RlIHRvIGdwaW8gbG93IHRvIGF2b2lkIGxlYWthZ2Ug
Y3VycmVudA0KDQogLi4uL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dCAgICAgICAg
IHwgMTIgKysrKw0KIC4uLi9iaW5kaW5ncy9tZWRpYS92aWRlby1pbnRlcmZhY2VzLnR4dCAgICAg
ICB8ICA0ICstDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYyAgICAgICAgICAg
IHwgNjYgKysrKysrKysrKysrKysrKysrLQ0KIDMgZmlsZXMgY2hhbmdlZCwgNzggaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjIxLjANCg==

