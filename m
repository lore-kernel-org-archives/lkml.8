Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A32EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 13:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A7C24900
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 13:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oriOEpQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbgFUNWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 09:22:37 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:23355 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729619AbgFUNWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 09:22:19 -0400
X-UUID: ce429ffb1dac4c33a4006b4a1d7cae5f-20200621
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3rvvFBdm5jN8tYlvL2WjSID0CHDQ80fY5OLbbB7MYi0=;
        b=oriOEpQSlutnGvjNTZ3mH5oIUO6c0a5UEJR+FPtPNEFT+WFKdjYB6VR9Y1LP1yZCT0QLMmZmPCxeyN33ja6mMqaAP3kKBJERRsKZkHBdd9fnxqmdVtj4wBu+2G4Htg6L9/RD5xNDkrNGQqN1+pV2diFw01imP09whfiIQcAkaFM=;
X-UUID: ce429ffb1dac4c33a4006b4a1d7cae5f-20200621
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 270657160; Sun, 21 Jun 2020 21:22:14 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 21 Jun 2020 21:22:05 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 21 Jun 2020 21:22:05 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v7 3/4] mailbox: cmdq: support mt6779 gce platform definition
Date:   Sun, 21 Jun 2020 21:22:10 +0800
Message-ID: <1592745731-14614-4-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1592745731-14614-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1592745731-14614-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGdjZSB2NCBoYXJkd2FyZSBzdXBwb3J0IHdpdGggZGlmZmVyZW50IHRocmVhZCBudW1iZXIg
YW5kIHNoaWZ0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15Yy5o
c2llaEBtZWRpYXRlay5jb20+DQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNv
bT4NClJldmlld2VkLWJ5OiBNYXR0aGlhcyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29t
Pg0KLS0tDQogZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYyB8ICAgIDIgKysNCiAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL21h
aWxib3gvbXRrLWNtZHEtbWFpbGJveC5jIGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxi
b3guYw0KaW5kZXggNGRiZWU5MjU4MTI3Li45OTk0YWM5NDI2ZDYgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQorKysgYi9kcml2ZXJzL21haWxib3gvbXRr
LWNtZHEtbWFpbGJveC5jDQpAQCAtNTcyLDEwICs1NzIsMTIgQEAgc3RhdGljIGludCBjbWRxX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogDQogc3RhdGljIGNvbnN0IHN0cnVj
dCBnY2VfcGxhdCBnY2VfcGxhdF92MiA9IHsudGhyZWFkX25yID0gMTZ9Ow0KIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgZ2NlX3BsYXQgZ2NlX3BsYXRfdjMgPSB7LnRocmVhZF9uciA9IDI0fTsNCitzdGF0
aWMgY29uc3Qgc3RydWN0IGdjZV9wbGF0IGdjZV9wbGF0X3Y0ID0gey50aHJlYWRfbnIgPSAyNCwg
LnNoaWZ0ID0gM307DQogDQogc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgY21kcV9v
Zl9pZHNbXSA9IHsNCiAJey5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE3My1nY2UiLCAuZGF0
YSA9ICh2b2lkICopJmdjZV9wbGF0X3YyfSwNCiAJey5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10
ODE4My1nY2UiLCAuZGF0YSA9ICh2b2lkICopJmdjZV9wbGF0X3YzfSwNCisJey5jb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10Njc3OS1nY2UiLCAuZGF0YSA9ICh2b2lkICopJmdjZV9wbGF0X3Y0fSwN
CiAJe30NCiB9Ow0KIA0KLS0gDQoxLjcuOS41DQo=

