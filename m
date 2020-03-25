Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D180C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 07:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE15F2074D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 07:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgCYHhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 03:37:22 -0400
Received: from m176148.mail.qiye.163.com ([59.111.176.148]:5165 "EHLO
        m176148.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgCYHhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 03:37:22 -0400
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Mar 2020 03:36:45 EDT
Received: from vivo.com (wm-8.qy.internal [127.0.0.1])
        by m176148.mail.qiye.163.com (Hmail) with ESMTP id F10EF1A3EE9;
        Wed, 25 Mar 2020 15:29:22 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ADUAqwAYCASXqCY1D9tlwqpy.3.1585121362951.Hmail.tao.li@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Sergey Organov <sorganov@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, wenhu.wang@vivo.com
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gdXNiOiBnYWRnZXQ6IHNlcmlhbDogRml4ZWQgS0FTQU4gbnVsbC1wdHItZGVyZWYgaW4gdHR5X3dha2V1cA==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.251.74.226
In-Reply-To: <20200318101240.GA2067041@kroah.com>
MIME-Version: 1.0
Received: from tao.li@vivo.com( [58.251.74.226) ] by ajax-webmail ( [127.0.0.1] ) ; Wed, 25 Mar 2020 15:29:22 +0800 (GMT+08:00)
From:   =?UTF-8?B?5p2O5qGD?= <tao.li@vivo.com>
Date:   Wed, 25 Mar 2020 15:29:22 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZTlVDTkJLS0tJS05CQkhNTllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhNTE5PSE5LTk5MN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6Py46Cgw6Ijg6KCMKOCJKP0IPFwwKCwJVSFVKTkNOSklKSE1OT05PVTMWGhIXVQ8aFFUXEjsN
        Eg0UVRgUFkVZV1kSC1lBWU5DVUlOSlVMT1VJSU1ZV1kIAVlBTUlJSDcG
X-HM-Tid: 0a71109884329394kuwsf10ef1a3ee9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4KRGF0
ZTogMjAyMC0wMy0xOCAxODoxMjo0MApUbzogIExpIFRhbyA8dGFvLmxpQHZpdm8uY29tPgpDYzog
IEZlbGlwZSBCYWxiaSA8YmFsYmlAa2VybmVsLm9yZz4sIk1pY2hhxYIgTWlyb3PFgmF3IiA8bWly
cS1saW51eEByZXJlLnFtcW0ucGw+LFNlcmdleSBPcmdhbm92IDxzb3JnYW5vdkBnbWFpbC5jb20+
LGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmcsbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZyx3
ZW5odS53YW5nQHZpdm8uY29tClN1YmplY3Q6IFJlOiBbUEFUQ0hdIHVzYjogZ2FkZ2V0OiBzZXJp
YWw6IEZpeGVkIEtBU0FOIG51bGwtcHRyLWRlcmVmIGluIHR0eV93YWtldXA+T24gV2VkLCBNYXIg
MTgsIDIwMjAgYXQgMTA6NTY6MDFBTSArMDgwMCwgTGkgVGFvIHdyb3RlOgo+PiBUaGUgcG9ydC0+
cG9ydC50dHkgbWF5YmUgcmVzZXQgYXMgTlVMTCwgSWYgZ3NfY2xvc2UoKSB3YXMgaW52b2tlZAo+
PiB1bmV4cGVjdGVkbHkgZHVyaW5nIHJ1bm5pbmcgZ3NlcmlhbF9jb25uZWN0KCkuCj4+IAo+PiBC
VUc6IEtBU0FOOiBudWxsLXB0ci1kZXJlZiBpbiB0dHlfd2FrZXVwKzB4MWMvMHg4NAo+PiBDYWxs
IHRyYWNlOgo+PiBbPDAwMDAwMDAwOTVjM2M4Mzc+XSBkdW1wX2JhY2t0cmFjZSsweDAvMHg2ZDQK
Pj4gWzwwMDAwMDAwMDQ3NzI2YmI4Pl0gc2hvd19zdGFjaysweDE4LzB4MjAKPj4gWzwwMDAwMDAw
MGJlZGI0YzFlPl0gLS1kdW1wX3N0YWNrKzB4MjAvMHgyOAo+PiBbPDAwMDAwMDAwNzIyZjJlMmE+
XSBkdW1wX3N0YWNrKzB4ODQvMHhiMAo+PiBbPDAwMDAwMDAwMzI1NjgzZDQ+XSBrYXNhbl9yZXBv
cnRfZXJyb3IrMHgxNzgvMHgxZTQKPj4gWzwwMDAwMDAwMDUzMDc5OTk4Pl0ga2FzYW5fcmVwb3J0
X2Vycm9yKzB4MC8weDFlNAo+PiBbPDAwMDAwMDAwYjZkMzNhZmE+XSAtLWFzYW5fbG9hZDgrMHgx
NTAvMHgxNWMKPj4gWzwwMDAwMDAwMDE4ODc0NWI4Pl0gdHR5X3dha2V1cCsweDFjLzB4ODQKPj4g
WzwwMDAwMDAwMDY0ZjZkZDIxPl0gZ3Nfc3RhcnRfaW8rMHhkMC8weDExYwo+PiBbPDAwMDAwMDAw
NjNkNjdiNmM+XSBnc2VyaWFsX2Nvbm5lY3QrMHgxNWMvMHgxYjAKPj4gWzwwMDAwMDAwMGZhZjdj
MGY5Pl0gZG1fc2V0X2FsdCsweGE4LzB4MTkwCj4+IFs8MDAwMDAwMDA4ZGViMTkwOT5dIGNvbXBv
c2l0ZV9zZXR1cCsweGRlNC8weDFlZGMKPj4gWzwwMDAwMDAwMDc5MmVlMTZkPl0gYW5kcm9pZF9z
ZXR1cCsweDIxMC8weDI5NAo+PiBbPDAwMDAwMDAwYWIzMmVmMzA+XSBkd2MzX2VwMF9kZWxlZ2F0
ZV9yZXErMHg0OC8weDY4Cj4+IFs8MDAwMDAwMDA1NGUyNmZkMj5dIGR3YzNfZXAwX2ludGVycnVw
dCsweGYyYy8weDE2ZmMKPj4gWzwwMDAwMDAwMDUwY2IyMjYyPl0gZHdjM19pbnRlcnJ1cHQrMHg0
NjQvMHgxZjQ0Cj4+IFs8MDAwMDAwMDBmZGNhYTZlOT5dIC0taGFuZGxlX2lycV9ldmVudF9wZXJj
cHUrMHgxODQvMHgzOTgKPj4gWzwwMDAwMDAwMDNiMjRmZjU2Pl0gaGFuZGxlX2lycV9ldmVudF9w
ZXJjcHUrMHhhMC8weDEzNAo+PiBbPDAwMDAwMDAwYWVkZGE1ZWU+XSBoYW5kbGVfaXJxX2V2ZW50
KzB4NjAvMHhhMAo+PiBbPDAwMDAwMDAwNWY1MWE1NzA+XSBoYW5kbGVfZmFzdGVvaV9pcnErMHgy
M2MvMHgzMWMKPj4gWzwwMDAwMDAwMDhkYjI2MDhkPl0gZ2VuZXJpY19oYW5kbGVfaXJxKzB4NzAv
MHhhNAo+PiBbPDAwMDAwMDAwMDk4NjgzZmM+XSAtLWhhbmRsZV9kb21haW5faXJxKzB4ODQvMHhl
MAo+PiBbPDAwMDAwMDAwOGVkMjNiNDY+XSBnaWNfaGFuZGxlX2lycSsweDk4LzB4YjgKPj4gCj4+
IFNpZ25lZC1vZmYtYnk6IExpIFRhbyA8dGFvLmxpQHZpdm8uY29tPgo+PiAtLS0KPj4gIGRyaXZl
cnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jIHwgMyArKy0KPj4gIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4gCj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYyBiL2RyaXZlcnMvdXNiL2dhZGdl
dC9mdW5jdGlvbi91X3NlcmlhbC5jCj4+IGluZGV4IDgxNjdkMzc5ZTExNS4uM2MxMDlhOGY5ZWM0
IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYwo+
PiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYwo+PiBAQCAtNTY1
LDcgKzU2NSw4IEBAIHN0YXRpYyBpbnQgZ3Nfc3RhcnRfaW8oc3RydWN0IGdzX3BvcnQgKnBvcnQp
Cj4+ICAJCWdzX3N0YXJ0X3R4KHBvcnQpOwo+PiAgCQkvKiBVbmJsb2NrIGFueSBwZW5kaW5nIHdy
aXRlcyBpbnRvIG91ciBjaXJjdWxhciBidWZmZXIsIGluIGNhc2UKPj4gIAkJICogd2UgZGlkbid0
IGluIGdzX3N0YXJ0X3R4KCkgKi8KPj4gLQkJdHR5X3dha2V1cChwb3J0LT5wb3J0LnR0eSk7Cj4+
ICsJCWlmIChwb3J0LT5wb3J0LnR0eSkKPj4gKwkJCXR0eV93YWtldXAocG9ydC0+cG9ydC50dHkp
Owo+Cj5XaGF0IHByZXZlbnRzIHBvcnQudHR5IGZyb20gYmVpbmcgc2V0IHRvIE5VTEwgYmV0d2Vl
biB0aGUgY2hlY2sgYW5kIHRoZQo+Y2FsbCB0byB0dHlfd2FrZXVwPwo+Cj5TaG91bGRuJ3QgZ3Nf
Y2xvc2UoKSBhbmQgZ3NlcmlhbF9jb25uZWN0KCkgaGF2ZSBzb21lIHNvcnQgb2YgbG9ja2luZyB0
bwo+cHJldmVudCB0aGlzPwo+CkkgZW5jb3VudGVyZWQgdGhpcyBpc3N1ZSBvbiBTYW1zdW5nIEVY
WU5PUzk4MCBwbGF0Zm9ybSwgTWF5YmUgdGhpcyBpcyBwbGF0Zm9ybSBzcGVjaWZpYyBpc3N1ZS4K
VGhlIFVTQiBpbnRlcnJ1cHQgaGFuZGxlciBnb3QgcG9ydF9sb2NrIG9uIENQVSAwIGluIGdzZXJp
YWxfY29ubmVjdCB3aGlsZSBnc19jbG9zZSBpcyB3YWl0aW5nIGZvciAKdGhpcyBsb2NrIG9uIENQ
VSAxLiAgQnV0IHRoaXMgcG9ydF9sb2NrIHdpbGwgdW5sb2NrIGluIGdzX3N0YXJ0X2lvLS0+Z3Nf
c3RhcnRfcnggdGVtcG9yYXJpbHksIFRoaXMgcmFjZQpjb25kaXRpb24gbWF5IGNhdXNlIHBvcnQu
dHR5IHNldCBhcyBOVUxMLgoKPnRoYW5rcywKPgo+Z3JlZyBrLWgKDQoNCg==
