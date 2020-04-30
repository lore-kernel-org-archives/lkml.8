Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE5EC8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 402AF24DD1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgD3LAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:00:46 -0400
Received: from m176148.mail.qiye.163.com ([59.111.176.148]:4973 "EHLO
        m176148.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgD3LAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:00:46 -0400
Received: from vivo.com (wm-8.qy.internal [127.0.0.1])
        by m176148.mail.qiye.163.com (Hmail) with ESMTP id B636B1A41B7;
        Thu, 30 Apr 2020 19:00:11 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AO2AmAAQCPm7TNcK3aT264ov.3.1588244411605.Hmail.bernard@vivo.com>
To:     Joe Perches <joe@perches.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gZHJtL3JhZGVvbjogY2xlYW51cCBjb2Rpbmcgc3R5bGUgYSBiaXQ=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 157.0.31.122
In-Reply-To: <ae65a955251bd43ac71b7a162320bbc1fe220a67.camel@perches.com>
MIME-Version: 1.0
Received: from bernard@vivo.com( [157.0.31.122) ] by ajax-webmail ( [127.0.0.1] ) ; Thu, 30 Apr 2020 19:00:11 +0800 (GMT+08:00)
From:   Bernard <bernard@vivo.com>
Date:   Thu, 30 Apr 2020 19:00:11 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVITktCQkJDSElKTkhISVlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhMT05IQ0hKQkpIN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6NEk6Fjo6KjgrFkwvNRgwSBovSU1PFA1VSFVKTkNDSU9PT0pKQ0tLVTMWGhIXVRkeCRUaCR87
        DRINFFUYFBZFWVdZEgtZQVlKTkxVS1VISlVKSUlZV1kIAVlBT01DTjcG
X-HM-Tid: 0a71cabe75699394kuwsb636b1a41b7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cgrlj5Hku7bkurrvvJpKb2UgUGVyY2hlcyA8am9lQHBlcmNoZXMuY29tPgrlj5HpgIHml6XmnJ/v
vJoyMDIwLTA0LTI3IDAxOjUzOjA2CuaUtuS7tuS6uu+8miJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPixCZXJuYXJkIFpoYW8gPGJlcm5hcmRAdml2by5jb20+LEFs
ZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4sIkRhdmlkIChDaHVuTWluZykg
WmhvdSIgPERhdmlkMS5aaG91QGFtZC5jb20+LERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5p
ZT4sRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPixhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZyxkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnLGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcK5oqE6YCB5Lq677yab3BlbnNvdXJjZS5rZXJuZWxAdml2by5jb20K5Li76aKY
77yaUmU6IFtQQVRDSF0gZHJtL3JhZGVvbjogY2xlYW51cCBjb2Rpbmcgc3R5bGUgYSBiaXQ+T24g
U3VuLCAyMDIwLTA0LTI2IGF0IDE1OjE4ICswMjAwLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+
PiBBbSAyNi4wNC4yMCB1bSAxNToxMiBzY2hyaWViIEJlcm5hcmQgWmhhbzoKPj4gPiBNYXliZSBu
byBuZWVkIHRvIGNoZWNrIHdzIGJlZm9yZSBrbWFsbG9jLCBrbWFsbG9jIHdpbGwgY2hlY2sKPj4g
PiBpdHNlbGYsIGttYWxsb2NgcyBsb2dpYyBpcyBpZiBwdHIgaXMgTlVMTCwga21hbGxvYyB3aWxs
IGp1c3QKPj4gPiByZXR1cm4KPj4gPiAKPj4gPiBTaWduZWQtb2ZmLWJ5OiBCZXJuYXJkIFpoYW8g
PGJlcm5hcmRAdml2by5jb20+Cj4+IAo+PiBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+PiAKPj4gSSdtIHdvbmRlcmluZyB3aHkgdGhlIGF1
dG9tYXRlZCBzY3JpcHRzIGhhdmVuJ3QgZm91bmQgdGhhdCBvbmUgYmVmb3JlLgo+Cj5iZWNhdXNl
IHRoaXMgcGF0dGVybiBpcwo+Cj4JaWYgKGZvbykKPgkJa2ZyZWUoYmFyKTsKPgo+YW5kIHRoZSBw
YXR0ZXJuIGxvb2tlZCBmb3IgaXM6Cj4KPglpZiAoZm9vKQo+CQlrZnJlZShmb28pOwo+Cj4+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vYXRvbS5jIGIvZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9hdG9tLmMKPltdCj4+ID4gQEAgLTEyMTEsOCArMTIxMSw3IEBAIHN0YXRpYyBp
bnQgYXRvbV9leGVjdXRlX3RhYmxlX2xvY2tlZChzdHJ1Y3QgYXRvbV9jb250ZXh0ICpjdHgsIGlu
dCBpbmRleCwgdWludDMyCj4+ID4gICAJU0RFQlVHKCI8PFxuIik7Cj4+ID4gICAKPj4gPiAgIGZy
ZWU6Cj4+ID4gLQlpZiAod3MpCj4+ID4gLQkJa2ZyZWUoZWN0eC53cyk7Cj4+ID4gKwlrZnJlZShl
Y3R4LndzKTsKPj4gPiAgIAlyZXR1cm4gcmV0Owo+PiA+ICAgfQo+Cj5JJ20gd29uZGVyaW5nIGlm
IHRoaXMgcmVtb3ZhbCBpcyBjb3JyZWN0IGFzIHRoZSBmdW5jdGlvbgo+aXMgbmFtZWQgX2xvY2tl
ZCBhbmQgaXQgbWF5IGJlIHJlY3Vyc2l2ZSBvciBjYWxsZWQgdW5kZXIKPnNvbWUgZXh0ZXJuYWwg
bG9jay4KPgpIaQpJIGFtIGEgbGl0dGxlIGNvbmZ1c2VkIGFib3V0IHRoaXMuIEkgdW5kZXJzdGFu
ZCB0aGF0IHRoZSBjYWxsZXIgZ3VhcmFudGVlcyB0aGUgbG9jayBwcm90ZWN0aW9uCnRoYXQgd2Ug
d2lsbCBub3QgcmVsZWFzZSB0aGUgd3JvbmcgcG9pbnRlci4gQW5kIHRoZSBOVUxMIGNoZWNrIGlz
IHRoZSBzYW1lIHdpdGggdGhlIGZpcnN0IGNoZWNrIGluIGtmcmVlPwpNYXliZSB3ZSBkbyBub3Qg
bmVlZCBjaGVjayB0d2ljaC4KClJlZ2FyZHMsCkJlcm5hcmQKCg0KDQo=
