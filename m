Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F004C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22FCB20857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgDQOQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 10:16:41 -0400
Received: from mail-m127107.qiye.163.com ([115.236.127.107]:2888 "EHLO
        mail-m127107.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgDQOQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:16:40 -0400
Received: from vivo.com (wm-12.qy.internal [127.0.0.1])
        by mail-m127107.qiye.163.com (Hmail) with ESMTP id 63ABA8224E;
        Fri, 17 Apr 2020 22:16:27 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <APIAAAABCKquIIhDNOkcHqp9.3.1587132987353.Hmail.wenhu.wang@vivo.com>
To:     Scott Wood <oss@buserror.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org,
        kernel@vivo.com
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2NCw0LzRdIGRyaXZlcnM6IHVpbzogbmV3IGRyaXZlciBmb3IgZnNsXzg1eHhfY2FjaGVfc3JhbQ==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.251.74.226
In-Reply-To: <ede379a75ec60ccba90cd393a3a2e70b410191fa.camel@buserror.net>
MIME-Version: 1.0
Received: from wenhu.wang@vivo.com( [58.251.74.226) ] by ajax-webmail ( [127.0.0.1] ) ; Fri, 17 Apr 2020 22:16:27 +0800 (GMT+08:00)
From:   =?UTF-8?B?546L5paH6JmO?= <wenhu.wang@vivo.com>
Date:   Fri, 17 Apr 2020 22:16:27 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VPQkhLS0tLSEtOSkxOQ1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhMSUNPSktITE9PN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6KzI6Ojo6OTgwCg4yMhM*NTQQGDMKC0JVSFVKTkNMSkhJQkNCT0xLVTMWGhIXVQweFRMOVQwa
        FRw7DRINFFUYFBZFWVdZEgtZQVlOQ1VJTkpVTE9VSUlNWVdZCAFZQU9CQkw3Bg++
X-HM-Tid: 0a71887f7817986bkuuu63aba8224e
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pk9uIEZyaSwgMjAyMC0wNC0xNyBhdCAwOTo0MiArMDIwMCwgR3JlZyBLSCB3cm90ZTo+PiBPbiBU
aHUsIEFwciAxNiwgMjAyMCBhdCAxMTo1ODoyOVBNIC0wNTAwLCBTY290dCBXb29kIHdyb3RlOgo+
PiA+IE9uIEZyaSwgMjAyMC0wNC0xNyBhdCAxMDozMSArMDgwMCwg546L5paH6JmOIHdyb3RlOgo+
PiA+ID4gU291bmRzIGl0IGlzLiBBbmQgZG9lcyB0aGUgbW9kaWZpY2F0aW9uIGJlbG93IGZpdCB3
ZWxsPwo+PiA+ID4gLS0tCj4+ID4gPiAtc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQg
dWlvX21wYzg1eHhfbDJjdGxyX29mX21hdGNoW10gPSB7Cj4+ID4gPiAtICAgICAgIHsgICAgICAg
LmNvbXBhdGlibGUgPSAidWlvLG1wYzg1eHgtY2FjaGUtc3JhbSIsIH0sCj4+ID4gPiAtICAgICAg
IHt9LAo+PiA+ID4gKyNpZmRlZiBDT05GSUdfT0YKPj4gPiA+ICtzdGF0aWMgc3RydWN0IG9mX2Rl
dmljZV9pZCB1aW9fZnNsXzg1eHhfY2FjaGVfc3JhbV9vZl9tYXRjaFtdID0gewo+PiA+ID4gKyAg
ICAgICB7IC8qIFRoaXMgaXMgZmlsbGVkIHdpdGggbW9kdWxlX3Bhcm0gKi8gfSwKPj4gPiA+ICsg
ICAgICAgeyAvKiBTZW50aW5lbCAqLyB9LAo+PiA+ID4gIH07Cj4+ID4gPiArTU9EVUxFX0RFVklD
RV9UQUJMRShvZiwgdWlvX2ZzbF84NXh4X2NhY2hlX3NyYW1fb2ZfbWF0Y2gpOwo+PiA+ID4gK21v
ZHVsZV9wYXJhbV9zdHJpbmcob2ZfaWQsCj4+ID4gPiB1aW9fZnNsXzg1eHhfY2FjaGVfc3JhbV9v
Zl9tYXRjaFswXS5jb21wYXRpYmxlLAo+PiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
IHNpemVvZih1aW9fZnNsXzg1eHhfY2FjaGVfc3JhbV9vZl9tYXRjaFswXS5jCj4+ID4gPiBvbXBh
Cj4+ID4gPiB0aWJsZSksIDApOwo+PiA+ID4gK01PRFVMRV9QQVJNX0RFU0Mob2ZfaWQsICJwbGF0
Zm9ybSBkZXZpY2UgaWQgdG8gYmUgaGFuZGxlZCBieSBjYWNoZS0KPj4gPiA+IHNyYW0tCj4+ID4g
PiB1aW8iKTsKPj4gPiA+ICsjZW5kaWYKPj4gPiAKPj4gPiBOby4gIFRoZSBwb2ludCBpcyB0aGF0
IHlvdSB3b3VsZG4ndCBiZSBjb25maWd1cmluZyB0aGlzIHdpdGggdGhlIGRldmljZQo+PiA+IHRy
ZWUKPj4gPiBhdCBhbGwuCj4+IAo+PiBXYWl0LCB3aHkgbm90PyAgRG9uJ3QgZm9yY2UgcGVvcGxl
IHRvIHVzZSBtb2R1bGUgcGFyYW1ldGVycywgdGhhdCBpcwo+PiBjcmF6eS4gIERUIGRlc2NyaWJl
cyB0aGUgaGFyZHdhcmUgaW52b2x2ZWQsIGlmIHNvbWVvbmUgd2FudHMgdG8gYmluZCB0bwo+PiBh
IHNwZWNpZmljIHJhbmdlIG9mIG1lbW9yeSwgYXMgZGVzY3JpYmVkIGJ5IERULCB3aHkgY2FuJ3Qg
dGhleSBkbyBzbz8KPgo+WWVzLCBEVCBkZXNjcmliZXMgdGhlIGhhcmR3YXJlLCBhbmQgYXMgSSd2
ZSBzYWlkIGEgY291cGxlIHRpbWVzIGFscmVhZHksIHRoaXMKPmlzbid0IGhhcmR3YXJlIGRlc2Ny
aXB0aW9uLgo+Cj5JJ20gbm90IGZvcmNpbmcgcGVvcGxlIHRvIHVzZSBtb2R1bGUgcGFyYW1ldGVy
cy4gIFRoYXQgd2FzIGEgbGVhc3QtZWZmb3J0Cj5zdWdnZXN0aW9uIHRvIGF2b2lkIGFidXNpbmcg
dGhlIERULiAgSSBsYXRlciBzYWlkIEknZCB0cnkgdG8gY29tZSB1cCB3aXRoIGEKPnBhdGNoIHRo
YXQgYWxsb2NhdGVzIHJlZ2lvbnMgZHluYW1pY2FsbHkgKGFuZCBtb3N0IGxpa2VseSBkb2Vzbid0
IHVzZSBVSU8gYXQKPmFsbCkuCj4KPj4gSSBjYW4gdW5kZXJzdGFuZCBub3QgbGlraW5nIHRoZSBu
YW1lICJ1aW8iIGluIGEgZHQgdHJlZSwgYnV0IHRoZXJlJ3Mgbm8KPj4gcmVhc29uIHRoYXQgRFQg
Y2FuIG5vdCBkZXNjcmliZSB3aGF0IGEgZHJpdmVyIGJpbmRzIHRvIGhlcmUuCj4KPlRoZSBEVCBh
bHJlYWR5IGRlc2NyaWJlcyB0aGlzIGhhcmR3YXJlLCBhbmQgdGhlcmUgaXMgYWxyZWFkeSBjb2Rl
IHRoYXQgYmluZHMKPnRvIGl0LiAgVGhpcyBwYXRjaCBpcyB0cnlpbmcgdG8gYWRkIGEgc2Vjb25k
IG5vZGUgZm9yIGl0IHdpdGggY29uZmlndXJhdGlvbi4KPgpIaSwgU2NvdHQsIEdyZWcsClNlZW1z
IGxpa2Ugbm8gYmFsYW5jZSBoZXJlLiBIb3cgYWJvdXQgSSBpbXBsZW1lbnQgYSBkcml2ZXIgb2Yg
dWlvIGluY2x1ZGluZwp0aGUgbDJjdHJsIGFuZCBjYWNoZV9zcmFtIHJlbGF0ZWQgaW1wbGVtZW50
YXRpb25zPwpBbmQgdGhpcyB3YXksIHRoZSBkcml2ZXIgd291bGQgYmUgYSBoYXJkd2FyZSBsZXZl
bCBkcml2ZXIgYW5kIHRhcmdldGVkIGZvciB1aW8uCgpSZWdhcmRzLApXZW5odQoNCg0K
