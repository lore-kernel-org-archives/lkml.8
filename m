Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3422C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCB9D206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cxIlhD2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgHJMMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:12:38 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:61896 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726657AbgHJMMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:12:38 -0400
X-UUID: c19a747bc3b34e1dacf458ee352624a9-20200810
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=85XI0r8gSm4pXV6KLRTXENKU7LoA4RXMZocUnSqxJRc=;
        b=cxIlhD2g5Qs6z62b8bTlSgu5/XQHLgDcdKdIfOke5gSemEonWspbZ+Jrhi8Db709r6KBPFFf17lsJWKBSKZxdyQkjhS9af8r+ymKVIbHP5YbKBMMaTWADX+UhAsbIwKNOEyez/x10MgRKDFQW+S8e99GP3kVwEuy3jJXuB0n3D4=;
X-UUID: c19a747bc3b34e1dacf458ee352624a9-20200810
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1866359265; Mon, 10 Aug 2020 20:12:35 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 10 Aug 2020 20:12:32 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 Aug 2020 20:12:32 +0800
Message-ID: <1597061554.13160.17.camel@mtksdccf07>
Subject: Re: [PATCH 0/5] kasan: add workqueue and timer stack for generic
 KASAN
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Qian Cai <cai@lca.pw>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Tejun Heo" <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
Date:   Mon, 10 Aug 2020 20:12:34 +0800
In-Reply-To: <1597060257.13160.11.camel@mtksdccf07>
References: <20200810072115.429-1-walter-zh.wu@mediatek.com>
         <B873B364-FF03-4819-8F9C-79F3C4EF47CE@lca.pw>
         <1597060257.13160.11.camel@mtksdccf07>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA4LTEwIGF0IDE5OjUwICswODAwLCBXYWx0ZXIgV3Ugd3JvdGU6DQo+IE9u
IE1vbiwgMjAyMC0wOC0xMCBhdCAwNzoxOSAtMDQwMCwgUWlhbiBDYWkgd3JvdGU6DQo+ID4gDQo+
ID4gPiBPbiBBdWcgMTAsIDIwMjAsIGF0IDM6MjEgQU0sIFdhbHRlciBXdSA8d2FsdGVyLXpoLnd1
QG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gPiANCj4gPiA+IO+7v1N5emJvdCByZXBvcnRzIG1h
bnkgVUFGIGlzc3VlcyBmb3Igd29ya3F1ZXVlIG9yIHRpbWVyLCBzZWUgWzFdIGFuZCBbMl0uDQo+
ID4gPiBJbiBzb21lIG9mIHRoZXNlIGFjY2Vzcy9hbGxvY2F0aW9uIGhhcHBlbmVkIGluIHByb2Nl
c3Nfb25lX3dvcmsoKSwNCj4gPiA+IHdlIHNlZSB0aGUgZnJlZSBzdGFjayBpcyB1c2VsZXNzIGlu
IEtBU0FOIHJlcG9ydCwgaXQgZG9lc24ndCBoZWxwDQo+ID4gPiBwcm9ncmFtbWVycyB0byBzb2x2
ZSBVQUYgb24gd29ya3F1ZXVlLiBUaGUgc2FtZSBtYXkgc3RhbmQgZm9yIHRpbWVzLg0KPiA+ID4g
DQo+ID4gPiBUaGlzIHBhdGNoc2V0IGltcHJvdmVzIEtBU0FOIHJlcG9ydHMgYnkgbWFraW5nIHRo
ZW0gdG8gaGF2ZSB3b3JrcXVldWUNCj4gPiA+IHF1ZXVlaW5nIHN0YWNrIGFuZCB0aW1lciBxdWV1
ZWluZyBzdGFjayBpbmZvcm1hdGlvbi4gSXQgaXMgdXNlZnVsIGZvcg0KPiA+ID4gcHJvZ3JhbW1l
cnMgdG8gc29sdmUgdXNlLWFmdGVyLWZyZWUgb3IgZG91YmxlLWZyZWUgbWVtb3J5IGlzc3VlLg0K
PiA+ID4gDQo+ID4gPiBHZW5lcmljIEtBU0FOIHdpbGwgcmVjb3JkIHRoZSBsYXN0IHR3byB3b3Jr
cXVldWUgYW5kIHRpbWVyIHN0YWNrcywNCj4gPiA+IHByaW50IHRoZW0gaW4gS0FTQU4gcmVwb3J0
LiBJdCBpcyBvbmx5IHN1aXRhYmxlIGZvciBnZW5lcmljIEtBU0FOLg0KPiA+ID4gDQo+ID4gPiBJ
biBvcmRlciB0byBwcmludCB0aGUgbGFzdCB0d28gd29ya3F1ZXVlIGFuZCB0aW1lciBzdGFja3Ms
IHNvIHRoYXQNCj4gPiA+IHdlIGFkZCBuZXcgbWVtYmVycyBpbiBzdHJ1Y3Qga2FzYW5fYWxsb2Nf
bWV0YS4NCj4gPiA+IC0gdHdvIHdvcmtxdWV1ZSBxdWV1ZWluZyB3b3JrIHN0YWNrcywgdG90YWwg
c2l6ZSBpcyA4IGJ5dGVzLg0KPiA+ID4gLSB0d28gdGltZXIgcXVldWVpbmcgc3RhY2tzLCB0b3Rh
bCBzaXplIGlzIDggYnl0ZXMuDQo+ID4gPiANCj4gPiA+IE9yaWduaWFsIHN0cnVjdCBrYXNhbl9h
bGxvY19tZXRhIHNpemUgaXMgMTYgYnl0ZXMuIEFmdGVyIGFkZCBuZXcNCj4gPiA+IG1lbWJlcnMs
IHRoZW4gdGhlIHN0cnVjdCBrYXNhbl9hbGxvY19tZXRhIHRvdGFsIHNpemUgaXMgMzIgYnl0ZXMs
DQo+ID4gPiBJdCBpcyBhIGdvb2QgbnVtYmVyIG9mIGFsaWdubWVudC4gTGV0IGl0IGdldCBiZXR0
ZXIgbWVtb3J5IGNvbnN1bXB0aW9uLg0KPiA+IA0KPiA+IEdldHRpbmcgZGVidWdnaW5nIHRvb2xz
IGNvbXBsaWNhdGVkIHN1cmVseSBpcyB0aGUgYmVzdCB3YXkgdG8ga2lsbCBpdC4gSSB3b3VsZCBh
cmd1ZSB0aGF0IGl0IG9ubHkgbWFrZSBzZW5zZSB0byBjb21wbGljYXRlIGl0IGlmIGl0IGlzIHVz
ZWZ1bCBtb3N0IG9mIHRoZSB0aW1lIHdoaWNoIEkgbmV2ZXIgZmVlbCBvciBoZWFyIHRoYXQgaXMg
dGhlIGNhc2UuIFRoaXMgcmVtaW5kcyBtZSB5b3VyIHJlY2VudCBjYWxsX3JjdSgpIHN0YWNrcyB0
aGF0IG1vc3Qgb2YgdGltZSBqdXN0IG1ha2VzIHBhcnNpbmcgdGhlIHJlcG9ydCBjdW1iZXJzb21l
LiBUaHVzLCBJIHVyZ2UgdGhpcyBleGVyY2lzZSB0byBvdmVyLWVuZ2luZWVyIG9uIHNwZWNpYWwg
Y2FzZXMgbmVlZCB0byBzdG9wIGVudGlyZWx5Lg0KPiA+IA0KPiANCj4gQSBnb29kIGRlYnVnIHRv
b2wgaXMgdG8gaGF2ZSBjb21wbGV0ZSBpbmZvcm1hdGlvbiBpbiBvcmRlciB0byBzb2x2ZQ0KPiBp
c3N1ZS4gV2Ugc2hvdWxkIGZvY3VzIG9uIGlmIEtBU0FOIHJlcG9ydHMgYWx3YXlzIHNob3cgdGhp
cyBkZWJ1Zw0KPiBpbmZvcm1hdGlvbiBvciBjcmVhdGUgYSBvcHRpb24gdG8gZGVjaWRlIGlmIHNo
b3cgaXQuIEJlY2F1c2UgdGhpcw0KPiBmZWF0dXJlIGlzIERtaXRyeSdzIHN1Z2dlc3Rpb24uIHNl
ZSBbMV0uIFNvIEkgdGhpbmsgaXQgbmVlZCB0byBiZQ0KPiBpbXBsZW1lbnRlZC4gTWF5YmUgd2Ug
Y2FuIHdhaXQgaGlzIHJlc3BvbnNlLiANCj4gDQo+IFsxXWh0dHBzOi8vbGttbC5vcmcvbGttbC8y
MDIwLzYvMjMvMjU2DQo+IA0KPiBUaGFua3MuDQo+IA0KDQpGaXggbmFtZSB0eXBvLiBJIGFtIHNv
cnJ5IHRvIGhpbS4NCkFuZCBhZGQgYSBidWd6aWxsYSB0byBzaG93IHdoeSBuZWVkIHRvIGRvIGl0
LiBwbGVhc2Ugc2VlIFsxXS4NCg0KWzFdIGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93
X2J1Zy5jZ2k/aWQ9MTk4NDM3DQoNCj4gPiA+IA0KPiA+ID4gWzFdaHR0cHM6Ly9ncm91cHMuZ29v
Z2xlLmNvbS9nL3N5emthbGxlci1idWdzL3NlYXJjaD9xPSUyMnVzZS1hZnRlci1mcmVlJTIyK3By
b2Nlc3Nfb25lX3dvcmsNCj4gPiA+IFsyXWh0dHBzOi8vZ3JvdXBzLmdvb2dsZS5jb20vZy9zeXpr
YWxsZXItYnVncy9zZWFyY2g/cT0lMjJ1c2UtYWZ0ZXItZnJlZSUyMiUyMGV4cGlyZV90aW1lcnMN
Cj4gPiA+IFszXWh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTk4
NDM3DQo+ID4gPiANCj4gPiA+IFdhbHRlciBXdSAoNSk6DQo+ID4gPiB0aW1lcjoga2FzYW46IHJl
Y29yZCBhbmQgcHJpbnQgdGltZXIgc3RhY2sNCj4gPiA+IHdvcmtxdWV1ZToga2FzYW46IHJlY29y
ZCBhbmQgcHJpbnQgd29ya3F1ZXVlIHN0YWNrDQo+ID4gPiBsaWIvdGVzdF9rYXNhbi5jOiBhZGQg
dGltZXIgdGVzdCBjYXNlDQo+ID4gPiBsaWIvdGVzdF9rYXNhbi5jOiBhZGQgd29ya3F1ZXVlIHRl
c3QgY2FzZQ0KPiA+ID4ga2FzYW46IHVwZGF0ZSBkb2N1bWVudGF0aW9uIGZvciBnZW5lcmljIGth
c2FuDQo+ID4gPiANCj4gPiA+IERvY3VtZW50YXRpb24vZGV2LXRvb2xzL2thc2FuLnJzdCB8ICA0
ICsrLS0NCj4gPiA+IGluY2x1ZGUvbGludXgva2FzYW4uaCAgICAgICAgICAgICB8ICA0ICsrKysN
Cj4gPiA+IGtlcm5lbC90aW1lL3RpbWVyLmMgICAgICAgICAgICAgICB8ICAyICsrDQo+ID4gPiBr
ZXJuZWwvd29ya3F1ZXVlLmMgICAgICAgICAgICAgICAgfCAgMyArKysNCj4gPiA+IGxpYi90ZXN0
X2thc2FuLmMgICAgICAgICAgICAgICAgICB8IDU0ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gbW0va2FzYW4vZ2VuZXJpYy5jICAg
ICAgICAgICAgICAgIHwgNDIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ID4gPiBtbS9rYXNhbi9rYXNhbi5oICAgICAgICAgICAgICAgICAgfCAgNiArKysrKy0N
Cj4gPiA+IG1tL2thc2FuL3JlcG9ydC5jICAgICAgICAgICAgICAgICB8IDIyICsrKysrKysrKysr
KysrKysrKysrKysNCj4gPiA+IDggZmlsZXMgY2hhbmdlZCwgMTM0IGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+ID4gPiANCj4gPiA+IC0tIA0KPiA+ID4gWW91IHJlY2VpdmVkIHRoaXMg
bWVzc2FnZSBiZWNhdXNlIHlvdSBhcmUgc3Vic2NyaWJlZCB0byB0aGUgR29vZ2xlIEdyb3VwcyAi
a2FzYW4tZGV2IiBncm91cC4NCj4gPiA+IFRvIHVuc3Vic2NyaWJlIGZyb20gdGhpcyBncm91cCBh
bmQgc3RvcCByZWNlaXZpbmcgZW1haWxzIGZyb20gaXQsIHNlbmQgYW4gZW1haWwgdG8ga2FzYW4t
ZGV2K3Vuc3Vic2NyaWJlQGdvb2dsZWdyb3Vwcy5jb20uDQo+ID4gPiBUbyB2aWV3IHRoaXMgZGlz
Y3Vzc2lvbiBvbiB0aGUgd2ViIHZpc2l0IGh0dHBzOi8vZ3JvdXBzLmdvb2dsZS5jb20vZC9tc2dp
ZC9rYXNhbi1kZXYvMjAyMDA4MTAwNzIxMTUuNDI5LTEtd2FsdGVyLXpoLnd1JTQwbWVkaWF0ZWsu
Y29tLg0KPiANCg0K

