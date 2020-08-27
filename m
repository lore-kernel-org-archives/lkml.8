Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B268C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 03:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57B2320786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 03:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WftHxJKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgH0DHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 23:07:02 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:5775 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726798AbgH0DHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 23:07:01 -0400
X-UUID: 56acd8b836974904863ee9712d44b96e-20200827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=2RA0I88lr0d0hGwKF//MrgxKAUGZdVtcyAh7Z0um5Ig=;
        b=WftHxJKrm3UF3wKSCl11XpoKefRD5hMvjqmRBfZg61QfMLoAJWXh1SdVSGC6zmXplzd0vGNUtyL3/OuXIUUMI9+pPObfC/Gnkbz+gjgKvOQ7vgO7XI6c7wmZHXBBkU62mf5gOEyl6CTDhyi1djTffOS5MXo4n0tBqDky9dc0Rbk=;
X-UUID: 56acd8b836974904863ee9712d44b96e-20200827
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1334194242; Thu, 27 Aug 2020 11:06:56 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 27 Aug 2020 11:06:42 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 27 Aug 2020 11:06:35 +0800
From:   Neal Liu <neal.liu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Neal Liu <neal.liu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH v7 1/2] dt-bindings: devapc: add bindings for mtk-devapc
Date:   Thu, 27 Aug 2020 11:06:32 +0800
Message-ID: <1598497593-15781-2-git-send-email-neal.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1598497593-15781-1-git-send-email-neal.liu@mediatek.com>
References: <1598497593-15781-1-git-send-email-neal.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGJpbmRpbmdzIGZvciBtdGstZGV2YXBjLg0KDQpTaWduZWQtb2ZmLWJ5OiBOZWFsIExpdSA8
bmVhbC5saXVAbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc29j
L21lZGlhdGVrL2RldmFwYy55YW1sICAgfCAgIDU4ICsrKysrKysrKysrKysrKysrKysrDQogMSBm
aWxlIGNoYW5nZWQsIDU4IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9kZXZhcGMueWFtbA0KDQpk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRl
ay9kZXZhcGMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVk
aWF0ZWsvZGV2YXBjLnlhbWwNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi42
Yzc2M2Y4DQotLS0gL2Rldi9udWxsDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc29jL21lZGlhdGVrL2RldmFwYy55YW1sDQpAQCAtMCwwICsxLDU4IEBADQorIyBTUERY
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
aXN0IGluIGNsb2NrcyBwcm9wZXJ0eQ0KKyAgICBtYXhJdGVtczogMQ0KKw0KK3JlcXVpcmVkOg0K
KyAgLSBjb21wYXRpYmxlDQorICAtIHJlZw0KKyAgLSBpbnRlcnJ1cHRzDQorICAtIGNsb2Nrcw0K
KyAgLSBjbG9jay1uYW1lcw0KKw0KK2V4YW1wbGVzOg0KKyAgLSB8DQorICAgICNpbmNsdWRlIDxk
dC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQorICAgICNpbmNsdWRl
IDxkdC1iaW5kaW5ncy9jbG9jay9tdDY3NzktY2xrLmg+DQorDQorICAgIGRldmFwYzogZGV2YXBj
QDEwMjA3MDAwIHsNCisgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Njc3OS1kZXZhcGMi
Ow0KKyAgICAgIHJlZyA9IDwweDEwMjA3MDAwIDB4MTAwMD47DQorICAgICAgaW50ZXJydXB0cyA9
IDxHSUNfU1BJIDE2OCBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KKyAgICAgIGNsb2NrcyA9IDwmaW5m
cmFjZmdfYW8gQ0xLX0lORlJBX0RFVklDRV9BUEM+Ow0KKyAgICAgIGNsb2NrLW5hbWVzID0gImRl
dmFwYy1pbmZyYS1jbG9jayI7DQorICAgIH07DQotLSANCjEuNy45LjUNCg==

