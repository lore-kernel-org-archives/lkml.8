Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BA4C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 07:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72DFE20777
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 07:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ostzrSed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgCTHdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 03:33:03 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:15951 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726821AbgCTHcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 03:32:46 -0400
X-UUID: bee15840b9bc490a8d66928e4d5ac2a1-20200320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=9ByvZaSP7wgDUAP7dbCeQuybeA2KfOGIgSwyXg+RiC4=;
        b=ostzrSedWS+EDhrLWhTxAOFGstvtlVetoNoRGil8r5vZMxvaCpuJUIg0BNotZnHmZ3qIPxPRFY/3lQWnfIWEUpC2cJraoMafxcNh7bT2GpRZoe/WB9QKA4NYCceexArP44klK9KLiuSowD1xBrompwOM4krjlZOP24JxHjvxxM4=;
X-UUID: bee15840b9bc490a8d66928e4d5ac2a1-20200320
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 387548730; Fri, 20 Mar 2020 15:32:26 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 20 Mar 2020 15:31:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 20 Mar 2020 15:29:18 +0800
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
Subject: [PATCH v13 00/11] Mediatek MT8183 scpsys support
Date:   Fri, 20 Mar 2020 15:32:09 +0800
Message-ID: <1584689540-5227-1-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBzZXJpZXMgaXMgYmFzZWQgb24gdjUuNi1yYzENCg0KY2hhbmdlIHNpbmNlIHYxMjoNCi0g
c2VwYXJhdGUgdGhlIGZpeCBvZiBjb21tYSBhdCB0aGUgZW5kIGludG8gYSBuZXcgcGF0Y2ggW1BB
VENIIDA5LzExXQ0KDQpjaGFuZ2VzIHNpbmNlIHYxMToNCi0gcmUtb3JkZXIgcGF0Y2hlcyAiUmVt
b3ZlIGluZnJhY2ZnIG1pc2MgZHJpdmVyIHN1cHBvcnQiIGFuZCAiQWRkIG11bHRpcGxlIHN0ZXAg
YnVzIHByb3RlY3Rpb24iDQotIGFkZCBjYXAgTVRLX1NDUERfU1JBTV9JU08gZm9yIGV4dHJhIHNy
YW0gY29udHJvbA0KLSBtaW5vciBjb2Rpbmcgc3l0bGUgZml4ZXMgYW5kIHJld29yZCBjb21taXQg
bWVzc2FnZXMNCg0KY2hhbmdlcyBzaW5jZSB2MTA6DQotIHNxdWFzaCBQQVRDSCAwNCBhbmQgUEFU
Q0ggMDYgaW4gdjkgaW50byBpdHMgcHJldmlvdXMgcGF0Y2gNCi0gYWRkICJpZ25vcmVfY2xyX2Fj
ayIgZm9yIG11bHRpcGxlIHN0ZXAgYnVzIHByb3RlY3Rpb24gY29udHJvbCB0byBoYXZlIGEgY2xl
YW4gZGVmaW5pdGlvbiBvZiBwb3dlciBkb21haW4gZGF0YQ0KLSBrZWVwIHRoZSBtYXNrIHJlZ2lz
dGVyIGJpdCBkZWZpbml0aW9ucyBhbmQgZG8gdGhlIHNhbWUgZm9yIE1UODE4Mw0KDQpjaGFuZ2Vz
IHNpbmNlIHY5Og0KLSBhZGQgbmV3IFBBVENIIDA0IGFuZCBQQVRDSCAwNiB0byByZXBsYWNlIGJ5
IG5ldyBtZXRob2QgZm9yIGFsbCBjb21wYXRpYmxlcw0KLSBhZGQgbmV3IFBBVENIIDA3IHRvIHJl
bW92ZSBpbmZyYWNmZyBtaXNjIGRyaXZlcg0KLSBtaW5vciBjb2Rpbmcgc3l0bGUgZml4DQoNCmNo
YW5nZXMgc2luY2Ugdjc6DQotIHJld29yZCBpbiBiaW5kaW5nIGRvY3VtZW50IFtQQVRDSCAwMi8x
NF0NCi0gZml4IGVycm9yIHJldHVybiBjaGVja2luZyBidWcgaW4gc3Vic3lzIGNsb2NrIGNvbnRy
b2wgW1BBVENIIDEwLzE0XQ0KLSBhZGQgcG93ZXIgZG9tYWlucyBwcm9wZXJpdHkgdG8gbWZnY2Zn
IHBhdGNoIFtQQVRDSCAxNC8xNF0gZnJvbQ0KICBodHRwczovL3BhdGNod29yay5rZXJuZWwub3Jn
L3BhdGNoLzExMTI2MTk5Lw0KDQpjaGFuZ2VzIHNpbmNlIHY2Og0KLSByZW1vdmUgdGhlIHBhdGNo
IG9mIFNQRFggbGljZW5zZSBpZGVudGlmaWVyIGJlY2F1c2UgaXQncyBhbHJlYWR5IGZpeGVkDQoN
CmNoYW5nZXMgc2luY2UgdjU6DQotIGZpeCBkb2N1bWVudGF0aW9uIGluIFtQQVRDSCAwNC8xNF0N
Ci0gcmVtb3ZlIHVzZWxlc3MgdmFyaWFibGUgY2hlY2tpbmcgYW5kIHJldXNlIEFQSSBvZiBjbG9j
ayBjb250cm9sIGluIFtQQVRDSCAwNi8xNF0NCi0gY29kaW5nIHN0eWxlIGZpeCBvZiBidXMgcHJv
dGVjdGlvbiBjb250cm9sIGluIFtQQVRDSCAwOC8xNF0NCi0gZml4IG5hbWluZyBvZiBuZXcgYWRk
ZWQgZGF0YSBpbiBbUEFUQ0ggMDkvMTRdDQotIHNtYWxsIHJlZmFjdG9yIG9mIG11bHRpcGxlIHN0
ZXAgYnVzIHByb3RlY3Rpb24gY29udHJvbCBpbiBbUEFUQ0ggMTAvMTRdDQoNCmNoYW5nZXMgc2lu
Y2UgdjQ6DQotIGFkZCBwcm9wZXJ0eSB0byBtdDgxODMgc21pLWNvbW1vbg0KLSBzZXBlcmF0ZSBy
ZWZhY3RvciBwYXRjaGVzIGFuZCBuZXcgYWRkIGZ1bmN0aW9uDQotIGFkZCBwb3dlciBjb250cm9s
bGVyIGRldmljZSBub2RlDQoNCg0KV2VpeWkgTHUgKDExKToNCiAgZHQtYmluZGluZ3M6IG1lZGlh
dGVrOiBBZGQgcHJvcGVydHkgdG8gbXQ4MTgzIHNtaS1jb21tb24NCiAgZHQtYmluZGluZ3M6IHNv
YzogQWRkIE1UODE4MyBwb3dlciBkdC1iaW5kaW5ncw0KICBzb2M6IG1lZGlhdGVrOiBBZGQgYmFz
aWNfY2xrX25hbWUgdG8gc2NwX3Bvd2VyX2RhdGENCiAgc29jOiBtZWRpYXRlazogUmVtb3ZlIGlu
ZnJhY2ZnIG1pc2MgZHJpdmVyIHN1cHBvcnQNCiAgc29jOiBtZWRpYXRlazogQWRkIG11bHRpcGxl
IHN0ZXAgYnVzIHByb3RlY3Rpb24gY29udHJvbA0KICBzb2M6IG1lZGlhdGVrOiBBZGQgc3Vic3lz
IGNsb2NrIGNvbnRyb2wgZm9yIGJ1cyBwcm90ZWN0aW9uDQogIHNvYzogbWVkaWF0ZWs6IEFkZCBl
eHRyYSBzcmFtIGNvbnRyb2wNCiAgc29jOiBtZWRpYXRlazogQWRkIE1UODE4MyBzY3BzeXMgc3Vw
cG9ydA0KICBzb2M6IG1lZGlhdGVrOiBBZGQgYSBjb21tYSBhdCB0aGUgZW5kDQogIGFybTY0OiBk
dHM6IEFkZCBwb3dlciBjb250cm9sbGVyIGRldmljZSBub2RlIG9mIE1UODE4Mw0KICBhcm02NDog
ZHRzOiBBZGQgcG93ZXItZG9tYWlucyBwcm9wZXJ0eSB0byBtZmdjZmcNCg0KIC4uLi9tZWRpYXRl
ayxzbWktY29tbW9uLnR4dCAgICAgICAgICAgICAgICAgICB8ICAgMiArLQ0KIC4uLi9iaW5kaW5n
cy9zb2MvbWVkaWF0ZWsvc2Nwc3lzLnR4dCAgICAgICAgICB8ICAyMCArLQ0KIGFyY2gvYXJtNjQv
Ym9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kgICAgICB8ICA2MyArKw0KIGRyaXZlcnMvc29j
L21lZGlhdGVrL0tjb25maWcgICAgICAgICAgICAgICAgICB8ICAxMCAtDQogZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvTWFrZWZpbGUgICAgICAgICAgICAgICAgIHwgICAxIC0NCiBkcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstaW5mcmFjZmcuYyAgICAgICAgICAgfCAgNzkgLS0tDQogZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXRrLXNjcHN5cy5jICAgICAgICAgICAgIHwgNjU0ICsrKysrKysrKysrKysrLS0t
LQ0KIGRyaXZlcnMvc29jL21lZGlhdGVrL3NjcHN5cy5oICAgICAgICAgICAgICAgICB8ICA5MCAr
KysNCiBpbmNsdWRlL2R0LWJpbmRpbmdzL3Bvd2VyL210ODE4My1wb3dlci5oICAgICAgfCAgMjYg
Kw0KIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL2luZnJhY2ZnLmggICAgICAgICB8ICAzOSAt
LQ0KIDEwIGZpbGVzIGNoYW5nZWQsIDcwNyBpbnNlcnRpb25zKCspLCAyNzcgZGVsZXRpb25zKC0p
DQogZGVsZXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1pbmZyYWNmZy5j
DQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc29jL21lZGlhdGVrL3NjcHN5cy5oDQogY3Jl
YXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvZHQtYmluZGluZ3MvcG93ZXIvbXQ4MTgzLXBvd2VyLmgN
CiBkZWxldGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvaW5mcmFjZmcu
aA0K

