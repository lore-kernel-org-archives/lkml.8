Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4313C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 02:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 800E120708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 02:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LZ9n0rZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgGICjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 22:39:42 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52078 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726107AbgGICjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 22:39:42 -0400
X-UUID: 8b6858da3d20484fbd2bac7dfb5c6755-20200709
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=GVIo4VsOj/fRhOA3I3T2Kp/4alllZZbEdvQH5u8PYno=;
        b=LZ9n0rZUoa2AjpgtOBhqK4Ptc+JqGmAcUUON7qfM19xQAJ7OBCYUEYn1IksCF7C+qjq9HLGGRqKIJ43s2ADt2doZuPnz9n3cxJndS+17DzCQBp6exyAuFMiKyaUfxdedaECTH0evpyd3yMwqJ5m8G0CqLlBXlT3z99WaJJTLG0U=;
X-UUID: 8b6858da3d20484fbd2bac7dfb5c6755-20200709
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1375418577; Thu, 09 Jul 2020 10:39:39 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 9 Jul 2020 10:39:36 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 9 Jul 2020 10:39:34 +0800
Message-ID: <1594262378.21095.3.camel@mtksdaap41>
Subject: Re: [PATCH v3 9/9] drm/mediatek: reduce clear event
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>
Date:   Thu, 9 Jul 2020 10:39:38 +0800
In-Reply-To: <1594136714-11650-10-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1594136714-11650-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1594136714-11650-10-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERlbm5pcywNCg0KVGhhbmtzIGZvciB0aGlzIHBhdGNoLg0KDQpJdCdzIGJldHRlciB0byBz
ZW5kIGFub3RoZXIgdHJlZSBmb3IgdGhpcyBwYXRjaC4NCkJlY2F1c2UgdGhpcyB0cmVlIGlzIG9u
bHkgZm9yIHNvYy9tZWRpYXRlay4NCg0KUGxlYXNlIGRvIG5vdCBmb3JnZXQgdG8gYWRkIHRoZSBk
ZXBlbmRlbmN5IGluZm9ybWF0aW9uLg0KDQpCaWJieQ0KDQpPbiBUdWUsIDIwMjAtMDctMDcgYXQg
MjM6NDUgKzA4MDAsIERlbm5pcyBZQyBIc2llaCB3cm90ZToNCj4gTm8gbmVlZCB0byBjbGVhciBl
dmVudCBhZ2FpbiBzaW5jZSBldmVudCBhbHdheXMgY2xlYXIgYmVmb3JlIHdhaXQuDQo+IFRoaXMg
Zml4IGRlcGVuZCBvbiBwYXRjaDoNCj4gICAic29jOiBtZWRpYXRlazogY21kcTogYWRkIGNsZWFy
IG9wdGlvbiBpbiBjbWRxX3BrdF93ZmUgYXBpIg0KPiANCj4gRml4ZXM6IDJmOTY1YmU3ZjkwMDgg
KCJkcm0vbWVkaWF0ZWs6IGFwcGx5IENNRFEgY29udHJvbCBmbG93IikNCj4gU2lnbmVkLW9mZi1i
eTogRGVubmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsuY29tPg0KDQpSZXZp
ZXdlZC1ieTogQmliYnkgSHNpZWggPGJpYmJ5LmhzaWVoQG1lZGlhdGVrLmNvbT4NCg0KPiAtLS0N
Cj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyB8ICAgIDIgKy0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyBiL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiBpbmRleCBjODRlN2ExNGQ0YTgu
LmJhNmNmOTU2YjIzOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcm1fY3J0Yy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Ny
dGMuYw0KPiBAQCAtNDkwLDcgKzQ5MCw3IEBAIHN0YXRpYyB2b2lkIG10a19kcm1fY3J0Y19od19j
b25maWcoc3RydWN0IG10a19kcm1fY3J0YyAqbXRrX2NydGMpDQo+ICAJCW1ib3hfZmx1c2gobXRr
X2NydGMtPmNtZHFfY2xpZW50LT5jaGFuLCAyMDAwKTsNCj4gIAkJY21kcV9oYW5kbGUgPSBjbWRx
X3BrdF9jcmVhdGUobXRrX2NydGMtPmNtZHFfY2xpZW50LCBQQUdFX1NJWkUpOw0KPiAgCQljbWRx
X3BrdF9jbGVhcl9ldmVudChjbWRxX2hhbmRsZSwgbXRrX2NydGMtPmNtZHFfZXZlbnQpOw0KPiAt
CQljbWRxX3BrdF93ZmUoY21kcV9oYW5kbGUsIG10a19jcnRjLT5jbWRxX2V2ZW50LCB0cnVlKTsN
Cj4gKwkJY21kcV9wa3Rfd2ZlKGNtZHFfaGFuZGxlLCBtdGtfY3J0Yy0+Y21kcV9ldmVudCwgZmFs
c2UpOw0KPiAgCQltdGtfY3J0Y19kZHBfY29uZmlnKGNydGMsIGNtZHFfaGFuZGxlKTsNCj4gIAkJ
Y21kcV9wa3RfZmluYWxpemUoY21kcV9oYW5kbGUpOw0KPiAgCQljbWRxX3BrdF9mbHVzaF9hc3lu
YyhjbWRxX2hhbmRsZSwgZGRwX2NtZHFfY2IsIGNtZHFfaGFuZGxlKTsNCg0K

