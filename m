Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81955C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63DEA206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VNy6BSxH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgGIJM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 05:12:29 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51599 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726211AbgGIJM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 05:12:28 -0400
X-UUID: 81185da012804daea3709e7722070278-20200709
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qd/l2ng/0l+Gi9Tf+m12gtyHV45xTKoWAIi8K6LgRjc=;
        b=VNy6BSxHnYazrySmA/dMhTYlhRv40eKlsB/J65eTLTbp8/aPKqfn537gPxKo0pHspLDEUzefx0PJSsjTODuke2a3PkGq+zziBbyLwMKrYjcTa+rSirFHTBeR4SBmRgo7ko8BsgClFLvARH8zxIB0aVlCxfVz5eqw1+bbMn96qKc=;
X-UUID: 81185da012804daea3709e7722070278-20200709
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1422258399; Thu, 09 Jul 2020 17:12:25 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 9 Jul 2020 17:12:15 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 9 Jul 2020 17:12:18 +0800
From:   Neal Liu <neal.liu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Neal Liu <neal.liu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH v2 1/2] dt-bindings: devapc: add bindings for mtk-devapc
Date:   Thu, 9 Jul 2020 17:12:06 +0800
Message-ID: <1594285927-1840-2-git-send-email-neal.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1594285927-1840-1-git-send-email-neal.liu@mediatek.com>
References: <1594285927-1840-1-git-send-email-neal.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 0E15991C4C7F97952111FB4DE219BB39A44992477E5D35D7CD0F363BB37AF36B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGJpbmRpbmdzIGZvciBtdGstZGV2YXBjLg0KDQpTaWduZWQtb2ZmLWJ5OiBOZWFsIExpdSA8
bmVhbC5saXVAbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc29j
L21lZGlhdGVrL2RldmFwYy55YW1sICAgfCAgIDgyICsrKysrKysrKysrKysrKysrKysrDQogMSBm
aWxlIGNoYW5nZWQsIDgyIGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9kZXZhcGMueWFtbA0KDQpk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRl
ay9kZXZhcGMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVk
aWF0ZWsvZGV2YXBjLnlhbWwNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi5m
MDgyNDNlDQotLS0gL2Rldi9udWxsDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc29jL21lZGlhdGVrL2RldmFwYy55YW1sDQpAQCAtMCwwICsxLDgyIEBADQorIyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAgT1IgQlNELTItQ2xhdXNlKQ0KKyMgIyBDb3B5
cmlnaHQgMjAyMCBNZWRpYVRlayBJbmMuDQorJVlBTUwgMS4yDQorLS0tDQorJGlkOiAiaHR0cDov
L2RldmljZXRyZWUub3JnL3NjaGVtYXMvc29jL21lZGlhdGVrL2RldmFwYy55YW1sIyINCiskc2No
ZW1hOiAiaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjIg0KKw0K
K3RpdGxlOiBNZWRpYVRlayBEZXZpY2UgQWNjZXNzIFBlcm1pc3Npb24gQ29udHJvbCBkcml2ZXIN
CisNCitkZXNjcmlwdGlvbjogfA0KKyAgTWVkaWFUZWsgYnVzIGZhYnJpYyBwcm92aWRlcyBUcnVz
dFpvbmUgc2VjdXJpdHkgc3VwcG9ydCBhbmQgZGF0YQ0KKyAgcHJvdGVjdGlvbiB0byBwcmV2ZW50
IHNsYXZlcyBmcm9tIGJlaW5nIGFjY2Vzc2VkIGJ5IHVuZXhwZWN0ZWQgbWFzdGVycy4NCisgIFRo
ZSBzZWN1cml0eSB2aW9sYXRpb24gaXMgbG9nZ2VkIGFuZCBzZW50IHRvIHRoZSBwcm9jZXNzb3Ig
Zm9yIGZ1cnRoZXINCisgIGFuYWx5c2lzIGFuZCBjb3VudGVybWVhc3VyZXMuDQorDQorbWFpbnRh
aW5lcnM6DQorICAtIE5lYWwgTGl1IDxuZWFsLmxpdUBtZWRpYXRlay5jb20+DQorDQorcHJvcGVy
dGllczoNCisgIGNvbXBhdGlibGU6DQorICAgIGVudW06DQorICAgICAgLSBtZWRpYXRlayxtdDY3
NzktZGV2YXBjDQorDQorICByZWc6DQorICAgIGRlc2NyaXB0aW9uOiBUaGUgYmFzZSBhZGRyZXNz
IG9mIGRldmFwYyByZWdpc3RlciBiYW5rDQorICAgIG1heEl0ZW1zOiAxDQorDQorICBpbnRlcnJ1
cHRzOg0KKyAgICBkZXNjcmlwdGlvbjogQSBzaW5nbGUgaW50ZXJydXB0IHNwZWNpZmllcg0KKyAg
ICBtYXhJdGVtczogMQ0KKw0KKyAgY2xvY2tzOg0KKyAgICBkZXNjcmlwdGlvbjogQ29udGFpbnMg
bW9kdWxlIGNsb2NrIHNvdXJjZSBhbmQgY2xvY2sgbmFtZXMNCisgICAgbWF4SXRlbXM6IDENCisN
CisgIGNsb2NrLW5hbWVzOg0KKyAgICBkZXNjcmlwdGlvbjogTmFtZXMgb2YgdGhlIGNsb2NrcyBs
aXN0IGluIGNsb2NrcyBwcm9wZXJ0eQ0KKyAgICBtYXhJdGVtczogMQ0KKw0KKyAgbWVkaWF0ZWst
c2x2X3R5cGVfbnVtOg0KKyAgICBkZXNjcmlwdGlvbjogTnVtYmVycyBvZiBzbGF2ZSB0eXBlIGlu
IG1lZGlhdGVrIHBsYXRmb3JtDQorICAgIG1heEl0ZW1zOiAxDQorDQorICBtZWRpYXRlay12aW9f
ZGJnczoNCisgICAgZGVzY3JpcHRpb246IFRoZSBtYXNrIGJpdCBhbmQgc3RhcnQgYml0IG9mIGRl
dmFwYyB2aW9sYXRpb24gZGVidWcgcmVnaXN0ZXJzDQorICAgIG1heEl0ZW1zOiA1DQorDQorICBt
ZWRpYXRlay1wZHNfb2Zmc2V0Og0KKyAgICBkZXNjcmlwdGlvbjogVGhlIG9mZnNldCBvZiBkZXZh
cGMgcGRzIHJlZ2lzdGVycw0KKyAgICBtYXhJdGVtczogMQ0KKw0KK3JlcXVpcmVkOg0KKyAgLSBj
b21wYXRpYmxlDQorICAtIHJlZw0KKyAgLSBpbnRlcnJ1cHRzDQorICAtIGNsb2Nrcw0KKyAgLSBj
bG9jay1uYW1lcw0KKyAgLSBtZWRpYXRlay1zbHZfdHlwZV9udW0NCisgIC0gbWVkaWF0ZWstdmlv
X2RiZ3MNCisgIC0gbWVkaWF0ZWstcGRzX29mZnNldA0KKw0KK2V4YW1wbGVzOg0KKyAgLSB8DQor
ICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+
DQorICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay9tdDY3NzktY2xrLmg+DQorDQorICAg
IGRldmFwYzogZGV2YXBjQDEwMjA3MDAwIHsNCisgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVr
LG10Njc3OS1kZXZhcGMiOw0KKyAgICAgIHJlZyA9IDwweDEwMjA3MDAwIDB4MTAwMD47DQorICAg
ICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDE2OCBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KKyAgICAg
IGNsb2NrcyA9IDwmaW5mcmFjZmdfYW8gQ0xLX0lORlJBX0RFVklDRV9BUEM+Ow0KKyAgICAgIGNs
b2NrLW5hbWVzID0gImRldmFwYy1pbmZyYS1jbG9jayI7DQorDQorICAgICAgbWVkaWF0ZWstc2x2
X3R5cGVfbnVtID0gL2JpdHMvIDggPDE+Ow0KKyAgICAgIG1lZGlhdGVrLXZpb19kYmdzID0gPDB4
MDAwMEZGRkYgMHgwPiwNCisgICAgICAgICAgICAgICAgICAgICAgICAgIDwweDAwM0YwMDAwIDB4
MTA+LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgPDB4MDA0MDAwMDAgMHgxNj4sDQorICAg
ICAgICAgICAgICAgICAgICAgICAgICA8MHgwMDgwMDAwMCAweDE3PiwNCisgICAgICAgICAgICAg
ICAgICAgICAgICAgIDwweDBGMDAwMDAwIDB4MTg+Ow0KKyAgICAgIG1lZGlhdGVrLXBkc19vZmZz
ZXQgPSA8MHgwIDB4NDAwIDB4OTAwIDB4OTA0DQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAweEYwMCAweEYxMCAweEYxNCAweEYyMD47DQorICAgIH07DQotLSANCjEuNy45LjUNCg==

