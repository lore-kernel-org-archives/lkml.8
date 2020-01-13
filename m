Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFD4C33CAB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589DD2081E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="THWRiMxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgAMJOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 04:14:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38583 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725832AbgAMJOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 04:14:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578906878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uspd5zkOPeMtHgKJ5e4ZESBs1SxHQ7Z6JFFqEWtfDCY=;
        b=THWRiMxCI8V6v1L50bYo/s6yU9qCMHl5ggvrfi1/5RiQdxLanlp8TFRmdr5PHDaraShW6Q
        EkUrQmBvCHOYYdeTEUvRbA3iDM1PRnEW4ssbAy0IrxCHzYAcwkbvgbTAM7L5FLLjJeL35Y
        1JUYHuEm+iPQp/UNiH2eeQTTwBgpGj4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-P9ovJyJbO9STwUB_mH_sYQ-1; Mon, 13 Jan 2020 04:14:34 -0500
X-MC-Unique: P9ovJyJbO9STwUB_mH_sYQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD33C800D50;
        Mon, 13 Jan 2020 09:14:31 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5557D5D9CA;
        Mon, 13 Jan 2020 09:14:31 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id AE28318089C8;
        Mon, 13 Jan 2020 09:14:30 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: base64
From:   David Hildenbrand <dhildenb@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH V11 1/5] mm/hotplug: Introduce arch callback validating the hot remove range
Date:   Mon, 13 Jan 2020 04:14:30 -0500 (EST)
Message-Id: <3C3BE5FA-0CFC-4C90-8657-63EF5B680B0B@redhat.com>
References: <6f0efddc-f124-58ca-28b6-4632469cf992@arm.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, cai@lca.pw,
        logang@deltatee.com, cpandya@codeaurora.org, arunks@codeaurora.org,
        dan.j.williams@intel.com, mgorman@techsingularity.net,
        osalvador@suse.de, ard.biesheuvel@arm.com, steve.capper@arm.com,
        broonie@kernel.org, valentin.schneider@arm.com,
        robin.murphy@arm.com, steven.price@arm.com, suzuki.poulose@arm.com,
        ira.weiny@intel.com
In-Reply-To: <6f0efddc-f124-58ca-28b6-4632469cf992@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Thread-Topic: mm/hotplug: Introduce arch callback validating the hot remove range
Thread-Index: 9dRMYHGdvxy56yfkC0YmYq8UQHzCmA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gQW0gMTMuMDEuMjAyMCB1bSAxMDoxMCBzY2hyaWViIEFuc2h1bWFuIEtoYW5kdWFsIDxh
bnNodW1hbi5raGFuZHVhbEBhcm0uY29tPjoNCj4gDQo+IO+7vw0KPiANCj4+IE9uIDAxLzEwLzIw
MjAgMDI6MTIgUE0sIERhdmlkIEhpbGRlbmJyYW5kIHdyb3RlOg0KPj4+IE9uIDEwLjAxLjIwIDA0
OjA5LCBBbnNodW1hbiBLaGFuZHVhbCB3cm90ZToNCj4+PiBDdXJyZW50bHkgdGhlcmUgYXJlIHR3
byBpbnRlcmZhY2VzIHRvIGluaXRpYXRlIG1lbW9yeSByYW5nZSBob3QgcmVtb3ZhbCBpLmUNCj4+
PiByZW1vdmVfbWVtb3J5KCkgYW5kIF9fcmVtb3ZlX21lbW9yeSgpIHdoaWNoIHRoZW4gY2FsbHMg
dHJ5X3JlbW92ZV9tZW1vcnkoKS4NCj4+PiBQbGF0Zm9ybSBnZXRzIGNhbGxlZCB3aXRoIGFyY2hf
cmVtb3ZlX21lbW9yeSgpIHRvIHRlYXIgZG93biByZXF1aXJlZCBrZXJuZWwNCj4+PiBwYWdlIHRh
YmxlcyBhbmQgb3RoZXIgYXJjaCBzcGVjaWZpYyBwcm9jZWR1cmVzLiBCdXQgdGhlcmUgYXJlIHBs
YXRmb3Jtcw0KPj4+IGxpa2UgYXJtNjQgd2hpY2ggbWlnaHQgd2FudCB0byBwcmV2ZW50IHJlbW92
YWwgb2YgY2VydGFpbiBzcGVjaWZpYyBtZW1vcnkNCj4+PiByYW5nZXMgaXJyZXNwZWN0aXZlIG9m
IHRoZWlyIHByZXNlbnQgdXNhZ2Ugb3IgbW92YWJpbGl0eSBwcm9wZXJ0aWVzLg0KPj4gDQo+PiBX
aHk/IElzIHRoaXMgb25seSByZWxldmFudCBmb3IgYm9vdCBtZW1vcnk/IEkgaG9wZSBzbywgb3Ro
ZXJ3aXNlIHRoZQ0KPj4gYXJjaCBjb2RlIG5lZWRzIGZpeGluZyBJTUhPLg0KPiANCj4gUmlnaHQs
IGl0IGlzIHJlbGV2YW50IG9ubHkgZm9yIHRoZSBib290IG1lbW9yeSBvbiBhcm02NCBwbGF0Zm9y
bS4gQnV0IHRoaXMNCj4gbmV3IGFyY2ggY2FsbGJhY2sgbWFrZXMgaXQgZmxleGlibGUgdG8gcmVq
ZWN0IGFueSBnaXZlbiBtZW1vcnkgcmFuZ2UuDQo+IA0KPj4gDQo+PiBJZiBpdCdzIG9ubHkgYm9v
dCBtZW1vcnksIHdlIHNob3VsZCBkaXNhbGxvdyBvZmZsaW5pbmcgaW5zdGVhZCB2aWEgYQ0KPj4g
bWVtb3J5IG5vdGlmaWVyIC0gbXVjaCBjbGVhbmVyLg0KPiANCj4gRG9udCBoYXZlIG11Y2ggZGV0
YWlsIHVuZGVyc3RhbmRpbmcgb2YgTU1VIG5vdGlmaWVyIG1lY2hhbmlzbSBidXQgZnJvbSBzb21l
DQo+IGluaXRpYWwgcmVhZGluZywgaXQgc2VlbXMgbGlrZSB3ZSBuZWVkIHRvIGhhdmUgYSBtbV9z
dHJ1Y3QgZm9yIGEgbm90aWZpZXINCj4gdG8gbW9uaXRvciB2YXJpb3VzIGV2ZW50cyBvbiB0aGUg
cGFnZSB0YWJsZS4gSnVzdCB3b25kZXJpbmcgaG93IGEgcGh5c2ljYWwNCj4gbWVtb3J5IHJhbmdl
IGxpa2UgYm9vdCBtZW1vcnkgY2FuIGJlIG1vbml0b3JlZCBiZWNhdXNlIGl0IGNhbiBiZSB1c2Vk
IGJvdGgNCj4gZm9yIGZvciBrZXJuZWwgKGluaXRfbW0pIG9yIHVzZXIgc3BhY2UgcHJvY2VzcyBh
dCBzYW1lIHRpbWUuIElzIHRoZXJlIHNvbWUNCj4gbWVjaGFuaXNtIHdlIGNvdWxkIGRvIHRoaXMg
Pw0KPiANCj4+IA0KPj4+IA0KPj4+IEN1cnJlbnQgYXJjaCBjYWxsIGJhY2sgYXJjaF9yZW1vdmVf
bWVtb3J5KCkgaXMgdG9vIGxhdGUgaW4gdGhlIHByb2Nlc3MgdG8NCj4+PiBhYm9ydCBtZW1vcnkg
aG90IHJlbW92YWwgYXMgbWVtb3J5IGJsb2NrIGRldmljZXMgYW5kIGZpcm13YXJlIG1lbW9yeSBt
YXANCj4+PiBlbnRyaWVzIHdvdWxkIGhhdmUgYWxyZWFkeSBiZWVuIHJlbW92ZWQuIFBsYXRmb3Jt
cyBzaG91bGQgYmUgYWJsZSB0byBhYm9ydA0KPj4+IHRoZSBwcm9jZXNzIGJlZm9yZSB0YWtpbmcg
dGhlIG1lbV9ob3RwbHVnX2xvY2sgd2l0aCBtZW1faG90cGx1Z19iZWdpbigpLg0KPj4+IFRoaXMg
ZXNzZW50aWFsbHkgcmVxdWlyZXMgYSBuZXcgYXJjaCBjYWxsYmFjayBmb3IgbWVtb3J5IHJhbmdl
IHZhbGlkYXRpb24uDQo+PiANCj4+IEkgc29tZXdoYXQgZGlzbGlrZSB0aGlzIHZlcnkgbXVjaC4g
TWVtb3J5IHJlbW92YWwgc2hvdWxkIG5ldmVyIGZhaWwgaWYNCj4+IHVzZWQgc2FuZWx5LiBTZWUg
ZS5nLiwgX19yZW1vdmVfbWVtb3J5KCksIGl0IHdpbGwgQlVHKCkgd2hlbmV2ZXINCj4+IHNvbWV0
aGluZyBsaWtlIHRoYXQgd291bGQgc3RyaWtlLg0KPj4gDQo+Pj4gDQo+Pj4gVGhpcyBkaWZmZXJl
bnRpYXRlcyBtZW1vcnkgcmFuZ2UgdmFsaWRhdGlvbiBiZXR3ZWVuIG1lbW9yeSBob3QgYWRkIGFu
ZCBob3QNCj4+PiByZW1vdmUgcGF0aHMgYmVmb3JlIGNhcnZpbmcgb3V0IGEgbmV3IGhlbHBlciBj
aGVja19ob3RyZW1vdmVfbWVtb3J5X3JhbmdlKCkNCj4+PiB3aGljaCBpbmNvcnBvcmF0ZXMgYSBu
ZXcgYXJjaCBjYWxsYmFjay4gVGhpcyBjYWxsIGJhY2sgcHJvdmlkZXMgcGxhdGZvcm1zDQo+Pj4g
YW4gb3Bwb3J0dW5pdHkgdG8gcmVmdXNlIG1lbW9yeSByZW1vdmFsIGF0IHRoZSB2ZXJ5IG9uc2V0
LiBJbiBmdXR1cmUgdGhlDQo+Pj4gc2FtZSBwcmluY2lwbGUgY2FuIGJlIGV4dGVuZGVkIGZvciBt
ZW1vcnkgaG90IGFkZCBwYXRoIGlmIHJlcXVpcmVkLg0KPj4+IA0KPj4+IFBsYXRmb3JtcyBjYW4g
Y2hvb3NlIHRvIG92ZXJyaWRlIHRoaXMgY2FsbGJhY2sgaW4gb3JkZXIgdG8gcmVqZWN0IHNwZWNp
ZmljDQo+Pj4gbWVtb3J5IHJhbmdlcyBmcm9tIHJlbW92YWwgb3IgY2FuIGp1c3QgZmFsbGJhY2sg
dG8gYSBkZWZhdWx0IGltcGxlbWVudGF0aW9uDQo+Pj4gd2hpY2ggYWxsb3dzIHJlbW92YWwgb2Yg
YWxsIG1lbW9yeSByYW5nZXMuDQo+PiANCj4+IEkgc3VzcGVjdCB3ZSB3YW50IHJlYWxseSB3YW50
IHRvIGRpc2FsbG93IG9mZmxpbmluZyBpbnN0ZWFkLiBFLmcuLCBJDQo+IA0KPiBJZiBib290IG1l
bW9yeSBwYWdlcyBjYW4gYmUgcHJldmVudGVkIGZyb20gYmVpbmcgb2ZmbGluZWQgZm9yIHN1cmUs
IHRoZW4gaXQNCj4gd291bGQgaW5kaXJlY3RseSBkZWZpbml0ZWx5IHByZXZlbnQgaG90IHJlbW92
ZSBwcm9jZXNzIGFzIHdlbGwuDQo+IA0KPj4gcmVtZW1iZXIgczM5MHggZG9lcyB0aGF0IHdpdGgg
Y2VydGFpbiBhcmVhcyBuZWVkZWQgZm9yIGR1bXBpbmcva2V4ZWMuDQo+IA0KPiBDb3VsZCBub3Qg
ZmluZCBhbnkgcmVmZXJlbmNlcyB0byBtbXVfbm90aWZpZXIgaW4gYXJjaC9zMzkwIG9yIGFueSBv
dGhlciBhcmNoDQo+IGZvciB0aGF0IG1hdHRlciBhcGFydCBmcm9tIEtWTSAod2hpY2ggaGFzIGFu
IHVzZXIgc3BhY2UgY29tcG9uZW50KSwgY291bGQgeW91DQo+IHBsZWFzZSBnaXZlIHNvbWUgcG9p
bnRlcnMgPw0KDQpNZW1vcnkgKGhvdHBsdWcpIG5vdGlmaWVyLCBub3QgTU1VIG5vdGlmaWVyIDop
DQoNCk5vdCBvbiBteSBub3RlYm9vayByaWdodCBub3csIGdyZXAgZm9yIE1FTV9HT0lOR19PRkZM
SU5FLCB0aGF0IHNob3VsZCBiZSBpdC4=

