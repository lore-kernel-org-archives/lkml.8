Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36279C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1554D21527
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="J7mOGjfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732196AbgFSJmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 05:42:19 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:33574 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732165AbgFSJmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 05:42:10 -0400
X-UUID: 061b931079204297bac5abaff0d5e7f4-20200619
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=NdvWbt7SwERzP8EgpdUPpJCpCAPBLOEYJIsaPCSnY3U=;
        b=J7mOGjfd4cBqpiT/30veNsMyXAyq+JZisEykhp4+/JfvnMoZFLCx5tpZcqfyqs3FxefApwukg6OBdThCuSv9EqOXJ4uRp87csHf91OV2n9AoL17d3SgUGwdgbC17VDo59T3hUzG3K3sgClzF1aWsd9Ln+vPpIviJ40ka/mPzqcw=;
X-UUID: 061b931079204297bac5abaff0d5e7f4-20200619
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 654226291; Fri, 19 Jun 2020 17:42:05 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 19 Jun 2020 17:42:03 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 19 Jun 2020 17:42:01 +0800
From:   Neal Liu <neal.liu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Neal Liu <neal.liu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Subject: Add MediaTek MT6873 devapc driver
Date:   Fri, 19 Jun 2020 17:41:58 +0800
Message-ID: <1592559720-8482-1-git-send-email-neal.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DEC6BD0ECEC83BC5E2FEC7676357C14324487936CC6DF2BA5AF3EE8EC662E1A12000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlc2UgcGF0Y2ggc2VyaWVzIGludHJvZHVjZSBhIE1lZGlhVGVrIE1UNjg3MyBkZXZhcGMgZHJp
dmVyLg0KDQpNVDY4NzMgYnVzIGZyYWJyaWMgcHJvdmlkZXMgVHJ1c3Rab25lIHNlY3VyaXR5IHN1
cHBvcnQgYW5kIGRhdGEgcHJvdGVjdGlvbiB0byBwcmV2ZW50IHNsYXZlcyBmcm9tIGJlaW5nIGFj
Y2Vzc2VkIGJ5IHVuZXhwZWN0ZWQgbWFzdGVycy4NClRoZSBzZWN1cml0eSB2aW9sYXRpb25zIGFy
ZSBsb2dnZWQgYW5kIHNlbnQgdG8gdGhlIHByb2Nlc3NvciBmb3IgZnVydGhlciBhbmFseXNpcyBv
ciBjb3VudGVybWVhc3VyZXMuDQoNCkFueSBvY2N1cnJlbmNlIG9mIHNlY3VyaXR5IHZpb2xhdGlv
biB3b3VsZCByYWlzZSBhbiBpbnRlcnJ1cHQsIGFuZCBpdCB3aWxsIGJlIGhhbmRsZWQgYnkgZGV2
YXBjLW10Njg3MyBkcml2ZXIuIFRoZSB2aW9sYXRpb24gaW5mb3JtYXRpb24gaXMgcHJpbnRlZCBp
biBvcmRlciB0byBmaW5kIHRoZSBtdXJkZXJlci4NCg0KY2hhbmdlcyBzaW5jZSB2MToNCiAtIHJl
dmlzZSBkdC1iaW5kaW5ncyBzY2hlbWEuIChuZWVkcyBtdDgxOTItY2xrLmggdG8gcGFzcyBkdF9i
aW5kaW5nX2NoZWNrKQ0KIC0gcmVtb3ZlIGRlYnVnZ2luZyBmdW5jdGlvbnMgYW5kIG1ha2UgZHJp
dmVyIG1vcmUgc2ltcGxlLg0KDQoqKiogQkxVUkIgSEVSRSAqKioNCg0KTmVhbCBMaXUgKDIpOg0K
ICBkdC1iaW5kaW5nczogZGV2YXBjOiBhZGQgYmluZGluZ3MgZm9yIGRldmFwYy1tdDY4NzMNCiAg
c29jOiBtZWRpYXRlazogZGV2YXBjOiBhZGQgZGV2YXBjLW10Njg3MyBkcml2ZXINCg0KIC4uLi9z
b2MvbWVkaWF0ZWsvZGV2YXBjL2RldmFwYy1tdDY4NzMueWFtbCAgICB8ICAgNjEgKw0KIGRyaXZl
cnMvc29jL21lZGlhdGVrL0tjb25maWcgICAgICAgICAgICAgICAgICB8ICAgIDYgKw0KIGRyaXZl
cnMvc29jL21lZGlhdGVrL01ha2VmaWxlICAgICAgICAgICAgICAgICB8ICAgIDEgKw0KIGRyaXZl
cnMvc29jL21lZGlhdGVrL2RldmFwYy9LY29uZmlnICAgICAgICAgICB8ICAgMjUgKw0KIGRyaXZl
cnMvc29jL21lZGlhdGVrL2RldmFwYy9NYWtlZmlsZSAgICAgICAgICB8ICAgMTMgKw0KIGRyaXZl
cnMvc29jL21lZGlhdGVrL2RldmFwYy9kZXZhcGMtbXQ2ODczLmMgICB8IDE2NTIgKysrKysrKysr
KysrKysrKysNCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9kZXZhcGMvZGV2YXBjLW10Njg3My5oICAg
fCAgMTExICsrDQogLi4uL3NvYy9tZWRpYXRlay9kZXZhcGMvZGV2YXBjLW10ay1tdWx0aS1hby5j
IHwgIDc1NiArKysrKysrKw0KIC4uLi9zb2MvbWVkaWF0ZWsvZGV2YXBjL2RldmFwYy1tdGstbXVs
dGktYW8uaCB8ICAxODIgKysNCiA5IGZpbGVzIGNoYW5nZWQsIDI4MDcgaW5zZXJ0aW9ucygrKQ0K
IGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29j
L21lZGlhdGVrL2RldmFwYy9kZXZhcGMtbXQ2ODczLnlhbWwNCiBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9zb2MvbWVkaWF0ZWsvZGV2YXBjL0tjb25maWcNCiBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9zb2MvbWVkaWF0ZWsvZGV2YXBjL01ha2VmaWxlDQogY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvc29jL21lZGlhdGVrL2RldmFwYy9kZXZhcGMtbXQ2ODczLmMNCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9zb2MvbWVkaWF0ZWsvZGV2YXBjL2RldmFwYy1tdDY4NzMuaA0KIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3NvYy9tZWRpYXRlay9kZXZhcGMvZGV2YXBjLW10ay1t
dWx0aS1hby5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc29jL21lZGlhdGVrL2RldmFw
Yy9kZXZhcGMtbXRrLW11bHRpLWFvLmgNCg0KLS0gDQoyLjE4LjANCg0K

