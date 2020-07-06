Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF44C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A69F720724
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nDzDTDNV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgGFJ20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 05:28:26 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51610 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728830AbgGFJ2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 05:28:25 -0400
X-UUID: 7858411cac86465f8898711f782df2a2-20200706
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=4WjiBQd4d63kHu1QOlYgrdqAunDxcjs/OX4hZYaIPsc=;
        b=nDzDTDNVLAAKd30DOUONMRP38PcAC8U8V3t63tsXXmo9dZ1JIMlkeWO9S7Kqk8eljh3/4RBuyoHBiy0rpwvYdeEiDX52xaDbnGBFLvPp0LlI8LKfYUjmPZLEfnBi+wncyVd1AVGI8URpacrHnjiUqwC0SBtR6xxNKXi3ede0VBI=;
X-UUID: 7858411cac86465f8898711f782df2a2-20200706
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 806493646; Mon, 06 Jul 2020 17:28:19 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH 1/2] dt-bindings: devapc: add bindings for devapc-mt6779
Date:   Mon, 6 Jul 2020 17:28:12 +0800
Message-ID: <1594027693-19530-2-git-send-email-neal.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1594027693-19530-1-git-send-email-neal.liu@mediatek.com>
References: <1594027693-19530-1-git-send-email-neal.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 34FB7792E0C6A836072038E025ADCDE4B70ADA2489711A1080C7688B5837E21E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGJpbmRpbmdzIGZvciBNVDY3NzkgZGV2YXBjLg0KDQpTaWduZWQtb2ZmLWJ5OiBOZWFsIExp
dSA8bmVhbC5saXVAbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4uL3NvYy9tZWRpYXRlay9kZXZhcGMv
ZGV2YXBjLW10Njc3OS55YW1sICAgICAgICAgfCAgIDU4ICsrKysrKysrKysrKysrKysrKysrDQog
MSBmaWxlIGNoYW5nZWQsIDU4IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9kZXZhcGMvZGV2YXBj
LW10Njc3OS55YW1sDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc29jL21lZGlhdGVrL2RldmFwYy9kZXZhcGMtbXQ2Nzc5LnlhbWwgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVrL2RldmFwYy9kZXZhcGMtbXQ2Nzc5
LnlhbWwNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi5iODBmNGQ3DQotLS0g
L2Rldi9udWxsDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21l
ZGlhdGVrL2RldmFwYy9kZXZhcGMtbXQ2Nzc5LnlhbWwNCkBAIC0wLDAgKzEsNTggQEANCisjIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBCU0QtMi1DbGF1c2UpDQorIyAjIENv
cHlyaWdodCAyMDIwIE1lZGlhVGVrIEluYy4NCislWUFNTCAxLjINCistLS0NCiskaWQ6ICJodHRw
Oi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9zb2MvbWVkaWF0ZWsvZGV2YXBjL2RldmFwYy1tdDY3
NzkueWFtbCMiDQorJHNjaGVtYTogImh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMv
Y29yZS55YW1sIyINCisNCit0aXRsZTogTWVkaWFUZWsgTVQ2Nzc5IERldmljZSBBY2Nlc3MgUGVy
bWlzc2lvbiBDb250cm9sIGRyaXZlcg0KKw0KK2Rlc2NyaXB0aW9uOiB8DQorICBNZWRpYVRlayBN
VDY3NzkgYnVzIGZyYWJyaWMgcHJvdmlkZXMgVHJ1c3Rab25lIHNlY3VyaXR5IHN1cHBvcnQgYW5k
IGRhdGENCisgIHByb3RlY3Rpb24gdG8gcHJldmVudCBzbGF2ZXMgZnJvbSBiZWluZyBhY2Nlc3Nl
ZCBieSB1bmV4cGVjdGVkIG1hc3RlcnMuDQorICBUaGUgc2VjdXJpdHkgdmlvbGF0aW9ucyBhcmUg
bG9nZ2VkIGFuZCBzZW50IHRvIHRoZSBwcm9jZXNzb3IgZm9yIGZ1cnRoZXINCisgIGFuYWx5c2lz
IGFuZCBjb3VudGVybWVhc3VyZXMuDQorDQorbWFpbnRhaW5lcnM6DQorICAtIE5lYWwgTGl1IDxu
ZWFsLmxpdUBtZWRpYXRlay5jb20+DQorDQorcHJvcGVydGllczoNCisgIGNvbXBhdGlibGU6DQor
ICAgIGVudW06DQorICAgICAgLSBtZWRpYXRlayxtdDY3NzktZGV2YXBjDQorDQorICByZWc6DQor
ICAgIGRlc2NyaXB0aW9uOiBUaGUgYmFzZSBhZGRyZXNzIG9mIGRldmFwYyByZWdpc3RlciBiYW5r
DQorICAgIG1heEl0ZW1zOiAxDQorDQorICBpbnRlcnJ1cHRzOg0KKyAgICBkZXNjcmlwdGlvbjog
QSBzaW5nbGUgaW50ZXJydXB0IHNwZWNpZmllcg0KKyAgICBtYXhJdGVtczogMQ0KKw0KKyAgY2xv
Y2tzOg0KKyAgICBkZXNjcmlwdGlvbjogQ29udGFpbnMgbW9kdWxlIGNsb2NrIHNvdXJjZSBhbmQg
Y2xvY2sgbmFtZXMNCisgICAgbWF4SXRlbXM6IDENCisNCisgIGNsb2NrLW5hbWVzOg0KKyAgICBk
ZXNjcmlwdGlvbjogTmFtZXMgb2YgdGhlIGNsb2NrcyBsaXN0IGluIGNsb2NrcyBwcm9wZXJ0eQ0K
KyAgICBtYXhJdGVtczogMQ0KKw0KK3JlcXVpcmVkOg0KKyAgLSBjb21wYXRpYmxlDQorICAtIHJl
Zw0KKyAgLSBpbnRlcnJ1cHRzDQorICAtIGNsb2Nrcw0KKyAgLSBjbG9jay1uYW1lcw0KKw0KK2V4
YW1wbGVzOg0KKyAgLSB8DQorICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29u
dHJvbGxlci9hcm0tZ2ljLmg+DQorICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay9tdDY3
NzktY2xrLmg+DQorDQorICAgIGRldmFwYzogZGV2YXBjQDEwMjA3MDAwIHsNCisgICAgICBjb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10Njc3OS1kZXZhcGMiOw0KKyAgICAgIHJlZyA9IDwweDEwMjA3
MDAwIDB4MTAwMD47DQorICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDE2OCBJUlFfVFlQRV9M
RVZFTF9MT1c+Ow0KKyAgICAgIGNsb2NrcyA9IDwmaW5mcmFjZmdfYW8gQ0xLX0lORlJBX0RFVklD
RV9BUEM+Ow0KKyAgICAgIGNsb2NrLW5hbWVzID0gImRldmFwYy1pbmZyYS1jbG9jayI7DQorICAg
IH07DQotLSANCjEuNy45LjUNCg==

