Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2A6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B48020760
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZjT78N6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgGCEmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 00:42:47 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:18438 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725764AbgGCEmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 00:42:46 -0400
X-UUID: 45ba3959e2f342d1a181344edd2741a5-20200703
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=fOIE/14eP5QaMvpr+A/0WJuqIjmfhZZCLzsc96MbxFk=;
        b=ZjT78N6ixAU4ZbgDzhdJuF4w9u3mwOYxJboOCzv1EGJeF3ZqEJz1L0tiCU4EQ6cZyb0qt0KO7j2WJ+Nj6VxDZVEEioyHv2MAhT/Jiy7d5YZ9V8LwJIm1K+TTRctdi7tljk8yNmeYtD86fDc8r3uYwt0LEaeEOAxs0pIG4uwOQaI=;
X-UUID: 45ba3959e2f342d1a181344edd2741a5-20200703
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1942315213; Fri, 03 Jul 2020 12:42:42 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Jul 2020 12:42:37 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 3 Jul 2020 12:42:33 +0800
From:   Chao Hao <chao.hao@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>,
        FY Yang <fy.yang@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
        TH Yang <th.yang@mediatek.com>
Subject: [PATCH v6 00/10] MT6779 IOMMU SUPPORT
Date:   Fri, 3 Jul 2020 12:41:17 +0800
Message-ID: <20200703044127.27438-1-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E4EE501486CFE45934E76861F54A424896840F7B4C9AC2ECB55F96F8AE402C6E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaHNldCBhZGRzIG10Njc3OSBpb21tdSBzdXBwb3J0Lg0KbXQ2Nzc5IGhhcyB0d28g
aW9tbXVzLCB0aGV5IGFyZSBNTV9JT01NVShNNFUpIGFuZCBBUFVfSU9NTVUgd2hpY2ggdXNlZCBB
Uk0gU2hvcnQtRGVzY3JpcHRvciB0cmFuc2xhdGlvbiBmb3JtYXQuDQpUaGUgbXQ2Nzc5J3MgTU1f
SU9NTVUtU01JIGFuZCBBUFVfSU9NTVUgSFcgZGlhZ3JhbSBpcyBhcyBiZWxvdywgaXQgaXMgb25s
eSBhIGJyaWVmIGRpYWdyYW06DQogICAgICAgICAgICAgICAgICAgICAgIEVNSQ0KCQkgICAgICAg
IHwNCiAgICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAgICAgfCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCiAgTU1fSU9NTVUgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgQVBVX0lPTU1VDQogICAgIHwgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8DQogU01JX0NPTU1PTS0tLS0tLS0tLS0tICAgICAgICAgICAgICAgICBB
UFVfQlVTDQogICAgIHwgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICB8DQogIFNN
SV9MQVJCKDB+MTEpICAgICAgfCAgICAgICAgICAgICAgICAgICB8DQogICAgIHwgICAgICAgICAg
ICAgICAgfCAgICAgICAgICAgICAgICAgICB8DQogICAgIHwgICAgICAgICAgICAgICAgfCAgICAg
ICAgICAgICAtLS0tLS0tLS0tLS0tLQ0KICAgICB8ICAgICAgICAgICAgICAgIHwgICAgICAgICAg
ICAgfCAgICAgfCAgICAgIHwNCk11bHRpbWVkaWEgZW5naW5lICAgIENDVSAgICAgICAgICAgVlBV
ICAgTURMQSAgIEVNREENCg0KQWxsIHRoZSBjb25uZWN0aW9ucyBhcmUgaGFyZHdhcmUgZml4ZWQs
IHNvZnR3YXJlIGNhbiBub3QgYWRqdXN0IGl0Lg0KQ29tcGFyZWQgd2l0aCBtdDgxODMsIFNNSV9C
VVNfSUQgd2lkdGggaGFzIGNoYW5nZWQgZnJvbSAxMCB0byAxMi4gU01JIExhcmIgbnVtYmVyIGlz
IGRlc2NyaWJlZCBpbiBiaXRbMTE6N10sDQpQb3J0IG51bWJlciBpcyBkZXNjcmliZWQgaW4gYml0
WzY6Ml0uIEluIGFkZGl0aW9uLCB0aGVyZSBhcmUgc29tZSByZWdpc3RlcnMgaGFzIGNoYW5nZWQg
aW4gbXQ2Nzc5LCBzbyB3ZSBuZWVkDQp0byByZWRlZmluZSBhbmQgcmV1c2UgdGhlbS4NCg0KVGhl
IHBhdGNoc2V0IG9ubHkgdXNlZCBNTV9JT01NVSwgc28gd2Ugb25seSBhZGQgTU1fSU9NTVUgYmFz
aWMgZnVuY3Rpb24sIHN1Y2ggYXMgc21pX2xhcmIgcG9ydCBkZWZpbml0aW9uLCByZWdpc3RlcnMN
CmRlZmluaXRpb24gYW5kIGhhcmR3YXJlIGluaXRpYWxpemF0aW9uLg0KY2hhbmdlIG5vdGVzOg0K
DQogdjY6DQogIDEuIEZpeCBidWlsZCBlcnJvciBmb3IgIlBBVENIIHY1IDAyLzEwIi4NCiAgMi4g
VXNlIG1vcmUgcHJlY2lzZSBkZWZpbml0aW9ucyBhbmQgY29tbWl0IG1lc3NhZ2VzLg0KDQogdjU6
DQogIDEuIFNwbGl0ICJpb21tdS9tZWRpYXRlazogQWRkIG10Njc3OSBJT01NVSBiYXNpYyBzdXBw
b3J0KHBhdGNoIHY0KSIgdG8gdGhyZWUgcGF0Y2hlcyhmcm9tIFBBVENIIHY1IDA4LzEwIHRvIFBB
VENIIHY1IDEwLzEwKS4NCiAgMi4gVXNlIG1hY3JvIGRlZmluaXRpb25zIHRvIHJlcGxhY2UgYm9v
bCB2YWx1ZXMgaW4gbXRrX2lvbW11X3BsYXRfZGF0YSBzdHJ1Y3R1cmUNCiBodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGludXgtbWVkaWF0ZWsvMjAyMC1KdW5lLzAxMzU4Ni5o
dG1sDQoNCiB2NDoNCiAgMS4gUmViYXNlIG9uIHY1LjgtcmMxLg0KICAyLiBGaXggY29kaW5nIHN0
eWxlLg0KICAzLiBBZGQgRl9NTVVfSU5fRFJERVJfV1JfRU4gZGVmaW5pdGlvbiBpbiBNSVNDX0NU
UkwgdG8gaW1wcm92ZSBwZXJmb3JtYW5jZS4NCiBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMC82
LzE2LzE3NDENCg0KIHYzOg0KICAxLiBSZWJhc2Ugb24gdjUuNy1yYzEuDQogIDIuIFJlbW92ZSB1
bnVzZWQgcG9ydCBkZWZpbml0aW9uLGV4OkFQVSBhbmQgQ0NVIHBvcnQgaW4gbXQ2Nzc5LWxhcmIt
cG9ydC5oLg0KICAzLiBSZW1vdmUgImNoYW5nZSBzaW5nbGUgZG9tYWluIHRvIG11bHRpcGxlIGRv
bWFpbiIgcGFydChmcm9tIFBBVENIIHYyIDA5LzE5IHRvIFBBVENIIHYyIDE5LzE5KS4NCiAgNC4g
UmVkZXNpZ24gbXQ2Nzc5IGJhc2ljIHBhcnQNCiAgICAoMSlBZGQgc29tZSByZWdpc3RlciBkZWZp
bml0aW9uIGFuZCByZXVzZSB0aGVtLg0KICAgICgyKVJlZGVzaWduIHNtaSBsYXJiIGJ1cyBJRCB0
byBhbmFseXplIElPTU1VIHRyYW5zbGF0aW9uIGZhdWx0Lg0KICAgICgzKU9ubHkgaW5pdCBNTV9J
T01NVSBhbmQgbm90IHVzZSBBUFVfSU9NTVUuDQogaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
cGlwZXJtYWlsL2xpbnV4LW1lZGlhdGVrLzIwMjAtTWF5LzAyOTgxMS5odG1sDQoNCiB2MjoNCiAg
MS4gUmViYXNlIG9uIHY1LjUtcmMxLg0KICAyLiBEZWxldGUgTTRVX1BPUlRfVU5LTk9XTiBkZWZp
bmUgYmVjYXVzZSBvZiBub3QgdXNlIGl0Lg0KICAzLiBDb3JyZWN0IGNvZGluZyBmb3JtYXQuDQog
IDQuIFJlbmFtZSBvZmZzZXQ9MHg0OCByZWdpc3Rlci4NCiAgNS4gU3BsaXQgImlvbW11L21lZGlh
dGVrOiBBZGQgbXQ2Nzc5IElPTU1VIGJhc2ljIHN1cHBvcnQocGF0Y2ggdjEpIiB0byBzZXZlcmFs
IHBhdGNoZXMocGF0Y2ggdjIpLg0KIGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL3BpcGVybWFp
bC9saW51eC1tZWRpYXRlay8yMDIwLUphbnVhcnkvMDI2MTMxLmh0bWwNCg0KIHYxOg0KIGh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL3BpcGVybWFpbC9saW51eC1tZWRpYXRlay8yMDE5LU5vdmVt
YmVyLzAyNDU2Ny5odG1sDQoNCkNoYW8gSGFvICgxMCk6DQogIGR0LWJpbmRpbmdzOiBtZWRpYXRl
azogQWRkIGJpbmRpbmdzIGZvciBNVDY3NzkNCiAgaW9tbXUvbWVkaWF0ZWs6IFJlbmFtZSB0aGUg
cmVnaXN0ZXIgU1RBTkRBUkRfQVhJX01PREUoMHg0OCkgdG8gTUlTQ19DVFJMDQogIGlvbW11L21l
ZGlhdGVrOiBVc2UgYSB1MzIgZmxhZ3MgdG8gZGVzY3JpYmUgZGlmZmVyZW50IEhXIGZlYXR1cmVz
DQogIGlvbW11L21lZGlhdGVrOiBTZXR0aW5nIE1JU0NfQ1RSTCByZWdpc3Rlcg0KICBpb21tdS9t
ZWRpYXRlazogTW92ZSBpbnZfc2VsX3JlZyBpbnRvIHRoZSBwbGF0X2RhdGENCiAgaW9tbXUvbWVk
aWF0ZWs6IEFkZCBzdWJfY29tbSBpZCBpbiB0cmFuc2xhdGlvbiBmYXVsdA0KICBpb21tdS9tZWRp
YXRlazogQWRkIFJFR19NTVVfV1JfTEVOX0NUUkwgcmVnaXN0ZXIgZGVmaW5pdGlvbg0KICBpb21t
dS9tZWRpYXRlazogRXh0ZW5kIHByb3RlY3QgcGEgYWxpZ25tZW50IHZhbHVlDQogIGlvbW11L21l
ZGlhdGVrOiBNb2RpZnkgTU1VX0NUUkwgcmVnaXN0ZXIgc2V0dGluZw0KICBpb21tdS9tZWRpYXRl
azogQWRkIG10Njc3OSBiYXNpYyBzdXBwb3J0DQoNCiAuLi4vYmluZGluZ3MvaW9tbXUvbWVkaWF0
ZWssaW9tbXUudHh0ICAgICAgICAgfCAgIDIgKw0KIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMg
ICAgICAgICAgICAgICAgICAgICB8IDExMCArKysrKysrLS0tDQogZHJpdmVycy9pb21tdS9tdGtf
aW9tbXUuaCAgICAgICAgICAgICAgICAgICAgIHwgIDIwICstDQogaW5jbHVkZS9kdC1iaW5kaW5n
cy9tZW1vcnkvbXQ2Nzc5LWxhcmItcG9ydC5oIHwgMjA2ICsrKysrKysrKysrKysrKysrKw0KIDQg
ZmlsZXMgY2hhbmdlZCwgMjk5IGluc2VydGlvbnMoKyksIDM5IGRlbGV0aW9ucygtKQ0KDQotLQ0K
Mi4xOC4wDQoNCg==

