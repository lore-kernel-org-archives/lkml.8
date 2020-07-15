Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0434FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 18:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEAD920656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 18:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594838242;
	bh=e9h7RZ00AoFOub6D8Q03xsiossw3B3gKpQ4bJXutBX0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DBgO4SYtQ0bHgY6JrTS4jB3R8+HAmD6/WIb2YALokwOXO+N4/bbEGHRgnwUKbCK9t
	 UpJqLsWfvkg+SgpbKdpWYGZseEqlHMMiY6/iWNctmM+e+G7L2eqpDTpwX6YveiKntm
	 EeIiPf2eK7M7LnP7jffTnbnKH+LuW97VaqK7AVA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgGOShV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 14:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgGOShU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 14:37:20 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7944BC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 11:37:20 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e8so3804751ljb.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 11:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9qQHm2b+3rwbBTzFM/lqzsH6S1Rv7/QR/QYGW+OhMFc=;
        b=Y+TX0qRGwQIRFrxBRRdvNjZH7UgARoC+KCS4tqoaotvEqXLNKmqCit9K/l4Ucq7pp+
         rtr3PG3sTjcq17LFAFMOd5vvu7wFr8lWTBiOi3e6ZLG+md72Rn6kNWfTyDy7ujKoNK67
         8XoVzr+fjQuVqWBY8h75boTmQ608nLGbj9cZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9qQHm2b+3rwbBTzFM/lqzsH6S1Rv7/QR/QYGW+OhMFc=;
        b=A0/p5XzfN1HP/T1aF47OFS4MChHYSNDKuwVFrHNBF89/2buGFLltNyZWZEpoeU7EtW
         Y4vtvPArhtPK4547k92PkSFb3+hw7IPzntG7Lk22lcyjoCm2278BjQ1aZIu0xrY8IDwm
         pBYIt9P2c7lAi0vhaaSCY/1HNOudSJz69Sindfmz7qhyWIGLIfJo6zg6B/Dt3mhwCvcq
         yiFC60V8dzhPoQ9trN3zoqHChbxwqvtmwTSpyQ02nGC7i92aSYccTCmU58qV720LxDpQ
         XSS0fwZlzP9eZ2JCu0qCl0ST8y54g1nNzmxgtNo7EdEM/q79iWYb+Q70SN618xlwqihE
         Jf0A==
X-Gm-Message-State: AOAM530BiHQetvvGo4h6J5Kv0z9xKUBMundEUyTfnIJwEI7pC8OGyhx+
        dy3RrO9wZEo+xCYIrRHFs/nxAsLl6ew=
X-Google-Smtp-Source: ABdhPJwoDI4r9pgpmz9i2Ql4e5mCWYfUAXpJHbkj4FtNenIfZ8nxNTUtQ7qWZbmmYeQNladSEsuq6g==
X-Received: by 2002:a2e:760f:: with SMTP id r15mr197703ljc.275.1594838238450;
        Wed, 15 Jul 2020 11:37:18 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id y26sm594102ljk.26.2020.07.15.11.37.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 11:37:17 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id y13so1615163lfe.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 11:37:16 -0700 (PDT)
X-Received: by 2002:a05:6512:3f1:: with SMTP id n17mr178224lfq.125.1594838236066;
 Wed, 15 Jul 2020 11:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200715135011.42743-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20200715135011.42743-1-kirill.shutemov@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Jul 2020 11:36:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4pB-jRngOjcGxpc8=NPds3jWqJwDMUWC3-OEo4dRiKg@mail.gmail.com>
Message-ID: <CAHk-=wh4pB-jRngOjcGxpc8=NPds3jWqJwDMUWC3-OEo4dRiKg@mail.gmail.com>
Subject: Re: [PATCHv2] mm: Fix warning in move_normal_pmd()
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        William Kucharski <william.kucharski@oracle.com>
Content-Type: multipart/mixed; boundary="00000000000089243c05aa7f3607"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000089243c05aa7f3607
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 15, 2020 at 6:50 AM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> mremap(2) does not allow source and destination regions to overlap, but
> shift_arg_pages() calls move_page_tables() directly and in this case the
> source and destination overlap often. It

Actually, before we do this patch (which I think is a good idea), I'd
like Naresh to test the attached patch.

And Kirill, Joel, mind looking it over too.

IT IS ENTIRELY UNTESTED.

But I hope the concept (and the code) is fairly obvious: it makes
move_page_tables() try to align the range to be moved, if possible.

That *should* actually remove the warning that Naresh sees, for the
simple reason that now the PMD moving case will *always* trigger when
the stack movement is PMD-aligned, and you never see the "first do a
few small pages, then do the PMD optimization" case.

And that should mean that we don't ever hit the "oh, we already have a
target pmd" thing, because the "move the whole pmd" case will clear
the ones it has already taken care of, and you never have that "oh,
there's an empty pmd where the pages were moved away one by one".

And that means that for this case, it's _ok_ to overlap (as long as we
copy downwards).

What do you think?

Ok, so I could easily have screwed up the patch, even if it's
conceptually fairly simple. The details are small, but they needed
some care. The thing _looks_ fine to me, both on a source level and
when looking at the generated code, and I made sure to try to use a
lot of small helper functions and couple of helper macros to make each
individual piece look clear and obvious.

But obviously a single "Oh, that test is the wrong way around", or a
missing mask inversion, or whatever, could completely break the code.
So no guarantees, but it looks fairly straightforward to me.

Naresh - this patch does *NOT* make sense to test together with
Kirill's (or Joel's) patch that says "don't do the PMD optimization at
all for overlapping cases". Those patches will hide the issue, and
make the new code only work for mremap(), not for the initial stack
setup that caused the original warning.

Joel - I think this patch makes sense _regardless_ of the special
execve() usage case, in that it extends your "let's just copy things
at a whole PMD level" logic to even the case where the beginning
wasn't PMD-aligned (or the length wasn't sufficient).

Obviously it only triggers when the source and destination are
mutually aligned, and if there are no other vma's around those
first/last PMD entries. Which might mean that it almost never triggers
in practice, but looking at the generated code, it sure looks like
it's cheap enough to test.

Didn't you have some test-cases for your pmd optimized movement cases,
at least for timing?

               Linus

--00000000000089243c05aa7f3607
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kcnphvie0>
X-Attachment-Id: f_kcnphvie0

IG1tL21yZW1hcC5jIHwgNjcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDY3IGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9tbS9tcmVtYXAuYyBiL21tL21yZW1hcC5jCmluZGV4IDZiMTUzZGMwNWZl
NC4uMzEyNTQyM2M4MzlhIDEwMDY0NAotLS0gYS9tbS9tcmVtYXAuYworKysgYi9tbS9tcmVtYXAu
YwpAQCAtMjU0LDYgKzI1NCw3MSBAQCBzdGF0aWMgYm9vbCBtb3ZlX25vcm1hbF9wbWQoc3RydWN0
IHZtX2FyZWFfc3RydWN0ICp2bWEsIHVuc2lnbmVkIGxvbmcgb2xkX2FkZHIsCiAKIAlyZXR1cm4g
dHJ1ZTsKIH0KKworI2RlZmluZSBBRERSX0JFRk9SRV9QUkVWKGFkZHIsIHZtYSkgXAorCSgodm1h
KS0+dm1fcHJldiAmJiAoYWRkcikgPCAodm1hKS0+dm1fcHJldi0+dm1fZW5kKQorCitzdGF0aWMg
aW5saW5lIHZvaWQgdHJ5X3RvX2FsaWduX3N0YXJ0KHVuc2lnbmVkIGxvbmcgKmxlbiwKKwlzdHJ1
Y3Qgdm1fYXJlYV9zdHJ1Y3QgKm9sZCwgdW5zaWduZWQgbG9uZyAqb2xkX2FkZHIsCisJc3RydWN0
IHZtX2FyZWFfc3RydWN0ICpuZXcsIHVuc2lnbmVkIGxvbmcgKm5ld19hZGRyKQoreworCWlmIChB
RERSX0JFRk9SRV9QUkVWKCpvbGRfYWRkciAmIFBNRF9NQVNLLCBvbGQpKQorCQlyZXR1cm47CisK
KwlpZiAoQUREUl9CRUZPUkVfUFJFVigqbmV3X2FkZHIgJiBQTURfTUFTSywgbmV3KSkKKwkJcmV0
dXJuOworCisJLyogQmluZ28hICovCisJKmxlbiArPSAqbmV3X2FkZHIgJiB+UE1EX01BU0s7CisJ
Km9sZF9hZGRyICY9IFBNRF9NQVNLOworCSpuZXdfYWRkciAmPSBQTURfTUFTSzsKK30KKworLyoK
KyAqIFdoZW4gYWxpZ25pbmcgdGhlIGVuZCwgYXZvaWQgQUxJR04oKSAod2hpY2ggY2FuIG92ZXJm
bG93CisgKiBpZiB0aGUgdXNlciBzcGFjZSBpcyB0aGUgZnVsbCBhZGRyZXNzIHNwYWNlLCBhbmQg
b3ZlcnNob290CisgKiB0aGUgdm1fc3RhcnQgb2YgdGhlIG5leHQgdm1hKS4KKyAqCisgKiBBbGln
biB0aGUgdXBwZXIgbGltaXQgZG93biBpbnN0ZWFkLCBhbmQgY2hlY2sgdGhhdCBpdCdzIG5vdAor
ICogaW4gdGhlIHNhbWUgUE1EIGFzIHRoZSBlbmQuCisgKi8KKyNkZWZpbmUgQUREUl9BRlRFUl9O
RVhUKGFkZHIsIHZtYSkgXAorCSgodm1hKS0+dm1fbmV4dCAmJiAoYWRkcikgPiAoUE1EX01BU0sg
JiAodm1hKS0+dm1fbmV4dC0+dm1fc3RhcnQpKQorCitzdGF0aWMgaW5saW5lIHZvaWQgdHJ5X3Rv
X2FsaWduX2VuZCh1bnNpZ25lZCBsb25nICpsZW4sCisJc3RydWN0IHZtX2FyZWFfc3RydWN0ICpv
bGQsIHVuc2lnbmVkIGxvbmcgKm9sZF9hZGRyLAorCXN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqbmV3
LCB1bnNpZ25lZCBsb25nICpuZXdfYWRkcikKK3sKKwlpZiAoQUREUl9BRlRFUl9ORVhUKCpvbGRf
YWRkciArICpsZW4sIG9sZCkpCisJCXJldHVybjsKKworCWlmIChBRERSX0FGVEVSX05FWFQoKm5l
d19hZGRyICsgKmxlbiwgbmV3KSkKKwkJcmV0dXJuOworCisJLyogTXV0dWFsIGFsaWdubWVudCBt
ZWFucyB0aGlzIGlzIHNhbWUgZm9yIG5ldy9vbGQgYWRkciAqLworCWxlbiArPSBBTElHTigoKm5l
d19hZGRyICsgKmxlbikgJiB+UE1EX01BU0ssIFBNRF9TSVpFKTsKK30KKworLyoKKyAqIFRoZSBQ
TUQgbW92ZSBjYXNlIGlzIG11Y2ggbW9yZSBlZmZpY2llbnQsIHNvIGlmIHdlIGhhdmUgdGhlCisg
KiBtdXR1YWxseSBhbGlnbmVkIGNhc2UsIHRyeSB0byBzZWUgaWYgd2UgY2FuIGV4dGVuZCB0aGUK
KyAqIGJlZ2lubmluZyBhbmQgZW5kIHRvIGJlIGFsaWduZWQgdG9vLgorICoKKyAqIFRoZSBwb2lu
dGVyIGRlcmVmZXJlbmNlcyBsb29rIGJhZCwgYnV0IHdpdGggaW5saW5pbmcsIHRoZQorICogY29t
cGlsZXIgd2lsbCBzb3J0IGl0IG91dC4KKyAqLworc3RhdGljIGlubGluZSB2b2lkIHRyeV90b19h
bGlnbl9yYW5nZSh1bnNpZ25lZCBsb25nICpsZW4sCisJc3RydWN0IHZtX2FyZWFfc3RydWN0ICpv
bGQsIHVuc2lnbmVkIGxvbmcgKm9sZF9hZGRyLAorCXN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqbmV3
LCB1bnNpZ25lZCBsb25nICpuZXdfYWRkcikKK3sKKwlpZiAoKCpvbGRfYWRkciBeICpuZXdfYWRk
cikgJiB+UE1EX01BU0spCisJCXJldHVybjsKKworCXRyeV90b19hbGlnbl9zdGFydChsZW4sIG9s
ZCwgb2xkX2FkZHIsIG5ldywgbmV3X2FkZHIpOworCXRyeV90b19hbGlnbl9lbmQobGVuLCBvbGQs
IG9sZF9hZGRyLCBuZXcsIG5ld19hZGRyKTsKK30KKyNlbHNlCisjZGVmaW5lIHRyeV90b19hbGln
bl9yYW5nZShsZW4sb2xkLG9sZGEsbmV3LG5ld2EpIGRvIHsgfSB3aGlsZSgwKTsKICNlbmRpZgog
CiB1bnNpZ25lZCBsb25nIG1vdmVfcGFnZV90YWJsZXMoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2
bWEsCkBAIC0yNzIsNiArMzM3LDggQEAgdW5zaWduZWQgbG9uZyBtb3ZlX3BhZ2VfdGFibGVzKHN0
cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLAogCQkJCW9sZF9hZGRyLCBvbGRfZW5kKTsKIAltbXVf
bm90aWZpZXJfaW52YWxpZGF0ZV9yYW5nZV9zdGFydCgmcmFuZ2UpOwogCisJdHJ5X3RvX2FsaWdu
X3JhbmdlKCZsZW4sIHZtYSwgJm9sZF9hZGRyLCBuZXdfdm1hLCAmbmV3X2FkZHIpOworCiAJZm9y
ICg7IG9sZF9hZGRyIDwgb2xkX2VuZDsgb2xkX2FkZHIgKz0gZXh0ZW50LCBuZXdfYWRkciArPSBl
eHRlbnQpIHsKIAkJY29uZF9yZXNjaGVkKCk7CiAJCW5leHQgPSAob2xkX2FkZHIgKyBQTURfU0la
RSkgJiBQTURfTUFTSzsK
--00000000000089243c05aa7f3607--
