Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA18C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A8620857
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgDUJJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 05:09:20 -0400
Received: from m176149.mail.qiye.163.com ([59.111.176.149]:20380 "EHLO
        m176149.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgDUJJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 05:09:20 -0400
Received: from vivo.com (wm-9.qy.internal [127.0.0.1])
        by m176149.mail.qiye.163.com (Hmail) with ESMTP id 6EF60282399;
        Tue, 21 Apr 2020 17:08:44 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AIgApgB6CE0xGrhst8pSe4p3.3.1587460124439.Hmail.bernard@vivo.com>
To:     Markus.Elfring@web.de
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?Q?Jos=C3=A9_Roberto_de_Souza?= <jose.souza@intel.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: =?UTF-8?B?W2FkZCBNYXJrdXMuRWxmcmluZyBpbiBtYWlsIGxpc3RdUmU6W1BBVENIIHYyXSBhbWRncHU6IGZpeGVzIGVycm9yIGJyYW5jaCBub3QgcmV0dXJuIGVycm5vIGlzc3Vl?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 157.0.31.122
In-Reply-To: <1587434874-123252-1-git-send-email-bernard@vivo.com>
MIME-Version: 1.0
Received: from bernard@vivo.com( [157.0.31.122) ] by ajax-webmail ( [127.0.0.1] ) ; Tue, 21 Apr 2020 17:08:44 +0800 (GMT+08:00)
From:   =?UTF-8?B?6LW15Yab5aWO?= <bernard@vivo.com>
Date:   Tue, 21 Apr 2020 17:08:44 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VKS0pCQkJMTkJNTE9LTFlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhMSEhKSE1LTE1JN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6Mhw6Cxw5TTg#SwM8CRMID0MLKB5PC0hVSFVKTkNMT01LSklPTk1KVTMWGhIXVRkeCRUaCR87
        DRINFFUYFBZFWVdZEgtZQVlKTkxVS1VISlVKSUlZV1kIAVlBTE9PSDcG
X-HM-Tid: 0a719bff2f2e9395kuws6ef60282399
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpGcm9tOiBCZXJuYXJkIFpoYW8gPGJlcm5hcmRAdml2by5jb20+CkRhdGU6IDIwMjAtMDQtMjEg
MTA6MDc6NTAKVG86ICBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+LCJD
aHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPiwiRGF2aWQgKENodW5N
aW5nKSBaaG91IiA8RGF2aWQxLlpob3VAYW1kLmNvbT4sRGF2aWQgQWlybGllIDxhaXJsaWVkQGxp
bnV4LmllPixEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+LEx5dWRlIFBhdWwgPGx5dWRl
QHJlZGhhdC5jb20+LFNhbSBSYXZuYm9yZyA8c2FtQHJhdm5ib3JnLm9yZz4sQmVybmFyZCBaaGFv
IDxiZXJuYXJkQHZpdm8uY29tPiwiSm9zw6kgUm9iZXJ0byBkZSBTb3V6YSIgPGpvc2Uuc291emFA
aW50ZWwuY29tPixBbmRyemVqIFBpZXRyYXNpZXdpY3ogPGFuZHJ6ZWoucEBjb2xsYWJvcmEuY29t
PixhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZyxkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnLGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcKQ2M6ICBvcGVuc291cmNlLmtlcm5l
bEB2aXZvLmNvbQpTdWJqZWN0OiBbUEFUQ0ggdjJdIGFtZGdwdTogZml4ZXMgZXJyb3IgYnJhbmNo
IG5vdCByZXR1cm4gZXJybm8gaXNzdWU+VGhlICJpZighZW5jb2RlcikiIGJyYW5jaCByZXR1cm4g
dGhlIHNhbWUgdmFsdWUgMCBvZiB0aGUgc3VjY2Vzcwo+YnJhbmNoLCBtYXliZSByZXR1cm4gLUVJ
TlZBTCBpcyBtb3JlIGJldHRlci4KPgo+U2lnbmVkLW9mZi1ieTogQmVybmFyZCBaaGFvIDxiZXJu
YXJkQHZpdm8uY29tPgo+Cj4tLS0KPkNoYW5nZXMgc2luY2UgVjE6Cj4qIGNvbW1pdCBtZXNzYWdl
IGltcHJvdmUKPi0tLQo+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jb25uZWN0
b3JzLmMgfCAxNCArKysrKysrLS0tLS0tLQo+IDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KyksIDcgZGVsZXRpb25zKC0pCj4KPmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfY29ubmVjdG9ycy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2Nvbm5lY3RvcnMuYwo+aW5kZXggZjM1NWQ5YS4uMWY4YzZiNCAxMDA2NDQKPi0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jb25uZWN0b3JzLmMKPisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jb25uZWN0b3JzLmMKPkBAIC00NzQsMTIgKzQ3
NCwxMiBAQCBzdGF0aWMgaW50IGFtZGdwdV9jb25uZWN0b3Jfc2V0X3Byb3BlcnR5KHN0cnVjdCBk
cm1fY29ubmVjdG9yICpjb25uZWN0b3IsCj4gCQkvKiBuZWVkIHRvIGZpbmQgZGlnaXRhbCBlbmNv
ZGVyIG9uIGNvbm5lY3RvciAqLwo+IAkJZW5jb2RlciA9IGFtZGdwdV9jb25uZWN0b3JfZmluZF9l
bmNvZGVyKGNvbm5lY3RvciwgRFJNX01PREVfRU5DT0RFUl9UTURTKTsKPiAJCWlmICghZW5jb2Rl
cikKPi0JCQlyZXR1cm4gMDsKPisJCQlyZXR1cm4gLUVJTlZBTDsKPiAKPiAJCWFtZGdwdV9lbmNv
ZGVyID0gdG9fYW1kZ3B1X2VuY29kZXIoZW5jb2Rlcik7Cj4gCj4gCQlpZiAoIWFtZGdwdV9lbmNv
ZGVyLT5lbmNfcHJpdikKPi0JCQlyZXR1cm4gMDsKPisJCQlyZXR1cm4gLUVJTlZBTDsKPiAKPiAJ
CWRpZyA9IGFtZGdwdV9lbmNvZGVyLT5lbmNfcHJpdjsKPiAJCW5ld19jb2hlcmVudF9tb2RlID0g
dmFsID8gdHJ1ZSA6IGZhbHNlOwo+QEAgLTQ5NCw3ICs0OTQsNyBAQCBzdGF0aWMgaW50IGFtZGdw
dV9jb25uZWN0b3Jfc2V0X3Byb3BlcnR5KHN0cnVjdCBkcm1fY29ubmVjdG9yICpjb25uZWN0b3Is
Cj4gCQkvKiBuZWVkIHRvIGZpbmQgZGlnaXRhbCBlbmNvZGVyIG9uIGNvbm5lY3RvciAqLwo+IAkJ
ZW5jb2RlciA9IGFtZGdwdV9jb25uZWN0b3JfZmluZF9lbmNvZGVyKGNvbm5lY3RvciwgRFJNX01P
REVfRU5DT0RFUl9UTURTKTsKPiAJCWlmICghZW5jb2RlcikKPi0JCQlyZXR1cm4gMDsKPisJCQly
ZXR1cm4gLUVJTlZBTDsKPiAKPiAJCWFtZGdwdV9lbmNvZGVyID0gdG9fYW1kZ3B1X2VuY29kZXIo
ZW5jb2Rlcik7Cj4gCj5AQCAtNTA5LDcgKzUwOSw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2Nvbm5l
Y3Rvcl9zZXRfcHJvcGVydHkoc3RydWN0IGRybV9jb25uZWN0b3IgKmNvbm5lY3RvciwKPiAJCS8q
IG5lZWQgdG8gZmluZCBkaWdpdGFsIGVuY29kZXIgb24gY29ubmVjdG9yICovCj4gCQllbmNvZGVy
ID0gYW1kZ3B1X2Nvbm5lY3Rvcl9maW5kX2VuY29kZXIoY29ubmVjdG9yLCBEUk1fTU9ERV9FTkNP
REVSX1RNRFMpOwo+IAkJaWYgKCFlbmNvZGVyKQo+LQkJCXJldHVybiAwOwo+KwkJCXJldHVybiAt
RUlOVkFMOwo+IAo+IAkJYW1kZ3B1X2VuY29kZXIgPSB0b19hbWRncHVfZW5jb2RlcihlbmNvZGVy
KTsKPiAKPkBAIC01MjMsNyArNTIzLDcgQEAgc3RhdGljIGludCBhbWRncHVfY29ubmVjdG9yX3Nl
dF9wcm9wZXJ0eShzdHJ1Y3QgZHJtX2Nvbm5lY3RvciAqY29ubmVjdG9yLAo+IAkJLyogbmVlZCB0
byBmaW5kIGRpZ2l0YWwgZW5jb2RlciBvbiBjb25uZWN0b3IgKi8KPiAJCWVuY29kZXIgPSBhbWRn
cHVfY29ubmVjdG9yX2ZpbmRfZW5jb2Rlcihjb25uZWN0b3IsIERSTV9NT0RFX0VOQ09ERVJfVE1E
Uyk7Cj4gCQlpZiAoIWVuY29kZXIpCj4tCQkJcmV0dXJuIDA7Cj4rCQkJcmV0dXJuIC1FSU5WQUw7
Cj4gCj4gCQlhbWRncHVfZW5jb2RlciA9IHRvX2FtZGdwdV9lbmNvZGVyKGVuY29kZXIpOwo+IAo+
QEAgLTUzNyw3ICs1MzcsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9jb25uZWN0b3Jfc2V0X3Byb3Bl
cnR5KHN0cnVjdCBkcm1fY29ubmVjdG9yICpjb25uZWN0b3IsCj4gCQkvKiBuZWVkIHRvIGZpbmQg
ZGlnaXRhbCBlbmNvZGVyIG9uIGNvbm5lY3RvciAqLwo+IAkJZW5jb2RlciA9IGFtZGdwdV9jb25u
ZWN0b3JfZmluZF9lbmNvZGVyKGNvbm5lY3RvciwgRFJNX01PREVfRU5DT0RFUl9UTURTKTsKPiAJ
CWlmICghZW5jb2RlcikKPi0JCQlyZXR1cm4gMDsKPisJCQlyZXR1cm4gLUVJTlZBTDsKPiAKPiAJ
CWFtZGdwdV9lbmNvZGVyID0gdG9fYW1kZ3B1X2VuY29kZXIoZW5jb2Rlcik7Cj4gCj5AQCAtNTUx
LDcgKzU1MSw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2Nvbm5lY3Rvcl9zZXRfcHJvcGVydHkoc3Ry
dWN0IGRybV9jb25uZWN0b3IgKmNvbm5lY3RvciwKPiAJCS8qIG5lZWQgdG8gZmluZCBkaWdpdGFs
IGVuY29kZXIgb24gY29ubmVjdG9yICovCj4gCQllbmNvZGVyID0gYW1kZ3B1X2Nvbm5lY3Rvcl9m
aW5kX2VuY29kZXIoY29ubmVjdG9yLCBEUk1fTU9ERV9FTkNPREVSX1RNRFMpOwo+IAkJaWYgKCFl
bmNvZGVyKQo+LQkJCXJldHVybiAwOwo+KwkJCXJldHVybiAtRUlOVkFMOwo+IAo+IAkJYW1kZ3B1
X2VuY29kZXIgPSB0b19hbWRncHVfZW5jb2RlcihlbmNvZGVyKTsKPiAKPi0tIAo+Mi43LjQKCj4K
CmFkZCBNYXJrdXMuRWxmcmluZyBpbiBtYWlsIGxpc3QgClJlZ2FyZHMsCkJlcm5hcmQNCg0K
