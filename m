Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF28C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C0B24653
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZjpbilcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgBUKMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 05:12:23 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:43041 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728486AbgBUKMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 05:12:20 -0500
X-UUID: 0c24167ae63b4e46ad5a75006e3580ab-20200221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=lyh07rORdyEMmH4qVkXFosUAcAB4Aohej6iysxVm6AY=;
        b=ZjpbilcPr35xQ4wjjfxsL615+NKCKhoTD4WTehZAfkPD8f65gZFh7cdFNmPIFk0ll1rZf12beMDuZjH1sj9M9nILDdSSgJYlZ7/IltVBVgMshh9JwXPdg9BBh/njxwi+k9/a5XxEfXCkqVmH4ZBHySe+piTOuaMsAVvCuPfQ7qA=;
X-UUID: 0c24167ae63b4e46ad5a75006e3580ab-20200221
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1107465619; Fri, 21 Feb 2020 18:12:13 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 21 Feb 2020 18:13:16 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 21 Feb 2020 18:11:53 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        mtk01761 <wendell.lin@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Evan Green <evgreen@chromium.org>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <jroedel@suse.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Subject: [PATCH v8 2/4] soc: mediatek: add MT6765 scpsys and subdomain support
Date:   Fri, 21 Feb 2020 18:12:07 +0800
Message-ID: <1582279929-11535-3-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1582279929-11535-1-git-send-email-macpaul.lin@mediatek.com>
References: <1582279929-11535-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWFycyBDaGVuZyA8bWFycy5jaGVuZ0BtZWRpYXRlay5jb20+DQoNClRoaXMgYWRkcyBz
Y3BzeXMgc3VwcG9ydCBmb3IgTVQ2NzY1DQpBZGQgc3ViZG9tYWluIHN1cHBvcnQgZm9yIE1UNjc2
NToNCmlzcCwgbW0sIGNvbm5zeXMsIG1mZywgYW5kIGNhbS4NCg0KU2lnbmVkLW9mZi1ieTogTWFy
cyBDaGVuZyA8bWFycy5jaGVuZ0BtZWRpYXRlay5jb20+DQpTaWduZWQtb2ZmLWJ5OiBPd2VuIENo
ZW4gPG93ZW4uY2hlbkBtZWRpYXRlay5jb20+DQpTaWduZWQtb2ZmLWJ5OiBNYWNwYXVsIExpbiA8
bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRr
LXNjcHN5cy5jIHwgIDEzMCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQog
MSBmaWxlIGNoYW5nZWQsIDEzMCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nw
c3lzLmMNCmluZGV4IGY2NjlkMzcuLjk5NDBjNmQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstc2Nwc3lzLmMNCisrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1zY3Bz
eXMuYw0KQEAgLTE1LDYgKzE1LDcgQEANCiANCiAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvcG93ZXIv
bXQyNzAxLXBvd2VyLmg+DQogI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3Bvd2VyL210MjcxMi1wb3dl
ci5oPg0KKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9wb3dlci9tdDY3NjUtcG93ZXIuaD4NCiAjaW5j
bHVkZSA8ZHQtYmluZGluZ3MvcG93ZXIvbXQ2Nzk3LXBvd2VyLmg+DQogI2luY2x1ZGUgPGR0LWJp
bmRpbmdzL3Bvd2VyL210NzYyMi1wb3dlci5oPg0KICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9wb3dl
ci9tdDc2MjNhLXBvd2VyLmg+DQpAQCAtNzUwLDYgKzc1MSwxMjAgQEAgc3RhdGljIHZvaWQgbXRr
X3JlZ2lzdGVyX3Bvd2VyX2RvbWFpbnMoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCiB9
Ow0KIA0KIC8qDQorICogTVQ2NzY1IHBvd2VyIGRvbWFpbiBzdXBwb3J0DQorICovDQorI2RlZmlu
ZSBTUE1fUFdSX1NUQVRVU19NVDY3NjUJCQkweDAxODANCisjZGVmaW5lIFNQTV9QV1JfU1RBVFVT
XzJORF9NVDY3NjUJCTB4MDE4NA0KKw0KK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc2NwX2RvbWFpbl9k
YXRhIHNjcF9kb21haW5fZGF0YV9tdDY3NjVbXSA9IHsNCisJW01UNjc2NV9QT1dFUl9ET01BSU5f
VkNPREVDXSA9IHsNCisJCS5uYW1lID0gInZjb2RlYyIsDQorCQkuc3RhX21hc2sgPSBCSVQoMjYp
LA0KKwkJLmN0bF9vZmZzID0gMHgzMDAsDQorCQkuc3JhbV9wZG5fYml0cyA9IEdFTk1BU0soOCwg
OCksDQorCQkuc3JhbV9wZG5fYWNrX2JpdHMgPSBHRU5NQVNLKDEyLCAxMiksDQorCX0sDQorCVtN
VDY3NjVfUE9XRVJfRE9NQUlOX0lTUF0gPSB7DQorCQkubmFtZSA9ICJpc3AiLA0KKwkJLnN0YV9t
YXNrID0gQklUKDUpLA0KKwkJLmN0bF9vZmZzID0gMHgzMDgsDQorCQkuc3JhbV9wZG5fYml0cyA9
IEdFTk1BU0soOCwgOCksDQorCQkuc3JhbV9wZG5fYWNrX2JpdHMgPSBHRU5NQVNLKDEyLCAxMiks
DQorCQkuc3Vic3lzX2Nsa19wcmVmaXggPSAiaXNwIiwNCisJCS5icF90YWJsZSA9IHsNCisJCQlC
VVNfUFJPVChJRlJfVFlQRSwgMHgyQTgsIDB4MkFDLCAwLCAweDI1OCwNCisJCQkJQklUKDIwKSwg
QklUKDIwKSksDQorCQkJQlVTX1BST1QoU01JX1RZUEUsIDB4M0M0LCAweDNDOCwgMCwgMHgzQzAs
DQorCQkJCUJJVCgyKSwgQklUKDIpKSwNCisJCX0sDQorCX0sDQorCVtNVDY3NjVfUE9XRVJfRE9N
QUlOX01NXSA9IHsNCisJCS5uYW1lID0gIm1tIiwNCisJCS5zdGFfbWFzayA9IEJJVCgzKSwNCisJ
CS5jdGxfb2ZmcyA9IDB4MzBDLA0KKwkJLnNyYW1fcGRuX2JpdHMgPSBHRU5NQVNLKDgsIDgpLA0K
KwkJLnNyYW1fcGRuX2Fja19iaXRzID0gR0VOTUFTSygxMiwgMTIpLA0KKwkJLmJhc2ljX2Nsa19p
ZCA9IHsibW0ifSwNCisJCS5zdWJzeXNfY2xrX3ByZWZpeCA9ICJtbSIsDQorCQkuYnBfdGFibGUg
PSB7DQorCQkJQlVTX1BST1QoSUZSX1RZUEUsIDB4MkE4LCAweDJBQywgMCwgMHgyNTgsDQorCQkJ
CUJJVCgxNikgfCBCSVQoMTcpLCBCSVQoMTYpIHwgQklUKDE3KSksDQorCQkJQlVTX1BST1QoSUZS
X1RZUEUsIDB4MkEwLCAweDJBNCwgMCwgMHgyMjgsDQorCQkJCUJJVCgxMCkgfCBCSVQoMTEpLCBC
SVQoMTApIHwgQklUKDExKSksDQorCQkJQlVTX1BST1QoSUZSX1RZUEUsIDB4MkEwLCAweDJBNCwg
MCwgMHgyMjgsDQorCQkJCUJJVCgxKSB8IEJJVCgyKSwgQklUKDEpIHwgQklUKDIpKSwNCisJCX0s
DQorCX0sDQorCVtNVDY3NjVfUE9XRVJfRE9NQUlOX0NPTk5dID0gew0KKwkJLm5hbWUgPSAiY29u
biIsDQorCQkuc3RhX21hc2sgPSBCSVQoMSksDQorCQkuY3RsX29mZnMgPSAweDMyQywNCisJCS5z
cmFtX3Bkbl9iaXRzID0gMCwNCisJCS5zcmFtX3Bkbl9hY2tfYml0cyA9IDAsDQorCQkuYnBfdGFi
bGUgPSB7DQorCQkJQlVTX1BST1QoSUZSX1RZUEUsIDB4MkEwLCAweDJBNCwgMCwgMHgyMjgsDQor
CQkJCUJJVCgxMyksIEJJVCgxMykpLA0KKwkJCUJVU19QUk9UKElGUl9UWVBFLCAweDJBOCwgMHgy
QUMsIDAsIDB4MjU4LA0KKwkJCQlCSVQoMTgpLCBCSVQoMTgpKSwNCisJCQlCVVNfUFJPVChJRlJf
VFlQRSwgMHgyQTAsIDB4MkE0LCAwLCAweDIyOCwNCisJCQkJQklUKDE0KSB8IEJJVCgxNiksIEJJ
VCgxNCkgfCBCSVQoMTYpKSwNCisJCX0sDQorCX0sDQorCVtNVDY3NjVfUE9XRVJfRE9NQUlOX01G
R19BU1lOQ10gPSB7DQorCQkubmFtZSA9ICJtZmdfYXN5bmMiLA0KKwkJLnN0YV9tYXNrID0gQklU
KDIzKSwNCisJCS5jdGxfb2ZmcyA9IDB4MzM0LA0KKwkJLnNyYW1fcGRuX2JpdHMgPSAwLA0KKwkJ
LnNyYW1fcGRuX2Fja19iaXRzID0gMCwNCisJCS5iYXNpY19jbGtfaWQgPSB7Im1mZyJ9LA0KKwl9
LA0KKwlbTVQ2NzY1X1BPV0VSX0RPTUFJTl9NRkddID0gew0KKwkJLm5hbWUgPSAibWZnIiwNCisJ
CS5zdGFfbWFzayA9IEJJVCg0KSwNCisJCS5jdGxfb2ZmcyA9IDB4MzM4LA0KKwkJLnNyYW1fcGRu
X2JpdHMgPSBHRU5NQVNLKDgsIDgpLA0KKwkJLnNyYW1fcGRuX2Fja19iaXRzID0gR0VOTUFTSygx
MiwgMTIpLA0KKwkJLmJwX3RhYmxlID0gew0KKwkJCUJVU19QUk9UKElGUl9UWVBFLCAweDJBMCwg
MHgyQTQsIDAsIDB4MjI4LA0KKwkJCQlCSVQoMjUpLCBCSVQoMjUpKSwNCisJCQlCVVNfUFJPVChJ
RlJfVFlQRSwgMHgyQTAsIDB4MkE0LCAwLCAweDIyOCwNCisJCQkJQklUKDIxKSB8IEJJVCgyMiks
IEJJVCgyMSkgfCBCSVQoMjIpKSwNCisJCX0NCisJfSwNCisJW01UNjc2NV9QT1dFUl9ET01BSU5f
Q0FNXSA9IHsNCisJCS5uYW1lID0gImNhbSIsDQorCQkuc3RhX21hc2sgPSBCSVQoMjUpLA0KKwkJ
LmN0bF9vZmZzID0gMHgzNDQsDQorCQkuc3JhbV9wZG5fYml0cyA9IEdFTk1BU0soOCwgOSksDQor
CQkuc3JhbV9wZG5fYWNrX2JpdHMgPSBHRU5NQVNLKDEyLCAxMyksDQorCQkuc3Vic3lzX2Nsa19w
cmVmaXggPSAiY2FtIiwNCisJCS5icF90YWJsZSA9IHsNCisJCQlCVVNfUFJPVChJRlJfVFlQRSwg
MHgyQTgsIDB4MkFDLCAwLCAweDI1OCwNCisJCQkJQklUKDE5KSB8IEJJVCgyMSksIEJJVCgxOSkg
fCBCSVQoMjEpKSwNCisJCQlCVVNfUFJPVChJRlJfVFlQRSwgMHgyQTAsIDB4MkE0LCAwLCAweDIy
OCwNCisJCQkJQklUKDIwKSwgQklUKDIwKSksDQorCQkJQlVTX1BST1QoU01JX1RZUEUsIDB4M0M0
LCAweDNDOCwgMCwgMHgzQzAsDQorCQkJCUJJVCgzKSwgQklUKDMpKSwNCisJCX0NCisJfSwNCisJ
W01UNjc2NV9QT1dFUl9ET01BSU5fTUZHX0NPUkUwXSA9IHsNCisJCS5uYW1lID0gIm1mZ19jb3Jl
MCIsDQorCQkuc3RhX21hc2sgPSBCSVQoNyksDQorCQkuY3RsX29mZnMgPSAweDM0QywNCisJCS5z
cmFtX3Bkbl9iaXRzID0gR0VOTUFTSyg4LCA4KSwNCisJCS5zcmFtX3Bkbl9hY2tfYml0cyA9IEdF
Tk1BU0soMTIsIDEyKSwNCisJfSwNCit9Ow0KKw0KK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc2NwX3N1
YmRvbWFpbiBzY3Bfc3ViZG9tYWluX210Njc2NVtdID0gew0KKwl7TVQ2NzY1X1BPV0VSX0RPTUFJ
Tl9NTSwgTVQ2NzY1X1BPV0VSX0RPTUFJTl9DQU19LA0KKwl7TVQ2NzY1X1BPV0VSX0RPTUFJTl9N
TSwgTVQ2NzY1X1BPV0VSX0RPTUFJTl9JU1B9LA0KKwl7TVQ2NzY1X1BPV0VSX0RPTUFJTl9NTSwg
TVQ2NzY1X1BPV0VSX0RPTUFJTl9WQ09ERUN9LA0KKwl7TVQ2NzY1X1BPV0VSX0RPTUFJTl9NRkdf
QVNZTkMsIE1UNjc2NV9QT1dFUl9ET01BSU5fTUZHfSwNCisJe01UNjc2NV9QT1dFUl9ET01BSU5f
TUZHLCBNVDY3NjVfUE9XRVJfRE9NQUlOX01GR19DT1JFMH0sDQorfTsNCisNCisvKg0KICAqIE1U
Njc5NyBwb3dlciBkb21haW4gc3VwcG9ydA0KICAqLw0KIA0KQEAgLTEwMzIsNiArMTE0NywxOCBA
QCBzdGF0aWMgdm9pZCBtdGtfcmVnaXN0ZXJfcG93ZXJfZG9tYWlucyhzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpwZGV2LA0KIAkuYnVzX3Byb3RfcmVnX3VwZGF0ZSA9IGZhbHNlLA0KIH07DQogDQor
c3RhdGljIGNvbnN0IHN0cnVjdCBzY3Bfc29jX2RhdGEgbXQ2NzY1X2RhdGEgPSB7DQorCS5kb21h
aW5zID0gc2NwX2RvbWFpbl9kYXRhX210Njc2NSwNCisJLm51bV9kb21haW5zID0gQVJSQVlfU0la
RShzY3BfZG9tYWluX2RhdGFfbXQ2NzY1KSwNCisJLnN1YmRvbWFpbnMgPSBzY3Bfc3ViZG9tYWlu
X210Njc2NSwNCisJLm51bV9zdWJkb21haW5zID0gQVJSQVlfU0laRShzY3Bfc3ViZG9tYWluX210
Njc2NSksDQorCS5yZWdzID0gew0KKwkJLnB3cl9zdGFfb2ZmcyA9IFNQTV9QV1JfU1RBVFVTX01U
Njc2NSwNCisJCS5wd3Jfc3RhMm5kX29mZnMgPSBTUE1fUFdSX1NUQVRVU18yTkRfTVQ2NzY1LA0K
Kwl9LA0KKwkuYnVzX3Byb3RfcmVnX3VwZGF0ZSA9IHRydWUsDQorfTsNCisNCiBzdGF0aWMgY29u
c3Qgc3RydWN0IHNjcF9zb2NfZGF0YSBtdDY3OTdfZGF0YSA9IHsNCiAJLmRvbWFpbnMgPSBzY3Bf
ZG9tYWluX2RhdGFfbXQ2Nzk3LA0KIAkubnVtX2RvbWFpbnMgPSBBUlJBWV9TSVpFKHNjcF9kb21h
aW5fZGF0YV9tdDY3OTcpLA0KQEAgLTEwODgsNiArMTIxNSw5IEBAIHN0YXRpYyB2b2lkIG10a19y
ZWdpc3Rlcl9wb3dlcl9kb21haW5zKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQogCQku
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MTItc2Nwc3lzIiwNCiAJCS5kYXRhID0gJm10Mjcx
Ml9kYXRhLA0KIAl9LCB7DQorCQkuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDY3NjUtc2Nwc3lz
IiwNCisJCS5kYXRhID0gJm10Njc2NV9kYXRhLA0KKwl9LCB7DQogCQkuY29tcGF0aWJsZSA9ICJt
ZWRpYXRlayxtdDY3OTctc2Nwc3lzIiwNCiAJCS5kYXRhID0gJm10Njc5N19kYXRhLA0KIAl9LCB7
DQotLSANCjEuNy45LjUNCg==

