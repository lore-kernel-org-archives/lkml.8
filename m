Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBB7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 23:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91BE520738
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 23:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a0uDTwrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgHUXRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 19:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgHUXRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 19:17:10 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C90C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 16:17:10 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh1so1549791plb.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 16:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8fcxk4S/SS9+6U/sU5xiUTNNUcgHge8dj9UT33Hlegs=;
        b=a0uDTwrKrklXNT/+DQJX3AvarzvVldEpUkgpgeWT9j4aQ6BQXI6RYxRS65s1IdDTo8
         DrZzeUpfP2IYvOuj0WQ41aYWF1RwczFnnyR5O8bECefKqAnYRF4V3lQwttYHITG4eVkt
         Wdu14k1/WQje0wZS8ZdlMpszIoKABSmaUc9WUbwsgG+4aJWof2Ua9neG84eX6qcuXspg
         CMPWr9cAgmQWQxieZlGKPPIzSjmM4x4GqqfY0dYzeIzdf5DdumiwCI42XLCrKF1h8AYk
         nU6vwixJvEP4CtAHLSzdod3dW9qAM3PUNzpTOBZ4aHkscENhD4nZWEXA1eC4jM2PK1w3
         Pm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8fcxk4S/SS9+6U/sU5xiUTNNUcgHge8dj9UT33Hlegs=;
        b=NCS+ttQKUyzaDekGfT//XjsbWlQ0vRAeuD5c+LEqbB+vzQgYxJfMKkoXkzzaElKG1J
         0f2RS4VaY7X1S7kJ8CYGk556bS1J58F+54lMxYIvFLWaA3k32Y6erb39XvjDagYfO3xr
         jPOxt4SiPqvFiloG1IOCly6xdMZ2Oq7CJe4saZ+Ut80dYvvvOuOItjzcxZxVyYy5amhk
         2fdzP/M3t3xB7BwzmNzj8RggMMQjjuHaaxkEPLPj+M9Qw6AMe9K5vyTo+1PRLPKDX3mb
         b3+MTykEuwQG4BvLcl/GiBt+uY00YwT8S0vRFRLo7EqutmNqnsvSFWNbJWh6m9K6QaQH
         h0Sw==
X-Gm-Message-State: AOAM532m8wB7pd5cPYIqXZxbisEXpnPQJWEsXknzfDM3WcLWHAjq18lw
        L7OwoagzCCrBxWtTHcL6J770IAz71WMoPnwtvnJIFg==
X-Google-Smtp-Source: ABdhPJy3hvELBxLZ9kFrXMB9vT3wtsbYWpUJbNbava5CXEnzBftZ5u5oD18U3Ea1X+7QB5Uzm23skuumJGCjXyDAwVc=
X-Received: by 2002:a17:90a:a10c:: with SMTP id s12mr4283278pjp.32.1598051828324;
 Fri, 21 Aug 2020 16:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200527135329.1172644-1-arnd@arndb.de> <878serh1b9.fsf@nanos.tec.linutronix.de>
 <CAKwvOdnOh3H3ga2qpTktywvcgfXW5QJaB7r4XMhigmDzLhDNeA@mail.gmail.com>
 <87h7t6tpye.fsf@nanos.tec.linutronix.de> <20200813173701.GC4295@paulmck-ThinkPad-P72>
 <20200813180933.GA532283@rani.riverdale.lan> <875z9dioll.fsf@nanos.tec.linutronix.de>
 <20200820130641.GA536306@rani.riverdale.lan> <87zh6ohm03.fsf@nanos.tec.linutronix.de>
 <20200821230435.GA56974@rani.riverdale.lan>
In-Reply-To: <20200821230435.GA56974@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 21 Aug 2020 16:16:56 -0700
Message-ID: <CAKwvOdkoB+fT9tt7vgg1R6J-NEr77EWP5X8nFat_L-HvEzWGzA@mail.gmail.com>
Subject: Re: [PATCH] x86: work around clang IAS bug referencing __force_order
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: multipart/mixed; boundary="0000000000008fd34e05ad6b6f20"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000008fd34e05ad6b6f20
Content-Type: text/plain; charset="UTF-8"

On Fri, Aug 21, 2020 at 4:04 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Fri, Aug 21, 2020 at 02:37:48AM +0200, Thomas Gleixner wrote:
> > On Thu, Aug 20 2020 at 09:06, Arvind Sankar wrote:
> > > I don't think that's an issue, or at least, not one where force_order
> > > helps.
> > >
> > > If the source for foo() is not visible to the compiler, the only reason
> > > force_order prevents the reordering is because foo() might have
> > > references to it, but equally foo() might have volatile asm, so the
> > > reordering isn't possible anyway.
> > >
> > > If the source is visible, force_order won't prevent any reordering
> > > except across references to force_order, but the only references are
> > > from the volatile asm's which already prevent reordering.
> > >
> > > I think force_order can only help with buggy compilers, and for those it
> > > should really have been an input-output operand -- it wouldn't currently
> > > do anything to prevent cr writes from being reordered.

I agree 100%.  From the link to GCC docs, the code in question doesn't
even follow the pattern from the doc from informing the compiler of
any dependency, it just looks like !@#$.

> >
> > Fair enough. Care to provide a patch which has the collected wisdom of
> > this thread in the changelog?
> >
> > Thanks,
> >
> >         tglx
>
> The gcc bug I linked to earlier is only fixed in gcc-6 onwards. Is that

(based on https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82602#c14)

> good enough to remove force_order? I can test gcc-4.9 and gcc-5 to check
> if it would currently have any impact.

I think checking the disassemblies with a pre-gcc-6 would be good
enough then; that bug isn't specific to this particular case.

> CBL guys, can you confirm that clang also will not reorder volatile asm?

Full disassemblies of vmlinux pre vs post __force_order removal are
the same.  That's pretty good actually; I was worried for a code base
of this size whether two compiles would produce the exact same
disassemblies; I know the version strings are timestamped, for
instance, but I didn't compare data, just .text.  I should triple
check i386, and some of the ko's that use modified functions.  I'd be
happy to help provide a tested by tag for numerous configurations with
Clang.

Attaching the diff I was testing, feel free to add a commit message.
--
Thanks,
~Nick Desaulniers

--0000000000008fd34e05ad6b6f20
Content-Type: application/octet-stream; name="force_order.patch"
Content-Disposition: attachment; filename="force_order.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ke4uosxj0>
X-Attachment-Id: f_ke4uosxj0

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9wZ3RhYmxlXzY0LmMgYi9hcmNo
L3g4Ni9ib290L2NvbXByZXNzZWQvcGd0YWJsZV82NC5jCmluZGV4IGM4ODYyNjk2YTQ3Yi4uN2Qw
Mzk0ZjRlYmY5IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9ib290L2NvbXByZXNzZWQvcGd0YWJsZV82
NC5jCisrKyBiL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9wZ3RhYmxlXzY0LmMKQEAgLTUsMTUg
KzUsNiBAQAogI2luY2x1ZGUgInBndGFibGUuaCIKICNpbmNsdWRlICIuLi9zdHJpbmcuaCIKIAot
LyoKLSAqIF9fZm9yY2Vfb3JkZXIgaXMgdXNlZCBieSBzcGVjaWFsX2luc25zLmggYXNtIGNvZGUg
dG8gZm9yY2UgaW5zdHJ1Y3Rpb24KLSAqIHNlcmlhbGl6YXRpb24uCi0gKgotICogSXQgaXMgbm90
IHJlZmVyZW5jZWQgZnJvbSB0aGUgY29kZSwgYnV0IEdDQyA8IDUgd2l0aCAtZlBJRSB3b3VsZCBm
YWlsCi0gKiBkdWUgdG8gYW4gdW5kZWZpbmVkIHN5bWJvbC4gRGVmaW5lIGl0IHRvIG1ha2UgdGhl
c2UgYW5jaWVudCBHQ0NzIHdvcmsuCi0gKi8KLXVuc2lnbmVkIGxvbmcgX19mb3JjZV9vcmRlcjsK
LQogI2RlZmluZSBCSU9TX1NUQVJUX01JTgkJMHgyMDAwMFUJLyogMTI4SywgbGVzcyB0aGFuIHRo
aXMgaXMgaW5zYW5lICovCiAjZGVmaW5lIEJJT1NfU1RBUlRfTUFYCQkweDlmMDAwVQkvKiA2NDBL
LCBhYnNvbHV0ZSBtYXhpbXVtICovCiAKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNt
L3NwZWNpYWxfaW5zbnMuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NwZWNpYWxfaW5zbnMuaApp
bmRleCA1OWEzZTEzMjA0YzMuLmQyZTBkNTNiMGY2OSAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5j
bHVkZS9hc20vc3BlY2lhbF9pbnNucy5oCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NwZWNp
YWxfaW5zbnMuaApAQCAtMTAsNDYgKzEwLDM3IEBACiAjaW5jbHVkZSA8bGludXgvaXJxZmxhZ3Mu
aD4KICNpbmNsdWRlIDxsaW51eC9qdW1wX2xhYmVsLmg+CiAKLS8qCi0gKiBWb2xhdGlsZSBpc24n
dCBlbm91Z2ggdG8gcHJldmVudCB0aGUgY29tcGlsZXIgZnJvbSByZW9yZGVyaW5nIHRoZQotICog
cmVhZC93cml0ZSBmdW5jdGlvbnMgZm9yIHRoZSBjb250cm9sIHJlZ2lzdGVycyBhbmQgbWVzc2lu
ZyBldmVyeXRoaW5nIHVwLgotICogQSBtZW1vcnkgY2xvYmJlciB3b3VsZCBzb2x2ZSB0aGUgcHJv
YmxlbSwgYnV0IHdvdWxkIHByZXZlbnQgcmVvcmRlcmluZyBvZgotICogYWxsIGxvYWRzIHN0b3Jl
cyBhcm91bmQgaXQsIHdoaWNoIGNhbiBodXJ0IHBlcmZvcm1hbmNlLiBTb2x1dGlvbiBpcyB0bwot
ICogdXNlIGEgdmFyaWFibGUgYW5kIG1pbWljIHJlYWRzIGFuZCB3cml0ZXMgdG8gaXQgdG8gZW5m
b3JjZSBzZXJpYWxpemF0aW9uCi0gKi8KLWV4dGVybiB1bnNpZ25lZCBsb25nIF9fZm9yY2Vfb3Jk
ZXI7Ci0KIHZvaWQgbmF0aXZlX3dyaXRlX2NyMCh1bnNpZ25lZCBsb25nIHZhbCk7CiAKIHN0YXRp
YyBpbmxpbmUgdW5zaWduZWQgbG9uZyBuYXRpdmVfcmVhZF9jcjAodm9pZCkKIHsKIAl1bnNpZ25l
ZCBsb25nIHZhbDsKLQlhc20gdm9sYXRpbGUoIm1vdiAlJWNyMCwlMFxuXHQiIDogIj1yIiAodmFs
KSwgIj1tIiAoX19mb3JjZV9vcmRlcikpOworCWFzbSB2b2xhdGlsZSgibW92ICUlY3IwLCUwXG5c
dCIgOiAiPXIiICh2YWwpKTsKIAlyZXR1cm4gdmFsOwogfQogCiBzdGF0aWMgX19hbHdheXNfaW5s
aW5lIHVuc2lnbmVkIGxvbmcgbmF0aXZlX3JlYWRfY3IyKHZvaWQpCiB7CiAJdW5zaWduZWQgbG9u
ZyB2YWw7Ci0JYXNtIHZvbGF0aWxlKCJtb3YgJSVjcjIsJTBcblx0IiA6ICI9ciIgKHZhbCksICI9
bSIgKF9fZm9yY2Vfb3JkZXIpKTsKKwlhc20gdm9sYXRpbGUoIm1vdiAlJWNyMiwlMFxuXHQiIDog
Ij1yIiAodmFsKSk7CiAJcmV0dXJuIHZhbDsKIH0KIAogc3RhdGljIF9fYWx3YXlzX2lubGluZSB2
b2lkIG5hdGl2ZV93cml0ZV9jcjIodW5zaWduZWQgbG9uZyB2YWwpCiB7Ci0JYXNtIHZvbGF0aWxl
KCJtb3YgJTAsJSVjcjIiOiA6ICJyIiAodmFsKSwgIm0iIChfX2ZvcmNlX29yZGVyKSk7CisJYXNt
IHZvbGF0aWxlKCJtb3YgJTAsJSVjcjIiOiA6ICJyIiAodmFsKSk7CiB9CiAKIHN0YXRpYyBpbmxp
bmUgdW5zaWduZWQgbG9uZyBfX25hdGl2ZV9yZWFkX2NyMyh2b2lkKQogewogCXVuc2lnbmVkIGxv
bmcgdmFsOwotCWFzbSB2b2xhdGlsZSgibW92ICUlY3IzLCUwXG5cdCIgOiAiPXIiICh2YWwpLCAi
PW0iIChfX2ZvcmNlX29yZGVyKSk7CisJYXNtIHZvbGF0aWxlKCJtb3YgJSVjcjMsJTBcblx0IiA6
ICI9ciIgKHZhbCkpOwogCXJldHVybiB2YWw7CiB9CiAKIHN0YXRpYyBpbmxpbmUgdm9pZCBuYXRp
dmVfd3JpdGVfY3IzKHVuc2lnbmVkIGxvbmcgdmFsKQogewotCWFzbSB2b2xhdGlsZSgibW92ICUw
LCUlY3IzIjogOiAiciIgKHZhbCksICJtIiAoX19mb3JjZV9vcmRlcikpOworCWFzbSB2b2xhdGls
ZSgibW92ICUwLCUlY3IzIjogOiAiciIgKHZhbCkpOwogfQogCiBzdGF0aWMgaW5saW5lIHVuc2ln
bmVkIGxvbmcgbmF0aXZlX3JlYWRfY3I0KHZvaWQpCkBAIC02NCwxMCArNTUsMTAgQEAgc3RhdGlj
IGlubGluZSB1bnNpZ25lZCBsb25nIG5hdGl2ZV9yZWFkX2NyNCh2b2lkKQogCWFzbSB2b2xhdGls
ZSgiMTogbW92ICUlY3I0LCAlMFxuIgogCQkgICAgICIyOlxuIgogCQkgICAgIF9BU01fRVhUQUJM
RSgxYiwgMmIpCi0JCSAgICAgOiAiPXIiICh2YWwpLCAiPW0iIChfX2ZvcmNlX29yZGVyKSA6ICIw
IiAoMCkpOworCQkgICAgIDogIj1yIiAodmFsKSA6ICIwIiAoMCkpOwogI2Vsc2UKIAkvKiBDUjQg
YWx3YXlzIGV4aXN0cyBvbiB4ODZfNjQuICovCi0JYXNtIHZvbGF0aWxlKCJtb3YgJSVjcjQsJTBc
blx0IiA6ICI9ciIgKHZhbCksICI9bSIgKF9fZm9yY2Vfb3JkZXIpKTsKKwlhc20gdm9sYXRpbGUo
Im1vdiAlJWNyNCwlMFxuXHQiIDogIj1yIiAodmFsKSk7CiAjZW5kaWYKIAlyZXR1cm4gdmFsOwog
fQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9jb21tb24uYyBiL2FyY2gveDg2L2tl
cm5lbC9jcHUvY29tbW9uLmMKaW5kZXggYzVkNmYxN2Q5YjlkLi5kYzYyYWVhOGM5ZTEgMTAwNjQ0
Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMKKysrIGIvYXJjaC94ODYva2VybmVs
L2NwdS9jb21tb24uYwpAQCAtMzU5LDcgKzM1OSw3IEBAIHZvaWQgbmF0aXZlX3dyaXRlX2NyMCh1
bnNpZ25lZCBsb25nIHZhbCkKIAl1bnNpZ25lZCBsb25nIGJpdHNfbWlzc2luZyA9IDA7CiAKIHNl
dF9yZWdpc3RlcjoKLQlhc20gdm9sYXRpbGUoIm1vdiAlMCwlJWNyMCI6ICIrciIgKHZhbCksICIr
bSIgKF9fZm9yY2Vfb3JkZXIpKTsKKwlhc20gdm9sYXRpbGUoIm1vdiAlMCwlJWNyMCI6ICIrciIg
KHZhbCkpOwogCiAJaWYgKHN0YXRpY19icmFuY2hfbGlrZWx5KCZjcl9waW5uaW5nKSkgewogCQlp
ZiAodW5saWtlbHkoKHZhbCAmIFg4Nl9DUjBfV1ApICE9IFg4Nl9DUjBfV1ApKSB7Cg==
--0000000000008fd34e05ad6b6f20--
