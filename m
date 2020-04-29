Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C21C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 07:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 765982076B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 07:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgD2H5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 03:57:06 -0400
Received: from mx-relay78-hz1.antispameurope.com ([94.100.133.239]:37890 "EHLO
        mx-relay78-hz1.antispameurope.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726381AbgD2H5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 03:57:06 -0400
X-Greylist: delayed 351 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Apr 2020 03:57:03 EDT
Received: from mailgw1.iis.fraunhofer.de ([153.96.172.4]) by mx-relay78-hz1.antispameurope.com;
 Wed, 29 Apr 2020 09:51:10 +0200
Received: from mail.iis.fraunhofer.de (mail01.iis.fhg.de [153.96.171.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.iis.fraunhofer.de (Postfix) with ESMTPS id A532B2400082;
        Wed, 29 Apr 2020 09:51:02 +0200 (CEST)
Received: from mail01.iis.fhg.de (2001:638:a0a:1111:fd91:8c2a:e4a5:e74e) by
 mail01.iis.fhg.de (2001:638:a0a:1111:fd91:8c2a:e4a5:e74e) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Wed, 29 Apr 2020 09:51:02 +0200
Received: from mail01.iis.fhg.de ([fe80::fd91:8c2a:e4a5:e74e]) by
 mail01.iis.fhg.de ([fe80::fd91:8c2a:e4a5:e74e%12]) with mapi id
 15.00.1395.000; Wed, 29 Apr 2020 09:51:02 +0200
From:   "Stahl, Manuel" <manuel.stahl@iis-extern.fraunhofer.de>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "Stahl, Manuel" <manuel.stahl@iis-extern.fraunhofer.de>,
        "sojkam1@fel.cvut.cz" <sojkam1@fel.cvut.cz>
Subject: Re: [PATCH v4] Add new uio device for PCI with dynamic memory
 allocation
Thread-Topic: [PATCH v4] Add new uio device for PCI with dynamic memory
 allocation
Thread-Index: AQHWFA15mQXQpLHKR0emWdXVXY2Gm6iOf4GAgAEst4A=
Date:   Wed, 29 Apr 2020 07:51:01 +0000
Message-ID: <eb405ab3782844e379629a655a3dcaf38dd2552d.camel@iis-extern.fraunhofer.de>
References: <1507296707.2915.14.camel@iis-extern.fraunhofer.de>
         <20200416163830.30623-1-manuel.stahl@iis-extern.fraunhofer.de>
         <20200428135443.GA1437053@kroah.com>
In-Reply-To: <20200428135443.GA1437053@kroah.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [153.96.171.210]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB6D30FED112BA498DF5E122F00C71C2@iis.fhg.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-cloud-security-sender: manuel.stahl@iis-extern.fraunhofer.de
X-cloud-security-recipient: linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay78-hz1.antispameurope.com with F356414813EE
X-cloud-security-connect: mailgw1.iis.fraunhofer.de[153.96.172.4], TLS=1, IP=153.96.172.4
X-cloud-security: scantime:.2600
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRGksIDIwMjAtMDQtMjggYXQgMTU6NTQgKzAyMDAsIGdyZWdraCBAIGxpbnV4Zm91bmRhdGlv
biAuIG9yZyB3cm90ZToNCj4gT24gVGh1LCBBcHIgMTYsIDIwMjAgYXQgMDY6Mzg6MzBQTSArMDIw
MCwgTWFudWVsIFN0YWhsIHdyb3RlOg0KPiA+IA0KPiA+ICsgKg0KPiA+ICsgKiBTaW5jZSB0aGUg
ZHJpdmVyIGRvZXMgbm90IGRlY2xhcmUgYW55IGRldmljZSBpZHMsIHlvdSBtdXN0IGFsbG9jYXRl
DQo+ID4gKyAqIGlkIGFuZCBiaW5kIHRoZSBkZXZpY2UgdG8gdGhlIGRyaXZlciB5b3Vyc2VsZi4g
IEZvciBleGFtcGxlOg0KPiA+ICsgKg0KPiA+ICsgKiAjIGVjaG8gIjgwODYgMTBmNSIgPiAvc3lz
L2J1cy9wY2kvZHJpdmVycy91aW9fcGNpX2RtZW1fZ2VuaXJxL25ld19pZA0KPiA+ICsgKiAjIGVj
aG8gLW4gMDAwMDowMDoxOS4wID4gL3N5cy9idXMvcGNpL2RyaXZlcnMvZTEwMDBlL3VuYmluZA0K
PiA+ICsgKiAjIGVjaG8gLW4gMDAwMDowMDoxOS4wID4gL3N5cy9idXMvcGNpL2RyaXZlcnMvdWlv
X3BjaV9kbWVtX2dlbmlycS9iaW5kDQo+ID4gKyAqICMgbHMgLWwgL3N5cy9idXMvcGNpL2Rldmlj
ZXMvMDAwMDowMDoxOS4wL2RyaXZlcg0KPiA+ICsgKiAuLi4vMDAwMDowMDoxOS4wL2RyaXZlciAt
PiAuLi8uLi8uLi9idXMvcGNpL2RyaXZlcnMvdWlvX3BjaV9kbWVtX2dlbmlycQ0KPiA+ICsgKg0K
PiA+ICsgKiBPciB1c2UgYSBtb2Rwcm9iZSBhbGlhczoNCj4gPiArICogIyBhbGlhcyBwY2k6djAw
MDAxMEVFZDAwMDAxMDAwc3Yqc2Qqc2MqaSogdWlvX3BjaV9kbWVtX2dlbmlycQ0KPiA+ICsgKg0K
PiA+ICsgKiBEcml2ZXIgd29uJ3QgYmluZCB0byBkZXZpY2VzIHdoaWNoIGRvIG5vdCBzdXBwb3J0
IHRoZSBJbnRlcnJ1cHQgRGlzYWJsZSBCaXQNCj4gPiArICogaW4gdGhlIGNvbW1hbmQgcmVnaXN0
ZXIuIEFsbCBkZXZpY2VzIGNvbXBsaWFudCB0byBQQ0kgMi4zIChjaXJjYSAyMDAyKSBhbmQNCj4g
PiArICogYWxsIGNvbXBsaWFudCBQQ0kgRXhwcmVzcyBkZXZpY2VzIHNob3VsZCBzdXBwb3J0IHRo
aXMgYml0Lg0KPiA+ICsgKg0KPiA+ICsgKiBUaGUgRE1BIG1hc2sgYml0cyBhbmQgc2l6ZXMgb2Yg
ZHluYW1pYyByZWdpb25zIGFyZSBkZXJpdmVkIGZyb20gbW9kdWxlDQo+ID4gKyAqIHBhcmFtZXRl
cnMuDQo+ID4gKyAqDQo+ID4gKyAqIFRoZSBmb3JtYXQgZm9yIHNwZWNpZnlpbmcgZHluYW1pYyBy
ZWdpb24gc2l6ZXMgaW4gbW9kdWxlIHBhcmFtZXRlcnMNCj4gPiArICogaXMgYXMgZm9sbG93czoN
Cj4gPiArICoNCj4gPiArICogdWlvX3BjaV9kbWVtX2dlbmlycS5kbWVtX3NpemVzIDo9IDx1aW9f
ZG1lbV9zaXplc19kZWY+Wzs8dWlvX2RtZW1fc2l6ZXNfZGVmPl0NCj4gPiArICogPHVpb19kbWVt
X3NpemVzX2RlZj4gICAgICAgICAgIDo9IDxwY2lfaWQ+OjxzaXplPlssPHNpemU+XQ0KPiA+ICsg
KiA8cGNpX2lkPiAgICAgICAgICAgICAgICAgICAgICAgOj0gPHZlbmRvcj46PGRldmljZT4NCj4g
PiArICogPHNpemU+ICAgICAgICAgICAgICAgICAgICAgICAgIDo9IHN0YW5kYXJkIGxpbnV4IG1l
bXNpemUNCj4gPiArICoNCj4gPiArICogRXhhbXBsZXM6DQo+ID4gKyAqDQo+ID4gKyAqIDEpIFVJ
TyBkbWVtIGRldmljZSB3aXRoIDMgZHluYW1pYyByZWdpb25zOg0KPiA+ICsgKiB1aW9fcGNpX2Rt
ZW1fZ2VuaXJxLmRtZW1fc2l6ZXM9ODA4NjoxMGY1OjRLLDE2Syw0TQ0KPiA+ICsgKg0KPiA+ICsg
KiAyKSBUd28gVUlPIGRtZW0gZGV2aWNlcyB3aXRoIGRpZmZlcmVudCBudW1iZXIgb2YgZHluYW1p
YyByZWdpb25zOg0KPiA+ICsgKiB1aW9fcGNpX2RtZW1fZ2VuaXJxLmRtZW1fc2l6ZXM9ODA4Njox
MGY1OjRLLDE2Syw0TTsxMjM0OjAwMDE6OEsNCj4gDQo+IE1vZHVsZSBwYXJhbWV0ZXJzIGFyZSBo
b3JyaWQsIGFyZSB5b3Ugc3VyZSB0aGVyZSBpcyBubyBvdGhlciB3YXk/DQoNCllvdSdyZSByaWdo
dCwgc2VlbWVkIHRvIGJlIHRoZSBzaW1wbGVzdCBzb2x1dGlvbiBiYWNrIHdoZW4gd2Ugc3RhcnRl
ZCBkZXZlbG9waW5nIHRoaXMgZHJpdmVyLiBJIHdpbGwgdHJ5IHRvIGNoYW5nZSBpdCB0byBzeXNm
cywgc28gdGhhdCBvbmUgY2FuIGFkZCByZWdpb25zIHdoaWxlIHRoZSBtb2R1bGUgaXMgYWxyZWFk
eSBsb2FkZWQuDQoNClJlZ2FyZHMsDQpNYW51ZWwNCg==
