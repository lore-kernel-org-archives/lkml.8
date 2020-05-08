Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCD2C54E49
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89560207DD
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgEHIpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:45:03 -0400
Received: from m176150.mail.qiye.163.com ([59.111.176.150]:33163 "EHLO
        m176150.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgEHIo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:44:56 -0400
Received: from vivo.com (wm-10.qy.internal [127.0.0.1])
        by m176150.mail.qiye.163.com (Hmail) with ESMTP id 4293E1A3189;
        Fri,  8 May 2020 16:44:20 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AEMAEgD6CFDEXGkP4OWX94rO.3.1588927460255.Hmail.bernard@vivo.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gZHJtL2V4eW5vczogcmVtb3ZlIG5vIG5lZWQgZGV2bV9rZnJlZSBpbiBwcm9iZSBbcmUtc2VuZCwgd2VsY29tZSBhbnkgY29tbWVudHNd?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 157.0.31.122
In-Reply-To: <20200508075210.GA8789@ravnborg.org>
MIME-Version: 1.0
Received: from bernard@vivo.com( [157.0.31.122) ] by ajax-webmail ( [127.0.0.1] ) ; Fri, 8 May 2020 16:44:20 +0800 (GMT+08:00)
From:   Bernard <bernard@vivo.com>
Date:   Fri, 8 May 2020 16:44:20 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVNQk1LS0tLQkJKQ0lKSFlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhMTU5ITkNJTUJKN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6PjY6Phw*TTg9Pz4jPBArTzQsI0JPCTRVSFVKTkNDQklMT01OSE1JVTMWGhIXVRkeCRUaCR87
        DRINFFUYFBZFWVdZEgtZQVlKTkxVS1VISlVKSUlZV1kIAVlBTUlPSjcG
X-HM-Tid: 0a71f374f3bc93b4kuws4293e1a3189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpGcm9tOiBTYW0gUmF2bmJvcmcgPHNhbUByYXZuYm9yZy5vcmc+CkRhdGU6IDIwMjAtMDUtMDgg
MTU6NTI6MTAKVG86ICBCZXJuYXJkIDxiZXJuYXJkQHZpdm8uY29tPgpDYzogIElua2kgRGFlIDxp
bmtpLmRhZUBzYW1zdW5nLmNvbT4sSm9vbnlvdW5nIFNoaW0gPGp5MDkyMi5zaGltQHNhbXN1bmcu
Y29tPixTZXVuZy1Xb28gS2ltIDxzdzAzMTIua2ltQHNhbXN1bmcuY29tPixLeXVuZ21pbiBQYXJr
IDxreXVuZ21pbi5wYXJrQHNhbXN1bmcuY29tPixEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXgu
aWU+LERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4sS3VramluIEtpbSA8a2dlbmVAa2Vy
bmVsLm9yZz4sS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPixkcmktZGV2ZWxA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnLGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZyxsaW51eC1zYW1zdW5nLXNvY0B2Z2VyLmtlcm5lbC5vcmcsbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZyxvcGVuc291cmNlLmtlcm5lbEB2aXZvLmNvbQpTdWJqZWN0OiBSZTogW1BBVENIXSBk
cm0vZXh5bm9zOiByZW1vdmUgbm8gbmVlZCBkZXZtX2tmcmVlIGluIHByb2JlIFtyZS1zZW5kLCB3
ZWxjb21lIGFueSBjb21tZW50c10+SGkgQmVybmFyZC4KPgo+T24gV2VkLCBNYXkgMDYsIDIwMjAg
YXQgMDg6NDk6MDNQTSArMDgwMCwgQmVybmFyZCB3cm90ZToKPj4gUmVtb3ZlIG5vIG5lZWQgZGV2
bV9rZnJlZSBpbiBwcm9iZS4KPj4gVGhlIGNoYW5nZSBpcyB0byBtYWtlIHRoZSBjb2RlIGEgYml0
IG1vcmUgcmVhZGFibGUKPj4gCj4+IFNpZ25lZC1vZmYtYnk6IEJlcm5hcmQgWmhhbyA8YmVybmFy
ZEB2aXZvLmNvbT4KPgo+Q291bGQgeW91IHRha2UgYSBjbG9zZXIgbG9vayBhbmQgZml4IHNpbWls
YXIgcGF0dGVybnMKPmluIHRoZSByZXN0IG9mIHRoZSBkcml2ZXI/Cj5Gb3IgZXhhbXBsZSBpbiBl
eHlub3NfZHBpX3Byb2JlKCkKPgo+SXMgd291bGQgYmUgbmljZSB0byBvbmx5IGhhdmUgdG8gcmV2
aWV3IGZvciB0aGlzCj50eXBlIG9mIGNoYW5nZXMgb25jZSwgc28gb25lIHBhdGNoLXNldCBpcyBw
cmVmZXJyZWQKPm92ZXIgc2luZ2xlIHBhdGNoZXMgb3ZlciB0aW1lLgo+Cj5Zb3UgY2FuIGFkZDoK
PlJldmlld2VkLWJ5OiBTYW0gUmF2bmJvcmcgPHNhbUByYXZuYm9yZy5vcmc+Cj4KPnRvIHRoaXMg
cGF0Y2ggd2hlbiB5b3UgcmUtc2VuZCBhIG5ldyBzZXJpZXMuCj4KPlRoYW5rcywKPglTYW0KCkhp
ClN1cmUsIHRoaXMgaXMgYWxzbyBhIGdvb2QgY2hhbmNlIGZvciBtZSB0byBsZWFybiB0aGlzIGNv
ZGUuCkkgd2lsbCByZS1jaGVjayB0aGlzIHBhcnQgb2YgdGhlIGV4eW5vcyBkcml2ZXIgY29kZSB0
byBzZWUgCmlmIHRoZXJlIGFyZSBzaW1pbGFyIHBhdHRlcm5zLCBhbmQgdGhlbiByZS1zZW5kIGEg
cGF0Y2ggc2VyaWVzLgoKUmVnYXJkcywKQmVybmFyZAoKPj4gLS0tCj4+ICBkcml2ZXJzL2dwdS9k
cm0vZXh5bm9zL2V4eW5vc19kcm1fZHBpLmMgfCAxMCArKystLS0tLS0tCj4+ICAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+PiAKPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9leHlub3MvZXh5bm9zX2RybV9kcGkuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9leHlub3MvZXh5bm9zX2RybV9kcGkuYwo+PiBpbmRleCA0M2ZhMGYyNmMwNTIuLmUwNmY3ZDdh
NjY5NSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2V4eW5vcy9leHlub3NfZHJtX2Rw
aS5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9leHlub3MvZXh5bm9zX2RybV9kcGkuYwo+PiBA
QCAtMTgxLDEwICsxODEsOCBAQCBzdGF0aWMgaW50IGV4eW5vc19kcGlfcGFyc2VfZHQoc3RydWN0
IGV4eW5vc19kcGkgKmN0eCkKPj4gIAkJCXJldHVybiAtRU5PTUVNOwo+PiAgCj4+ICAJCXJldCA9
IG9mX2dldF92aWRlb21vZGUoZG4sIHZtLCAwKTsKPj4gLQkJaWYgKHJldCA8IDApIHsKPj4gLQkJ
CWRldm1fa2ZyZWUoZGV2LCB2bSk7Cj4+ICsJCWlmIChyZXQgPCAwKQo+PiAgCQkJcmV0dXJuIHJl
dDsKPj4gLQkJfQo+PiAgCj4+ICAJCWN0eC0+dm0gPSB2bTsKPj4gIAo+PiBAQCAtMjMzLDEwICsy
MzEsOCBAQCBzdHJ1Y3QgZHJtX2VuY29kZXIgKmV4eW5vc19kcGlfcHJvYmUoc3RydWN0IGRldmlj
ZSAqZGV2KQo+PiAgCWN0eC0+ZGV2ID0gZGV2Owo+PiAgCj4+ICAJcmV0ID0gZXh5bm9zX2RwaV9w
YXJzZV9kdChjdHgpOwo+PiAtCWlmIChyZXQgPCAwKSB7Cj4+IC0JCWRldm1fa2ZyZWUoZGV2LCBj
dHgpOwo+PiAtCQlyZXR1cm4gTlVMTDsKPj4gLQl9Cj4+ICsJaWYgKHJldCA8IDApCj4+ICsJCXJl
dHVybiBFUlJfUFRSKHJldCk7Cj4+ICAKPj4gIAlpZiAoY3R4LT5wYW5lbF9ub2RlKSB7Cj4+ICAJ
CWN0eC0+cGFuZWwgPSBvZl9kcm1fZmluZF9wYW5lbChjdHgtPnBhbmVsX25vZGUpOwo+PiAtLSAK
Pj4gMi4yNi4yCj4+IAo+PiAKPj4gW3JlLXNlbmQsIHdlbGNvbWUgYW55IGNvbW1lbnRzXQo+PiBS
ZWdhcmRzLAo+PiBCZXJuYXJkCj4+IAo+PiAKPj4gCj4+IAo+PiBfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBkcmktZGV2ZWwgbWFpbGluZyBsaXN0Cj4+
IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKDQoNCg==
