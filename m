Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8EAC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FFE2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgCXNne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:43:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:55924 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727904AbgCXNnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:43:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0C7CEAC0C;
        Tue, 24 Mar 2020 13:43:31 +0000 (UTC)
Message-ID: <1585057397.7151.22.camel@suse.de>
Subject: Re: KASAN: slab-out-of-bounds Read in garmin_read_process
From:   Oliver Neukum <oneukum@suse.de>
To:     syzbot <syzbot+d29e9263e13ce0b9f4fd@syzkaller.appspotmail.com>,
        andreyknvl@google.com, gregkh@linuxfoundation.org,
        johan@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Date:   Tue, 24 Mar 2020 14:43:17 +0100
In-Reply-To: <000000000000ca19c205a15d8aca@google.com>
References: <000000000000ca19c205a15d8aca@google.com>
Content-Type: multipart/mixed; boundary="=-uEHle+UyLTjyzWxu00zb"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uEHle+UyLTjyzWxu00zb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Am Samstag, den 21.03.2020, 06:40 -0700 schrieb syzbot:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    e17994d1 usb: core: kcov: collect coverage from usb comple..
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=16255ce5e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5d64370c438bc60
> dashboard link: https://syzkaller.appspot.com/bug?extid=d29e9263e13ce0b9f4fd
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1376a3f9e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c65fe3e00000

#syz test: https://github.com/google/kasan.git e17994d1

--=-uEHle+UyLTjyzWxu00zb
Content-Disposition: attachment;
	filename="0002-garmin_gps-add-sanity-checking-for-data-length.patch"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch;
	name="0002-garmin_gps-add-sanity-checking-for-data-length.patch";
	charset="UTF-8"

RnJvbSAzNmJhOWM2NDI1M2NjNDIzODM3NmI3NDIzNWExNjMyODhhZjU5NjM4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29tPgpEYXRl
OiBUdWUsIDI0IE1hciAyMDIwIDEzOjQ2OjMxICswMTAwClN1YmplY3Q6IFtQQVRDSCAyLzJdIGdh
cm1pbl9ncHM6IGFkZCBzYW5pdHkgY2hlY2tpbmcgZm9yIGRhdGEgbGVuZ3RoCgpXZSBtdXN0IG5v
dCBwcm9jZXNzIHBhY2tldHMgc2hvcnRlciB0aGFuIGEgcGFja2V0IElECgpTaWduZWQtb2ZmLWJ5
OiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29tPgotLS0KIGRyaXZlcnMvdXNiL3Nlcmlh
bC9nYXJtaW5fZ3BzLmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Ivc2VyaWFsL2dhcm1pbl9n
cHMuYyBiL2RyaXZlcnMvdXNiL3NlcmlhbC9nYXJtaW5fZ3BzLmMKaW5kZXggZmZkOTg0MTQyMTcx
Li5hNzJmYmJjNjU0MzYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdXNiL3NlcmlhbC9nYXJtaW5fZ3Bz
LmMKKysrIGIvZHJpdmVycy91c2Ivc2VyaWFsL2dhcm1pbl9ncHMuYwpAQCAtMTEzOCw4ICsxMTM4
LDggQEAgc3RhdGljIHZvaWQgZ2FybWluX3JlYWRfcHJvY2VzcyhzdHJ1Y3QgZ2FybWluX2RhdGEg
Kmdhcm1pbl9kYXRhX3AsCiAJCSAgIHNlbmQgaXQgZGlyZWN0bHkgdG8gdGhlIHR0eSBwb3J0ICov
CiAJCWlmIChnYXJtaW5fZGF0YV9wLT5mbGFncyAmIEZMQUdTX1FVRVVJTkcpIHsKIAkJCXBrdF9h
ZGQoZ2FybWluX2RhdGFfcCwgZGF0YSwgZGF0YV9sZW5ndGgpOwotCQl9IGVsc2UgaWYgKGJ1bGtf
ZGF0YSB8fAotCQkJICAgZ2V0TGF5ZXJJZChkYXRhKSA9PSBHQVJNSU5fTEFZRVJJRF9BUFBMKSB7
CisJCX0gZWxzZSBpZiAoYnVsa19kYXRhIHx8IChkYXRhX2xlbmd0aCA+PSBzaXplb2YodTMyKSAm
JgorCQkJICAgZ2V0TGF5ZXJJZChkYXRhKSA9PSBHQVJNSU5fTEFZRVJJRF9BUFBMKSkgewogCiAJ
CQlzcGluX2xvY2tfaXJxc2F2ZSgmZ2FybWluX2RhdGFfcC0+bG9jaywgZmxhZ3MpOwogCQkJZ2Fy
bWluX2RhdGFfcC0+ZmxhZ3MgfD0gQVBQX1JFU1BfU0VFTjsKLS0gCjIuMTYuNAoK


--=-uEHle+UyLTjyzWxu00zb--

