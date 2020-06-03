Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2210C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 13:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8B5E206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 13:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Vm6d7M2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgFCNBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 09:01:31 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:63051 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725833AbgFCNB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 09:01:29 -0400
X-UUID: a04f9c17f0f14a85b9f425e09bc82981-20200603
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=4T4GZu2BhBmei0L8cxQIJh1W9EQOektqEZeHV+JC9ko=;
        b=Vm6d7M2iXShnUXPqPG/6Uw7SJYLRssCcEXVgJODiqyHSSQG1tBCE9WULJBnW0tf4gClUKWe1Cpk7LccVeSXEIvJx4csFxIYToGazbUHfu0LrwU8wHoY86pAxbO3Ck7L1qpQj5caTQwhJHFt2dQOGvSd23bTl3kkLoMbWupal5HU=;
X-UUID: a04f9c17f0f14a85b9f425e09bc82981-20200603
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1363244390; Wed, 03 Jun 2020 21:01:25 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 3 Jun 2020 21:01:20 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Jun 2020 21:01:22 +0800
Message-ID: <1591189283.23525.67.camel@mtkswgap22>
Subject: Re: [PATCH] usb: host: xhci-mtk: avoid runtime suspend when
 removing hcd
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Date:   Wed, 3 Jun 2020 21:01:23 +0800
In-Reply-To: <ebd32a2b-c4ba-8891-b13e-f6c641a94276@linux.intel.com>
References: <1590726569-28248-1-git-send-email-macpaul.lin@mediatek.com>
         <ebd32a2b-c4ba-8891-b13e-f6c641a94276@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA2LTAzIGF0IDE0OjQ3ICswMzAwLCBNYXRoaWFzIE55bWFuIHdyb3RlOg0K
PiBPbiAyOS41LjIwMjAgNy4yOSwgTWFjcGF1bCBMaW4gd3JvdGU6DQo+ID4gV2hlbiBydW50aW1l
IHN1c3BlbmQgd2FzIGVuYWJsZWQsIHJ1bnRpbWUgc3VzcGVuZCBtaWdodCBoYXBwZW5lZA0KPiA+
IHdoZW4geGhjaSBpcyByZW1vdmluZyBoY2QuIFRoaXMgbWlnaHQgY2F1c2Uga2VybmVsIHBhbmlj
IHdoZW4gaGNkDQo+ID4gaGFzIGJlZW4gZnJlZWQgYnV0IHJ1bnRpbWUgcG0gc3VzcGVuZCByZWxh
dGVkIGhhbmRsZSBuZWVkIHRvDQo+ID4gcmVmZXJlbmNlIGl0Lg0KPiA+IA0KPiA+IENoYW5nZS1J
ZDogSTcwYTVkYzgwMDYyMDdjYWVlY2JhYzY5NTVjZThlNTM0NWRjYzcwZTYNCj4gPiBTaWduZWQt
b2ZmLWJ5OiBNYWNwYXVsIExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMgfCAgICA1ICsrKy0tDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGsuYyBiL2RyaXZlcnMvdXNiL2hvc3Qv
eGhjaS1tdGsuYw0KPiA+IGluZGV4IGJmYmRiM2MuLjY0MWQyNGUgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jDQo+ID4gKysrIGIvZHJpdmVycy91c2IvaG9zdC94
aGNpLW10ay5jDQo+ID4gQEAgLTU4Nyw2ICs1ODcsOSBAQCBzdGF0aWMgaW50IHhoY2lfbXRrX3Jl
bW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYpDQo+ID4gIAlzdHJ1Y3QgeGhjaV9oY2QJ
KnhoY2kgPSBoY2RfdG9feGhjaShoY2QpOw0KPiA+ICAJc3RydWN0IHVzYl9oY2QgICpzaGFyZWRf
aGNkID0geGhjaS0+c2hhcmVkX2hjZDsNCj4gPiAgDQo+ID4gKwlwbV9ydW50aW1lX3B1dF9zeW5j
KCZkZXYtPmRldik7DQo+IA0KPiBNaWdodCBydW50aW1lIHN1c3BlbmQgaGVyZS4NCj4gSXQncyBh
IGxvdCBiZXR0ZXIgdGhhbiBiZWZvcmUsIG5vIHBhbmljIGFzIGhjZCBpc24ndCByZWxlYXNlZCwg
YnV0IGEgYml0IHVubmVjZXNzYXJ5Lg0KPiANCj4gaG93IGFib3V0IHRoaXMgc2VxdWVuY2UgaW5z
dGVhZDoNCj4gcG1fcnVudGltZV9kaXNhYmxlKCkNCj4gcG1fcnVudGltZV9wdXRfbm9pZGxlKCkN
Cj4gDQo+ID4gKwlwbV9ydW50aW1lX2Rpc2FibGUoJmRldi0+ZGV2KTsNCj4gPiArDQo+IA0KPiAt
TWF0aGlhcw0KDQpUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbiENCldpbGwgaXQgYmV0dGVyIHRv
IHB1dCBubyBpZGxlIGJlZm9yZSBkaXNhYmxlPyANCnBtX3J1bnRpbWVfcHV0X25vaWRsZSgpDQpw
bV9ydW50aW1lX2Rpc2FibGUoKQ0KDQpJJ3ZlIGZvdW5kIHBtX3J1bnRpbWVfcHV0X25vaWRsZSBp
cyBjYWxsZWQgaW4gcG1fcnVudGltZV9kaXNhYmxlKCkgd2hlbg0KdGhlcmUgaXMgYSBwZW5kaW5n
IHJlcXVlc3QuDQoNCkkgd2lsbCBzZW5kIHBhdGNoIHYzIGFzIG5vaWRsZSgpIGNhbGxlZCBlYXJs
aWVyIHRoYW4gZGlzYWJsZSgpLiBQbGVhc2UNCmhlbHAgdG8gY29tbWVudCBpdCBpZiBkaXNhYmxl
KCkgc2hvdWxkIGdvIGJlZm9yZS4NCg0KVGhhbmtzIQ0KTWFjcGF1bCBMaW4gDQo=

