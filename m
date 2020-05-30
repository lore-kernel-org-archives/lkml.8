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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96811C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67B782070E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WoItoK9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgE3IPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 04:15:07 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:14557 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728714AbgE3IPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 04:15:06 -0400
X-UUID: 7f1c8947612342a3b81e3fa3c937bd3d-20200530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JyIu4KZk/rNQyfZafP7R9KjJHq8mZ+Y5T2MKy+5I7n8=;
        b=WoItoK9NpLdllrsNTcX12OGgINLiUImth6XpZvxjwcDdHkbVYbEnJ0E2OlZTrwm1qD0SkYHZdiKVpCxAEqOent0Ke83M/HEosCTTazsj5acY0AnhCvnFjSIMQDVKEYHY7F3DRZ3La3PtWJgvtcIe0oa29FcEuARnCbSd55beRmU=;
X-UUID: 7f1c8947612342a3b81e3fa3c937bd3d-20200530
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 686325910; Sat, 30 May 2020 16:15:01 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 30 May 2020 16:14:58 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 30 May 2020 16:14:58 +0800
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
Subject: [PATCH v4 17/17] arm64: dts: mediatek: Get rid of mediatek,larb for MM nodes
Date:   Sat, 30 May 2020 16:10:18 +0800
Message-ID: <1590826218-23653-18-git-send-email-yong.wu@mediatek.com>
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

QWZ0ZXIgYWRkaW5nIGRldmljZV9saW5rIGJldHdlZW4gdGhlIElPTU1VIGNvbnN1bWVyIGFuZCBz
bWksDQp0aGUgbWVkaWF0ZWssbGFyYiBpcyB1bm5lY2Vzc2FyeSBub3cuDQoNCkNDOiBNYXR0aGlh
cyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPg0KU2lnbmVkLW9mZi1ieTogWW9uZyBX
dSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQpSZXZpZXdlZC1ieTogRXZhbiBHcmVlbiA8ZXZncmVl
bkBjaHJvbWl1bS5vcmc+DQotLS0NCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE3
My5kdHNpIHwgMTYgLS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxNiBkZWxldGlv
bnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTcz
LmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE3My5kdHNpDQppbmRleCA5
ZmNjYmVjLi43ZWVkOGM4IDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRl
ay9tdDgxNzMuZHRzaQ0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxNzMu
ZHRzaQ0KQEAgLTkyNiw3ICs5MjYsNiBAQA0KIAkJCQkgPCZtbXN5cyBDTEtfTU1fTVVURVhfMzJL
PjsNCiAJCQlwb3dlci1kb21haW5zID0gPCZzY3BzeXMgTVQ4MTczX1BPV0VSX0RPTUFJTl9NTT47
DQogCQkJaW9tbXVzID0gPCZpb21tdSBNNFVfUE9SVF9NRFBfUkRNQTA+Ow0KLQkJCW1lZGlhdGVr
LGxhcmIgPSA8JmxhcmIwPjsNCiAJCQltZWRpYXRlayx2cHUgPSA8JnZwdT47DQogCQl9Ow0KIA0K
QEAgLTkzNyw3ICs5MzYsNiBAQA0KIAkJCQkgPCZtbXN5cyBDTEtfTU1fTVVURVhfMzJLPjsNCiAJ
CQlwb3dlci1kb21haW5zID0gPCZzY3BzeXMgTVQ4MTczX1BPV0VSX0RPTUFJTl9NTT47DQogCQkJ
aW9tbXVzID0gPCZpb21tdSBNNFVfUE9SVF9NRFBfUkRNQTE+Ow0KLQkJCW1lZGlhdGVrLGxhcmIg
PSA8JmxhcmI0PjsNCiAJCX07DQogDQogCQltZHBfcnN6MDogcnN6QDE0MDAzMDAwIHsNCkBAIC05
NjcsNyArOTY1LDYgQEANCiAJCQljbG9ja3MgPSA8Jm1tc3lzIENMS19NTV9NRFBfV0RNQT47DQog
CQkJcG93ZXItZG9tYWlucyA9IDwmc2Nwc3lzIE1UODE3M19QT1dFUl9ET01BSU5fTU0+Ow0KIAkJ
CWlvbW11cyA9IDwmaW9tbXUgTTRVX1BPUlRfTURQX1dETUE+Ow0KLQkJCW1lZGlhdGVrLGxhcmIg
PSA8JmxhcmIwPjsNCiAJCX07DQogDQogCQltZHBfd3JvdDA6IHdyb3RAMTQwMDcwMDAgew0KQEAg
LTk3Niw3ICs5NzMsNiBAQA0KIAkJCWNsb2NrcyA9IDwmbW1zeXMgQ0xLX01NX01EUF9XUk9UMD47
DQogCQkJcG93ZXItZG9tYWlucyA9IDwmc2Nwc3lzIE1UODE3M19QT1dFUl9ET01BSU5fTU0+Ow0K
IAkJCWlvbW11cyA9IDwmaW9tbXUgTTRVX1BPUlRfTURQX1dST1QwPjsNCi0JCQltZWRpYXRlayxs
YXJiID0gPCZsYXJiMD47DQogCQl9Ow0KIA0KIAkJbWRwX3dyb3QxOiB3cm90QDE0MDA4MDAwIHsN
CkBAIC05ODUsNyArOTgxLDYgQEANCiAJCQljbG9ja3MgPSA8Jm1tc3lzIENMS19NTV9NRFBfV1JP
VDE+Ow0KIAkJCXBvd2VyLWRvbWFpbnMgPSA8JnNjcHN5cyBNVDgxNzNfUE9XRVJfRE9NQUlOX01N
PjsNCiAJCQlpb21tdXMgPSA8JmlvbW11IE00VV9QT1JUX01EUF9XUk9UMT47DQotCQkJbWVkaWF0
ZWssbGFyYiA9IDwmbGFyYjQ+Ow0KIAkJfTsNCiANCiAJCW92bDA6IG92bEAxNDAwYzAwMCB7DQpA
QCAtOTk1LDcgKzk5MCw2IEBADQogCQkJcG93ZXItZG9tYWlucyA9IDwmc2Nwc3lzIE1UODE3M19Q
T1dFUl9ET01BSU5fTU0+Ow0KIAkJCWNsb2NrcyA9IDwmbW1zeXMgQ0xLX01NX0RJU1BfT1ZMMD47
DQogCQkJaW9tbXVzID0gPCZpb21tdSBNNFVfUE9SVF9ESVNQX09WTDA+Ow0KLQkJCW1lZGlhdGVr
LGxhcmIgPSA8JmxhcmIwPjsNCiAJCX07DQogDQogCQlvdmwxOiBvdmxAMTQwMGQwMDAgew0KQEAg
LTEwMDUsNyArOTk5LDYgQEANCiAJCQlwb3dlci1kb21haW5zID0gPCZzY3BzeXMgTVQ4MTczX1BP
V0VSX0RPTUFJTl9NTT47DQogCQkJY2xvY2tzID0gPCZtbXN5cyBDTEtfTU1fRElTUF9PVkwxPjsN
CiAJCQlpb21tdXMgPSA8JmlvbW11IE00VV9QT1JUX0RJU1BfT1ZMMT47DQotCQkJbWVkaWF0ZWss
bGFyYiA9IDwmbGFyYjQ+Ow0KIAkJfTsNCiANCiAJCXJkbWEwOiByZG1hQDE0MDBlMDAwIHsNCkBA
IC0xMDE1LDcgKzEwMDgsNiBAQA0KIAkJCXBvd2VyLWRvbWFpbnMgPSA8JnNjcHN5cyBNVDgxNzNf
UE9XRVJfRE9NQUlOX01NPjsNCiAJCQljbG9ja3MgPSA8Jm1tc3lzIENMS19NTV9ESVNQX1JETUEw
PjsNCiAJCQlpb21tdXMgPSA8JmlvbW11IE00VV9QT1JUX0RJU1BfUkRNQTA+Ow0KLQkJCW1lZGlh
dGVrLGxhcmIgPSA8JmxhcmIwPjsNCiAJCX07DQogDQogCQlyZG1hMTogcmRtYUAxNDAwZjAwMCB7
DQpAQCAtMTAyNSw3ICsxMDE3LDYgQEANCiAJCQlwb3dlci1kb21haW5zID0gPCZzY3BzeXMgTVQ4
MTczX1BPV0VSX0RPTUFJTl9NTT47DQogCQkJY2xvY2tzID0gPCZtbXN5cyBDTEtfTU1fRElTUF9S
RE1BMT47DQogCQkJaW9tbXVzID0gPCZpb21tdSBNNFVfUE9SVF9ESVNQX1JETUExPjsNCi0JCQlt
ZWRpYXRlayxsYXJiID0gPCZsYXJiND47DQogCQl9Ow0KIA0KIAkJcmRtYTI6IHJkbWFAMTQwMTAw
MDAgew0KQEAgLTEwMzUsNyArMTAyNiw2IEBADQogCQkJcG93ZXItZG9tYWlucyA9IDwmc2Nwc3lz
IE1UODE3M19QT1dFUl9ET01BSU5fTU0+Ow0KIAkJCWNsb2NrcyA9IDwmbW1zeXMgQ0xLX01NX0RJ
U1BfUkRNQTI+Ow0KIAkJCWlvbW11cyA9IDwmaW9tbXUgTTRVX1BPUlRfRElTUF9SRE1BMj47DQot
CQkJbWVkaWF0ZWssbGFyYiA9IDwmbGFyYjQ+Ow0KIAkJfTsNCiANCiAJCXdkbWEwOiB3ZG1hQDE0
MDExMDAwIHsNCkBAIC0xMDQ1LDcgKzEwMzUsNiBAQA0KIAkJCXBvd2VyLWRvbWFpbnMgPSA8JnNj
cHN5cyBNVDgxNzNfUE9XRVJfRE9NQUlOX01NPjsNCiAJCQljbG9ja3MgPSA8Jm1tc3lzIENMS19N
TV9ESVNQX1dETUEwPjsNCiAJCQlpb21tdXMgPSA8JmlvbW11IE00VV9QT1JUX0RJU1BfV0RNQTA+
Ow0KLQkJCW1lZGlhdGVrLGxhcmIgPSA8JmxhcmIwPjsNCiAJCX07DQogDQogCQl3ZG1hMTogd2Rt
YUAxNDAxMjAwMCB7DQpAQCAtMTA1NSw3ICsxMDQ0LDYgQEANCiAJCQlwb3dlci1kb21haW5zID0g
PCZzY3BzeXMgTVQ4MTczX1BPV0VSX0RPTUFJTl9NTT47DQogCQkJY2xvY2tzID0gPCZtbXN5cyBD
TEtfTU1fRElTUF9XRE1BMT47DQogCQkJaW9tbXVzID0gPCZpb21tdSBNNFVfUE9SVF9ESVNQX1dE
TUExPjsNCi0JCQltZWRpYXRlayxsYXJiID0gPCZsYXJiND47DQogCQl9Ow0KIA0KIAkJY29sb3Iw
OiBjb2xvckAxNDAxMzAwMCB7DQpAQCAtMTI5OSw3ICsxMjg3LDYgQEANCiAJCQkgICAgICA8MCAw
eDE2MDI3ODAwIDAgMHg4MDA+LAkvKiBWREVDX0hXQiAqLw0KIAkJCSAgICAgIDwwIDB4MTYwMjg0
MDAgMCAweDQwMD47CS8qIFZERUNfSFdHICovDQogCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDIw
NCBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KLQkJCW1lZGlhdGVrLGxhcmIgPSA8JmxhcmIxPjsNCiAJ
CQlpb21tdXMgPSA8JmlvbW11IE00VV9QT1JUX0hXX1ZERUNfTUNfRVhUPiwNCiAJCQkJIDwmaW9t
bXUgTTRVX1BPUlRfSFdfVkRFQ19QUF9FWFQ+LA0KIAkJCQkgPCZpb21tdSBNNFVfUE9SVF9IV19W
REVDX0FWQ19NVl9FWFQ+LA0KQEAgLTEzNjcsNyArMTM1NCw2IEBADQogCQkJY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxtdDgxNzMtdmNvZGVjLWF2Yy1lbmMiOw0KIAkJCXJlZyA9IDwwIDB4MTgwMDIw
MDAgMCAweDEwMDA+OwkvKiBWRU5DX1NZUyAqLw0KIAkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAx
OTggSVJRX1RZUEVfTEVWRUxfTE9XPjsNCi0JCQltZWRpYXRlayxsYXJiID0gPCZsYXJiMz47DQog
CQkJaW9tbXVzID0gPCZpb21tdSBNNFVfUE9SVF9WRU5DX1JDUFU+LA0KIAkJCQkgPCZpb21tdSBN
NFVfUE9SVF9WRU5DX1JFQz4sDQogCQkJCSA8JmlvbW11IE00VV9QT1JUX1ZFTkNfQlNETUE+LA0K
QEAgLTEzOTUsNyArMTM4MSw2IEBADQogCQkJY2xvY2stbmFtZXMgPSAianBnZGVjLXNtaSIsDQog
CQkJCSAgICAgICJqcGdkZWMiOw0KIAkJCXBvd2VyLWRvbWFpbnMgPSA8JnNjcHN5cyBNVDgxNzNf
UE9XRVJfRE9NQUlOX1ZFTkM+Ow0KLQkJCW1lZGlhdGVrLGxhcmIgPSA8JmxhcmIzPjsNCiAJCQlp
b21tdXMgPSA8JmlvbW11IE00VV9QT1JUX0pQR0RFQ19XRE1BPiwNCiAJCQkJIDwmaW9tbXUgTTRV
X1BPUlRfSlBHREVDX0JTRE1BPjsNCiAJCX07DQpAQCAtMTQyOSw3ICsxNDE0LDYgQEANCiAJCQkJ
IDwmaW9tbXUgTTRVX1BPUlRfVkVOQ19DVVJfQ0hST01BX1NFVDI+LA0KIAkJCQkgPCZpb21tdSBN
NFVfUE9SVF9WRU5DX1JFRl9MVU1BX1NFVDI+LA0KIAkJCQkgPCZpb21tdSBNNFVfUE9SVF9WRU5D
X1JFQ19DSFJPTUFfU0VUMj47DQotCQkJbWVkaWF0ZWssbGFyYiA9IDwmbGFyYjU+Ow0KIAkJCW1l
ZGlhdGVrLHZwdSA9IDwmdnB1PjsNCiAJCQljbG9ja3MgPSA8JnRvcGNrZ2VuIENMS19UT1BfVkVO
Q19MVF9TRUw+Ow0KIAkJCWNsb2NrLW5hbWVzID0gInZlbmNfbHRfc2VsIjsNCi0tIA0KMS45LjEN
Cg==

