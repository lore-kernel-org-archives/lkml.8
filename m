Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84C1C3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 01:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26A120708
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 01:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Tktp5Tts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbgBKBTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 20:19:41 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:15287 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727120AbgBKBTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 20:19:40 -0500
X-UUID: bb4be0dbcae848f58523fcadeed9470f-20200211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=mxKXHpMsJ5tja8hbUWbIbhD1W2Y9D1qbD+njzeGZeLo=;
        b=Tktp5Ttsa726dao3RTS7GoXNd3YZYVkBSmBNjTBUHKgRcmtOlWHLtbpvTeZ0H+EMYjJVOfPSXOkbwQX8qcIzttInXfMIfiR9XW6jUSLcpkveZBE6B7qJcZXuFuhFpsrbnepqeSobKjpdZefnXWfoCuKQ1OBPbbkV4FsBfRWGU3s=;
X-UUID: bb4be0dbcae848f58523fcadeed9470f-20200211
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 772415810; Tue, 11 Feb 2020 09:19:35 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 11 Feb 2020 09:18:52 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 11 Feb 2020 09:20:00 +0800
Message-ID: <1581383974.3194.1.camel@mtksdaap41>
Subject: Re: [PATCH] drm/mediatek: Find the cursor plane instead of hard
 coding it
From:   CK Hu <ck.hu@mediatek.com>
To:     Sean Paul <sean@poorly.run>
CC:     Evan Benn <evanbenn@chromium.org>, David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 11 Feb 2020 09:19:34 +0800
In-Reply-To: <CAMavQKLqr=a=WZKFfC2sEBcskjX+k-82a3V3XVk7LQLzpAMaBg@mail.gmail.com>
References: <20200206140140.GA18465@art_vandelay>
         <20200207152348.1.Ie0633018fc787dda6e869cae23df76ae30f2a686@changeid>
         <1581064499.590.0.camel@mtksdaap41> <1581303187.951.2.camel@mtksdaap41>
         <CAMavQKLqr=a=WZKFfC2sEBcskjX+k-82a3V3XVk7LQLzpAMaBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTAyLTEwIGF0IDA5OjEwIC0wNTAwLCBTZWFuIFBhdWwgd3JvdGU6DQo+IE9u
IFN1biwgRmViIDksIDIwMjAgYXQgOTo1MyBQTSBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPiB3
cm90ZToNCj4gPg0KPiA+IEhpLCBFdmFuOg0KPiA+DQo+ID4gT24gRnJpLCAyMDIwLTAyLTA3IGF0
IDE2OjM0ICswODAwLCBDSyBIdSB3cm90ZToNCj4gPiA+IEhpLCBFdmFuOg0KPiA+ID4NCj4gPiA+
IE9uIEZyaSwgMjAyMC0wMi0wNyBhdCAxNToyMyArMTEwMCwgRXZhbiBCZW5uIHdyb3RlOg0KPiA+
ID4gPiBUaGUgY3Vyc29yIGFuZCBwcmltYXJ5IHBsYW5lcyB3ZXJlIGhhcmQgY29kZWQuDQo+ID4g
PiA+IE5vdyBzZWFyY2ggZm9yIHRoZW0gZm9yIHBhc3NpbmcgdG8gZHJtX2NydGNfaW5pdF93aXRo
X3BsYW5lcw0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IFJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVA
bWVkaWF0ZWsuY29tPg0KPiA+DQo+ID4gQXBwbGllZCB0byBtZWRpYXRlay1kcm0tZml4ZXMtNS42
IFsxXSwgdGhhbmtzLg0KPiA+DQo+IA0KPiBIaSBDSywNCj4gVGhhbmtzIGZvciBwaWNraW5nIHRo
aXMgdXAuIEJlZm9yZSB5b3Ugc2VuZCB0aGUgcHVsbCwgY291bGQgeW91IHBsZWFzZQ0KPiByZXZl
cnNlIHRoZSBvcmRlciBvZiB0aGVzZSAyIHBhdGNoZXM/IEV2YW4ncyBzaG91bGQgY29tZSBiZWZv
cmUgbWluZQ0KPiB0byBwcmV2ZW50IGEgcmVncmVzc2lvbi4NCj4gDQo+IFNlYW4NCj4gDQoNCkhp
LCBTZWFuOg0KDQpUaGFua3MgZm9yIHlvdXIgbm90aWNlLiBJJ3ZlIHJldmVyc2VkIHRoZSBvcmRl
ci4NCg0KUmVnYXJkcywNCkNLDQoNCj4gPiBbMV0NCj4gPiBodHRwczovL2dpdGh1Yi5jb20vY2to
dS1tZWRpYXRlay9saW51eC5naXQtdGFncy9jb21taXRzL21lZGlhdGVrLWRybS1maXhlcy01LjYN
Cj4gPg0KPiA+IFJlZ2FyZHMsDQo+ID4gQ0sNCj4gPg0KPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogRXZhbiBCZW5uIDxldmFuYmVubkBjaHJvbWl1bS5vcmc+DQo+ID4gPiA+IC0tLQ0KPiA+
ID4gPg0KPiA+ID4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jIHwg
MTggKysrKysrKysrKysrLS0tLS0tDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0
aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiA+ID4gPiBpbmRleCA3YjM5MmQ2YzcxY2MuLjkzNTY1
Mjk5MGFmYSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcm1fY3J0Yy5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2NydGMuYw0KPiA+ID4gPiBAQCAtNjU4LDEwICs2NTgsMTggQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBkcm1fY3J0Y19oZWxwZXJfZnVuY3MgbXRrX2NydGNfaGVscGVyX2Z1bmNzID0gew0KPiA+
ID4gPg0KPiA+ID4gPiAgc3RhdGljIGludCBtdGtfZHJtX2NydGNfaW5pdChzdHJ1Y3QgZHJtX2Rl
dmljZSAqZHJtLA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IG10a19k
cm1fY3J0YyAqbXRrX2NydGMsDQo+ID4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICBzdHJ1
Y3QgZHJtX3BsYW5lICpwcmltYXJ5LA0KPiA+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAg
c3RydWN0IGRybV9wbGFuZSAqY3Vyc29yLCB1bnNpZ25lZCBpbnQgcGlwZSkNCj4gPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBwaXBlKQ0KPiA+ID4gPiAgew0KPiA+
ID4gPiAtICAgaW50IHJldDsNCj4gPiA+ID4gKyAgIHN0cnVjdCBkcm1fcGxhbmUgKnByaW1hcnkg
PSBOVUxMOw0KPiA+ID4gPiArICAgc3RydWN0IGRybV9wbGFuZSAqY3Vyc29yID0gTlVMTDsNCj4g
PiA+ID4gKyAgIGludCBpLCByZXQ7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgIGZvciAoaSA9IDA7
IGkgPCBtdGtfY3J0Yy0+bGF5ZXJfbnI7IGkrKykgew0KPiA+ID4gPiArICAgICAgICAgICBpZiAo
bXRrX2NydGMtPnBsYW5lc1tpXS50eXBlID09IERSTV9QTEFORV9UWVBFX1BSSU1BUlkpDQo+ID4g
PiA+ICsgICAgICAgICAgICAgICAgICAgcHJpbWFyeSA9ICZtdGtfY3J0Yy0+cGxhbmVzW2ldOw0K
PiA+ID4gPiArICAgICAgICAgICBlbHNlIGlmIChtdGtfY3J0Yy0+cGxhbmVzW2ldLnR5cGUgPT0g
RFJNX1BMQU5FX1RZUEVfQ1VSU09SKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgIGN1cnNv
ciA9ICZtdGtfY3J0Yy0+cGxhbmVzW2ldOw0KPiA+ID4gPiArICAgfQ0KPiA+ID4gPg0KPiA+ID4g
PiAgICAgcmV0ID0gZHJtX2NydGNfaW5pdF93aXRoX3BsYW5lcyhkcm0sICZtdGtfY3J0Yy0+YmFz
ZSwgcHJpbWFyeSwgY3Vyc29yLA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAmbXRrX2NydGNfZnVuY3MsIE5VTEwpOw0KPiA+ID4gPiBAQCAtODMwLDkgKzgzOCw3
IEBAIGludCBtdGtfZHJtX2NydGNfY3JlYXRlKHN0cnVjdCBkcm1fZGV2aWNlICpkcm1fZGV2LA0K
PiA+ID4gPiAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gPiA+ICAgICB9DQo+
ID4gPiA+DQo+ID4gPiA+IC0gICByZXQgPSBtdGtfZHJtX2NydGNfaW5pdChkcm1fZGV2LCBtdGtf
Y3J0YywgJm10a19jcnRjLT5wbGFuZXNbMF0sDQo+ID4gPiA+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICBtdGtfY3J0Yy0+bGF5ZXJfbnIgPiAxID8gJm10a19jcnRjLT5wbGFuZXNbMV0gOg0K
PiA+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCwgcGlwZSk7DQo+ID4gPiA+
ICsgICByZXQgPSBtdGtfZHJtX2NydGNfaW5pdChkcm1fZGV2LCBtdGtfY3J0YywgcGlwZSk7DQo+
ID4gPiA+ICAgICBpZiAocmV0IDwgMCkNCj4gPiA+ID4gICAgICAgICAgICAgcmV0dXJuIHJldDsN
Cj4gPiA+ID4NCj4gPiA+DQo+ID4NCj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXw0KPiA+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QNCj4gPiBkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwNCg0K

