Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A23AC35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128DC24125
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bl2K4sLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgBQDgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 22:36:02 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:37451 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727953AbgBQDfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 22:35:50 -0500
X-UUID: 782d532ef64b4d68b219b89e947b0dcc-20200217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ijwC23Ver6dmempwk564z1rj8q4l6AEPxD6fhOUj3L8=;
        b=bl2K4sLOIrsoUTD5sATyZxYvERt2lmoNx2WSA4Kr/b9tYFNmHnzSm1Zqu7gUZPKNx3viR3iTO2eTdHQmPCWInZ480F6Lx8MuygSJjI23FszXSAj/ZhcFXMJYqRsYjOck8WzK4Od4afm7ZBYHh4bxHl5RJ0vwJlubLP/5QLwDbM0=;
X-UUID: 782d532ef64b4d68b219b89e947b0dcc-20200217
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 134607066; Mon, 17 Feb 2020 11:35:33 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 17 Feb 2020 11:33:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Feb 2020 11:35:08 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v12 09/10] arm64: dts: Add power controller device node of MT8183
Date:   Mon, 17 Feb 2020 11:35:26 +0800
Message-ID: <1581910527-1636-10-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1581910527-1636-1-git-send-email-weiyi.lu@mediatek.com>
References: <1581910527-1636-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 123025A41DE5EEAAFDA594A3C6F88AF2A1E432E843D30DEE91B6514F75DDAF2D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHBvd2VyIGNvbnRyb2xsZXIgbm9kZSBhbmQgc21pLWNvbW1vbiBub2RlIGZvciBNVDgxODMN
CkluIHNjcHN5cyBub2RlLCBpdCBjb250YWlucyBjbG9ja3MgYW5kIHJlZ21hcHBpbmcgb2YNCmlu
ZnJhY2ZnIGFuZCBzbWktY29tbW9uIGZvciBidXMgcHJvdGVjdGlvbi4NCg0KU2lnbmVkLW9mZi1i
eTogV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGFyY2gvYXJtNjQvYm9v
dC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kgfCA2MiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA2MiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQg
YS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5kdHNpIGIvYXJjaC9hcm02NC9i
b290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaQ0KaW5kZXggMTBiMzI0Ny4uY2VmMjIzNiAxMDA2
NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kNCisrKyBi
L2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kNCkBAIC04LDYgKzgsNyBA
QA0KICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay9tdDgxODMtY2xrLmg+DQogI2luY2x1ZGUg
PGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2FybS1naWMuaD4NCiAjaW5jbHVkZSA8
ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+DQorI2luY2x1ZGUgPGR0LWJp
bmRpbmdzL3Bvd2VyL210ODE4My1wb3dlci5oPg0KICNpbmNsdWRlICJtdDgxODMtcGluZnVuYy5o
Ig0KIA0KIC8gew0KQEAgLTI1Myw2ICsyNTQsNjIgQEANCiAJCQkjaW50ZXJydXB0LWNlbGxzID0g
PDI+Ow0KIAkJfTsNCiANCisJCXNjcHN5czogcG93ZXItY29udHJvbGxlckAxMDAwNjAwMCB7DQor
CQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtc2Nwc3lzIiwgInN5c2NvbiI7DQorCQkJ
I3Bvd2VyLWRvbWFpbi1jZWxscyA9IDwxPjsNCisJCQlyZWcgPSA8MCAweDEwMDA2MDAwIDAgMHgx
MDAwPjsNCisJCQljbG9ja3MgPSA8JnRvcGNrZ2VuIENMS19UT1BfTVVYX0FVRF9JTlRCVVM+LA0K
KwkJCQkgPCZpbmZyYWNmZyBDTEtfSU5GUkFfQVVESU8+LA0KKwkJCQkgPCZpbmZyYWNmZyBDTEtf
SU5GUkFfQVVESU9fMjZNX0JDTEs+LA0KKwkJCQkgPCZ0b3Bja2dlbiBDTEtfVE9QX01VWF9NRkc+
LA0KKwkJCQkgPCZ0b3Bja2dlbiBDTEtfVE9QX01VWF9NTT4sDQorCQkJCSA8JnRvcGNrZ2VuIENM
S19UT1BfTVVYX0NBTT4sDQorCQkJCSA8JnRvcGNrZ2VuIENMS19UT1BfTVVYX0lNRz4sDQorCQkJ
CSA8JnRvcGNrZ2VuIENMS19UT1BfTVVYX0lQVV9JRj4sDQorCQkJCSA8JnRvcGNrZ2VuIENMS19U
T1BfTVVYX0RTUD4sDQorCQkJCSA8JnRvcGNrZ2VuIENMS19UT1BfTVVYX0RTUDE+LA0KKwkJCQkg
PCZ0b3Bja2dlbiBDTEtfVE9QX01VWF9EU1AyPiwNCisJCQkJIDwmbW1zeXMgQ0xLX01NX1NNSV9D
T01NT04+LA0KKwkJCQkgPCZtbXN5cyBDTEtfTU1fU01JX0xBUkIwPiwNCisJCQkJIDwmbW1zeXMg
Q0xLX01NX1NNSV9MQVJCMT4sDQorCQkJCSA8Jm1tc3lzIENMS19NTV9HQUxTX0NPTU0wPiwNCisJ
CQkJIDwmbW1zeXMgQ0xLX01NX0dBTFNfQ09NTTE+LA0KKwkJCQkgPCZtbXN5cyBDTEtfTU1fR0FM
U19DQ1UyTU0+LA0KKwkJCQkgPCZtbXN5cyBDTEtfTU1fR0FMU19JUFUxMk1NPiwNCisJCQkJIDwm
bW1zeXMgQ0xLX01NX0dBTFNfSU1HMk1NPiwNCisJCQkJIDwmbW1zeXMgQ0xLX01NX0dBTFNfQ0FN
Mk1NPiwNCisJCQkJIDwmbW1zeXMgQ0xLX01NX0dBTFNfSVBVMk1NPiwNCisJCQkJIDwmaW1nc3lz
IENMS19JTUdfTEFSQjU+LA0KKwkJCQkgPCZpbWdzeXMgQ0xLX0lNR19MQVJCMj4sDQorCQkJCSA8
JmNhbXN5cyBDTEtfQ0FNX0xBUkI2PiwNCisJCQkJIDwmY2Ftc3lzIENMS19DQU1fTEFSQjM+LA0K
KwkJCQkgPCZjYW1zeXMgQ0xLX0NBTV9TRU5JTkY+LA0KKwkJCQkgPCZjYW1zeXMgQ0xLX0NBTV9D
QU1TVjA+LA0KKwkJCQkgPCZjYW1zeXMgQ0xLX0NBTV9DQU1TVjE+LA0KKwkJCQkgPCZjYW1zeXMg
Q0xLX0NBTV9DQU1TVjI+LA0KKwkJCQkgPCZjYW1zeXMgQ0xLX0NBTV9DQ1U+LA0KKwkJCQkgPCZp
cHVfY29ubiBDTEtfSVBVX0NPTk5fSVBVPiwNCisJCQkJIDwmaXB1X2Nvbm4gQ0xLX0lQVV9DT05O
X0FIQj4sDQorCQkJCSA8JmlwdV9jb25uIENMS19JUFVfQ09OTl9BWEk+LA0KKwkJCQkgPCZpcHVf
Y29ubiBDTEtfSVBVX0NPTk5fSVNQPiwNCisJCQkJIDwmaXB1X2Nvbm4gQ0xLX0lQVV9DT05OX0NB
TV9BREw+LA0KKwkJCQkgPCZpcHVfY29ubiBDTEtfSVBVX0NPTk5fSU1HX0FETD47DQorCQkJY2xv
Y2stbmFtZXMgPSAiYXVkaW8iLCAiYXVkaW8xIiwgImF1ZGlvMiIsDQorCQkJCSAgICAgICJtZmci
LCAibW0iLCAiY2FtIiwNCisJCQkJICAgICAgImlzcCIsICJ2cHUiLCAidnB1MSIsDQorCQkJCSAg
ICAgICJ2cHUyIiwgInZwdTMiLCAibW0tMCIsDQorCQkJCSAgICAgICJtbS0xIiwgIm1tLTIiLCAi
bW0tMyIsDQorCQkJCSAgICAgICJtbS00IiwgIm1tLTUiLCAibW0tNiIsDQorCQkJCSAgICAgICJt
bS03IiwgIm1tLTgiLCAibW0tOSIsDQorCQkJCSAgICAgICJpc3AtMCIsICJpc3AtMSIsICJjYW0t
MCIsDQorCQkJCSAgICAgICJjYW0tMSIsICJjYW0tMiIsICJjYW0tMyIsDQorCQkJCSAgICAgICJj
YW0tNCIsICJjYW0tNSIsICJjYW0tNiIsDQorCQkJCSAgICAgICJ2cHUtMCIsICJ2cHUtMSIsICJ2
cHUtMiIsDQorCQkJCSAgICAgICJ2cHUtMyIsICJ2cHUtNCIsICJ2cHUtNSI7DQorCQkJaW5mcmFj
ZmcgPSA8JmluZnJhY2ZnPjsNCisJCQlzbWlfY29tbSA9IDwmc21pX2NvbW1vbj47DQorCQl9Ow0K
Kw0KIAkJYXBtaXhlZHN5czogc3lzY29uQDEwMDBjMDAwIHsNCiAJCQljb21wYXRpYmxlID0gIm1l
ZGlhdGVrLG10ODE4My1hcG1peGVkc3lzIiwgInN5c2NvbiI7DQogCQkJcmVnID0gPDAgMHgxMDAw
YzAwMCAwIDB4MTAwMD47DQpAQCAtNTk0LDYgKzY1MSwxMSBAQA0KIAkJCSNjbG9jay1jZWxscyA9
IDwxPjsNCiAJCX07DQogDQorCQlzbWlfY29tbW9uOiBzbWlAMTQwMTkwMDAgew0KKwkJCWNvbXBh
dGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLXNtaS1jb21tb24iLCAic3lzY29uIjsNCisJCQlyZWcg
PSA8MCAweDE0MDE5MDAwIDAgMHgxMDAwPjsNCisJCX07DQorDQogCQlpbWdzeXM6IHN5c2NvbkAx
NTAyMDAwMCB7DQogCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtaW1nc3lzIiwgInN5
c2NvbiI7DQogCQkJcmVnID0gPDAgMHgxNTAyMDAwMCAwIDB4MTAwMD47DQotLSANCjEuOC4xLjEu
ZGlydHkNCg==

