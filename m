Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10CEC2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 07:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB20720857
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 07:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sB43eeK+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgDKHoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 03:44:46 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:61810 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726178AbgDKHon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 03:44:43 -0400
X-UUID: ac2d969db3de4dee952271d4b6244625-20200411
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=VL/uIEJeOh4V+RzzjIL7SOp5c2Ln6Wq9deMdt7EQdfo=;
        b=sB43eeK+G0tuhcF5a8a8QM2WBi7iA64YFUJIh4BzIoMkbbmUOFQjSZGk1D+L9+nzcpb+ZJsxGQ/xn5eT1lZFR1l7CBt9m8aH+JWKiUKJrJGwxES+AsV4Sn1YM5T+KNienUyLoerC2V9Ra8a94rqQU+3ZsHN0n4jzMtmkA2ZT9s0=;
X-UUID: ac2d969db3de4dee952271d4b6244625-20200411
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1165974946; Sat, 11 Apr 2020 15:44:28 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 11 Apr
 2020 15:44:25 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sat, 11 Apr 2020 15:44:22 +0800
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
Subject: [PATCH v6 0/4] Config mipi tx current and impedance
Date:   Sat, 11 Apr 2020 15:44:04 +0800
Message-ID: <20200411074408.38090-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F06F78ACE077B8F53AD26555B0EACD516F8A1379DB458BC6BF1268D245B0AFD52000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2NToNCiAtIHJlbW92ZSBtZW1zZXQoKQ0KIC0gYWRkIHJldHVybiB0byBy
ZW1vdmUgImVsc2UiDQoNCkNoYW5nZXMgc2luY2UgdjQ6DQogLSBhZGQgUmV2aWV3ZWQtYnk6DQog
LSBtb3ZlIHRoZSBnZXQgdGhlIGNhbGlicmF0aW9uIGRhdGEgY29kZSB0byBwcm9iZS4NCg0KQ2hh
bmdlcyBzaW5jZSB2MzoNCiAtIHJlZmluZSBkcml2ZS1zdHJlbmd0aC1taWNyb2FtcCBhcyBmcm9t
IDMwMDAgdG8gNjAwMC4NCg0KQ2hhbmdlcyBzaW5jZSB2MjoNCiAtIGZpeCB0aGUgdGl0bGUgb2Yg
Y29tbWl0IG1lc3NhZ2UuDQogLSByZW5hbWUgbWlwaXR4LWN1cnJlbnQtZHJpdmUgdG8gZHJpdmUt
c3RyZW5ndGgtbWljcm9hbXANCg0KQ2hhbmdlcyBzaW5jZSB2MToNCiAtIGZpeCBjb2Rpbmcgc3R5
bGUuDQogLSBjaGFuZ2UgbXRrX21pcGlfdHhfY29uZmlnX2NhbGlicmF0aW9uX2RhdGEoKSB0byB2
b2lkDQoNCkppdGFvIFNoaSAoNCk6DQogIGR0LWJpbmRpbmdzOiBkaXNwbGF5OiBtZWRpYXRlazog
YWRkIHByb3BlcnR5IHRvIGNvbnRyb2wgbWlwaSB0eCBkcml2ZQ0KICAgIGN1cnJlbnQNCiAgZHQt
YmluZGluZ3M6IGRpc3BsYXk6IG1lZGlhdGVrOiBnZXQgbWlwaXR4IGNhbGlicmF0aW9uIGRhdGEg
ZnJvbSBudm1lbQ0KICBkcm0vbWVkaWF0ZWs6IGFkZCB0aGUgbWlwaXR4IGRyaXZpbmcgY29udHJv
bA0KICBkcm0vbWVkaWF0ZWs6IGNvbmZpZyBtaXBpdHggaW1wZWRhbmNlIHdpdGggY2FsaWJyYXRp
b24gZGF0YQ0KDQogLi4uL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHNpLnR4dCAgICAgICAg
IHwgMTAgKysrKw0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbWlwaV90eC5jICAgICAg
ICB8IDU0ICsrKysrKysrKysrKysrKysrKysNCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X21pcGlfdHguaCAgICAgICAgfCAgNCArKw0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
bXQ4MTgzX21pcGlfdHguYyB8IDI4ICsrKysrKysrKysNCiA0IGZpbGVzIGNoYW5nZWQsIDk2IGlu
c2VydGlvbnMoKykNCg0KLS0gDQoyLjIxLjANCg==

