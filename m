Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F57C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 10:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0743D2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 10:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IH6vlJtA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgHNKrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 06:47:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:7179 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727807AbgHNKq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 06:46:59 -0400
X-UUID: 265164d8aad943f0ba1dae3513a646c9-20200814
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Vg2nMxZsYjEcovPtsX9BS/W+I/gd/3mpy5v2d1HpBk8=;
        b=IH6vlJtANCNfHanVLG1x/WJLGXR1205kDGmxerhPno8Nb9PvNjGojqtyTRTGS9ACtg+xQ37HMJ+VjoWzAQSj6Ykxork4z+wHSzI+izXsC4ptm0mYvl2dhDO7ujf4PhyvbENV2Poz9jHjjyset5Uo3CGsNjR4GP2YGsREm91Pc4g=;
X-UUID: 265164d8aad943f0ba1dae3513a646c9-20200814
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 971439689; Fri, 14 Aug 2020 18:46:55 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 14 Aug 2020 18:46:52 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 14 Aug 2020 18:46:51 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>, <matthias.bgg@gmail.com>,
        <robh+dt@kernel.org>, <tiwai@suse.com>,
        <linux-kernel@vger.kernel.org>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <howie.huang@mediatek.com>,
        <tzungbi@google.com>, <eason.yen@mediatek.com>,
        <shane.chien@mediatek.com>, <bicycle.tasi@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [PATCH v3 0/2] Add mediatek codec mt6359 driver
Date:   Fri, 14 Aug 2020 18:45:52 +0800
Message-ID: <1597401954-28388-1-git-send-email-jiaxin.yu@mediatek.com>
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
b3JtYWwgUGF0aCINCigyKSBIUEwgTXV4IC0tPiAiQXVkaW8gUGxheWJhY2siDQooMykgSFBSIE11
eCAtLT4gIkF1ZGlvIFBsYXliYWNrIg0KDQp2MyBjaGFuZ2VzOg0KCTEuIFJlbW92ZSBjYWxpYnJh
dGlvbiByZWxhdGVkIGZ1bmN0aW9ucy4NCgkyLiBDb25iaW5lZCAnSFBMIE11eCcgYW5kICdIUFIg
TXV4JyB0byAnSFAgTXV4Jy4NCgkzLiBNb3ZlIHRoZSByZWd1bGF0b3JfZW5hYmxlIG9mICd2YXVk
MTgnIHRvIHRoZSBjb21wb25lbnQgcHJvYmUuDQoJNC4gRml4IHNvbWUgaW5jb3JyZWN0IGNvZGlu
ZyBzdHlsZS4NCg0KdjIgY2hhbmdlczoNCgkxLiBwYXRjaHdvcmsgbGluazoNCgkJaHR0cHM6Ly9w
YXRjaHdvcmsua2VybmVsLm9yZy9jb3Zlci8xMTcwNjkzNS8NCgkJaHR0cHM6Ly9wYXRjaHdvcmsu
a2VybmVsLm9yZy9wYXRjaC8xMTcwODg2NS8NCgkJaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9y
Zy9wYXRjaC8xMTcwNjkzNy8NCg0KdjEgY2hhbmdlczoNCgkxLmxrbWwgbGluazoNCgkJaHR0cHM6
Ly9sa21sLm9yZy9sa21sLzIwMjAvMy81LzEyNTcNCg0KSmlheGluIFl1ICgyKToNCiAgV0lQOiBB
U29DOiBtZWRpYXRlazogbXQ2MzU5OiBhZGQgY29kZWMgZHJpdmVyDQogIFdJUDogZHQtYmluZGlu
Z3M6IG1lZGlhdGVrOiBtdDYzNTk6IGFkZCBjb2RlYyBkb2N1bWVudA0KDQogLi4uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc291bmQvbXQ2MzU5LnlhbWwgICAgIHwgICA2OCArDQogc291bmQvc29jL2Nv
ZGVjcy9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgIHwgICAgOCArDQogc291bmQvc29jL2Nv
ZGVjcy9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgIHwgICAgMiArDQogc291bmQvc29jL2Nv
ZGVjcy9tdDYzNTkuYyAgICAgICAgICAgICAgICAgICAgIHwgMjczNyArKysrKysrKysrKysrKysr
Kw0KIHNvdW5kL3NvYy9jb2RlY3MvbXQ2MzU5LmggICAgICAgICAgICAgICAgICAgICB8IDI2NDAg
KysrKysrKysrKysrKysrKw0KIDUgZmlsZXMgY2hhbmdlZCwgNTQ1NSBpbnNlcnRpb25zKCspDQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3Vu
ZC9tdDYzNTkueWFtbA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3VuZC9zb2MvY29kZWNzL210NjM1
OS5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IHNvdW5kL3NvYy9jb2RlY3MvbXQ2MzU5LmgNCg0KLS0g
DQoyLjE4LjANCg==

