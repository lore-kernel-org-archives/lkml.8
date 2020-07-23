Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE1CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E6B8208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="afA/FzuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgGWM7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:59:14 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:1179 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728797AbgGWM7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:59:12 -0400
X-UUID: 80e6315af1c245779b462d1fb305a47f-20200723
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=OFP3aVnGFLwqIDX2jIQwWUUmJ/SO9/pdmEsZz66Hvtc=;
        b=afA/FzuHAFiROy3phSUdczqHV7Bp1gjZXKQR3EslP9cQCERjMRs5YWLz2jceQRd9qzUq6KFo7e73hUPIS4P21mwbMJEBKV8KWg5sSQU86I4AgTIVbyr1Uf6hJnD9sGZ1QCRWriRCbY1ttYJN2slDSQdFIwEV27VHQsj2QZWkdmA=;
X-UUID: 80e6315af1c245779b462d1fb305a47f-20200723
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1198603443; Thu, 23 Jul 2020 20:59:07 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Jul 2020 20:59:04 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Jul 2020 20:59:06 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Josef Friedl <josef.friedl@speed.at>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Wen Su <wen.su@mediatek.com>
Subject: [PATCH 3/8] dt-bindings: regulator: Add document for MT6359 regulator
Date:   Thu, 23 Jul 2020 20:58:48 +0800
Message-ID: <1595509133-5358-4-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1595509133-5358-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1595509133-5358-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogV2VuIFN1IDx3ZW4uc3VAbWVkaWF0ZWsuY29tPg0KDQphZGQgZHQtYmluZGluZyBkb2N1
bWVudCBmb3IgTWVkaWFUZWsgTVQ2MzU5IFBNSUMNCg0KU2lnbmVkLW9mZi1ieTogV2VuIFN1IDx3
ZW4uc3VAbWVkaWF0ZWsuY29tPg0KU2lnbmVkLW9mZi1ieTogSHNpbi1Ic2l1bmcgV2FuZyA8aHNp
bi1oc2l1bmcud2FuZ0BtZWRpYXRlay5jb20+DQpSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJv
YmhAa2VybmVsLm9yZz4NCi0tLQ0KIC4uLi9iaW5kaW5ncy9yZWd1bGF0b3IvbXQ2MzU5LXJlZ3Vs
YXRvci50eHQgICAgICAgIHwgNTggKysrKysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFu
Z2VkLCA1OCBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9yZWd1bGF0b3IvbXQ2MzU5LXJlZ3VsYXRvci50eHQNCg0KZGlm
ZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZWd1bGF0b3IvbXQ2
MzU5LXJlZ3VsYXRvci50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVn
dWxhdG9yL210NjM1OS1yZWd1bGF0b3IudHh0DQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXgg
MDAwMDAwMC4uYzg2YWFhOQ0KLS0tIC9kZXYvbnVsbA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3JlZ3VsYXRvci9tdDYzNTktcmVndWxhdG9yLnR4dA0KQEAgLTAsMCAr
MSw1OCBAQA0KK01lZGlhdGVrIE1UNjM1OSBSZWd1bGF0b3INCisNCitSZXF1aXJlZCBwcm9wZXJ0
aWVzOg0KKy0gY29tcGF0aWJsZTogIm1lZGlhdGVrLG10NjM1OS1yZWd1bGF0b3IiDQorLSBtdDYz
NTlyZWd1bGF0b3I6IExpc3Qgb2YgcmVndWxhdG9ycyBwcm92aWRlZCBieSB0aGlzIGNvbnRyb2xs
ZXIuIEl0IGlzIG5hbWVkDQorICBhY2NvcmRpbmcgdG8gaXRzIHJlZ3VsYXRvciB0eXBlLCBidWNr
XzxuYW1lPiBhbmQgbGRvXzxuYW1lPi4NCisgIFRoZSBkZWZpbml0aW9uIGZvciBlYWNoIG9mIHRo
ZXNlIG5vZGVzIGlzIGRlZmluZWQgdXNpbmcgdGhlIHN0YW5kYXJkIGJpbmRpbmcNCisgIGZvciBy
ZWd1bGF0b3JzIGF0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZWd1bGF0b3Iv
cmVndWxhdG9yLnR4dC4NCisNCitUaGUgdmFsaWQgbmFtZXMgZm9yIHJlZ3VsYXRvcnMgYXJlOg0K
K0JVQ0s6DQorICBidWNrX3ZzMSwgYnVja192Z3B1MTEsIGJ1Y2tfdm1vZGVtLCBidWNrX3ZwdSwg
YnVja192Y29yZSwgYnVja192czIsDQorICBidWNrX3ZwYSwgYnVja192cHJvYzIsIGJ1Y2tfdnBy
b2MxLCBidWNrX3Zjb3JlX3NzaHViDQorTERPOg0KKyAgbGRvX3ZhdWQxOCwgbGRvX3ZzaW0xLCBs
ZG9fdmliciwgbGRvX3ZyZjEyLCBsZG9fdnVzYiwgbGRvX3ZzcmFtX3Byb2MyLA0KKyAgbGRvX3Zp
bzE4LCBsZG9fdmNhbWlvLCBsZG9fdmNuMTgsIGxkb192ZmUyOCwgbGRvX3ZjbjEzLCBsZG9fdmNu
MzNfMV9idCwNCisgIGxkb192Y24xM18xX3dpZmksIGxkb192YXV4MTgsIGxkb192c3JhbV9vdGhl
cnMsIGxkb192ZWZ1c2UsIGxkb192eG8yMiwNCisgIGxkb192cmZjaywgbGRvX3ZiaWYyOCwgbGRv
X3ZpbzI4LCBsZG9fdmVtYywgbGRvX3ZjbjMzXzJfYnQsIGxkb192Y24zM18yX3dpZmksDQorICBs
ZG9fdmExMiwgbGRvX3ZhMDksIGxkb192cmYxOCwgbGRvX3ZzcmFtX21kLCBsZG9fdnVmcywgbGRv
X3ZtMTgsIGxkb192YmJjaywNCisgIGxkb192c3JhbV9wcm9jMSwgbGRvX3ZzaW0yLCBsZG9fdnNy
YW1fb3RoZXJzX3NzaHViDQorDQorRXhhbXBsZToNCisJcG1pYyB7DQorCQljb21wYXRpYmxlID0g
Im1lZGlhdGVrLG10NjM1OSI7DQorDQorCQltdDYzNTlyZWd1bGF0b3I6IG10NjM1OXJlZ3VsYXRv
ciB7DQorCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDYzNTktcmVndWxhdG9yIjsNCisNCisJ
CQltdDYzNTlfdnMxX2J1Y2tfcmVnOiBidWNrX3ZzMSB7DQorCQkJCXJlZ3VsYXRvci1uYW1lID0g
InZzMSI7DQorCQkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDgwMDAwMD47DQorCQkJCXJl
Z3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDIyMDAwMDA+Ow0KKwkJCQlyZWd1bGF0b3ItZW5hYmxl
LXJhbXAtZGVsYXkgPSA8MD47DQorCQkJCXJlZ3VsYXRvci1hbHdheXMtb247DQorCQkJfTsNCisJ
CQltdDYzNTlfdmdwdTExX2J1Y2tfcmVnOiBidWNrX3ZncHUxMSB7DQorCQkJCXJlZ3VsYXRvci1u
YW1lID0gInZncHUxMSI7DQorCQkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDQwMDAwMD47
DQorCQkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDExOTM3NTA+Ow0KKwkJCQlyZWd1bGF0
b3ItZW5hYmxlLXJhbXAtZGVsYXkgPSA8MjAwPjsNCisJCQkJcmVndWxhdG9yLWFsd2F5cy1vbjsN
CisJCQkJcmVndWxhdG9yLWFsbG93ZWQtbW9kZXMgPSA8MCAxIDI+Ow0KKwkJCX07DQorCQkJbXQ2
MzU5X3ZhdWQxOF9sZG9fcmVnOiBsZG9fdmF1ZDE4IHsNCisJCQkJcmVndWxhdG9yLW5hbWUgPSAi
dmF1ZDE4IjsNCisJCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MTgwMDAwMD47DQorCQkJ
CXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDE4MDAwMDA+Ow0KKwkJCQlyZWd1bGF0b3ItZW5h
YmxlLXJhbXAtZGVsYXkgPSA8MjQwPjsNCisJCQl9Ow0KKwkJCW10NjM1OV92c2ltMV9sZG9fcmVn
OiBsZG9fdnNpbTEgew0KKwkJCQlyZWd1bGF0b3ItbmFtZSA9ICJ2c2ltMSI7DQorCQkJCXJlZ3Vs
YXRvci1taW4tbWljcm92b2x0ID0gPDE3MDAwMDA+Ow0KKwkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jv
dm9sdCA9IDwzMTAwMDAwPjsNCisJCQkJcmVndWxhdG9yLWVuYWJsZS1yYW1wLWRlbGF5ID0gPDQ4
MD47DQorCQkJfTsNCisJCX07DQorCX07DQorDQotLSANCjIuNi40DQo=

