Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE239C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC0AC20874
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jCpd8f9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgGBJhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 05:37:33 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:57567 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726805AbgGBJh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 05:37:28 -0400
X-UUID: d9cb19290049469cb5a4d6253553cdb7-20200702
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=cHL3FGvns2Vq3Q+lzPqG/tPY0T/sEGYmRDbEd2Ph2NU=;
        b=jCpd8f9KSqHTHBz+nHWc0cEaktfjIHJ/vfaVobp8cBqsurxP5NwPVPqYcUuU512nS88J2UZ+rKM9OZWWvq16OCH9+I/REqwl74Fou8RFMT6V+VKNVxhl64owiXokMF6MlnPJc4QVPjbRzahoVZedCDltdwCEB8k24WKUpSaNfug=;
X-UUID: d9cb19290049469cb5a4d6253553cdb7-20200702
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1698284110; Thu, 02 Jul 2020 17:37:24 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Jul 2020 17:37:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Jul 2020 17:37:20 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH 1/4] dt-bindings: mediatek: add mediatek,infracfg phandle
Date:   Thu, 2 Jul 2020 17:37:17 +0800
Message-ID: <20200702093721.6063-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 888036A33ECD69FCAC32F294B9ADA91343BDD3CA9220D418C65C109C141F4D452000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGEgZGVzY3JpcHRpb24gZm9yIG1lZGlhdGVrLGluZnJhY2ZnLiBXZSBjYW4gY2hlY2sgaWYg
NEdCIG1vZGUNCmlzIGVuYWJsZSBieSByZWFkaW5nIGl0IGluc3RlYWQgb2YgY2hlY2tpbmcgdGhl
IHVuZXhwb3J0ZWQNCnN5bWJvbCAibWF4X3BmbiIuDQoNClRoaXMgaXMgYSBzdGVwIHRvd2FyZHMg
YnVpbGRpbmcgbXRrX2lvbW11IGFzIGEga2VybmVsIG1vZHVsZS4NCg0KQ2M6IFlvbmcgV3UgPHlv
bmcud3VAbWVkaWF0ZWsuY29tPg0KU2lnbmVkLW9mZi1ieTogTWlsZXMgQ2hlbiA8bWlsZXMuY2hl
bkBtZWRpYXRlay5jb20+DQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
aW9tbXUvbWVkaWF0ZWssaW9tbXUudHh0IHwgMiArKw0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9pb21tdS9tZWRpYXRlayxpb21tdS50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvaW9tbXUvbWVkaWF0ZWssaW9tbXUudHh0DQppbmRleCBjZTU5YTUwNWY1YTQuLmE3ODgx
ZGVhYmNjYSAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9p
b21tdS9tZWRpYXRlayxpb21tdS50eHQNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9pb21tdS9tZWRpYXRlayxpb21tdS50eHQNCkBAIC03NCw2ICs3NCw4IEBAIFJlcXVp
cmVkIHByb3BlcnRpZXM6DQogLSBtZWRpYXRlayxsYXJicyA6IExpc3Qgb2YgcGhhbmRsZSB0byB0
aGUgbG9jYWwgYXJiaXRlcnMgaW4gdGhlIGN1cnJlbnQgU29jcy4NCiAJUmVmZXIgdG8gYmluZGlu
Z3MvbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1sYXJiLnR4dC4gSXQgbXVzdCBzb3J0
DQogCWFjY29yZGluZyB0byB0aGUgbG9jYWwgYXJiaXRlciBpbmRleCwgbGlrZSBsYXJiMCwgbGFy
YjEsIGxhcmIyLi4uDQorLSBtZWRpYXRlayxpbmZyYWNmZzogYSBwaGFuZGxlIHRvIGluZnJhY2Zn
LiBJdCBpcyB1c2VkIHRvIGNvbmZpcm0gaWYgNEdCIG1vZGUgaXMgc2V0Lg0KKwlJdCBpcyBhbiBv
cHRpb25hbCBwcm9wZXJ0eSwgYWRkIGl0IHdoZW4gdGhlIFNvQyBoYXZlIDRnIG1vZGUuDQogLSBp
b21tdS1jZWxscyA6IG11c3QgYmUgMS4gVGhpcyBpcyB0aGUgbXRrX200dV9pZCBhY2NvcmRpbmcg
dG8gdGhlIEhXLg0KIAlTcGVjaWZpZXMgdGhlIG10a19tNHVfaWQgYXMgZGVmaW5lZCBpbg0KIAlk
dC1iaW5kaW5nL21lbW9yeS9tdDI3MDEtbGFyYi1wb3J0LmggZm9yIG10MjcwMSwgbXQ3NjIzDQot
LSANCjIuMTguMA0K

