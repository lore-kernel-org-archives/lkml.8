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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892AAC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 649CB2070E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EQ/AeGy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgE3IO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 04:14:57 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:27547 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728714AbgE3IO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 04:14:56 -0400
X-UUID: de14d8edaccb421d9e132428fae02f70-20200530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=UzfE6L+Q+N5T60qWBYKFvl/nWB8dnMHgO4HFEf6j0Lk=;
        b=EQ/AeGy179Ew+/hKZOBs/oIb1tNjzQNd1dAKioPKcPdTY4A6ZhTV5Qftx+4OUTssOYtDOwju6HaYVANLy2vex0E16BVgTaQ4H5ppayeFIPbOKeVb/HGzv/fQfCP+hbFyjaGQ1KeMGT0YOTRbgeR9w2LT2hL/wa7nKlXWrJHZ7Nk=;
X-UUID: de14d8edaccb421d9e132428fae02f70-20200530
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 169133581; Sat, 30 May 2020 16:14:53 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 30 May 2020 16:14:50 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 30 May 2020 16:14:50 +0800
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
        <acourbot@chromium.org>, Irui Wang <irui.wang@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: [PATCH v4 16/17] arm64: dts: mt8173: Separate mtk-vcodec-enc node
Date:   Sat, 30 May 2020 16:10:17 +0800
Message-ID: <1590826218-23653-17-git-send-email-yong.wu@mediatek.com>
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

RnJvbTogSXJ1aSBXYW5nIDxpcnVpLndhbmdAbWVkaWF0ZWsuY29tPg0KDQpUaGVyZSBhcmUgdHdv
IHNlcGFyYXRlIGhhcmR3YXJlIGVuY29kZXIgYmxvY2tzIGluc2lkZSBNVDgxNzMuIFNwbGl0DQp0
aGUgY3VycmVudCBtdGstdmNvZGVjLWVuYyBub2RlIHRvIG1hdGNoIHRoZSBoYXJkd2FyZSBhcmNo
aXRlY3R1cmUuDQoNClNpZ25lZC1vZmYtYnk6IElydWkgV2FuZyA8aXJ1aS53YW5nQG1lZGlhdGVr
LmNvbT4NClNpZ25lZC1vZmYtYnk6IEhzaW4tWWkgV2FuZyA8aHNpbnlpQGNocm9taXVtLm9yZz4N
Ci0tLQ0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTczLmR0c2kgfCA2MCArKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAzMSBpbnNlcnRp
b25zKCspLCAyOSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvbWVkaWF0ZWsvbXQ4MTczLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210
ODE3My5kdHNpDQppbmRleCBmYjIxYTZiLi45ZmNjYmVjIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02
NC9ib290L2R0cy9tZWRpYXRlay9tdDgxNzMuZHRzaQ0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0
cy9tZWRpYXRlay9tdDgxNzMuZHRzaQ0KQEAgLTEzNjQsMTMgKzEzNjQsMTAgQEANCiAJCX07DQog
DQogCQl2Y29kZWNfZW5jOiB2Y29kZWNAMTgwMDIwMDAgew0KLQkJCWNvbXBhdGlibGUgPSAibWVk
aWF0ZWssbXQ4MTczLXZjb2RlYy1lbmMiOw0KLQkJCXJlZyA9IDwwIDB4MTgwMDIwMDAgMCAweDEw
MDA+LAkvKiBWRU5DX1NZUyAqLw0KLQkJCSAgICAgIDwwIDB4MTkwMDIwMDAgMCAweDEwMDA+Owkv
KiBWRU5DX0xUX1NZUyAqLw0KLQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAxOTggSVJRX1RZUEVf
TEVWRUxfTE9XPiwNCi0JCQkJICAgICA8R0lDX1NQSSAyMDIgSVJRX1RZUEVfTEVWRUxfTE9XPjsN
Ci0JCQltZWRpYXRlayxsYXJiID0gPCZsYXJiMz4sDQotCQkJCQk8JmxhcmI1PjsNCisJCQljb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10ODE3My12Y29kZWMtYXZjLWVuYyI7DQorCQkJcmVnID0gPDAg
MHgxODAwMjAwMCAwIDB4MTAwMD47CS8qIFZFTkNfU1lTICovDQorCQkJaW50ZXJydXB0cyA9IDxH
SUNfU1BJIDE5OCBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KKwkJCW1lZGlhdGVrLGxhcmIgPSA8Jmxh
cmIzPjsNCiAJCQlpb21tdXMgPSA8JmlvbW11IE00VV9QT1JUX1ZFTkNfUkNQVT4sDQogCQkJCSA8
JmlvbW11IE00VV9QT1JUX1ZFTkNfUkVDPiwNCiAJCQkJIDwmaW9tbXUgTTRVX1BPUlRfVkVOQ19C
U0RNQT4sDQpAQCAtMTM4MSwyOSArMTM3OCwxMiBAQA0KIAkJCQkgPCZpb21tdSBNNFVfUE9SVF9W
RU5DX1JFRl9MVU1BPiwNCiAJCQkJIDwmaW9tbXUgTTRVX1BPUlRfVkVOQ19SRUZfQ0hST01BPiwN
CiAJCQkJIDwmaW9tbXUgTTRVX1BPUlRfVkVOQ19OQk1fUkRNQT4sDQotCQkJCSA8JmlvbW11IE00
VV9QT1JUX1ZFTkNfTkJNX1dETUE+LA0KLQkJCQkgPCZpb21tdSBNNFVfUE9SVF9WRU5DX1JDUFVf
U0VUMj4sDQotCQkJCSA8JmlvbW11IE00VV9QT1JUX1ZFTkNfUkVDX0ZSTV9TRVQyPiwNCi0JCQkJ
IDwmaW9tbXUgTTRVX1BPUlRfVkVOQ19CU0RNQV9TRVQyPiwNCi0JCQkJIDwmaW9tbXUgTTRVX1BP
UlRfVkVOQ19TVl9DT01BX1NFVDI+LA0KLQkJCQkgPCZpb21tdSBNNFVfUE9SVF9WRU5DX1JEX0NP
TUFfU0VUMj4sDQotCQkJCSA8JmlvbW11IE00VV9QT1JUX1ZFTkNfQ1VSX0xVTUFfU0VUMj4sDQot
CQkJCSA8JmlvbW11IE00VV9QT1JUX1ZFTkNfQ1VSX0NIUk9NQV9TRVQyPiwNCi0JCQkJIDwmaW9t
bXUgTTRVX1BPUlRfVkVOQ19SRUZfTFVNQV9TRVQyPiwNCi0JCQkJIDwmaW9tbXUgTTRVX1BPUlRf
VkVOQ19SRUNfQ0hST01BX1NFVDI+Ow0KKwkJCQkgPCZpb21tdSBNNFVfUE9SVF9WRU5DX05CTV9X
RE1BPjsNCiAJCQltZWRpYXRlayx2cHUgPSA8JnZwdT47DQotCQkJY2xvY2tzID0gPCZ0b3Bja2dl
biBDTEtfVE9QX1ZFTkNQTExfRDI+LA0KLQkJCQkgPCZ0b3Bja2dlbiBDTEtfVE9QX1ZFTkNfU0VM
PiwNCi0JCQkJIDwmdG9wY2tnZW4gQ0xLX1RPUF9VTklWUExMMV9EMj4sDQotCQkJCSA8JnRvcGNr
Z2VuIENMS19UT1BfVkVOQ19MVF9TRUw+Ow0KLQkJCWNsb2NrLW5hbWVzID0gInZlbmNfc2VsX3Ny
YyIsDQotCQkJCSAgICAgICJ2ZW5jX3NlbCIsDQotCQkJCSAgICAgICJ2ZW5jX2x0X3NlbF9zcmMi
LA0KLQkJCQkgICAgICAidmVuY19sdF9zZWwiOw0KLQkJCWFzc2lnbmVkLWNsb2NrcyA9IDwmdG9w
Y2tnZW4gQ0xLX1RPUF9WRU5DX1NFTD4sDQotCQkJCQkgIDwmdG9wY2tnZW4gQ0xLX1RPUF9WRU5D
X0xUX1NFTD47DQotCQkJYXNzaWduZWQtY2xvY2stcGFyZW50cyA9IDwmdG9wY2tnZW4gQ0xLX1RP
UF9WRU5DUExMX0QyPiwNCi0JCQkJCQkgPCZ0b3Bja2dlbiBDTEtfVE9QX1VOSVZQTEwxX0QyPjsN
CisJCQljbG9ja3MgPSA8JnRvcGNrZ2VuIENMS19UT1BfVkVOQ19TRUw+Ow0KKwkJCWNsb2NrLW5h
bWVzID0gInZlbmNfc2VsIjsNCisJCQlhc3NpZ25lZC1jbG9ja3MgPSA8JnRvcGNrZ2VuIENMS19U
T1BfVkVOQ19TRUw+Ow0KKwkJCWFzc2lnbmVkLWNsb2NrLXBhcmVudHMgPSA8JnRvcGNrZ2VuIENM
S19UT1BfVkNPREVDUExMPjsNCiAJCX07DQogDQogCQlqcGVnZGVjOiBqcGVnZGVjQDE4MDA0MDAw
IHsNCkBAIC0xNDM1LDYgKzE0MTUsMjggQEANCiAJCQkJIDwmdmVuY2x0c3lzIENMS19WRU5DTFRf
Q0tFMD47DQogCQkJY2xvY2stbmFtZXMgPSAiYXBiIiwgInNtaSI7DQogCQl9Ow0KKw0KKwkJdmNv
ZGVjX2VuY19sdDogdmNvZGVjQDE5MDAyMDAwIHsNCisJCQljb21wYXRpYmxlID0gIm1lZGlhdGVr
LG10ODE3My12Y29kZWMtdnA4LWVuYyI7DQorCQkJcmVnID0gIDwwIDB4MTkwMDIwMDAgMCAweDEw
MDA+OwkvKiBWRU5DX0xUX1NZUyAqLw0KKwkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAyMDIgSVJR
X1RZUEVfTEVWRUxfTE9XPjsNCisJCQlpb21tdXMgPSA8JmlvbW11IE00VV9QT1JUX1ZFTkNfUkNQ
VV9TRVQyPiwNCisJCQkJIDwmaW9tbXUgTTRVX1BPUlRfVkVOQ19SRUNfRlJNX1NFVDI+LA0KKwkJ
CQkgPCZpb21tdSBNNFVfUE9SVF9WRU5DX0JTRE1BX1NFVDI+LA0KKwkJCQkgPCZpb21tdSBNNFVf
UE9SVF9WRU5DX1NWX0NPTUFfU0VUMj4sDQorCQkJCSA8JmlvbW11IE00VV9QT1JUX1ZFTkNfUkRf
Q09NQV9TRVQyPiwNCisJCQkJIDwmaW9tbXUgTTRVX1BPUlRfVkVOQ19DVVJfTFVNQV9TRVQyPiwN
CisJCQkJIDwmaW9tbXUgTTRVX1BPUlRfVkVOQ19DVVJfQ0hST01BX1NFVDI+LA0KKwkJCQkgPCZp
b21tdSBNNFVfUE9SVF9WRU5DX1JFRl9MVU1BX1NFVDI+LA0KKwkJCQkgPCZpb21tdSBNNFVfUE9S
VF9WRU5DX1JFQ19DSFJPTUFfU0VUMj47DQorCQkJbWVkaWF0ZWssbGFyYiA9IDwmbGFyYjU+Ow0K
KwkJCW1lZGlhdGVrLHZwdSA9IDwmdnB1PjsNCisJCQljbG9ja3MgPSA8JnRvcGNrZ2VuIENMS19U
T1BfVkVOQ19MVF9TRUw+Ow0KKwkJCWNsb2NrLW5hbWVzID0gInZlbmNfbHRfc2VsIjsNCisJCQlh
c3NpZ25lZC1jbG9ja3MgPSA8JnRvcGNrZ2VuIENMS19UT1BfVkVOQ19MVF9TRUw+Ow0KKwkJCWFz
c2lnbmVkLWNsb2NrLXBhcmVudHMgPSA8JnRvcGNrZ2VuDQorCQkJCQkJICBDTEtfVE9QX1ZDT0RF
Q1BMTF8zNzBQNT47DQorCQl9Ow0KIAl9Ow0KIH07DQogDQotLSANCjEuOS4xDQo=

