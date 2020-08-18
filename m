Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9ADC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 02:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8332620716
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 02:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rok244st"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgHRCos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 22:44:48 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:35656 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726360AbgHRCos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 22:44:48 -0400
X-UUID: 47f689674dcb4c12b389755fc9f029c9-20200818
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=en2ljHqsnZ/VPKCY8bno0iSD5K5hgy3QPkxO0IChSmg=;
        b=rok244stEazfl4qerr1v9g4k3UYxTeAZcPDYBhjgRv9UPY+L6Wj9+qGLhKiOWfaaoBTm7IXJSaFPe1euF19oPeVib81AMaZaKTmOMGYNp21GlCKr4JzvFhO1BUJ62CHcDluNDExKdmxQvWVBI5l90el7JWox067OFOjLx0lznek=;
X-UUID: 47f689674dcb4c12b389755fc9f029c9-20200818
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1080151321; Tue, 18 Aug 2020 10:44:40 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 18 Aug 2020 10:44:38 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 18 Aug 2020 10:44:38 +0800
Message-ID: <1597718679.5704.3.camel@mtkswgap22>
Subject: Re: [PATCH v6 2/2] soc: mediatek: add mt6779 devapc driver
From:   Neal Liu <neal.liu@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Neal Liu <neal.liu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 18 Aug 2020 10:44:39 +0800
In-Reply-To: <CAAOTY__7gmvp+U+xD12KJkxuya=CkD8xV67S3pfC60gyfajQiA@mail.gmail.com>
References: <1597289564-17030-1-git-send-email-neal.liu@mediatek.com>
         <1597289564-17030-3-git-send-email-neal.liu@mediatek.com>
         <CAAOTY_88YSHOvDEHm+rM1=fTv_y25nUh1tuLUH8YSxH5UD1bug@mail.gmail.com>
         <1597636953.3394.7.camel@mtkswgap22>
         <CAAOTY__7gmvp+U+xD12KJkxuya=CkD8xV67S3pfC60gyfajQiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 456BB4DDEFAE25A5B5D0432379B20AE28B9A6A79FB0FF20C0668B7C7963BB0EC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2h1bi1LdWFuZywNCg0KT24gTW9uLCAyMDIwLTA4LTE3IGF0IDIzOjEzICswODAwLCBDaHVu
LUt1YW5nIEh1IHdyb3RlOg0KPiBIaSwgTmVhbDoNCj4gDQo+IE5lYWwgTGl1IDxuZWFsLmxpdUBt
ZWRpYXRlay5jb20+IOaWvCAyMDIw5bm0OOaciDE35pelIOmAseS4gCDkuIvljYgxMjowMuWvq+mB
k++8mg0KPiA+DQo+ID4gSGkgQ2h1bi1LdWFuZywNCj4gPg0KPiA+IE9uIFNhdCwgMjAyMC0wOC0x
NSBhdCAxMTowMyArMDgwMCwgQ2h1bi1LdWFuZyBIdSB3cm90ZToNCj4gPiA+IEhpLCBOZWFsOg0K
PiA+ID4NCj4gPiA+IE5lYWwgTGl1IDxuZWFsLmxpdUBtZWRpYXRlay5jb20+IOaWvCAyMDIw5bm0
OOaciDEz5pelIOmAseWbmyDkuIrljYgxMTozM+Wvq+mBk++8mg0KPiA+ID4gPg0KPiA+ID4gPiBN
ZWRpYVRlayBidXMgZmFicmljIHByb3ZpZGVzIFRydXN0Wm9uZSBzZWN1cml0eSBzdXBwb3J0IGFu
ZCBkYXRhDQo+ID4gPiA+IHByb3RlY3Rpb24gdG8gcHJldmVudCBzbGF2ZXMgZnJvbSBiZWluZyBh
Y2Nlc3NlZCBieSB1bmV4cGVjdGVkDQo+ID4gPiA+IG1hc3RlcnMuDQo+ID4gPiA+IFRoZSBzZWN1
cml0eSB2aW9sYXRpb24gaXMgbG9nZ2VkIGFuZCBzZW50IHRvIHRoZSBwcm9jZXNzb3IgZm9yDQo+
ID4gPiA+IGZ1cnRoZXIgYW5hbHlzaXMgb3IgY291bnRlcm1lYXN1cmVzLg0KPiA+ID4gPg0KPiA+
ID4gPiBBbnkgb2NjdXJyZW5jZSBvZiBzZWN1cml0eSB2aW9sYXRpb24gd291bGQgcmFpc2UgYW4g
aW50ZXJydXB0LCBhbmQNCj4gPiA+ID4gaXQgd2lsbCBiZSBoYW5kbGVkIGJ5IG10ay1kZXZhcGMg
ZHJpdmVyLiBUaGUgdmlvbGF0aW9uDQo+ID4gPiA+IGluZm9ybWF0aW9uIGlzIHByaW50ZWQgaW4g
b3JkZXIgdG8gZmluZCB0aGUgbXVyZGVyZXIuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IE5lYWwgTGl1IDxuZWFsLmxpdUBtZWRpYXRlay5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4N
Cj4gPiA+IFtzbmlwXQ0KPiA+ID4NCj4gPiA+ID4gKy8qDQo+ID4gPiA+ICsgKiBkZXZhcGNfdmlv
bGF0aW9uX2lycSAtIHRoZSBkZXZhcGMgSW50ZXJydXB0IFNlcnZpY2UgUm91dGluZSAoSVNSKSB3
aWxsIGR1bXANCj4gPiA+ID4gKyAqICAgICAgICAgICAgICAgICAgICAgICAgdmlvbGF0aW9uIGlu
Zm9ybWF0aW9uIGluY2x1ZGluZyB3aGljaCBtYXN0ZXIgdmlvbGF0ZXMNCj4gPiA+ID4gKyAqICAg
ICAgICAgICAgICAgICAgICAgICAgYWNjZXNzIHNsYXZlLg0KPiA+ID4gPiArICovDQo+ID4gPiA+
ICtzdGF0aWMgaXJxcmV0dXJuX3QgZGV2YXBjX3Zpb2xhdGlvbl9pcnEoaW50IGlycV9udW1iZXIs
DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qg
bXRrX2RldmFwY19jb250ZXh0ICpjdHgpDQo+ID4gPiA+ICt7DQo+ID4gPiA+ICsgICAgICAgLyoN
Cj4gPiA+ID4gKyAgICAgICAgKiBNYXNrIHNsYXZlJ3MgaXJxIGJlZm9yZSBjbGVhcmluZyB2aW8g
c3RhdHVzLg0KPiA+ID4gPiArICAgICAgICAqIE11c3QgZG8gaXQgdG8gYXZvaWQgbmVzdGVkIGlu
dGVycnVwdCBhbmQgcHJldmVudA0KPiA+ID4gPiArICAgICAgICAqIHVuZXhwZWN0ZWQgYmVoYXZp
b3IuDQo+ID4gPiA+ICsgICAgICAgICovDQo+ID4gPiA+ICsgICAgICAgbWFza19tb2R1bGVfaXJx
KGN0eCwgdHJ1ZSk7DQo+ID4gPg0KPiA+ID4gSSBzdGlsbCBkb24ndCB1bmRlcnN0YW5kIHdoeSBu
ZXN0ZWQgaW50ZXJydXB0IGhhcHBlbi4gSWYgdHdvIENQVQ0KPiA+ID4gcHJvY2VzcyBkaWZmZXJl
bnQgZGV2YXBjIGludGVycnVwdCBhdCB0aGUgc2FtZSB0aW1lLCBtYXNrIGludGVycnVwdA0KPiA+
ID4gY291bGQgbm90IHByZXZlbnQgdGhlc2UgdHdvIENQVSB0byBzeW5jIHZpbyBkYmcgYXQgdGhl
IHNhbWUgdGltZS4gQXMgSQ0KPiA+ID4ga25vdywgaW4gQVJNIENQVSwgb25seSBDUFUwIHByb2Nl
c3MgaXJxIGhhbmRsZXIsIGFuZCBhbGwgZGV2YXBjDQo+ID4gPiBpbnRlcnJ1cHQgaGFzIHRoZSBz
YW1lIHByaW9yaXR5LCBzbyB3aHkgbmVzdGVkIGludGVycnVwdCBoYXBwZW4/IENvdWxkDQo+ID4g
PiB5b3UgZXhwbGFpbiBtb3JlIGRldGFpbCBhYm91dCBob3cgbmVzdGVkIGludGVycnVwdCBoYXBw
ZW4/DQo+ID4NCj4gPiBJZiB0aGVyZSBpcyBhbm90aGVyIHZpb2xhdGlvbiBoYXBwZW5lZCBiZWZv
cmUgcHJldmlvdXMgdmlvbGF0aW9uIGlzDQo+ID4gZnVsbHkgaGFuZGxlZCwgbmVzdGVkIGludGVy
cnVwdCB3b3VsZCBoYXBwZW4uDQo+ID4NCj4gPiBMZXQncyBtZSB0YWtlIGFuIGV4YW1wbGU6DQo+
ID4gdmlvIEEgaGFwcGVuDQo+ID4gZW50ZXIgQSBJU1INCj4gPiAuLi4gICAgICAgICAgICAgdmlv
IEIgaGFwcGVuDQo+ID4gZmluaXNoIEEgSVNSICAgIGVudGVyIEIgSVNSDQo+ID4gICAgICAgICAg
ICAgICAgIC4uLg0KPiA+ICAgICAgICAgICAgICAgICBmaW5pc2ggQiBJU1INCj4gPg0KPiA+IFdl
IG1hc2sgYWxsIG1vZHVsZSdzIGlycSB0byBhdm9pZCBuZXN0ZWQgaW50ZXJydXB0Lg0KPiANCj4g
VGhpcyBpcyBub3QgJ25lc3RlZCcgaW50ZXJydXB0LiBBZnRlciBBIElTUiBpcyBmaW5pc2hlZCwg
QiBJU1IgaGFwcGVuLg0KPiBTbyBBIElTUiBhbmQgQiBJU1IgYXJlIGNvbnNlY3V0aXZlIGludGVy
cnVwdCwgbm90IG5lc3RlZCBpbnRlcnJ1cHQuDQo+IFRvIGNvbXBhcmUgbWFzayBpcnEgYW5kIG5v
IG1hc2sgaXJxLCBMZXQncyBjb25zaWRlciB0aGlzIHNpdHVhdGlvbjoNCj4gDQo+IDEuIDEwMDAg
Y29uc2VjdXRpdmUgdmlvbGF0aW9uIGhhcHBlbiwgdGhlIHRpbWUgcGVyaW9kIGJldHdlZW4gdHdv
DQo+IHZpb2xhdGlvbiBpcyAwLjAxIG1zLCBzbyB0aGUgdG90YWwgdGltZSBpcyAxMG1zLiAoSW4g
MTBtcywgMTAwMA0KPiB2aW9sYXRpb24gaGFwcGVuKQ0KPiAyLiBPbmUgSVNSIGhhbmRsZSB0aW1l
IGlzIDEgbXMsIHNvIGluIG9uZSBJU1IgaGFuZGxlciwgMTAwIHZpb2xhdGlvbiBoYXBwZW4uDQo+
IA0KPiBGb3IgbWFzayBpcnEgc29sdXRpb24sIDEwIElTUiBoYW5kbGVyIGlzIHRyaWdnZXIuIEZv
ciBubyBtYXNrIGlycQ0KPiBzb2x1dGlvbiwgMTEgSVNSIGhhbmRsZXIgaXMgdHJpZ2dlci4NCj4g
SSB0aGluayB0aGVzZSB0d28gc29sdXRpb24gaGF2ZSBzaW1pbGFyIHJlc3VsdCwgYW5kIG5vIG1h
c2sgaXJxDQo+IHNvbHV0aW9uIHByaW50IG1vcmUgaW5mb3JtYXRpb24gKElmIHRoZXNlIDEwMDAg
dmlvbGF0aW9uIGlzIHRyaWdnZXIgYnkNCj4gMjAgZGlmZmVyZW50IGRyaXZlciwgbm8gbWFzayBz
b2x1dGlvbiBtYXkgc2hvdyBvbmUgbW9yZSBkcml2ZXIgdGhhbg0KPiBtYXNrIHNvbHV0aW9uKQ0K
PiBTbyBJIHRoaW5rIGl0J3Mgbm90IG5lY2Vzc2FyeSB0byBtYXNrIGlycSBpbiBpcnEgaGFuZGxl
ci4NCj4gDQoNCk5vLCBteSBleGFtcGxlIGlzIEIgSVNSIGlzIGVudGVyZWQgYmVmb3JlIEEgSVNS
IGZpbmlzaGVkLg0KV2h5IHRoaXMgaXMgbm90IG5lc3RlZD8NCnZpbyBBIGhhcHBlbg0KZW50ZXIg
QSBJU1INCi4uLiAgICAgICAgICAgICB2aW8gQiBoYXBwZW4NCi4uLgkJZW50ZXIgQiBJU1INCmZp
bmlzaCBBIElTUg0KICAgICAgICAgICAgICAgIC4uLg0KCQkuLi4NCiAgICAgICAgICAgICAgICBm
aW5pc2ggQiBJU1INCg0KPiA+DQo+ID4gPg0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgd2hp
bGUgKGRldmFwY19zeW5jX3Zpb19kYmcoY3R4KSkNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIGRl
dmFwY19leHRyYWN0X3Zpb19kYmcoY3R4KTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIC8q
DQo+ID4gPiA+ICsgICAgICAgICogRW5zdXJlIHRoYXQgdmlvbGF0aW9uIGluZm8gYXJlIHdyaXR0
ZW4NCj4gPiA+ID4gKyAgICAgICAgKiBiZWZvcmUgZnVydGhlciBvcGVyYXRpb25zDQo+ID4gPiA+
ICsgICAgICAgICovDQo+ID4gPiA+ICsgICAgICAgc21wX21iKCk7DQo+ID4gPiA+ICsNCj4gPiA+
ID4gKyAgICAgICBjbGVhcl92aW9fc3RhdHVzKGN0eCk7DQo+ID4gPiA+ICsgICAgICAgbWFza19t
b2R1bGVfaXJxKGN0eCwgZmFsc2UpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgcmV0dXJu
IElSUV9IQU5ETEVEOw0KPiA+ID4gPiArfQ0KPiA+ID4gPiArDQo+ID4gPg0KPiA+ID4gW3NuaXBd
DQo+ID4gPg0KPiA+ID4gPiArDQo+ID4gPiA+ICtzdGF0aWMgaW50IG10a19kZXZhcGNfcmVtb3Zl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gPiA+ICt7DQo+ID4gPiA+ICsgICAg
ICAgc3RydWN0IG10a19kZXZhcGNfY29udGV4dCAqY3R4ID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEo
cGRldik7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICBzdG9wX2RldmFwYyhjdHgpOw0KPiA+
ID4gPiArDQo+ID4gPiA+ICsgICAgICAgaWYgKGN0eC0+aW5mcmFfY2xrKQ0KPiA+ID4NCj4gPiA+
IFRoaXMgYWx3YXlzIHRydWUuDQo+ID4NCj4gPiBEb2VzIGl0IG1lYW4gdGhhdCByZW1vdmUgZnVu
Y3Rpb24gd291bGQgYmUgY2FsbGVkIG9ubHkgaWYgcHJvYmUgZnVuY3Rpb24NCj4gPiBpcyByZXR1
cm5lZCBzdWNjZXNzZnVsbHk/DQo+IA0KPiBZZXMuDQo+IA0KPiA+IElzIHRoZXJlIGFueSBjaGFu
Y2UgdGhpcyBmdW5jdGlvbiB3b3VsZCBiZSBjYWxsZWQgZGlyZWN0bHk/DQo+IA0KPiBOby4NCj4g
DQo+IFJlZ2FyZHMsDQo+IENodW4tS3VhbmcuDQo+IA0KPiA+DQo+ID4gPg0KPiA+ID4gUmVnYXJk
cywNCj4gPiA+IENodW4tS3VhbmcuDQo+ID4gPg0KPiA+ID4gPiArICAgICAgICAgICAgICAgY2xr
X2Rpc2FibGVfdW5wcmVwYXJlKGN0eC0+aW5mcmFfY2xrKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiAr
ICAgICAgIHJldHVybiAwOw0KPiA+ID4gPiArfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICtzdGF0aWMg
c3RydWN0IHBsYXRmb3JtX2RyaXZlciBtdGtfZGV2YXBjX2RyaXZlciA9IHsNCj4gPiA+ID4gKyAg
ICAgICAucHJvYmUgPSBtdGtfZGV2YXBjX3Byb2JlLA0KPiA+ID4gPiArICAgICAgIC5yZW1vdmUg
PSBtdGtfZGV2YXBjX3JlbW92ZSwNCj4gPiA+ID4gKyAgICAgICAuZHJpdmVyID0gew0KPiA+ID4g
PiArICAgICAgICAgICAgICAgLm5hbWUgPSBLQlVJTERfTU9ETkFNRSwNCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgIC5vZl9tYXRjaF90YWJsZSA9IG10a19kZXZhcGNfZHRfbWF0Y2gsDQo+ID4gPiA+
ICsgICAgICAgfSwNCj4gPiA+ID4gK307DQo+ID4gPiA+ICsNCj4gPiA+ID4gK21vZHVsZV9wbGF0
Zm9ybV9kcml2ZXIobXRrX2RldmFwY19kcml2ZXIpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICtNT0RV
TEVfREVTQ1JJUFRJT04oIk1lZGlhdGVrIERldmljZSBBUEMgRHJpdmVyIik7DQo+ID4gPiA+ICtN
T0RVTEVfQVVUSE9SKCJOZWFsIExpdSA8bmVhbC5saXVAbWVkaWF0ZWsuY29tPiIpOw0KPiA+ID4g
PiArTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOw0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAxLjcuOS41DQo+
ID4gPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+
ID4gPiA+IExpbnV4LW1lZGlhdGVrIG1haWxpbmcgbGlzdA0KPiA+ID4gPiBMaW51eC1tZWRpYXRl
a0BsaXN0cy5pbmZyYWRlYWQub3JnDQo+ID4gPiA+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtbWVkaWF0ZWsNCj4gPg0KDQo=

