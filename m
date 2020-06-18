Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5E9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D901920707
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BHnl+ojv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbgFRMbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:31:36 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:52814 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726982AbgFRMbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:31:36 -0400
X-UUID: c8b391ed12af4425bc33560d78c90fab-20200618
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=IdkUN6cylx03pQG/oDT7DQeFHBUy2IznlAtWG2KPrdE=;
        b=BHnl+ojvldDF7DGK/g7xfJrozNynqfFSSJ7gwzB6D9OiIdOB8ONbXH6fMWzJ3avt+xTvNbqf4P3r1ujlpJKXXgRjMny0HLPv0peOYq76IsmoRrcKA39dAUJqzal2ws/zU0S0tHOMRtDWsoO5pgeHON2HiJPDL7z7gddj4ZZqMxI=;
X-UUID: c8b391ed12af4425bc33560d78c90fab-20200618
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <hanks.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 639806830; Thu, 18 Jun 2020 20:31:32 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 18 Jun 2020 20:31:28 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Jun 2020 20:31:27 +0800
From:   Hanks Chen <hanks.chen@mediatek.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Hanks Chen <hanks.chen@mediatek.com>
Subject: [PATCH 1/1] irqchip: Add config MTK_SYSIRQ and MTK_CIRQ
Date:   Thu, 18 Jun 2020 20:31:11 +0800
Message-ID: <1592483471-14806-1-git-send-email-hanks.chen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1395E1B7B1501B6DCA231C05D5DB73483CF77046C33F0D234CB5FF87FD79AA9B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWVkaWF0ZWsgc3lzaXJxIGFuZCBjaXJxIGRyaXZlcnMgYXMtaXMgd2VyZSBib3VuZCB0b2dldGhl
ciB0byB0aGUgY29uZmlnDQpvZiBBUkNIX01FRElBVEVLLiAgVGhlc2UgdHdvIGRyaXZlcnMgc2hv
dWxkIGJlIGFibGUgdG8gYmUgY29uZmlndXJlZA0Kc2VwYXJhdGVseS4gIEZvciBleGFtcGxlLCBv
biBuZXcgTWVkaWF0ZWsgbW9iaWxlIGNoaXBzIHN1Y2ggYXMgRGltZW5zaXR5DQo4MjAsIHRoZSBz
eXNpcnEgZHJpdmVyIGlzIG5vdCB1c2VkIHNpbmNlIHRoZSBoYXJkd2FyZSBtb2R1bGUgaXMgcmVt
b3ZlZC4NCg0KQWRkIHR3byBuZXcgY29uZmlncyB0byBzeXNpcnEgYW5kIGNpcnEgZHJpdmVycy4N
Ci0gY29uZmlnIE1US19TWVNJUlEgZm9yIHRoZSBpbnRlcnJ1cHQgcG9sYXJpdHkgY29udHJvbGxl
ciBkcml2ZXI6IHN5c2lycQ0KLSBjb25maWcgTVRLX0NJUlEgZm9yIHRoZSBsb3ctcG93ZXIgaW50
ZXJydXB0IGRyaXZlcjogY2lycQ0KDQpTaWduZWQtb2ZmLWJ5OiBjYy5od2FuZyA8Y2MuaHdhbmdA
bWVkaWF0ZWsuY29tPg0KU2lnbmVkLW9mZi1ieTogSGFua3MgQ2hlbiA8aGFua3MuY2hlbkBtZWRp
YXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2lycWNoaXAvS2NvbmZpZyAgfCAgIDEyICsrKysrKysr
KysrKw0KIGRyaXZlcnMvaXJxY2hpcC9NYWtlZmlsZSB8ICAgIDMgKystDQogMiBmaWxlcyBjaGFu
Z2VkLCAxNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2lycWNoaXAvS2NvbmZpZyBiL2RyaXZlcnMvaXJxY2hpcC9LY29uZmlnDQppbmRleCAyOWZl
YWQyLi5jYzlhYTE4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pcnFjaGlwL0tjb25maWcNCisrKyBi
L2RyaXZlcnMvaXJxY2hpcC9LY29uZmlnDQpAQCAtNTcyLDQgKzU3MiwxNiBAQCBjb25maWcgTE9P
TkdTT05fUENIX01TSQ0KIAloZWxwDQogCSAgU3VwcG9ydCBmb3IgdGhlIExvb25nc29uIFBDSCBN
U0kgQ29udHJvbGxlci4NCiANCitjb25maWcgTVRLX1NZU0lSUQ0KKwl0cmlzdGF0ZSAiTWVkaWF0
ZWsgaW50ZXJydXB0IHBvbGFyaXR5IGNvbnRyb2xsZXIiDQorCWhlbHANCisJICBJbnRlcnJ1cHQg
cG9sYXJpdHkgY29udHJvbGxlciBkcml2ZXIgdG8gc3dhcCBwb2xhcml0eSBmb3INCisJICBpbnRl
cnJ1cHRzIGZvciBNZWRpYXRlayBtb2JpbGUgY2hpcHMuDQorDQorY29uZmlnIE1US19DSVJRDQor
CWJvb2wgIk1lZGlhdGVrIGxvdy1wb3dlciBpbnRlcnJ1cHQgY29udHJvbGxlciINCisJaGVscA0K
KwkgIExvdy1wb3dlciBpbnRlcnJ1cHQgY29udHJvbGxlciBkcml2ZXIgdG8gbW9uaXRvciBJUlFT
DQorCSAgaW4gdGhlIHNsZWVwIG1vZGUgZm9yIE1lZGlhdGVrIG1vYmlsZSBjaGlwcy4NCisNCiBl
bmRtZW51DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pcnFjaGlwL01ha2VmaWxlIGIvZHJpdmVycy9p
cnFjaGlwL01ha2VmaWxlDQppbmRleCAxMzNmOWM0Li4zMDQyMWQyIDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9pcnFjaGlwL01ha2VmaWxlDQorKysgYi9kcml2ZXJzL2lycWNoaXAvTWFrZWZpbGUNCkBA
IC02OSw3ICs2OSw4IEBAIG9iai0kKENPTkZJR19CQ003MTIwX0wyX0lSUSkJCSs9IGlycS1iY203
MTIwLWwyLm8NCiBvYmotJChDT05GSUdfQlJDTVNUQl9MMl9JUlEpCQkrPSBpcnEtYnJjbXN0Yi1s
Mi5vDQogb2JqLSQoQ09ORklHX0tFWVNUT05FX0lSUSkJCSs9IGlycS1rZXlzdG9uZS5vDQogb2Jq
LSQoQ09ORklHX01JUFNfR0lDKQkJCSs9IGlycS1taXBzLWdpYy5vDQotb2JqLSQoQ09ORklHX0FS
Q0hfTUVESUFURUspCQkrPSBpcnEtbXRrLXN5c2lycS5vIGlycS1tdGstY2lycS5vDQorb2JqLSQo
Q09ORklHX01US19TWVNJUlEpCQkrPSBpcnEtbXRrLXN5c2lycS5vDQorb2JqLSQoQ09ORklHX01U
S19DSVJRKQkJCSs9IGlycS1tdGstY2lycS5vDQogb2JqLSQoQ09ORklHX0FSQ0hfRElHSUNPTE9S
KQkJKz0gaXJxLWRpZ2ljb2xvci5vDQogb2JqLSQoQ09ORklHX1JFTkVTQVNfSDgzMDBIX0lOVEMp
CSs9IGlycS1yZW5lc2FzLWg4MzAwaC5vDQogb2JqLSQoQ09ORklHX1JFTkVTQVNfSDhTX0lOVEMp
CQkrPSBpcnEtcmVuZXNhcy1oOHMubw0KLS0gDQoxLjcuOS41DQo=

