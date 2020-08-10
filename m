Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE0DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1995F2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SMQ+HDqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgHJHVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 03:21:25 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:42672 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725869AbgHJHVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 03:21:23 -0400
X-UUID: 9ef467e8e3c44a80abe745e271563427-20200810
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=8hb1XmCOYYfoHO2INc2JsSa/wZHmidgJRDdB3egeX9U=;
        b=SMQ+HDqc9JZ3FaxSewQJaEBxCuE2aLVL/LY32B9mIdtH7TldvAJw0kksEXpoORisUxJU0rqFiysRM95qk12M1qJ7FoYRDti/B3QK4LK40GZjEa8EDF2epUmuERB+BuUur64cCu8nn9VO/NCGsGoAQllAC0loyzK2wTsx3CH/Ioo=;
X-UUID: 9ef467e8e3c44a80abe745e271563427-20200810
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1691687393; Mon, 10 Aug 2020 15:21:18 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 10 Aug 2020 15:21:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 Aug 2020 15:21:15 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
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
Subject: [PATCH 0/5] kasan: add workqueue and timer stack for generic KASAN
Date:   Mon, 10 Aug 2020 15:21:15 +0800
Message-ID: <20200810072115.429-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
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
cmtxdWV1ZQ0KcXVldWVpbmcgc3RhY2sgYW5kIHRpbWVyIHF1ZXVlaW5nIHN0YWNrIGluZm9ybWF0
aW9uLiBJdCBpcyB1c2VmdWwgZm9yDQpwcm9ncmFtbWVycyB0byBzb2x2ZSB1c2UtYWZ0ZXItZnJl
ZSBvciBkb3VibGUtZnJlZSBtZW1vcnkgaXNzdWUuDQoNCkdlbmVyaWMgS0FTQU4gd2lsbCByZWNv
cmQgdGhlIGxhc3QgdHdvIHdvcmtxdWV1ZSBhbmQgdGltZXIgc3RhY2tzLA0KcHJpbnQgdGhlbSBp
biBLQVNBTiByZXBvcnQuIEl0IGlzIG9ubHkgc3VpdGFibGUgZm9yIGdlbmVyaWMgS0FTQU4uDQoN
CkluIG9yZGVyIHRvIHByaW50IHRoZSBsYXN0IHR3byB3b3JrcXVldWUgYW5kIHRpbWVyIHN0YWNr
cywgc28gdGhhdA0Kd2UgYWRkIG5ldyBtZW1iZXJzIGluIHN0cnVjdCBrYXNhbl9hbGxvY19tZXRh
Lg0KLSB0d28gd29ya3F1ZXVlIHF1ZXVlaW5nIHdvcmsgc3RhY2tzLCB0b3RhbCBzaXplIGlzIDgg
Ynl0ZXMuDQotIHR3byB0aW1lciBxdWV1ZWluZyBzdGFja3MsIHRvdGFsIHNpemUgaXMgOCBieXRl
cy4NCg0KT3JpZ25pYWwgc3RydWN0IGthc2FuX2FsbG9jX21ldGEgc2l6ZSBpcyAxNiBieXRlcy4g
QWZ0ZXIgYWRkIG5ldw0KbWVtYmVycywgdGhlbiB0aGUgc3RydWN0IGthc2FuX2FsbG9jX21ldGEg
dG90YWwgc2l6ZSBpcyAzMiBieXRlcywNCkl0IGlzIGEgZ29vZCBudW1iZXIgb2YgYWxpZ25tZW50
LiBMZXQgaXQgZ2V0IGJldHRlciBtZW1vcnkgY29uc3VtcHRpb24uDQoNClsxXWh0dHBzOi8vZ3Jv
dXBzLmdvb2dsZS5jb20vZy9zeXprYWxsZXItYnVncy9zZWFyY2g/cT0lMjJ1c2UtYWZ0ZXItZnJl
ZSUyMitwcm9jZXNzX29uZV93b3JrDQpbMl1odHRwczovL2dyb3Vwcy5nb29nbGUuY29tL2cvc3l6
a2FsbGVyLWJ1Z3Mvc2VhcmNoP3E9JTIydXNlLWFmdGVyLWZyZWUlMjIlMjBleHBpcmVfdGltZXJz
DQpbM11odHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTE5ODQzNw0K
DQpXYWx0ZXIgV3UgKDUpOg0KdGltZXI6IGthc2FuOiByZWNvcmQgYW5kIHByaW50IHRpbWVyIHN0
YWNrDQp3b3JrcXVldWU6IGthc2FuOiByZWNvcmQgYW5kIHByaW50IHdvcmtxdWV1ZSBzdGFjaw0K
bGliL3Rlc3Rfa2FzYW4uYzogYWRkIHRpbWVyIHRlc3QgY2FzZQ0KbGliL3Rlc3Rfa2FzYW4uYzog
YWRkIHdvcmtxdWV1ZSB0ZXN0IGNhc2UNCmthc2FuOiB1cGRhdGUgZG9jdW1lbnRhdGlvbiBmb3Ig
Z2VuZXJpYyBrYXNhbg0KDQpEb2N1bWVudGF0aW9uL2Rldi10b29scy9rYXNhbi5yc3QgfCAgNCAr
Ky0tDQppbmNsdWRlL2xpbnV4L2thc2FuLmggICAgICAgICAgICAgfCAgNCArKysrDQprZXJuZWwv
dGltZS90aW1lci5jICAgICAgICAgICAgICAgfCAgMiArKw0Ka2VybmVsL3dvcmtxdWV1ZS5jICAg
ICAgICAgICAgICAgIHwgIDMgKysrDQpsaWIvdGVzdF9rYXNhbi5jICAgICAgICAgICAgICAgICAg
fCA1NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCm1tL2thc2FuL2dlbmVyaWMuYyAgICAgICAgICAgICAgICB8IDQyICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KbW0va2FzYW4va2FzYW4uaCAgICAgICAgICAg
ICAgICAgIHwgIDYgKysrKystDQptbS9rYXNhbi9yZXBvcnQuYyAgICAgICAgICAgICAgICAgfCAy
MiArKysrKysrKysrKysrKysrKysrKysrDQo4IGZpbGVzIGNoYW5nZWQsIDEzNCBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQ==

