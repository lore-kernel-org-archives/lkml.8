Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11ACC33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 22:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3962080D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 22:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZDoe8kH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgAMW5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 17:57:19 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21945 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728833AbgAMW5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 17:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578956237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQCOGbh+bMqXrPS+qToZ71MmwbqD2csN/FzB8tydSE4=;
        b=OZDoe8kHDTFBLgq/XL48nEaCm45BxCsJ1oDwdkY28RPi48dSADNhBONBixnWHpriZUoUT/
        qApREG/8XX/apOQkSY4ScQKEp1OpAHPvD20QgyAW6aSb3Nk3RPxLnREMS3maLEFzp9Xln5
        O4UPpr+G7+C6rKRR8Ge9c2MmyDLo6FA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-cG5FGFRxN6uisPMJ3xaI_g-1; Mon, 13 Jan 2020 17:57:14 -0500
X-MC-Unique: cG5FGFRxN6uisPMJ3xaI_g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C50518024D3;
        Mon, 13 Jan 2020 22:57:12 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AAEEB811E0;
        Mon, 13 Jan 2020 22:57:12 +0000 (UTC)
Received: from zmail19.collab.prod.int.phx2.redhat.com (zmail19.collab.prod.int.phx2.redhat.com [10.5.83.22])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 814B4503DA;
        Mon, 13 Jan 2020 22:57:12 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: base64
From:   David Hildenbrand <dhildenb@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH v1 2/2] mm: factor out next_present_section_nr()
Date:   Mon, 13 Jan 2020 17:57:12 -0500 (EST)
Message-Id: <0B77E39C-BD38-4A61-AB28-3578B519952F@redhat.com>
References: <20200113224155.efoekgw4hyey2by2@box>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
In-Reply-To: <20200113224155.efoekgw4hyey2by2@box>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Thread-Topic: factor out next_present_section_nr()
Thread-Index: KOJuedPw6AHzUiVonlt4OpFWR8o9Jw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gQW0gMTMuMDEuMjAyMCB1bSAyMzo0MSBzY2hyaWViIEtpcmlsbCBBLiBTaHV0ZW1vdiA8
a2lyaWxsQHNodXRlbW92Lm5hbWU+Og0KPiANCj4g77u/T24gTW9uLCBKYW4gMTMsIDIwMjAgYXQg
MDM6NDA6MzVQTSArMDEwMCwgRGF2aWQgSGlsZGVuYnJhbmQgd3JvdGU6DQo+PiBMZXQncyBtb3Zl
IGl0IHRvIHRoZSBoZWFkZXIgYW5kIHVzZSB0aGUgc2hvcnRlciB2YXJpYW50IGZyb20NCj4+IG1t
L3BhZ2VfYWxsb2MuYyAodGhlIG9yaWdpbmFsIG9uZSB3aWxsIGFsc28gY2hlY2sNCj4+ICJfX2hp
Z2hlc3RfcHJlc2VudF9zZWN0aW9uX25yICsgMSIsIHdoaWNoIGlzIG5vdCBuZWNlc3NhcnkpLiBX
aGlsZSBhdCBpdCwNCj4+IG1ha2UgdGhlIHNlY3Rpb25fbnIgaW4gbmV4dF9wZm4oKSBjb25zdC4N
Cj4+IA0KPj4gSW4gbmV4dF9wZm4oKSwgd2Ugbm93IHJldHVybiBzZWN0aW9uX25yX3RvX3Bmbigt
MSkgaW5zdGVhZCBvZiAtMSBvbmNlDQo+PiB3ZSBleGNlZWQgX19oaWdoZXN0X3ByZXNlbnRfc2Vj
dGlvbl9uciwgd2hpY2ggZG9lc24ndCBtYWtlIGEgZGlmZmVyZW5jZSBpbg0KPj4gdGhlIGNhbGxl
ciBhcyBpdCBpcyBiaWcgZW5vdWdoICg+PSBhbGwgc2FuZSBlbmRfcGZuKS4NCj4+IA0KPj4gQ2M6
IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+DQo+PiBDYzogTWljaGFs
IEhvY2tvIDxtaG9ja29Aa2VybmVsLm9yZz4NCj4+IENjOiBPc2NhciBTYWx2YWRvciA8b3NhbHZh
ZG9yQHN1c2UuZGU+DQo+PiBDYzogS2lyaWxsIEEuIFNodXRlbW92IDxraXJpbGxAc2h1dGVtb3Yu
bmFtZT4NCj4+IFNpZ25lZC1vZmYtYnk6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQu
Y29tPg0KPj4gLS0tDQo+PiBpbmNsdWRlL2xpbnV4L21tem9uZS5oIHwgMTAgKysrKysrKysrKw0K
Pj4gbW0vcGFnZV9hbGxvYy5jICAgICAgICB8IDExICsrLS0tLS0tLS0tDQo+PiBtbS9zcGFyc2Uu
YyAgICAgICAgICAgIHwgMTAgLS0tLS0tLS0tLQ0KPj4gMyBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNl
cnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvbW16b25lLmggYi9pbmNsdWRlL2xpbnV4L21tem9uZS5oDQo+PiBpbmRleCBjMmJjMzA5
ZDE2MzQuLjQ2MmY2ODczOTA1YSAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvbGludXgvbW16b25l
LmgNCj4+ICsrKyBiL2luY2x1ZGUvbGludXgvbW16b25lLmgNCj4+IEBAIC0xMzc5LDYgKzEzNzks
MTYgQEAgc3RhdGljIGlubGluZSBpbnQgcGZuX3ByZXNlbnQodW5zaWduZWQgbG9uZyBwZm4pDQo+
PiAgICByZXR1cm4gcHJlc2VudF9zZWN0aW9uKF9fbnJfdG9fc2VjdGlvbihwZm5fdG9fc2VjdGlv
bl9ucihwZm4pKSk7DQo+PiB9DQo+PiANCj4+ICtzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxvbmcg
bmV4dF9wcmVzZW50X3NlY3Rpb25fbnIodW5zaWduZWQgbG9uZyBzZWN0aW9uX25yKQ0KPj4gK3sN
Cj4+ICsgICAgd2hpbGUgKCsrc2VjdGlvbl9uciA8PSBfX2hpZ2hlc3RfcHJlc2VudF9zZWN0aW9u
X25yKSB7DQo+PiArICAgICAgICBpZiAocHJlc2VudF9zZWN0aW9uX25yKHNlY3Rpb25fbnIpKQ0K
Pj4gKyAgICAgICAgICAgIHJldHVybiBzZWN0aW9uX25yOw0KPj4gKyAgICB9DQo+PiArDQo+PiAr
ICAgIHJldHVybiAtMTsNCj4+ICt9DQo+PiArDQo+PiAvKg0KPj4gICogVGhlc2UgYXJlIF9vbmx5
XyB1c2VkIGR1cmluZyBpbml0aWFsaXNhdGlvbiwgdGhlcmVmb3JlIHRoZXkNCj4+ICAqIGNhbiB1
c2UgX19pbml0ZGF0YSAuLi4gIFRoZXkgY291bGQgaGF2ZSBuYW1lcyB0byBpbmRpY2F0ZQ0KPj4g
ZGlmZiAtLWdpdCBhL21tL3BhZ2VfYWxsb2MuYyBiL21tL3BhZ2VfYWxsb2MuYw0KPj4gaW5kZXgg
YTkyNzkxNTEyMDc3Li4yNmU4MDQ0ZTk4NDggMTAwNjQ0DQo+PiAtLS0gYS9tbS9wYWdlX2FsbG9j
LmMNCj4+ICsrKyBiL21tL3BhZ2VfYWxsb2MuYw0KPj4gQEAgLTU4NTIsMTggKzU4NTIsMTEgQEAg
b3ZlcmxhcF9tZW1tYXBfaW5pdCh1bnNpZ25lZCBsb25nIHpvbmUsIHVuc2lnbmVkIGxvbmcgKnBm
bikNCj4+IC8qIFNraXAgUEZOcyB0aGF0IGJlbG9uZyB0byBub24tcHJlc2VudCBzZWN0aW9ucyAq
Lw0KPj4gc3RhdGljIGlubGluZSBfX21lbWluaXQgdW5zaWduZWQgbG9uZyBuZXh0X3Bmbih1bnNp
Z25lZCBsb25nIHBmbikNCj4+IHsNCj4+IC0gICAgdW5zaWduZWQgbG9uZyBzZWN0aW9uX25yOw0K
Pj4gKyAgICBjb25zdCB1bnNpZ25lZCBsb25nIHNlY3Rpb25fbnIgPSBwZm5fdG9fc2VjdGlvbl9u
cigrK3Bmbik7DQo+PiANCj4+IC0gICAgc2VjdGlvbl9uciA9IHBmbl90b19zZWN0aW9uX25yKCsr
cGZuKTsNCj4+ICAgIGlmIChwcmVzZW50X3NlY3Rpb25fbnIoc2VjdGlvbl9ucikpDQo+PiAgICAg
ICAgcmV0dXJuIHBmbjsNCj4+IC0NCj4+IC0gICAgd2hpbGUgKCsrc2VjdGlvbl9uciA8PSBfX2hp
Z2hlc3RfcHJlc2VudF9zZWN0aW9uX25yKSB7DQo+PiAtICAgICAgICBpZiAocHJlc2VudF9zZWN0
aW9uX25yKHNlY3Rpb25fbnIpKQ0KPj4gLSAgICAgICAgICAgIHJldHVybiBzZWN0aW9uX25yX3Rv
X3BmbihzZWN0aW9uX25yKTsNCj4+IC0gICAgfQ0KPj4gLQ0KPj4gLSAgICByZXR1cm4gLTE7DQo+
PiArICAgIHJldHVybiBzZWN0aW9uX25yX3RvX3BmbihuZXh0X3ByZXNlbnRfc2VjdGlvbl9ucihz
ZWN0aW9uX25yKSk7DQo+IA0KPiBUaGlzIGNoYW5nZXMgYmVoYXZpb3VyIGluIHRoZSBjb3JuZXIg
Y2FzZTogaWYgbmV4dF9wcmVzZW50X3NlY3Rpb25fbnIoKQ0KPiByZXR1cm5zIC0xLCB3ZSBjYWxs
IHNlY3Rpb25fbnJfdG9fcGZuKCkgZm9yIGl0LiBJdCdzIHVubGlrZWx5IHdvdWxkIGdpdmUNCj4g
YW55IHZhbGlkIHBmbiwgYnV0IEkgY2FuJ3Qgc2F5IGZvciBzdXJlIGZvciBhbGwgYXJjaHMuIEkg
Z3Vlc3MgdGhlIHdvcnN0DQo+IGNhc2Ugc2NlbnJpbyB3b3VsZCBiZSBlbmRsZXNzIGxvb3Agb3Zl
ciB0aGUgc2FtZSBzZWNpdG9ucy9wZm5zLg0KPiANCj4gSGF2ZSB5b3UgY29uc2lkZXJlZCB0aGUg
Y2FzZT8NCg0KWWVzLCBzZWUgdGhlIHBhdGNoIGRlc2NyaXB0aW9uLiBXZSByZXR1cm4gLTEgPDwg
UEZOX1NFQ1RJT05fU0hJRlQsIHNvIGEgbnVtYmVyIGNsb3NlIHRvIHRoZSBlbmQgb2YgdGhlIGFk
ZHJlc3Mgc3BhY2UgKDB4ZmZmLi4uMDAwKS4gKFdpbGwgZG91YmxlIGNoZWNrIHRvbW9ycm93IGlm
IGFueSAzMmJpdCBhcmNoIGNvdWxkIGJlIHByb2JsZW1hdGljIGhlcmUpDQoNClRoYW5rcyENCg0K
PiANCj4gLS0gDQo+IEtpcmlsbCBBLiBTaHV0ZW1vdg0KPiANCg==

