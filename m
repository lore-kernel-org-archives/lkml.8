Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3060C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B868220768
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 23:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595633179;
	bh=7P3jKtPxhXfzbtgQg30KABT3bON0Jak2YINbg6oelKQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0xWw34x2zhzCcL7cJuaY4QECVieS3VGPZbbaZ700cO8YSmh3Tnl2JmCBnf82oasQI
	 X6I5Zw/SfscKFnB33xNPQUqz59wpyFM6UsDQcVrWAxoJhVXkAkZZDbnB5ZbrRQmVw+
	 f0YR77DG4iNzAHQagGrGUxhiTHOJaQJJNJeBR+pI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgGXX0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 19:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgGXX0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 19:26:18 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57A3C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 16:26:17 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id j22so146981lfm.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 16:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FCOCmAnXTE7rgEisjzU4LDufxCROSWiZAdkgGpbkaeM=;
        b=R5+ox8+lAZ0OQvHzjQKvw5Em1qvtnp8XYSq4FZEfYpXohFMtdM6OQnV35Xq8k+QMST
         Wo7V9VEp8ab+ZpRs3ATwQhvpfsfV2D5tJk8BlLlVdTBcuamptMu02JvB0+2/kGbyGa6J
         7m8y5cIU8WSCI9ffD6OJsVYDDSQYYB14zj3tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FCOCmAnXTE7rgEisjzU4LDufxCROSWiZAdkgGpbkaeM=;
        b=X27ZGOYYmPOe+KTWREdm41E/zS1ztg42/RHdGM045UY4SCgAUTEcHVEQ4rStnyKG+G
         FfZz4kTjqBeWTsMDwTiKLiXV60PjDtET4XymVI+pWGO9ghL2Tjp1fInEivme82Siu4wP
         gwyPPu9dhR7BhO+UiKYgR+QIzqt54kGztX18EbWXFLeM2fjSXgELGc9YDRyhlxAdAGdz
         5AgpNgSXBomaENsOzCIyGS4xjnxudiGStaEJNWPG0+b5wg9aOlchQzyZR2FZ9xmprG8f
         gbaDlEM0L5C405YCaLOcdimuDUaMO34ZZqnhcdq8dbaReRIVtA9g30WVEPWIZvvfa6wt
         T5ng==
X-Gm-Message-State: AOAM533Vow7IjZnePnXPEv81LyRxHkoBXBfoRmINznAFgGcJ3XOnRbO2
        AObXtTyZSWEK29EGEcwdp9S2w8otO4E=
X-Google-Smtp-Source: ABdhPJzp2f3ljqHlYpDo6/mn/C5RWEzHqZTrT7TEiJfTVsURNU2g0at6SGnF1N252zJd1/2bkGUBCg==
X-Received: by 2002:a05:6512:14d:: with SMTP id m13mr6168646lfo.173.1595633175802;
        Fri, 24 Jul 2020 16:26:15 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id n82sm685112lfa.40.2020.07.24.16.26.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 16:26:14 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id q6so11580089ljp.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 16:26:14 -0700 (PDT)
X-Received: by 2002:a05:651c:1b6:: with SMTP id c22mr4677131ljn.421.1595633173620;
 Fri, 24 Jul 2020 16:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whewL14RgwLZTXcNAnrDPt0H+sRJS6iDq0oGb6zwaBMxg@mail.gmail.com>
 <CAHk-=whb0=rjc1WR+F_r_syw5Ld4=ebuNJmmpaPEzfjZRD5Y-w@mail.gmail.com>
 <alpine.LSU.2.11.2007221359450.1017@eggly.anvils> <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com>
 <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com>
 <20200723124749.GA7428@redhat.com> <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com>
 <CAHk-=whQK3OGwExTzCrwwvuuVaQAgs8KsR-Yv8m1BmXoNZZ=jQ@mail.gmail.com>
 <alpine.LSU.2.11.2007231549540.1016@eggly.anvils> <CAHk-=wgvGOnMF0ePU4xS236bOsP8jouj3rps+ysCaGXvCjh2Dg@mail.gmail.com>
 <20200724152424.GC17209@redhat.com> <CAHk-=whuG+5pUeUqdiW4gk0prvqu7GZSMo-6oWv5PdDC5dBr=A@mail.gmail.com>
In-Reply-To: <CAHk-=whuG+5pUeUqdiW4gk0prvqu7GZSMo-6oWv5PdDC5dBr=A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Jul 2020 16:25:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjYHvbOs9i39EnUsC6VEJiuJ2e_5gZB5-J5CRKxq80B_Q@mail.gmail.com>
Message-ID: <CAHk-=wjYHvbOs9i39EnUsC6VEJiuJ2e_5gZB5-J5CRKxq80B_Q@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: multipart/mixed; boundary="00000000000081c57b05ab384cb2"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000081c57b05ab384cb2
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 24, 2020 at 10:32 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Ok, that makes sense. Except you did it on top of the original patch
> without the fix to set WQ_FLAG_WOKEN for the non-wakeup case.

Hmm.

I just realized that one thing we could do is to not even test the
page bit for the shared case in the wakeup path.

Because anybody who uses the non-exclusive "wait_on_page_locked()" or
"wait_on_page_writeback()" isn't actually interested in the bit state
any more at that point. All they care about is that somebody cleared
it - not whether it was then re-taken again.

So instead of keeping them on the list - or stopping the waitqueue
walk because somebody else got the bit - we could just mark them
successfully done, wake them up, and remove those entries from the
list.

That would be better for everybody - less pointless waiting for a new
lock or writeback event, but also fewer entries on the wait queues as
we get rid of them more quickly instead of walking them over and over
just because somebody else re-took the page lock.

Generally "wait_on_page_locked()" is used for two things

 - either wait for the IO to then check if it's now uptodate

 - throttle things that can't afford to lock the page (eg page faults
that dropped the mm lock, and as such need to go through the whole
restart logic, but that don't want to lock the page because it's now
too late, but also the page migration things)

In the first case, waiting to actually seeing the locked bit clear is
pointless - the code only cared about the "wait for IO in progress"
not about the lock bit itself.

And that second case generally might want to retry, but doesn't want
to busy-loop.

And "wait_on_page_writeback()" is basically used for similar reasons
(ie check if there were IO errors, but also possibly to throttle
writeback traffic).

Saying "stop walking, keep it on the list" seems wrong. It makes IO
error handling and retries much worse, for example.

So it turns out that the wakeup logic and the initial wait logic don't
have so much in common after all, and there is a fundamental
conceptual difference between that "check bit one last time" case, and
the "we got woken up, now what" case..

End result: one final (yes, hopefully - I think I'm done) version of
this patch-series.

This not only makes the code cleaner (the generated code for
wake_up_page() is really quite nice now), but getting rid of extra
waiting might help the load that Michal reported.

Because a lot of page waiting might be that non-exclusive
"wait_on_page_locked()" kind, particularly in the thundering herd kind
of situation where one process starts IO, and then other processes
wait for it to finish.

Those users don't even care if somebody else then did a "lock_page()"
for some other reason (maybe for writeback). They are generally
perfectly happy with a locked page, as long as it's now up-to-date.

So this not only simplifies the code, it really might avoid some problems too.

               Linus

--00000000000081c57b05ab384cb2
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-mm-rewrite-wait_on_page_bit_common-logic.patch"
Content-Disposition: attachment; 
	filename="0001-mm-rewrite-wait_on_page_bit_common-logic.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kd0us0jf0>
X-Attachment-Id: f_kd0us0jf0

RnJvbSAwYmNjYjYwODQxY2M1MmE5YWE2ZTljYzZiN2VmZjU5ZDE5ODNlOGZhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFRodSwgMjMgSnVsIDIwMjAgMTA6MTY6NDkgLTA3MDAKU3ViamVjdDog
W1BBVENIIDEvMl0gbW06IHJld3JpdGUgd2FpdF9vbl9wYWdlX2JpdF9jb21tb24oKSBsb2dpYwoK
SXQgdHVybnMgb3V0IHRoYXQgd2FpdF9vbl9wYWdlX2JpdF9jb21tb24oKSBoYWQgc2V2ZXJhbCBw
cm9ibGVtcywKcmFuZ2luZyBmcm9tIGp1c3QgdW5mYWlyIGJlaGF2aW9lIGR1ZSB0byByZS1xdWV1
ZWluZyBhdCB0aGUgZW5kIG9mIHRoZQp3YWl0IHF1ZXVlIHdoZW4gcmUtdHJ5aW5nLCBhbmQgYW4g
b3V0cmlnaHQgYnVnIHRoYXQgY291bGQgcmVzdWx0IGluCm1pc3NlZCB3YWtldXBzIChidXQgcHJv
YmFibHkgbmV2ZXIgaGFwcGVuZWQgaW4gcHJhY3RpY2UpLgoKVGhpcyByZXdyaXRlcyB0aGUgd2hv
bGUgbG9naWMgdG8gYXZvaWQgYm90aCBpc3N1ZXMsIGJ5IHNpbXBseSBtb3ZpbmcgdGhlCmxvZ2lj
IHRvIGNoZWNrIChhbmQgcG9zc2libHkgdGFrZSkgdGhlIGJpdCBsb2NrIGludG8gdGhlIHdha2V1
cCBwYXRoCmluc3RlYWQuCgpUaGF0IG1ha2VzIGV2ZXJ5dGhpbmcgbXVjaCBtb3JlIHN0cmFpZ2h0
Zm9yd2FyZCwgYW5kIG1lYW5zIHRoYXQgd2UgbmV2ZXIKbmVlZCB0byByZS1xdWV1ZSB0aGUgd2Fp
dCBlbnRyeTogaWYgd2UgZ2V0IHdva2VuIHVwLCB3ZSdsbCBiZSBub3RpZmllZAp0aHJvdWdoIFdR
X0ZMQUdfV09LRU4sIGFuZCB0aGUgd2FpdCBxdWV1ZSBlbnRyeSB3aWxsIGhhdmUgYmVlbiByZW1v
dmVkLAphbmQgZXZlcnl0aGluZyB3aWxsIGhhdmUgYmVlbiBkb25lIGZvciB1cy4KCkxpbms6IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvQ0FIay09d2pKQTJaM2tVRmItNXM9NituMHFiVHM4
RUxxS0Z0OUIzcEg4NWE4ZkdENzN3QG1haWwuZ21haWwuY29tLwpMaW5rOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9sa21sL2FscGluZS5MU1UuMi4xMS4yMDA3MjIxMzU5NDUwLjEwMTdAZWdnbHku
YW52aWxzLwpSZXBvcnRlZC1ieTogT2xlZyBOZXN0ZXJvdiA8b2xlZ0ByZWRoYXQuY29tPgpSZXBv
cnRlZC1ieTogSHVnaCBEaWNraW5zIDxodWdoZEBnb29nbGUuY29tPgpDYzogTWljaGFsIEhvY2tv
IDxtaG9ja29Ac3VzZS5jb20+ClJldmlld2VkLWJ5OiBPbGVnIE5lc3Rlcm92IDxvbGVnQHJlZGhh
dC5jb20+ClNpZ25lZC1vZmYtYnk6IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1mb3Vu
ZGF0aW9uLm9yZz4KLS0tCiBtbS9maWxlbWFwLmMgfCAxMzIgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgODUgaW5zZXJ0
aW9ucygrKSwgNDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbW0vZmlsZW1hcC5jIGIvbW0v
ZmlsZW1hcC5jCmluZGV4IDM4NTc1OWM0Y2U0Yi4uOGMzZDNlMjMzZDM3IDEwMDY0NAotLS0gYS9t
bS9maWxlbWFwLmMKKysrIGIvbW0vZmlsZW1hcC5jCkBAIC0xMDAyLDYgKzEwMDIsNyBAQCBzdHJ1
Y3Qgd2FpdF9wYWdlX3F1ZXVlIHsKIAogc3RhdGljIGludCB3YWtlX3BhZ2VfZnVuY3Rpb24od2Fp
dF9xdWV1ZV9lbnRyeV90ICp3YWl0LCB1bnNpZ25lZCBtb2RlLCBpbnQgc3luYywgdm9pZCAqYXJn
KQogeworCWludCByZXQ7CiAJc3RydWN0IHdhaXRfcGFnZV9rZXkgKmtleSA9IGFyZzsKIAlzdHJ1
Y3Qgd2FpdF9wYWdlX3F1ZXVlICp3YWl0X3BhZ2UKIAkJPSBjb250YWluZXJfb2Yod2FpdCwgc3Ry
dWN0IHdhaXRfcGFnZV9xdWV1ZSwgd2FpdCk7CkBAIC0xMDE0LDE3ICsxMDE1LDQwIEBAIHN0YXRp
YyBpbnQgd2FrZV9wYWdlX2Z1bmN0aW9uKHdhaXRfcXVldWVfZW50cnlfdCAqd2FpdCwgdW5zaWdu
ZWQgbW9kZSwgaW50IHN5bmMsCiAJCXJldHVybiAwOwogCiAJLyoKLQkgKiBTdG9wIHdhbGtpbmcg
aWYgaXQncyBsb2NrZWQuCi0JICogSXMgdGhpcyBzYWZlIGlmIHB1dF9hbmRfd2FpdF9vbl9wYWdl
X2xvY2tlZCgpIGlzIGluIHVzZT8KLQkgKiBZZXM6IHRoZSB3YWtlciBtdXN0IGhvbGQgYSByZWZl
cmVuY2UgdG8gdGhpcyBwYWdlLCBhbmQgaWYgUEdfbG9ja2VkCi0JICogaGFzIG5vdyBhbHJlYWR5
IGJlZW4gc2V0IGJ5IGFub3RoZXIgdGFzaywgdGhhdCB0YXNrIG11c3QgYWxzbyBob2xkCi0JICog
YSByZWZlcmVuY2UgdG8gdGhlICpzYW1lIHVzYWdlKiBvZiB0aGlzIHBhZ2U7IHNvIHRoZXJlIGlz
IG5vIG5lZWQKLQkgKiB0byB3YWxrIG9uIHRvIHdha2UgZXZlbiB0aGUgcHV0X2FuZF93YWl0X29u
X3BhZ2VfbG9ja2VkKCkgY2FsbGVycy4KKwkgKiBJZiBpdCdzIGFuIGV4Y2x1c2l2ZSB3YWl0LCB3
ZSBnZXQgdGhlIGJpdCBmb3IgaXQsIGFuZAorCSAqIHN0b3Agd2Fsa2luZyBpZiB3ZSBjYW4ndC4K
KwkgKgorCSAqIElmIGl0J3MgYSBub24tZXhjbHVzaXZlIHdhaXQsIHRoZW4gdGhlIGZhY3QgdGhh
dCB0aGlzCisJICogd2FrZSBmdW5jdGlvbiB3YXMgY2FsbGVkIG1lYW5zIHRoYXQgdGhlIGJpdCBh
bHJlYWR5CisJICogd2FzIGNsZWFyZWQsIGFuZCB3ZSBkb24ndCBjYXJlIGlmIHNvbWVib2R5IHRo
ZW4KKwkgKiByZS10b29rIGl0LgogCSAqLwotCWlmICh0ZXN0X2JpdChrZXktPmJpdF9uciwgJmtl
eS0+cGFnZS0+ZmxhZ3MpKQotCQlyZXR1cm4gLTE7CisJcmV0ID0gMDsKKwlpZiAod2FpdC0+Zmxh
Z3MgJiBXUV9GTEFHX0VYQ0xVU0lWRSkgeworCQlpZiAodGVzdF9hbmRfc2V0X2JpdChrZXktPmJp
dF9uciwgJmtleS0+cGFnZS0+ZmxhZ3MpKQorCQkJcmV0dXJuIC0xOworCQlyZXQgPSAxOworCX0K
Kwl3YWl0LT5mbGFncyB8PSBXUV9GTEFHX1dPS0VOOwogCi0JcmV0dXJuIGF1dG9yZW1vdmVfd2Fr
ZV9mdW5jdGlvbih3YWl0LCBtb2RlLCBzeW5jLCBrZXkpOworCXdha2VfdXBfc3RhdGUod2FpdC0+
cHJpdmF0ZSwgbW9kZSk7CisKKwkvKgorCSAqIE9rLCB3ZSBoYXZlIHN1Y2Nlc3NmdWxseSBkb25l
IHdoYXQgd2UncmUgd2FpdGluZyBmb3IsCisJICogYW5kIHdlIGNhbiB1bmNvbmRpdGlvbmFsbHkg
cmVtb3ZlIHRoZSB3YWl0IGVudHJ5LgorCSAqCisJICogTm90ZSB0aGF0IHRoaXMgaGFzIHRvIGJl
IHRoZSBhYnNvbHV0ZSBsYXN0IHRoaW5nIHdlIGRvLAorCSAqIHNpbmNlIGFmdGVyIGxpc3RfZGVs
X2luaXQoJndhaXQtPmVudHJ5KSB0aGUgd2FpdCBlbnRyeQorCSAqIG1pZ2h0IGJlIGRlLWFsbG9j
YXRlZCBhbmQgdGhlIHByb2Nlc3MgbWlnaHQgZXZlbiBoYXZlCisJICogZXhpdGVkLgorCSAqCisJ
ICogV2UgX3JlYWxseV8gc2hvdWxkIGhhdmUgYSAibGlzdF9kZWxfaW5pdF9jYXJlZnVsKCkiIHRv
CisJICogcHJvcGVybHkgcGFpciB3aXRoIHRoZSB1bmxvY2tlZCAibGlzdF9lbXB0eV9jYXJlZnVs
KCkiCisJICogaW4gZmluaXNoX3dhaXQoKS4KKwkgKi8KKwlzbXBfbWIoKTsKKwlsaXN0X2RlbF9p
bml0KCZ3YWl0LT5lbnRyeSk7CisJcmV0dXJuIHJldDsKIH0KIAogc3RhdGljIHZvaWQgd2FrZV91
cF9wYWdlX2JpdChzdHJ1Y3QgcGFnZSAqcGFnZSwgaW50IGJpdF9ucikKQEAgLTExMDMsMTYgKzEx
MjcsMzEgQEAgZW51bSBiZWhhdmlvciB7CiAJCQkgKi8KIH07CiAKKy8qCisgKiBBdHRlbXB0IHRv
IGNoZWNrIChvciBnZXQpIHRoZSBwYWdlIGJpdCwgYW5kIG1hcmsgdGhlCisgKiB3YWl0ZXIgd29r
ZW4gaWYgc3VjY2Vzc2Z1bC4KKyAqLworc3RhdGljIGlubGluZSBib29sIHRyeWxvY2tfcGFnZV9i
aXRfY29tbW9uKHN0cnVjdCBwYWdlICpwYWdlLCBpbnQgYml0X25yLAorCQkJCQlzdHJ1Y3Qgd2Fp
dF9xdWV1ZV9lbnRyeSAqd2FpdCkKK3sKKwlpZiAod2FpdC0+ZmxhZ3MgJiBXUV9GTEFHX0VYQ0xV
U0lWRSkgeworCQlpZiAodGVzdF9hbmRfc2V0X2JpdChiaXRfbnIsICZwYWdlLT5mbGFncykpCisJ
CQlyZXR1cm4gZmFsc2U7CisJfSBlbHNlIGlmICh0ZXN0X2JpdChiaXRfbnIsICZwYWdlLT5mbGFn
cykpCisJCXJldHVybiBmYWxzZTsKKworCXdhaXQtPmZsYWdzIHw9IFdRX0ZMQUdfV09LRU47CisJ
cmV0dXJuIHRydWU7Cit9CisKIHN0YXRpYyBpbmxpbmUgaW50IHdhaXRfb25fcGFnZV9iaXRfY29t
bW9uKHdhaXRfcXVldWVfaGVhZF90ICpxLAogCXN0cnVjdCBwYWdlICpwYWdlLCBpbnQgYml0X25y
LCBpbnQgc3RhdGUsIGVudW0gYmVoYXZpb3IgYmVoYXZpb3IpCiB7CiAJc3RydWN0IHdhaXRfcGFn
ZV9xdWV1ZSB3YWl0X3BhZ2U7CiAJd2FpdF9xdWV1ZV9lbnRyeV90ICp3YWl0ID0gJndhaXRfcGFn
ZS53YWl0OwotCWJvb2wgYml0X2lzX3NldDsKIAlib29sIHRocmFzaGluZyA9IGZhbHNlOwogCWJv
b2wgZGVsYXlhY2N0ID0gZmFsc2U7CiAJdW5zaWduZWQgbG9uZyBwZmxhZ3M7Ci0JaW50IHJldCA9
IDA7CiAKIAlpZiAoYml0X25yID09IFBHX2xvY2tlZCAmJgogCSAgICAhUGFnZVVwdG9kYXRlKHBh
Z2UpICYmIFBhZ2VXb3JraW5nc2V0KHBhZ2UpKSB7CkBAIC0xMTMwLDQ4ICsxMTY5LDQ3IEBAIHN0
YXRpYyBpbmxpbmUgaW50IHdhaXRfb25fcGFnZV9iaXRfY29tbW9uKHdhaXRfcXVldWVfaGVhZF90
ICpxLAogCXdhaXRfcGFnZS5wYWdlID0gcGFnZTsKIAl3YWl0X3BhZ2UuYml0X25yID0gYml0X25y
OwogCi0JZm9yICg7OykgewotCQlzcGluX2xvY2tfaXJxKCZxLT5sb2NrKTsKKwkvKgorCSAqIERv
IG9uZSBsYXN0IGNoZWNrIHdoZXRoZXIgd2UgY2FuIGdldCB0aGUKKwkgKiBwYWdlIGJpdCBzeW5j
aHJvbm91c2x5LgorCSAqCisJICogRG8gdGhlIFNldFBhZ2VXYWl0ZXJzKCkgbWFya2luZyBiZWZv
cmUgdGhhdAorCSAqIHRvIGxldCBhbnkgd2FrZXIgd2UgX2p1c3RfIG1pc3NlZCBrbm93IHRoZXkK
KwkgKiBuZWVkIHRvIHdha2UgdXMgdXAgKG90aGVyd2lzZSB0aGV5J2xsIG5ldmVyCisJICogZXZl
biBnbyB0byB0aGUgc2xvdyBjYXNlIHRoYXQgbG9va3MgYXQgdGhlCisJICogcGFnZSBxdWV1ZSks
IGFuZCBhZGQgb3Vyc2VsdmVzIHRvIHRoZSB3YWl0CisJICogcXVldWUgaWYgd2UgbmVlZCB0byBz
bGVlcC4KKwkgKgorCSAqIFRoaXMgcGFydCBuZWVkcyB0byBiZSBkb25lIHVuZGVyIHRoZSBxdWV1
ZQorCSAqIGxvY2sgdG8gYXZvaWQgcmFjZXMuCisJICovCisJc3Bpbl9sb2NrX2lycSgmcS0+bG9j
ayk7CisJU2V0UGFnZVdhaXRlcnMocGFnZSk7CisJaWYgKCF0cnlsb2NrX3BhZ2VfYml0X2NvbW1v
bihwYWdlLCBiaXRfbnIsIHdhaXQpKQorCQlfX2FkZF93YWl0X3F1ZXVlX2VudHJ5X3RhaWwocSwg
d2FpdCk7CisJc3Bpbl91bmxvY2tfaXJxKCZxLT5sb2NrKTsKIAotCQlpZiAobGlrZWx5KGxpc3Rf
ZW1wdHkoJndhaXQtPmVudHJ5KSkpIHsKLQkJCV9fYWRkX3dhaXRfcXVldWVfZW50cnlfdGFpbChx
LCB3YWl0KTsKLQkJCVNldFBhZ2VXYWl0ZXJzKHBhZ2UpOwotCQl9CisJLyoKKwkgKiBGcm9tIG5v
dyBvbiwgYWxsIHRoZSBsb2dpYyB3aWxsIGJlIGJhc2VkIG9uCisJICogdGhlIFdRX0ZMQUdfV09L
RU4gZmxhZywgYW5kIHRoZSBhbmQgdGhlIHBhZ2UKKwkgKiBiaXQgdGVzdGluZyAoYW5kIHNldHRp
bmcpIHdpbGwgYmUgLSBvciBoYXMKKwkgKiBhbHJlYWR5IGJlZW4gLSBkb25lIGJ5IHRoZSB3YWtl
IGZ1bmN0aW9uLgorCSAqCisJICogV2UgY2FuIGRyb3Agb3VyIHJlZmVyZW5jZSB0byB0aGUgcGFn
ZS4KKwkgKi8KKwlpZiAoYmVoYXZpb3IgPT0gRFJPUCkKKwkJcHV0X3BhZ2UocGFnZSk7CiAKKwlm
b3IgKDs7KSB7CiAJCXNldF9jdXJyZW50X3N0YXRlKHN0YXRlKTsKIAotCQlzcGluX3VubG9ja19p
cnEoJnEtPmxvY2spOwotCi0JCWJpdF9pc19zZXQgPSB0ZXN0X2JpdChiaXRfbnIsICZwYWdlLT5m
bGFncyk7Ci0JCWlmIChiZWhhdmlvciA9PSBEUk9QKQotCQkJcHV0X3BhZ2UocGFnZSk7Ci0KLQkJ
aWYgKGxpa2VseShiaXRfaXNfc2V0KSkKLQkJCWlvX3NjaGVkdWxlKCk7Ci0KLQkJaWYgKGJlaGF2
aW9yID09IEVYQ0xVU0lWRSkgewotCQkJaWYgKCF0ZXN0X2FuZF9zZXRfYml0X2xvY2soYml0X25y
LCAmcGFnZS0+ZmxhZ3MpKQotCQkJCWJyZWFrOwotCQl9IGVsc2UgaWYgKGJlaGF2aW9yID09IFNI
QVJFRCkgewotCQkJaWYgKCF0ZXN0X2JpdChiaXRfbnIsICZwYWdlLT5mbGFncykpCi0JCQkJYnJl
YWs7Ci0JCX0KLQotCQlpZiAoc2lnbmFsX3BlbmRpbmdfc3RhdGUoc3RhdGUsIGN1cnJlbnQpKSB7
Ci0JCQlyZXQgPSAtRUlOVFI7CisJCWlmIChzaWduYWxfcGVuZGluZ19zdGF0ZShzdGF0ZSwgY3Vy
cmVudCkpCiAJCQlicmVhazsKLQkJfQogCi0JCWlmIChiZWhhdmlvciA9PSBEUk9QKSB7Ci0JCQkv
KgotCQkJICogV2UgY2FuIG5vIGxvbmdlciBzYWZlbHkgYWNjZXNzIHBhZ2UtPmZsYWdzOgotCQkJ
ICogZXZlbiBpZiBDT05GSUdfTUVNT1JZX0hPVFJFTU9WRSBpcyBub3QgZW5hYmxlZCwKLQkJCSAq
IHRoZXJlIGlzIGEgcmlzayBvZiB3YWl0aW5nIGZvcmV2ZXIgb24gYSBwYWdlIHJldXNlZAotCQkJ
ICogZm9yIHNvbWV0aGluZyB0aGF0IGtlZXBzIGl0IGxvY2tlZCBpbmRlZmluaXRlbHkuCi0JCQkg
KiBCdXQgYmVzdCBjaGVjayBmb3IgLUVJTlRSIGFib3ZlIGJlZm9yZSBicmVha2luZy4KLQkJCSAq
LworCQlpZiAod2FpdC0+ZmxhZ3MgJiBXUV9GTEFHX1dPS0VOKQogCQkJYnJlYWs7Ci0JCX0KKwor
CQlpb19zY2hlZHVsZSgpOwogCX0KIAogCWZpbmlzaF93YWl0KHEsIHdhaXQpOwpAQCAtMTE5MCw3
ICsxMjI4LDcgQEAgc3RhdGljIGlubGluZSBpbnQgd2FpdF9vbl9wYWdlX2JpdF9jb21tb24od2Fp
dF9xdWV1ZV9oZWFkX3QgKnEsCiAJICogYm90aGVyIHdpdGggc2lnbmFscyBlaXRoZXIuCiAJICov
CiAKLQlyZXR1cm4gcmV0OworCXJldHVybiB3YWl0LT5mbGFncyAmIFdRX0ZMQUdfV09LRU4gPyAw
IDogLUVJTlRSOwogfQogCiB2b2lkIHdhaXRfb25fcGFnZV9iaXQoc3RydWN0IHBhZ2UgKnBhZ2Us
IGludCBiaXRfbnIpCi0tIAoyLjI4LjAucmMwLjMuZzFlMjVkM2E2MmYKCg==
--00000000000081c57b05ab384cb2
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-list-add-list_del_init_careful-to-go-with-list_empty.patch"
Content-Disposition: attachment; 
	filename="0002-list-add-list_del_init_careful-to-go-with-list_empty.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kd0us4ic1>
X-Attachment-Id: f_kd0us4ic1

RnJvbSA5M2YwMjYzYjliOTUyYTFjNDQ5Y2VjNTZhNmFhZGY2MzIwZTgyMWY5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFRodSwgMjMgSnVsIDIwMjAgMTI6MzM6NDEgLTA3MDAKU3ViamVjdDog
W1BBVENIIDIvMl0gbGlzdDogYWRkICJsaXN0X2RlbF9pbml0X2NhcmVmdWwoKSIgdG8gZ28gd2l0
aAogImxpc3RfZW1wdHlfY2FyZWZ1bCgpIgoKVGhhdCBnaXZlcyB1cyBvcmRlcmluZyBndWFyYW50
ZWVzIGFyb3VuZCB0aGUgcGFpci4KClNpZ25lZC1vZmYtYnk6IExpbnVzIFRvcnZhbGRzIDx0b3J2
YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4KLS0tCiBpbmNsdWRlL2xpbnV4L2xpc3QuaCB8IDIw
ICsrKysrKysrKysrKysrKysrKystCiBrZXJuZWwvc2NoZWQvd2FpdC5jICB8ICAyICstCiBtbS9m
aWxlbWFwLmMgICAgICAgICB8ICA3ICstLS0tLS0KIDMgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0
aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2xpc3Qu
aCBiL2luY2x1ZGUvbGludXgvbGlzdC5oCmluZGV4IGFmZjQ0ZDM0ZjRlNC4uMGQwZDE3YTEwZDI1
IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2xpc3QuaAorKysgYi9pbmNsdWRlL2xpbnV4L2xp
c3QuaApAQCAtMjgyLDYgKzI4MiwyNCBAQCBzdGF0aWMgaW5saW5lIGludCBsaXN0X2VtcHR5KGNv
bnN0IHN0cnVjdCBsaXN0X2hlYWQgKmhlYWQpCiAJcmV0dXJuIFJFQURfT05DRShoZWFkLT5uZXh0
KSA9PSBoZWFkOwogfQogCisvKioKKyAqIGxpc3RfZGVsX2luaXRfY2FyZWZ1bCAtIGRlbGV0ZXMg
ZW50cnkgZnJvbSBsaXN0IGFuZCByZWluaXRpYWxpemUgaXQuCisgKiBAZW50cnk6IHRoZSBlbGVt
ZW50IHRvIGRlbGV0ZSBmcm9tIHRoZSBsaXN0LgorICoKKyAqIFRoaXMgaXMgdGhlIHNhbWUgYXMg
bGlzdF9kZWxfaW5pdCgpLCBleGNlcHQgZGVzaWduZWQgdG8gYmUgdXNlZAorICogdG9nZXRoZXIg
d2l0aCBsaXN0X2VtcHR5X2NhcmVmdWwoKSBpbiBhIHdheSB0byBndWFyYW50ZWUgb3JkZXJpbmcK
KyAqIG9mIG90aGVyIG1lbW9yeSBvcGVyYXRpb25zLgorICoKKyAqIEFueSBtZW1vcnkgb3BlcmF0
aW9ucyBkb25lIGJlZm9yZSBhIGxpc3RfZGVsX2luaXRfY2FyZWZ1bCgpIGFyZQorICogZ3VhcmFu
dGVlZCB0byBiZSB2aXNpYmxlIGFmdGVyIGEgbGlzdF9lbXB0eV9jYXJlZnVsKCkgdGVzdC4KKyAq
Lworc3RhdGljIGlubGluZSB2b2lkIGxpc3RfZGVsX2luaXRfY2FyZWZ1bChzdHJ1Y3QgbGlzdF9o
ZWFkICplbnRyeSkKK3sKKwlfX2xpc3RfZGVsX2VudHJ5KGVudHJ5KTsKKwllbnRyeS0+cHJldiA9
IGVudHJ5OworCXNtcF9zdG9yZV9yZWxlYXNlKCZlbnRyeS0+bmV4dCwgZW50cnkpOworfQorCiAv
KioKICAqIGxpc3RfZW1wdHlfY2FyZWZ1bCAtIHRlc3RzIHdoZXRoZXIgYSBsaXN0IGlzIGVtcHR5
IGFuZCBub3QgYmVpbmcgbW9kaWZpZWQKICAqIEBoZWFkOiB0aGUgbGlzdCB0byB0ZXN0CkBAIC0y
OTcsNyArMzE1LDcgQEAgc3RhdGljIGlubGluZSBpbnQgbGlzdF9lbXB0eShjb25zdCBzdHJ1Y3Qg
bGlzdF9oZWFkICpoZWFkKQogICovCiBzdGF0aWMgaW5saW5lIGludCBsaXN0X2VtcHR5X2NhcmVm
dWwoY29uc3Qgc3RydWN0IGxpc3RfaGVhZCAqaGVhZCkKIHsKLQlzdHJ1Y3QgbGlzdF9oZWFkICpu
ZXh0ID0gaGVhZC0+bmV4dDsKKwlzdHJ1Y3QgbGlzdF9oZWFkICpuZXh0ID0gc21wX2xvYWRfYWNx
dWlyZSgmaGVhZC0+bmV4dCk7CiAJcmV0dXJuIChuZXh0ID09IGhlYWQpICYmIChuZXh0ID09IGhl
YWQtPnByZXYpOwogfQogCmRpZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQvd2FpdC5jIGIva2VybmVs
L3NjaGVkL3dhaXQuYwppbmRleCBiYTA1OWZiZmM1M2EuLjAxZjVkMzAyMDU4OSAxMDA2NDQKLS0t
IGEva2VybmVsL3NjaGVkL3dhaXQuYworKysgYi9rZXJuZWwvc2NoZWQvd2FpdC5jCkBAIC0zODks
NyArMzg5LDcgQEAgaW50IGF1dG9yZW1vdmVfd2FrZV9mdW5jdGlvbihzdHJ1Y3Qgd2FpdF9xdWV1
ZV9lbnRyeSAqd3FfZW50cnksIHVuc2lnbmVkIG1vZGUsIGkKIAlpbnQgcmV0ID0gZGVmYXVsdF93
YWtlX2Z1bmN0aW9uKHdxX2VudHJ5LCBtb2RlLCBzeW5jLCBrZXkpOwogCiAJaWYgKHJldCkKLQkJ
bGlzdF9kZWxfaW5pdCgmd3FfZW50cnktPmVudHJ5KTsKKwkJbGlzdF9kZWxfaW5pdF9jYXJlZnVs
KCZ3cV9lbnRyeS0+ZW50cnkpOwogCiAJcmV0dXJuIHJldDsKIH0KZGlmZiAtLWdpdCBhL21tL2Zp
bGVtYXAuYyBiL21tL2ZpbGVtYXAuYwppbmRleCA4YzNkM2UyMzNkMzcuLjk5MTUwM2JiZjkyMiAx
MDA2NDQKLS0tIGEvbW0vZmlsZW1hcC5jCisrKyBiL21tL2ZpbGVtYXAuYwpAQCAtMTA0MSwxMyAr
MTA0MSw4IEBAIHN0YXRpYyBpbnQgd2FrZV9wYWdlX2Z1bmN0aW9uKHdhaXRfcXVldWVfZW50cnlf
dCAqd2FpdCwgdW5zaWduZWQgbW9kZSwgaW50IHN5bmMsCiAJICogc2luY2UgYWZ0ZXIgbGlzdF9k
ZWxfaW5pdCgmd2FpdC0+ZW50cnkpIHRoZSB3YWl0IGVudHJ5CiAJICogbWlnaHQgYmUgZGUtYWxs
b2NhdGVkIGFuZCB0aGUgcHJvY2VzcyBtaWdodCBldmVuIGhhdmUKIAkgKiBleGl0ZWQuCi0JICoK
LQkgKiBXZSBfcmVhbGx5XyBzaG91bGQgaGF2ZSBhICJsaXN0X2RlbF9pbml0X2NhcmVmdWwoKSIg
dG8KLQkgKiBwcm9wZXJseSBwYWlyIHdpdGggdGhlIHVubG9ja2VkICJsaXN0X2VtcHR5X2NhcmVm
dWwoKSIKLQkgKiBpbiBmaW5pc2hfd2FpdCgpLgogCSAqLwotCXNtcF9tYigpOwotCWxpc3RfZGVs
X2luaXQoJndhaXQtPmVudHJ5KTsKKwlsaXN0X2RlbF9pbml0X2NhcmVmdWwoJndhaXQtPmVudHJ5
KTsKIAlyZXR1cm4gcmV0OwogfQogCi0tIAoyLjI4LjAucmMwLjMuZzFlMjVkM2E2MmYKCg==
--00000000000081c57b05ab384cb2--
