Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E088C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 07:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE652206F8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 07:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qc4QKYmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgCYH0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 03:26:38 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43587 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgCYH0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 03:26:38 -0400
Received: by mail-vs1-f67.google.com with SMTP id w185so883773vsw.10;
        Wed, 25 Mar 2020 00:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fOHuTUxFaXvYqen0oyjg96xjkmcXfO5BevtoiCO4Aoc=;
        b=Qc4QKYmZbTkn84IZ7OuK+k8tdccAz8+iwmT7AocwrXr/l7TEqXxY6uV7FPT5Q+R4r2
         DK/74cHx3v88CQFoASC3ioE1dfGpKq85uuuZsWBR1tZ9bZuGc6J6F2tdIY1A6ChjLNML
         VYrKXjMwhdAD/LkzUUV1sf68E7Gep6Ou2Uxd6e3MoW1W/jsM1CmBnW1YdcNDow7EAg4/
         yt1eDYt3VkFXNzuRLgwNuR5+Us0XWXAI407zB7eSklbTR/aprSH2KR6jkcoOUHkOdL7K
         xaS7BVZud92jfHWtpM1C2c6jyN2Qg13R7Gycaj6UsJ6fpynQYSiZBFYkm7bamwJU5W8F
         Q8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fOHuTUxFaXvYqen0oyjg96xjkmcXfO5BevtoiCO4Aoc=;
        b=q60xBk7I1/ir9OH3wWdZy68jgVzRLmZ9829sLBHQl7RfoH24F3SkF3pUnClaS1CyRH
         YlV8O2nRUXpR8EcIG8z+leIeIHfgens81HKDudqE8a/0rlAYpsBjltqOe8AIWTznIWCz
         FqvPnyMwh9syBRBEiBUkcb4Jgx/k0PFtxzqo8F+1mfeuP8IVQJCRYDCIiA6kyLGZg/Zq
         tdHlfGKUIYC8PH5GZfS1ivcumY+7xFOvOqH8NctHwkLBAyScJ0GhiAM+cbnnrQ8x/r6a
         QDOc/sPd3ApELKNzGanfo3+yFA7axhVH3nm6BMb9HNy1hqu2JPtPzEj9Mpbt+e9cJzrV
         CsOQ==
X-Gm-Message-State: ANhLgQ23E2cOUD7S+EmUi/WwHKNLUJznmG3Vu25i9HH6KdnjZ0ZkVDzG
        xaOcPOldwUnbYFl8v/qXxbSnOOgdetclhkC1Ay0=
X-Google-Smtp-Source: ADFU+vvflhlHeBMOrrqhKThBTo4W38UGjm2hmZjXmIzzYsJ7VYe+cLR23tCuGjYGLhnT9S6Vl8nmqQ66NJmkvbYOBKU=
X-Received: by 2002:a67:fe41:: with SMTP id m1mr1611504vsr.174.1585121195688;
 Wed, 25 Mar 2020 00:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ce3eed05a184efe9@google.com>
In-Reply-To: <000000000000ce3eed05a184efe9@google.com>
From:   Qiujun Huang <anenbupt@gmail.com>
Date:   Wed, 25 Mar 2020 15:26:25 +0800
Message-ID: <CADG63jBvx_NarKZT-+QmMAgdHKoYSQwtd9KO0c6rxkgtF_JnyA@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in edge_interrupt_callback
To:     syzbot <syzbot+37ba33391ad5f3935bbd@syzkaller.appspotmail.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Greg KH <gregkh@linuxfoundation.org>, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="000000000000cc5c3e05a1a8c977"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000cc5c3e05a1a8c977
Content-Type: text/plain; charset="UTF-8"

#syz test: https://github.com/google/kasan.git e17994d1

On Mon, Mar 23, 2020 at 8:40 PM syzbot
<syzbot+37ba33391ad5f3935bbd@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    e17994d1 usb: core: kcov: collect coverage from usb comple..
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=13706939e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5d64370c438bc60
> dashboard link: https://syzkaller.appspot.com/bug?extid=37ba33391ad5f3935bbd
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=150d3841e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12842b19e00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+37ba33391ad5f3935bbd@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in edge_interrupt_callback+0x8be/0x9d0 drivers/usb/serial/io_edgeport.c:715
> Read of size 1 at addr ffff8881d2920c67 by task swapper/0/0
>
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.6.0-rc5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0xef/0x16e lib/dump_stack.c:118
>  print_address_description.constprop.0.cold+0xd3/0x314 mm/kasan/report.c:374
>  __kasan_report.cold+0x37/0x77 mm/kasan/report.c:506
>  kasan_report+0xe/0x20 mm/kasan/common.c:641
>  edge_interrupt_callback+0x8be/0x9d0 drivers/usb/serial/io_edgeport.c:715
>  __usb_hcd_giveback_urb+0x29a/0x550 drivers/usb/core/hcd.c:1650
>  usb_hcd_giveback_urb+0x368/0x420 drivers/usb/core/hcd.c:1716
>  dummy_timer+0x1258/0x32ae drivers/usb/gadget/udc/dummy_hcd.c:1966
>  call_timer_fn+0x195/0x6f0 kernel/time/timer.c:1404
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches

--000000000000cc5c3e05a1a8c977
Content-Type: application/octet-stream; 
	name="0003-USB-io_edgeport-fix-slab-out-of-bounds-Read-in-edge_.patch"
Content-Disposition: attachment; 
	filename="0003-USB-io_edgeport-fix-slab-out-of-bounds-Read-in-edge_.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k87077l10>
X-Attachment-Id: f_k87077l10

RnJvbSBkZTQzY2QxZTdlMTY4NTZmN2JmYzYzZTFlZTQxZDJmZDA4YTNkNTgwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBRaXVqdW4gSHVhbmcgPGhxamFnYWluQGdtYWlsLmNvbT4KRGF0
ZTogV2VkLCAyNSBNYXIgMjAyMCAxNToxNzoxOCArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMy8zXSBV
U0I6IGlvX2VkZ2Vwb3J0OiBmaXggIHNsYWItb3V0LW9mLWJvdW5kcyBSZWFkIGluCiBlZGdlX2lu
dGVycnVwdF9jYWxsYmFjawoKVGhlIGJvdW5kYXJ5IGNvbmRpdGlvbiBzaG91bGQgYmUgKGxlbmd0
aCAtIDEpIGFzIHdlIGFjY2VzcyBkYXRhW3Bvc2l0aW9uKzFdLgoKUmVwb3J0ZWQtYnk6IHN5emJv
dCszN2JhMzMzOTFhZDVmMzkzNWJiZEBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tClNpZ25lZC1v
ZmYtYnk6IFFpdWp1biBIdWFuZyA8aHFqYWdhaW5AZ21haWwuY29tPgotLS0KIGRyaXZlcnMvdXNi
L3NlcmlhbC9pb19lZGdlcG9ydC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Ivc2VyaWFsL2lvX2Vk
Z2Vwb3J0LmMgYi9kcml2ZXJzL3VzYi9zZXJpYWwvaW9fZWRnZXBvcnQuYwppbmRleCA1NzM3YWRk
Li40Y2NhMGI4IDEwMDY0NAotLS0gYS9kcml2ZXJzL3VzYi9zZXJpYWwvaW9fZWRnZXBvcnQuYwor
KysgYi9kcml2ZXJzL3VzYi9zZXJpYWwvaW9fZWRnZXBvcnQuYwpAQCAtNzEwLDcgKzcxMCw3IEBA
IHN0YXRpYyB2b2lkIGVkZ2VfaW50ZXJydXB0X2NhbGxiYWNrKHN0cnVjdCB1cmIgKnVyYikKIAkJ
LyogZ3JhYiB0aGUgdHhjcmVkaXRzIGZvciB0aGUgcG9ydHMgaWYgYXZhaWxhYmxlICovCiAJCXBv
c2l0aW9uID0gMjsKIAkJcG9ydE51bWJlciA9IDA7Ci0JCXdoaWxlICgocG9zaXRpb24gPCBsZW5n
dGgpICYmCisJCXdoaWxlICgocG9zaXRpb24gPCBsZW5ndGggLSAxKSAmJgogCQkJCShwb3J0TnVt
YmVyIDwgZWRnZV9zZXJpYWwtPnNlcmlhbC0+bnVtX3BvcnRzKSkgewogCQkJdHhDcmVkaXRzID0g
ZGF0YVtwb3NpdGlvbl0gfCAoZGF0YVtwb3NpdGlvbisxXSA8PCA4KTsKIAkJCWlmICh0eENyZWRp
dHMpIHsKLS0gCjEuOC4zLjEKCg==
--000000000000cc5c3e05a1a8c977--
