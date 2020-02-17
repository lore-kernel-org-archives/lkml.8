Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FF3C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D772072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 03:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GL06Y6kd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgBQDgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 22:36:10 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:21995 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726498AbgBQDfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 22:35:38 -0500
X-UUID: 1c32d7a49e83477284ef5fb075c91cae-20200217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=d38kig+Zusa5V6aoIvUBBHX1aAbt63Db2pgRYqg7t0k=;
        b=GL06Y6kd8pL1HQSDEPE1OZWJymXU5+r0Dce5ILiEuU2l46sP3mb/Egh9RI2oWcGis1rkE1o8OgOlfrOaVn6+ftfzOQizwmM0cIYxPK5Vo3NF2sOQp88PiDFmEppH/jPrjDP7rKo6E/ufFXLioZBGP64CY80+KnfyM64ymiuH8WY=;
X-UUID: 1c32d7a49e83477284ef5fb075c91cae-20200217
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1028839163; Mon, 17 Feb 2020 11:35:31 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 17 Feb 2020 11:33:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Feb 2020 11:35:07 +0800
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
Subject: [PATCH v12 00/10] Mediatek MT8183 scpsys support
Date:   Mon, 17 Feb 2020 11:35:17 +0800
Message-ID: <1581910527-1636-1-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 785D55F3EA22E4D6C03FE494E98FA6AC1A19E1A6762D691285BCAD124FF076B82000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBzZXJpZXMgaXMgYmFzZWQgb24gdjUuNS1yYzENCg0KY2hhbmdlcyBzaW5jZSB2MTE6DQot
IHJlLW9yZGVyIHBhdGNoZXMgIlJlbW92ZSBpbmZyYWNmZyBtaXNjIGRyaXZlciBzdXBwb3J0IiBh
bmQgIkFkZCBtdWx0aXBsZSBzdGVwIGJ1cyBwcm90ZWN0aW9uIg0KLSBhZGQgY2FwIE1US19TQ1BE
X1NSQU1fSVNPIGZvciBleHRyYSBzcmFtIGNvbnRyb2wNCi0gbWlub3IgY29kaW5nIHN5dGxlIGZp
eGVzIGFuZCByZXdvcmQgY29tbWl0IG1lc3NhZ2VzDQoNCmNoYW5nZXMgc2luY2UgdjEwOg0KLSBz
cXVhc2ggUEFUQ0ggMDQgYW5kIFBBVENIIDA2IGluIHY5IGludG8gaXRzIHByZXZpb3VzIHBhdGNo
DQotIGFkZCAiaWdub3JlX2Nscl9hY2siIGZvciBtdWx0aXBsZSBzdGVwIGJ1cyBwcm90ZWN0aW9u
IGNvbnRyb2wgdG8gaGF2ZSBhIGNsZWFuIGRlZmluaXRpb24gb2YgcG93ZXIgZG9tYWluIGRhdGEN
Ci0ga2VlcCB0aGUgbWFzayByZWdpc3RlciBiaXQgZGVmaW5pdGlvbnMgYW5kIGRvIHRoZSBzYW1l
IGZvciBNVDgxODMNCg0KY2hhbmdlcyBzaW5jZSB2OToNCi0gYWRkIG5ldyBQQVRDSCAwNCBhbmQg
UEFUQ0ggMDYgdG8gcmVwbGFjZSBieSBuZXcgbWV0aG9kIGZvciBhbGwgY29tcGF0aWJsZXMNCi0g
YWRkIG5ldyBQQVRDSCAwNyB0byByZW1vdmUgaW5mcmFjZmcgbWlzYyBkcml2ZXINCi0gbWlub3Ig
Y29kaW5nIHN5dGxlIGZpeA0KDQpjaGFuZ2VzIHNpbmNlIHY3Og0KLSByZXdvcmQgaW4gYmluZGlu
ZyBkb2N1bWVudCBbUEFUQ0ggMDIvMTRdDQotIGZpeCBlcnJvciByZXR1cm4gY2hlY2tpbmcgYnVn
IGluIHN1YnN5cyBjbG9jayBjb250cm9sIFtQQVRDSCAxMC8xNF0NCi0gYWRkIHBvd2VyIGRvbWFp
bnMgcHJvcGVyaXR5IHRvIG1mZ2NmZyBwYXRjaCBbUEFUQ0ggMTQvMTRdIGZyb20NCiAgaHR0cHM6
Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMTEyNjE5OS8NCg0KY2hhbmdlcyBzaW5jZSB2
NjoNCi0gcmVtb3ZlIHRoZSBwYXRjaCBvZiBTUERYIGxpY2Vuc2UgaWRlbnRpZmllciBiZWNhdXNl
IGl0J3MgYWxyZWFkeSBmaXhlZA0KDQpjaGFuZ2VzIHNpbmNlIHY1Og0KLSBmaXggZG9jdW1lbnRh
dGlvbiBpbiBbUEFUQ0ggMDQvMTRdDQotIHJlbW92ZSB1c2VsZXNzIHZhcmlhYmxlIGNoZWNraW5n
IGFuZCByZXVzZSBBUEkgb2YgY2xvY2sgY29udHJvbCBpbiBbUEFUQ0ggMDYvMTRdDQotIGNvZGlu
ZyBzdHlsZSBmaXggb2YgYnVzIHByb3RlY3Rpb24gY29udHJvbCBpbiBbUEFUQ0ggMDgvMTRdDQot
IGZpeCBuYW1pbmcgb2YgbmV3IGFkZGVkIGRhdGEgaW4gW1BBVENIIDA5LzE0XQ0KLSBzbWFsbCBy
ZWZhY3RvciBvZiBtdWx0aXBsZSBzdGVwIGJ1cyBwcm90ZWN0aW9uIGNvbnRyb2wgaW4gW1BBVENI
IDEwLzE0XQ0KDQpjaGFuZ2VzIHNpbmNlIHY0Og0KLSBhZGQgcHJvcGVydHkgdG8gbXQ4MTgzIHNt
aS1jb21tb24NCi0gc2VwZXJhdGUgcmVmYWN0b3IgcGF0Y2hlcyBhbmQgbmV3IGFkZCBmdW5jdGlv
bg0KLSBhZGQgcG93ZXIgY29udHJvbGxlciBkZXZpY2Ugbm9kZQ0KDQoNCldlaXlpIEx1ICgxMCk6
DQogIGR0LWJpbmRpbmdzOiBtZWRpYXRlazogQWRkIHByb3BlcnR5IHRvIG10ODE4MyBzbWktY29t
bW9uDQogIGR0LWJpbmRpbmdzOiBzb2M6IEFkZCBNVDgxODMgcG93ZXIgZHQtYmluZGluZ3MNCiAg
c29jOiBtZWRpYXRlazogQWRkIGJhc2ljX2Nsa19uYW1lIHRvIHNjcF9wb3dlcl9kYXRhDQogIHNv
YzogbWVkaWF0ZWs6IFJlbW92ZSBpbmZyYWNmZyBtaXNjIGRyaXZlciBzdXBwb3J0DQogIHNvYzog
bWVkaWF0ZWs6IEFkZCBtdWx0aXBsZSBzdGVwIGJ1cyBwcm90ZWN0aW9uIGNvbnRyb2wNCiAgc29j
OiBtZWRpYXRlazogQWRkIHN1YnN5cyBjbG9jayBjb250cm9sIGZvciBidXMgcHJvdGVjdGlvbg0K
ICBzb2M6IG1lZGlhdGVrOiBBZGQgZXh0cmEgc3JhbSBjb250cm9sDQogIHNvYzogbWVkaWF0ZWs6
IEFkZCBNVDgxODMgc2Nwc3lzIHN1cHBvcnQNCiAgYXJtNjQ6IGR0czogQWRkIHBvd2VyIGNvbnRy
b2xsZXIgZGV2aWNlIG5vZGUgb2YgTVQ4MTgzDQogIGFybTY0OiBkdHM6IEFkZCBwb3dlci1kb21h
aW5zIHByb3BlcnR5IHRvIG1mZ2NmZw0KDQogLi4uL21lZGlhdGVrLHNtaS1jb21tb24udHh0ICAg
ICAgICAgICAgICAgICAgIHwgICAyICstDQogLi4uL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9zY3Bz
eXMudHh0ICAgICAgICAgIHwgIDIwICstDQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9t
dDgxODMuZHRzaSAgICAgIHwgIDYzICsrDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvS2NvbmZpZyAg
ICAgICAgICAgICAgICAgIHwgIDEwIC0NCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9NYWtlZmlsZSAg
ICAgICAgICAgICAgICAgfCAgIDEgLQ0KIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1pbmZyYWNm
Zy5jICAgICAgICAgICB8ICA3OSAtLS0NCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lz
LmMgICAgICAgICAgICAgfCA2NTQgKysrKysrKysrKysrKystLS0tDQogZHJpdmVycy9zb2MvbWVk
aWF0ZWsvc2Nwc3lzLmggICAgICAgICAgICAgICAgIHwgIDkwICsrKw0KIGluY2x1ZGUvZHQtYmlu
ZGluZ3MvcG93ZXIvbXQ4MTgzLXBvd2VyLmggICAgICB8ICAyNiArDQogaW5jbHVkZS9saW51eC9z
b2MvbWVkaWF0ZWsvaW5mcmFjZmcuaCAgICAgICAgIHwgIDM5IC0tDQogMTAgZmlsZXMgY2hhbmdl
ZCwgNzA3IGluc2VydGlvbnMoKyksIDI3NyBkZWxldGlvbnMoLSkNCiBkZWxldGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWluZnJhY2ZnLmMNCiBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9zb2MvbWVkaWF0ZWsvc2Nwc3lzLmgNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5j
bHVkZS9kdC1iaW5kaW5ncy9wb3dlci9tdDgxODMtcG93ZXIuaA0KIGRlbGV0ZSBtb2RlIDEwMDY0
NCBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9pbmZyYWNmZy5oDQo=

