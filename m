Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3668FC2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 00:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F2482071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 00:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgDXA0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 20:26:23 -0400
Received: from m142-177.yeah.net ([123.58.177.142]:3234 "EHLO
        m142-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgDXA0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 20:26:22 -0400
X-Greylist: delayed 313 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Apr 2020 20:26:21 EDT
Received: from vivo.com (localhost [127.0.0.1])
        by m142-177.yeah.net (Hmail) with ESMTP id 30EF8643DCF;
        Fri, 24 Apr 2020 08:20:34 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <APUAbgC8CDi*auuSjFr7jKrI.3.1587687634093.Hmail.bernard@vivo.com>
To:     Liviu Dudau <liviu.dudau@arm.com>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gZHJtL2FybTogY2xlYW51cCBjb2Rpbmcgc3R5bGUgaW4gYXJtIGEgYml0?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 157.0.31.122
In-Reply-To: <20200423125007.GG364558@e110455-lin.cambridge.arm.com>
MIME-Version: 1.0
Received: from bernard@vivo.com( [157.0.31.122) ] by ajax-webmail ( [127.0.0.1] ) ; Fri, 24 Apr 2020 08:20:34 +0800 (GMT+08:00)
From:   =?UTF-8?B?6LW15Yab5aWO?= <bernard@vivo.com>
Date:   Fri, 24 Apr 2020 08:20:34 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVNQ05CQkJDTEtIS0tJQllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhMSEJLSU5KTktPN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6Ky46GRw4Qzg*ElEaDg4oET0JTBEwCTJVSFVKTkNMTUNMTUhPSUxJVTMWGhIXVRkeCRUaCR87
        DRINFFUYFBZFWVdZEgtZQVlKTkxVS1VISlVKSUlZV1kIAVlBT01MTjcG
X-HM-Tid: 0a71a98eb51f6473kurs30ef8643dcf
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkZyb206IExpdml1IER1ZGF1IDxsaXZpdS5kdWRhdUBhcm0uY29tPgpEYXRlOiAyMDIwLTA0LTIz
IDIwOjUwOjA3ClRvOiAgQmVybmFyZCBaaGFvIDxiZXJuYXJkQHZpdm8uY29tPgpDYzogIEJyaWFu
IFN0YXJrZXkgPGJyaWFuLnN0YXJrZXlAYXJtLmNvbT4sRGF2aWQgQWlybGllIDxhaXJsaWVkQGxp
bnV4LmllPixEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+LGRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcsbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZyxvcGVuc291cmNlLmtl
cm5lbEB2aXZvLmNvbQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYXJtOiBjbGVhbnVwIGNvZGlu
ZyBzdHlsZSBpbiBhcm0gYSBiaXQ+SGkgQmVybmFyZCwKPgo+T24gVHVlLCBBcHIgMjEsIDIwMjAg
YXQgMDc6MTA6NDZQTSAtMDcwMCwgQmVybmFyZCBaaGFvIHdyb3RlOgo+PiBGb3IgdGhlIGNvZGUg
bG9naWMsIGFuIGFsYXJtIGlzIHRocm93biBhZnRlciBmYWlsdXJlLCBidXQgdGhlCj4+IGNvZGUg
Y29udGludWVzIHRvIHJ1biBhbmQgcmV0dXJucyBzdWNjZXNzZnVsbHksIHNvIHRvIHRoZSBjYWxs
ZXIKPj4gdGhlIGlmIGNoZWNrIGFuZCByZXR1cm4gYnJhbmNoIHdpbGwgbmV2ZXIgcnVuLgo+PiBU
aGUgY2hhbmdlIGlzIHRvIG1ha2UgdGhlIGNvZGUgYSBiaXQgbW9yZSByZWFkYWJsZS4KPj4gCj4+
IFNpZ25lZC1vZmYtYnk6IEJlcm5hcmQgWmhhbyA8YmVybmFyZEB2aXZvLmNvbT4KPj4gLS0tCj4+
ICBkcml2ZXJzL2dwdS9kcm0vYXJtL2hkbGNkX2NydGMuYyB8IDQgKy0tLQo+PiAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQo+PiAKPj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hcm0vaGRsY2RfY3J0Yy5jIGIvZHJpdmVycy9ncHUvZHJtL2FybS9o
ZGxjZF9jcnRjLmMKPj4gaW5kZXggYWY2N2ZlZmVkMzhkLi4zMmJkYTEzMjUwZjUgMTAwNjQ0Cj4+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hcm0vaGRsY2RfY3J0Yy5jCj4+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hcm0vaGRsY2RfY3J0Yy5jCj4+IEBAIC0xNjAsOSArMTYwLDcgQEAgc3RhdGljIHZv
aWQgaGRsY2RfY3J0Y19tb2RlX3NldF9ub2ZiKHN0cnVjdCBkcm1fY3J0YyAqY3J0YykKPj4gIAlo
ZGxjZF93cml0ZShoZGxjZCwgSERMQ0RfUkVHX0hfU1lOQywgdm0uaHN5bmNfbGVuIC0gMSk7Cj4+
ICAJaGRsY2Rfd3JpdGUoaGRsY2QsIEhETENEX1JFR19QT0xBUklUSUVTLCBwb2xhcml0aWVzKTsK
Pj4gIAo+PiAtCWVyciA9IGhkbGNkX3NldF9weGxfZm10KGNydGMpOwo+PiAtCWlmIChlcnIpCj4+
IC0JCXJldHVybjsKPj4gKwloZGxjZF9zZXRfcHhsX2ZtdChjcnRjKTsKPgo+SSB0aGluayB5b3Ug
Zm91bmQgYSByZWFsIGJ1Zy4gaGRsY2Rfc2V0X3B4bF9mbXQoKSBpcyBub3Qgc3VwcG9zZWQgdG8g
cmV0dXJuIHplcm8gaWYKPnRoZSBmb3JtYXQgaXMgbm90IHN1cHBvcnRlZCBhbmQgaGVyZSB3ZSB3
b3VsZCBzdG9wIGVuYWJsaW5nIHRoZSBwaXhlbCBjbG9jay4KPgo+RG8geW91IGNhcmUgdG8gc2Vu
ZCBhIHBhdGNoIGZvciBmaXhpbmcgdGhlIGJ1ZywgcmF0aGVyIHRoYW4gdGhpcyBvbmU/Cj4KPkJl
c3QgcmVnYXJkcywKPkxpdml1Cj4KClN1cmUsIEkgZG8gaGF2ZSBhIGJpdCBjb25mdXNpbmcgYWJv
dXQgdGhpcyBjb2RlLCBJIHdpbGwgcmVzdWJtaXQgYSBwYXRjaCBhbmQgdHJ5IHRvIGZpeCBpdC4K
ClJlZ2FyZHMsCkJlcm5hcmQKCj4+ICAKPj4gIAljbGtfc2V0X3JhdGUoaGRsY2QtPmNsaywgbS0+
Y3J0Y19jbG9jayAqIDEwMDApOwo+PiAgfQo+PiAtLSAKPj4gMi4yNi4yCj4+IAo+Cj4tLSAKPj09
PT09PT09PT09PT09PT09PT09Cj58IEkgd291bGQgbGlrZSB0byB8Cj58IGZpeCB0aGUgd29ybGQs
ICB8Cj58IGJ1dCB0aGV5J3JlIG5vdCB8Cj58IGdpdmluZyBtZSB0aGUgICB8Cj4gXCBzb3VyY2Ug
Y29kZSEgIC8KPiAgLS0tLS0tLS0tLS0tLS0tCj4gICAgwq9cXyjjg4QpXy/CrwoNCg0K
