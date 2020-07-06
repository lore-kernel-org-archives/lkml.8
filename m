Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18958C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A092074F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ApSbqI2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgGFJ2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 05:28:24 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37617 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728381AbgGFJ2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 05:28:23 -0400
X-UUID: eaa565ad2c714a31a042ac80f6ec7b01-20200706
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=u2Bkt9DjBrhYa1J0kIELWnKBokVBfauhP1saEFved5M=;
        b=ApSbqI2ZyV2iX7VDysbEX2K+D1s+cG0yf/C25Nru260/rgVSe/TqGqMMZ7T0Dj1ijkCQUXeAw08wdF6g/Gi1yWuOATrY9r6OffkMFPiEGXT8EID1SkAIYYiFLrhz0UGzTqleb0JjqYIRhaR2YY05IBwsK5AM7NEqsPW4hV66GxU=;
X-UUID: eaa565ad2c714a31a042ac80f6ec7b01-20200706
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 24518554; Mon, 06 Jul 2020 17:28:22 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 6 Jul 2020 17:28:11 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 6 Jul 2020 17:28:12 +0800
From:   Neal Liu <neal.liu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Neal Liu <neal.liu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Add MediaTek MT6779 devapc driver
Date:   Mon, 6 Jul 2020 17:28:11 +0800
Message-ID: <1594027693-19530-1-git-send-email-neal.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlc2UgcGF0Y2ggc2VyaWVzIGludHJvZHVjZSBhIE1lZGlhVGVrIE1UNjc3OSBkZXZhcGMgZHJp
dmVyLg0KDQpNVDY3NzkgYnVzIGZyYWJyaWMgcHJvdmlkZXMgVHJ1c3Rab25lIHNlY3VyaXR5IHN1
cHBvcnQgYW5kIGRhdGENCnByb3RlY3Rpb24gdG8gcHJldmVudCBzbGF2ZXMgZnJvbSBiZWluZyBh
Y2Nlc3NlZCBieSB1bmV4cGVjdGVkDQptYXN0ZXJzLg0KVGhlIHNlY3VyaXR5IHZpb2xhdGlvbnMg
YXJlIGxvZ2dlZCBhbmQgc2VudCB0byB0aGUgcHJvY2Vzc29yIGZvcg0KZnVydGhlciBhbmFseXNp
cyBvciBjb3VudGVybWVhc3VyZXMuDQoNCkFueSBvY2N1cnJlbmNlIG9mIHNlY3VyaXR5IHZpb2xh
dGlvbiB3b3VsZCByYWlzZSBhbiBpbnRlcnJ1cHQsDQphbmQgaXQgd2lsbCBiZSBoYW5kbGVkIGJ5
IGRldmFwYy1tdDY3NzkgZHJpdmVyLg0KVGhlIHZpb2xhdGlvbiBpbmZvcm1hdGlvbiBpcyBwcmlu
dGVkIGluIG9yZGVyIHRvIGZpbmQgdGhlIG11cmRlcmVyLg0KDQoNCioqKiBCTFVSQiBIRVJFICoq
Kg0KDQpOZWFsIExpdSAoMik6DQogIGR0LWJpbmRpbmdzOiBkZXZhcGM6IGFkZCBiaW5kaW5ncyBm
b3IgZGV2YXBjLW10Njc3OQ0KICBzb2M6IG1lZGlhdGVrOiBkZXZhcGM6IGFkZCBkZXZhcGMtbXQ2
Nzc5IGRyaXZlcg0KDQogLi4uL3NvYy9tZWRpYXRlay9kZXZhcGMvZGV2YXBjLW10Njc3OS55YW1s
ICAgIHwgICA1OCArDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvS2NvbmZpZyAgICAgICAgICAgICAg
ICAgIHwgICAgNiArDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvTWFrZWZpbGUgICAgICAgICAgICAg
ICAgIHwgICAgMSArDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvZGV2YXBjL0tjb25maWcgICAgICAg
ICAgIHwgICAxNyArDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvZGV2YXBjL01ha2VmaWxlICAgICAg
ICAgIHwgICAxMCArDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvZGV2YXBjL2RldmFwYy1tdDY3Nzku
YyAgIHwgMTExMSArKysrKysrKysrKysrKysrKw0KIGRyaXZlcnMvc29jL21lZGlhdGVrL2RldmFw
Yy9kZXZhcGMtbXQ2Nzc5LmggICB8ICAgOTkgKysNCiA3IGZpbGVzIGNoYW5nZWQsIDEzMDIgaW5z
ZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3Mvc29jL21lZGlhdGVrL2RldmFwYy9kZXZhcGMtbXQ2Nzc5LnlhbWwNCiBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9zb2MvbWVkaWF0ZWsvZGV2YXBjL0tjb25maWcNCiBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9zb2MvbWVkaWF0ZWsvZGV2YXBjL01ha2VmaWxlDQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvc29jL21lZGlhdGVrL2RldmFwYy9kZXZhcGMtbXQ2Nzc5LmMN
CiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zb2MvbWVkaWF0ZWsvZGV2YXBjL2RldmFwYy1t
dDY3NzkuaA0KDQotLSANCjIuMTguMA0K

