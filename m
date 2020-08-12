Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0666C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 09:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D20207DE
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 09:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Vj+AkpnA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgHLJPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 05:15:44 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50322 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726255AbgHLJPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 05:15:42 -0400
X-UUID: 6a8523b67382456a97e59d3f7a78669d-20200812
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=L+KavRCBQgfTOdvCNrk/qG3OTZZfc+8SqW2qQrGwgrg=;
        b=Vj+AkpnAXOI1M+CWJylimnh93Y4Vm8nVxIP0fxqcFdS+WRAhyE4QV2F+d0OPbx7QwygFiDwdP/Os0gevGB5k2qMoO8/Czh1elgXK6Vs61ja3IOYKj0WLHX9KlpNjgMElx3kzWWYBDJNlQynRDrng7kgqWj/b62KWweJ86RHLbLI=;
X-UUID: 6a8523b67382456a97e59d3f7a78669d-20200812
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1205999173; Wed, 12 Aug 2020 17:15:39 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 12 Aug 2020 17:15:30 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 Aug 2020 17:15:30 +0800
Message-ID: <1597223732.5467.10.camel@mtkswgap22>
Subject: RE: [PATCH] net: untag pointer in sockptr_is_kernel
From:   Miles Chen <miles.chen@mediatek.com>
To:     David Laight <David.Laight@ACULAB.COM>
CC:     'Christoph Hellwig' <hch@lst.de>,
        "David S . Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wsd_upstream@mediatek.com" <wsd_upstream@mediatek.com>
Date:   Wed, 12 Aug 2020 17:15:32 +0800
In-Reply-To: <36e381c558e24185bc2f7e80a758d06a@AcuMS.aculab.com>
References: <20200811102704.17875-1-miles.chen@mediatek.com>
         <20200811111551.GA3958@lst.de>
         <36e381c558e24185bc2f7e80a758d06a@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 8C830A68D723F95F6BDDC1C13338A4B11FEEE2C54A7FF5C5D7AFEA180AA80EE62000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA4LTExIGF0IDExOjQ0ICswMDAwLCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+
ID4gT24gVHVlLCBBdWcgMTEsIDIwMjAgYXQgMDY6Mjc6MDRQTSArMDgwMCwgTWlsZXMgQ2hlbiB3
cm90ZToNCj4gPiA+IEZyb206IE1pbGVzIENoZW4gPG1pbGVzLmNoZW5AbWVkaWF0ZWsuY29tPg0K
PiA+ID4NCj4gPiA+IHNvY2twdHJfaXNfa2VybmVsKCkgdXNlcyAoc29ja3B0ci5rZXJuZWwgPj0g
VEFTS19TSVpFKSB0byB0ZWxsDQo+ID4gPiBpZiB0aGUgcG9pbnRlciBpcyBrZXJuZWwgc3BhY2Ug
b3IgdXNlciBzcGFjZS4gV2hlbiB1c2VyIHNwYWNlIHVzZXMNCj4gPiA+IHRoZSAidG9wIGJ5dGUg
aWdub3JlZCIgZmVhdHVyZSBzdWNoIGFzIEhXQXNhbiwgd2UgbXVzdCB1bnRhZw0KPiA+ID4gdGhl
IHBvaW50ZXIgYmVmb3JlIGNoZWNraW5nIGFnYWluc3QgVEFTS19TSVpFLg0KPiA+ID4NCj4gPiA+
IHNvY2twdHJfaXNfa2VybmVsKCkgd2lsbCB2aWV3IGEgdGFnZ2VkIHVzZXIgcG9pbnRlciBhcyBh
IGtlcm5lbCBwb2ludGVyDQo+ID4gPiBhbmQgdXNlIG1lbWNweSBkaXJlY3RseSBhbmQgY2F1c2Vz
IGEga2VybmVsIGNyYXNoLg0KPiA+IA0KPiA+IERhdmUgbWVyZ2VkIGEgcGF0Y2ggZnJvbSBtZSB0
byByZXZlciB0aGUgb3B0aW1pemVkIHNvY2twdHINCj4gPiBpbXBsZW1lbnRhdGlvbiBmb3Igbm93
LiAgSWYgd2UgYnJpbmcgaXQgYmFjayB3ZSBzaG91bGQgZm9sZCBpbiB5b3VyDQo+ID4gZml4Lg0K
PiANCj4gSSBtaXNzZWQgdGhhdCBnb2luZyB0aG91Z2ggOi0oDQo+IEkndmUgbG9va2VkIGZvciBh
IGZpeCB0byB0aGUgYWNjZXNzX29rKGtlcm5lbF9hZGRyLDApIGJlaW5nIHRydWUgaXNzdWUuDQo+
IA0KPiBTaG91bGRuJ3QgVEFTS19TSVpFIGJlIGluY3JlYXNlZCB0byBjb3ZlciBhbGwgdGhlICd0
YWdnZWQnIGFkZHJlc3Nlcz8NCj4gSVNUUiB0aGUgJ3RhZycgYml0cyBhcmUgdGhlICduZXh0JyA4
IChvciBzbykgYWRkcmVzcyBiaXRzIGF0IHRoZSB0b3ANCj4gb2YgdmFsaWQgdXNlciBhZGRyZXNz
ZXMuDQoNCg0KSSdtIG5vdCBzdXJlIGlmIHRoaXMgaXMgYSBnb29kIGlkZWEuIFRBU0tfU0laRSBp
cyBhbiBhcmNoIGRlcGVuZGVudA0KY29uc3RhbnQsIGlmIHdlIGluY3JlYXNlIFRBU0tfU0laRSB0
byBjb3ZlciB0aGUgJ3RhZ2dlZCcgYWRkcmVzcyBzcGFjZSwNCnRoZSBUQVNLX1NJWkUgd2lsbCBu
b3QgdGVsbCB1cyB0aGUgYWN0dWFsIHZpcnR1YWwgYWRkcmVzcyBzaXplLg0KDQpNYXliZSB3ZSBu
ZWVkIGEgbWFjcm8gdG8gdGVsbCBpZiBhIHBvaW50ZXIgaXMgaW4gdXNlciBzcGFjZSBvciBub3Qg
YW5kDQpoYW5kbGUgdGhlIG1lbW9yeSB0YWcgdGhlcmUuDQpCdXQgdGhpcyBvbmx5IHdvcmtzIGZv
ciB0aGUgImlzIHRoaXMgcG9pbnRlciBpbiB1c2VyIHNwYWNlIiBwcm9ibGVtLiANCg0KDQpJIHJl
cG9ydGVkIGFub3RoZXIgdGFnZ2VkIHBvaW50ZXIgaXNzdWUgWzFdLg0KDQpNaWxlcw0KDQpbMV0g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcGF0Y2h3b3JrL3BhdGNoLzEyODM2NDkvDQoNCg0KDQo+
IFRoZW4gcHJlc3VtYWJseSB0aGUgdXNlci1jb3BpZXMgd291bGQgYmUgYWJsZSB0byB1c2UgdGhl
IHRhZ2dlZA0KPiBhZGRyZXNzIHZhbHVlcyBnZXR0aW5nIHdoYXRldmVyIHByb3RlY3Rpb24gdGhh
dCBnaXZlcy4NCj4gDQo+IElTVE0gdGhhdCBmb3Iga2VybmVsLXVzZXIgYm91bmRhcnkgY2hlY2tz
IFRBU0tfU0laRSBpcyB0aGUNCj4gd3JvbmcgY29uc3RhbnQuDQo+IChUaGUgdXBwZXIgbGltaXQg
Zm9yIG1tYXAoKSBpcyBlbnRpcmVseSBkaWZmZXJlbnQuKQ0KPiBUaGUgbGltaXQgc2hvdWxkIGJl
IGluZGVwZW5kZW50IG9mIHdoZXRoZXIgdGhlIHByb2Nlc3MgaXMgMzIgb3IgNjRiaXQNCj4gKGFu
eSBmYXVsdCBhYm92ZSA0RyB3aWxsIGZhaWwgdG8gZmluZCBhIHVzZXItcGFnZSBmb3IgMzJiaXQp
Lg0KPiBUaGUgbGltaXQgY2FuIGFsc28gZ28gd2VsbCBpbnRvIHRoZSBhZGRyZXNzICdibGFjayBo
b2xlJyB0aGF0DQo+IGV4aXN0cyBvbiB4ODYteDY0IChhbmQgc2ltaWxhcikgYmV0d2VlbiB2YWxp
ZCB1c2VyIGFuZCBrZXJuZWwNCj4gYWRkcmVzc2VzIC0gaGFuZGxpbmcgdGhlIHJlbGV2YW50IHRy
YXAgc2hvdWxkIGJlIHRvbyBoYXJkDQo+IChpdCBpcyBhbHdheXMgYW4gZXJyb3IsIHNvIG5lZWQg
bm90IGJlIGZhc3QpLg0KPiANCj4gU28gd2l0aCBzZXRfZnMoS0VSTkVMX0RTKSBnb25lIHg4Ni14
NjQgY2FuIChhbG1vc3QgY2VydGFpbmx5KQ0KPiBkbyBhIGNoZWFwIHRlc3QgZm9yIChsb25nKWFk
ZHIgPj0gMCBpbiBhY2Nlc3Nfb2soKSAoKyBsZW5ndGggdGVzdCkuDQo+IFdoaWxlIHNldF9mcygp
IGlzIG5lZWRlZCBpdCBjYW4gYmU6DQo+IAkoKGxvbmcpYWRkciAmIGN1cnJlbnQtPm1hc2spID49
IDANCj4gKG1hc2tpbmcgb2ZmIHRoZSB0b3AgYml0IGlmIGtlcm5lbCBhZGRyZXNzZXMgYXJlIHZh
bGlkKS4NCj4gDQo+IAlEYXZpZA0KPiANCj4gLQ0KPiBSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNp
ZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsN
Cj4gUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCj4gDQoNCg==

