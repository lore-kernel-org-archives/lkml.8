Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8893BC38A2A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 11:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A8EB20757
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 11:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lcrEA0GG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgEFLvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 07:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726778AbgEFLvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 07:51:04 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30485C061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 04:51:04 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d184so888963pfd.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 04:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NCWVLraG9Z8gnxmAn0SmeF0f40Gs+IBXqSv5TRfXTeo=;
        b=lcrEA0GGS/ODMtk1F9EbQgx/zhTGO7HwxM1q3YwRF1yV7sz+TG/gC9gvwnsxPQWUl5
         JzJDdag0D4HdVsx00o/HcFoqylOGBpDNPCWbqQ/5lsZ5Sj9+rB8rWUcyx2SqsNwKdLq8
         BRigHnSvx7Vx35Rhg2+39JJe9beD0dmVijEfEI5qklWM9IkysJcJsh92eP1QXtfb1/gB
         MpDZquvW1w0za/4eaHctNyYMhfXiCTbYy7yX0Fye2B7xdAqne9CJx8jqDuQgCCjKk5JG
         Rwed3oTTBNks+c1PQ37hE8Do/pVC9jiUjJdHmhoGcK51qUlm/m7+vArPv65nyVvo/gqc
         6lMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NCWVLraG9Z8gnxmAn0SmeF0f40Gs+IBXqSv5TRfXTeo=;
        b=CKlGhsdmPkvxnkmg1fuq7pwteeZLjHqyGfMhiri0/3gkW7gNnxuvITilp1xgzxAGaK
         ij3MFLEXzC4SBO9Ep7LzAf3BHPR4wQ3wPbPm/CTOHgVyRzZ99Z/VQ0skALTY9SA+AT1s
         YB7kCMXBdbUUBYx1y5tBVh/Ad0xsudVBwY21VOm9zmWO7TodGSBQgFsMYhCABmUts0QK
         qV87MNslZMCehq1xBndkdvsyqz9o1jW6ndfuDV3xDGl49P4TIA5LiB49V9drBTFYfF9a
         IMQXMlUWAAPnDdg+tQRcNkZmtsn8A24d0/Fvx7x15nLP+SJKX6vm4/mWcvMcct0tS+25
         tCLQ==
X-Gm-Message-State: AGi0PuZ8jbaRdELYtG8AXxJVZ4JEWrXpZHiLDpOHXLTMcV4kozVoeHXR
        k3LOHUnHL+w+HDqmVUtgclVir47Cr3xQhFuWK/hIoQ==
X-Google-Smtp-Source: APiQypLbnuslSjWfPJCL6GH8TRgkchj+mtZa+8D31hKdGt3QwTAT7sKf3dYFt1pz5KQgKBc84Vw4pl1Pwk8as9editc=
X-Received: by 2002:a63:a61:: with SMTP id z33mr6595886pgk.440.1588765863165;
 Wed, 06 May 2020 04:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000039420505a14e4951@google.com> <1588755226.13662.17.camel@suse.com>
In-Reply-To: <1588755226.13662.17.camel@suse.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 6 May 2020 13:50:52 +0200
Message-ID: <CAAeHK+zOdghTAu647iKBEU+0LqkYYOk0f7gPk_4T6BjNi=2sAQ@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in hfa384x_usbin_callback
To:     Oliver Neukum <oneukum@suse.com>
Cc:     syzbot <syzbot+7d42d68643a35f71ac8a@syzkaller.appspotmail.com>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>, nishkadg.linux@gmail.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: multipart/mixed; boundary="000000000000e870ed05a4f96035"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e870ed05a4f96035
Content-Type: text/plain; charset="UTF-8"

On Wed, May 6, 2020 at 10:54 AM Oliver Neukum <oneukum@suse.com> wrote:
>
> Am Freitag, den 20.03.2020, 12:28 -0700 schrieb syzbot:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    e17994d1 usb: core: kcov: collect coverage from usb comple..
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11d74573e00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5d64370c438bc60
> > dashboard link: https://syzkaller.appspot.com/bug?extid=7d42d68643a35f71ac8a
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fa561de00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d74573e00000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+7d42d68643a35f71ac8a@syzkaller.appspotmail.com
> >
>
> Hi,
>
> is this bug still active and can a test be run on it? I requested one
> yesterday. If my analysis is correct this bug has security
> implications, so it is kind of important.

I see your request in the queue and it's been registered and
completed, but for some reason syzbot didn't send an email with a
response.

Let me try this once again:

#syz test: https://github.com/google/kasan.git e17994d1

--000000000000e870ed05a4f96035
Content-Type: application/octet-stream; 
	name="0001-hfa384x_usb-fix-buffer-overflow.patch"
Content-Disposition: attachment; 
	filename="0001-hfa384x_usb-fix-buffer-overflow.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k9va5uf00>
X-Attachment-Id: f_k9va5uf00

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
--000000000000e870ed05a4f96035--
