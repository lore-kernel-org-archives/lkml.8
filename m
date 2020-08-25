Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A17FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 01:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 558B2204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 01:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="vIAQSCJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgHYB47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 21:56:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:22883 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725850AbgHYB47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 21:56:59 -0400
X-UUID: d2c409b765f64f23a75f83bc153bfba3-20200825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=dui2EisGgR0+t0THBhS3OAXFKeQaKCwjzNylFyfsynE=;
        b=vIAQSCJL2GMmOBhY1FXjNbDc0jvqU73eR4Jrjw+GvFGcspFaq8vu1mXNKn1Deij8FXbf3N4t0XoB3x1SwDmfR1M0v1tT22xDaTdnpafXrpuW5pWSHMD6IH9A/eAs5G7D9UKLkyk4PpHK6so5CMYy3sjFB79O7fbbX86D8qz+ehs=;
X-UUID: d2c409b765f64f23a75f83bc153bfba3-20200825
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2031445678; Tue, 25 Aug 2020 09:56:57 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 25 Aug 2020 09:56:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 Aug 2020 09:56:55 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Marco Elver <elver@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH v3 0/6] kasan: add workqueue and timer stack for generic KASAN
Date:   Tue, 25 Aug 2020 09:56:54 +0800
Message-ID: <20200825015654.27781-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A71BEAAB700B14FB398E93913C82E2C0D2E251B57762600FE97A0A54DAEC618C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3l6Ym90IHJlcG9ydHMgbWFueSBVQUYgaXNzdWVzIGZvciB3b3JrcXVldWUgb3IgdGltZXIsIHNl
ZSBbMV0gYW5kIFsyXS4NCkluIHNvbWUgb2YgdGhlc2UgYWNjZXNzL2FsbG9jYXRpb24gaGFwcGVu
ZWQgaW4gcHJvY2Vzc19vbmVfd29yaygpLA0Kd2Ugc2VlIHRoZSBmcmVlIHN0YWNrIGlzIHVzZWxl
c3MgaW4gS0FTQU4gcmVwb3J0LCBpdCBkb2Vzbid0IGhlbHANCnByb2dyYW1tZXJzIHRvIHNvbHZl
IFVBRiBvbiB3b3JrcXVldWUuIFRoZSBzYW1lIG1heSBzdGFuZCBmb3IgdGltZXMuDQoNClRoaXMg
cGF0Y2hzZXQgaW1wcm92ZXMgS0FTQU4gcmVwb3J0cyBieSBtYWtpbmcgdGhlbSB0byBoYXZlIHdv
cmtxdWV1ZQ0KcXVldWVpbmcgc3RhY2sgYW5kIHRpbWVyIHN0YWNrIGluZm9ybWF0aW9uLiBJdCBp
cyB1c2VmdWwgZm9yIHByb2dyYW1tZXJzDQp0byBzb2x2ZSB1c2UtYWZ0ZXItZnJlZSBvciBkb3Vi
bGUtZnJlZSBtZW1vcnkgaXNzdWUuDQoNCkdlbmVyaWMgS0FTQU4gYWxzbyByZWNvcmRzIHRoZSBs
YXN0IHR3byB3b3JrcXVldWUgYW5kIHRpbWVyIHN0YWNrcyBhbmQNCnByaW50cyB0aGVtIGluIEtB
U0FOIHJlcG9ydC4gSXQgaXMgb25seSBzdWl0YWJsZSBmb3IgZ2VuZXJpYyBLQVNBTi4NCg0KWzFd
aHR0cHM6Ly9ncm91cHMuZ29vZ2xlLmNvbS9nL3N5emthbGxlci1idWdzL3NlYXJjaD9xPSUyMnVz
ZS1hZnRlci1mcmVlJTIyK3Byb2Nlc3Nfb25lX3dvcmsNClsyXWh0dHBzOi8vZ3JvdXBzLmdvb2ds
ZS5jb20vZy9zeXprYWxsZXItYnVncy9zZWFyY2g/cT0lMjJ1c2UtYWZ0ZXItZnJlZSUyMiUyMGV4
cGlyZV90aW1lcnMNClszXWh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/
aWQ9MTk4NDM3DQoNCldhbHRlciBXdSAoNik6DQp0aW1lcjoga2FzYW46IHJlY29yZCB0aW1lciBz
dGFjaw0Kd29ya3F1ZXVlOiBrYXNhbjogcmVjb3JkIHdvcmtxdWV1ZSBzdGFjaw0Ka2FzYW46IHBy
aW50IHRpbWVyIGFuZCB3b3JrcXVldWUgc3RhY2sNCmxpYi90ZXN0X2thc2FuLmM6IGFkZCB0aW1l
ciB0ZXN0IGNhc2UNCmxpYi90ZXN0X2thc2FuLmM6IGFkZCB3b3JrcXVldWUgdGVzdCBjYXNlDQpr
YXNhbjogdXBkYXRlIGRvY3VtZW50YXRpb24gZm9yIGdlbmVyaWMga2FzYW4NCg0KLS0tDQoNCkNo
YW5nZXMgc2luY2UgdjI6DQotIG1vZGlmeSBrYXNhbiBkb2N1bWVudCB0byBiZSBtb3JlIHJlYWRh
YmxlLg0KICBUaGFua3MgZm9yIE1hcmNvIHN1Z2dlc3Rpb24uDQoNCkNoYW5nZXMgc2luY2UgdjE6
DQotIFRoYW5rcyBmb3IgTWFyY28gYW5kIFRob21hcyBzdWdnZXN0aW9uLg0KLSBSZW1vdmUgdW5u
ZWNlc3NhcnkgY29kZSBhbmQgZml4IGNvbW1pdCBsb2cNCi0gcmV1c2Uga2FzYW5fcmVjb3JkX2F1
eF9zdGFjaygpIGFuZCBhdXhfc3RhY2sNCiAgdG8gcmVjb3JkIHRpbWVyIGFuZCB3b3JrcXVldWUg
c3RhY2suDQotIGNoYW5nZSB0aGUgYXV4IHN0YWNrIHRpdGxlIGZvciBjb21tb24gbmFtZS4NCg0K
LS0tDQoNCkRvY3VtZW50YXRpb24vZGV2LXRvb2xzL2thc2FuLnJzdCB8ICA0ICsrLS0NCmtlcm5l
bC90aW1lL3RpbWVyLmMgICAgICAgICAgICAgICB8ICAzICsrKw0Ka2VybmVsL3dvcmtxdWV1ZS5j
ICAgICAgICAgICAgICAgIHwgIDMgKysrDQpsaWIvdGVzdF9rYXNhbi5jICAgICAgICAgICAgICAg
ICAgfCA1NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCm1tL2thc2FuL3JlcG9ydC5jICAgICAgICAgICAgICAgICB8ICA0ICsrLS0NCjUgZmls
ZXMgY2hhbmdlZCwgNjQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSk=

