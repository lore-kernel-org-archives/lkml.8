Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECCDC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 03:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06ABE204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 03:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RfSu+rcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgHSDmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 23:42:51 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:14811 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726318AbgHSDms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 23:42:48 -0400
X-UUID: 5160d2c900fd46c3838dbea551d4a832-20200819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kpBsxONTkkbc5bOYHR9hFMap17MiXFktP1dZs/pBlQA=;
        b=RfSu+rcZUd3Cub/Xyz1jxH+TTd6MqM4ZtiXa3/zxdvv76GbCWgR25ZQ35bQz/wG0L+4OInFwm6XTG7K1ADSxbeQYBv0hhl/4SsyVGEOuGarLMt9RlMQKbKO4hmOFIo0lRk//LBHrIkXyvEBCXtrg30LGtwwra3NtPjCdbSLVEC4=;
X-UUID: 5160d2c900fd46c3838dbea551d4a832-20200819
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1897202186; Wed, 19 Aug 2020 11:42:45 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 Aug 2020 11:42:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Aug 2020 11:42:40 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <maz@kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <mark-pk.tsai@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <yj.chiang@mediatek.com>,
        <alix.wu@mediatek.com>, <daniel@0x0f.com>
Subject: [PATCH 2/2] dt-bindings: interrupt-controller: Add MStar interrupt controller
Date:   Wed, 19 Aug 2020 11:42:31 +0800
Message-ID: <20200819034231.20726-3-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200819034231.20726-1-mark-pk.tsai@mediatek.com>
References: <20200819034231.20726-1-mark-pk.tsai@mediatek.com>
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
aW50ZXJydXB0LWNvbnRyb2xsZXIvbXN0YXIsbXN0LWludGMueWFtbCAgfCA4MiArKysrKysrKysr
KysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDgyIGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250
cm9sbGVyL21zdGFyLG1zdC1pbnRjLnlhbWwNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9tc3Rhcixtc3QtaW50Yy55
YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9s
bGVyL21zdGFyLG1zdC1pbnRjLnlhbWwNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAw
MDAwMDAwMDAuLjZlMzgzMzE1ZTUyOQ0KLS0tIC9kZXYvbnVsbA0KKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL21zdGFyLG1zdC1pbnRj
LnlhbWwNCkBAIC0wLDAgKzEsODIgQEANCisjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wDQorJVlBTUwgMS4yDQorLS0tDQorJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1h
cy9pbnRlcnJ1cHQtY29udHJvbGxlci9tc3Rhcixtc3QtaW50Yy55YW1sIw0KKyRzY2hlbWE6IGh0
dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KKw0KK3RpdGxlOiBN
U3RhciBJbnRlcnJ1cHQgQ29udHJvbGxlcg0KKw0KK21haW50YWluZXJzOg0KKyAgLSBNYXJrLVBL
IFRzYWkgPG1hcmstcGsudHNhaUBtZWRpYXRlay5jb20+DQorDQorZGVzY3JpcHRpb246IHwrDQor
ICBNU3RhciwgU2lnbWFTdGFyIGFuZCBNZWRpYXRlayBEVFYgU29DcyBjb250YWluIG11bHRpcGxl
IGxlZ2FjeQ0KKyAgaW50ZXJydXB0IGNvbnRyb2xsZXJzIHRoYXQgcm91dGVzIGludGVycnVwdHMg
dG8gdGhlIEdJQy4NCisNCisgIFRoZSBIVyBibG9jayBleHBvc2VzIGEgbnVtYmVyIG9mIGludGVy
cnVwdCBjb250cm9sbGVycywgZWFjaA0KKyAgY2FuIHN1cHBvcnQgdXAgdG8gNjQgaW50ZXJydXB0
cy4NCisNCithbGxPZjoNCisgIC0gJHJlZjogL3NjaGVtYXMvaW50ZXJydXB0LWNvbnRyb2xsZXIu
eWFtbCMNCisNCitwcm9wZXJ0aWVzOg0KKyAgY29tcGF0aWJsZToNCisgICAgaXRlbXM6DQorICAg
ICAgLSBjb25zdDogbXN0YXIsbXN0LWludGMNCisgICAgICAtIGVudW06DQorICAgICAgICAgIC0g
bWVkaWF0ZWssbXQ1OHh4LWludGMNCisNCisgIGludGVycnVwdC1jb250cm9sbGVyOiB0cnVlDQor
DQorICAiI2FkZHJlc3MtY2VsbHMiOg0KKyAgICBlbnVtOiBbIDAsIDEsIDIgXQ0KKw0KKyAgIiNz
aXplLWNlbGxzIjoNCisgICAgZW51bTogWyAxLCAyIF0NCisNCisgICIjaW50ZXJydXB0LWNlbGxz
IjoNCisgICAgY29uc3Q6IDMNCisgICAgZGVzY3JpcHRpb246IHwNCisgICAgICBVc2UgdGhlIHNh
bWUgZm9ybWF0IGFzIHNwZWNpZmllZCBieSBHSUMgaW4gYXJtLGdpYy55YW1sLg0KKw0KKyAgcmVn
Og0KKyAgICBkZXNjcmlwdGlvbjogfA0KKyAgICAgIFBoeXNpY2FsIGJhc2UgYWRkcmVzcyBvZiB0
aGUgbXN0YXIgaW50ZXJydXB0IGNvbnRyb2xsZXINCisgICAgICByZWdpc3RlcnMgYW5kIGxlbmd0
aCBvZiBtZW1vcnkgbWFwcGVkIHJlZ2lvbi4NCisgICAgbWluSXRlbXM6IDENCisNCisgIG1zdGFy
LGlycXMtbWFwLXJhbmdlOg0KKyAgICBkZXNjcmlwdGlvbjogfA0KKyAgICAgIFRoZSByYW5nZSBv
ZiBwYXJlbnQgaW50ZXJydXB0IGNvbnRyb2xsZXIncyBpbnRlcnJ1cHQgbGluZXMNCisgICAgICB0
aGF0IGFyZSBoYXJkd2lyZWQgdG8gbXN0YXIgaW50ZXJydXB0IGNvbnRyb2xsZXIuDQorICAgICRy
ZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMi1tYXRyaXgNCisgICAg
aXRlbXM6DQorICAgICAgbWluSXRlbXM6IDINCisgICAgICBtYXhJdGVtczogMg0KKw0KKyAgbXN0
YXIsaW50Yy1uby1lb2k6DQorICAgIGRlc2NyaXB0aW9uOiB8DQorICAgICAgTWFyayB0aGlzIGNv
bnRyb2xsZXIgaGFzIG5vIEVuZCBPZiBJbnRlcnJ1cHQoRU9JKSBpbXBsZW1lbnRhdGlvbi4NCisg
ICAgICBUaGlzIGlzIGEgZW1wdHksIGJvb2xlYW4gcHJvcGVydHkuDQorICAgIHR5cGU6IGJvb2xl
YW4NCisNCityZXF1aXJlZDoNCisgIC0gY29tcGF0aWJsZQ0KKyAgLSByZWcNCisgIC0gbXN0YXIs
aXJxcy1tYXAtcmFuZ2UNCisNCithZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCisNCitleGFt
cGxlczoNCisgIC0gfA0KKyAgICBtc3RfaW50YzA6IGludGVycnVwdC1jb250cm9sbGVyQDFmMjAz
MmQwIHsNCisgICAgICBjb21wYXRpYmxlID0gIm1zdGFyLG1zdC1pbnRjIiwgIm1lZGlhdGVrLG10
NTh4eC1pbnRjIjsNCisgICAgICBpbnRlcnJ1cHQtY29udHJvbGxlcjsNCisgICAgICAjaW50ZXJy
dXB0LWNlbGxzID0gPDM+Ow0KKyAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KKyAgICAgICNz
aXplLWNlbGxzID0gPDE+Ow0KKyAgICAgIGludGVycnVwdC1wYXJlbnQgPSA8JmdpYz47DQorICAg
ICAgcmVnID0gPDB4MWYyMDMyZDAgMHgzMD47DQorICAgICAgbXN0YXIsaXJxcy1tYXAtcmFuZ2Ug
PSA8MCA2Mz47DQorICAgIH07DQorLi4uDQotLSANCjIuMTguMA0K

