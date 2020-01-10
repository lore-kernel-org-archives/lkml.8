Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BE1C33C99
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244D720673
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="C1L+sKks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731460AbgAJGT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 01:19:58 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:11573 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725797AbgAJGT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 01:19:58 -0500
X-UUID: 8ca12080878f42b4a5f4715cd583c413-20200110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=2hX33a9oKQvAaZtJ3NQ0cW54cICk0Docx++JIfjlN54=;
        b=C1L+sKksrUCaSk1L4aeeOVIVRwEj1HUrt9aleg63TRWpo7VBpUS81ERuh3PNSUunD9Xu1wprIqEyvlTGUgv9u46+P+pc5ZtS6J/CrC9/cU+QCMQc5rn+h0O25Y2pUfHBO53nYFXa68rXi9isephJKUdMzm32vi13QPLKNVRvKQI=;
X-UUID: 8ca12080878f42b4a5f4715cd583c413-20200110
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 294544061; Fri, 10 Jan 2020 14:19:53 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 10 Jan 2020 14:18:47 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 10 Jan 2020 14:20:24 +0800
Message-ID: <1578637185.29400.3.camel@mtksdaap41>
Subject: Re: [PATCH] drm/mediatek: check for comp->funcs
From:   CK Hu <ck.hu@mediatek.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Fri, 10 Jan 2020 14:19:45 +0800
In-Reply-To: <20200109072900.17988-1-hsinyi@chromium.org>
References: <20200109072900.17988-1-hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaW4teWk6DQoNCk9uIFRodSwgMjAyMC0wMS0wOSBhdCAxNToyOSArMDgwMCwgSHNpbi1Z
aSBXYW5nIHdyb3RlOg0KPiBUaGVyZSBtaWdodCBiZSBzb21lIGNvbXAgdGhhdCBkb2Vzbid0IGhh
dmUgZnVuY3MsIGVnLiBoZG1pLWNvbm5lY3Rvci4NCj4gQ2hlY2sgZm9yIGNvbXAtPmZ1bmNzIG90
aGVyd2lzZSB0aGVyZSB3aWxsIGJlIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZQ0KPiBjcmFzaC4N
Cj4gDQo+IEZpeGVzOiBiZDNkZThjZDc4MmIgKCJkcm0vbWVkaWF0ZWs6IEFkZCBnYW1tYSBwcm9w
ZXJ0eSBhY2NvcmRpbmcgdG8gaGFyZHdhcmUgY2FwYWJpbGl0eSIpDQo+IEZpeGVzOiA3Mzk1ZWFi
MDc3ZjkgKCJkcm0vbWVkaWF0ZWs6IEFkZCBjdG0gcHJvcGVydHkgc3VwcG9ydCIpDQoNCkJlY2F1
c2UgdGhlIGZpeGVkIHBhdGNoZXMgYXJlIHN0aWxsIGluIG15IHRyZWUsIHNvIEkgbWVyZ2UgdGhp
cyBwYXRjaA0Kd2l0aCB0aGUgZml4ZWQgcGF0Y2hlcyBpbiBtZWRpYXRlay1kcm0tbmV4dC01LjYg
WzFdLg0KDQpbMV0NCmh0dHBzOi8vZ2l0aHViLmNvbS9ja2h1LW1lZGlhdGVrL2xpbnV4LmdpdC10
YWdzL2NvbW1pdHMvbWVkaWF0ZWstZHJtLW5leHQtNS42DQoNClJlZ2FyZHMsDQpDSw0KDQo+IFNp
Z25lZC1vZmYtYnk6IEhzaW4tWWkgV2FuZyA8aHNpbnlpQGNocm9taXVtLm9yZz4NCj4gLS0tDQo+
IFRoaXMgcGF0Y2ggaXMgYmFzZWQgb24gbWVkaWF0ZWsncyBkcm0gYnJhbmNoOg0KPiBodHRwczov
L2dpdGh1Yi5jb20vY2todS1tZWRpYXRlay9saW51eC5naXQtdGFncy9jb21taXRzL21lZGlhdGVr
LWRybS1uZXh0LTUuNg0KPiANCj4gQWZ0ZXINCj4gaHR0cHM6Ly9wYXRjaHdvcmsuZnJlZWRlc2t0
b3Aub3JnL3BhdGNoLzM0NDQ3Ny8/c2VyaWVzPTYzMzI4JnJldj01OSwNCj4gdGhlcmUgd2lsbCBh
bHNvIGJlIGZ1bmNzIGZvciBoZG1pLWNvbm5lY3Rvci4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgfCAxMCArKysrKystLS0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiBpbmRleCBmYjE0MmZjZmMzNTMuLjdiMzkyZDZj
NzFjYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0
Yy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiBA
QCAtODA4LDExICs4MDgsMTMgQEAgaW50IG10a19kcm1fY3J0Y19jcmVhdGUoc3RydWN0IGRybV9k
ZXZpY2UgKmRybV9kZXYsDQo+ICANCj4gIAkJbXRrX2NydGMtPmRkcF9jb21wW2ldID0gY29tcDsN
Cj4gIA0KPiAtCQlpZiAoY29tcC0+ZnVuY3MtPmN0bV9zZXQpDQo+IC0JCQloYXNfY3RtID0gdHJ1
ZTsNCj4gKwkJaWYgKGNvbXAtPmZ1bmNzKSB7DQo+ICsJCQlpZiAoY29tcC0+ZnVuY3MtPmN0bV9z
ZXQpDQo+ICsJCQkJaGFzX2N0bSA9IHRydWU7DQo+ICANCj4gLQkJaWYgKGNvbXAtPmZ1bmNzLT5n
YW1tYV9zZXQpDQo+IC0JCQlnYW1tYV9sdXRfc2l6ZSA9IE1US19MVVRfU0laRTsNCj4gKwkJCWlm
IChjb21wLT5mdW5jcy0+Z2FtbWFfc2V0KQ0KPiArCQkJCWdhbW1hX2x1dF9zaXplID0gTVRLX0xV
VF9TSVpFOw0KPiArCQl9DQo+ICAJfQ0KPiAgDQo+ICAJZm9yIChpID0gMDsgaSA8IG10a19jcnRj
LT5kZHBfY29tcF9ucjsgaSsrKQ0KDQo=

