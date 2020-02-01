Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E5AC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 11:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD31206E6
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 11:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="okgZ6fLQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgBALUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 06:20:49 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:4717 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726265AbgBALUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 06:20:49 -0500
X-UUID: ff97da01dd944c2c9f0feda24c8c3132-20200201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=XTEY6dMzjjkyr9jLk6HV6IbqAj2VEs2vvVsCYlO1zCo=;
        b=okgZ6fLQhJowbyiwEa9oqF6V0EM8nHcd6fUReOIUAHLh9aMwO41MwLkvJyJ+PcDmG2PeGaFSoKMaBeciMpt+/YB8XPq2nxr175dBiTaVGXF9EDUrD+uZaQUyhCO1KaduCjEoxQiGaN3r6vWpa8VENhlB2KrDb3R8rf9OSCN/M88=;
X-UUID: ff97da01dd944c2c9f0feda24c8c3132-20200201
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1575815744; Sat, 01 Feb 2020 19:20:40 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 1 Feb 2020 19:20:01 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 1 Feb 2020 19:18:14 +0800
Message-ID: <1580556039.10835.3.camel@mtkswgap22>
Subject: Re: [PATCH] xhci-mtk: Fix NULL pointer dereference with xhci_irq()
 for shared_hcd
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Chunfeng Yun" <chunfeng.yun@mediatek.com>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Sriharsha Allenki <sallenki@codeaurora.org>
Date:   Sat, 1 Feb 2020 19:20:39 +0800
In-Reply-To: <08f69bab-2ada-d6ab-7bf7-d960e9f148a0@linux.intel.com>
References: <1579246910-22736-1-git-send-email-macpaul.lin@mediatek.com>
         <08f69bab-2ada-d6ab-7bf7-d960e9f148a0@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTAxLTMxIGF0IDE2OjUwICswMjAwLCBNYXRoaWFzIE55bWFuIHdyb3RlOg0K
PiBPbiAxNy4xLjIwMjAgOS40MSwgTWFjcGF1bCBMaW4gd3JvdGU6DQo+ID4gQWNjb3JkaW5nIHRv
IE5VTEwgcG9pbnRlciBmaXg6IGh0dHBzOi8vdGlueXVybC5jb20vdXFmdDVyYQ0KPiA+IHhoY2k6
IEZpeCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2Ugd2l0aCB4aGNpX2lycSgpIGZvciBzaGFyZWRf
aGNkDQo+ID4gVGhlIHNpbWlsYXIgaXNzdWUgaGFzIGFsc28gYmVlbiBmb3VuZCBpbiBRQyBhY3Rp
dml0aWVzIGluIE1lZGlhdGVrLg0KPiA+IA0KPiA+IEhlcmUgcXVvdGUgdGhlIGRlc2NyaXB0aW9u
IGZyb20gdGhlIHJlZmVyZW5jZWQgcGF0Y2ggYXMgZm9sbG93cy4NCj4gPiAiQ29tbWl0ICgiZjA2
ODA5MDQyNmVhIHhoY2k6IEZpeCBsZWFraW5nIFVTQjMgc2hhcmVkX2hjZA0KPiA+IGF0IHhoY2kg
cmVtb3ZhbCIpIHNldHMgeGhjaV9zaGFyZWRfaGNkIHRvIE5VTEwgd2l0aG91dA0KPiA+IHN0b3Bw
aW5nIHhoY2kgaG9zdC4gVGhpcyByZXN1bHRzIGludG8gYSByYWNlIGNvbmRpdGlvbg0KPiA+IHdo
ZXJlIHNoYXJlZF9oY2QgKHN1cGVyIHNwZWVkIHJvb3RodWIpIHJlbGF0ZWQgaW50ZXJydXB0cw0K
PiA+IGFyZSBiZWluZyBoYW5kbGVkIHdpdGggeGhjaV9pcnEgaGFwcGVucyB3aGVuIHRoZQ0KPiA+
IHhoY2lfcGxhdF9yZW1vdmUgaXMgY2FsbGVkIGFuZCBzaGFyZWRfaGNkIGlzIHNldCB0byBOVUxM
Lg0KPiA+IEZpeCB0aGlzIGJ5IHNldHRpbmcgdGhlIHNoYXJlZF9oY2QgdG8gTlVMTCBvbmx5IGFm
dGVyIHRoZQ0KPiA+IGNvbnRyb2xsZXIgaXMgaGFsdGVkIGFuZCBubyBpbnRlcnJ1cHRzIGFyZSBn
ZW5lcmF0ZWQuIg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFNyaWhhcnNoYSBBbGxlbmtpIDxz
YWxsZW5raUBjb2RlYXVyb3JhLm9yZz4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYWNwYXVsIExpbiA8
bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy91c2IvaG9z
dC94aGNpLW10ay5jIHwgMiArLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3Qv
eGhjaS1tdGsuYyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGsuYw0KPiA+IGluZGV4IGIxOGE2
YmFlZjIwNC4uYzIyN2M2N2Y1ZGM1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2hvc3Qv
eGhjaS1tdGsuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGsuYw0KPiA+IEBA
IC01OTMsMTEgKzU5MywxMSBAQCBzdGF0aWMgaW50IHhoY2lfbXRrX3JlbW92ZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpkZXYpDQo+ID4gICAJc3RydWN0IHVzYl9oY2QgICpzaGFyZWRfaGNkID0g
eGhjaS0+c2hhcmVkX2hjZDsNCj4gPiAgIA0KPiA+ICAgCXVzYl9yZW1vdmVfaGNkKHNoYXJlZF9o
Y2QpOw0KPiA+IC0JeGhjaS0+c2hhcmVkX2hjZCA9IE5VTEw7DQo+ID4gICAJZGV2aWNlX2luaXRf
d2FrZXVwKCZkZXYtPmRldiwgZmFsc2UpOw0KPiA+ICAgDQo+ID4gICAJdXNiX3JlbW92ZV9oY2Qo
aGNkKTsNCj4gPiAgIAl1c2JfcHV0X2hjZChzaGFyZWRfaGNkKTsNCj4gPiArCXhoY2ktPnNoYXJl
ZF9oY2QgPSBOVUxMOw0KPiA+ICAgCXVzYl9wdXRfaGNkKGhjZCk7DQo+ID4gICAJeGhjaV9tdGtf
c2NoX2V4aXQobXRrKTsNCj4gPiAgIAl4aGNpX210a19jbGtzX2Rpc2FibGUobXRrKTsNCj4gPiAN
Cj4gDQo+IENvdWxkIHlvdSBzaGFyZSBkZXRhaWxzIG9mIHRoZSBOVUxMIHBvaW50ZXIgZGVyZWZl
cmVuY2UsIChiYWNrdHJhY2UpLg0KDQpUaGlzIGJ1ZyB3YXMgZm91bmQgYnkgb3VyIFFBIHN0YWZm
IHdoaWxlIGRvaW5nIDUwMCB0aW1lcyBwbHVnLWluIGFuZA0KcGx1Zy1vdXQgZGV2aWNlcy4gVGhl
IGJhY2t0cmFjZSBJIGhhdmUgd2FzIHJlY29yZGVkIGJ5IFFBIGFuZCBJIGRpZG4ndA0KcmVwcm9k
dWNlIHRoaXMgaXNzdWUgb24gbXkgb3duIGVudmlyb25tZW50LiBIb3dldmVyLCBhZnRlciBhcHBs
aWVkIHRoaXMNCnBhdGNoIHRoZSBpc3N1ZSBzZWVtcyByZXNvbHZlLiBIZXJlIGlzIHRoZSBiYWNr
dHJhY2U6DQoNCkV4Y2VwdGlvbiBDbGFzczogS2VybmVsIChLRSkNClBDIGlzIGF0IFs8ZmZmZmZm
ODAwOGNjY2JjMD5dIHhoY2lfaXJxKzB4NzI4LzB4MjM2NA0KTFIgaXMgYXQgWzxmZmZmZmY4MDA4
Y2NjNzg4Pl0geGhjaV9pcnErMHgyZjAvMHgyMzY0DQoNCkN1cnJlbnQgRXhlY3V0aW5nIFByb2Nl
c3M6DQpbaXB0YWJsZXMsIDg1OV1bbmV0ZGFnZW50LCA3NzBdDQoNCkJhY2t0cmFjZToNCls8ZmZm
ZmZmODAwODBlYWQ1OD5dIF9fYXRvbWljX25vdGlmaWVyX2NhbGxfY2hhaW4rMHhhOC8weDEzMCAg
IA0KWzxmZmZmZmY4MDA4MGViNmQ0Pl0gbm90aWZ5X2RpZSsweDg0LzB4YWMgICAgICANCls8ZmZm
ZmZmODAwODA4ZTg3ND5dIGRpZSsweDFkOC8weDNiOCAgIA0KWzxmZmZmZmY4MDA4MGE4OWIwPl0g
X19kb19rZXJuZWxfZmF1bHQrMHgxNzgvMHgxODggICAgIA0KWzxmZmZmZmY4MDA4MGE4MWI0Pl0g
ZG9fcGFnZV9mYXVsdCsweDQ0LzB4M2IwICANCls8ZmZmZmZmODAwODBhODExYz5dIGRvX3RyYW5z
bGF0aW9uX2ZhdWx0KzB4NDQvMHg5OCAgICANCls8ZmZmZmZmODAwODA4MGUwOD5dIGRvX21lbV9h
Ym9ydCsweDRjLzB4MTI4ICAgDQpbPGZmZmZmZjgwMDgwODMyZDA+XSBlbDFfZGErMHgyNC8weDNj
ICANCls8ZmZmZmZmODAwOGNjY2JjMD5dIHhoY2lfaXJxKzB4NzI4LzB4MjM2NCAgICAgDQpbPGZm
ZmZmZjgwMDhjOTg4MDQ+XSB1c2JfaGNkX2lycSsweDJjLzB4NDQgICAgIA0KWzxmZmZmZmY4MDA4
MTc5YmIwPl0gX19oYW5kbGVfaXJxX2V2ZW50X3BlcmNwdSsweDI2Yy8weDRhNCAgICAgDQpbPGZm
ZmZmZjgwMDgxNzllYzg+XSBoYW5kbGVfaXJxX2V2ZW50KzB4NWMvMHhkMA0KWzxmZmZmZmY4MDA4
MTdlM2MwPl0gaGFuZGxlX2Zhc3Rlb2lfaXJxKzB4MTBjLzB4MWUwICAgIA0KWzxmZmZmZmY4MDA4
MTc4N2IwPl0gX19oYW5kbGVfZG9tYWluX2lycSsweDMyYy8weDczOCAgIA0KWzxmZmZmZmY4MDA4
MDgxNTljPl0gZ2ljX2hhbmRsZV9pcnErMHgxNzQvMHgxYzQNCls8ZmZmZmZmODAwODA4M2NmOD5d
IGVsMF9pcnFfbmFrZWQrMHg1MC8weDVjICAgDQpbPGZmZmZmZmZmZmZmZmZmZmY+XSAweGZmZmZm
ZmZmZmZmZmZmZmYNCg0KPiBUaGUgVVNCMyBoY2QgaXMgYWxyZWFkeSByZW1vdmVkIHdoZW4geGhj
aS0+c2hhcmVkX2hjZCBpcyBzZXQgdG8gTlVMTC4NCj4gV2UgbWlnaHQgd2FudCB0byBhZGQgc29t
ZSBjaGVja3MgdG8gbWFrZSBzdXJlIHdlIGFyZSBub3QgdXNpbmcgdGhlIHJlbW92ZWQNCj4gaGNk
IGFueW1vcmUgaW4gdGhhdCBjb2RlcGF0aCBhbnltb3JlLg0KPiANCj4gLU1hdGhpYXMNCg0KVGhh
bmtzLA0KTWFjcGF1bCBMaW4NCg0K

