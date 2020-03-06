Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CA7C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 02:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A2120801
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 02:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="AAQ6CTG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgCFCgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 21:36:23 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:43141 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726162AbgCFCgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 21:36:23 -0500
X-UUID: 9cc3b2701f8a4559a2fa5dd77344f4fc-20200306
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=xm6Lh3IOt6rBhv5b30U0fgLekvmN2ICx+5qldR5tZI4=;
        b=AAQ6CTG6kATMMz24ktLahqkzucRleC80edGrEcqu7h+px54917XELT8pJReHvs69D4UZ8RSMyRv2X8CNtccqpvqZYnIma4j2adyTo10sxsuyR/gzRy6C4myjsg0MsdcfPTp8hqGPCPZ/krSBlwfxifEYWxijIRWwSYteepqp+jU=;
X-UUID: 9cc3b2701f8a4559a2fa5dd77344f4fc-20200306
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 505324043; Fri, 06 Mar 2020 10:36:16 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 6 Mar 2020 10:35:19 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 6 Mar 2020 10:35:25 +0800
Message-ID: <1583462174.12083.67.camel@mtkswgap22>
Subject: Re: [PATCH] xhci-mtk: Fix NULL pointer dereference with xhci_irq()
 for shared_hcd
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
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
Date:   Fri, 6 Mar 2020 10:36:14 +0800
In-Reply-To: <20200305183202.GA2107395@kroah.com>
References: <1579246910-22736-1-git-send-email-macpaul.lin@mediatek.com>
         <08f69bab-2ada-d6ab-7bf7-d960e9f148a0@linux.intel.com>
         <1580556039.10835.3.camel@mtkswgap22>
         <39ec1610-1686-6509-02ac-6e73d8be2453@linux.intel.com>
         <1583291775.12083.59.camel@mtkswgap22>
         <ef4d9d96-df4d-be0c-22af-a97a03c39d3a@linux.intel.com>
         <1583377126.12083.63.camel@mtkswgap22> <20200305183202.GA2107395@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTAzLTA1IGF0IDE5OjMyICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IE9uIFRodSwgTWFyIDA1LCAyMDIwIGF0IDEwOjU4OjQ2QU0gKzA4MDAsIE1hY3BhdWwg
TGluIHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAyMC0wMy0wNCBhdCAxNjozOSArMDIwMCwgTWF0aGlh
cyBOeW1hbiB3cm90ZToNCj4gPiA+IE9uIDQuMy4yMDIwIDUuMTYsIE1hY3BhdWwgTGluIHdyb3Rl
Og0KPiA+ID4gPiBPbiBUdWUsIDIwMjAtMDItMDQgYXQgMTc6NDQgKzA4MDAsIE1hdGhpYXMgTnlt
YW4gd3JvdGU6DQo+ID4gPiA+PiBPbiAxLjIuMjAyMCAxMy4yMCwgTWFjcGF1bCBMaW4gd3JvdGU6
DQo+ID4gPiA+Pj4gT24gRnJpLCAyMDIwLTAxLTMxIGF0IDE2OjUwICswMjAwLCBNYXRoaWFzIE55
bWFuIHdyb3RlOg0KPiA+ID4gPj4+PiBPbiAxNy4xLjIwMjAgOS40MSwgTWFjcGF1bCBMaW4gd3Jv
dGU6DQo+ID4gPiA+Pj4+PiBBY2NvcmRpbmcgdG8gTlVMTCBwb2ludGVyIGZpeDogaHR0cHM6Ly90
aW55dXJsLmNvbS91cWZ0NXJhDQo+ID4gPiA+Pj4+PiB4aGNpOiBGaXggTlVMTCBwb2ludGVyIGRl
cmVmZXJlbmNlIHdpdGggeGhjaV9pcnEoKSBmb3Igc2hhcmVkX2hjZA0KPiA+ID4gPj4+Pj4gVGhl
IHNpbWlsYXIgaXNzdWUgaGFzIGFsc28gYmVlbiBmb3VuZCBpbiBRQyBhY3Rpdml0aWVzIGluIE1l
ZGlhdGVrLg0KPiA+ID4gPj4+Pj4NCj4gPiA+ID4+Pj4+IEhlcmUgcXVvdGUgdGhlIGRlc2NyaXB0
aW9uIGZyb20gdGhlIHJlZmVyZW5jZWQgcGF0Y2ggYXMgZm9sbG93cy4NCj4gPiA+ID4+Pj4+ICJD
b21taXQgKCJmMDY4MDkwNDI2ZWEgeGhjaTogRml4IGxlYWtpbmcgVVNCMyBzaGFyZWRfaGNkDQo+
ID4gPiA+Pj4+PiBhdCB4aGNpIHJlbW92YWwiKSBzZXRzIHhoY2lfc2hhcmVkX2hjZCB0byBOVUxM
IHdpdGhvdXQNCj4gPiA+ID4+Pj4+IHN0b3BwaW5nIHhoY2kgaG9zdC4gVGhpcyByZXN1bHRzIGlu
dG8gYSByYWNlIGNvbmRpdGlvbg0KPiA+ID4gPj4+Pj4gd2hlcmUgc2hhcmVkX2hjZCAoc3VwZXIg
c3BlZWQgcm9vdGh1YikgcmVsYXRlZCBpbnRlcnJ1cHRzDQo+ID4gPiA+Pj4+PiBhcmUgYmVpbmcg
aGFuZGxlZCB3aXRoIHhoY2lfaXJxIGhhcHBlbnMgd2hlbiB0aGUNCj4gPiA+ID4+Pj4+IHhoY2lf
cGxhdF9yZW1vdmUgaXMgY2FsbGVkIGFuZCBzaGFyZWRfaGNkIGlzIHNldCB0byBOVUxMLg0KPiA+
ID4gPj4+Pj4gRml4IHRoaXMgYnkgc2V0dGluZyB0aGUgc2hhcmVkX2hjZCB0byBOVUxMIG9ubHkg
YWZ0ZXIgdGhlDQo+ID4gPiA+Pj4+PiBjb250cm9sbGVyIGlzIGhhbHRlZCBhbmQgbm8gaW50ZXJy
dXB0cyBhcmUgZ2VuZXJhdGVkLiINCj4gPiA+ID4+Pj4+DQo+ID4gPiA+Pj4+PiBTaWduZWQtb2Zm
LWJ5OiBTcmloYXJzaGEgQWxsZW5raSA8c2FsbGVua2lAY29kZWF1cm9yYS5vcmc+DQo+ID4gPiA+
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBNYWNwYXVsIExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29t
Pg0KPiA+ID4gPj4+Pj4gLS0tDQo+ID4gPiA+Pj4+PiAgICBkcml2ZXJzL3VzYi9ob3N0L3hoY2kt
bXRrLmMgfCAyICstDQo+ID4gPiA+Pj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4+Pj4+DQo+ID4gPiA+Pj4+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5j
DQo+ID4gPiA+Pj4+PiBpbmRleCBiMThhNmJhZWYyMDQuLmMyMjdjNjdmNWRjNSAxMDA2NDQNCj4g
PiA+ID4+Pj4+IC0tLSBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGsuYw0KPiA+ID4gPj4+Pj4g
KysrIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jDQo+ID4gPiA+Pj4+PiBAQCAtNTkzLDEx
ICs1OTMsMTEgQEAgc3RhdGljIGludCB4aGNpX210a19yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqZGV2KQ0KPiA+ID4gPj4+Pj4gICAgCXN0cnVjdCB1c2JfaGNkICAqc2hhcmVkX2hjZCA9
IHhoY2ktPnNoYXJlZF9oY2Q7DQo+ID4gPiA+Pj4+PiAgICANCj4gPiA+ID4+Pj4+ICAgIAl1c2Jf
cmVtb3ZlX2hjZChzaGFyZWRfaGNkKTsNCj4gPiA+ID4+Pj4+IC0JeGhjaS0+c2hhcmVkX2hjZCA9
IE5VTEw7DQo+ID4gPiA+Pj4+PiAgICAJZGV2aWNlX2luaXRfd2FrZXVwKCZkZXYtPmRldiwgZmFs
c2UpOw0KPiA+ID4gPj4+Pj4gICAgDQo+ID4gPiA+Pj4+PiAgICAJdXNiX3JlbW92ZV9oY2QoaGNk
KTsNCj4gPiA+ID4+Pj4+ICAgIAl1c2JfcHV0X2hjZChzaGFyZWRfaGNkKTsNCj4gPiA+ID4+Pj4+
ICsJeGhjaS0+c2hhcmVkX2hjZCA9IE5VTEw7DQo+ID4gPiA+Pj4+PiAgICAJdXNiX3B1dF9oY2Qo
aGNkKTsNCj4gPiA+ID4+Pj4+ICAgIAl4aGNpX210a19zY2hfZXhpdChtdGspOw0KPiA+ID4gPj4+
Pj4gICAgCXhoY2lfbXRrX2Nsa3NfZGlzYWJsZShtdGspOw0KPiA+ID4gPj4+Pj4NCj4gPiA+ID4+
Pj4NCj4gPiA+ID4+Pj4gQ291bGQgeW91IHNoYXJlIGRldGFpbHMgb2YgdGhlIE5VTEwgcG9pbnRl
ciBkZXJlZmVyZW5jZSwgKGJhY2t0cmFjZSkuDQo+ID4gPiA+Pj4NCj4gPiA+ID4+PiBUaGlzIGJ1
ZyB3YXMgZm91bmQgYnkgb3VyIFFBIHN0YWZmIHdoaWxlIGRvaW5nIDUwMCB0aW1lcyBwbHVnLWlu
IGFuZA0KPiA+ID4gPj4+IHBsdWctb3V0IGRldmljZXMuIFRoZSBiYWNrdHJhY2UgSSBoYXZlIHdh
cyByZWNvcmRlZCBieSBRQSBhbmQgSSBkaWRuJ3QNCj4gPiA+ID4+PiByZXByb2R1Y2UgdGhpcyBp
c3N1ZSBvbiBteSBvd24gZW52aXJvbm1lbnQuIEhvd2V2ZXIsIGFmdGVyIGFwcGxpZWQgdGhpcw0K
PiA+ID4gPj4+IHBhdGNoIHRoZSBpc3N1ZSBzZWVtcyByZXNvbHZlLiBIZXJlIGlzIHRoZSBiYWNr
dHJhY2U6DQo+ID4gPiA+Pj4NCj4gPiA+ID4+PiBFeGNlcHRpb24gQ2xhc3M6IEtlcm5lbCAoS0Up
DQo+ID4gPiA+Pj4gUEMgaXMgYXQgWzxmZmZmZmY4MDA4Y2NjYmMwPl0geGhjaV9pcnErMHg3Mjgv
MHgyMzY0DQo+ID4gPiA+Pj4gTFIgaXMgYXQgWzxmZmZmZmY4MDA4Y2NjNzg4Pl0geGhjaV9pcnEr
MHgyZjAvMHgyMzY0DQo+ID4gPiA+Pj4NCj4gPiA+ID4+PiBDdXJyZW50IEV4ZWN1dGluZyBQcm9j
ZXNzOg0KPiA+ID4gPj4+IFtpcHRhYmxlcywgODU5XVtuZXRkYWdlbnQsIDc3MF0NCj4gPiA+ID4+
Pg0KPiA+ID4gPj4+IEJhY2t0cmFjZToNCj4gPiA+ID4+PiBbPGZmZmZmZjgwMDgwZWFkNTg+XSBf
X2F0b21pY19ub3RpZmllcl9jYWxsX2NoYWluKzB4YTgvMHgxMzANCj4gPiA+ID4+PiBbPGZmZmZm
ZjgwMDgwZWI2ZDQ+XSBub3RpZnlfZGllKzB4ODQvMHhhYw0KPiA+ID4gPj4+IFs8ZmZmZmZmODAw
ODA4ZTg3ND5dIGRpZSsweDFkOC8weDNiOA0KPiA+ID4gPj4+IFs8ZmZmZmZmODAwODBhODliMD5d
IF9fZG9fa2VybmVsX2ZhdWx0KzB4MTc4LzB4MTg4DQo+ID4gPiA+Pj4gWzxmZmZmZmY4MDA4MGE4
MWI0Pl0gZG9fcGFnZV9mYXVsdCsweDQ0LzB4M2IwDQo+ID4gPiA+Pj4gWzxmZmZmZmY4MDA4MGE4
MTFjPl0gZG9fdHJhbnNsYXRpb25fZmF1bHQrMHg0NC8weDk4DQo+ID4gPiA+Pj4gWzxmZmZmZmY4
MDA4MDgwZTA4Pl0gZG9fbWVtX2Fib3J0KzB4NGMvMHgxMjgNCj4gPiA+ID4+PiBbPGZmZmZmZjgw
MDgwODMyZDA+XSBlbDFfZGErMHgyNC8weDNjDQo+ID4gPiA+Pj4gWzxmZmZmZmY4MDA4Y2NjYmMw
Pl0geGhjaV9pcnErMHg3MjgvMHgyMzY0DQo+ID4gPiA+Pj4gWzxmZmZmZmY4MDA4Yzk4ODA0Pl0g
dXNiX2hjZF9pcnErMHgyYy8weDQ0DQo+ID4gPiA+Pj4gWzxmZmZmZmY4MDA4MTc5YmIwPl0gX19o
YW5kbGVfaXJxX2V2ZW50X3BlcmNwdSsweDI2Yy8weDRhNA0KPiA+ID4gPj4+IFs8ZmZmZmZmODAw
ODE3OWVjOD5dIGhhbmRsZV9pcnFfZXZlbnQrMHg1Yy8weGQwDQo+ID4gPiA+Pj4gWzxmZmZmZmY4
MDA4MTdlM2MwPl0gaGFuZGxlX2Zhc3Rlb2lfaXJxKzB4MTBjLzB4MWUwDQo+ID4gPiA+Pj4gWzxm
ZmZmZmY4MDA4MTc4N2IwPl0gX19oYW5kbGVfZG9tYWluX2lycSsweDMyYy8weDczOA0KPiA+ID4g
Pj4+IFs8ZmZmZmZmODAwODA4MTU5Yz5dIGdpY19oYW5kbGVfaXJxKzB4MTc0LzB4MWM0DQo+ID4g
PiA+Pj4gWzxmZmZmZmY4MDA4MDgzY2Y4Pl0gZWwwX2lycV9uYWtlZCsweDUwLzB4NWMNCj4gPiA+
ID4+PiBbPGZmZmZmZmZmZmZmZmZmZmY+XSAweGZmZmZmZmZmZmZmZmZmZmYNCj4gPiA+ID4+Pg0K
PiA+ID4gPj4NCj4gPiA+ID4+IFRoYW5rcywNCj4gPiA+ID4+IENvdWxkIHlvdSBoZWxwIG1lIGZp
bmQgb3V0IHdoaWNoIGxpbmUgb2YgY29kZSB4aGNpX2lycSsweDcyOCBpcyBpbiB5b3VyIGNhc2Uu
DQo+ID4gPiA+Pg0KPiA+ID4gPj4gQXMgR3VlbnRlciBwb2ludGVkIG91dCB0aGVyZSBpcyBhIHJp
c2sgb2YgdHVybmluZyB0aGUgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlDQo+ID4gPiA+PiBpbnRv
IGEgdXNlIGFmdGVyIGZyZWUgaWYgd2UganVzdCBzb2x2ZSB0aGlzIGJ5IHNldHRpbmcgeGhjaS0+
c2hhcmVkX2hjZCA9IE5VTEwNCj4gPiA+ID4+IGxhdGVyLg0KPiA+ID4gPj4NCj4gPiA+ID4+IElm
IHlvdSBzdGlsbCBoYXZlIHRoYXQga2VybmVsIGFyb3VuZCwgYW5kIHhoY2kgaXMgY29tcGlsZWQg
aW46DQo+ID4gPiA+PiBnZGIgdm1saW51eA0KPiA+ID4gPj4gZ2RiIGxpICooeGhjaV9pcnErMHg3
MjgpDQo+ID4gPiA+Pg0KPiA+ID4gPiANCj4gPiA+ID4gU29ycnkgdGhhdCBJIGNvdWxkbid0IGdl
dCBiYWNrIHRvIHlvdSBzb29uLiBUaGUgaW50ZXJuYWwgY29kZSB2ZXJzaW9uDQo+ID4gPiA+IGZv
ciB0aGlzIGlzc3VlIHdhcyByZWFsbHkgb2xkIGFuZCBhIGxpdHRsZSBiaXQgZGlmZmljdWx0IHRv
IHJld2luZCB0bw0KPiA+ID4gPiB0aGF0IHZlcnNpb24uDQo+ID4gPiA+IEhvd2V2ZXIsIEkgdGhp
bmsgdGhlIGZvbGxvd2luZyBkdW1wIG1pZ2h0IGJlIGNvcnJlY3QgZm9yIHRoZSBjb2RlIGJhc2Uu
DQo+ID4gPiA+IA0KPiA+ID4gPiAoZ2RiKSBsaSAqKHhoY2lfaXJxKzB4NzI4KQ0KPiA+ID4gPiAw
eGZmZmZmZjgwMDhjYzg2MzQgaXMgaW4geGhjaV9pcnEgKCpzdHJpcHBlZCoNCj4gPiA+ID4ga2Vy
bmVsLTQuMTQvZHJpdmVycy91c2IvaG9zdC94aGNpLmg6MTY5NCkuDQo+ID4gPiA+IDE2ODkgICAg
ICovDQo+ID4gPiA+IDE2OTAgICAgI2RlZmluZSBYSENJX01BWF9SRVhJVF9USU1FT1VUX01TICAg
ICAgIDIwDQo+ID4gPiA+IDE2OTENCj4gPiA+ID4gMTY5MiAgICBzdGF0aWMgaW5saW5lIHVuc2ln
bmVkIGludCBoY2RfaW5kZXgoc3RydWN0IHVzYl9oY2QgKmhjZCkNCj4gPiA+ID4gMTY5MyAgICB7
DQo+ID4gPiA+IDE2OTQgICAgICAgICAgICBpZiAoaGNkLT5zcGVlZCA+PSBIQ0RfVVNCMykNCj4g
PiA+ID4gMTY5NSAgICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gPiA+IDE2OTYgICAg
ICAgICAgICBlbHNlDQo+ID4gPiA+IDE2OTcgICAgICAgICAgICAgICAgICAgIHJldHVybiAxOw0K
PiA+ID4gPiAxNjk4ICAgIH0NCj4gPiA+ID4gKGdkYikNCj4gPiA+ID4gDQo+ID4gPiA+IFRoYW5r
cw0KPiA+ID4gPiBNYWNwYXVsIExpbg0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gQWgsIGl0IHdh
cyBhIDQuMTQga2VybmVsLg0KPiA+ID4gVGhpcyBzaG91bGQgYmUgZml4ZWQgaW4gNC4yMCB3aXRo
IHBhdGNoOg0KPiA+ID4gMTI0NTM3NGU5YjgzIHhoY2k6IGhhbmRsZSBwb3J0IHN0YXR1cyBldmVu
dHMgZm9yIHJlbW92ZWQgVVNCMyBoY2QNCj4gPiA+IA0KPiA+ID4gUG9ydCBhcnJheXMvc3RydWN0
dXJlcyB3ZXJlIGNoYW5nZWQgY29tcGxldGVseSBpbiA0LjE4DQo+ID4gPiANCj4gPiA+IFNvbWV0
aGluZyBsaWtlIHRoZSBiZWxvdyBzaG91bGQgd29yayBmb3IgNC4xNDoNCj4gPiA+IA0KPiA+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1yaW5nLmMgYi9kcml2ZXJzL3VzYi9o
b3N0L3hoY2ktcmluZy5jDQo+ID4gPiBpbmRleCA2MWZhMzAwN2E3NGEuLmU3MzY3YjlmMTljNSAx
MDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1yaW5nLmMNCj4gPiA+ICsr
KyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1yaW5nLmMNCj4gPiA+IEBAIC0xNjQwLDYgKzE2NDAs
MTIgQEAgc3RhdGljIHZvaWQgaGFuZGxlX3BvcnRfc3RhdHVzKHN0cnVjdCB4aGNpX2hjZCAqeGhj
aSwNCj4gPiA+ICAJaWYgKChtYWpvcl9yZXZpc2lvbiA9PSAweDAzKSAhPSAoaGNkLT5zcGVlZCA+
PSBIQ0RfVVNCMykpDQo+ID4gPiAgCQloY2QgPSB4aGNpLT5zaGFyZWRfaGNkOw0KPiA+ID4gIA0K
PiA+ID4gKwlpZiAoIWhjZCkgew0KPiA+ID4gKwkJeGhjaV9kYmcoeGhjaSwgIk5vIGhjZCBmb3Vu
ZCBmb3IgcG9ydCAldSBldmVudFxuIiwgcG9ydF9pZCk7DQo+ID4gPiArCQlib2d1c19wb3J0X3N0
YXR1cyA9IHRydWU7DQo+ID4gPiArCQlnb3RvIGNsZWFudXA7DQo+ID4gPiArCX0NCj4gPiA+ICsN
Cj4gPiA+ICAJaWYgKG1ham9yX3JldmlzaW9uID09IDApIHsNCj4gPiA+ICAJCXhoY2lfd2Fybih4
aGNpLCAiRXZlbnQgZm9yIHBvcnQgJXUgbm90IGluICINCj4gPiA+ICAJCQkJIkV4dGVuZGVkIENh
cGFiaWxpdGllcywgaWdub3JpbmcuXG4iLA0KPiA+IA0KPiA+IFRoYW5rcyBmb3IgdGhpcyBzdWdn
ZXN0aW9uLCB0aGlzIGlzIG11Y2ggYmV0dGVyISBJIGFtIHNvcnJ5IHRoYXQgd2UncmUNCj4gPiB1
c2luZyBhbmRyb2lkIGtlcm5lbCB0aGF0IHNvbWUgcmVwb3J0ZWQgaXNzdWUgbWlnaHQgYmUgb3V0
IG9mIGRhdGUuIEkNCj4gPiB3aWxsIHVwZGF0ZSB0aGUgc3VnZ2VzdGlvbiBpbnRvIG91ciBjb2Rl
IGJhc2UuIFRoYW5rcyENCj4gDQo+IFNob3VsZCBJIGJhY2twb3J0IHRoaXMgdG8gNC4xNCBhbmQg
b2xkZXIga2VybmVscyB0byBwcmV2ZW50IHRoaXMgaXNzdWUNCj4gZnJvbSBzaG93aW5nIHVwIGlu
IG5ld2VyIEFuZHJvaWQgZGV2aWNlcyB0aGF0IGFyZSB1c2luZyB0aGVzZSBvbGRlcg0KPiBrZXJu
ZWxzPw0KPiANCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg0KSWYgdGhpcyBjb3VsZCBiZSBi
YWNrcG9ydGVkIHRvIG9sZGVyIGtlcm5lbCB0aGF0IHdpbGwgYmUgZ3JlYXQgZm9yIG5ld2VyDQpB
bmRyb2lkIGRldmljZXMuIFNvbWUgb2YgdGhlIHNoaXBwaW5nIGRldmljZXMgd2lsbCBoYXZlIHJl
cXVpcmVtZW50IG9mDQprZXJuZWwgdXBncmFkZS4gSGVuY2UgaWYgeW91IGNvdWxkIGJhY2twb3J0
IHRoaXMgcGF0Y2ggd2lsbCBiZSBncmVhdC4NCg0KVGhhbmtzIQ0KDQpSZWdhcmRzLA0KTWFjcGF1
bCBMaW4NCg==

