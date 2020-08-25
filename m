Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7E5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 01:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E11D520738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 01:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ehXeURId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgHYB6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 21:58:40 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45744 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726000AbgHYB6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 21:58:39 -0400
X-UUID: 0684c9f2029942189b2e2ebe3781934f-20200825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=QjiWiguuQ5aBJrBkNVTbpiMEZNHatuVj+uLpNS9djNY=;
        b=ehXeURId29jpQwQ+ZBXw/aE0Sx6qzqnI0kGiCDJQgGvFCGUFEJw7UKTWqM7u2sOYEadt1fWoTG+ST9Rz8+RGH7hvcSKRYhFo1ZPhJBxO3F9UiBoka78DDFNh46aNU6JYcMoT6Kt5ucQ2C3pcdEpIj1yURDmT3xYzOZeuPkHeHnk=;
X-UUID: 0684c9f2029942189b2e2ebe3781934f-20200825
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1742342722; Tue, 25 Aug 2020 09:58:36 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 25 Aug 2020 09:58:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 Aug 2020 09:58:35 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Marco Elver <elver@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH v3 2/6] workqueue: kasan: record workqueue stack
Date:   Tue, 25 Aug 2020 09:58:33 +0800
Message-ID: <20200825015833.27900-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmVjb3JkcyB0aGUgbGFzdCB0d28gZW5xdWV1aW5nIHdvcmsgY2FsbCBzdGFja3MgaW4gb3JkZXIg
dG8gcHJpbnQgdGhlbQ0KaW4gS0FTQU4gcmVwb3J0LiBJdCBpcyB1c2VmdWwgZm9yIHByb2dyYW1t
ZXJzIHRvIHNvbHZlIHVzZS1hZnRlci1mcmVlDQpvciBkb3VibGUtZnJlZSBtZW1vcnkgd29ya3F1
ZXVlIGlzc3VlLg0KDQpGb3Igd29ya3F1ZXVlIGl0IGhhcyB0dXJuZWQgb3V0IHRvIGJlIHVzZWZ1
bCB0byByZWNvcmQgdGhlIGVucXVldWluZw0Kd29yayBjYWxsIHN0YWNrcy4gQmVjYXVzZSB1c2Vy
IGNhbiBzZWUgS0FTQU4gcmVwb3J0IHRvIGRldGVybWluZQ0Kd2hldGhlciBpdCBpcyByb290IGNh
dXNlLiBUaGV5IGRvbid0IG5lZWQgdG8gZW5hYmxlIGRlYnVnb2JqZWN0cywNCmJ1dCB0aGV5IGhh
dmUgYSBjaGFuY2UgdG8gZmluZCBvdXQgdGhlIHJvb3QgY2F1c2UuDQoNClNpZ25lZC1vZmYtYnk6
IFdhbHRlciBXdSA8d2FsdGVyLXpoLnd1QG1lZGlhdGVrLmNvbT4NClN1Z2dlc3RlZC1ieTogTWFy
Y28gRWx2ZXIgPGVsdmVyQGdvb2dsZS5jb20+DQpDYzogQW5kcmV5IFJ5YWJpbmluIDxhcnlhYmlu
aW5AdmlydHVvenpvLmNvbT4NCkNjOiBEbWl0cnkgVnl1a292IDxkdnl1a292QGdvb2dsZS5jb20+
DQpDYzogQWxleGFuZGVyIFBvdGFwZW5rbyA8Z2xpZGVyQGdvb2dsZS5jb20+DQpDYzogVGVqdW4g
SGVvIDx0akBrZXJuZWwub3JnPg0KQ2M6IExhaSBKaWFuZ3NoYW4gPGppYW5nc2hhbmxhaUBnbWFp
bC5jb20+DQotLS0NCg0KdjI6DQotIFRoYW5rcyBmb3IgTWFyY28gc3VnZ2VzdGlvbi4NCi0gUmVt
b3ZlIHVubmVjZXNzYXJ5IGNvZGUNCi0gcmV1c2Uga2FzYW5fcmVjb3JkX2F1eF9zdGFjaygpIGFu
ZCBhdXhfc3RhY2sNCiAgdG8gcmVjb3JkIHRpbWVyIGFuZCB3b3JrcXVldWUgc3RhY2sNCg0KLS0t
DQoNCiBrZXJuZWwvd29ya3F1ZXVlLmMgfCAzICsrKw0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2tlcm5lbC93b3JrcXVldWUuYyBiL2tlcm5lbC93b3Jr
cXVldWUuYw0KaW5kZXggYzQxYzNjMTdiODZhLi41ZmVhN2RjOTE4MGYgMTAwNjQ0DQotLS0gYS9r
ZXJuZWwvd29ya3F1ZXVlLmMNCisrKyBiL2tlcm5lbC93b3JrcXVldWUuYw0KQEAgLTEzMjQsNiAr
MTMyNCw5IEBAIHN0YXRpYyB2b2lkIGluc2VydF93b3JrKHN0cnVjdCBwb29sX3dvcmtxdWV1ZSAq
cHdxLCBzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmssDQogew0KIAlzdHJ1Y3Qgd29ya2VyX3Bvb2wg
KnBvb2wgPSBwd3EtPnBvb2w7DQogDQorCS8qIHJlY29yZCB0aGUgd29yayBjYWxsIHN0YWNrIGlu
IG9yZGVyIHRvIHByaW50IGl0IGluIEtBU0FOIHJlcG9ydHMgKi8NCisJa2FzYW5fcmVjb3JkX2F1
eF9zdGFjayh3b3JrKTsNCisNCiAJLyogd2Ugb3duIEB3b3JrLCBzZXQgZGF0YSBhbmQgbGluayAq
Lw0KIAlzZXRfd29ya19wd3Eod29yaywgcHdxLCBleHRyYV9mbGFncyk7DQogCWxpc3RfYWRkX3Rh
aWwoJndvcmstPmVudHJ5LCBoZWFkKTsNCi0tIA0KMi4xOC4wDQo=

