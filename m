Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B73C43332
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 07:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F69E2051A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 07:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MSBQZ/fq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgCTHcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 03:32:46 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:15951 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726982AbgCTHcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 03:32:43 -0400
X-UUID: 9236304136bc407b87f44bf04659f847-20200320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=HRs7cf/vg54eE9WqxDBPqnxsyBTDI4woFjEa7HdU93I=;
        b=MSBQZ/fqyQkJndzDsZi4Mp6qZ2cmoRwia2TMcJ5zwHjbHYkxkGmH1yz8TozkBOWGx1XkiD8WAEUGQngFqX9YY3JA8rSwX0GSR+4sJ/noQj2Ubc7bs7hui3OK0UUwqRUZtxYvk11NdiN6Pg70jkWq6jzO59CgPzLqYY4tVuRc/lo=;
X-UUID: 9236304136bc407b87f44bf04659f847-20200320
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 56884287; Fri, 20 Mar 2020 15:32:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 20 Mar 2020 15:30:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 20 Mar 2020 15:29:20 +0800
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
Subject: [PATCH v13 10/11] arm64: dts: Add power controller device node of MT8183
Date:   Fri, 20 Mar 2020 15:32:19 +0800
Message-ID: <1584689540-5227-11-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1584689540-5227-1-git-send-email-weiyi.lu@mediatek.com>
References: <1584689540-5227-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
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
b290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaQ0KaW5kZXggMTI0ZjlkMy4uNzBmMThiOSAxMDA2
NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kNCisrKyBi
L2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kNCkBAIC04LDYgKzgsNyBA
QA0KICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay9tdDgxODMtY2xrLmg+DQogI2luY2x1ZGUg
PGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2FybS1naWMuaD4NCiAjaW5jbHVkZSA8
ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+DQorI2luY2x1ZGUgPGR0LWJp
bmRpbmdzL3Bvd2VyL210ODE4My1wb3dlci5oPg0KICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9yZXNl
dC1jb250cm9sbGVyL210ODE4My1yZXNldHMuaD4NCiAjaW5jbHVkZSAibXQ4MTgzLXBpbmZ1bmMu
aCINCiANCkBAIC0yNTUsNiArMjU2LDYyIEBADQogCQkJI2ludGVycnVwdC1jZWxscyA9IDwyPjsN
CiAJCX07DQogDQorCQlzY3BzeXM6IHBvd2VyLWNvbnRyb2xsZXJAMTAwMDYwMDAgew0KKwkJCWNv
bXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLXNjcHN5cyIsICJzeXNjb24iOw0KKwkJCSNwb3dl
ci1kb21haW4tY2VsbHMgPSA8MT47DQorCQkJcmVnID0gPDAgMHgxMDAwNjAwMCAwIDB4MTAwMD47
DQorCQkJY2xvY2tzID0gPCZ0b3Bja2dlbiBDTEtfVE9QX01VWF9BVURfSU5UQlVTPiwNCisJCQkJ
IDwmaW5mcmFjZmcgQ0xLX0lORlJBX0FVRElPPiwNCisJCQkJIDwmaW5mcmFjZmcgQ0xLX0lORlJB
X0FVRElPXzI2TV9CQ0xLPiwNCisJCQkJIDwmdG9wY2tnZW4gQ0xLX1RPUF9NVVhfTUZHPiwNCisJ
CQkJIDwmdG9wY2tnZW4gQ0xLX1RPUF9NVVhfTU0+LA0KKwkJCQkgPCZ0b3Bja2dlbiBDTEtfVE9Q
X01VWF9DQU0+LA0KKwkJCQkgPCZ0b3Bja2dlbiBDTEtfVE9QX01VWF9JTUc+LA0KKwkJCQkgPCZ0
b3Bja2dlbiBDTEtfVE9QX01VWF9JUFVfSUY+LA0KKwkJCQkgPCZ0b3Bja2dlbiBDTEtfVE9QX01V
WF9EU1A+LA0KKwkJCQkgPCZ0b3Bja2dlbiBDTEtfVE9QX01VWF9EU1AxPiwNCisJCQkJIDwmdG9w
Y2tnZW4gQ0xLX1RPUF9NVVhfRFNQMj4sDQorCQkJCSA8Jm1tc3lzIENMS19NTV9TTUlfQ09NTU9O
PiwNCisJCQkJIDwmbW1zeXMgQ0xLX01NX1NNSV9MQVJCMD4sDQorCQkJCSA8Jm1tc3lzIENMS19N
TV9TTUlfTEFSQjE+LA0KKwkJCQkgPCZtbXN5cyBDTEtfTU1fR0FMU19DT01NMD4sDQorCQkJCSA8
Jm1tc3lzIENMS19NTV9HQUxTX0NPTU0xPiwNCisJCQkJIDwmbW1zeXMgQ0xLX01NX0dBTFNfQ0NV
Mk1NPiwNCisJCQkJIDwmbW1zeXMgQ0xLX01NX0dBTFNfSVBVMTJNTT4sDQorCQkJCSA8Jm1tc3lz
IENMS19NTV9HQUxTX0lNRzJNTT4sDQorCQkJCSA8Jm1tc3lzIENMS19NTV9HQUxTX0NBTTJNTT4s
DQorCQkJCSA8Jm1tc3lzIENMS19NTV9HQUxTX0lQVTJNTT4sDQorCQkJCSA8JmltZ3N5cyBDTEtf
SU1HX0xBUkI1PiwNCisJCQkJIDwmaW1nc3lzIENMS19JTUdfTEFSQjI+LA0KKwkJCQkgPCZjYW1z
eXMgQ0xLX0NBTV9MQVJCNj4sDQorCQkJCSA8JmNhbXN5cyBDTEtfQ0FNX0xBUkIzPiwNCisJCQkJ
IDwmY2Ftc3lzIENMS19DQU1fU0VOSU5GPiwNCisJCQkJIDwmY2Ftc3lzIENMS19DQU1fQ0FNU1Yw
PiwNCisJCQkJIDwmY2Ftc3lzIENMS19DQU1fQ0FNU1YxPiwNCisJCQkJIDwmY2Ftc3lzIENMS19D
QU1fQ0FNU1YyPiwNCisJCQkJIDwmY2Ftc3lzIENMS19DQU1fQ0NVPiwNCisJCQkJIDwmaXB1X2Nv
bm4gQ0xLX0lQVV9DT05OX0lQVT4sDQorCQkJCSA8JmlwdV9jb25uIENMS19JUFVfQ09OTl9BSEI+
LA0KKwkJCQkgPCZpcHVfY29ubiBDTEtfSVBVX0NPTk5fQVhJPiwNCisJCQkJIDwmaXB1X2Nvbm4g
Q0xLX0lQVV9DT05OX0lTUD4sDQorCQkJCSA8JmlwdV9jb25uIENMS19JUFVfQ09OTl9DQU1fQURM
PiwNCisJCQkJIDwmaXB1X2Nvbm4gQ0xLX0lQVV9DT05OX0lNR19BREw+Ow0KKwkJCWNsb2NrLW5h
bWVzID0gImF1ZGlvIiwgImF1ZGlvMSIsICJhdWRpbzIiLA0KKwkJCQkgICAgICAibWZnIiwgIm1t
IiwgImNhbSIsDQorCQkJCSAgICAgICJpc3AiLCAidnB1IiwgInZwdTEiLA0KKwkJCQkgICAgICAi
dnB1MiIsICJ2cHUzIiwgIm1tLTAiLA0KKwkJCQkgICAgICAibW0tMSIsICJtbS0yIiwgIm1tLTMi
LA0KKwkJCQkgICAgICAibW0tNCIsICJtbS01IiwgIm1tLTYiLA0KKwkJCQkgICAgICAibW0tNyIs
ICJtbS04IiwgIm1tLTkiLA0KKwkJCQkgICAgICAiaXNwLTAiLCAiaXNwLTEiLCAiY2FtLTAiLA0K
KwkJCQkgICAgICAiY2FtLTEiLCAiY2FtLTIiLCAiY2FtLTMiLA0KKwkJCQkgICAgICAiY2FtLTQi
LCAiY2FtLTUiLCAiY2FtLTYiLA0KKwkJCQkgICAgICAidnB1LTAiLCAidnB1LTEiLCAidnB1LTIi
LA0KKwkJCQkgICAgICAidnB1LTMiLCAidnB1LTQiLCAidnB1LTUiOw0KKwkJCWluZnJhY2ZnID0g
PCZpbmZyYWNmZz47DQorCQkJc21pX2NvbW0gPSA8JnNtaV9jb21tb24+Ow0KKwkJfTsNCisNCiAJ
CWFwbWl4ZWRzeXM6IHN5c2NvbkAxMDAwYzAwMCB7DQogCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRl
ayxtdDgxODMtYXBtaXhlZHN5cyIsICJzeXNjb24iOw0KIAkJCXJlZyA9IDwwIDB4MTAwMGMwMDAg
MCAweDEwMDA+Ow0KQEAgLTYwNSw2ICs2NjIsMTEgQEANCiAJCQkjY2xvY2stY2VsbHMgPSA8MT47
DQogCQl9Ow0KIA0KKwkJc21pX2NvbW1vbjogc21pQDE0MDE5MDAwIHsNCisJCQljb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10ODE4My1zbWktY29tbW9uIiwgInN5c2NvbiI7DQorCQkJcmVnID0gPDAg
MHgxNDAxOTAwMCAwIDB4MTAwMD47DQorCQl9Ow0KKw0KIAkJaW1nc3lzOiBzeXNjb25AMTUwMjAw
MDAgew0KIAkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLWltZ3N5cyIsICJzeXNjb24i
Ow0KIAkJCXJlZyA9IDwwIDB4MTUwMjAwMDAgMCAweDEwMDA+Ow0KLS0gDQoxLjguMS4xLmRpcnR5
DQo=

