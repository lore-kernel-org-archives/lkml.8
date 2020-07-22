Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCD3C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30F7620825
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595461377;
	bh=CXQjL7rWmykcJbOfigiQGfTm256WxCMUY09Y41/6AH4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jHslO+XUetyjKsOOXDFU0wMwKekCltst+37dcF5AG1fmCMxq5QIFLURsNy6Q67/bp
	 Igwf5KKeFBBq1YE+8VVXNJnsOoYbjOiKjoYjmbeV3YaSB0S35gn6lj6YJY5O6tW1mh
	 8C+mItosFbhIxNbwtgSUQNdcebhpUZCAwCPoygMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733065AbgGVXmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 19:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733039AbgGVXmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 19:42:55 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97584C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 16:42:54 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id f5so4383699ljj.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 16:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1gorWaBOTDzwkFhAp9D2nVno0BUb+tV20gLZenZj/T4=;
        b=ho/W69t/YxXGLh0XaFKt/roxTs3MiEFtwEnMaPMV8+fOWVsCezqOQN1WNe8TaVdLNe
         DMuj+BUEFrl5Yky3CviDr7U0AFNjkntZeH7SF0wLptyDbnU+rq9TG97CE9sIA6L0iwNt
         8b/mvsbHherQp25Ze+df1/AL9wJqjzU1gEkIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1gorWaBOTDzwkFhAp9D2nVno0BUb+tV20gLZenZj/T4=;
        b=At5Pj1ipsyVVaBokPEMpeE/4lt0KP41DZX0kOgvW8QydMbyF8pFx8PmMwzwlM7TdKW
         VIvh018mVUbI/Q9n3y6zQ51ReIvzEGoeli1QA2HqH9j+yR5jdNocdepGHn3eZ9DKqNru
         axA46jnlHD9FsTGqQaDX1+JyBTZlHhNvaoRL/RxhDaJbQVOU1JJz1I/boPOADNRKkGYA
         b3NUptfXaFYyp/UI/9A0uYtcyJ4sEn4/nJ7ZfMMLpmmuPcm9pwJvu+jXh3BMUMrurM/E
         7LedLkvLc+K6LhahAeOdHAOmetttybfJZRBlcH8fMJQYX49eStrkHclPEhGFNwj2tR5k
         Pvfg==
X-Gm-Message-State: AOAM532J4/DGK8JJ8NWIYk5nucwEruYVxOwS/haWCvMe4lvSnJCWLqJ2
        1Ge6Hzr8wvC6bg10HjQKYDJc8jUvJVw=
X-Google-Smtp-Source: ABdhPJx3Yv6VUaHK2UZfTovY9EbnFdve3xnBK+W8EexcjxMMW917Yc6D9CMpQHGxm6eHAwwNtjXDyA==
X-Received: by 2002:a05:651c:1034:: with SMTP id w20mr677764ljm.382.1595461372717;
        Wed, 22 Jul 2020 16:42:52 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id d21sm1152102ljo.85.2020.07.22.16.42.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 16:42:51 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id h22so4388940lji.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 16:42:50 -0700 (PDT)
X-Received: by 2002:a2e:991:: with SMTP id 139mr664554ljj.314.1595461370291;
 Wed, 22 Jul 2020 16:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200721063258.17140-1-mhocko@kernel.org> <CAHk-=whewL14RgwLZTXcNAnrDPt0H+sRJS6iDq0oGb6zwaBMxg@mail.gmail.com>
 <CAHk-=whb0=rjc1WR+F_r_syw5Ld4=ebuNJmmpaPEzfjZRD5Y-w@mail.gmail.com>
 <alpine.LSU.2.11.2007221359450.1017@eggly.anvils> <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com>
In-Reply-To: <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Jul 2020 16:42:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com>
Message-ID: <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
To:     Hugh Dickins <hughd@google.com>, Oleg Nesterov <oleg@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: multipart/mixed; boundary="0000000000003af25505ab104cfa"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000003af25505ab104cfa
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 22, 2020 at 3:10 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> > +       bool first_time = true;
> >         bool thrashing = false;
> >         bool delayacct = false;
> >         unsigned long pflags;
> > @@ -1134,7 +1135,12 @@ static inline int wait_on_page_bit_commo
> >                 spin_lock_irq(&q->lock);
> >
> >                 if (likely(list_empty(&wait->entry))) {
> > -                       __add_wait_queue_entry_tail(q, wait);
> > +                       if (first_time) {
> > +                               __add_wait_queue_entry_tail(q, wait);
> > +                               first_time = false;
> > +                       } else {
> > +                               __add_wait_queue(q, wait);
> > +                       }
> >                         SetPageWaiters(page);
> >                 }
>
> This seems very hacky.
>
> And in fact, looking closer, I'd say that there are more serious problems here.
>
> Look at that WQ_FLAG_EXCLUSIVE thing: non-exclusive waits should
> always go at the head (because they're not going to steal the bit,
> they just want to know when it got cleared), and exclusive waits
> should always go at the tail (because of fairness).
>
> But that's not at all what we do.
>
> Your patch adds even more confusion to this nasty area.

Actually, I think the right thing to do is to just say "we should
never add ourselves back to the list".

We have three cases:

 - DROP: we'll never loop

 - SHARED: we'll break if we see the bit clear - so if we're no longer
on the list, we should break out

 - EXCLUSIVE: we should remain on the list until we get the lock.

and we should just handle these three cases in the wakeup function
instead, I feel.

And then to make it fair to people, let's just always add things to
the head of the queue, whether exclusive or not.

AND NEVER RE-QUEUE.

IOW, something like the attached patch.

NOTE NOTE NOTE! This is both somewhat subtle code, and ENTIRELY
UNTESTED. But it actually fixes the bug mentioned a few weeks ago, it
makes the code simpler in one sense, and it avoids the whole
re-queueuing thing.

It removes all the "is the page locked" testing from the actual wait
loop, and replaces it with "is the wait queue entry still on the list"
instead.

Comments? Oleg, this should fix the race you talked about too.

Note that this patch really is meant as a RFC, and "something like
this". It builds. I tried to think it through. But it might have some
obvious thinko that means that it really really doesn't work.

                    Linus

--0000000000003af25505ab104cfa
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kcy0hit60>
X-Attachment-Id: f_kcy0hit60

IG1tL2ZpbGVtYXAuYyB8IDE1NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDExMSBpbnNlcnRpb25zKCsp
LCA0NiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9tbS9maWxlbWFwLmMgYi9tbS9maWxlbWFw
LmMKaW5kZXggMzg1NzU5YzRjZTRiLi5lNDQ4NzNkYTVkMTkgMTAwNjQ0Ci0tLSBhL21tL2ZpbGVt
YXAuYworKysgYi9tbS9maWxlbWFwLmMKQEAgLTEwMDAsOCArMTAwMCwxNiBAQCBzdHJ1Y3Qgd2Fp
dF9wYWdlX3F1ZXVlIHsKIAl3YWl0X3F1ZXVlX2VudHJ5X3Qgd2FpdDsKIH07CiAKKy8qCisgKiBX
YWtlIGZ1bmN0aW9uIHJldHVybiB2YWx1ZToKKyAqICAtMTogInN0b3AiCisgKiAgIDA6ICJnbyBv
biIuCisgKiAgIDE6IHdlIGhhbmRsZWQgYW4gZXhjbHVzaXZlIGNhc2UKKyAqLwogc3RhdGljIGlu
dCB3YWtlX3BhZ2VfZnVuY3Rpb24od2FpdF9xdWV1ZV9lbnRyeV90ICp3YWl0LCB1bnNpZ25lZCBt
b2RlLCBpbnQgc3luYywgdm9pZCAqYXJnKQogeworCWludCByZXQ7CisJc3RydWN0IHRhc2tfc3Ry
dWN0ICp0YXJnZXQ7CiAJc3RydWN0IHdhaXRfcGFnZV9rZXkgKmtleSA9IGFyZzsKIAlzdHJ1Y3Qg
d2FpdF9wYWdlX3F1ZXVlICp3YWl0X3BhZ2UKIAkJPSBjb250YWluZXJfb2Yod2FpdCwgc3RydWN0
IHdhaXRfcGFnZV9xdWV1ZSwgd2FpdCk7CkBAIC0xMDEzLDE4ICsxMDIxLDQ2IEBAIHN0YXRpYyBp
bnQgd2FrZV9wYWdlX2Z1bmN0aW9uKHdhaXRfcXVldWVfZW50cnlfdCAqd2FpdCwgdW5zaWduZWQg
bW9kZSwgaW50IHN5bmMsCiAJaWYgKHdhaXRfcGFnZS0+Yml0X25yICE9IGtleS0+Yml0X25yKQog
CQlyZXR1cm4gMDsKIAorCS8qIFN0b3Agd2Fsa2luZyBpZiBpdCdzIGxvY2tlZCAqLworCWlmICh3
YWl0LT5mbGFncyAmIFdRX0ZMQUdfRVhDTFVTSVZFKSB7CisJCWlmICh0ZXN0X2FuZF9zZXRfYml0
KGtleS0+Yml0X25yLCAma2V5LT5wYWdlLT5mbGFncykpCisJCQlyZXR1cm4gLTE7CisJCXJldCA9
IDE7CisJfSBlbHNlIHsKKwkJaWYgKHRlc3RfYml0KGtleS0+Yml0X25yLCAma2V5LT5wYWdlLT5m
bGFncykpCisJCQlyZXR1cm4gLTE7CisJCXJldCA9IDA7CisJfQorCisKIAkvKgotCSAqIFN0b3Ag
d2Fsa2luZyBpZiBpdCdzIGxvY2tlZC4KLQkgKiBJcyB0aGlzIHNhZmUgaWYgcHV0X2FuZF93YWl0
X29uX3BhZ2VfbG9ja2VkKCkgaXMgaW4gdXNlPwotCSAqIFllczogdGhlIHdha2VyIG11c3QgaG9s
ZCBhIHJlZmVyZW5jZSB0byB0aGlzIHBhZ2UsIGFuZCBpZiBQR19sb2NrZWQKLQkgKiBoYXMgbm93
IGFscmVhZHkgYmVlbiBzZXQgYnkgYW5vdGhlciB0YXNrLCB0aGF0IHRhc2sgbXVzdCBhbHNvIGhv
bGQKLQkgKiBhIHJlZmVyZW5jZSB0byB0aGUgKnNhbWUgdXNhZ2UqIG9mIHRoaXMgcGFnZTsgc28g
dGhlcmUgaXMgbm8gbmVlZAotCSAqIHRvIHdhbGsgb24gdG8gd2FrZSBldmVuIHRoZSBwdXRfYW5k
X3dhaXRfb25fcGFnZV9sb2NrZWQoKSBjYWxsZXJzLgorCSAqIFdlIGNhbiBubyBsb25nZXIgdXNl
ICd3YWl0JyBhZnRlciB3ZSd2ZSBkb25lIHRoZQorCSAqIGxpc3RfZGVsX2luaXQoJndhaXQtPmVu
dHJ5KSwgYmVjYXVzZSBhdCB0aGF0IHBvaW50CisJICogdGhlIHRhcmdldCBtYXkgZGVjaWRlIGl0
J3MgYWxsIGRvbmUgd2l0aCBubworCSAqIG90aGVyIGxvY2tpbmcsIGFuZCAnd2FpdCcgaGFzIGJl
ZW4gYWxsb2NhdGVkIG9uCisJICogdGhlIHN0YWNrIG9mIHRoZSB0YXJnZXQuCiAJICovCi0JaWYg
KHRlc3RfYml0KGtleS0+Yml0X25yLCAma2V5LT5wYWdlLT5mbGFncykpCi0JCXJldHVybiAtMTsK
Kwl0YXJnZXQgPSB3YWl0LT5wcml2YXRlOworCXNtcF9tYigpOwogCi0JcmV0dXJuIGF1dG9yZW1v
dmVfd2FrZV9mdW5jdGlvbih3YWl0LCBtb2RlLCBzeW5jLCBrZXkpOworCS8qCisJICogT2ssIHdl
IGhhdmUgc3VjY2Vzc2Z1bGx5IGRvbmUgd2hhdCB3ZSdyZSB3YWl0aW5nIGZvci4KKwkgKgorCSAq
IE5vdyB1bmNvbmRpdGlvbmFsbHkgcmVtb3ZlIHRoZSB3YWl0IGVudHJ5LCBzbyB0aGF0IHRoZQor
CSAqIHdhaXRlciBjYW4gdXNlIHRoYXQgdG8gc2VlIHN1Y2Nlc3Mgb3Igbm90LgorCSAqCisJICog
V2UgX3JlYWxseV8gc2hvdWxkIGhhdmUgYSAibGlzdF9kZWxfaW5pdF9jYXJlZnVsKCkiCisJICog
dG8gcHJvcGVybHkgcGFpciB3aXRoIGFuIHVubG9ja2VkICJsaXN0X2VtcHR5X2NhcmVmdWwoKSIu
CisJICovCisJbGlzdF9kZWxfaW5pdCgmd2FpdC0+ZW50cnkpOworCisJLyoKKwkgKiBUaGVyZXMn
cyBhbm90aGVyIG1lbW9yeSBiYXJyaWVyIGluIHRoZSB3YWt1cCBwYXRoLCB0aGF0CisJICogbWFr
ZXMgc3VyZSB0aGUgd2FrdXAgaGFwcGVucyBhZnRlciB0aGUgYWJvdmUgaXMgdmlzaWJsZQorCSAq
IHRvIHRoZSB0YXJnZXQuCisJICovCisJd2FrZV91cF9zdGF0ZSh0YXJnZXQsIG1vZGUpOworCXJl
dHVybiByZXQ7CiB9CiAKIHN0YXRpYyB2b2lkIHdha2VfdXBfcGFnZV9iaXQoc3RydWN0IHBhZ2Ug
KnBhZ2UsIGludCBiaXRfbnIpCkBAIC0xMDU0LDYgKzEwOTAsMTUgQEAgc3RhdGljIHZvaWQgd2Fr
ZV91cF9wYWdlX2JpdChzdHJ1Y3QgcGFnZSAqcGFnZSwgaW50IGJpdF9ucikKIAkJICogZnJvbSB3
YWl0IHF1ZXVlCiAJCSAqLwogCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZxLT5sb2NrLCBmbGFn
cyk7CisKKwkJLyoKKwkJICogSWYgc29tZWJvZHkgZWxzZSBzZXQgdGhlIGJpdCBhZ2Fpbiwgc3Rv
cCB3YWtpbmcKKwkJICogcGVvcGxlIHVwLiBJdCdzIG5vdyB0aGUgcmVzcG9uc2liaWxpdHkgb2Yg
dGhhdAorCQkgKiBvdGhlciBwYWdlIGJpdCBvd25lciB0byBkbyBzby4KKwkJICovCisJCWlmICh0
ZXN0X2JpdChiaXRfbnIsICZwYWdlLT5mbGFncykpCisJCQlyZXR1cm47CisKIAkJY3B1X3JlbGF4
KCk7CiAJCXNwaW5fbG9ja19pcnFzYXZlKCZxLT5sb2NrLCBmbGFncyk7CiAJCV9fd2FrZV91cF9s
b2NrZWRfa2V5X2Jvb2ttYXJrKHEsIFRBU0tfTk9STUFMLCAma2V5LCAmYm9va21hcmspOwpAQCAt
MTEwMywxNiArMTE0OCwyMyBAQCBlbnVtIGJlaGF2aW9yIHsKIAkJCSAqLwogfTsKIAorc3RhdGlj
IGlubGluZSBpbnQgdHJ5bG9ja19wYWdlX2JpdF9jb21tb24oc3RydWN0IHBhZ2UgKnBhZ2UsIGlu
dCBiaXRfbnIsCisJZW51bSBiZWhhdmlvciBiZWhhdmlvcikKK3sKKwlyZXR1cm4gYmVoYXZpb3Ig
PT0gRVhDTFVTSVZFID8KKwkJIXRlc3RfYW5kX3NldF9iaXQoYml0X25yLCAmcGFnZS0+ZmxhZ3Mp
IDoKKwkJIXRlc3RfYml0KGJpdF9uciwgJnBhZ2UtPmZsYWdzKTsKK30KKwogc3RhdGljIGlubGlu
ZSBpbnQgd2FpdF9vbl9wYWdlX2JpdF9jb21tb24od2FpdF9xdWV1ZV9oZWFkX3QgKnEsCiAJc3Ry
dWN0IHBhZ2UgKnBhZ2UsIGludCBiaXRfbnIsIGludCBzdGF0ZSwgZW51bSBiZWhhdmlvciBiZWhh
dmlvcikKIHsKIAlzdHJ1Y3Qgd2FpdF9wYWdlX3F1ZXVlIHdhaXRfcGFnZTsKIAl3YWl0X3F1ZXVl
X2VudHJ5X3QgKndhaXQgPSAmd2FpdF9wYWdlLndhaXQ7Ci0JYm9vbCBiaXRfaXNfc2V0OwogCWJv
b2wgdGhyYXNoaW5nID0gZmFsc2U7CiAJYm9vbCBkZWxheWFjY3QgPSBmYWxzZTsKIAl1bnNpZ25l
ZCBsb25nIHBmbGFnczsKLQlpbnQgcmV0ID0gMDsKKwlpbnQgcmV0OwogCiAJaWYgKGJpdF9uciA9
PSBQR19sb2NrZWQgJiYKIAkgICAgIVBhZ2VVcHRvZGF0ZShwYWdlKSAmJiBQYWdlV29ya2luZ3Nl
dChwYWdlKSkgewpAQCAtMTEzMCw1MiArMTE4Miw2NSBAQCBzdGF0aWMgaW5saW5lIGludCB3YWl0
X29uX3BhZ2VfYml0X2NvbW1vbih3YWl0X3F1ZXVlX2hlYWRfdCAqcSwKIAl3YWl0X3BhZ2UucGFn
ZSA9IHBhZ2U7CiAJd2FpdF9wYWdlLmJpdF9uciA9IGJpdF9ucjsKIAotCWZvciAoOzspIHsKLQkJ
c3Bpbl9sb2NrX2lycSgmcS0+bG9jayk7CisJLyoKKwkgKiBBZGQgb3Vyc2VsdmVzIHRvIHRoZSB3
YWl0IHF1ZXVlLgorCSAqCisJICogTk9URSEgVGhpcyBpcyB3aGVyZSB3ZSBhbHNvIGNoZWNrIHRo
ZSBwYWdlCisJICogc3RhdGUgc3luY2hyb25vdXNseSB0aGUgbGFzdCB0aW1lIHRvIHNlZSB0aGF0
CisJICogc29tZWJvZHkgZGlkbid0IGp1c3QgY2xlYXIgdGhlIGJpdC4KKwkgKi8KKwlzcGluX2xv
Y2tfaXJxKCZxLT5sb2NrKTsKKwlTZXRQYWdlV2FpdGVycyhwYWdlKTsKKwlpZiAoIXRyeWxvY2tf
cGFnZV9iaXRfY29tbW9uKHBhZ2UsIGJpdF9uciwgYmVoYXZpb3IpKQorCQlfX2FkZF93YWl0X3F1
ZXVlX2VudHJ5X3RhaWwocSwgd2FpdCk7CisJc3Bpbl91bmxvY2tfaXJxKCZxLT5sb2NrKTsKIAot
CQlpZiAobGlrZWx5KGxpc3RfZW1wdHkoJndhaXQtPmVudHJ5KSkpIHsKLQkJCV9fYWRkX3dhaXRf
cXVldWVfZW50cnlfdGFpbChxLCB3YWl0KTsKLQkJCVNldFBhZ2VXYWl0ZXJzKHBhZ2UpOwotCQl9
CisJLyoKKwkgKiBGcm9tIG5vdyBvbiwgYWxsIHRoZSBsb2dpYyB3aWxsIGJlIGJhc2VkIG9uCisJ
ICogd2hldGhlciB0aGUgd2FpdCBlbnRyeSBpcyBvbiB0aGUgcXVldWUgb3Igbm90LAorCSAqIGFu
ZCB0aGUgcGFnZSBiaXQgdGVzdGluZyAoYW5kIHNldHRpbmcpIHdpbGwgYmUKKwkgKiBkb25lIGJ5
IHRoZSB3YWtlIGZ1bmN0aW9uLCBub3QgdXMuCisJICoKKwkgKiBXZSBjYW4gZHJvcCBvdXIgcmVm
ZXJlbmNlIHRvIHRoZSBwYWdlLgorCSAqLworCWlmIChiZWhhdmlvciA9PSBEUk9QKQorCQlwdXRf
cGFnZShwYWdlKTsKIAorCWZvciAoOzspIHsKIAkJc2V0X2N1cnJlbnRfc3RhdGUoc3RhdGUpOwog
Ci0JCXNwaW5fdW5sb2NrX2lycSgmcS0+bG9jayk7Ci0KLQkJYml0X2lzX3NldCA9IHRlc3RfYml0
KGJpdF9uciwgJnBhZ2UtPmZsYWdzKTsKLQkJaWYgKGJlaGF2aW9yID09IERST1ApCi0JCQlwdXRf
cGFnZShwYWdlKTsKKwkJaWYgKHNpZ25hbF9wZW5kaW5nX3N0YXRlKHN0YXRlLCBjdXJyZW50KSkK
KwkJCWJyZWFrOwogCi0JCWlmIChsaWtlbHkoYml0X2lzX3NldCkpCi0JCQlpb19zY2hlZHVsZSgp
OworCQlpZiAobGlzdF9lbXB0eV9jYXJlZnVsKCZ3YWl0LT5lbnRyeSkpCisJCQlicmVhazsKIAot
CQlpZiAoYmVoYXZpb3IgPT0gRVhDTFVTSVZFKSB7Ci0JCQlpZiAoIXRlc3RfYW5kX3NldF9iaXRf
bG9jayhiaXRfbnIsICZwYWdlLT5mbGFncykpCi0JCQkJYnJlYWs7Ci0JCX0gZWxzZSBpZiAoYmVo
YXZpb3IgPT0gU0hBUkVEKSB7Ci0JCQlpZiAoIXRlc3RfYml0KGJpdF9uciwgJnBhZ2UtPmZsYWdz
KSkKLQkJCQlicmVhazsKLQkJfQorCQlpb19zY2hlZHVsZSgpOworCX0KIAotCQlpZiAoc2lnbmFs
X3BlbmRpbmdfc3RhdGUoc3RhdGUsIGN1cnJlbnQpKSB7CisJLyoKKwkgKiBXZSdyZSBvcGVuLWNv
ZGluZyBmaW5pc2hfd2FpdCgpLCB0aGUgc2FtZSB3YXkKKwkgKiB3ZSBvcGVuLWNvZGVkIGFkZF93
YWl0KCkgYWJvdmUuIEJlY2F1c2Ugd2UgY2FyZQorCSAqIGRlZXBseSBhYm91dCB3aGV0aGVyIHdl
IG5lZWRlZCB0byByZW1vdmUgb3VyCisJICogd2FpdCBlbnRyeSBvciBub3QgKHRoYXQgbWVhbnMg
d2UgZmFpbGVkKS4KKwkgKgorCSAqIE5vdGUgdGhhdCB3ZSB0cnkgdG8gYXZvaWQgdGFraW5nIHRo
ZSBzcGlubG9jaworCSAqIGZvciB0aGUgd2FpdCBxdWV1ZSBpZiBhdCBhbGwgcG9zc2libGUuIElm
IHdlCisJICogc2xlcHQgYW5kIHdlcmUgd29rZW4gdXAsIHRoYXQgd2lsbCBoYXZlIHJlbW92ZWQK
KwkgKiBvdXIgZW50cnkgZnJvbSB0aGUgcXVldWUsIGFuZCB3ZSBkb24ndCBuZWVkIHRvCisJICog
ZG8gYW55dGhpZ24gZWxzZS4KKwkgKi8KKwlfX3NldF9jdXJyZW50X3N0YXRlKFRBU0tfUlVOTklO
Ryk7CisJcmV0ID0gMDsKKwlpZiAoIWxpc3RfZW1wdHlfY2FyZWZ1bCgmd2FpdC0+ZW50cnkpKSB7
CisJCXNwaW5fbG9ja19pcnEoJnEtPmxvY2spOworCQlpZiAoIWxpc3RfZW1wdHkoJndhaXQtPmVu
dHJ5KSkgeworCQkJbGlzdF9kZWwoJndhaXQtPmVudHJ5KTsKIAkJCXJldCA9IC1FSU5UUjsKLQkJ
CWJyZWFrOwotCQl9Ci0KLQkJaWYgKGJlaGF2aW9yID09IERST1ApIHsKLQkJCS8qCi0JCQkgKiBX
ZSBjYW4gbm8gbG9uZ2VyIHNhZmVseSBhY2Nlc3MgcGFnZS0+ZmxhZ3M6Ci0JCQkgKiBldmVuIGlm
IENPTkZJR19NRU1PUllfSE9UUkVNT1ZFIGlzIG5vdCBlbmFibGVkLAotCQkJICogdGhlcmUgaXMg
YSByaXNrIG9mIHdhaXRpbmcgZm9yZXZlciBvbiBhIHBhZ2UgcmV1c2VkCi0JCQkgKiBmb3Igc29t
ZXRoaW5nIHRoYXQga2VlcHMgaXQgbG9ja2VkIGluZGVmaW5pdGVseS4KLQkJCSAqIEJ1dCBiZXN0
IGNoZWNrIGZvciAtRUlOVFIgYWJvdmUgYmVmb3JlIGJyZWFraW5nLgotCQkJICovCi0JCQlicmVh
azsKIAkJfQorCQlzcGluX3VubG9ja19pcnEoJnEtPmxvY2spOwogCX0KIAotCWZpbmlzaF93YWl0
KHEsIHdhaXQpOwotCiAJaWYgKHRocmFzaGluZykgewogCQlpZiAoZGVsYXlhY2N0KQogCQkJZGVs
YXlhY2N0X3RocmFzaGluZ19lbmQoKTsK
--0000000000003af25505ab104cfa--
