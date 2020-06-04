Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857A2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 03:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56A5F20829
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 03:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FAAUMXeg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgFDDjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 23:39:53 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:61994 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726604AbgFDDjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 23:39:52 -0400
X-UUID: 755fa141118a4201a48e86f265915509-20200604
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=9ohiaeGdFreb1r0AXs539unugde1ILARpYyi69vZq7M=;
        b=FAAUMXegfjiNk7eBOMTYbUdzdoIslcIAQpe/Cb/PZllnABeI6orW1H/Fvpg4/HThRotVRYZ/RfLlbYXa6A+7xSTX8jThRyjIdY9Z3UYF1i6RV1v87eJBSWVsL1OnrtDWUtp3dnf7zTsTE0QRe1jXTRBVVGgU50XvOi2QqRDCBaU=;
X-UUID: 755fa141118a4201a48e86f265915509-20200604
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1213929344; Thu, 04 Jun 2020 11:39:49 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 4 Jun 2020 11:39:47 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Jun 2020 11:39:47 +0800
Message-ID: <1591241987.29475.19.camel@mtkswgap22>
Subject: Re: [PATCH] mm/memblock: export max_pfn for kernel modules
From:   Miles Chen <miles.chen@mediatek.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Thu, 4 Jun 2020 11:39:47 +0800
In-Reply-To: <23a9a2cc-3461-52bb-4285-b063a01bd7c6@redhat.com>
References: <20200603161132.2441-1-miles.chen@mediatek.com>
         <23a9a2cc-3461-52bb-4285-b063a01bd7c6@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: BBB609BC241D5D6326810E159D32C1FFD2E89757713B0F6749736E0F12BB7A882000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA2LTAzIGF0IDE4OjE2ICswMjAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gT24gMDMuMDYuMjAgMTg6MTEsIE1pbGVzIENoZW4gd3JvdGU6DQo+ID4gbWF4X3BmbiBp
cyB1ZXNkIHRvIGdldCB0aGUgaGlnaGVzdCBwZm4gaW4gdGhlIHN5c3RlbS4gRHJpdmVycyBsaWtl
DQo+ID4gZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBjaGVja3MgbWF4X3BmbiB0byBzZWUgaWYg
aXQgc2hvdWxkIGVuYWJsZQ0KPiA+IGl0cyAiNEdCIG1vZGUiLg0KPiA+IA0KPiA+IFRoaXMgcGF0
Y2ggZXhwb3J0cyB0aGUgbWF4X3BmbiBzeW1ib2wsIHNvIHdlIGNhbiBidWlsZCB0aGUgZHJpdmVy
IGFzDQo+ID4gYSBrZXJuZWwgbW9kdWxlLg0KPiANCj4gUGxlYXNlIGFkZCB0aGF0IGNoYW5nZSB0
byB0aGUgcmVzcGVjdGl2ZSB1c2VyIHBhdGNoIChhbmQgY2MgTU0tcGVvcGxlDQo+IGZvciB0aGF0
IHBhdGNoKSwgc28gd2UgaGF2ZSB0aGUgYWN0dWFsIHVzZXIgcmlnaHQgYWxvbmcgdGhlIGNoYW5n
ZSBhbmQNCj4gY2FuIGZpZ3VyZSBvdXQgaWYgdGhpcyBpcyB0aGUgcmlnaHQgdGhpbmcgdG8gZG8u
DQo+IA0KDQpUaGFua3MgZm9yIHRoZSBjb21tZW50Lg0KDQpNaWtlIHBvaW50cyBvdXQgYW5vdGhl
ciBhbHRlcm5hdGl2ZSB3YXkgdG8gZG8gdGhpcyBieSB0b3RhbHJhbV9wYWdlcygpLg0KSSB3aWxs
IHVzZSB0aGF0IGFwcHJvYWNoIHNvIHdlIGRvbid0IGhhdmUgdG8gZXhwb3J0IG1heF9wZm4gaGVy
ZS4NCg0KaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjAvNi8zLzc3MQ0KDQpNaWxlcw0KDQo+ID4g
DQo+ID4gU2lnbmVkLW9mZi1ieTogTWlsZXMgQ2hlbiA8bWlsZXMuY2hlbkBtZWRpYXRlay5jb20+
DQo+ID4gLS0tDQo+ID4gIG1tL21lbWJsb2NrLmMgfCAxICsNCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL21tL21lbWJsb2NrLmMgYi9t
bS9tZW1ibG9jay5jDQo+ID4gaW5kZXggYzc5YmE2Zjk5MjBjLi4zYjJiMjFlY2ViYjYgMTAwNjQ0
DQo+ID4gLS0tIGEvbW0vbWVtYmxvY2suYw0KPiA+ICsrKyBiL21tL21lbWJsb2NrLmMNCj4gPiBA
QCAtOTksNiArOTksNyBAQCBFWFBPUlRfU1lNQk9MKGNvbnRpZ19wYWdlX2RhdGEpOw0KPiA+ICB1
bnNpZ25lZCBsb25nIG1heF9sb3dfcGZuOw0KPiA+ICB1bnNpZ25lZCBsb25nIG1pbl9sb3dfcGZu
Ow0KPiA+ICB1bnNpZ25lZCBsb25nIG1heF9wZm47DQo+ID4gK0VYUE9SVF9TWU1CT0wobWF4X3Bm
bik7DQo+ID4gIHVuc2lnbmVkIGxvbmcgbG9uZyBtYXhfcG9zc2libGVfcGZuOw0KPiA+ICANCj4g
PiAgc3RhdGljIHN0cnVjdCBtZW1ibG9ja19yZWdpb24gbWVtYmxvY2tfbWVtb3J5X2luaXRfcmVn
aW9uc1tJTklUX01FTUJMT0NLX1JFR0lPTlNdIF9faW5pdGRhdGFfbWVtYmxvY2s7DQo+ID4gDQo+
IA0KPiANCg0K

