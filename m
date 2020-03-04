Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BE0C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 03:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DCD20842
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 03:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kSjlAehl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387651AbgCDDQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 22:16:25 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:39647 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387595AbgCDDQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 22:16:25 -0500
X-UUID: 0d74a16f8159421595eecd9bcf402b15-20200304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=3ZD5MsYu656KMRNrDoSsh6O5TBQomSaNiA5g4AqhbdY=;
        b=kSjlAehl7DXtE6MpOBytzOBRqN4GuuusYy5Pl2/Ws0eM5esMdOOheZPtkLbct6Q9hrKK+WhxbNe94Tl35cLNJuQ9ySF+a7KumzN5MuuPpxQvs4T8zb15Jzd8iQftxj/7BEDEzN3Jttty/42SD8kZsr/0ewd9diIYFbjzBFqJYCs=;
X-UUID: 0d74a16f8159421595eecd9bcf402b15-20200304
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1411949230; Wed, 04 Mar 2020 11:16:17 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 4 Mar 2020 11:15:20 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 4 Mar 2020 11:13:44 +0800
Message-ID: <1583291775.12083.59.camel@mtkswgap22>
Subject: Re: [PATCH] xhci-mtk: Fix NULL pointer dereference with xhci_irq()
 for shared_hcd
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chunfeng Yun =?UTF-8?Q?=28=E4=BA=91=E6=98=A5=E5=B3=B0=29?= 
        <Chunfeng.Yun@mediatek.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Sriharsha Allenki <sallenki@codeaurora.org>
Date:   Wed, 4 Mar 2020 11:16:15 +0800
In-Reply-To: <39ec1610-1686-6509-02ac-6e73d8be2453@linux.intel.com>
References: <1579246910-22736-1-git-send-email-macpaul.lin@mediatek.com>
         <08f69bab-2ada-d6ab-7bf7-d960e9f148a0@linux.intel.com>
         <1580556039.10835.3.camel@mtkswgap22>
         <39ec1610-1686-6509-02ac-6e73d8be2453@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTAyLTA0IGF0IDE3OjQ0ICswODAwLCBNYXRoaWFzIE55bWFuIHdyb3RlOg0K
PiBPbiAxLjIuMjAyMCAxMy4yMCwgTWFjcGF1bCBMaW4gd3JvdGU6DQo+ID4gT24gRnJpLCAyMDIw
LTAxLTMxIGF0IDE2OjUwICswMjAwLCBNYXRoaWFzIE55bWFuIHdyb3RlOg0KPiA+PiBPbiAxNy4x
LjIwMjAgOS40MSwgTWFjcGF1bCBMaW4gd3JvdGU6DQo+ID4+PiBBY2NvcmRpbmcgdG8gTlVMTCBw
b2ludGVyIGZpeDogaHR0cHM6Ly90aW55dXJsLmNvbS91cWZ0NXJhDQo+ID4+PiB4aGNpOiBGaXgg
TlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIHdpdGggeGhjaV9pcnEoKSBmb3Igc2hhcmVkX2hjZA0K
PiA+Pj4gVGhlIHNpbWlsYXIgaXNzdWUgaGFzIGFsc28gYmVlbiBmb3VuZCBpbiBRQyBhY3Rpdml0
aWVzIGluIE1lZGlhdGVrLg0KPiA+Pj4NCj4gPj4+IEhlcmUgcXVvdGUgdGhlIGRlc2NyaXB0aW9u
IGZyb20gdGhlIHJlZmVyZW5jZWQgcGF0Y2ggYXMgZm9sbG93cy4NCj4gPj4+ICJDb21taXQgKCJm
MDY4MDkwNDI2ZWEgeGhjaTogRml4IGxlYWtpbmcgVVNCMyBzaGFyZWRfaGNkDQo+ID4+PiBhdCB4
aGNpIHJlbW92YWwiKSBzZXRzIHhoY2lfc2hhcmVkX2hjZCB0byBOVUxMIHdpdGhvdXQNCj4gPj4+
IHN0b3BwaW5nIHhoY2kgaG9zdC4gVGhpcyByZXN1bHRzIGludG8gYSByYWNlIGNvbmRpdGlvbg0K
PiA+Pj4gd2hlcmUgc2hhcmVkX2hjZCAoc3VwZXIgc3BlZWQgcm9vdGh1YikgcmVsYXRlZCBpbnRl
cnJ1cHRzDQo+ID4+PiBhcmUgYmVpbmcgaGFuZGxlZCB3aXRoIHhoY2lfaXJxIGhhcHBlbnMgd2hl
biB0aGUNCj4gPj4+IHhoY2lfcGxhdF9yZW1vdmUgaXMgY2FsbGVkIGFuZCBzaGFyZWRfaGNkIGlz
IHNldCB0byBOVUxMLg0KPiA+Pj4gRml4IHRoaXMgYnkgc2V0dGluZyB0aGUgc2hhcmVkX2hjZCB0
byBOVUxMIG9ubHkgYWZ0ZXIgdGhlDQo+ID4+PiBjb250cm9sbGVyIGlzIGhhbHRlZCBhbmQgbm8g
aW50ZXJydXB0cyBhcmUgZ2VuZXJhdGVkLiINCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBT
cmloYXJzaGEgQWxsZW5raSA8c2FsbGVua2lAY29kZWF1cm9yYS5vcmc+DQo+ID4+PiBTaWduZWQt
b2ZmLWJ5OiBNYWNwYXVsIExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+Pj4gLS0t
DQo+ID4+PiAgICBkcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMgfCAyICstDQo+ID4+PiAgICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPj4+DQo+ID4+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jIGIvZHJpdmVycy91c2Iv
aG9zdC94aGNpLW10ay5jDQo+ID4+PiBpbmRleCBiMThhNmJhZWYyMDQuLmMyMjdjNjdmNWRjNSAx
MDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGsuYw0KPiA+Pj4gKysr
IGIvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jDQo+ID4+PiBAQCAtNTkzLDExICs1OTMsMTEg
QEAgc3RhdGljIGludCB4aGNpX210a19yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqZGV2
KQ0KPiA+Pj4gICAgCXN0cnVjdCB1c2JfaGNkICAqc2hhcmVkX2hjZCA9IHhoY2ktPnNoYXJlZF9o
Y2Q7DQo+ID4+PiAgICANCj4gPj4+ICAgIAl1c2JfcmVtb3ZlX2hjZChzaGFyZWRfaGNkKTsNCj4g
Pj4+IC0JeGhjaS0+c2hhcmVkX2hjZCA9IE5VTEw7DQo+ID4+PiAgICAJZGV2aWNlX2luaXRfd2Fr
ZXVwKCZkZXYtPmRldiwgZmFsc2UpOw0KPiA+Pj4gICAgDQo+ID4+PiAgICAJdXNiX3JlbW92ZV9o
Y2QoaGNkKTsNCj4gPj4+ICAgIAl1c2JfcHV0X2hjZChzaGFyZWRfaGNkKTsNCj4gPj4+ICsJeGhj
aS0+c2hhcmVkX2hjZCA9IE5VTEw7DQo+ID4+PiAgICAJdXNiX3B1dF9oY2QoaGNkKTsNCj4gPj4+
ICAgIAl4aGNpX210a19zY2hfZXhpdChtdGspOw0KPiA+Pj4gICAgCXhoY2lfbXRrX2Nsa3NfZGlz
YWJsZShtdGspOw0KPiA+Pj4NCj4gPj4NCj4gPj4gQ291bGQgeW91IHNoYXJlIGRldGFpbHMgb2Yg
dGhlIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSwgKGJhY2t0cmFjZSkuDQo+ID4gDQo+ID4gVGhp
cyBidWcgd2FzIGZvdW5kIGJ5IG91ciBRQSBzdGFmZiB3aGlsZSBkb2luZyA1MDAgdGltZXMgcGx1
Zy1pbiBhbmQNCj4gPiBwbHVnLW91dCBkZXZpY2VzLiBUaGUgYmFja3RyYWNlIEkgaGF2ZSB3YXMg
cmVjb3JkZWQgYnkgUUEgYW5kIEkgZGlkbid0DQo+ID4gcmVwcm9kdWNlIHRoaXMgaXNzdWUgb24g
bXkgb3duIGVudmlyb25tZW50LiBIb3dldmVyLCBhZnRlciBhcHBsaWVkIHRoaXMNCj4gPiBwYXRj
aCB0aGUgaXNzdWUgc2VlbXMgcmVzb2x2ZS4gSGVyZSBpcyB0aGUgYmFja3RyYWNlOg0KPiA+IA0K
PiA+IEV4Y2VwdGlvbiBDbGFzczogS2VybmVsIChLRSkNCj4gPiBQQyBpcyBhdCBbPGZmZmZmZjgw
MDhjY2NiYzA+XSB4aGNpX2lycSsweDcyOC8weDIzNjQNCj4gPiBMUiBpcyBhdCBbPGZmZmZmZjgw
MDhjY2M3ODg+XSB4aGNpX2lycSsweDJmMC8weDIzNjQNCj4gPiANCj4gPiBDdXJyZW50IEV4ZWN1
dGluZyBQcm9jZXNzOg0KPiA+IFtpcHRhYmxlcywgODU5XVtuZXRkYWdlbnQsIDc3MF0NCj4gPiAN
Cj4gPiBCYWNrdHJhY2U6DQo+ID4gWzxmZmZmZmY4MDA4MGVhZDU4Pl0gX19hdG9taWNfbm90aWZp
ZXJfY2FsbF9jaGFpbisweGE4LzB4MTMwDQo+ID4gWzxmZmZmZmY4MDA4MGViNmQ0Pl0gbm90aWZ5
X2RpZSsweDg0LzB4YWMNCj4gPiBbPGZmZmZmZjgwMDgwOGU4NzQ+XSBkaWUrMHgxZDgvMHgzYjgN
Cj4gPiBbPGZmZmZmZjgwMDgwYTg5YjA+XSBfX2RvX2tlcm5lbF9mYXVsdCsweDE3OC8weDE4OA0K
PiA+IFs8ZmZmZmZmODAwODBhODFiND5dIGRvX3BhZ2VfZmF1bHQrMHg0NC8weDNiMA0KPiA+IFs8
ZmZmZmZmODAwODBhODExYz5dIGRvX3RyYW5zbGF0aW9uX2ZhdWx0KzB4NDQvMHg5OA0KPiA+IFs8
ZmZmZmZmODAwODA4MGUwOD5dIGRvX21lbV9hYm9ydCsweDRjLzB4MTI4DQo+ID4gWzxmZmZmZmY4
MDA4MDgzMmQwPl0gZWwxX2RhKzB4MjQvMHgzYw0KPiA+IFs8ZmZmZmZmODAwOGNjY2JjMD5dIHho
Y2lfaXJxKzB4NzI4LzB4MjM2NA0KPiA+IFs8ZmZmZmZmODAwOGM5ODgwND5dIHVzYl9oY2RfaXJx
KzB4MmMvMHg0NA0KPiA+IFs8ZmZmZmZmODAwODE3OWJiMD5dIF9faGFuZGxlX2lycV9ldmVudF9w
ZXJjcHUrMHgyNmMvMHg0YTQNCj4gPiBbPGZmZmZmZjgwMDgxNzllYzg+XSBoYW5kbGVfaXJxX2V2
ZW50KzB4NWMvMHhkMA0KPiA+IFs8ZmZmZmZmODAwODE3ZTNjMD5dIGhhbmRsZV9mYXN0ZW9pX2ly
cSsweDEwYy8weDFlMA0KPiA+IFs8ZmZmZmZmODAwODE3ODdiMD5dIF9faGFuZGxlX2RvbWFpbl9p
cnErMHgzMmMvMHg3MzgNCj4gPiBbPGZmZmZmZjgwMDgwODE1OWM+XSBnaWNfaGFuZGxlX2lycSsw
eDE3NC8weDFjNA0KPiA+IFs8ZmZmZmZmODAwODA4M2NmOD5dIGVsMF9pcnFfbmFrZWQrMHg1MC8w
eDVjDQo+ID4gWzxmZmZmZmZmZmZmZmZmZmZmPl0gMHhmZmZmZmZmZmZmZmZmZmZmDQo+ID4gDQo+
IA0KPiBUaGFua3MsDQo+IENvdWxkIHlvdSBoZWxwIG1lIGZpbmQgb3V0IHdoaWNoIGxpbmUgb2Yg
Y29kZSB4aGNpX2lycSsweDcyOCBpcyBpbiB5b3VyIGNhc2UuDQo+IA0KPiBBcyBHdWVudGVyIHBv
aW50ZWQgb3V0IHRoZXJlIGlzIGEgcmlzayBvZiB0dXJuaW5nIHRoZSBOVUxMIHBvaW50ZXIgZGVy
ZWZlcmVuY2UNCj4gaW50byBhIHVzZSBhZnRlciBmcmVlIGlmIHdlIGp1c3Qgc29sdmUgdGhpcyBi
eSBzZXR0aW5nIHhoY2ktPnNoYXJlZF9oY2QgPSBOVUxMDQo+IGxhdGVyLg0KPiANCj4gSWYgeW91
IHN0aWxsIGhhdmUgdGhhdCBrZXJuZWwgYXJvdW5kLCBhbmQgeGhjaSBpcyBjb21waWxlZCBpbjoN
Cj4gZ2RiIHZtbGludXgNCj4gZ2RiIGxpICooeGhjaV9pcnErMHg3MjgpDQo+IA0KDQpTb3JyeSB0
aGF0IEkgY291bGRuJ3QgZ2V0IGJhY2sgdG8geW91IHNvb24uIFRoZSBpbnRlcm5hbCBjb2RlIHZl
cnNpb24NCmZvciB0aGlzIGlzc3VlIHdhcyByZWFsbHkgb2xkIGFuZCBhIGxpdHRsZSBiaXQgZGlm
ZmljdWx0IHRvIHJld2luZCB0bw0KdGhhdCB2ZXJzaW9uLg0KSG93ZXZlciwgSSB0aGluayB0aGUg
Zm9sbG93aW5nIGR1bXAgbWlnaHQgYmUgY29ycmVjdCBmb3IgdGhlIGNvZGUgYmFzZS4NCg0KKGdk
YikgbGkgKih4aGNpX2lycSsweDcyOCkNCjB4ZmZmZmZmODAwOGNjODYzNCBpcyBpbiB4aGNpX2ly
cSAoKnN0cmlwcGVkKg0Ka2VybmVsLTQuMTQvZHJpdmVycy91c2IvaG9zdC94aGNpLmg6MTY5NCku
DQoxNjg5ICAgICAqLw0KMTY5MCAgICAjZGVmaW5lIFhIQ0lfTUFYX1JFWElUX1RJTUVPVVRfTVMg
ICAgICAgMjANCjE2OTENCjE2OTIgICAgc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQgaGNkX2lu
ZGV4KHN0cnVjdCB1c2JfaGNkICpoY2QpDQoxNjkzICAgIHsNCjE2OTQgICAgICAgICAgICBpZiAo
aGNkLT5zcGVlZCA+PSBIQ0RfVVNCMykNCjE2OTUgICAgICAgICAgICAgICAgICAgIHJldHVybiAw
Ow0KMTY5NiAgICAgICAgICAgIGVsc2UNCjE2OTcgICAgICAgICAgICAgICAgICAgIHJldHVybiAx
Ow0KMTY5OCAgICB9DQooZ2RiKQ0KDQpUaGFua3MNCk1hY3BhdWwgTGluDQoNCg==

