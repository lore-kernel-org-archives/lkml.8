Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56591C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238C82146E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEMMVrYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgCIUHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:07:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36530 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726384AbgCIUHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583784422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ftWHEpSAUbk0eoJjmPg+C+QzhYo5sgkwqXSro3PQIsQ=;
        b=XEMMVrYMaZc+g9NvBN6kVZQXlFP2SPCMPESWlTn2YSGZMLgX0obSMrpCUyzxdTAu31RZ1I
        fu3cRyyCG4Z5UBqgYbFX4osHOkIWcgh0DrB4WbiuxhVO78LHGwMLUZ7/inSuik/J93Hu8q
        pDgOUPlXyIuDHA1LKD6mBcfPiyUYlFw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-ikgYpv8ZNqKPibZ96WJ9dA-1; Mon, 09 Mar 2020 16:07:00 -0400
X-MC-Unique: ikgYpv8ZNqKPibZ96WJ9dA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 131001005509;
        Mon,  9 Mar 2020 20:06:57 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 730E35D9CA;
        Mon,  9 Mar 2020 20:06:56 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 53F4486A04;
        Mon,  9 Mar 2020 20:06:54 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: base64
From:   David Hildenbrand <dhildenb@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND v6 00/16] mm: Page fault enhancements
Date:   Mon, 9 Mar 2020 16:06:54 -0400 (EDT)
Message-Id: <FD483CC3-26F1-4CEE-899E-7EB77C4D3277@redhat.com>
References: <20200309195100.GD4206@xz-x1>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Martin Cracauer <cracauer@cons.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Bobby Powers <bobbypowers@gmail.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mel Gorman <mgorman@suse.de>, Hugh Dickins <hughd@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>
In-Reply-To: <20200309195100.GD4206@xz-x1>
To:     Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Thread-Topic: Page fault enhancements
Thread-Index: VkIGmTyFztzfGbEHyyEMiVtHfLEZng==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gQW0gMDkuMDMuMjAyMCB1bSAyMDo1MSBzY2hyaWViIFBldGVyIFh1IDxwZXRlcnhAcmVk
aGF0LmNvbT46DQo+IA0KPiDvu79PbiBTdW4sIE1hciAwOCwgMjAyMCBhdCAwMToxMjozNFBNICsw
MTAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToNCj4+IFsuLi5dDQo+PiANCj4+PiBZZXMsIElJ
VUMgdGhlIHJhY2UgY2FuIGhhcHBlbiBsaWtlIHRoaXMgaW4geW91ciBiZWxvdyB0ZXN0Og0KPj4+
IA0KPj4+ICAgICBtYWluIHRocmVhZCAgICAgICAgICB1ZmZkIHRocmVhZCAgICAgICAgICAgICBk
aXNnYXJkIHRocmVhZA0KPj4+ICAgICA9PT09PT09PT09PSAgICAgICAgICA9PT09PT09PT09PSAg
ICAgICAgICAgICA9PT09PT09PT09PT09PQ0KPj4+ICAgICBhY2Nlc3MgcGFnZQ0KPj4+ICAgICAg
IHVmZmQgcGFnZSBmYXVsdA0KPj4+ICAgICAgICAgd2FpdCBmb3IgcGFnZQ0KPj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICBVRkZESU9fWkVST0NPUFkNCj4+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBwdXQgYSBwYWdlIFAgdGhlcmUNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgTUFEVl9ET05UTkVFRCBvbiBQDQo+Pj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgd2FrZXVwIG1haW4gdGhyZWFkDQo+Pj4gICAgICAgICByZXR1cm4g
ZnJvbSBmYXVsdA0KPj4+ICAgICAgIHBhZ2Ugc3RpbGwgbWlzc2luZw0KPj4+ICAgICAgIHVmZmQg
cGFnZSBmYXVsdCBhZ2Fpbg0KPj4+ICAgICAgICh3aXRob3V0IEFMTE9XX1JFVFJZKQ0KPj4+ICAg
ICAgIC0tPiBTSUdCVVMuDQo+PiANCj4+IEV4YWN0bHkhDQo+PiANCj4+Pj4gQ2FuIHdlIHBsZWFz
ZSBoYXZlIGEgd2F5IHRvIGlkZW50aWZ5IHRoYXQgdGhpcyAiZmVhdHVyZSIgaXMgYXZhaWxhYmxl
Pw0KPj4+PiBJJ2QgYXBwcmVjaWF0ZSBhIG5ldyByZWFkLW9ubHkgVUZGRF9GRUFUXyAsIHNvIHdl
IGNhbiBkZXRlY3QgdGhpcyBmcm9tDQo+Pj4+IHVzZXIgc3BhY2UgZWFzaWx5IGFuZCB1c2UgY29u
Y3VycmVudCBkaXNjYXJkcyB3aXRob3V0IGNyYXNoaW5nIG91ciBhcHBsaWNhdGlvbnMuDQo+Pj4g
DQo+Pj4gSSdtIG5vdCBzdXJlIGhvdyBvdGhlcnMgdGhpbmsgYWJvdXQgaXQsIGJ1dCB0byBtZSB0
aGlzIHN0aWxsIGZlbGxzDQo+Pj4gaW50byB0aGUgYnVja2V0IG9mICJzb2x2aW5nIGFuIGV4aXN0
aW5nIHByb2JsZW0iIHJhdGhlciB0aGFuIGENCj4+PiBmZWF0dXJlLiAgQWxzbyBub3RlIHRoYXQg
dGhpcyBzaG91bGQgY2hhbmdlIHRoZSBiZWhhdmlvciBmb3IgdGhlIHBhZ2UNCj4+PiBmYXVsdCBs
b2dpYyBpbiBnZW5lcmFsLCByYXRoZXIgdGhhbiBhbiB1ZmZkLW9ubHkgY2hhbmdlLiBTbyBJJ20g
YWxzbw0KPj4+IG5vdCBzdXJlIHdoZXRoZXIgVUZGRF9GRUFUXyogc3VpdGVzIGhlcmUgZXZlbiBp
ZiB3ZSB3YW50IGl0Lg0KPj4gDQo+PiBTbywgYXJlIHdlIHBsYW5uaW5nIG9uIGJhY2twb3J0aW5n
IHRoaXMgdG8gc3RhYmxlIGtlcm5lbHM/DQo+IA0KPiBJIGRvbid0IGhhdmUgYSBwbGFuIHNvIGZh
ci4gIEknbSBzdGlsbCBhdCB0aGUgcGhhc2UgdG8gb25seSB3b3JyeQ0KPiBhYm91dCB3aGV0aGVy
IGl0IGNhbiBiZSBhdCBsZWFzdCBtZXJnZWQgaW4gbWFzdGVyLi4gOikNCj4gDQo+IEkgd291bGQg
dGhpbmsgaXQgd29uJ3Qgd29ydGggaXQgdG8gYmFja3BvcnQgdGhpcyB0byBzdGFibGVzIHRob3Vn
aCwNCj4gY29uc2lkZXJpbmcgdGhhdCBpdCBjb3VsZCBwb3RlbnRpYWxseSBjaGFuZ2UgcXVpdGUg
YSBiaXQgZm9yIGZhdWx0aW5nDQo+IHByb2NlZHVyZXMsIGFuZCBhZnRlciBhbGwgdGhlIGlzc3Vl
cyB3ZSdyZSBmaXhpbmcgc2hvdWxkbid0IGJlIGNvbW1vbg0KPiB0byBnZW5lcmFsIHVzZXJzLg0K
PiANCj4+IA0KPj4gSW1hZ2luZSB1c2luZyB0aGlzIGluIFFFTVUvS1ZNIHRvIGFsbG93IGRpc2Nh
cmRzIChlLmcuLCBiYWxsb29uDQo+PiBpbmZsYXRpb24pIHdoaWxlIHBvc3Rjb3B5IGlzIGFjdGl2
ZSAuIFlvdSBjZXJ0YWlubHkgZG9uJ3Qgd2FudCByYW5kb20NCj4+IGd1ZXN0IGNyYXNoZXMuIFNv
IGVpdGhlciwgd2UgdHJlYXQgdGhpcyBhcyBhIGZpeCAoYW5kIGJhY2twb3J0KSBvciBhcyBhDQo+
PiBjaGFuZ2UgaW4gYmVoYXZpb3IvZmVhdHVyZS4NCj4gDQo+IEkgdGhpbmsgd2UgZG9uJ3QgbmVl
ZCB0byB3b3JyeSBvbiB0aGF0IC0gUUVNVSB3aWxsIHByb2hpYml0IGJhbGxvb25pbmcNCj4gZHVy
aW5nIHBvc3Rjb3B5IHN0YXJ0aW5nIGZyb20gdGhlIGZpcnN0IGRheS4gIEZlZWwgZnJlZSB0byBz
ZWUgUUVNVQ0KPiBjb21taXQgMzcxZmY1YTNmMDRjZDcgKCJJbmhpYml0IGJhbGxvb25pbmcgZHVy
aW5nIHBvc3Rjb3B5IikuDQoNCkltYWdpbmUgSSB3YW50IHRvIGNoYW5nZSB0aGF0IG9yIGltYWdp
bmUgSSBoYXZlIGFub3RoZXIgdXNlciB0aGF0IGhlYXZpbHkgZGVwZW5kcyBvbiBzdWNoIHJhY2Vz
IHRvIG5ldmVyIGhhcHBlbi4NCg0KSU9XIEkgd2FudCB0byBrbm93IGZvciBzdXJlIGlmIG15IGFw
cGxpY2F0aW9uIGNhbiBjcmFzaCBvciBub3QuDQoNCkBBbmRyZWEgd2hhdCBhcmUgeW91ciB0aG91
Z2h0cyBvbiBhIG5ldyBmZWF0dXJlIGZsYWcgdG8gaWRlbnRpZnkgdGhpcyBiZWhhdmlvcj8NCg0K

