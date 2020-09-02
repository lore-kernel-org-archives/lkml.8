Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2B0C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B92CD2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="L0GglRgr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgIBGeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 02:34:11 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46978 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726301AbgIBGeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 02:34:09 -0400
X-UUID: 9181e59758034cfc9b3a72050d05a74e-20200902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=t/mmIReHAuUCSGNHgLFwXSx2t7ItYAk8SFunmzCQg/w=;
        b=L0GglRgrtTVb+znavw1s5/tOgP2Lrkn+QNYIDyUgLRh1b7R+AZrAdQiHcAM2T5yk8yXDW3Mm90VdKt46VwX5SPGmAyw2b/LZungNDUa2L3a6D7UPfPBxZzK9EVJORG7BgZ8SiGujEjHwnDzqeA1/wGF9R0DV3HdBR9qbKsBHyNA=;
X-UUID: 9181e59758034cfc9b3a72050d05a74e-20200902
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 87235445; Wed, 02 Sep 2020 14:34:07 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 2 Sep 2020 14:34:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Sep 2020 14:34:05 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <maz@kernel.org>, <robh+dt@kernel.org>
CC:     <mark-pk.tsai@mediatek.com>, <alix.wu@mediatek.com>,
        <daniel@0x0f.com>, <devicetree@vger.kernel.org>,
        <jason@lakedaemon.net>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <tglx@linutronix.de>, <yj.chiang@mediatek.com>
Subject: [PATCH v3 2/2] dt-bindings: interrupt-controller: Add MStar interrupt controller
Date:   Wed, 2 Sep 2020 14:33:44 +0800
Message-ID: <20200902063344.1852-3-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200902063344.1852-1-mark-pk.tsai@mediatek.com>
References: <20200902063344.1852-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGJpbmRpbmcgZm9yIE1TdGFyIGludGVycnVwdCBjb250cm9sbGVyLg0KDQpTaWduZWQtb2Zm
LWJ5OiBNYXJrLVBLIFRzYWkgPG1hcmstcGsudHNhaUBtZWRpYXRlay5jb20+DQotLS0NCiAuLi4v
aW50ZXJydXB0LWNvbnRyb2xsZXIvbXN0YXIsbXN0LWludGMueWFtbCAgfCA2NCArKysrKysrKysr
KysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDY0IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250
cm9sbGVyL21zdGFyLG1zdC1pbnRjLnlhbWwNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9tc3Rhcixtc3QtaW50Yy55
YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9s
bGVyL21zdGFyLG1zdC1pbnRjLnlhbWwNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAw
MDAwMDAwMDAuLmJiZjBmMjZjZDAwOA0KLS0tIC9kZXYvbnVsbA0KKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL21zdGFyLG1zdC1pbnRj
LnlhbWwNCkBAIC0wLDAgKzEsNjQgQEANCisjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BM
LTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCislWUFNTCAxLjINCistLS0NCiskaWQ6IGh0dHA6
Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2ludGVycnVwdC1jb250cm9sbGVyL21zdGFyLG1zdC1p
bnRjLnlhbWwjDQorJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9j
b3JlLnlhbWwjDQorDQordGl0bGU6IE1TdGFyIEludGVycnVwdCBDb250cm9sbGVyDQorDQorbWFp
bnRhaW5lcnM6DQorICAtIE1hcmstUEsgVHNhaSA8bWFyay1way50c2FpQG1lZGlhdGVrLmNvbT4N
CisNCitkZXNjcmlwdGlvbjogfCsNCisgIE1TdGFyLCBTaWdtYVN0YXIgYW5kIE1lZGlhdGVrIFRW
IFNvQ3MgY29udGFpbiBtdWx0aXBsZSBsZWdhY3kNCisgIGludGVycnVwdCBjb250cm9sbGVycyB0
aGF0IHJvdXRlcyBpbnRlcnJ1cHRzIHRvIHRoZSBHSUMuDQorDQorICBUaGUgSFcgYmxvY2sgZXhw
b3NlcyBhIG51bWJlciBvZiBpbnRlcnJ1cHQgY29udHJvbGxlcnMsIGVhY2gNCisgIGNhbiBzdXBw
b3J0IHVwIHRvIDY0IGludGVycnVwdHMuDQorDQorcHJvcGVydGllczoNCisgIGNvbXBhdGlibGU6
DQorICAgIGNvbnN0OiBtc3Rhcixtc3QtaW50Yw0KKw0KKyAgaW50ZXJydXB0LWNvbnRyb2xsZXI6
IHRydWUNCisNCisgICIjaW50ZXJydXB0LWNlbGxzIjoNCisgICAgY29uc3Q6IDMNCisgICAgZGVz
Y3JpcHRpb246IHwNCisgICAgICBVc2UgdGhlIHNhbWUgZm9ybWF0IGFzIHNwZWNpZmllZCBieSBH
SUMgaW4gYXJtLGdpYy55YW1sLg0KKw0KKyAgcmVnOg0KKyAgICBtYXhJdGVtczogMQ0KKw0KKyAg
bXN0YXIsaXJxcy1tYXAtcmFuZ2U6DQorICAgIGRlc2NyaXB0aW9uOiB8DQorICAgICAgVGhlIHJh
bmdlIDxzdGFydCwgZW5kPiBvZiBwYXJlbnQgaW50ZXJydXB0IGNvbnRyb2xsZXIncyBpbnRlcnJ1
cHQNCisgICAgICBsaW5lcyB0aGF0IGFyZSBoYXJkd2lyZWQgdG8gbXN0YXIgaW50ZXJydXB0IGNv
bnRyb2xsZXIuDQorICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3Vp
bnQzMi1tYXRyaXgNCisgICAgaXRlbXM6DQorICAgICAgbWluSXRlbXM6IDINCisgICAgICBtYXhJ
dGVtczogMg0KKw0KKyAgbXN0YXIsaW50Yy1uby1lb2k6DQorICAgIGRlc2NyaXB0aW9uOg0KKyAg
ICAgIE1hcmsgdGhpcyBjb250cm9sbGVyIGhhcyBubyBFbmQgT2YgSW50ZXJydXB0KEVPSSkgaW1w
bGVtZW50YXRpb24uDQorICAgIHR5cGU6IGJvb2xlYW4NCisNCityZXF1aXJlZDoNCisgIC0gY29t
cGF0aWJsZQ0KKyAgLSByZWcNCisgIC0gbXN0YXIsaXJxcy1tYXAtcmFuZ2UNCisNCithZGRpdGlv
bmFsUHJvcGVydGllczogZmFsc2UNCisNCitleGFtcGxlczoNCisgIC0gfA0KKyAgICBtc3RfaW50
YzA6IGludGVycnVwdC1jb250cm9sbGVyQDFmMjAzMmQwIHsNCisgICAgICBjb21wYXRpYmxlID0g
Im1zdGFyLG1zdC1pbnRjIjsNCisgICAgICBpbnRlcnJ1cHQtY29udHJvbGxlcjsNCisgICAgICAj
aW50ZXJydXB0LWNlbGxzID0gPDM+Ow0KKyAgICAgIGludGVycnVwdC1wYXJlbnQgPSA8JmdpYz47
DQorICAgICAgcmVnID0gPDB4MWYyMDMyZDAgMHgzMD47DQorICAgICAgbXN0YXIsaXJxcy1tYXAt
cmFuZ2UgPSA8MCA2Mz47DQorICAgIH07DQorLi4uDQotLSANCjIuMTguMA0K

