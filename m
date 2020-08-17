Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9FEC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 06:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F01D320758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 06:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WU8s/2Df"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgHQGIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 02:08:54 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50609 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726415AbgHQGIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 02:08:49 -0400
X-UUID: 9b12133b8c1b4633a50d50bb56699ca5-20200817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Lu1pMyst1Tuly33CctInw4/3ftqcqaHDiJCV73RnmxQ=;
        b=WU8s/2DfsA7RlJAnD3vnJD8QMhLS0UrNUK3J5OYVawl5IfkcEvJGGr5ZzGlUZDLWdA+CMBli6Nzx/8PjH+mHQcs6fjBY0gAeI87Flfc9J1w7OEuku5puGAt0CC02dDDMHRUWHanhJCI3ecyuByUkJ+I4LXmCryP5SzNPN6ZQn0M=;
X-UUID: 9b12133b8c1b4633a50d50bb56699ca5-20200817
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1270104413; Mon, 17 Aug 2020 14:08:42 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 17 Aug 2020 14:08:39 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Aug 2020 14:08:40 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>, <matthias.bgg@gmail.com>,
        <robh+dt@kernel.org>, <tiwai@suse.com>,
        <linux-kernel@vger.kernel.org>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <howie.huang@mediatek.com>,
        <tzungbi@google.com>, <eason.yen@mediatek.com>,
        <shane.chien@mediatek.com>, <bicycle.tsai@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [PATCH v5 0/2] Add mediatek codec mt6359 driver
Date:   Mon, 17 Aug 2020 14:07:33 +0800
Message-ID: <1597644455-8216-1-git-send-email-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIG1lZGlhdGVrIGNvZGVjIChNVDYzNTkpIGRyaXZlcg0KDQpNVDYzNTkgc3VwcG9ydCBwbGF5
YmFjayBhbmQgY2FwdHVyZSBmZWF0dXJlLg0KDQpPbiBkb3dubGluayBwYXRoLCBpdCBpbmNsdWRl
cyB0aHJlZSBEQUNzIGZvciBoYW5kc2V0LCBoZWFkc2V0LA0KYW5kIGxpbmVvdXQgcGF0aC4gT24g
dW5saW5rIHBhdGgsIGl0IGluY2x1ZGVkcyB0aHJlZSBBRENzIGZvcg0KbWFpbiBtaWMsIHNlY29u
ZCBtaWMsIDNyZCBtaWMsIGFuZCBoZWFkc2V0IG1pYy4NCg0KQnkgc2NlbmFyaW8sIHNlbGVjdCAq
X01VWCB3aWRnZXQgdG8gY3JlYXRlIGRhbXAgcGF0aC4NCkFuZCBieSBzZWxlY3QgbWljX3R5cGVf
bXV4IHRvIGNob29zZSBETUlDL0FNSUMvLi4uLg0KDQpGb3IgZXhhbXBsZSwgc2VsZWN0IHRoZXNl
IE1VWCB3aWRnZXQgdG8gY3JlYXRlIGhlYWRzZXQgcGF0aA0KKDEpIERBQyBJbiBNdXggLS0+ICJO
b3JtYWwgUGF0aCINCigyKSBIUCBNdXggLS0+ICJBdWRpbyBQbGF5YmFjayINCg0KdjUgY2hhbmdl
czoNCgkxLiBEb24ndCBuZWVkIHRvIHVucmVnaXN0ZXIgdGhlIGNvbXBvbmVudCB3aGljaCBpcyBh
bHJlYWR5IHJlbGVnYXRlZCB0byBkZXZtLg0KDQp2NCBjaGFuZ2VzOg0KCTEuIEFkZCBhIHJlbW92
ZSgpIGZ1bmN0aW9uIHRvIHVuZG8gcmVndWxhdG9yX2VuYWJsZSgpLg0KCTIuIFJlbW92ZWQgdW5u
ZWNlc3NhcnkgbG9ncy4NCgkzLiBwYXRjaHdvcmsgbGluazoNCgkJaHR0cHM6Ly9wYXRjaHdvcmsu
a2VybmVsLm9yZy9jb3Zlci8xMTcxNTU1My8NCgkJaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9y
Zy9wYXRjaC8xMTcxNjAxNS8NCgkJaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8x
MTcxNTU1Ny8NCnYzIGNoYW5nZXM6DQoJMS4gcGF0Y2h3b3JrIGxpbms6DQoJCWh0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvY292ZXIvMTE3MTQyOTEvDQoJCWh0dHBzOi8vcGF0Y2h3b3JrLmtl
cm5lbC5vcmcvcGF0Y2gvMTE3MTQyOTUvDQoJCWh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcv
cGF0Y2gvMTE3MTQzMzkvDQoNCnYyIGNoYW5nZXM6DQoJMS4gcGF0Y2h3b3JrIGxpbms6DQoJCWh0
dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvY292ZXIvMTE3MDY5MzUvDQoJCWh0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTE3MDg4NjUvDQoJCWh0dHBzOi8vcGF0Y2h3b3JrLmtl
cm5lbC5vcmcvcGF0Y2gvMTE3MDY5MzcvDQoNCnYxIGNoYW5nZXM6DQoJMS5sa21sIGxpbms6DQoJ
CWh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIwLzMvNS8xMjU3DQoNCkppYXhpbiBZdSAoMik6DQog
IEFTb0M6IG1lZGlhdGVrOiBtdDYzNTk6IGFkZCBjb2RlYyBkcml2ZXINCiAgZHQtYmluZGluZ3M6
IG1lZGlhdGVrOiBtdDYzNTk6IGFkZCBjb2RlYyBkb2N1bWVudA0KDQogLi4uL2RldmljZXRyZWUv
YmluZGluZ3Mvc291bmQvbXQ2MzU5LnlhbWwgICAgICAgICAgfCAgIDY4ICsNCiBzb3VuZC9zb2Mv
Y29kZWNzL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDggKw0KIHNvdW5k
L3NvYy9jb2RlY3MvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgMiArDQog
c291bmQvc29jL2NvZGVjcy9tdDYzNTkuYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAyNzUz
ICsrKysrKysrKysrKysrKysrKysrDQogc291bmQvc29jL2NvZGVjcy9tdDYzNTkuaCAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAyNjQwICsrKysrKysrKysrKysrKysrKysNCiA1IGZpbGVzIGNo
YW5nZWQsIDU0NzEgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbXQ2MzU5LnlhbWwNCiBjcmVhdGUgbW9kZSAx
MDA2NDQgc291bmQvc29jL2NvZGVjcy9tdDYzNTkuYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3Vu
ZC9zb2MvY29kZWNzL210NjM1OS5oDQoNCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

