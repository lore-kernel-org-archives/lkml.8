Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F9BC433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F01BA2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594849406;
	bh=aQpQVzk1xUYNjebeOl4o3pvHPiq0ZZecL/XEdPFq1+0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=14XUOLSIIqIE4IBqpORfVrW/rAKuRGYv3sNjDQULQZEN0LVOb0+gtArc47VfE1KuH
	 IyjwipM8njiHK0OnNTN00E6SHL2fUp1hh0tCrANPh7h9gODDRBG48gpezcjoZfTYzk
	 DbBC3rmvlmNdWPn2oosSxDggbyibofL9a1R4ZZg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgGOVnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgGOVnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 17:43:20 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC07AC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 14:43:19 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id x9so4430899ljc.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 14:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3057EMWaB0Rm7SYQylMTrxjhWYKGDzBcFFBU9TaBwGE=;
        b=GnnquYDJshFWXxRYjFZehI+GFKvShVAkirzPeulbS97rwl268xDJYKMsd3Gl7eLyHH
         m9I//bxHzB3mrtl7VR52+jQaPEqCWpg2k5AcyeErele8/RyM5U3eYDEveSZpJxJxDIN/
         YRqqKk3QYZe7SUAlAdDXA6eqPB7agwr7jIg5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3057EMWaB0Rm7SYQylMTrxjhWYKGDzBcFFBU9TaBwGE=;
        b=Epets0mIBsjjeK0rnBmAmRpLQyRNf/yhASk6YbT4KLd87bVYkXMOOSoUZY9c809vIj
         WbH+actqprmIgsla9j4Xq5L+aBOZ93PB7pCWbi4HKE0FPpkSoSnMA7CQU74zeXKEoIim
         GnjW9/xRJxMHKar+rbcbsBcVGdhIwHvkAiEv6Zp3c2zuWwmmnU6/n1uqxpBXyPIrEb/D
         0FyL5KXTrCtpd8AZRQZ8P3BRQsrOI6aP816pTlOUKrR0OZvI3pd/FWCQmfP4sEKormfx
         CcM9UFT0onhjeJy/PIm7KUsACU4jD9iC3mL4PDSAIqipBvtpfyRB6pP8y8sVfKxZbEyP
         ht2A==
X-Gm-Message-State: AOAM531UlJo/169N3METUR2npNJLL1F682NrTLJq5qnOy/ld6z8oD2EE
        Luxe8HFMOINdKUy9jfaUlMusnoY0Is8=
X-Google-Smtp-Source: ABdhPJx7dlVYweDRsXRu+UJ10w0273pGot5+6Jyof0fl0UGvTsnUn0Ey3PM2o5mUoZr11V0mzN0FuQ==
X-Received: by 2002:a2e:80cc:: with SMTP id r12mr560211ljg.344.1594849397938;
        Wed, 15 Jul 2020 14:43:17 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id i10sm660349ljg.80.2020.07.15.14.43.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 14:43:16 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id o4so1950744lfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 14:43:16 -0700 (PDT)
X-Received: by 2002:a05:6512:241:: with SMTP id b1mr138854lfo.125.1594849396345;
 Wed, 15 Jul 2020 14:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200715135011.42743-1-kirill.shutemov@linux.intel.com>
 <CAHk-=wh4pB-jRngOjcGxpc8=NPds3jWqJwDMUWC3-OEo4dRiKg@mail.gmail.com>
 <20200715205428.GA201569@google.com> <CAHk-=wg-_Oof43pKUHMk4ySdLwpYi7+shFg+aeV18UP2Akiv8g@mail.gmail.com>
In-Reply-To: <CAHk-=wg-_Oof43pKUHMk4ySdLwpYi7+shFg+aeV18UP2Akiv8g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Jul 2020 14:43:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg+iVwK7MDXB+BPbhTmP-1eBa-y4vxRNr_G8ETnzv5pZg@mail.gmail.com>
Message-ID: <CAHk-=wg+iVwK7MDXB+BPbhTmP-1eBa-y4vxRNr_G8ETnzv5pZg@mail.gmail.com>
Subject: Re: [PATCHv2] mm: Fix warning in move_normal_pmd()
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        William Kucharski <william.kucharski@oracle.com>
Content-Type: multipart/mixed; boundary="000000000000bd913e05aa81cf94"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000bd913e05aa81cf94
Content-Type: text/plain; charset="UTF-8"

On Wed, Jul 15, 2020 at 2:31 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Naresh - don't test that version. The bugs Joel found just make the
> math wrong, so it won't work.

Here's a new version with the thing that Joel and Kirill both noticed
hopefully fixed.

But I probably screwed it up again. I guess I should test it, but I
don't have any really relevant environment (the plain mremap() case
should have shown the obvious bugs, though, so that's just an excuse
for my laziness)

            Linus

--000000000000bd913e05aa81cf94
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kcnw52pb0>
X-Attachment-Id: f_kcnw52pb0

ZGlmZiAtLWdpdCBhL21tL21yZW1hcC5jIGIvbW0vbXJlbWFwLmMKaW5kZXggNWRkNTcyZDU3Y2E5
Li42MTRiNGZmZmVkMWQgMTAwNjQ0Ci0tLSBhL21tL21yZW1hcC5jCisrKyBiL21tL21yZW1hcC5j
CkBAIC0yMzUsNiArMjM1LDcxIEBAIHN0YXRpYyBib29sIG1vdmVfbm9ybWFsX3BtZChzdHJ1Y3Qg
dm1fYXJlYV9zdHJ1Y3QgKnZtYSwgdW5zaWduZWQgbG9uZyBvbGRfYWRkciwKIAogCXJldHVybiB0
cnVlOwogfQorCisjZGVmaW5lIEFERFJfQkVGT1JFX1BSRVYoYWRkciwgdm1hKSBcCisJKCh2bWEp
LT52bV9wcmV2ICYmIChhZGRyKSA8ICh2bWEpLT52bV9wcmV2LT52bV9lbmQpCisKK3N0YXRpYyBp
bmxpbmUgdm9pZCB0cnlfdG9fYWxpZ25fc3RhcnQodW5zaWduZWQgbG9uZyAqbGVuLAorCXN0cnVj
dCB2bV9hcmVhX3N0cnVjdCAqb2xkLCB1bnNpZ25lZCBsb25nICpvbGRfYWRkciwKKwlzdHJ1Y3Qg
dm1fYXJlYV9zdHJ1Y3QgKm5ldywgdW5zaWduZWQgbG9uZyAqbmV3X2FkZHIpCit7CisJaWYgKEFE
RFJfQkVGT1JFX1BSRVYoKm9sZF9hZGRyICYgUE1EX01BU0ssIG9sZCkpCisJCXJldHVybjsKKwor
CWlmIChBRERSX0JFRk9SRV9QUkVWKCpuZXdfYWRkciAmIFBNRF9NQVNLLCBuZXcpKQorCQlyZXR1
cm47CisKKwkvKiBCaW5nbyEgKi8KKwkqbGVuICs9ICpuZXdfYWRkciAmIH5QTURfTUFTSzsKKwkq
b2xkX2FkZHIgJj0gUE1EX01BU0s7CisJKm5ld19hZGRyICY9IFBNRF9NQVNLOworfQorCisvKgor
ICogV2hlbiBhbGlnbmluZyB0aGUgZW5kLCBhdm9pZCBBTElHTigpICh3aGljaCBjYW4gb3ZlcmZs
b3cKKyAqIGlmIHRoZSB1c2VyIHNwYWNlIGlzIHRoZSBmdWxsIGFkZHJlc3Mgc3BhY2UsIGFuZCBv
dmVyc2hvb3QKKyAqIHRoZSB2bV9zdGFydCBvZiB0aGUgbmV4dCB2bWEpLgorICoKKyAqIEFsaWdu
IHRoZSB1cHBlciBsaW1pdCBkb3duIGluc3RlYWQsIGFuZCBjaGVjayB0aGF0IGl0J3Mgbm90Cisg
KiBpbiB0aGUgc2FtZSBQTUQgYXMgdGhlIGVuZC4KKyAqLworI2RlZmluZSBBRERSX0FGVEVSX05F
WFQoYWRkciwgdm1hKSBcCisJKCh2bWEpLT52bV9uZXh0ICYmIChhZGRyKSA+IChQTURfTUFTSyAm
ICh2bWEpLT52bV9uZXh0LT52bV9zdGFydCkpCisKK3N0YXRpYyBpbmxpbmUgdm9pZCB0cnlfdG9f
YWxpZ25fZW5kKHVuc2lnbmVkIGxvbmcgKmxlbiwKKwlzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKm9s
ZCwgdW5zaWduZWQgbG9uZyAqb2xkX2FkZHIsCisJc3RydWN0IHZtX2FyZWFfc3RydWN0ICpuZXcs
IHVuc2lnbmVkIGxvbmcgKm5ld19hZGRyKQoreworCWlmIChBRERSX0FGVEVSX05FWFQoKm9sZF9h
ZGRyICsgKmxlbiwgb2xkKSkKKwkJcmV0dXJuOworCisJaWYgKEFERFJfQUZURVJfTkVYVCgqbmV3
X2FkZHIgKyAqbGVuLCBuZXcpKQorCQlyZXR1cm47CisKKwkvKiBNdXR1YWwgYWxpZ25tZW50IG1l
YW5zIHRoaXMgaXMgc2FtZSBmb3IgbmV3L29sZCBhZGRyICovCisJKmxlbiA9IEFMSUdOKCpuZXdf
YWRkciArICpsZW4sIFBNRF9TSVpFKSAtICpuZXdfYWRkcjsKK30KKworLyoKKyAqIFRoZSBQTUQg
bW92ZSBjYXNlIGlzIG11Y2ggbW9yZSBlZmZpY2llbnQsIHNvIGlmIHdlIGhhdmUgdGhlCisgKiBt
dXR1YWxseSBhbGlnbmVkIGNhc2UsIHRyeSB0byBzZWUgaWYgd2UgY2FuIGV4dGVuZCB0aGUKKyAq
IGJlZ2lubmluZyBhbmQgZW5kIHRvIGJlIGFsaWduZWQgdG9vLgorICoKKyAqIFRoZSBwb2ludGVy
IGRlcmVmZXJlbmNlcyBsb29rIGJhZCwgYnV0IHdpdGggaW5saW5pbmcsIHRoZQorICogY29tcGls
ZXIgd2lsbCBzb3J0IGl0IG91dC4KKyAqLworc3RhdGljIGlubGluZSB2b2lkIHRyeV90b19hbGln
bl9yYW5nZSh1bnNpZ25lZCBsb25nICpsZW4sCisJc3RydWN0IHZtX2FyZWFfc3RydWN0ICpvbGQs
IHVuc2lnbmVkIGxvbmcgKm9sZF9hZGRyLAorCXN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqbmV3LCB1
bnNpZ25lZCBsb25nICpuZXdfYWRkcikKK3sKKwlpZiAoKCpvbGRfYWRkciBeICpuZXdfYWRkcikg
JiB+UE1EX01BU0spCisJCXJldHVybjsKKworCXRyeV90b19hbGlnbl9zdGFydChsZW4sIG9sZCwg
b2xkX2FkZHIsIG5ldywgbmV3X2FkZHIpOworCXRyeV90b19hbGlnbl9lbmQobGVuLCBvbGQsIG9s
ZF9hZGRyLCBuZXcsIG5ld19hZGRyKTsKK30KKyNlbHNlCisjZGVmaW5lIHRyeV90b19hbGlnbl9y
YW5nZShsZW4sb2xkLG9sZGEsbmV3LG5ld2EpIGRvIHsgfSB3aGlsZSgwKTsKICNlbmRpZgogCiB1
bnNpZ25lZCBsb25nIG1vdmVfcGFnZV90YWJsZXMoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEs
CkBAIC0yNTMsNiArMzE4LDggQEAgdW5zaWduZWQgbG9uZyBtb3ZlX3BhZ2VfdGFibGVzKHN0cnVj
dCB2bV9hcmVhX3N0cnVjdCAqdm1hLAogCQkJCW9sZF9hZGRyLCBvbGRfZW5kKTsKIAltbXVfbm90
aWZpZXJfaW52YWxpZGF0ZV9yYW5nZV9zdGFydCgmcmFuZ2UpOwogCisJdHJ5X3RvX2FsaWduX3Jh
bmdlKCZsZW4sIHZtYSwgJm9sZF9hZGRyLCBuZXdfdm1hLCAmbmV3X2FkZHIpOworCiAJZm9yICg7
IG9sZF9hZGRyIDwgb2xkX2VuZDsgb2xkX2FkZHIgKz0gZXh0ZW50LCBuZXdfYWRkciArPSBleHRl
bnQpIHsKIAkJY29uZF9yZXNjaGVkKCk7CiAJCW5leHQgPSAob2xkX2FkZHIgKyBQTURfU0laRSkg
JiBQTURfTUFTSzsK
--000000000000bd913e05aa81cf94--
