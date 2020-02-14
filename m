Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEB8C3B18F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 04:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70ED222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 04:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VIEAdEWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgBNEde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 23:33:34 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:4306 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728239AbgBNEdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 23:33:33 -0500
X-UUID: 3042e2da5e7c484c98e0979874365b81-20200214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=sOXRtKwjw1Ahc1rly56OaA1QzNe/iiZaYY1UpQs1y/g=;
        b=VIEAdEWKZU2dx2qC57jM/2WPVYo4Anw0ZUKG0nHAyWMs3TzyRnnamaYz1t8Up7eUUroJETTcTOFyN72sq5MECl2fhjQLbNq66jITeAIN74dRFwFzUdOKbtDkD93FvbezvOxxQIH0U4y4zu4DzcgKtCfyDsoTJyB3+3UA8MRmtNE=;
X-UUID: 3042e2da5e7c484c98e0979874365b81-20200214
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 471597843; Fri, 14 Feb 2020 12:33:28 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Feb 2020 12:33:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Feb 2020 12:33:18 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH 0/3] Remove atomic_exec
Date:   Fri, 14 Feb 2020 12:33:22 +0800
Message-ID: <20200214043325.16618-1-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGF0b21pY19leGVjIHdhcyBkZXNpZ25lZCBmb3IgcHJvY2Vzc2luZyBjb250aW51b3VzDQpw
YWNrZXRzIG9mIGNvbW1hbmRzIGluIGF0b21pYyB3YXkgZm9yIE1lZGlhdGVrIERSTSBkcml2ZXIu
DQoNCkFmdGVyIHdlIGltcGxlbWVudCBmbHVzaCBmdW5jdGlvbiwgTWVkaWF0ZWsgRFJNIGRyaXZl
cg0KZG9lc24ndCBuZWVkIGF0b21pY19leGVjLCB0aGUgcHJpbWFyeSBjb25jZXB0IGlzIHRvIGxl
dA0KTWVkaWF0ZWsgRFJNIGRyaXZlciBjYW4gbWFrZSBzdXJlIHByZXZpb3VzIG1lc3NhZ2UgZG9u
ZSBvcg0KYmUgYWJvcnRlZCAoaWYgdGhlIG1lc3NhZ2UgaGFzIG5vdCBzdGFydGVkIHlldCkgYmVm
b3JlIHRoZXkNCnNlbmQgbmV4dCBtZXNzYWdlLg0KDQpCaWJieSBIc2llaCAoMyk6DQogIG1haWxi
b3g6IG1lZGlhdGVrOiBpbXBsZW1lbnQgZmx1c2ggZnVuY3Rpb24NCiAgbWFpbGJveDogbWVkaWF0
ZWs6IHJlbW92ZSBpbXBsZW1lbnRhdGlvbiByZWxhdGVkIHRvIGF0b21pY19leGVjDQogIGR0LWJp
bmRpbmc6IGdjZTogcmVtb3ZlIGF0b21pY19leGVjIGluIG1ib3hlcyBwcm9wZXJ0eQ0KDQogLi4u
L2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9tdGstZ2NlLnR4dCAgIHwgIDEwICstDQogZHJp
dmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYyAgICAgICAgICAgIHwgMTI2ICsrKysrKysr
LS0tLS0tLS0tLQ0KIDIgZmlsZXMgY2hhbmdlZCwgNjAgaW5zZXJ0aW9ucygrKSwgNzYgZGVsZXRp
b25zKC0pDQoNCi0tIA0KMi4xOC4wDQo=

