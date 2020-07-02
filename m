Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B355EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E718214DB
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593726949;
	bh=6h2Ujohpg1x30tNKUSUaW44Cf83SifSCpsrtPEgxg6g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uRqEoTbnMWkEv6TTWzMpkEvy8prl2oKaQ6PPAoDhf+POwaMM972y4lfPN7ueNChD3
	 lNNK7HBRoJ7bPtFh0Q+n0JenoG0mSNFhq1mu+kH+IyR4V+I8Lqcivr7FVFO5hT495O
	 wM319u+bS3kgaw+dP2HaojosCbPLp7CDBarCWwLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgGBVzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGBVzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:55:40 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5788C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 14:55:39 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id f5so18298381ljj.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 14:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eBWPla4w5ZuOBmVLN7OJnV2oMF3mSL1a7GCrqtrKS3A=;
        b=Ev//laQVkymL94Qm+NV56VPEufh6b8dOZXynnO02WXI1HnLvH6P1xe7qBSinHA5+Lq
         5wi159sABHwiNZqyO9GrfOcDGMjBgqJC74DJJVex1qMcndlFOOA6eaQYfVhdHBCJV8yd
         ixKPGna/B0HbbsQEfF8FO6fSdpsKcaXqAPZc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eBWPla4w5ZuOBmVLN7OJnV2oMF3mSL1a7GCrqtrKS3A=;
        b=QLZwoqHhQrgbiKAMWGABFS/hfBJlwH3eb59BMkxr642IR4PiFfubc6Xb7cedXKRyvM
         KKasRn6/Fwu9NhyfY1N4ESnWBJMTMMWACwPGkut9pj8oUFC3CZvhbtP82yCf6W8+41BZ
         30kJBsUAphqG8tkQnmg3CKLEp86CQH8yHRrcinuDdzO3d5CPWxpGLfJu2/bOljt7JEAW
         JatIZ+lt5emK90gAdQFo0eYiandix5V5XlmOfXf6y47CSUO1ojkSf7paQr1Ecg8Gy4LP
         XiL+zViGTyV3teP0ATFVDIpdsYW9scldi0ty/MTtWGj14tyiZcCDD0n+KBZ3w4DDbnqx
         Bddg==
X-Gm-Message-State: AOAM530e1NVn1G93NQWPKwZsVNanJqNBFdshmzC5m4j7ydjfI45GQQ8U
        9iVbkIt1dfWkR/ZDfpQfUVwWWvM9tcQ=
X-Google-Smtp-Source: ABdhPJySFqm2LQ9Mx4BxtkQtjeCvMHqsZX5pohPIZkp4OkfYPzdwU28DGCHq9/+j611fkkOARLFRLw==
X-Received: by 2002:a05:651c:1105:: with SMTP id d5mr5583942ljo.62.1593726937792;
        Thu, 02 Jul 2020 14:55:37 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id w19sm2191241ljm.120.2020.07.02.14.55.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 14:55:36 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id t74so17158362lff.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 14:55:36 -0700 (PDT)
X-Received: by 2002:ac2:5093:: with SMTP id f19mr19902332lfm.10.1593726935733;
 Thu, 02 Jul 2020 14:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjc-ktbOr7ZHMY8gfAmHxUK+aMdDsQjeh+BvmQwnQfN_g@mail.gmail.com>
 <20200701184131.GI2786714@ZenIV.linux.org.uk> <CAHk-=wj_2v9m+yZioE4vOLGW1mc9SBa5+++LdeJ86aEeB5OXcw@mail.gmail.com>
 <20200701195914.GK2786714@ZenIV.linux.org.uk> <CAHk-=wj-CYhKZR8ZKQgi=VTx=o7n6dtwPXikvgkJ3SdiqRPd8A@mail.gmail.com>
 <87lfk26nx4.fsf@mpe.ellerman.id.au> <CAHk-=wicOPQwuDUzFyDTBgr4UvQJHPdCX7_6BLaK6cve6CqBSg@mail.gmail.com>
 <20200702201755.GO2786714@ZenIV.linux.org.uk> <CAHk-=whW7qYEK-MJMS9gKf-K4cBNGTq0pv-5wo4bqE_QtUfkDw@mail.gmail.com>
 <20200702205902.GP2786714@ZenIV.linux.org.uk>
In-Reply-To: <20200702205902.GP2786714@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Jul 2020 14:55:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whm66UhcEQgXHr8hPkzyDTOdbGikLbSg0zJ4-b93aSg8w@mail.gmail.com>
Message-ID: <CAHk-=whm66UhcEQgXHr8hPkzyDTOdbGikLbSg0zJ4-b93aSg8w@mail.gmail.com>
Subject: Re: objtool clac/stac handling change..
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000dfc4eb05a97c77fc"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000dfc4eb05a97c77fc
Content-Type: text/plain; charset="UTF-8"

On Thu, Jul 2, 2020 at 1:59 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> I'm not sure it's the right solution in this case.  Look at the call chain
> and the stuff done nearby (that __clear_user(), for example)...
>
> I'm not saying that this code is not awful - it certainly is.  But it's
> not that simple, unfortunately ;-/

Well, the minimal thing to do would probably be to just change that
particular place to use asm_volatile_goto() for the error handling.

Even aside from anything else, it would improve code generation and
avoid that extra "err" variable.

So something like this (ENTIRELY UNTESTED!!).

It removes lines of code, and it must improve code generation too.

And while XSTATE_OP() is still disgusting, it's

 (a) slightly less disgusting than it used to be

 (b) now easily fixable if we do the "exceptions clear AC" thing.

so it's an improvement all around.

If it works, that is. As mentioned: IT HAS NO TESTING.

                   Linus

--000000000000dfc4eb05a97c77fc
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kc5buvf30>
X-Attachment-Id: f_kc5buvf30

IGFyY2gveDg2L2luY2x1ZGUvYXNtL2ZwdS9pbnRlcm5hbC5oIHwgNTUgKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLS0tLQogYXJjaC94ODYva2VybmVsL2ZwdS94c3RhdGUuYyAgICAg
ICAgfCAxMSArKysrLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAzNSBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9mcHUvaW50ZXJu
YWwuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2ZwdS9pbnRlcm5hbC5oCmluZGV4IDQyMTU5ZjQ1
YmY5Yy4uMzJlYjQyY2FlMDdiIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9mcHUv
aW50ZXJuYWwuaAorKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9mcHUvaW50ZXJuYWwuaApAQCAt
MjExLDE4ICsyMTEsMTIgQEAgc3RhdGljIGlubGluZSB2b2lkIGNvcHlfZnhyZWdzX3RvX2tlcm5l
bChzdHJ1Y3QgZnB1ICpmcHUpCiAjZGVmaW5lIFhSU1RPUgkJIi5ieXRlICIgUkVYX1BSRUZJWCAi
MHgwZiwweGFlLDB4MmYiCiAjZGVmaW5lIFhSU1RPUlMJCSIuYnl0ZSAiIFJFWF9QUkVGSVggIjB4
MGYsMHhjNywweDFmIgogCi0jZGVmaW5lIFhTVEFURV9PUChvcCwgc3QsIGxtYXNrLCBobWFzaywg
ZXJyKQkJCQlcCi0JYXNtIHZvbGF0aWxlKCIxOiIgb3AgIlxuXHQiCQkJCQlcCi0JCSAgICAgInhv
ciAlW2Vycl0sICVbZXJyXVxuIgkJCQlcCi0JCSAgICAgIjI6XG5cdCIJCQkJCQlcCi0JCSAgICAg
Ii5wdXNoc2VjdGlvbiAuZml4dXAsXCJheFwiXG5cdCIJCQlcCi0JCSAgICAgIjM6IG1vdmwgJC0y
LCVbZXJyXVxuXHQiCQkJCVwKLQkJICAgICAiam1wIDJiXG5cdCIJCQkJCVwKLQkJICAgICAiLnBv
cHNlY3Rpb25cblx0IgkJCQkJXAotCQkgICAgIF9BU01fRVhUQUJMRSgxYiwgM2IpCQkJCVwKLQkJ
ICAgICA6IFtlcnJdICI9ciIgKGVycikJCQkJCVwKLQkJICAgICA6ICJEIiAoc3QpLCAibSIgKCpz
dCksICJhIiAobG1hc2spLCAiZCIgKGhtYXNrKQlcCi0JCSAgICAgOiAibWVtb3J5IikKKyNkZWZp
bmUgWFNUQVRFX09QKG9wLCBzdCwgbG1hc2ssIGhtYXNrLCBsYWJlbCkJCQkJXAorCWFzbV92b2xh
dGlsZV9nb3RvKCIxOiIgb3AgIlxuXHQiCQkJCVwKKwkJICBfQVNNX0VYVEFCTEUoMWIsICVsNCkJ
CQkJCVwKKwkJOiAvKiBubyBvdXRwdXRzICovCQkJCQlcCisJCTogIkQiIChzdCksICJtIiAoKnN0
KSwgImEiIChsbWFzayksICJkIiAoaG1hc2spCQlcCisJCTogIm1lbW9yeSIgOiBsYWJlbCkKIAog
LyoKICAqIElmIFhTQVZFUyBpcyBlbmFibGVkLCBpdCByZXBsYWNlcyBYU0FWRU9QVCBiZWNhdXNl
IGl0IHN1cHBvcnRzIGEgY29tcGFjdApAQCAtMjc3LDcgKzI3MSw2IEBAIHN0YXRpYyBpbmxpbmUg
dm9pZCBjb3B5X3hyZWdzX3RvX2tlcm5lbF9ib290aW5nKHN0cnVjdCB4cmVnc19zdGF0ZSAqeHN0
YXRlKQogCXU2NCBtYXNrID0gLTE7CiAJdTMyIGxtYXNrID0gbWFzazsKIAl1MzIgaG1hc2sgPSBt
YXNrID4+IDMyOwotCWludCBlcnI7CiAKIAlXQVJOX09OKHN5c3RlbV9zdGF0ZSAhPSBTWVNURU1f
Qk9PVElORyk7CiAKQEAgLTI4NSw5ICsyNzgsMTEgQEAgc3RhdGljIGlubGluZSB2b2lkIGNvcHlf
eHJlZ3NfdG9fa2VybmVsX2Jvb3Rpbmcoc3RydWN0IHhyZWdzX3N0YXRlICp4c3RhdGUpCiAJCVhT
VEFURV9PUChYU0FWRVMsIHhzdGF0ZSwgbG1hc2ssIGhtYXNrLCBlcnIpOwogCWVsc2UKIAkJWFNU
QVRFX09QKFhTQVZFLCB4c3RhdGUsIGxtYXNrLCBobWFzaywgZXJyKTsKKwlyZXR1cm47CiAKK2Vy
cjoKIAkvKiBXZSBzaG91bGQgbmV2ZXIgZmF1bHQgd2hlbiBjb3B5aW5nIHRvIGEga2VybmVsIGJ1
ZmZlcjogKi8KLQlXQVJOX09OX0ZQVShlcnIpOworCVdBUk5fT05fRlBVKDEpOwogfQogCiAvKgpA
QCAtMjk5LDcgKzI5NCw2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBjb3B5X2tlcm5lbF90b194cmVn
c19ib290aW5nKHN0cnVjdCB4cmVnc19zdGF0ZSAqeHN0YXRlKQogCXU2NCBtYXNrID0gLTE7CiAJ
dTMyIGxtYXNrID0gbWFzazsKIAl1MzIgaG1hc2sgPSBtYXNrID4+IDMyOwotCWludCBlcnI7CiAK
IAlXQVJOX09OKHN5c3RlbV9zdGF0ZSAhPSBTWVNURU1fQk9PVElORyk7CiAKQEAgLTMwNywxMiAr
MzAxLDEwIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBjb3B5X2tlcm5lbF90b194cmVnc19ib290aW5n
KHN0cnVjdCB4cmVnc19zdGF0ZSAqeHN0YXRlKQogCQlYU1RBVEVfT1AoWFJTVE9SUywgeHN0YXRl
LCBsbWFzaywgaG1hc2ssIGVycik7CiAJZWxzZQogCQlYU1RBVEVfT1AoWFJTVE9SLCB4c3RhdGUs
IGxtYXNrLCBobWFzaywgZXJyKTsKKwlyZXR1cm47CiAKLQkvKgotCSAqIFdlIHNob3VsZCBuZXZl
ciBmYXVsdCB3aGVuIGNvcHlpbmcgZnJvbSBhIGtlcm5lbCBidWZmZXIsIGFuZCB0aGUgRlBVCi0J
ICogc3RhdGUgd2Ugc2V0IGF0IGJvb3QgdGltZSBzaG91bGQgYmUgdmFsaWQuCi0JICovCi0JV0FS
Tl9PTl9GUFUoZXJyKTsKK2VycjoKKwlXQVJOX09OX0ZQVSgxKTsKIH0KIAogLyoKQEAgLTM1Niwy
MSArMzQ4LDIxIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBjb3B5X2tlcm5lbF90b194cmVncyhzdHJ1
Y3QgeHJlZ3Nfc3RhdGUgKnhzdGF0ZSwgdTY0IG1hc2spCiAgKi8KIHN0YXRpYyBpbmxpbmUgaW50
IGNvcHlfeHJlZ3NfdG9fdXNlcihzdHJ1Y3QgeHJlZ3Nfc3RhdGUgX191c2VyICpidWYpCiB7Ci0J
aW50IGVycjsKLQogCS8qCiAJICogQ2xlYXIgdGhlIHhzYXZlIGhlYWRlciBmaXJzdCwgc28gdGhh
dCByZXNlcnZlZCBmaWVsZHMgYXJlCiAJICogaW5pdGlhbGl6ZWQgdG8gemVyby4KIAkgKi8KLQll
cnIgPSBfX2NsZWFyX3VzZXIoJmJ1Zi0+aGVhZGVyLCBzaXplb2YoYnVmLT5oZWFkZXIpKTsKLQlp
ZiAodW5saWtlbHkoZXJyKSkKKwlpZiAodW5saWtlbHkoX19jbGVhcl91c2VyKCZidWYtPmhlYWRl
ciwgc2l6ZW9mKGJ1Zi0+aGVhZGVyKSkpKQogCQlyZXR1cm4gLUVGQVVMVDsKIAogCXN0YWMoKTsK
IAlYU1RBVEVfT1AoWFNBVkUsIGJ1ZiwgLTEsIC0xLCBlcnIpOwogCWNsYWMoKTsKIAotCXJldHVy
biBlcnI7CisJcmV0dXJuIDA7CitlcnI6CisJY2xhYygpOworCXJldHVybiAtRUZBVUxUOwogfQog
CiAvKgpAQCAtMzgxLDEzICszNzMsMTQgQEAgc3RhdGljIGlubGluZSBpbnQgY29weV91c2VyX3Rv
X3hyZWdzKHN0cnVjdCB4cmVnc19zdGF0ZSBfX3VzZXIgKmJ1ZiwgdTY0IG1hc2spCiAJc3RydWN0
IHhyZWdzX3N0YXRlICp4c3RhdGUgPSAoKF9fZm9yY2Ugc3RydWN0IHhyZWdzX3N0YXRlICopYnVm
KTsKIAl1MzIgbG1hc2sgPSBtYXNrOwogCXUzMiBobWFzayA9IG1hc2sgPj4gMzI7Ci0JaW50IGVy
cjsKIAogCXN0YWMoKTsKIAlYU1RBVEVfT1AoWFJTVE9SLCB4c3RhdGUsIGxtYXNrLCBobWFzaywg
ZXJyKTsKIAljbGFjKCk7Ci0KLQlyZXR1cm4gZXJyOworCXJldHVybiAwOworZXJyOgorCWNsYWMo
KTsKKwlyZXR1cm4gLUVGQVVMVDsKIH0KIAogLyoKQEAgLTM5OCwxNCArMzkxLDE2IEBAIHN0YXRp
YyBpbmxpbmUgaW50IGNvcHlfa2VybmVsX3RvX3hyZWdzX2VycihzdHJ1Y3QgeHJlZ3Nfc3RhdGUg
KnhzdGF0ZSwgdTY0IG1hc2spCiB7CiAJdTMyIGxtYXNrID0gbWFzazsKIAl1MzIgaG1hc2sgPSBt
YXNrID4+IDMyOwotCWludCBlcnI7CiAKIAlpZiAoc3RhdGljX2NwdV9oYXMoWDg2X0ZFQVRVUkVf
WFNBVkVTKSkKIAkJWFNUQVRFX09QKFhSU1RPUlMsIHhzdGF0ZSwgbG1hc2ssIGhtYXNrLCBlcnIp
OwogCWVsc2UKIAkJWFNUQVRFX09QKFhSU1RPUiwgeHN0YXRlLCBsbWFzaywgaG1hc2ssIGVycik7
CiAKLQlyZXR1cm4gZXJyOworCXJldHVybiAwOworZXJyOgorCS8qIFdoYXQgd291bGQgdGhlIHJp
Z2h0IGVycm9yIGJlPyAqLworCXJldHVybiAtRUlOVkFMOwogfQogCiAvKgpkaWZmIC0tZ2l0IGEv
YXJjaC94ODYva2VybmVsL2ZwdS94c3RhdGUuYyBiL2FyY2gveDg2L2tlcm5lbC9mcHUveHN0YXRl
LmMKaW5kZXggYmRhMmU1ZWFjYTBlLi4xODdlZDA2MzBiNGIgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2
L2tlcm5lbC9mcHUveHN0YXRlLmMKKysrIGIvYXJjaC94ODYva2VybmVsL2ZwdS94c3RhdGUuYwpA
QCAtMTMxMSw3ICsxMzExLDcgQEAgdm9pZCBjb3B5X3N1cGVydmlzb3JfdG9fa2VybmVsKHN0cnVj
dCB4cmVnc19zdGF0ZSAqeHN0YXRlKQogCXN0cnVjdCB4c3RhdGVfaGVhZGVyICpoZWFkZXI7CiAJ
dTY0IG1heF9iaXQsIG1pbl9iaXQ7CiAJdTMyIGxtYXNrLCBobWFzazsKLQlpbnQgZXJyLCBpOwor
CWludCBpOwogCiAJaWYgKFdBUk5fT04oIWJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9YU0FWRVMp
KSkKIAkJcmV0dXJuOwpAQCAtMTMyNiwxMCArMTMyNiw2IEBAIHZvaWQgY29weV9zdXBlcnZpc29y
X3RvX2tlcm5lbChzdHJ1Y3QgeHJlZ3Nfc3RhdGUgKnhzdGF0ZSkKIAlobWFzayA9IHhmZWF0dXJl
c19tYXNrX3N1cGVydmlzb3IoKSA+PiAzMjsKIAlYU1RBVEVfT1AoWFNBVkVTLCB4c3RhdGUsIGxt
YXNrLCBobWFzaywgZXJyKTsKIAotCS8qIFdlIHNob3VsZCBuZXZlciBmYXVsdCB3aGVuIGNvcHlp
bmcgdG8gYSBrZXJuZWwgYnVmZmVyOiAqLwotCWlmIChXQVJOX09OX0ZQVShlcnIpKQotCQlyZXR1
cm47Ci0KIAkvKgogCSAqIEF0IHRoaXMgcG9pbnQsIHRoZSBidWZmZXIgaGFzIG9ubHkgc3VwZXJ2
aXNvciBzdGF0ZXMgYW5kIG11c3QgYmUKIAkgKiBjb252ZXJ0ZWQgYmFjayB0byBub3JtYWwga2Vy
bmVsIGZvcm1hdC4KQEAgLTEzNTQsNiArMTM1MCwxMSBAQCB2b2lkIGNvcHlfc3VwZXJ2aXNvcl90
b19rZXJuZWwoc3RydWN0IHhyZWdzX3N0YXRlICp4c3RhdGUpCiAJCQl4YnVmICsgeHN0YXRlX3N1
cGVydmlzb3Jfb25seV9vZmZzZXRzW2ldLAogCQkJeHN0YXRlX3NpemVzW2ldKTsKIAl9CisJcmV0
dXJuOworCitlcnI6CisJLyogV2Ugc2hvdWxkIG5ldmVyIGZhdWx0IHdoZW4gY29weWluZyB0byBh
IGtlcm5lbCBidWZmZXI6ICovCisJV0FSTl9PTl9GUFUoMSk7CiB9CiAKICNpZmRlZiBDT05GSUdf
UFJPQ19QSURfQVJDSF9TVEFUVVMK
--000000000000dfc4eb05a97c77fc--
