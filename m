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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC62BC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9699420776
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="F9g4eyzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgE3IMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 04:12:38 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:51759 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725813AbgE3IMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 04:12:38 -0400
X-UUID: fbc85b79037b40fcae9b8fbcec22fa25-20200530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=YoE+PstubvdV+P9sL6XU+QZldj5rsjBxfw5MlFZPCr8=;
        b=F9g4eyzKmmWJylVtxvkUJycnrMMYr9AnRecc0wtoE447Ai/BJWsgXd47Ory4kHxOfUMujGU3IsniqKBtOCo9IvBLpZR9KdMLnRuoQK5Ob4azxrXFymTJl0MKmNKvkmBHUnttM/jaGMo5x4v5qOtxh8eRx7gp8iRAznK32Opo+pE=;
X-UUID: fbc85b79037b40fcae9b8fbcec22fa25-20200530
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 14443008; Sat, 30 May 2020 16:12:30 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 30 May 2020 16:12:27 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 30 May 2020 16:12:27 +0800
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
        <acourbot@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Irui Wang <irui.wang@mediatek.com>
Subject: [PATCH v4 01/17] media: dt-binding: mtk-vcodec: Separating mtk-vcodec encode node.
Date:   Sat, 30 May 2020 16:10:02 +0800
Message-ID: <1590826218-23653-2-git-send-email-yong.wu@mediatek.com>
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

RnJvbTogTWFvZ3VhbmcgTWVuZyA8bWFvZ3VhbmcubWVuZ0BtZWRpYXRlay5jb20+DQoNClVwZGF0
ZSBiaW5kaW5nIGRvY3VtZW50IHNpbmNlIHRoZSBhdmMgYW5kIHZwOCBoYXJkd2FyZSBlbmNvZGVy
IGluDQptdDgxNzMgYXJlIG5vdyBzZXBhcmF0ZWQuIFNlcGFyYXRlICJtZWRpYXRlayxtdDgxNzMt
dmNvZGVjLWVuYyIgdG8NCiJtZWRpYXRlayxtdDgxNzMtdmNvZGVjLXZwOC1lbmMiIGFuZCAibWVk
aWF0ZWssbXQ4MTczLXZjb2RlYy1hdmMtZW5jIi4NCg0KVGhpcyBpcyBhIHByZXBhcmluZyBwYXRj
aCBmb3Igc21pIGNsZWFuaW5nIHVwICJtZWRpYXRlayxsYXJiIi4NCg0KU2lnbmVkLW9mZi1ieTog
TWFvZ3VhbmcgTWVuZyA8bWFvZ3VhbmcubWVuZ0BtZWRpYXRlay5jb20+DQpTaWduZWQtb2ZmLWJ5
OiBIc2luLVlpIFdhbmcgPGhzaW55aUBjaHJvbWl1bS5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBJcnVp
IFdhbmcgPGlydWkud2FuZ0BtZWRpYXRlay5jb20+DQpTaWduZWQtb2ZmLWJ5OiBZb25nIFd1IDx5
b25nLnd1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlh
L21lZGlhdGVrLXZjb2RlYy50eHQgIHwgNTggKysrKysrKysrKysrLS0tLS0tLS0tLQ0KIDEgZmls
ZSBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAyNyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9tZWRpYXRlay12Y29k
ZWMudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL21lZGlhdGVr
LXZjb2RlYy50eHQNCmluZGV4IDgwOTMzMzUuLjEwMjM3NDAgMTAwNjQ0DQotLS0gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVkaWEvbWVkaWF0ZWstdmNvZGVjLnR4dA0KKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL21lZGlhdGVrLXZjb2Rl
Yy50eHQNCkBAIC00LDcgKzQsOSBAQCBNZWRpYXRlayBWaWRlbyBDb2RlYyBpcyB0aGUgdmlkZW8g
Y29kZWMgaHcgcHJlc2VudCBpbiBNZWRpYXRlayBTb0NzIHdoaWNoDQogc3VwcG9ydHMgaGlnaCBy
ZXNvbHV0aW9uIGVuY29kaW5nIGFuZCBkZWNvZGluZyBmdW5jdGlvbmFsaXRpZXMuDQogDQogUmVx
dWlyZWQgcHJvcGVydGllczoNCi0tIGNvbXBhdGlibGUgOiAibWVkaWF0ZWssbXQ4MTczLXZjb2Rl
Yy1lbmMiIGZvciBNVDgxNzMgZW5jb2Rlcg0KKy0gY29tcGF0aWJsZSA6IG11c3QgYmUgb25lIG9m
IHRoZSBmb2xsb3dpbmcgc3RyaW5nOg0KKyAgIm1lZGlhdGVrLG10ODE3My12Y29kZWMtdnA4LWVu
YyIgZm9yIG10ODE3MyB2cDggZW5jb2Rlci4NCisgICJtZWRpYXRlayxtdDgxNzMtdmNvZGVjLWF2
Yy1lbmMiIGZvciBtdDgxNzMgYXZjIGVuY29kZXIuDQogICAibWVkaWF0ZWssbXQ4MTgzLXZjb2Rl
Yy1lbmMiIGZvciBNVDgxODMgZW5jb2Rlci4NCiAgICJtZWRpYXRlayxtdDgxNzMtdmNvZGVjLWRl
YyIgZm9yIE1UODE3MyBkZWNvZGVyLg0KIC0gcmVnIDogUGh5c2ljYWwgYmFzZSBhZGRyZXNzIG9m
IHRoZSB2aWRlbyBjb2RlYyByZWdpc3RlcnMgYW5kIGxlbmd0aCBvZg0KQEAgLTEzLDEwICsxNSwx
MSBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KIC0gbWVkaWF0ZWssbGFyYiA6IG11c3QgY29udGFp
biB0aGUgbG9jYWwgYXJiaXRlcnMgaW4gdGhlIGN1cnJlbnQgU29jcy4NCiAtIGNsb2NrcyA6IGxp
c3Qgb2YgY2xvY2sgc3BlY2lmaWVycywgY29ycmVzcG9uZGluZyB0byBlbnRyaWVzIGluDQogICB0
aGUgY2xvY2stbmFtZXMgcHJvcGVydHkuDQotLSBjbG9jay1uYW1lczogZW5jb2RlciBtdXN0IGNv
bnRhaW4gInZlbmNfc2VsX3NyYyIsICJ2ZW5jX3NlbCIsLA0KLSAgInZlbmNfbHRfc2VsX3NyYyIs
ICJ2ZW5jX2x0X3NlbCIsIGRlY29kZXIgbXVzdCBjb250YWluICJ2Y29kZWNwbGwiLA0KLSAgInVu
aXZwbGxfZDIiLCAiY2xrX2NjaTQwMF9zZWwiLCAidmRlY19zZWwiLCAidmRlY3BsbCIsICJ2ZW5j
cGxsIiwNCi0gICJ2ZW5jX2x0X3NlbCIsICJ2ZGVjX2J1c19jbGtfc3JjIi4NCistIGNsb2NrLW5h
bWVzOg0KKyAgIGF2YyB2ZW5jIG11c3QgY29udGFpbiAidmVuY19zZWwiOw0KKyAgIHZwOCB2ZW5j
IG11c3QgY29udGFpbiAidmVuY19sdF9zZWwiOw0KKyAgIGRlY29kZXIgIG11c3QgY29udGFpbiAi
dmNvZGVjcGxsIiwgInVuaXZwbGxfZDIiLCAiY2xrX2NjaTQwMF9zZWwiLA0KKyAgICJ2ZGVjX3Nl
bCIsICJ2ZGVjcGxsIiwgInZlbmNwbGwiLCAidmVuY19sdF9zZWwiLCAidmRlY19idXNfY2xrX3Ny
YyIuDQogLSBpb21tdXMgOiBzaG91bGQgcG9pbnQgdG8gdGhlIHJlc3BlY3RpdmUgSU9NTVUgYmxv
Y2sgd2l0aCBtYXN0ZXIgcG9ydCBhcw0KICAgYXJndW1lbnQsIHNlZSBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvaW9tbXUvbWVkaWF0ZWssaW9tbXUudHh0DQogICBmb3IgZGV0YWls
cy4NCkBAIC04MCwxNCArODMsMTAgQEAgdmNvZGVjX2RlYzogdmNvZGVjQDE2MDAwMDAwIHsNCiAg
ICAgYXNzaWduZWQtY2xvY2stcmF0ZXMgPSA8MD4sIDwwPiwgPDA+LCA8MTQ4MjAwMDAwMD4sIDw4
MDAwMDAwMDA+Ow0KICAgfTsNCiANCi0gIHZjb2RlY19lbmM6IHZjb2RlY0AxODAwMjAwMCB7DQot
ICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLXZjb2RlYy1lbmMiOw0KLSAgICByZWcg
PSA8MCAweDE4MDAyMDAwIDAgMHgxMDAwPiwgICAgLypWRU5DX1NZUyovDQotICAgICAgICAgIDww
IDB4MTkwMDIwMDAgMCAweDEwMDA+OyAgICAvKlZFTkNfTFRfU1lTKi8NCi0gICAgaW50ZXJydXB0
cyA9IDxHSUNfU1BJIDE5OCBJUlFfVFlQRV9MRVZFTF9MT1c+LA0KLQkJIDxHSUNfU1BJIDIwMiBJ
UlFfVFlQRV9MRVZFTF9MT1c+Ow0KLSAgICBtZWRpYXRlayxsYXJiID0gPCZsYXJiMz4sDQotCQkg
ICAgPCZsYXJiNT47DQordmNvZGVjX2VuYzogdmNvZGVjQDE4MDAyMDAwIHsNCisgICAgY29tcGF0
aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMtdmNvZGVjLWF2Yy1lbmMiOw0KKyAgICByZWcgPSA8MCAw
eDE4MDAyMDAwIDAgMHgxMDAwPjsNCisgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDE5OCBJUlFf
VFlQRV9MRVZFTF9MT1c+Ow0KICAgICBpb21tdXMgPSA8JmlvbW11IE00VV9QT1JUX1ZFTkNfUkNQ
VT4sDQogICAgICAgICAgICAgIDwmaW9tbXUgTTRVX1BPUlRfVkVOQ19SRUM+LA0KICAgICAgICAg
ICAgICA8JmlvbW11IE00VV9QT1JUX1ZFTkNfQlNETUE+LA0KQEAgLTk4LDggKzk3LDIwIEBAIHZj
b2RlY19kZWM6IHZjb2RlY0AxNjAwMDAwMCB7DQogICAgICAgICAgICAgIDwmaW9tbXUgTTRVX1BP
UlRfVkVOQ19SRUZfTFVNQT4sDQogICAgICAgICAgICAgIDwmaW9tbXUgTTRVX1BPUlRfVkVOQ19S
RUZfQ0hST01BPiwNCiAgICAgICAgICAgICAgPCZpb21tdSBNNFVfUE9SVF9WRU5DX05CTV9SRE1B
PiwNCi0gICAgICAgICAgICAgPCZpb21tdSBNNFVfUE9SVF9WRU5DX05CTV9XRE1BPiwNCi0gICAg
ICAgICAgICAgPCZpb21tdSBNNFVfUE9SVF9WRU5DX1JDUFVfU0VUMj4sDQorICAgICAgICAgICAg
IDwmaW9tbXUgTTRVX1BPUlRfVkVOQ19OQk1fV0RNQT47DQorICAgIG1lZGlhdGVrLGxhcmIgPSA8
JmxhcmIzPjsNCisgICAgbWVkaWF0ZWssdnB1ID0gPCZ2cHU+Ow0KKyAgICBjbG9ja3MgPSA8JnRv
cGNrZ2VuIENMS19UT1BfVkVOQ19TRUw+Ow0KKyAgICBjbG9jay1uYW1lcyA9ICJ2ZW5jX3NlbCI7
DQorICAgIGFzc2lnbmVkLWNsb2NrcyA9IDwmdG9wY2tnZW4gQ0xLX1RPUF9WRU5DX1NFTD47DQor
ICAgIGFzc2lnbmVkLWNsb2NrLXBhcmVudHMgPSA8JnRvcGNrZ2VuIENMS19UT1BfVkNPREVDUExM
PjsNCisgIH07DQorDQordmNvZGVjX2VuY19sdDogdmNvZGVjQDE5MDAyMDAwIHsNCisgICAgY29t
cGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMtdmNvZGVjLXZwOC1lbmMiOw0KKyAgICByZWcgPSAg
PDAgMHgxOTAwMjAwMCAwIDB4MTAwMD47CS8qIFZFTkNfTFRfU1lTICovDQorICAgIGludGVycnVw
dHMgPSA8R0lDX1NQSSAyMDIgSVJRX1RZUEVfTEVWRUxfTE9XPjsNCisgICAgaW9tbXVzID0gPCZp
b21tdSBNNFVfUE9SVF9WRU5DX1JDUFVfU0VUMj4sDQogICAgICAgICAgICAgIDwmaW9tbXUgTTRV
X1BPUlRfVkVOQ19SRUNfRlJNX1NFVDI+LA0KICAgICAgICAgICAgICA8JmlvbW11IE00VV9QT1JU
X1ZFTkNfQlNETUFfU0VUMj4sDQogICAgICAgICAgICAgIDwmaW9tbXUgTTRVX1BPUlRfVkVOQ19T
Vl9DT01BX1NFVDI+LA0KQEAgLTEwOCwxNyArMTE5LDEwIEBAIHZjb2RlY19kZWM6IHZjb2RlY0Ax
NjAwMDAwMCB7DQogICAgICAgICAgICAgIDwmaW9tbXUgTTRVX1BPUlRfVkVOQ19DVVJfQ0hST01B
X1NFVDI+LA0KICAgICAgICAgICAgICA8JmlvbW11IE00VV9QT1JUX1ZFTkNfUkVGX0xVTUFfU0VU
Mj4sDQogICAgICAgICAgICAgIDwmaW9tbXUgTTRVX1BPUlRfVkVOQ19SRUNfQ0hST01BX1NFVDI+
Ow0KKyAgICBtZWRpYXRlayxsYXJiID0gPCZsYXJiNT47DQogICAgIG1lZGlhdGVrLHZwdSA9IDwm
dnB1PjsNCi0gICAgY2xvY2tzID0gPCZ0b3Bja2dlbiBDTEtfVE9QX1ZFTkNQTExfRDI+LA0KLSAg
ICAgICAgICAgICA8JnRvcGNrZ2VuIENMS19UT1BfVkVOQ19TRUw+LA0KLSAgICAgICAgICAgICA8
JnRvcGNrZ2VuIENMS19UT1BfVU5JVlBMTDFfRDI+LA0KLSAgICAgICAgICAgICA8JnRvcGNrZ2Vu
IENMS19UT1BfVkVOQ19MVF9TRUw+Ow0KLSAgICBjbG9jay1uYW1lcyA9ICJ2ZW5jX3NlbF9zcmMi
LA0KLSAgICAgICAgICAgICAgICAgICJ2ZW5jX3NlbCIsDQotICAgICAgICAgICAgICAgICAgInZl
bmNfbHRfc2VsX3NyYyIsDQotICAgICAgICAgICAgICAgICAgInZlbmNfbHRfc2VsIjsNCi0gICAg
YXNzaWduZWQtY2xvY2tzID0gPCZ0b3Bja2dlbiBDTEtfVE9QX1ZFTkNfU0VMPiwNCi0gICAgICAg
ICAgICAgICAgICAgICAgPCZ0b3Bja2dlbiBDTEtfVE9QX1ZFTkNfTFRfU0VMPjsNCi0gICAgYXNz
aWduZWQtY2xvY2stcGFyZW50cyA9IDwmdG9wY2tnZW4gQ0xLX1RPUF9WRU5DUExMX0QyPiwNCi0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmdG9wY2tnZW4gQ0xLX1RPUF9VTklWUExMMV9E
Mj47DQorICAgIGNsb2NrcyA9IDwmdG9wY2tnZW4gQ0xLX1RPUF9WRU5DX0xUX1NFTD47DQorICAg
IGNsb2NrLW5hbWVzID0gInZlbmNfbHRfc2VsIjsNCisgICAgYXNzaWduZWQtY2xvY2tzID0gPCZ0
b3Bja2dlbiBDTEtfVE9QX1ZFTkNfTFRfU0VMPjsNCisgICAgYXNzaWduZWQtY2xvY2stcGFyZW50
cyA9IDwmdG9wY2tnZW4gQ0xLX1RPUF9WQ09ERUNQTExfMzcwUDU+Ow0KICAgfTsNCi0tIA0KMS45
LjENCg==

