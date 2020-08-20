Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCF2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37BFE206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="V1oMbpwV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgHTIxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:53:03 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:30491 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725823AbgHTIww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:52:52 -0400
X-UUID: 093ddc2104f44c19bc9682f25a33b436-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=sJv/+CGFViRM8kc7c0v51N1LTh6fBPIfS3In0xmPVHA=;
        b=V1oMbpwVLECj0GWQWV1Tf/LwDCnbxBp2onDOVA4ZuvKRDAWiVXYn/cXT4QcD/KZpEB6lrwwPQEDEjhIxrmIEK+kn3UmUYrZB8G4SgUbJeNXVHyeQ3SJnR7p3opOIKoqbP5+8XOxpGlM4HKQxdFmr1pWBe7q+gkbLo9TSZRPy3zI=;
X-UUID: 093ddc2104f44c19bc9682f25a33b436-20200820
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 753846107; Thu, 20 Aug 2020 16:52:45 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 16:52:43 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 16:52:43 +0800
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
Subject: [PATCH v6 0/2] Add mediatek codec mt6359 driver
Date:   Thu, 20 Aug 2020 16:51:31 +0800
Message-ID: <1597913493-10747-1-git-send-email-jiaxin.yu@mediatek.com>
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
b3JtYWwgUGF0aCINCigyKSBIUCBNdXggLS0+ICJBdWRpbyBQbGF5YmFjayINCg0KdjYgY2hhbmdl
czoNCgkxLiBSZW1vdmUgdGhlIGNvbXBhdGlibGUgc3RyaW5nIGluIG10NjM1OWNvZGVjIGJlY2F1
c2UgTUZEIHNob3VsZCBiZSByZWdpc3RlcmluZyB0aGUgcGxhdGZvcm0gZGV2aWNlLg0KDQp2NSBj
aGFuZ2VzOg0KCTEuIERvbid0IG5lZWQgdG8gdW5yZWdpc3RlciB0aGUgY29tcG9uZW50IHdoaWMg
aXMgYWxyZWFkeSByZWxlZ2F0ZWQgdG8gZGV2bS4NCgkyLiBwYXRjaHdvcmsgbGluazoNCgkJaHR0
cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9jb3Zlci8xMTcxNjM4Ny8NCgkJaHR0cHM6Ly9wYXRj
aHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMTcxNzc1Ny8NCgkJaHR0cHM6Ly9wYXRjaHdvcmsua2Vy
bmVsLm9yZy9wYXRjaC8xMTcxNjQ5MS8NCg0KdjQgY2hhbmdlczoNCgkxLiBBZGQgYSByZW1vdmUo
KSBmdW5jdGlvbiB0byB1bmRvIHJlZ3VsYXRvcl9lbmFibGUoKS4NCgkyLiBSZW1vdmVkIHVubmVj
ZXNzYXJ5IGxvZ3MuDQoJMy4gcGF0Y2h3b3JrIGxpbms6DQoJCWh0dHBzOi8vcGF0Y2h3b3JrLmtl
cm5lbC5vcmcvY292ZXIvMTE3MTU1NTMvDQoJCWh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcv
cGF0Y2gvMTE3MTYwMTUvDQoJCWh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTE3
MTU1NTcvDQoNCnYzIGNoYW5nZXM6DQoJMS4gcGF0Y2h3b3JrIGxpbms6DQoJCWh0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvY292ZXIvMTE3MTQyOTEvDQoJCWh0dHBzOi8vcGF0Y2h3b3JrLmtl
cm5lbC5vcmcvcGF0Y2gvMTE3MTQyOTUvDQoJCWh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcv
cGF0Y2gvMTE3MTQzMzkvDQoNCnYyIGNoYW5nZXM6DQoJMS4gcGF0Y2h3b3JrIGxpbms6DQoJCWh0
dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvY292ZXIvMTE3MDY5MzUvDQoJCWh0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTE3MDg4NjUvDQoJCWh0dHBzOi8vcGF0Y2h3b3JrLmtl
cm5lbC5vcmcvcGF0Y2gvMTE3MDY5MzcvDQoNCnYxIGNoYW5nZXM6DQoJMS5sa21sIGxpbms6DQoJ
CWh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIwLzMvNS8xMjU3DQoNCkppYXhpbiBZdSAoMik6DQog
IEFTb0M6IG1lZGlhdGVrOiBtdDYzNTk6IGFkZCBjb2RlYyBkcml2ZXINCiAgZHQtYmluZGluZ3M6
IG1lZGlhdGVrOiBtdDYzNTk6IGFkZCBjb2RlYyBkb2N1bWVudA0KDQogLi4uL2RldmljZXRyZWUv
YmluZGluZ3Mvc291bmQvbXQ2MzU5LnlhbWwgICAgIHwgICA2MSArDQogc291bmQvc29jL2NvZGVj
cy9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgIHwgICAgOCArDQogc291bmQvc29jL2NvZGVj
cy9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgIHwgICAgMiArDQogc291bmQvc29jL2NvZGVj
cy9tdDYzNTkuYyAgICAgICAgICAgICAgICAgICAgIHwgMjc1MyArKysrKysrKysrKysrKysrKw0K
IHNvdW5kL3NvYy9jb2RlY3MvbXQ2MzU5LmggICAgICAgICAgICAgICAgICAgICB8IDI2NDAgKysr
KysrKysrKysrKysrKw0KIDUgZmlsZXMgY2hhbmdlZCwgNTQ2NCBpbnNlcnRpb25zKCspDQogY3Jl
YXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9t
dDYzNTkueWFtbA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3VuZC9zb2MvY29kZWNzL210NjM1OS5j
DQogY3JlYXRlIG1vZGUgMTAwNjQ0IHNvdW5kL3NvYy9jb2RlY3MvbXQ2MzU5LmgNCg0KLS0gDQoy
LjE4LjANCg==

