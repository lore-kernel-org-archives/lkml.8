Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88647C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 698BE207DD
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgEHIrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:47:53 -0400
Received: from m176150.mail.qiye.163.com ([59.111.176.150]:38851 "EHLO
        m176150.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgEHIrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:47:53 -0400
Received: from vivo.com (wm-10.qy.internal [127.0.0.1])
        by m176150.mail.qiye.163.com (Hmail) with ESMTP id 527F61A33D1;
        Fri,  8 May 2020 16:47:17 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AAsAdQBuCHzEtmuRTR69xqrg.3.1588927637309.Hmail.bernard@vivo.com>
To:     =?UTF-8?B?6LW15Yab5aWO?= <bernard@vivo.com>
Cc:     Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: =?UTF-8?B?UmU6UmU6UmU6IFtQQVRDSCB2Ml0gZHJtL2FybTogZml4ZXMgcGl4ZWwgY2xvY2sgZW5hYmxlZCB3aXRoIHdyb25nIGZvcm1hdA==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 157.0.31.122
In-Reply-To: <AKgAPAB2CNW-P97ALGekNqqN.3.1587728256276.Hmail.bernard@vivo.com>
MIME-Version: 1.0
Received: from bernard@vivo.com( [157.0.31.122) ] by ajax-webmail ( [127.0.0.1] ) ; Fri, 8 May 2020 16:47:17 +0800 (GMT+08:00)
From:   Bernard <bernard@vivo.com>
Date:   Fri, 8 May 2020 16:47:17 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VKQ0xLS0tJTE9NTkNJWVdZKFlBSE
        83V1ktWUFJV1kJDhceCFlBWTU0KTY6NyQpLjc#WQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhMT0pISkhMTkxJN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6Ogg6Hyo5DjgzAT4PFg4pLylNQgMKCRxVSFVKTkNDQklMTU9LT0hJVTMWGhIXVRkeCRUaCR87
        DRINFFUYFBZFWVdZEgtZQVlKTkxVS1VISlVKSUlZV1kIAVlBTExDSjcG
X-HM-Tid: 0a71f377a76193b4kuws527f61a33d1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogIui1teWGm+WljiIgPGJlcm5hcmRAdml2by5jb20+CkRhdGU6IDIwMjAtMDQtMjQgMTk6
Mzc6MzYKVG86ICBMaXZpdSBEdWRhdSA8bGl2aXUuZHVkYXVAYXJtLmNvbT4KQ2M6ICBCcmlhbiBT
dGFya2V5IDxicmlhbi5zdGFya2V5QGFybS5jb20+LERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51
eC5pZT4sRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPixkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnLGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcsb3BlbnNvdXJjZS5rZXJu
ZWxAdml2by5jb20KU3ViamVjdDogUmU6UmU6IFtQQVRDSCB2Ml0gZHJtL2FybTogZml4ZXMgcGl4
ZWwgY2xvY2sgZW5hYmxlZCB3aXRoIHdyb25nIGZvcm1hdAoKCgoKRnJvbTogTGl2aXUgRHVkYXUg
PGxpdml1LmR1ZGF1QGFybS5jb20+CkRhdGU6IDIwMjAtMDQtMjQgMTk6MDk6NTAKVG86ICBCZXJu
YXJkIFpoYW8gPGJlcm5hcmRAdml2by5jb20+CkNjOiAgQnJpYW4gU3RhcmtleSA8YnJpYW4uc3Rh
cmtleUBhcm0uY29tPixEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+LERhbmllbCBWZXR0
ZXIgPGRhbmllbEBmZndsbC5jaD4sZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZyxsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLG9wZW5zb3VyY2Uua2VybmVsQHZpdm8uY29tClN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjJdIGRybS9hcm06IGZpeGVzIHBpeGVsIGNsb2NrIGVuYWJsZWQgd2l0
aCB3cm9uZyBmb3JtYXQ+SGkgQmVybmFuZCwKPgo+T24gVGh1LCBBcHIgMjMsIDIwMjAgYXQgMTE6
MzU6NTFQTSAtMDcwMCwgQmVybmFyZCBaaGFvIHdyb3RlOgo+PiBUaGUgcGl4ZWwgY2xvY2sgaXMg
c3RpbGwgZW5hYmxlZCB3aGVuIHRoZSBmb3JtYXQgaXMgd3JvbmcuCj4+IG5vIGVycm9yIGJyYW5j
aCBoYW5kbGUsIGFuZCBhbHNvIHNvbWUgcmVnaXN0ZXIgaXMgbm90IHNldAo+PiBpbiB0aGlzIGNh
c2UsIGUuZzogSERMQ0RfUkVHXzxjb2xvcj5fU0VMRUNULiBNYXliZSB3ZQo+PiBzaG91bGQgZGlz
YWJsZSB0aGlzIGNsb2NrIGFuZCB0aHJvdyBhbiB3YXJuIG1lc3NhZ2Ugd2hlbgo+PiB0aGlzIGhh
cHBlbmVkLgo+PiBXaXRoIHRoaXMgY2hhbmdlLCB0aGUgY29kZSBtYXliZSBhIGJpdCBtb3JlIHJl
YWRhYmxlLgo+PiAKPj4gU2lnbmVkLW9mZi1ieTogQmVybmFyZCBaaGFvIDxiZXJuYXJkQHZpdm8u
Y29tPgo+PiAKPj4gQ2hhbmdlcyBzaW5jZSBWMToKPj4gKmFkZCBmb3JtYXQgZXJyb3IgaGFuZGxl
LCBpZiBmb3JtYXQgaXMgbm90IGNvcnJlY3QsIHRocm93Cj4+IGFuIHdhcm5pbmcgbWVzc2FnZSBh
bmQgZGlzYWJsZSB0aGlzIGNsb2NrLgo+PiAKPj4gTGluayBmb3IgVjE6Cj4+ICpodHRwczovL2xv
cmUua2VybmVsLm9yZy9wYXRjaHdvcmsvcGF0Y2gvMTIyODUwMS8KPj4gLS0tCj4+ICBkcml2ZXJz
L2dwdS9kcm0vYXJtL2hkbGNkX2NydGMuYyB8IDEzICsrKysrKysrKy0tLS0KPj4gIDEgZmlsZSBj
aGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4+IAo+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FybS9oZGxjZF9jcnRjLmMgYi9kcml2ZXJzL2dwdS9kcm0vYXJt
L2hkbGNkX2NydGMuYwo+PiBpbmRleCBhZjY3ZmVmZWQzOGQuLmYzOTQ1ZGVlMmI3ZCAxMDA2NDQK
Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FybS9oZGxjZF9jcnRjLmMKPj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FybS9oZGxjZF9jcnRjLmMKPj4gQEAgLTk2LDcgKzk2LDcgQEAgc3RhdGljIGlu
dCBoZGxjZF9zZXRfcHhsX2ZtdChzdHJ1Y3QgZHJtX2NydGMgKmNydGMpCj4+ICAJfQo+PiAgCj4+
ICAJaWYgKFdBUk5fT04oIWZvcm1hdCkpCj4+IC0JCXJldHVybiAwOwo+PiArCQlyZXR1cm4gLUVJ
TlZBTDsKPgo+VGhhdCBpcyB0aGUgcmlnaHQgZml4IQo+Cj4+ICAKPj4gIAkvKiBIRExDRCB1c2Vz
ICdieXRlcyBwZXIgcGl4ZWwnLCB6ZXJvIG1lYW5zIDEgYnl0ZSAqLwo+PiAgCWJ0cHAgPSAoZm9y
bWF0LT5iaXRzX3Blcl9waXhlbCArIDcpIC8gODsKPj4gQEAgLTEyNSw3ICsxMjUsNyBAQCBzdGF0
aWMgaW50IGhkbGNkX3NldF9weGxfZm10KHN0cnVjdCBkcm1fY3J0YyAqY3J0YykKPj4gIAlyZXR1
cm4gMDsKPj4gIH0KPj4gIAo+PiAtc3RhdGljIHZvaWQgaGRsY2RfY3J0Y19tb2RlX3NldF9ub2Zi
KHN0cnVjdCBkcm1fY3J0YyAqY3J0YykKPj4gK3N0YXRpYyBpbnQgaGRsY2RfY3J0Y19tb2RlX3Nl
dF9ub2ZiKHN0cnVjdCBkcm1fY3J0YyAqY3J0YykKPgo+QnV0IHRoaXMgaXMgbm90LiBXZSBkb24n
dCBuZWVkIHRvIHByb3BhZ2F0ZSB0aGUgZXJyb3IgZnVydGhlciwganVzdCAuLi4uCj4KPj4gIHsK
Pj4gIAlzdHJ1Y3QgaGRsY2RfZHJtX3ByaXZhdGUgKmhkbGNkID0gY3J0Y190b19oZGxjZF9wcml2
KGNydGMpOwo+PiAgCXN0cnVjdCBkcm1fZGlzcGxheV9tb2RlICptID0gJmNydGMtPnN0YXRlLT5h
ZGp1c3RlZF9tb2RlOwo+PiBAQCAtMTYyLDkgKzE2MiwxMCBAQCBzdGF0aWMgdm9pZCBoZGxjZF9j
cnRjX21vZGVfc2V0X25vZmIoc3RydWN0IGRybV9jcnRjICpjcnRjKQo+PiAgCj4+ICAJZXJyID0g
aGRsY2Rfc2V0X3B4bF9mbXQoY3J0Yyk7Cj4+ICAJaWYgKGVycikKPj4gLQkJcmV0dXJuOwo+CgpN
eSBwcmV2aW91cyB1bmRlcnN0YW5kaW5nIHdhcyB0aGF0IHdoZW4gc3VjaCBhbiBleGNlcHRpb24g
b2NjdXJyZWQsIGl0IHdhcyBjYXVnaHQKaW4gdGhlIGF0b21pY19lbmFibGUgaW50ZXJmYWNlLCBh
bmQgdGhlbiBkaXNhYmxlIHBpeGVsIGNsb2NrLiBJIGFtIG5vdCBzdXJlIGlzIHRoaXMgb2sgb3IK
aSBoYXZlIHRvIGRvIG1vcmUgcmVnaXN0ZXIgY2xlYW4gb3BlcmFjdGlvbi4KCj4uLi4gcmV0dXJu
IGhlcmUgc28gdGhhdCB3ZSBkb24ndCBjYWxsIGNsa19zZXRfcmF0ZSgpOwpBbmQgZm9yIHRoaXMg
cGFydCwgaSBhbSBhIGxpdHRsZSBjb25mdXNlZCA6CjEgY2xrX3NldF9yYXRlIG11c3QgYmUgc2V0
IGV2ZW4gaWYgZm9ybWF0IGlzIHdyb25nPwoyIFRoZSBvcmlnaW5hbCBjb2RlIGxvZ2ljIHNob3dz
IHRoYXQgSWYgZm9ybWF0IGlzIG5vdCBjb3JyZWN0LCB3ZSB3aWxsIG5vdCBzZXQgcmVnaXN0ZXJz
IApIRExDRF9SRUdfUElYRUxfRk9STUFUICYgSERMQ0RfUkVHXzxjb2xvcj5fU0VMRUNULCB3aWxs
IHRoaXMgYnJpbmcgaW4KYW55IHByb2JsZW1zPwozIGlmIDEgdGhlIHJhdGUgbXVzdCBzZXQgJiAy
IHJlZ2lzdGVycyBhYm92ZSBkb2VzbmB0IG1hdHRlciwgdGhlbiBtYXliZSB0aGVyZSBpcyBubwpu
ZWVkIHRvIGRpc2FibGUgcGl4ZWwgY2xvY2suCkFtIGkgbWlzdW5kZXJzdGFuZGluZwoKUmVnYXJk
cywKQmVybmFyZAoKPj4gKwkJcmV0dXJuIGVycjsKPj4gIAo+PiAgCWNsa19zZXRfcmF0ZShoZGxj
ZC0+Y2xrLCBtLT5jcnRjX2Nsb2NrICogMTAwMCk7Cj4+ICsJcmV0dXJuIDA7Cj4+ICB9Cj4+ICAK
Pj4gIHN0YXRpYyB2b2lkIGhkbGNkX2NydGNfYXRvbWljX2VuYWJsZShzdHJ1Y3QgZHJtX2NydGMg
KmNydGMsCj4+IEBAIC0xNzMsNyArMTc0LDExIEBAIHN0YXRpYyB2b2lkIGhkbGNkX2NydGNfYXRv
bWljX2VuYWJsZShzdHJ1Y3QgZHJtX2NydGMgKmNydGMsCj4+ICAJc3RydWN0IGhkbGNkX2RybV9w
cml2YXRlICpoZGxjZCA9IGNydGNfdG9faGRsY2RfcHJpdihjcnRjKTsKPj4gIAo+PiAgCWNsa19w
cmVwYXJlX2VuYWJsZShoZGxjZC0+Y2xrKTsKPj4gLQloZGxjZF9jcnRjX21vZGVfc2V0X25vZmIo
Y3J0Yyk7Cj4+ICsJaWYgKGhkbGNkX2NydGNfbW9kZV9zZXRfbm9mYihjcnRjKSkgewo+PiArCQlE
Uk1fREVCVUdfS01TKCJJbnZhbGlkIGZvcm1hdCwgcGl4ZWwgY2xvY2sgZW5hYmxlIGZhaWxlZCFc
biIpOwo+PiArCQljbGtfZGlzYWJsZV91bnByZXBhcmUoaGRsY2QtPmNsayk7Cj4+ICsJCXJldHVy
bjsKPj4gKwl9Cj4+ICAJaGRsY2Rfd3JpdGUoaGRsY2QsIEhETENEX1JFR19DT01NQU5ELCAxKTsK
Pj4gIAlkcm1fY3J0Y192Ymxhbmtfb24oY3J0Yyk7Cj4+ICB9Cj4+IC0tIAo+PiAyLjI2LjIKPj4g
Cj4KPi0tIAo+PT09PT09PT09PT09PT09PT09PT0KPnwgSSB3b3VsZCBsaWtlIHRvIHwKPnwgZml4
IHRoZSB3b3JsZCwgIHwKPnwgYnV0IHRoZXkncmUgbm90IHwKPnwgZ2l2aW5nIG1lIHRoZSAgIHwK
PiBcIHNvdXJjZSBjb2RlISAgLwo+ICAtLS0tLS0tLS0tLS0tLS0KPiAgICDCr1xfKOODhClfL8Kv
CgoNCg0K
