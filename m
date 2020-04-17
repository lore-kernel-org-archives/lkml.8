Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07244C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E14B321D94
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgDQHEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:04:36 -0400
Received: from m142-177.yeah.net ([123.58.177.142]:9121 "EHLO
        m142-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgDQHEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:04:35 -0400
Received: from vivo.com (localhost [127.0.0.1])
        by m142-177.yeah.net (Hmail) with ESMTP id 397A4644168;
        Fri, 17 Apr 2020 15:04:29 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AO6ABADMCK4udBOCpij0-KpN.3.1587107069183.Hmail.wenhu.wang@vivo.com>
To:     Scott Wood <oss@buserror.net>
Cc:     Rob Herring <robh@kernel.org>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, christophe.leroy@c-s.fr,
        linuxppc-dev@lists.ozlabs.org, kernel@vivo.com
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSCB2NCw0LzRdIGRyaXZlcnM6IHVpbzogbmV3IGRyaXZlciBmb3IgZnNsXzg1eHhfY2FjaGVfc3JhbQ==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.251.74.226
In-Reply-To: <64bb1f056abd8bfab2befef5d1e6baec2056077f.camel@buserror.net>
MIME-Version: 1.0
Received: from wenhu.wang@vivo.com( [58.251.74.226) ] by ajax-webmail ( [127.0.0.1] ) ; Fri, 17 Apr 2020 15:04:29 +0800 (GMT+08:00)
From:   =?UTF-8?B?546L5paH6JmO?= <wenhu.wang@vivo.com>
Date:   Fri, 17 Apr 2020 15:04:29 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VKS01CQkJDTE9KSk9CQllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhMSUxMT0pKSkNPN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6NE06OTo*NjgwTw4fOTQ4CxIRS1YwCzVVSFVKTkNMSktMS0xKT09NVTMWGhIXVQweFRMOVQwa
        FRw7DRINFFUYFBZFWVdZEgtZQVlOQ1VJTkpVTE9VSUlNWVdZCAFZQU1DSUo3Bg++
X-HM-Tid: 0a7186f3fd3b6473kurs397a4644168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4+ID4gPiBPbiBUaHUsIDIwMjAtMDQtMTYgYXQgMDg6MzUgLTA3MDAsIFdhbmcgV2VuaHUgd3Jv
dGU6Cj4+ID4gPiA+ICsjZGVmaW5lIFVJT19JTkZPX1ZFUgkiZGV2aWNldHJlZSxwc2V1ZG8iCj4+
ID4gPiAKPj4gPiA+IFdoYXQgZG9lcyB0aGlzIG1lYW4/ICBDaGFuZ2luZyBhIG51bWJlciBpbnRv
IGEgbm9uLW9idmlvdXMgc3RyaW5nIChXaHkKPj4gPiA+ICJwc2V1ZG8iPyAgV2h5IGRvZXMgdGhl
IFVJTyB1c2VyIGNhcmUgdGhhdCB0aGUgY29uZmlnIGNhbWUgZnJvbSB0aGUKPj4gPiA+IGRldmlj
ZQo+PiA+ID4gdHJlZT8pIGp1c3QgdG8gYXZvaWQgc2V0dGluZyBvZmYgR3JlZydzIHZlcnNpb24g
bnVtYmVyIGF1dG9yZXNwb25zZQo+PiA+ID4gaXNuJ3QKPj4gPiA+IHJlYWxseSBoZWxwaW5nIGFu
eXRoaW5nLgpBcyBJIG1lbnRpb25lZCBiZWZvcmUsIHRoaXMgaXMgbm90IGN1cnJlbnRseSBtZWFu
aW5nZnVsIGZvciB1cywgYW5kIG1heWJlIHRoZSBiZXR0ZXIKd2F5IGlzIHRvIHNldCBpdCBvcHRp
b25hbGx5IGZvciB1aW8sIGJ1dCBpdCBiZWxvbmdzIHRvIHVpbyBjb3JlLCB3aGljaCBpcyBhIGZy
YW1ld29yayBmb3IKZGlmZmVyZW50IGtpbmQgb2YgZHJpdmVycyBvciBkZXZpY2VzLCBidXQgbm90
IG9ubHkgZm9yIHVzLiBTbyBJIGd1ZXNzIHRoaXMgaXMgbm90IGEgdGhpbmcKdHJvdWJsZXMgYW5k
IGFyZ3VpbmcgYWJvdXQgdGhpcyBpcyByZWFsbHkgaGVscGxlc3MuCgo+PiA+ID4gCj4+ID4gPiA+
ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCB1aW9fbXBjODV4eF9sMmN0bHJfb2Zf
bWF0Y2hbXSA9IHsKPj4gPiA+ID4gKwl7CS5jb21wYXRpYmxlID0gInVpbyxtcGM4NXh4LWNhY2hl
LXNyYW0iLAl9LAo+PiA+IAo+PiA+IEZvcm0gaXMgPHZlbmRvcj4sPGRldmljZT4gYW5kICJ1aW8i
IGlzIG5vdCBhIHZlbmRvciAoYW5kIG5ldmVyIHdpbGwgYmUpLgo+PiA+IAo+PiAKPj4gU2hvdWxk
IGhhdmUgYmVlbiBzb21ldGhpbmcgbGlrZSAiZnNsLG1wYzg1eHgtY2FjaGUtc3JhbS11aW8iLCBh
bmQgaWYgaXQgaXMKPj4gdG8gYmUgZGVmaW5lZCB3aXRoIG1vZHVsZSBwYXJhbWV0ZXJzLCB0aGlz
IHdvdWxkIGJlIHVzZXIgZGVmaW5lZC4KPj4gQW55d2F5LCA8dmVuZG9yPiw8ZGV2aWNlPiBzaG91
bGQgYWx3YXlzIGJlIHVzZWQuCj4+IAo+PiA+ID4gPiArCXt9LAo+PiA+ID4gPiArfTsKPj4gPiA+
ID4gKwo+PiA+ID4gPiArc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgdWlvX2ZzbF84NXh4
X2NhY2hlX3NyYW0gPSB7Cj4+ID4gPiA+ICsJLnByb2JlID0gdWlvX2ZzbF84NXh4X2NhY2hlX3Ny
YW1fcHJvYmUsCj4+ID4gPiA+ICsJLnJlbW92ZSA9IHVpb19mc2xfODV4eF9jYWNoZV9zcmFtX3Jl
bW92ZSwKPj4gPiA+ID4gKwkuZHJpdmVyID0gewo+PiA+ID4gPiArCQkubmFtZSA9IERSSVZFUl9O
QU1FLAo+PiA+ID4gPiArCQkub3duZXIgPSBUSElTX01PRFVMRSwKPj4gPiA+ID4gKwkJLm9mX21h
dGNoX3RhYmxlCT0gdWlvX21wYzg1eHhfbDJjdGxyX29mX21hdGNoLAo+PiA+ID4gPiArCX0sCj4+
ID4gPiA+ICt9Owo+PiA+ID4gCj4+ID4gPiBHcmVnJ3MgY29tbWVudCBub3R3aXRoc3RhbmRpbmcs
IEkgcmVhbGx5IGRvbid0IHRoaW5rIHRoaXMgYmVsb25ncyBpbiB0aGUKPj4gPiA+IGRldmljZSB0
cmVlIChhbmQgaWYgSSBkbyBnZXQgb3ZlcnJ1bGVkIG9uIHRoYXQgcG9pbnQsIGl0IGF0IGxlYXN0
IG5lZWRzCj4+ID4gPiBhCj4+ID4gPiBiaW5kaW5nIGRvY3VtZW50KS4gIExldCBtZSB0cnkgdG8g
Y29tZSB1cCB3aXRoIGEgcGF0Y2ggZm9yIGR5bmFtaWMKPj4gPiA+IGFsbG9jYXRpb24uCj4+ID4g
Cj4+ID4gQWdyZWVkLiAiVUlPIiBiaW5kaW5ncyBoYXZlIGxvbmcgYmVlbiByZWplY3RlZC4KPj4g
PiAKPj4gCj4+IFNvdW5kcyBpdCBpcy4gQW5kIGRvZXMgdGhlIG1vZGlmaWNhdGlvbiBiZWxvdyBm
aXQgd2VsbD8KPj4gLS0tCj4+IC1zdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCB1aW9f
bXBjODV4eF9sMmN0bHJfb2ZfbWF0Y2hbXSA9IHsKPj4gLSAgICAgICB7ICAgICAgIC5jb21wYXRp
YmxlID0gInVpbyxtcGM4NXh4LWNhY2hlLXNyYW0iLCB9LAo+PiAtICAgICAgIHt9LAo+PiArI2lm
ZGVmIENPTkZJR19PRgo+PiArc3RhdGljIHN0cnVjdCBvZl9kZXZpY2VfaWQgdWlvX2ZzbF84NXh4
X2NhY2hlX3NyYW1fb2ZfbWF0Y2hbXSA9IHsKPj4gKyAgICAgICB7IC8qIFRoaXMgaXMgZmlsbGVk
IHdpdGggbW9kdWxlX3Bhcm0gKi8gfSwKPj4gKyAgICAgICB7IC8qIFNlbnRpbmVsICovIH0sCj4+
ICB9Owo+PiArTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgdWlvX2ZzbF84NXh4X2NhY2hlX3NyYW1f
b2ZfbWF0Y2gpOwo+PiArbW9kdWxlX3BhcmFtX3N0cmluZyhvZl9pZCwgdWlvX2ZzbF84NXh4X2Nh
Y2hlX3NyYW1fb2ZfbWF0Y2hbMF0uY29tcGF0aWJsZSwKPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHNpemVvZih1aW9fZnNsXzg1eHhfY2FjaGVfc3JhbV9vZl9tYXRjaFswXS5jb21wYQo+
PiB0aWJsZSksIDApOwo+PiArTU9EVUxFX1BBUk1fREVTQyhvZl9pZCwgInBsYXRmb3JtIGRldmlj
ZSBpZCB0byBiZSBoYW5kbGVkIGJ5IGNhY2hlLXNyYW0tCj4+IHVpbyIpOwo+PiArI2VuZGlmCj4K
Pk5vLiAgVGhlIHBvaW50IGlzIHRoYXQgeW91IHdvdWxkbid0IGJlIGNvbmZpZ3VyaW5nIHRoaXMg
d2l0aCB0aGUgZGV2aWNlIHRyZWUKPmF0IGFsbC4KPgpJdCB3YXMgdG8gZml0IGZvciB0aGUgdW5i
aW5kaW5nIHJlcXVyaWVtZW50LiBBbmQgSSBtZW50aW9uZWQgd2hhdCBpZiBJIHdhbnQgdG8gY3Jl
YXRlCm1vcmUgdGhhbiBvbmUgZGV2aWNlIGFuZCBlYWNoIG93bnMgbXVsdGlwbGUgdWlvbWFwcz8K
RGV2aWNldHJlZSBpcyBkZWZpbml0ZWx5IGJldHRlciBjaG9pY2UgdG8gc29sdmUgdGhlIHByb2Js
ZW0gYW5kIG1ha2UgdGhlIGRyaXZlciBtb3JlCmNvbnZlbmllbnQgZm9yIHVzZXJzIHRvIHVzZS4g
UHNldWRvIGRldmljZSBpcyBhIGRldmljZSBhbmQgYSBkZXZpY2UuIE9yIGVsc2UgZGV2aWNlCnRy
ZWUgc2hvdWxkIGJlIGhhcmR3YXJlLW9ubHktZGV2aWNldHJlZS4KClRoZSBwb2ludCBpcyB3aHkg
d2UgbGVmdCB0aGUgYmV0dGVyIGNob2ljZSBhbmQgd3JpdGUgYSBwbGVudHkgb2YgcmVkdW5kYW50
IGNvZGVzCnRvIHBhcnNlIHRoZSBtb2R1bGUgcGFyYW1ldGVycz8KCkZ1cnRoZXIgbW9yZSwgSSBk
b24ndCB0aGluayB0aGVyZSBpcyBlbm91Z2ggcmVhc29uIGZvciB0aGUgbG93ZXIgZHJpdmVyIG1w
Yzg1eHggY2FjaGUtc3JhbQp0byByZXN0cmljdCBvdGhlciBmcm9tIHVzaW5nIGl0IGluIGEgd2F5
IG9mIG1vZHVsZSBwYXJhbSBvciBkeW5hbWljIGFsbG9jYXRpb24gd2l0aCBpb2N0bCBvciBzby4K
ClVJTyBpcyB0aGVyZSBhbmQgYWxsIHRoZXNlIHBhcnRzIGNvb3BlcmF0ZSB3ZWxsIHRvIG1ha2Ug
dGhlIGNhY2hlLXNyYW0gbW9yZSB1c2VmdWwgYW5kIGJldHRlcgpyZXNvbHZlIHVzZXIgcmVxdWly
ZW1lbnQuCgpJIHdpbGwgdXBkYXRlIHRoZSBwYXRjaCB3aXRoIHRoZSBkaWZmIGFwcGxpZWQgaW4g
djUuCgpUaGFua3MsCldlbmh1DQoNCg==
