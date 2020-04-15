Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C2EC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D3FE20575
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WWo1FeKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896888AbgDOLVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 07:21:12 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:52519 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2896766AbgDOLTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:19:12 -0400
X-UUID: c3b887139ce249bc88c868d1af68274f-20200415
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=VxaaBmnZiciOML8KK3Xnbo/VtfQpkB4jCNcyrHqsQOc=;
        b=WWo1FeKNnFH9I+I63Gk9uExc09/f9ECYeUvXSA02B903bEMD3mqIDQ9+dp4h8O3nKPSmaeqVd4veC1jZRrIbrd6tcJNwWJoA0mRgMao7vf6c4Nx7/ejM0iHRfp9sxIKopMnnG4UO73j1KFK9iGX/go5w5oymnTV76gh8fkkfdAc=;
X-UUID: c3b887139ce249bc88c868d1af68274f-20200415
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <anthony.huang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1474518894; Wed, 15 Apr 2020 19:19:04 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 15 Apr 2020 19:18:56 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Apr 2020 19:18:56 +0800
From:   Anthony Huang <anthony.huang@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Subject: Add Mediatek MMDVFS driver
Date:   Wed, 15 Apr 2020 19:18:24 +0800
Message-ID: <1586949506-22990-1-git-send-email-anthony.huang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2FC43E88FC5EC31261F318F81DD4C58D1769D04964F53E9E647465ED3ADE254F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aGlzIHBhdGNoc2V0IGFkZHMgdGhlIE1lZGlhdGVrIE1NRFZGUyhNdWx0aW1lZGlhIER5bmFtaWMg
Vm9sdGFnZSBhbmQNCkZyZXF1ZW5jeSBTY2FsaW5nKSBkcml2ZXIuIFRoZSBtdWx0aW1lZGlhIEhX
cywgc3VjaCBhcyBkaXNwbGF5LCBjYW1lcmEsDQpzaGFyZSB0aGUgc2FtZSBwb3dlciBzdXBwbGll
ciwgYW5kIG9uIHNvbWUgcGxhdGZvcm1zLCB0aGV5IHNoYXJlIHRoZQ0Kc2FtZSBjbG9jayBNVVgu
IElmIGVhY2ggSFcgbmVlZHMgZGlmZmVyZW50IGNsb2NrIGZyZXF1ZW5jeSBhdCB0aGUgc2FtZQ0K
dGltZSwgdGhlIGNsb2NrIE1VWCBtdXN0IGJlIHNldCB0byB0aGUgY2xvY2sgc291cmNlIHdoaWNo
IGNhbiBtZWV0IHRoZQ0KaGlnaGVzdCByZXF1aXJlZCBjbG9jayBmcmVxdWVuY3kuDQoNCkZvbGxv
d2luZyBpbXBsZW1lbnRhdGlvbiBpcyB1c2VkIHRvIGFjaGlldmUgdGhlIGdvYWwuIFRoZXJlIGFy
ZSBPUFAgdGFibGVzDQpmb3IgYWxsIHRoZSBjbG9jayBNVVhzIGZvciBNTSBIV3MgZGVmaW5lZCBp
biBEVFMsIGFudCB0aGVzZSBPUFAgdGFibGVzIGhhdmUNCnRoZSBzYW1lIG51bWJlciBvZiBsZXZl
bHMuIFRoZSBNTURWRlMgcmVnaXN0ZXJzIHRoZSByZWd1bGF0b3IgY2FsbGJhY2sgYW5kDQp0aGUg
TU0gSFdzIGNhbiBnZXQgYXZhaWxhYmxlIGNsb2NrIGZyZXF1ZW5jaWVzIGZyb20gT1BQIHRhYmxl
cyBhbmQgc2V0DQpjb3JyZXNwb25kaW5nIHZvbHRhZ2UgYnkgcmVndWxvciBBUEkuIFRoZSBNTURW
RlMncyBjYWxsYmFjayB3aWxsIGJlDQp0cmlnZ2VyZWQgaWYgdGhlIHZvbHRhZ2UgaXMgY2hhbmdl
ZCBhbmQgdGhpcyB2b2x0YWdlIHJlcHJlc2VudHMgdGhlIGhpZ2hlc3QNCnJlcXVpcmVkIE9QUCBs
ZXZlbC4gVGhlIE1NRFZGUyBoYXMgYSBtYXBwaW5nIHRhYmxlOiB3aGljaCBjbG9jayBzb3VyY2UN
CnNob3VsZCBiZSBzZXQgdG8gZWFjaCBjbG9jayBNVVggZm9yIGV2ZXJ5IE9QUCBsZXZlbC4gU28g
YWxsIHRoZSBjbG9jayBNVVhzDQp3aWxsIGJlIHNldCB0byB0aGUgY2xvY2sgc291cmNlcyBhY2Nv
cmRpbmcgdG8gdGhlIGN1cnJlbnQgT1BQIGxldmVsIGluIHRoZQ0KTU1EVkZTJ3MgcmVndWxhdG9y
IGNhbGxiYWNrLg0KDQoNCg0KQW50aG9ueSBIdWFuZyAoMik6DQogIGR0LWJpbmRpbmdzOiBzb2M6
IG1lZGlhdGVrOiBBZGQgZG9jdW1lbnQgZm9yIG1tZHZmcyBkcml2ZXINCiAgc29jOiBtZWRpYXRl
azogQWRkIG10ay1tbWR2ZnMgZHJpdmVyDQoNCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2Mv
bWVkaWF0ZWsvbW1kdmZzLnlhbWwgICB8ICAxOTggKysrKysrKysrKysrKw0KIGRyaXZlcnMvc29j
L21lZGlhdGVrL0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgIHwgICAgOSArDQogZHJpdmVy
cy9zb2MvbWVkaWF0ZWsvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgfCAgICAxICsNCiBk
cml2ZXJzL3NvYy9tZWRpYXRlay9tdGstbW1kdmZzLmMgICAgICAgICAgICAgICAgICB8ICAzMTIg
KysrKysrKysrKysrKysrKysrKysNCiA0IGZpbGVzIGNoYW5nZWQsIDUyMCBpbnNlcnRpb25zKCsp
DQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
b2MvbWVkaWF0ZWsvbW1kdmZzLnlhbWwNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXRrLW1tZHZmcy5jDQoNCi0tIA0KMS43LjkuNQ==

