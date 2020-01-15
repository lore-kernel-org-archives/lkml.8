Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5927C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9A624656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cUKJg8tI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbgAOOB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:01:26 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:30358 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729527AbgAOOBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:01:23 -0500
X-UUID: 0ae485446c95407c9fd5d1ff31189a19-20200115
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=mTHqCyl3PT41Ee4vqhiT5z1TdFbxdAOVDKgXmuHkAtQ=;
        b=cUKJg8tImZzOvC7VYWwhB4JLlW5Zoki1dY8o8YRBz7XNcm+irII/ocMP60H9b8lIkBeaUt2cb9R/VeP5cRwD+bxlKh0vgQU+efr/GSCpKErQIEWMvX0W3/awnF4cmk5axwyWQlgzHlvSwMK0hkbq6kSX/XapByQ6JgkD9qyIl00=;
X-UUID: 0ae485446c95407c9fd5d1ff31189a19-20200115
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1100281724; Wed, 15 Jan 2020 22:01:05 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 15 Jan
 2020 22:01:31 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 15 Jan 2020 22:01:14 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v8 5/8] dt-bindings: display: panel: add boe tv101wum-n53 panel documentation
Date:   Wed, 15 Jan 2020 21:59:55 +0800
Message-ID: <20200115135958.126303-6-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115135958.126303-1-jitao.shi@mediatek.com>
References: <20200115135958.126303-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8CFC2934BF925020F2325C5403DAC107A371D9957E9BFE906EEEDEE9599C9A612000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGRjdW1lbnRhdGlvbiBmb3IgYm9lLHR2MTAxd3VtLW41Mywgd2hpY2ggaXMgbWlwaSBkc2kg
dmlkZW8gcGFuZWwNCmFuZCByZXNvbHV0aW9uIGlzIDEyMDB4MTkyMC4NCg0KU2lnbmVkLW9mZi1i
eTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4uL2Rpc3BsYXkv
cGFuZWwvYm9lLHR2MTAxd3VtLW41My55YW1sICAgICAgIHwgNzQgKysrKysrKysrKysrKysrKysr
Kw0KIDEgZmlsZSBjaGFuZ2VkLCA3NCBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L3BhbmVsL2JvZSx0djEw
MXd1bS1uNTMueWFtbA0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2Rpc3BsYXkvcGFuZWwvYm9lLHR2MTAxd3VtLW41My55YW1sIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvcGFuZWwvYm9lLHR2MTAxd3VtLW41My55YW1s
DQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMDAwMDAwLi41MTJjYTYwMjk5OGMN
Ci0tLSAvZGV2L251bGwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9k
aXNwbGF5L3BhbmVsL2JvZSx0djEwMXd1bS1uNTMueWFtbA0KQEAgLTAsMCArMSw3NCBAQA0KKyMg
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCislWUFNTCAxLjINCistLS0NCiskaWQ6
IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2Rpc3BsYXkvcGFuZWwvYm9lLHR2MTAxd3Vt
LW41My55YW1sIw0KKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMv
Y29yZS55YW1sIw0KKw0KK3RpdGxlOiBCT0UgVFYxMDFXVU0tTjUzIERTSSBEaXNwbGF5IFBhbmVs
DQorDQorbWFpbnRhaW5lcnM6DQorICAtIFRoaWVycnkgUmVkaW5nIDx0aGllcnJ5LnJlZGluZ0Bn
bWFpbC5jb20+DQorICAtIFNhbSBSYXZuYm9yZyA8c2FtQHJhdm5ib3JnLm9yZz4NCisgIC0gUm9i
IEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz4NCisNCithbGxPZjoNCisgIC0gJHJlZjogcGFu
ZWwtY29tbW9uLnlhbWwjDQorDQorcHJvcGVydGllczoNCisgIGNvbXBhdGlibGU6DQorICAgICAg
ICBjb25zdDogYm9lLHR2MTAxd3VtLW41Mw0KKw0KKyAgcmVnOg0KKyAgICBkZXNjcmlwdGlvbjog
dGhlIHZpcnR1YWwgY2hhbm5lbCBudW1iZXIgb2YgYSBEU0kgcGVyaXBoZXJhbA0KKw0KKyAgZW5h
YmxlLWdwaW9zOg0KKyAgICBkZXNjcmlwdGlvbjogYSBHUElPIHNwZWMgZm9yIHRoZSBlbmFibGUg
cGluDQorDQorICBwcDE4MDAtc3VwcGx5Og0KKyAgICBkZXNjcmlwdGlvbjogY29yZSB2b2x0YWdl
IHN1cHBseQ0KKw0KKyAgYXZkZC1zdXBwbHk6DQorICAgIGRlc2NyaXB0aW9uOiBwaGFuZGxlIG9m
IHRoZSByZWd1bGF0b3IgdGhhdCBwcm92aWRlcyBwb3NpdGl2ZSB2b2x0YWdlDQorDQorICBhdmVl
LXN1cHBseToNCisgICAgZGVzY3JpcHRpb246IHBoYW5kbGUgb2YgdGhlIHJlZ3VsYXRvciB0aGF0
IHByb3ZpZGVzIG5lZ2F0aXZlIHZvbHRhZ2UNCisNCisgIGJhY2tsaWdodDoNCisgICAgZGVzY3Jp
cHRpb246IHBoYW5kbGUgb2YgdGhlIGJhY2tsaWdodCBkZXZpY2UgYXR0YWNoZWQgdG8gdGhlIHBh
bmVsDQorDQorICBwb3J0OiB0cnVlDQorDQorcmVxdWlyZWQ6DQorIC0gY29tcGF0aWJsZQ0KKyAt
IHJlZw0KKyAtIGVuYWJsZS1ncGlvcw0KKyAtIHBwMTgwMC1zdXBwbHkNCisgLSBhdmRkLXN1cHBs
eQ0KKyAtIGF2ZWUtc3VwcGx5DQorIC0gYmFja2xpZ2h0DQorDQorYWRkaXRpb25hbFByb3BlcnRp
ZXM6IGZhbHNlDQorDQorZXhhbXBsZXM6DQorICAtIHwNCisgICAgZHNpIHsNCisgICAgICAgICNh
ZGRyZXNzLWNlbGxzID0gPDE+Ow0KKyAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQorICAgICAg
ICBwYW5lbEAwIHsNCisgICAgICAgICAgICBjb21wYXRpYmxlID0gImJvZSx0djEwMXd1bS1uNTMi
Ow0KKyAgICAgICAgICAgIHJlZyA9IDwwPjsNCisgICAgICAgICAgICBlbmFibGUtZ3Bpb3MgPSA8
JnBpbyA0NSAwPjsNCisgICAgICAgICAgICBhdmRkLXN1cHBseSA9IDwmcHB2YXJuX2xjZD47DQor
ICAgICAgICAgICAgYXZlZS1zdXBwbHkgPSA8JnBwdmFycF9sY2Q+Ow0KKyAgICAgICAgICAgIHBw
MTgwMC1zdXBwbHkgPSA8JnBwMTgwMF9sY2Q+Ow0KKyAgICAgICAgICAgIGJhY2tsaWdodCA9IDwm
YmFja2xpZ2h0X2xjZDA+Ow0KKyAgICAgICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCisgICAgICAg
ICAgICBwb3J0IHsNCisgICAgICAgICAgICAgICAgcGFuZWxfaW46IGVuZHBvaW50IHsNCisgICAg
ICAgICAgICAgICAgICAgIHJlbW90ZS1lbmRwb2ludCA9IDwmZHNpX291dD47DQorICAgICAgICAg
ICAgICAgIH07DQorICAgICAgICAgICAgfTsNCisgICAgICAgIH07DQorICAgIH07DQorDQorLi4u
DQotLSANCjIuMjEuMA0K

