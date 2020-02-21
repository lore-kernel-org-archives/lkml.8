Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AE1C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33AA20722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EvAkE69k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgBUKMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 05:12:18 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:5479 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728637AbgBUKMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 05:12:18 -0500
X-UUID: 8580c188ca1c4683b143bcc1bb34a3f7-20200221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=BeBQELOP6/jjvwXwwsxHmMAHpAErb5cdnorUWLKW/vk=;
        b=EvAkE69k9ORyuGLCOCSCtO3GLU8O/vr2jcg0An8MzKKbGHglS6cx+6Uz8Imz/lAyTPZN0qPgNRZzwSJWlAF+XzTkJWmf6SYu8r2o9dV1ftx2ikZzB41dtEMHyxpQDffPJndV3nzH3qTHo6iFVDr6/zOSvEqtQWDNhxjqnQetgQA=;
X-UUID: 8580c188ca1c4683b143bcc1bb34a3f7-20200221
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 618939546; Fri, 21 Feb 2020 18:12:13 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 21 Feb 2020 18:11:30 +0800
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
Subject: [PATCH v8 0/4] Add basic SoC support for mt6765
Date:   Fri, 21 Feb 2020 18:12:05 +0800
Message-ID: <1582279929-11535-1-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DA3DDA379D4AE327C2F9F2B41F4294B902761E1F5B0BC745B996EC5B115CB3212000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIGJhc2ljIFNvQyBzdXBwb3J0IGZvciBNZWRpYXRlaydzIG5ldyA4LWNv
cmUgU29DLA0KTVQ2NzY1LCB3aGljaCBpcyBtYWlubHkgZm9yIHNtYXJ0cGhvbmUgYXBwbGljYXRp
b24uDQoNCkNoYW5nZXMgaW4gVjg6DQoxLiBPcmlnaW4gVjcgcGF0Y2hzZXQ6DQogICBodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL2NvdmVyLzExMzcwMTA1Lw0KICAgU3BsaXQgb3JpZ2luIFY3
IHBhdGNoc2V0IGludG8gMiBwYXRjaHNldCwNCiAgIGtlZXAgcmVtYWluIHBhdGNoZXMgIzIsICM1
LCAjNiwgYW5kICM3IGluIHRoZSBzYW1lIG9yZGVyIGFzIHRoaXMNCiAgIFY4IHBhdGNoc2V0Lg0K
ICAgW3Y3LDIvN10gZHQtYmluZGluZ3M6IG1lZGlhdGVrOiBBZGQgc21pIGR0cyBiaW5kaW5nIGZv
ciBNZWRpYXRlaw0KICAgICAgICAgICAgTVQ2NzY1IFNvQw0KICAgW3Y3LDUvN10gc29jOiBtZWRp
YXRlazogYWRkIE1UNjc2NSBzY3BzeXMgYW5kIHN1YmRvbWFpbiBzdXBwb3J0DQogICBbdjcsNi83
XSBhcm02NDogZHRzOiBtZWRpYXRlazogYWRkIG10Njc2NSBzdXBwb3J0DQogICBbdjcsNy83XSBh
cm02NDogZGVmY29uZmlnOiBhZGQgQ09ORklHX0NPTU1PTl9DTEtfTVQ2NzY1X1hYWCBjbG9ja3MN
Cg0KQ2hhbmdlcyBpbiBWNzoNCjEuIEFkYXB0IFY2J3MgcGF0Y2hzZXQgdG8gbGF0ZXN0IGtlcm5l
bCB0cmVlIDUuNS1yYzEuDQogICBPcmlnaW4gVjYgcGF0Y2hzZXQ6DQogICBodHRwczovL3BhdGNo
d29yay5rZXJuZWwub3JnL2NvdmVyLzExMDQxOTYzLw0KMi4gQ29ycmVjdCAyIGNsb2NrLWNvbnRy
b2xsZXIgdHlwZSBpbiBkb2N1bWVudGF0aW9uOg0KICAgbWlwaTAgYW5kIHZlbmNfZ2Nvbi4NCiAg
IFt2NyAxLzddIGR0LWJpbmRpbmdzOiBjbG9jazogbWVkaWF0ZWs6IGRvY3VtZW50IGNsayBiaW5k
aW5ncw0KMy4gUmVtb3ZlIFY2J3MgcGF0Y2ggMDMgYmVjYXVzZSBpdCBoYXMgYmVlbiB0YWtlbiBp
bnRvIDUuNS1uZXh0LXNvYw0KICAgW3Y2LCAwMy8wOF0gZHQtYmluZGluZ3M6IG1lZGlhdGVrOiBh
ZGQgTVQ2NzY1IHBvd2VyIGR0LWJpbmRpbmdzDQozLiBVcGRhdGUgUmV2aWV3ZWQtYnk6IFJvYiBI
ZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+IGZvcg0KICAgW3Y2LCAwNC8wOF0gY2xrOiBtZWRpYXRl
azogYWRkIG10Njc2NSBjbG9jayBJRHMNCiAgIC0tPiBbdjcsIDAzLzA3XSBjbGs6IG1lZGlhdGVr
OiBhZGQgbXQ2NzY1IGNsb2NrIElEcw0KNC4gVXBkYXRlIFNQRFggdGFnIGZvcg0KICAgW3Y2LCAw
NS8wOF0gY2xrOiBtZWRpYXRlazogQWRkIE1UNjc2NSBjbG9jayBzdXBwb3J0DQogICAtLT4gW3Y3
LCAwNC8wN10gY2xrOiBtZWRpYXRlazogQWRkIE1UNjc2NSBjbG9jayBzdXBwb3J0DQoNCkNoYW5n
ZXMgaW4gVjY6DQoxLiBBZGFwdCBWNSdzIHBhdGNoc2V0IHRvIGxhdGVzdCBrZXJuZWwgdHJlZS4N
CiAgIE9yaWdpbiBWNSBwYXRjaHNldC4NCiAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNo
d29yay9jb3Zlci85NjM2MTIvDQoyLiBEdWUgdG8gY2xrJ3MgY29tbW9uIGNvZGUgaGFzIGJlZW4g
c3VibWl0IGJ5IG90aGVyIHBsYXRmb3JtLA0KICAgdGhpcyBwYXRjaCBzZXQgd2lsbCBoYXZlIGRl
cGVuZGVuY2llcyB3aXRoIHRoZSBmb2xsb3dpbmcgcGF0Y2hzZXRzDQogICBhcyB0aGUgZm9sbG93
aW5nIG9yZGVycy4NCiAgIDIuYS4gW3Y4LDAwLzIxXSBNVDgxODMgSU9NTVUgU1VQUE9SVA0KICAg
ICAgICBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL2NvdmVyLzExMDIzNTg1Lw0KICAgMi5i
LiBbdjExLDAvNl0gQWRkIGJhc2ljIG5vZGUgc3VwcG9ydCBmb3IgTWVkaWF0ZWsgTVQ4MTgzIFNv
Qw0KICAgICAgICBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL2NvdmVyLzEwOTYyMzg1Lw0K
ICAgMi5jLiBbdjYsMDAvMTRdIE1lZGlhdGVrIE1UODE4MyBzY3BzeXMgc3VwcG9ydA0KICAgICAg
ICBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL2NvdmVyLzExMDA1NzUxLw0KMy4gQ29ycmVj
dCBwb3dlciByZWxhdGVkIHBhdGNoZXMgaW50byBkdC1iaW5kaW5nIHBhdGNoZXMuDQo0LiBSZS1v
cmRlciBWNSdzIDQvMTEsIDYvMTEsIGFuZCA3LzExIGR1ZSBjbGsgY29tbW9uIGNvZGUgY2hhbmdl
DQogICBhbmQgbWFrZSBkZXBlbmRlbmNpZXMgaW4gb3JkZXIuDQo1LiBVcGRhdGUgc29tZSBjb21t
aXQgbWVzc2FnZSBpbiBjbGsgcmVsYXRlZCBwYXRjaGVzLg0KDQpDaGFuZ2VzIGluIFY1Og0KMS4g
YWRkIGNsayBzdXBwb3J0DQoNCkNoYW5nZXMgaW4gVjQ6DQoxLiBhZGQgZ2ljJ3Mgc2V0dGluZ3Mg
aW4gcmVnIHByb3BlcnRpZXMNCjIuIHJlbW92ZSBzb21lIHBhdGNoZXMgYWJvdXQgZHQtYmluZGlu
Z3Mgc2luY2UgR0tIIGFscmVhZHkgdG9vayB0aGVtDQoNCkNoYW5nZXMgaW4gVjM6DQoxLiBzcGxp
dCBkdC1iaW5kaW5nIGRvY3VtZW50IHBhdGNocw0KMi4gZml4IG10Njc2NS5kdHNpIHdhcm5pbmdz
IHdpdGggVz0xMg0KMy4gcmVtb3ZlIHVuY2Vzc2FyeSBQUEkgYWZmaW5pdHkgZm9yIHRpbWVyDQo0
LiBhZGQgZ2ljYyBiYXNlIGZvciBnaWMgZHQgbm9kZQ0KDQpDaGFuZ2VzIGluIFYyOg0KMS4gZml4
IGNsayBwcm9wZXJ0aWVzIGluIHVhcnQgZHRzIG5vZGUNCjIuIGZpeCB0eXBvIGluIHN1Ym1pdCB0
aXRsZQ0KMy4gYWRkIHNpbXBsZS1idXMgaW4gbXQ2NzY1LmR0c2kNCjQuIHVzZSBjb3JyZWN0IFNQ
RFggbGljZW5zZSBmb3JtYXQNCg0KTWFycyBDaGVuZyAoMyk6DQogIGR0LWJpbmRpbmdzOiBtZWRp
YXRlazogQWRkIHNtaSBkdHMgYmluZGluZyBmb3IgTWVkaWF0ZWsgTVQ2NzY1IFNvQw0KICBzb2M6
IG1lZGlhdGVrOiBhZGQgTVQ2NzY1IHNjcHN5cyBhbmQgc3ViZG9tYWluIHN1cHBvcnQNCiAgYXJt
NjQ6IGR0czogbWVkaWF0ZWs6IGFkZCBtdDY3NjUgc3VwcG9ydA0KDQpPd2VuIENoZW4gKDEpOg0K
ICBhcm02NDogZGVmY29uZmlnOiBhZGQgQ09ORklHX0NPTU1PTl9DTEtfTVQ2NzY1X1hYWCBjbG9j
a3MNCg0KIC4uLi9tZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWNvbW1vbi50eHQgICAg
IHwgICAgMSArDQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9NYWtlZmlsZSAgICAgICAg
ICAgICAgfCAgICAxICsNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210Njc2NS1ldmIu
ZHRzICAgICAgICB8ICAgMzMgKysrDQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDY3
NjUuZHRzaSAgICAgICAgICAgfCAgMjUzICsrKysrKysrKysrKysrKysrKysrDQogYXJjaC9hcm02
NC9jb25maWdzL2RlZmNvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgfCAgICA2ICsNCiBkcml2
ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMgICAgICAgICAgICAgICAgICB8ICAxMzAgKysr
KysrKysrKw0KIDYgZmlsZXMgY2hhbmdlZCwgNDI0IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDY3NjUtZXZiLmR0cw0KIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210Njc2NS5kdHNp
DQoNCi0tIA0KMS43LjkuNQ0K

