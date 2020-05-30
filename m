Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D14C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C2062070E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="M2kAZT6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgE3IO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 04:14:29 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:31473 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725813AbgE3IO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 04:14:28 -0400
X-UUID: f3764fe00c43440686fc71b2f2004fb5-20200530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3n8qQs/+XQtriV9uBcTrs++ZoOREAIe6PJ1LIF68gR4=;
        b=M2kAZT6ZrYkSk5AmgCpfM8peyFM2WHXUFizcc4Fd2f7i6Wd9SQppW0qScWN4LZUV0CQzQY/ALzGh46aEs4U5UULlcoOxRjp1+PzbeqE4lB0gbBlDlObHY/X0jUisfbLadi7I3IXPUmktqybifmTIvjbzbiD+Oz5/Bk+VorUvXXk=;
X-UUID: f3764fe00c43440686fc71b2f2004fb5-20200530
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 274966586; Sat, 30 May 2020 16:14:26 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 30 May 2020 16:14:22 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 30 May 2020 16:14:22 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, <anan.sun@mediatek.com>,
        <cui.zhang@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>, <eizan@chromium.org>,
        <acourbot@chromium.org>
Subject: [PATCH v4 13/17] iommu/mediatek: Use module_platform_driver
Date:   Sat, 30 May 2020 16:10:14 +0800
Message-ID: <1590826218-23653-14-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
References: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWVkaWFUZWsgSU9NTVUgc2hvdWxkIHdhaXQgZm9yIHNtaSBsYXJiIHdoaWNoIG5lZWQgd2FpdCBm
b3IgdGhlDQpwb3dlciBkb21haW4obXRrLXNjcHN5cy5jKSBhbmQgdGhlIG11bHRpbWVkaWEgY2Nm
LCBib3RoIGFyZSBtb2R1bGUNCmluaXQuIFRodXMsIHN1YnN5c19pbml0Y2FsbCBmb3IgTWVkaWFU
ZWsgSU9NTVUgaXMgbm90IGhlbHBmdWwuDQpTd2l0Y2ggdG8gbW9kdWxlX3BsYXRmb3JtX2RyaXZl
ci4NCg0KQ29ycmVzcG9uZGluZ2x5LCBhZGQgdGhlIG1vZHVsZSBsaWNlbnNlIGluZm9ybWF0aW9u
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCi0tLQ0K
Zm9yIGlvbW11IHYxOiBob25naHVpJ3MgbWFpbCBhZGRyZXNzIGlzIG5vdCB2YWxpZCBub3cuIEkg
d2lsbCBiZQ0KcmVzcG9uc2libGUgZm9yIHRoYXQgZmlsZSB0b28sIFNvIEkgYWRkIG15c2VsZiBp
biBpdC4NCi0tLQ0KIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgICAgfCAxOCArKysrKystLS0t
LS0tLS0tLS0NCiBkcml2ZXJzL2lvbW11L210a19pb21tdV92MS5jIHwgMTIgKysrKysrKy0tLS0t
DQogMiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L210
a19pb21tdS5jDQppbmRleCA1YzNhNmJhLi4wNzQwY2E5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9p
b21tdS9tdGtfaW9tbXUuYw0KKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KQEAgLTE1
LDYgKzE1LDcgQEANCiAjaW5jbHVkZSA8bGludXgvaW9tbXUuaD4NCiAjaW5jbHVkZSA8bGludXgv
aW9wb2xsLmg+DQogI2luY2x1ZGUgPGxpbnV4L2xpc3QuaD4NCisjaW5jbHVkZSA8bGludXgvbW9k
dWxlLmg+DQogI2luY2x1ZGUgPGxpbnV4L29mX2FkZHJlc3MuaD4NCiAjaW5jbHVkZSA8bGludXgv
b2ZfaW9tbXUuaD4NCiAjaW5jbHVkZSA8bGludXgvb2ZfaXJxLmg+DQpAQCAtODIzLDE2ICs4MjQs
OSBAQCBzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIG10a19pb21tdV9yZXN1bWUoc3RydWN0IGRl
dmljZSAqZGV2KQ0KIAkJLnBtID0gJm10a19pb21tdV9wbV9vcHMsDQogCX0NCiB9Ow0KK21vZHVs
ZV9wbGF0Zm9ybV9kcml2ZXIobXRrX2lvbW11X2RyaXZlcik7DQogDQotc3RhdGljIGludCBfX2lu
aXQgbXRrX2lvbW11X2luaXQodm9pZCkNCi17DQotCWludCByZXQ7DQotDQotCXJldCA9IHBsYXRm
b3JtX2RyaXZlcl9yZWdpc3RlcigmbXRrX2lvbW11X2RyaXZlcik7DQotCWlmIChyZXQgIT0gMCkN
Ci0JCXByX2VycigiRmFpbGVkIHRvIHJlZ2lzdGVyIE1USyBJT01NVSBkcml2ZXJcbiIpOw0KLQ0K
LQlyZXR1cm4gcmV0Ow0KLX0NCi0NCi1zdWJzeXNfaW5pdGNhbGwobXRrX2lvbW11X2luaXQpDQor
TU9EVUxFX0RFU0NSSVBUSU9OKCJJT01NVSBBUEkgZm9yIE1lZGlhVGVrIE00VSBpbXBsZW1lbnRh
dGlvbnMiKTsNCitNT0RVTEVfQVVUSE9SKCJZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4i
KTsNCitNT0RVTEVfQUxJQVMoInBsYXRmb3JtOk1lZGlhVGVrLU00VSIpOw0KK01PRFVMRV9MSUNF
TlNFKCJHUEwgdjIiKTsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdV92MS5j
IGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXVfdjEuYw0KaW5kZXggMjZiNmM3OS4uMDg1MmNiMyAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11X3YxLmMNCisrKyBiL2RyaXZlcnMv
aW9tbXUvbXRrX2lvbW11X3YxLmMNCkBAIC0yMCw2ICsyMCw3IEBADQogI2luY2x1ZGUgPGxpbnV4
L2lvbW11Lmg+DQogI2luY2x1ZGUgPGxpbnV4L2lvcG9sbC5oPg0KICNpbmNsdWRlIDxsaW51eC9s
aXN0Lmg+DQorI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KICNpbmNsdWRlIDxsaW51eC9vZl9h
ZGRyZXNzLmg+DQogI2luY2x1ZGUgPGxpbnV4L29mX2lvbW11Lmg+DQogI2luY2x1ZGUgPGxpbnV4
L29mX2lycS5oPg0KQEAgLTcxMSw5ICs3MTIsMTAgQEAgc3RhdGljIGludCBfX21heWJlX3VudXNl
ZCBtdGtfaW9tbXVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCiAJCS5wbSA9ICZtdGtfaW9t
bXVfcG1fb3BzLA0KIAl9DQogfTsNCittb2R1bGVfcGxhdGZvcm1fZHJpdmVyKG10a19pb21tdV9k
cml2ZXIpOw0KIA0KLXN0YXRpYyBpbnQgX19pbml0IG00dV9pbml0KHZvaWQpDQotew0KLQlyZXR1
cm4gcGxhdGZvcm1fZHJpdmVyX3JlZ2lzdGVyKCZtdGtfaW9tbXVfZHJpdmVyKTsNCi19DQotc3Vi
c3lzX2luaXRjYWxsKG00dV9pbml0KTsNCitNT0RVTEVfREVTQ1JJUFRJT04oIklPTU1VIEFQSSBm
b3IgTWVkaWFUZWsgTTRVIHYxIGltcGxlbWVudGF0aW9ucyIpOw0KK01PRFVMRV9BVVRIT1IoIllv
bmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPiIpOw0KK01PRFVMRV9BVVRIT1IoIkhvbmdodWkg
WmhhbmcgPGhvbmdodWkuemhhbmdAbWVkaWF0ZWsuY29tPiIpOw0KK01PRFVMRV9BTElBUygicGxh
dGZvcm06TWVkaWFUZWstTTRVLXYxIik7DQorTU9EVUxFX0xJQ0VOU0UoIkdQTCB2MiIpOw0KLS0g
DQoxLjkuMQ0K

