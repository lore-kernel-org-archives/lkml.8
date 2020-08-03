Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BB9C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3129C206D4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nF9FOXiZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgHCGXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 02:23:08 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:14331 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728071AbgHCGXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 02:23:08 -0400
X-UUID: ec0323f58ea4438291c2b51bfb314908-20200803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=uYfWyEBf09draA4+Bw+2HdPo7pH44w0XlSp71SGm5QA=;
        b=nF9FOXiZW72aCluLjmqOBLh2yUslCQjpy3lUs7foLnB5UJMZ8z7HlDNWqdyydw/5swlIuXYiLPaZU6NwzqK8v8FI38pLwBm28ZgFH8dN1Z+zOqIeQiJqjNyZk78A2umgMbihU8p8Y7UIEKGww2X7Ldcqvisa33gIVtYQu882mww=;
X-UUID: ec0323f58ea4438291c2b51bfb314908-20200803
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 999196604; Mon, 03 Aug 2020 14:23:04 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 3 Aug 2020 14:23:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 3 Aug 2020 14:23:02 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <mark-pk.tsai@mediatek.com>
CC:     <yj.chiang@mediatek.com>, <alix.wu@mediatek.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>, <maz@kernel.org>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 2/2] dt-bindings: interrupt-controller: Add MT58XX interrupt controller
Date:   Mon, 3 Aug 2020 14:22:14 +0800
Message-ID: <20200803062214.24076-3-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200803062214.24076-1-mark-pk.tsai@mediatek.com>
References: <20200803062214.24076-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGJpbmRpbmcgZm9yIE1UNThYWCBpbnRlcnJ1cHQgY29udHJvbGxlci4NCg0KU2lnbmVkLW9m
Zi1ieTogTWFyay1QSyBUc2FpIDxtYXJrLXBrLnRzYWlAbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4u
L21lZGlhdGVrLG10NTh4eC1pbnRjLnlhbWwgICAgICAgICAgICAgICAgIHwgNzAgKysrKysrKysr
KysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA3MCBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29u
dHJvbGxlci9tZWRpYXRlayxtdDU4eHgtaW50Yy55YW1sDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvbWVkaWF0ZWss
bXQ1OHh4LWludGMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRl
cnJ1cHQtY29udHJvbGxlci9tZWRpYXRlayxtdDU4eHgtaW50Yy55YW1sDQpuZXcgZmlsZSBtb2Rl
IDEwMDY0NA0KaW5kZXggMDAwMDAwMDAwMDAwLi4yM2UwNDc2M2FiODYNCi0tLSAvZGV2L251bGwN
CisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJv
bGxlci9tZWRpYXRlayxtdDU4eHgtaW50Yy55YW1sDQpAQCAtMCwwICsxLDcwIEBADQorIyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KKyVZQU1MIDEuMg0KKy0tLQ0KKyRpZDogaHR0
cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXJtLGdpYy55
YW1sIw0KKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55
YW1sIw0KKw0KK3RpdGxlOiBNZWRpYVRlayBNVDU4WFggSW50ZXJydXB0IENvbnRyb2xsZXINCisN
CittYWludGFpbmVyczoNCisgIC0gTWFyay1QSyBUc2FpIDxtYXJrLXBrLnRzYWlAbWVkaWF0ZWsu
Y29tPg0KKw0KK2Rlc2NyaXB0aW9uOiB8Kw0KKyAgTWVkaWF0ZWsgRFRWIFNvQ3MgY29udGFpbiBt
dWx0aXBsZSBsZWdhY3kgaW50ZXJydXB0IGNvbnRyb2xsZXJzIHRoYXQNCisgIHJvdXRlcyBpbnRl
cnJ1cHRzIHRvIHRoZSBHSUMuIEFsbCB0aGUgbXQ1OHh4IFNvQ3MgaGF2ZSB0aGlzDQorICBjb250
cm9sbGVyLCBoZW5jZSB0aGUgbmFtZSBvZiBiaW5kaW5nLg0KKw0KKyAgVGhlIEhXIGJsb2NrIGV4
cG9zZXMgYSBudW1iZXIgb2YgaW50ZXJydXB0IGNvbnRyb2xsZXJzLCBlYWNoDQorICBjYW4gc3Vw
cG9ydCB1cCB0byA2NCBpbnRlcnJ1cHRzLg0KKw0KK2FsbE9mOg0KKyAgLSAkcmVmOiAvc2NoZW1h
cy9pbnRlcnJ1cHQtY29udHJvbGxlci55YW1sIw0KKw0KK3Byb3BlcnRpZXM6DQorICBjb21wYXRp
YmxlOg0KKyAgICAtIGl0ZW1zOg0KKyAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ1OHh4LWlu
dGMNCisNCisgIGludGVycnVwdC1jb250cm9sbGVyOiB0cnVlDQorDQorICAiI2FkZHJlc3MtY2Vs
bHMiOg0KKyAgICBlbnVtOiBbIDAsIDEgXQ0KKyAgIiNzaXplLWNlbGxzIjoNCisgICAgY29uc3Q6
IDENCisNCisgICIjaW50ZXJydXB0LWNlbGxzIjoNCisgICAgY29uc3Q6IDMNCisgICAgZGVzY3Jp
cHRpb246IHwNCisgICAgICBVc2UgdGhlIHNhbWUgZm9ybWF0IGFzIHNwZWNpZmllZCBieSBHSUMg
aW4gYXJtLGdpYy55YW1sLg0KKw0KKyAgcmVnOg0KKyAgICBkZXNjcmlwdGlvbjogfA0KKyAgICAg
IFBoeXNpY2FsIGJhc2UgYWRkcmVzcyBvZiB0aGUgTVQ1OHh4IGludGVycnVwdCBjb250cm9sbGVy
DQorICAgICAgcmVnaXN0ZXJzIGFuZCBsZW5ndGggb2YgbWVtb3J5IG1hcHBlZCByZWdpb24uDQor
DQorICBtZWRpYXRlayxpcnFzLW1hcC1yYW5nZToNCisgICAgZGVzY3JpcHRpb246IHwNCisgICAg
ICBUaGUgcmFuZ2Ugb2YgcGFyZW50IGludGVycnVwdCBjb250cm9sbGVyJ3MgaW50ZXJydXB0IGxp
bmVzDQorICAgICAgdGhhdCBhcmUgaGFyZHdpcmVkIHRvIE1UNTh4eCBpbnRlcnJ1cHQgY29udHJv
bGxlci4NCisNCisgIG1lZGlhdGVrLGludGMtbm8tZW9pOg0KKyAgICBkZXNjcmlwdGlvbjogfA0K
KyAgICAgIE1hcmsgdGhpcyBjb250cm9sbGVyIGhhcyBubyBFbmQgT2YgSW50ZXJydXB0KEVPSSkg
aW1wbGVtZW50YXRpb24uDQorICAgICAgVGhpcyBpcyBhIGVtcHR5LCBib29sZWFuIHByb3BlcnR5
Lg0KKw0KK3JlcXVpcmVkOg0KKyAgLSBjb21wYXRpYmxlDQorICAtIHJlZw0KKyAgLSBtZWRpYXRl
ayxpcnFzLW1hcC1yYW5nZQ0KKw0KK2V4YW1wbGVzOg0KKyAgLSB8DQorICAgIG10NTh4eF9pbnRj
MDogaW50ZXJydXB0LWNvbnRyb2xsZXJAMWYyMDMyZDAgew0KKyAgICAgIGNvbXBhdGlibGUgPSAi
bWVkaWF0ZWssbXQ1OHh4LWludGMiOw0KKyAgICAgIGludGVycnVwdC1jb250cm9sbGVyOw0KKyAg
ICAgICNpbnRlcnJ1cHQtY2VsbHMgPSA8MHgzPjsNCisgICAgICBpbnRlcnJ1cHQtcGFyZW50ID0g
PCZnaWM+Ow0KKyAgICAgIHJlZyA9IDwweDAgMHgxZjIwMzJkMCAweDAgMHgzMD47DQorICAgICAg
bWVkaWF0ZWssaXJxcy1tYXAtcmFuZ2UgPSA8MCA2Mz47DQorICAgIH07DQorLi4uDQotLSANCjIu
MTguMA0K

