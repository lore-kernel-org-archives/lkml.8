Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D46C2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCEC820722
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SqSLOyHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgCZO7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:59:02 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:4922 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727821AbgCZO7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:59:02 -0400
X-UUID: 3b0233988805467bb0e81fa145363b3d-20200326
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Wz22YepjvknPTT9ZKt5FiQJcqf5sA/7i5zIs+ibGrZ4=;
        b=SqSLOyHXrBpAitkBidGCJ+3b5YisFxhwgjBJdS8wNh0FkMflt3HKNZm8WQoYzI4/2sWCaj/ykWw3b9s8L2bqzC5aJ6HtbONsOdinWnxIOYeFN3FZWHg7c2Axf5XXzD/3bQPei6i8ua9kWNkr/t5bGVWIDnvEwX5Q8zfBa1hmE6Q=;
X-UUID: 3b0233988805467bb0e81fa145363b3d-20200326
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1827274245; Thu, 26 Mar 2020 22:57:25 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 26 Mar 2020 22:57:23 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 26 Mar 2020 22:57:20 +0800
Message-ID: <1585234641.12089.7.camel@mtksdaap41>
Subject: Re: [RESEND PATCH v6 00/17] add drm support for MT8183
From:   CK Hu <ck.hu@mediatek.com>
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 26 Mar 2020 22:57:21 +0800
In-Reply-To: <1578021148-32413-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1578021148-32413-1-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 0F6801C5DB930AB9FF671AA0D74D3E125BF3CAC024BE411DDBC607B4DE40F1C22000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KSW4gWzFdLCBNYXR0aGlhcyBoYXMgYXBwbGllZCBiZWxvdyBzZXJp
ZXMgdG8gZml4IG1tc3lzIGRyaXZlciBwcm9iZQ0KcHJvYmxlbS4gUGxlYXNlIGJhc2Ugb24gdGhh
dCBzZXJpZXMgdG8gcmVzZW5kIHlvdXIgcGF0Y2hlcy4NCg0Kc29jIC8gZHJtOiBtZWRpYXRlazog
Rml4IG1lZGlhdGVrLWRybSBkZXZpY2UgcHJvYmluZwlzb2MgLyBkcm06DQptZWRpYXRlazogTW92
ZSByb3V0aW5nIGNvbnRyb2wgdG8gbW1zeXMgZGV2aWNlCWNsayAvIHNvYzogbWVkaWF0ZWs6IE1v
dmUNCm10ODE3MyBNTVNZUyB0byBwbGF0Zm9ybSBkcml2ZXIJZHQtYmluZGluZ3M6IG1lZGlhdGVr
OiBVcGRhdGUgbW1zeXMNCmJpbmRpbmcgdG8gcmVmbGVjdCBpdCBpcyBhIHN5c3RlbSBjb250cm9s
bGVyCWRybS9tZWRpYXRlazogT21pdCB3YXJuaW5nDQpvbiBwcm9iZSBkZWZlcnMNCg0KWzFdDQpo
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9tYXR0aGlhcy5i
Z2cvbGludXguZ2l0L2xvZy8/aD1mb3ItbmV4dA0KDQpSZWdhcmRzLA0KQ0sNCg0KT24gRnJpLCAy
MDIwLTAxLTAzIGF0IDExOjEyICswODAwLCBZb25ncWlhbmcgTml1IHdyb3RlOg0KPiBUaGlzIHNl
cmllcyBhcmUgYmFzZWQgb24gNS41LXJjMSBhbmQgcHJvdmlkIDE3IHBhdGNoDQo+IHRvIHN1cHBv
cnQgbWVkaWF0ZWsgU09DIE1UODE4Mw0KPiANCj4gQ2hhbmdlIHNpbmNlIHY1DQo+IC0gZml4IHJl
dmlld2VkIGlzc3VlIGluIHY1DQo+IGJhc2UgaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9w
cm9qZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nlcmllcz0yMTMyMTkNCj4gDQo+IENoYW5nZSBz
aW5jZSB2NA0KPiAtIGZpeCByZXZpZXdlZCBpc3N1ZSBpbiB2NA0KPiANCj4gQ2hhbmdlIHNpbmNl
IHYzDQo+IC0gZml4IHJldmlld2VkIGlzc3VlIGluIHYzDQo+IC0gZml4IHR5cGUgZXJyb3IgaW4g
djMNCj4gLSBmaXggY29uZmxpY3Qgd2l0aCBpb21tdSBwYXRjaA0KPiANCj4gQ2hhbmdlIHNpbmNl
IHYyDQo+IC0gZml4IHJldmlld2VkIGlzc3VlIGluIHYyDQo+IC0gYWRkIG11dGV4IG5vZGUgaW50
byBkdHMgZmlsZQ0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2MToNCj4gLSBmaXggcmV2aWV3ZWQgaXNz
dWUgaW4gdjENCj4gLSBhZGQgZHRzIGZvciBtdDgxODMgZGlzcGxheSBub2Rlcw0KPiAtIGFkanVz
dCBkaXNwbGF5IGNsb2NrIGNvbnRyb2wgZmxvdyBpbiBwYXRjaCAyMg0KPiAtIGFkZCB2bWFwIHN1
cHBvcnQgZm9yIG1lZGlhdGVrIGRybSBpbiBwYXRjaCAyMw0KPiAtIGZpeCBwYWdlIG9mZnNldCBp
c3N1ZSBmb3IgbW1hcCBmdW5jdGlvbiBpbiBwYXRjaCAyNA0KPiAtIGVuYWJsZSBhbGxvd19mYl9t
b2RpZmllcnMgZm9yIG1lZGlhdGVrIGRybSBpbiBwYXRjaCAyNQ0KPiANCj4gWW9uZ3FpYW5nIE5p
dSAoMTcpOg0KPiAgIGR0LWJpbmRpbmdzOiBtZWRpYXRlazogYWRkIHJkbWFfZmlmb19zaXplIGRl
c2NyaXB0aW9uIGZvciBtdDgxODMNCj4gICAgIGRpc3BsYXkNCj4gICBhcm02NDogZHRzOiBhZGQg
ZGlzcGxheSBub2RlcyBmb3IgbXQ4MTgzDQo+ICAgZHJtL21lZGlhdGVrOiBtb3ZlIGRzaS9kcGkg
c2VsZWN0IGlucHV0IGludG8gbXRrX2RkcF9zZWxfaW4NCj4gICBkcm0vbWVkaWF0ZWs6IG1ha2Ug
c291dCBzZWxlY3QgZnVuY3Rpb24gZm9ybWF0IHNhbWUgd2l0aCBzZWxlY3QgaW5wdXQNCj4gICBk
cm0vbWVkaWF0ZWs6IGFkZCBtbXN5cyBwcml2YXRlIGRhdGEgZm9yIGRkcCBwYXRoIGNvbmZpZw0K
PiAgIGRybS9tZWRpYXRlazogYWRkIHByaXZhdGUgZGF0YSBmb3IgcmRtYTEgdG8gZHBpMCBjb25u
ZWN0aW9uDQo+ICAgZHJtL21lZGlhdGVrOiBhZGQgcHJpdmF0ZSBkYXRhIGZvciByZG1hMSB0byBk
c2kwIGNvbm5lY3Rpb24NCj4gICBkcm0vbWVkaWF0ZWs6IG1vdmUgcmRtYSBzb3V0IGZyb20gbXRr
X2RkcF9tb3V0X2VuIGludG8NCj4gICAgIG10a19kZHBfc291dF9zZWwNCj4gICBkcm0vbWVkaWF0
ZWs6IGFkZCBjb25uZWN0aW9uIGZyb20gT1ZMMCB0byBPVkxfMkwwDQo+ICAgZHJtL21lZGlhdGVr
OiBhZGQgY29ubmVjdGlvbiBmcm9tIFJETUEwIHRvIENPTE9SMA0KPiAgIGRybS9tZWRpYXRlazog
YWRkIGNvbm5lY3Rpb24gZnJvbSBSRE1BMSB0byBEU0kwDQo+ICAgZHJtL21lZGlhdGVrOiBhZGQg
Y29ubmVjdGlvbiBmcm9tIE9WTF8yTDAgdG8gUkRNQTANCj4gICBkcm0vbWVkaWF0ZWs6IGFkZCBj
b25uZWN0aW9uIGZyb20gT1ZMXzJMMSB0byBSRE1BMQ0KPiAgIGRybS9tZWRpYXRlazogYWRkIGNv
bm5lY3Rpb24gZnJvbSBESVRIRVIwIHRvIERTSTANCj4gICBkcm0vbWVkaWF0ZWs6IGFkZCBjb25u
ZWN0aW9uIGZyb20gUkRNQTAgdG8gRFNJMA0KPiAgIGRybS9tZWRpYXRlazogYWRkIGZpZm9fc2l6
ZSBpbnRvIHJkbWEgcHJpdmF0ZSBkYXRhDQo+ICAgZHJtL21lZGlhdGVrOiBhZGQgc3VwcG9ydCBm
b3IgbWVkaWF0ZWsgU09DIE1UODE4Mw0KPiANCj4gIC4uLi9iaW5kaW5ncy9kaXNwbGF5L21lZGlh
dGVrL21lZGlhdGVrLGRpc3AudHh0ICAgIHwgIDEzICsNCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMv
bWVkaWF0ZWsvbXQ4MTgzLmR0c2kgICAgICAgICAgIHwgIDk4ICsrKysrKysNCj4gIGRyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYyAgICAgICAgICAgIHwgIDE4ICsrDQo+ICBk
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jICAgICAgICAgICB8ICAyNSAr
LQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jICAgICAgICAgICAg
fCAgIDQgKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwLmMgICAgICAg
ICAgICAgfCAyODggKysrKysrKysrKysrKysrKy0tLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RybV9kZHAuaCAgICAgICAgICAgICB8ICAgNyArDQo+ICBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYyAgICAgICAgICAgICB8ICA0OSArKysrDQo+ICBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuaCAgICAgICAgICAgICB8ICAgMyArDQo+
ICA5IGZpbGVzIGNoYW5nZWQsIDQzNSBpbnNlcnRpb25zKCspLCA3MCBkZWxldGlvbnMoLSkNCj4g
DQoNCg==

