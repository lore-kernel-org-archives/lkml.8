Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F961C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0259A206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgDUMKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:10:20 -0400
Received: from m176149.mail.qiye.163.com ([59.111.176.149]:11207 "EHLO
        m176149.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgDUMKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:10:19 -0400
Received: from vivo.com (wm-9.qy.internal [127.0.0.1])
        by m176149.mail.qiye.163.com (Hmail) with ESMTP id 905DC282636;
        Tue, 21 Apr 2020 20:09:43 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AIEABQDACBGx7eaGVybumqrT.3.1587470983521.Hmail.bernard@vivo.com>
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tom St Denis <tom.stdenis@amd.com>,
        Ori Messinger <Ori.Messinger@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gYW1kZ3B1OiBmaXhlcyBtZW1sZWFrIGlzc3VlIHdoZW4gaW5pdCBmYWlsZWQ=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 157.0.31.122
In-Reply-To: <738537e5-9a1a-25c8-3dd0-b1f5fd045979@amd.com>
MIME-Version: 1.0
Received: from bernard@vivo.com( [157.0.31.122) ] by ajax-webmail ( [127.0.0.1] ) ; Tue, 21 Apr 2020 20:09:43 +0800 (GMT+08:00)
From:   =?UTF-8?B?6LW15Yab5aWO?= <bernard@vivo.com>
Date:   Tue, 21 Apr 2020 20:09:43 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVMQ0lCQkJCQklITEtNSllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhMSE9IQkhLTExJN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6Mj46OSo*Ojg5PANMHho8LQIZDhYKCS9VSFVKTkNMT0xLQkNITU5CVTMWGhIXVRkeCRUaCR87
        DRINFFUYFBZFWVdZEgtZQVlKTkxVS1VISlVKSUlZV1kIAVlBTU1CTDcG
X-HM-Tid: 0a719ca4e1ad9395kuws905dc282636
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkZyb206ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpEYXRl
OiAyMDIwLTA0LTIxIDE5OjIyOjQ5ClRvOiAgQmVybmFyZCBaaGFvIDxiZXJuYXJkQHZpdm8uY29t
PixBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+LCJEYXZpZCAoQ2h1bk1p
bmcpIFpob3UiIDxEYXZpZDEuWmhvdUBhbWQuY29tPixEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGlu
dXguaWU+LERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4sVG9tIFN0IERlbmlzIDx0b20u
c3RkZW5pc0BhbWQuY29tPixPcmkgTWVzc2luZ2VyIDxPcmkuTWVzc2luZ2VyQGFtZC5jb20+LFNh
bSBSYXZuYm9yZyA8c2FtQHJhdm5ib3JnLm9yZz4sYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcsZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZyxsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnCkNjOiAgb3BlbnNvdXJjZS5rZXJuZWxAdml2by5jb20KU3ViamVjdDogUmU6IFtQQVRD
SF0gYW1kZ3B1OiBmaXhlcyBtZW1sZWFrIGlzc3VlIHdoZW4gaW5pdCBmYWlsZWQ+QW0gMjEuMDQu
MjAgdW0gMTM6MTcgc2NocmllYiBCZXJuYXJkIFpoYW86Cj4+IFZSQU0gbWFuYWdlciBhbmQgRFJN
IE1NIHdoZW4gaW5pdCBmYWlsZWQsIHRoZXJlIGlzIG5vIG9wZXJhY3Rpb24KPj4gdG8gZnJlZSBr
emFsbG9jIG1lbW9yeSAmIHJlbW92ZSBkZXZpY2UgZmlsZS4KPj4gVGhpcyB3aWxsIGxlYWQgdG8g
bWVtbGVhayAmIGNhdXNlIHN0YWJpbGl0eSBpc3N1ZS4KPgo+TkFLLCBmYWlsdXJlIHRvIGNyZWF0
ZSBzeXNmcyBub2RlcyBhcmUgbm90IGNyaXRpY2FsLgo+Cj5DaHJpc3RpYW4uCj4KCk9LLCBnZXQg
aXQuCkJ5IHRoZSB3YXksIHNob3VsZCBpIG1vZGlmeSB0aGlzIHBhdGNoIHRvIGp1c3QgaGFuZGxl
IDxrZnJlZShtZ3IpPiBpbiBlcnJvciBicmFuY2gsIG9yIHRoYXQgaXQgaXMgYWxzbyB1bm5lY2Vz
c2FyeT8KClJlZ2FyZHMsCkJlcm5hcmQKCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEJlcm5hcmQgWmhh
byA8YmVybmFyZEB2aXZvLmNvbT4KPj4gLS0tCj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZyYW1fbWdyLmMgfCAyNCArKysrKysrKysrKysrKysrLS0tLQo+PiAgIDEgZmls
ZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdnJhbV9tZ3IuYwo+PiBpbmRleCA4MmEzMjk5
ZTUzYzAuLjRjNWZiMTUzZTZiNCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZyYW1fbWdyLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZyYW1fbWdyLmMKPj4gQEAgLTE3NSwzMCArMTc1LDQ0IEBAIHN0YXRpYyBpbnQg
YW1kZ3B1X3ZyYW1fbWdyX2luaXQoc3RydWN0IHR0bV9tZW1fdHlwZV9tYW5hZ2VyICptYW4sCj4+
ICAgCXJldCA9IGRldmljZV9jcmVhdGVfZmlsZShhZGV2LT5kZXYsICZkZXZfYXR0cl9tZW1faW5m
b192cmFtX3RvdGFsKTsKPj4gICAJaWYgKHJldCkgewo+PiAgIAkJRFJNX0VSUk9SKCJGYWlsZWQg
dG8gY3JlYXRlIGRldmljZSBmaWxlIG1lbV9pbmZvX3ZyYW1fdG90YWxcbiIpOwo+PiAtCQlyZXR1
cm4gcmV0Owo+PiArCQlnb3RvIFZSQU1fVE9UQUxfRkFJTDsKPj4gICAJfQo+PiAgIAlyZXQgPSBk
ZXZpY2VfY3JlYXRlX2ZpbGUoYWRldi0+ZGV2LCAmZGV2X2F0dHJfbWVtX2luZm9fdmlzX3ZyYW1f
dG90YWwpOwo+PiAgIAlpZiAocmV0KSB7Cj4+ICAgCQlEUk1fRVJST1IoIkZhaWxlZCB0byBjcmVh
dGUgZGV2aWNlIGZpbGUgbWVtX2luZm9fdmlzX3ZyYW1fdG90YWxcbiIpOwo+PiAtCQlyZXR1cm4g
cmV0Owo+PiArCQlnb3RvIFZJU19WUkFNX1RPVEFfRkFJTDsKPj4gICAJfQo+PiAgIAlyZXQgPSBk
ZXZpY2VfY3JlYXRlX2ZpbGUoYWRldi0+ZGV2LCAmZGV2X2F0dHJfbWVtX2luZm9fdnJhbV91c2Vk
KTsKPj4gICAJaWYgKHJldCkgewo+PiAgIAkJRFJNX0VSUk9SKCJGYWlsZWQgdG8gY3JlYXRlIGRl
dmljZSBmaWxlIG1lbV9pbmZvX3ZyYW1fdXNlZFxuIik7Cj4+IC0JCXJldHVybiByZXQ7Cj4+ICsJ
CWdvdG8gVlJBTV9VU0VEX0ZBSUw7Cj4+ICAgCX0KPj4gICAJcmV0ID0gZGV2aWNlX2NyZWF0ZV9m
aWxlKGFkZXYtPmRldiwgJmRldl9hdHRyX21lbV9pbmZvX3Zpc192cmFtX3VzZWQpOwo+PiAgIAlp
ZiAocmV0KSB7Cj4+ICAgCQlEUk1fRVJST1IoIkZhaWxlZCB0byBjcmVhdGUgZGV2aWNlIGZpbGUg
bWVtX2luZm9fdmlzX3ZyYW1fdXNlZFxuIik7Cj4+IC0JCXJldHVybiByZXQ7Cj4+ICsJCWdvdG8g
VklTX1ZSQU1fVVNFRF9GQUlMOwo+PiAgIAl9Cj4+ICAgCXJldCA9IGRldmljZV9jcmVhdGVfZmls
ZShhZGV2LT5kZXYsICZkZXZfYXR0cl9tZW1faW5mb192cmFtX3ZlbmRvcik7Cj4+ICAgCWlmIChy
ZXQpIHsKPj4gICAJCURSTV9FUlJPUigiRmFpbGVkIHRvIGNyZWF0ZSBkZXZpY2UgZmlsZSBtZW1f
aW5mb192cmFtX3ZlbmRvclxuIik7Cj4+IC0JCXJldHVybiByZXQ7Cj4+ICsJCWdvdG8gVlJBTV9W
RVJET1JfRkFJTDsKPj4gICAJfQo+PiAgIAo+PiAgIAlyZXR1cm4gMDsKPj4gKwo+PiArVlJBTV9W
RVJET1JfRkFJTDoKPj4gKwlkZXZpY2VfcmVtb3ZlX2ZpbGUoYWRldi0+ZGV2LCAmZGV2X2F0dHJf
bWVtX2luZm9fdmlzX3ZyYW1fdXNlZCk7Cj4+ICtWSVNfVlJBTV9VU0VEX0ZBSUw6Cj4+ICsJZGV2
aWNlX3JlbW92ZV9maWxlKGFkZXYtPmRldiwgJmRldl9hdHRyX21lbV9pbmZvX3ZyYW1fdXNlZCk7
Cj4+ICtSVkFNX1VTRURfRkFJTDoKPj4gKwlkZXZpY2VfcmVtb3ZlX2ZpbGUoYWRldi0+ZGV2LCAm
ZGV2X2F0dHJfbWVtX2luZm9fdmlzX3ZyYW1fdG90YWwpOwo+PiArVklTX1ZSQU1fVE9UQV9GQUlM
Ogo+PiArCWRldmljZV9yZW1vdmVfZmlsZShhZGV2LT5kZXYsICZkZXZfYXR0cl9tZW1faW5mb192
cmFtX3RvdGFsKTsKPj4gK1ZSQU1fVE9UQUxfRkFJTDoKPj4gKwlrZnJlZShtZ3IpOwo+PiArCW1h
bi0+cHJpdiA9IE5VTEw7Cj4+ICsKPj4gKwlyZXR1cm4gcmV0Owo+PiAgIH0KPj4gICAKPj4gICAv
KioKPgoNCg0K
