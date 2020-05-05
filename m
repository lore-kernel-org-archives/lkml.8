Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEDCC47258
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5441206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbgEEL42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 07:56:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:57368 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728900AbgEEL4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 07:56:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 44235AC37;
        Tue,  5 May 2020 11:56:21 +0000 (UTC)
Message-ID: <1588679748.13662.8.camel@suse.com>
Subject: Re: KASAN: slab-out-of-bounds Read in hfa384x_usbin_callback
From:   Oliver Neukum <oneukum@suse.com>
To:     syzbot <syzbot+7d42d68643a35f71ac8a@syzkaller.appspotmail.com>,
        andreyknvl@google.com, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, nishkadg.linux@gmail.com,
        syzkaller-bugs@googlegroups.com
Date:   Tue, 05 May 2020 13:55:48 +0200
In-Reply-To: <00000000000039420505a14e4951@google.com>
References: <00000000000039420505a14e4951@google.com>
Content-Type: multipart/mixed; boundary="=-L0cX0s0IEEouwFjJ7n/w"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-L0cX0s0IEEouwFjJ7n/w
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Am Freitag, den 20.03.2020, 12:28 -0700 schrieb syzbot:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    e17994d1 usb: core: kcov: collect coverage from usb comple..
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=11d74573e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5d64370c438bc60
> dashboard link: https://syzkaller.appspot.com/bug?extid=7d42d68643a35f71ac8a
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fa561de00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d74573e00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+7d42d68643a35f71ac8a@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in memcpy include/linux/string.h:381 [inline]
> BUG: KASAN: slab-out-of-bounds in skb_put_data include/linux/skbuff.h:2284 [inline]
> BUG: KASAN: slab-out-of-bounds in hfa384x_int_rxmonitor drivers/staging/wlan-ng/hfa384x_usb.c:3412 [inline]
> BUG: KASAN: slab-out-of-bounds in hfa384x_usbin_rx drivers/staging/wlan-ng/hfa384x_usb.c:3312 [inline]
> BUG: KASAN: slab-out-of-bounds in hfa384x_usbin_callback+0x1993/0x2360 drivers/staging/wlan-ng/hfa384x_usb.c:3026
> Read of size 19671 at addr ffff8881d226413c by task swapper/0/0

#syz test: https://github.com/google/kasan.git e17994d1
--=-L0cX0s0IEEouwFjJ7n/w
Content-Disposition: attachment; filename="0001-hfa384x_usb-fix-buffer-overflow.patch"
Content-Type: text/x-patch; name="0001-hfa384x_usb-fix-buffer-overflow.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSA2ZGJjYWM4YzRiNjQ1NjAwMTYxZmVhZmM1NTc2NjU3OTA1ZjE1ZDY1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29tPgpEYXRl
OiBUdWUsIDUgTWF5IDIwMjAgMTM6NDY6MjYgKzAyMDAKU3ViamVjdDogW1BBVENIXSBoZmEzODR4
X3VzYjogZml4IGJ1ZmZlciBvdmVyZmxvdwoKVGhlIGRyaXZlciB0cnVzdHMgdGhlIGRhdGFfbGVu
IGNvbWluZyBmcm9tIHRoZSBoYXJkd2FyZQp3aXRob3V0IHZlcmlmaWNhdGlvbi4gVGhhdCBtZWFu
cyB0aGF0IHRoaXMgb3BlbnMKYSB2ZWN0b3IgYnkgd2hpY2ggYW4gYXR0YWNrZXIgY2FuIHNtYXNo
IDY0SyBvZiB0aGUgaGVhcC4KClNpZ25lZC1vZmYtYnk6IE9saXZlciBOZXVrdW0gPG9uZXVrdW1A
c3VzZS5jb20+Ci0tLQogZHJpdmVycy9zdGFnaW5nL3dsYW4tbmcvaGZhMzg0eF91c2IuYyB8IDEy
ICsrKysrKystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvd2xhbi1uZy9oZmEzODR4X3VzYi5j
IGIvZHJpdmVycy9zdGFnaW5nL3dsYW4tbmcvaGZhMzg0eF91c2IuYwppbmRleCBmYTFiZjhiMDY5
ZmQuLjViNjQ5N2Q4YzllMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9zdGFnaW5nL3dsYW4tbmcvaGZh
Mzg0eF91c2IuYworKysgYi9kcml2ZXJzL3N0YWdpbmcvd2xhbi1uZy9oZmEzODR4X3VzYi5jCkBA
IC0zMzUzLDkgKzMzNTMsOSBAQCBzdGF0aWMgdm9pZCBoZmEzODR4X2ludF9yeG1vbml0b3Ioc3Ry
dWN0IHdsYW5kZXZpY2UgKndsYW5kZXYsCiAJCQkJICBzdHJ1Y3QgaGZhMzg0eF91c2Jfcnhmcm0g
KnJ4ZnJtKQogewogCXN0cnVjdCBoZmEzODR4X3J4X2ZyYW1lICpyeGRlc2MgPSAmcnhmcm0tPmRl
c2M7Ci0JdW5zaWduZWQgaW50IGhkcmxlbiA9IDA7Ci0JdW5zaWduZWQgaW50IGRhdGFsZW4gPSAw
OwotCXVuc2lnbmVkIGludCBza2JsZW4gPSAwOworCXVuc2lnbmVkIGludCBoZHJsZW47CisJdW5z
aWduZWQgaW50IGRhdGFsZW47CisJdW5zaWduZWQgaW50IHNrYmxlbjsKIAl1OCAqZGF0YXA7CiAJ
dTE2IGZjOwogCXN0cnVjdCBza19idWZmICpza2I7CkBAIC0zNDEzLDggKzM0MTMsMTAgQEAgc3Rh
dGljIHZvaWQgaGZhMzg0eF9pbnRfcnhtb25pdG9yKHN0cnVjdCB3bGFuZGV2aWNlICp3bGFuZGV2
LAogCSAqLwogCXNrYl9wdXRfZGF0YShza2IsICZyeGRlc2MtPmZyYW1lX2NvbnRyb2wsIGhkcmxl
bik7CiAKLQkvKiBJZiBhbnksIGNvcHkgdGhlIGRhdGEgZnJvbSB0aGUgY2FyZCB0byB0aGUgc2ti
ICovCi0JaWYgKGRhdGFsZW4gPiAwKSB7CisJLyogSWYgYW55LCBjb3B5IHRoZSBkYXRhIGZyb20g
dGhlIGNhcmQgdG8gdGhlIHNrYiwKKwkgKiBhcyBsb25nIGFzIGl0IGZpdHMsIGxlc3Qgd2Ugc21h
c2ggYSBidWZmZXIKKwkgKi8KKwlpZiAoZGF0YWxlbiA+IDAgJiYgZGF0YWxlbiA8PSBza2JsZW4g
LSBoZHJsZW4pIHsKIAkJZGF0YXAgPSBza2JfcHV0X2RhdGEoc2tiLCByeGZybS0+ZGF0YSwgZGF0
YWxlbik7CiAKIAkJLyogY2hlY2sgZm9yIHVuZW5jcnlwdGVkIHN0dWZmIGlmIFdFUCBiaXQgc2V0
LiAqLwotLSAKMi4xNi40Cgo=


--=-L0cX0s0IEEouwFjJ7n/w--

