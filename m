Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4A1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89374206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pBU+7Id1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbgGAJgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:36:05 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:33687 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729156AbgGAJgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:36:03 -0400
X-UUID: 334d10a69c5e4b4db150b328e848eb6a-20200701
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=JmH2i1K1LVRfQ5H7fZWEmVhisTSm9PDFTAU2k91Y8VA=;
        b=pBU+7Id1echOHiDolArMMpizj6NcCPxHmoFQD7NiBDIZU9z67XfET3R9dBG8YMLVr2E9HR0k5fdlcI2VuJfXLTlZYo7h4Tj6eTXnsoIzq02s2Fj14zSHeGmxVWuaap+P+6RiaMciZLU7ivj3nJmKpykGTD9Q+FU0iYa5z05o9vQ=;
X-UUID: 334d10a69c5e4b4db150b328e848eb6a-20200701
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1774990996; Wed, 01 Jul 2020 17:36:00 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 1 Jul 2020 17:35:50 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 1 Jul 2020 17:35:50 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH v3, 0/2] This patchset add read-only(Ro) request for capture queue
Date:   Wed, 1 Jul 2020 17:35:20 +0800
Message-ID: <20200701093522.8521-1-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 098F809224606EF2751969BA6E6369678673A6DDE0F23228BF1043BDAABBF46B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNClVzZXIgZHJpdmVyIG5lZWQgdG8gZ2V0IEhEUjEwKyBpbmZvcm1hdGlvbiBmb3Ig
ZWFjaCBjYXB0dXJlIGJ1ZmZlcjsNCkZvciBzb21lIGVuY29kZXIgY2FzZXMsIHVzZXIgZHJpdmVy
IG5lZWQgdG8gZ2V0IGVuY29kZWQgbWVzc2FnZSBmb3INCmVhY2ggZnJhbWUuIFNvIGFkZCBzdXBw
b3J0IHJlYWQtb25seShSbykgcmVxdWVzdCBmb3IgY2FwdHVyZSBxdWV1ZS4NCg0KVGhlcmUgaXMg
bm8gdXBzdHJlYW0gZHJpdmVyIHRvIHVzZSB0aGlzIGZlYXR1cmUgYXQgbm93LCBidXQgd2UgYXJl
DQpkZXZlbG9waW5nIGludGVybmFsIGRyaXZlciB0byB1c2UgaXQuIElmIGl0IGlzIHJlYWR5LCB3
ZSB3aWxsIHRyeSB0bw0KdXBzdHJlYW0gdmRlYy92ZW5jIGRyaXZlciBiYXNlZCBvbiB0aGlzIGZl
YXR1cmUuDQoNCj09PT09PT09PT09PT09DQpJbnRyb2R1Y3Rpb24NCj09PT09PT09PT09PT09DQoN
ClJvIHJlcXVlc3QgbWVhbiB0aGF0IHVzZXIgZHJpdmVyIGp1c3QgY2FuIGdldCBleHQgY3RybHMs
IHNldCBleHQgY3RybHMNCmlzIG5vdCBub3QgYWxsb3dlZC4gUm8gUmVxdWVzdCBhbHNvIGNhbiBi
ZSB1c2VkIGluIG91dHB1dCBxdWV1ZS4NCg0KQWRkIHBhcmFtIHJvX3JlcXVlc3RzIGluIHN0cnVj
dCB2NGwyX2N0cmxfaGFuZGxlciBtZWFuIHRoYXQgYWxsIENJRCBjdHJscw0KYmVsb25nIHRvIHRo
aXMgY3RybCBoYW5kbGVyIGlzIHJlYWQgb25seS4gQWRkIHBhcmFtIHJvX2N0cmxfaGFuZGxlciBp
bg0Kc3RydWN0IHY0bDJfZmggdXNlZCBmb3IgUm8gcmVxdWVzdC4NCg0KQWRkIHBhcmFtIHN1cHBv
cnRzX3JvX3JlcXVlc3RzIGluIHN0cnVjdCB2YjJfcXVldWUgcHJlc2VudCB0aGF0IGNhcHR1cmUg
b3INCm91dHB1dCBxdWV1ZSB1c2UgUm8gcmVxdWVzdC4NCg0KV2hlbiBzZXQvZ2V0IGV4dCBjdHJs
cywgd2lsbCBjaGVjayB3aGV0aGVyIGN1cnJlbnQgQ0lEIGN0cmxzIGlzIHJvIGN0cmxzDQpvciBu
b3QgdXNpbmcgZnVuY3Rpb24gdjRsMl9jaGVja19yb19leHRfY3RybHMoKS4NCg0KPT09PT09PT09
PT09PT09PQ0KQ2hhbmdlcyBpbiB2Mw0KPT09PT09PT09PT09PT09PQ0KLWNoYW5nZSBjb3Zlci1s
ZXR0ZXIgbWVzc2FnZQ0KLWNoYW5nZSBjb21taXQgbWVzc2FnZSBmb3IgcGF0Y2ggMDIvMDINCi1h
ZGQgc2FuaXR5IGNoZWNrIGluIHZiMl9jb3JlX3F1ZXVlX2luaXQoKQ0KDQpZdW5mZWkgRG9uZyAo
Mik6DQogIG1lZGlhOiB2NGwgVUFQSTogYWRkIFY0TDJfQlVGX0NBUF9TVVBQT1JUU19ST19SRVFV
RVNUUw0KICBtZWRpYTogdjRsOiBBZGQgUm8gcmVxdWVzdCBhcGkgZm9yIGNhcHR1cmUgcXVldWUN
Cg0KIC4uLi9tZWRpYS92NGwvdmlkaW9jLXJlcWJ1ZnMucnN0ICAgICAgICAgICAgICB8ICAgNCAr
DQogLi4uL21lZGlhL2NvbW1vbi92aWRlb2J1ZjIvdmlkZW9idWYyLWNvcmUuYyAgIHwgICAzICsN
CiAuLi4vbWVkaWEvY29tbW9uL3ZpZGVvYnVmMi92aWRlb2J1ZjItdjRsMi5jICAgfCAgIDcgKysN
CiBkcml2ZXJzL21lZGlhL21jL21jLXJlcXVlc3QuYyAgICAgICAgICAgICAgICAgfCAgMTAgKy0N
CiBkcml2ZXJzL21lZGlhL3Y0bDItY29yZS92NGwyLWN0cmxzLmMgICAgICAgICAgfCAxMDcgKysr
KysrKysrKysrKysrLS0tDQogZHJpdmVycy9tZWRpYS92NGwyLWNvcmUvdjRsMi1pb2N0bC5jICAg
ICAgICAgIHwgIDIyICsrKysNCiBkcml2ZXJzL21lZGlhL3Y0bDItY29yZS92NGwyLW1lbTJtZW0u
YyAgICAgICAgfCAgMTkgKystLQ0KIGluY2x1ZGUvbWVkaWEvdjRsMi1jdHJscy5oICAgICAgICAg
ICAgICAgICAgICB8ICAyMiArKystDQogaW5jbHVkZS9tZWRpYS92NGwyLWZoLmggICAgICAgICAg
ICAgICAgICAgICAgIHwgICAyICsNCiBpbmNsdWRlL21lZGlhL3ZpZGVvYnVmMi1jb3JlLmggICAg
ICAgICAgICAgICAgfCAgIDIgKw0KIGluY2x1ZGUvdWFwaS9saW51eC92aWRlb2RldjIuaCAgICAg
ICAgICAgICAgICB8ICAgMSArDQogMTEgZmlsZXMgY2hhbmdlZCwgMTYxIGluc2VydGlvbnMoKyks
IDM4IGRlbGV0aW9ucygtKQ0KDQo=

