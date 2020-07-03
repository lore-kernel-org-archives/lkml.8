Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618A0C433E3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34F1E20772
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UlOxZnl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgGCEnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 00:43:01 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:2203 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726288AbgGCEm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 00:42:59 -0400
X-UUID: 3352b89a9d9b46a4b666a3ee5f47ef98-20200703
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XYZtbPuux1C4TIYKkjpGG7jbqpKAStOsqKUBvtJnzA4=;
        b=UlOxZnl7r0ibRCfbBbbMKJzH4dMZmAe5r+P33aGx2qYWw+Nd32E28teFaaZD1orjqdvLRzN6Pne+SOsIS2UGoGzAxp5OoXj37kKlj4p5k6UKOWTmntjHNELCXdIQ9MfpqiXuGk0Fu5oDzjWQcXEWxAnG0keHMk8ufw7Pdpdnjnc=;
X-UUID: 3352b89a9d9b46a4b666a3ee5f47ef98-20200703
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 504613560; Fri, 03 Jul 2020 12:42:56 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Jul 2020 12:42:51 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 3 Jul 2020 12:42:47 +0800
From:   Chao Hao <chao.hao@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>,
        FY Yang <fy.yang@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
        TH Yang <th.yang@mediatek.com>
Subject: [PATCH v6 08/10] iommu/mediatek: Extend protect pa alignment value
Date:   Fri, 3 Jul 2020 12:41:25 +0800
Message-ID: <20200703044127.27438-9-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200703044127.27438-1-chao.hao@mediatek.com>
References: <20200703044127.27438-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 038E0728C1CC9080D0465BC51087B52A7BFC42E938F21F99095E7E982F1C2A602000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U3RhcnRpbmcgd2l0aCBtdDY3NzksIGlvbW11IG5lZWRzIHRvIGV4dGVuZCB0byAyNTYgYnl0ZXMg
ZnJvbSAxMjgNCmJ5dGVzIHdoaWNoIGNhbiBzZW5kIHRoZSBtYXggbnVtYmVyIG9mIGRhdGEgZm9y
IG1lbW9yeSBwcm90ZWN0aW9uDQpwYSBhbGlnbm1lbnQuIFNvIHdlIGNhbiB1c2UgYSBzZXBhcmF0
ZSBwYXRjaCB0byBtb2RpZnkgaXQuDQoNClNpZ25lZC1vZmYtYnk6IENoYW8gSGFvIDxjaGFvLmhh
b0BtZWRpYXRlay5jb20+DQpSZXZpZXdlZC1ieTogTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhpYXMu
YmdnQGdtYWlsLmNvbT4NCi0tLQ0KIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgfCAyICstDQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUu
Yw0KaW5kZXggNWM4ZTE0MTY2OGZjLi5lNzEwMDMwMzdmZmEgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2lvbW11L210a19pb21tdS5jDQorKysgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQpAQCAt
OTgsNyArOTgsNyBAQA0KICNkZWZpbmUgRl9NTVVfSU5UX0lEX0xBUkJfSUQoYSkJCQkoKChhKSA+
PiA3KSAmIDB4NykNCiAjZGVmaW5lIEZfTU1VX0lOVF9JRF9QT1JUX0lEKGEpCQkJKCgoYSkgPj4g
MikgJiAweDFmKQ0KIA0KLSNkZWZpbmUgTVRLX1BST1RFQ1RfUEFfQUxJR04JCQkxMjgNCisjZGVm
aW5lIE1US19QUk9URUNUX1BBX0FMSUdOCQkJMjU2DQogDQogLyoNCiAgKiBHZXQgdGhlIGxvY2Fs
IGFyYml0ZXIgSUQgYW5kIHRoZSBwb3J0aWQgd2l0aGluIHRoZSBsYXJiIGFyYml0ZXINCi0tIA0K
Mi4xOC4wDQo=

