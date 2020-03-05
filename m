Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B05C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 02:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F50220838
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 02:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bwi+QgHx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbgCEC64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 21:58:56 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:11905 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725810AbgCEC6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 21:58:55 -0500
X-UUID: 65600fd7992e4f2a941f1790c12fc5eb-20200305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=F7PLKBwRKlNMHN+qvRx/poyq+GC8uN8Rdyl0q+FHkC0=;
        b=bwi+QgHxF7+70QzDd5pQu7Ulhi99aqe6bKZIC3LPK5wOMpI5ygbT2Xk4HKktgBf7kDZZxnda6/G9QDgP/eATXYNHDw2YK4I3Kdn9EgCvqkuQ6rt/+GafFyJ2xLXhmLeCfQrW/Uyr4ZUz/QhkEJ2ynhZA7xdDzQKMSXqoT0P4bJQ=;
X-UUID: 65600fd7992e4f2a941f1790c12fc5eb-20200305
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 205886089; Thu, 05 Mar 2020 10:58:48 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 5 Mar 2020 10:57:54 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 5 Mar 2020 10:58:02 +0800
Message-ID: <1583377126.12083.63.camel@mtkswgap22>
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
Date:   Thu, 5 Mar 2020 10:58:46 +0800
In-Reply-To: <ef4d9d96-df4d-be0c-22af-a97a03c39d3a@linux.intel.com>
References: <1579246910-22736-1-git-send-email-macpaul.lin@mediatek.com>
         <08f69bab-2ada-d6ab-7bf7-d960e9f148a0@linux.intel.com>
         <1580556039.10835.3.camel@mtkswgap22>
         <39ec1610-1686-6509-02ac-6e73d8be2453@linux.intel.com>
         <1583291775.12083.59.camel@mtkswgap22>
         <ef4d9d96-df4d-be0c-22af-a97a03c39d3a@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTAzLTA0IGF0IDE2OjM5ICswMjAwLCBNYXRoaWFzIE55bWFuIHdyb3RlOg0K
PiBPbiA0LjMuMjAyMCA1LjE2LCBNYWNwYXVsIExpbiB3cm90ZToNCj4gPiBPbiBUdWUsIDIwMjAt
MDItMDQgYXQgMTc6NDQgKzA4MDAsIE1hdGhpYXMgTnltYW4gd3JvdGU6DQo+ID4+IE9uIDEuMi4y
MDIwIDEzLjIwLCBNYWNwYXVsIExpbiB3cm90ZToNCj4gPj4+IE9uIEZyaSwgMjAyMC0wMS0zMSBh
dCAxNjo1MCArMDIwMCwgTWF0aGlhcyBOeW1hbiB3cm90ZToNCj4gPj4+PiBPbiAxNy4xLjIwMjAg
OS40MSwgTWFjcGF1bCBMaW4gd3JvdGU6DQo+ID4+Pj4+IEFjY29yZGluZyB0byBOVUxMIHBvaW50
ZXIgZml4OiBodHRwczovL3Rpbnl1cmwuY29tL3VxZnQ1cmENCj4gPj4+Pj4geGhjaTogRml4IE5V
TEwgcG9pbnRlciBkZXJlZmVyZW5jZSB3aXRoIHhoY2lfaXJxKCkgZm9yIHNoYXJlZF9oY2QNCj4g
Pj4+Pj4gVGhlIHNpbWlsYXIgaXNzdWUgaGFzIGFsc28gYmVlbiBmb3VuZCBpbiBRQyBhY3Rpdml0
aWVzIGluIE1lZGlhdGVrLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBIZXJlIHF1b3RlIHRoZSBkZXNjcmlw
dGlvbiBmcm9tIHRoZSByZWZlcmVuY2VkIHBhdGNoIGFzIGZvbGxvd3MuDQo+ID4+Pj4+ICJDb21t
aXQgKCJmMDY4MDkwNDI2ZWEgeGhjaTogRml4IGxlYWtpbmcgVVNCMyBzaGFyZWRfaGNkDQo+ID4+
Pj4+IGF0IHhoY2kgcmVtb3ZhbCIpIHNldHMgeGhjaV9zaGFyZWRfaGNkIHRvIE5VTEwgd2l0aG91
dA0KPiA+Pj4+PiBzdG9wcGluZyB4aGNpIGhvc3QuIFRoaXMgcmVzdWx0cyBpbnRvIGEgcmFjZSBj
b25kaXRpb24NCj4gPj4+Pj4gd2hlcmUgc2hhcmVkX2hjZCAoc3VwZXIgc3BlZWQgcm9vdGh1Yikg
cmVsYXRlZCBpbnRlcnJ1cHRzDQo+ID4+Pj4+IGFyZSBiZWluZyBoYW5kbGVkIHdpdGggeGhjaV9p
cnEgaGFwcGVucyB3aGVuIHRoZQ0KPiA+Pj4+PiB4aGNpX3BsYXRfcmVtb3ZlIGlzIGNhbGxlZCBh
bmQgc2hhcmVkX2hjZCBpcyBzZXQgdG8gTlVMTC4NCj4gPj4+Pj4gRml4IHRoaXMgYnkgc2V0dGlu
ZyB0aGUgc2hhcmVkX2hjZCB0byBOVUxMIG9ubHkgYWZ0ZXIgdGhlDQo+ID4+Pj4+IGNvbnRyb2xs
ZXIgaXMgaGFsdGVkIGFuZCBubyBpbnRlcnJ1cHRzIGFyZSBnZW5lcmF0ZWQuIg0KPiA+Pj4+Pg0K
PiA+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBTcmloYXJzaGEgQWxsZW5raSA8c2FsbGVua2lAY29kZWF1
cm9yYS5vcmc+DQo+ID4+Pj4+IFNpZ25lZC1vZmYtYnk6IE1hY3BhdWwgTGluIDxtYWNwYXVsLmxp
bkBtZWRpYXRlay5jb20+DQo+ID4+Pj4+IC0tLQ0KPiA+Pj4+PiAgICBkcml2ZXJzL3VzYi9ob3N0
L3hoY2ktbXRrLmMgfCAyICstDQo+ID4+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQ0KPiA+Pj4+Pg0KPiA+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy91c2IvaG9zdC94aGNpLW10ay5jIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jDQo+ID4+
Pj4+IGluZGV4IGIxOGE2YmFlZjIwNC4uYzIyN2M2N2Y1ZGM1IDEwMDY0NA0KPiA+Pj4+PiAtLS0g
YS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMNCj4gPj4+Pj4gKysrIGIvZHJpdmVycy91c2Iv
aG9zdC94aGNpLW10ay5jDQo+ID4+Pj4+IEBAIC01OTMsMTEgKzU5MywxMSBAQCBzdGF0aWMgaW50
IHhoY2lfbXRrX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYpDQo+ID4+Pj4+ICAg
IAlzdHJ1Y3QgdXNiX2hjZCAgKnNoYXJlZF9oY2QgPSB4aGNpLT5zaGFyZWRfaGNkOw0KPiA+Pj4+
PiAgICANCj4gPj4+Pj4gICAgCXVzYl9yZW1vdmVfaGNkKHNoYXJlZF9oY2QpOw0KPiA+Pj4+PiAt
CXhoY2ktPnNoYXJlZF9oY2QgPSBOVUxMOw0KPiA+Pj4+PiAgICAJZGV2aWNlX2luaXRfd2FrZXVw
KCZkZXYtPmRldiwgZmFsc2UpOw0KPiA+Pj4+PiAgICANCj4gPj4+Pj4gICAgCXVzYl9yZW1vdmVf
aGNkKGhjZCk7DQo+ID4+Pj4+ICAgIAl1c2JfcHV0X2hjZChzaGFyZWRfaGNkKTsNCj4gPj4+Pj4g
Kwl4aGNpLT5zaGFyZWRfaGNkID0gTlVMTDsNCj4gPj4+Pj4gICAgCXVzYl9wdXRfaGNkKGhjZCk7
DQo+ID4+Pj4+ICAgIAl4aGNpX210a19zY2hfZXhpdChtdGspOw0KPiA+Pj4+PiAgICAJeGhjaV9t
dGtfY2xrc19kaXNhYmxlKG10ayk7DQo+ID4+Pj4+DQo+ID4+Pj4NCj4gPj4+PiBDb3VsZCB5b3Ug
c2hhcmUgZGV0YWlscyBvZiB0aGUgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlLCAoYmFja3RyYWNl
KS4NCj4gPj4+DQo+ID4+PiBUaGlzIGJ1ZyB3YXMgZm91bmQgYnkgb3VyIFFBIHN0YWZmIHdoaWxl
IGRvaW5nIDUwMCB0aW1lcyBwbHVnLWluIGFuZA0KPiA+Pj4gcGx1Zy1vdXQgZGV2aWNlcy4gVGhl
IGJhY2t0cmFjZSBJIGhhdmUgd2FzIHJlY29yZGVkIGJ5IFFBIGFuZCBJIGRpZG4ndA0KPiA+Pj4g
cmVwcm9kdWNlIHRoaXMgaXNzdWUgb24gbXkgb3duIGVudmlyb25tZW50LiBIb3dldmVyLCBhZnRl
ciBhcHBsaWVkIHRoaXMNCj4gPj4+IHBhdGNoIHRoZSBpc3N1ZSBzZWVtcyByZXNvbHZlLiBIZXJl
IGlzIHRoZSBiYWNrdHJhY2U6DQo+ID4+Pg0KPiA+Pj4gRXhjZXB0aW9uIENsYXNzOiBLZXJuZWwg
KEtFKQ0KPiA+Pj4gUEMgaXMgYXQgWzxmZmZmZmY4MDA4Y2NjYmMwPl0geGhjaV9pcnErMHg3Mjgv
MHgyMzY0DQo+ID4+PiBMUiBpcyBhdCBbPGZmZmZmZjgwMDhjY2M3ODg+XSB4aGNpX2lycSsweDJm
MC8weDIzNjQNCj4gPj4+DQo+ID4+PiBDdXJyZW50IEV4ZWN1dGluZyBQcm9jZXNzOg0KPiA+Pj4g
W2lwdGFibGVzLCA4NTldW25ldGRhZ2VudCwgNzcwXQ0KPiA+Pj4NCj4gPj4+IEJhY2t0cmFjZToN
Cj4gPj4+IFs8ZmZmZmZmODAwODBlYWQ1OD5dIF9fYXRvbWljX25vdGlmaWVyX2NhbGxfY2hhaW4r
MHhhOC8weDEzMA0KPiA+Pj4gWzxmZmZmZmY4MDA4MGViNmQ0Pl0gbm90aWZ5X2RpZSsweDg0LzB4
YWMNCj4gPj4+IFs8ZmZmZmZmODAwODA4ZTg3ND5dIGRpZSsweDFkOC8weDNiOA0KPiA+Pj4gWzxm
ZmZmZmY4MDA4MGE4OWIwPl0gX19kb19rZXJuZWxfZmF1bHQrMHgxNzgvMHgxODgNCj4gPj4+IFs8
ZmZmZmZmODAwODBhODFiND5dIGRvX3BhZ2VfZmF1bHQrMHg0NC8weDNiMA0KPiA+Pj4gWzxmZmZm
ZmY4MDA4MGE4MTFjPl0gZG9fdHJhbnNsYXRpb25fZmF1bHQrMHg0NC8weDk4DQo+ID4+PiBbPGZm
ZmZmZjgwMDgwODBlMDg+XSBkb19tZW1fYWJvcnQrMHg0Yy8weDEyOA0KPiA+Pj4gWzxmZmZmZmY4
MDA4MDgzMmQwPl0gZWwxX2RhKzB4MjQvMHgzYw0KPiA+Pj4gWzxmZmZmZmY4MDA4Y2NjYmMwPl0g
eGhjaV9pcnErMHg3MjgvMHgyMzY0DQo+ID4+PiBbPGZmZmZmZjgwMDhjOTg4MDQ+XSB1c2JfaGNk
X2lycSsweDJjLzB4NDQNCj4gPj4+IFs8ZmZmZmZmODAwODE3OWJiMD5dIF9faGFuZGxlX2lycV9l
dmVudF9wZXJjcHUrMHgyNmMvMHg0YTQNCj4gPj4+IFs8ZmZmZmZmODAwODE3OWVjOD5dIGhhbmRs
ZV9pcnFfZXZlbnQrMHg1Yy8weGQwDQo+ID4+PiBbPGZmZmZmZjgwMDgxN2UzYzA+XSBoYW5kbGVf
ZmFzdGVvaV9pcnErMHgxMGMvMHgxZTANCj4gPj4+IFs8ZmZmZmZmODAwODE3ODdiMD5dIF9faGFu
ZGxlX2RvbWFpbl9pcnErMHgzMmMvMHg3MzgNCj4gPj4+IFs8ZmZmZmZmODAwODA4MTU5Yz5dIGdp
Y19oYW5kbGVfaXJxKzB4MTc0LzB4MWM0DQo+ID4+PiBbPGZmZmZmZjgwMDgwODNjZjg+XSBlbDBf
aXJxX25ha2VkKzB4NTAvMHg1Yw0KPiA+Pj4gWzxmZmZmZmZmZmZmZmZmZmZmPl0gMHhmZmZmZmZm
ZmZmZmZmZmZmDQo+ID4+Pg0KPiA+Pg0KPiA+PiBUaGFua3MsDQo+ID4+IENvdWxkIHlvdSBoZWxw
IG1lIGZpbmQgb3V0IHdoaWNoIGxpbmUgb2YgY29kZSB4aGNpX2lycSsweDcyOCBpcyBpbiB5b3Vy
IGNhc2UuDQo+ID4+DQo+ID4+IEFzIEd1ZW50ZXIgcG9pbnRlZCBvdXQgdGhlcmUgaXMgYSByaXNr
IG9mIHR1cm5pbmcgdGhlIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZQ0KPiA+PiBpbnRvIGEgdXNl
IGFmdGVyIGZyZWUgaWYgd2UganVzdCBzb2x2ZSB0aGlzIGJ5IHNldHRpbmcgeGhjaS0+c2hhcmVk
X2hjZCA9IE5VTEwNCj4gPj4gbGF0ZXIuDQo+ID4+DQo+ID4+IElmIHlvdSBzdGlsbCBoYXZlIHRo
YXQga2VybmVsIGFyb3VuZCwgYW5kIHhoY2kgaXMgY29tcGlsZWQgaW46DQo+ID4+IGdkYiB2bWxp
bnV4DQo+ID4+IGdkYiBsaSAqKHhoY2lfaXJxKzB4NzI4KQ0KPiA+Pg0KPiA+IA0KPiA+IFNvcnJ5
IHRoYXQgSSBjb3VsZG4ndCBnZXQgYmFjayB0byB5b3Ugc29vbi4gVGhlIGludGVybmFsIGNvZGUg
dmVyc2lvbg0KPiA+IGZvciB0aGlzIGlzc3VlIHdhcyByZWFsbHkgb2xkIGFuZCBhIGxpdHRsZSBi
aXQgZGlmZmljdWx0IHRvIHJld2luZCB0bw0KPiA+IHRoYXQgdmVyc2lvbi4NCj4gPiBIb3dldmVy
LCBJIHRoaW5rIHRoZSBmb2xsb3dpbmcgZHVtcCBtaWdodCBiZSBjb3JyZWN0IGZvciB0aGUgY29k
ZSBiYXNlLg0KPiA+IA0KPiA+IChnZGIpIGxpICooeGhjaV9pcnErMHg3MjgpDQo+ID4gMHhmZmZm
ZmY4MDA4Y2M4NjM0IGlzIGluIHhoY2lfaXJxICgqc3RyaXBwZWQqDQo+ID4ga2VybmVsLTQuMTQv
ZHJpdmVycy91c2IvaG9zdC94aGNpLmg6MTY5NCkuDQo+ID4gMTY4OSAgICAgKi8NCj4gPiAxNjkw
ICAgICNkZWZpbmUgWEhDSV9NQVhfUkVYSVRfVElNRU9VVF9NUyAgICAgICAyMA0KPiA+IDE2OTEN
Cj4gPiAxNjkyICAgIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IGhjZF9pbmRleChzdHJ1Y3Qg
dXNiX2hjZCAqaGNkKQ0KPiA+IDE2OTMgICAgew0KPiA+IDE2OTQgICAgICAgICAgICBpZiAoaGNk
LT5zcGVlZCA+PSBIQ0RfVVNCMykNCj4gPiAxNjk1ICAgICAgICAgICAgICAgICAgICByZXR1cm4g
MDsNCj4gPiAxNjk2ICAgICAgICAgICAgZWxzZQ0KPiA+IDE2OTcgICAgICAgICAgICAgICAgICAg
IHJldHVybiAxOw0KPiA+IDE2OTggICAgfQ0KPiA+IChnZGIpDQo+ID4gDQo+ID4gVGhhbmtzDQo+
ID4gTWFjcGF1bCBMaW4NCj4gPiANCj4gDQo+IEFoLCBpdCB3YXMgYSA0LjE0IGtlcm5lbC4NCj4g
VGhpcyBzaG91bGQgYmUgZml4ZWQgaW4gNC4yMCB3aXRoIHBhdGNoOg0KPiAxMjQ1Mzc0ZTliODMg
eGhjaTogaGFuZGxlIHBvcnQgc3RhdHVzIGV2ZW50cyBmb3IgcmVtb3ZlZCBVU0IzIGhjZA0KPiAN
Cj4gUG9ydCBhcnJheXMvc3RydWN0dXJlcyB3ZXJlIGNoYW5nZWQgY29tcGxldGVseSBpbiA0LjE4
DQo+IA0KPiBTb21ldGhpbmcgbGlrZSB0aGUgYmVsb3cgc2hvdWxkIHdvcmsgZm9yIDQuMTQ6DQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC94aGNpLXJpbmcuYyBiL2RyaXZlcnMv
dXNiL2hvc3QveGhjaS1yaW5nLmMNCj4gaW5kZXggNjFmYTMwMDdhNzRhLi5lNzM2N2I5ZjE5YzUg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1yaW5nLmMNCj4gKysrIGIvZHJp
dmVycy91c2IvaG9zdC94aGNpLXJpbmcuYw0KPiBAQCAtMTY0MCw2ICsxNjQwLDEyIEBAIHN0YXRp
YyB2b2lkIGhhbmRsZV9wb3J0X3N0YXR1cyhzdHJ1Y3QgeGhjaV9oY2QgKnhoY2ksDQo+ICAJaWYg
KChtYWpvcl9yZXZpc2lvbiA9PSAweDAzKSAhPSAoaGNkLT5zcGVlZCA+PSBIQ0RfVVNCMykpDQo+
ICAJCWhjZCA9IHhoY2ktPnNoYXJlZF9oY2Q7DQo+ICANCj4gKwlpZiAoIWhjZCkgew0KPiArCQl4
aGNpX2RiZyh4aGNpLCAiTm8gaGNkIGZvdW5kIGZvciBwb3J0ICV1IGV2ZW50XG4iLCBwb3J0X2lk
KTsNCj4gKwkJYm9ndXNfcG9ydF9zdGF0dXMgPSB0cnVlOw0KPiArCQlnb3RvIGNsZWFudXA7DQo+
ICsJfQ0KPiArDQo+ICAJaWYgKG1ham9yX3JldmlzaW9uID09IDApIHsNCj4gIAkJeGhjaV93YXJu
KHhoY2ksICJFdmVudCBmb3IgcG9ydCAldSBub3QgaW4gIg0KPiAgCQkJCSJFeHRlbmRlZCBDYXBh
YmlsaXRpZXMsIGlnbm9yaW5nLlxuIiwNCg0KVGhhbmtzIGZvciB0aGlzIHN1Z2dlc3Rpb24sIHRo
aXMgaXMgbXVjaCBiZXR0ZXIhIEkgYW0gc29ycnkgdGhhdCB3ZSdyZQ0KdXNpbmcgYW5kcm9pZCBr
ZXJuZWwgdGhhdCBzb21lIHJlcG9ydGVkIGlzc3VlIG1pZ2h0IGJlIG91dCBvZiBkYXRlLiBJDQp3
aWxsIHVwZGF0ZSB0aGUgc3VnZ2VzdGlvbiBpbnRvIG91ciBjb2RlIGJhc2UuIFRoYW5rcyENCg0K
UmVnYXJkcywNCk1hY3BhdWwgTGluDQoNCg==

