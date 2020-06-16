Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1BEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91C90207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592333739;
	bh=IsdzgXrYkW06ZRsfIxA8YgHQt63UhViFakKJYKfyV+s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UGGzk6je8HTOE1jOuJx+3Tit0F/+2xd4WURZr0ovA5AbqHLsrmtZ8OkVhzuePyMsB
	 TiUQpEzersSUChRK/S/k3GyyoGNiRqNPer2UzJtlS63MW3d2OskZwLodoJndQn7qFn
	 Wt5XHA+C1849caxIernSeiV3anrB/y1sSwxFyW6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbgFPSzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgFPSzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:55:37 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C6EC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 11:55:37 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id d7so12392314lfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 11:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q0q8gubf8krgZV8oGCJJ77Manwa2gcrwHgDVVcoIMF4=;
        b=Za9iu2csZgttP35aE+aT08tNb3V6uxoyuIhn76uFapZGtiQBoNJQlm46x1X88modKX
         56L73dqUCWnkD91z+9cqMwv5Y5xo/wgnVPwKoQqgiOz23E0vmPXaA37iu5082TSSxz11
         OBgSNYHUnDL9NHnY2O/1eCVT5xkEIS6vHlrTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q0q8gubf8krgZV8oGCJJ77Manwa2gcrwHgDVVcoIMF4=;
        b=k4m0tQ++FHNaVWGwgQ7w2Ddf08HF9Mt6IBH9QfquH/2r5jJyj3sYQiXSxbelrgTOb+
         Z1nV1n5YwWtZTnCfhMcGYBWeTTSUwkhuJjZSKNEw4dtSGX7LuDKwqPJA+XUwSQImbi7B
         hSH8stHRO3eta4FoaL9ozQFAVHBq/N0J2Nl4fuT9L6xnyYhsi/r1QLto/sqUxfvfuxEC
         LthZsbhIBwa/i2+4UfnhuMa+3Tgh/bMT9MUiDun22rSN/lf0xuxlt5XneI3+YLvhFwzj
         mdOApobLlcR4hYQPOZ46sEYrlhr8lnK8kDzkYKbDnPB1ZZdPvJS1pPzd98ZQqp6S7kBF
         /JAQ==
X-Gm-Message-State: AOAM533xNamfCVwiwjWN0eUSnm2/DTKfwxyfCvSYlIwYzGZmGG5M7qmc
        CYHj6gosi550ZtEk5u0om0weRxabTdw=
X-Google-Smtp-Source: ABdhPJzD7If6nG1sjDWX1/pnHOwnxyv+n64Z7ClQTcxWgOO/JjVl4Z06NRy0rtJZCi55NznJClNKwQ==
X-Received: by 2002:ac2:48a6:: with SMTP id u6mr2404776lfg.49.1592333735576;
        Tue, 16 Jun 2020 11:55:35 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id y3sm4547970ljk.39.2020.06.16.11.55.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 11:55:34 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id q19so24896772lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 11:55:34 -0700 (PDT)
X-Received: by 2002:a2e:97c3:: with SMTP id m3mr2263094ljj.312.1592333733916;
 Tue, 16 Jun 2020 11:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200615221607.7764-1-peterx@redhat.com>
In-Reply-To: <20200615221607.7764-1-peterx@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 Jun 2020 11:55:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiTjaXHu+uxMi0xCZQOm4KVr0MucECAK=Zm4p4YZZ1XEg@mail.gmail.com>
Message-ID: <CAHk-=wiTjaXHu+uxMi0xCZQOm4KVr0MucECAK=Zm4p4YZZ1XEg@mail.gmail.com>
Subject: Re: [PATCH 00/25] mm: Page fault accounting cleanups
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        openrisc@lists.librecores.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="00000000000093703c05a8381612"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000093703c05a8381612
Content-Type: text/plain; charset="UTF-8"

On Mon, Jun 15, 2020 at 3:16 PM Peter Xu <peterx@redhat.com> wrote:
>
> This series tries to address all of them by introducing mm_fault_accounting()
> first, so that we move all the page fault accounting into the common code base,
> then call it properly from arch pf handlers just like handle_mm_fault().

Hmm.

So having looked at this a bit more, I'd actually like to go even
further, and just get rid of the per-architecture code _entirely_.

Here's a straw-man patch to the generic code - the idea is mostly laid
out in the comment that I'm just quoting here directly too:

        /*
         * Do accounting in the common code, to avoid unnecessary
         * architecture differences or duplicated code.
         *
         * We arbitrarily make the rules be:
         *
         *  - faults that never even got here (because the address
         *    wasn't valid). That includes arch_vma_access_permitted()
         *    failing above.
         *
         *    So this is expressly not a "this many hardware page
         *    faults" counter. Use the hw profiling for that.
         *
         *  - incomplete faults (ie RETRY) do not count (see above).
         *    They will only count once completed.
         *
         *  - the fault counts as a "major" fault when the final
         *    successful fault is VM_FAULT_MAJOR, or if it was a
         *    retry (which implies that we couldn't handle it
         *    immediately previously).
         *
         *  - if the fault is done for GUP, regs wil be NULL and
         *    no accounting will be done (but you _could_ pass in
         *    your own regs and it would be accounted to the thread
         *    doing the fault, not to the target!)
         */

the code itself in the patch is

 (a) pretty trivial and self-evident

 (b) INCOMPLETE

that (b) is worth noting: this patch won't compile on its own. It
intentionally leaves all the users without the new 'regs' argument,
because you obviously simply need to remove all the code that
currently tries to do any accounting.

Comments?

This is a bigger change, but I think it might be worth it to _really_
consolidate the major/minor logic.

One detail worth noting: I do wonder if we should put the

    perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);

just in the arch code at the top of the fault handling, and consider
it entirely unrelated to the major/minor fault handling. The
major/minor faults fundamnetally are about successes. But the plain
PERF_COUNT_SW_PAGE_FAULTS could be about things that fail, including
things that never even get to this point at all.

I'm not convinced it's useful to have three SW events that are defined
to be A=B+C.

But this does *not* do that part. It' sreally just an RFC patch.

                    Linus

--00000000000093703c05a8381612
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kbiacfcm0>
X-Attachment-Id: f_kbiacfcm0

IGluY2x1ZGUvbGludXgvbW0uaCB8ICAzICsrLQogbW0vbWVtb3J5LmMgICAgICAgIHwgNDYgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQogMiBmaWxlcyBjaGFu
Z2VkLCA0NyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvbW0uaCBiL2luY2x1ZGUvbGludXgvbW0uaAppbmRleCBkYzdiODczMTBjMTAuLmU4
MmE2MDQzMzljMCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9tbS5oCisrKyBiL2luY2x1ZGUv
bGludXgvbW0uaApAQCAtMTY0OCw3ICsxNjQ4LDggQEAgaW50IGludmFsaWRhdGVfaW5vZGVfcGFn
ZShzdHJ1Y3QgcGFnZSAqcGFnZSk7CiAKICNpZmRlZiBDT05GSUdfTU1VCiBleHRlcm4gdm1fZmF1
bHRfdCBoYW5kbGVfbW1fZmF1bHQoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsCi0JCQl1bnNp
Z25lZCBsb25nIGFkZHJlc3MsIHVuc2lnbmVkIGludCBmbGFncyk7CisJCQl1bnNpZ25lZCBsb25n
IGFkZHJlc3MsIHVuc2lnbmVkIGludCBmbGFncywKKwkJCXN0cnVjdCBwdF9yZWdzICopOwogZXh0
ZXJuIGludCBmaXh1cF91c2VyX2ZhdWx0KHN0cnVjdCB0YXNrX3N0cnVjdCAqdHNrLCBzdHJ1Y3Qg
bW1fc3RydWN0ICptbSwKIAkJCSAgICB1bnNpZ25lZCBsb25nIGFkZHJlc3MsIHVuc2lnbmVkIGlu
dCBmYXVsdF9mbGFncywKIAkJCSAgICBib29sICp1bmxvY2tlZCk7CmRpZmYgLS1naXQgYS9tbS9t
ZW1vcnkuYyBiL21tL21lbW9yeS5jCmluZGV4IGRjN2YzNTQzYjFmZC4uZjE1MDU2MTUxZmIxIDEw
MDY0NAotLS0gYS9tbS9tZW1vcnkuYworKysgYi9tbS9tZW1vcnkuYwpAQCAtNzIsNiArNzIsNyBA
QAogI2luY2x1ZGUgPGxpbnV4L29vbS5oPgogI2luY2x1ZGUgPGxpbnV4L251bWEuaD4KIAorI2lu
Y2x1ZGUgPGxpbnV4L3BlcmZfZXZlbnQuaD4KICNpbmNsdWRlIDx0cmFjZS9ldmVudHMva21lbS5o
PgogCiAjaW5jbHVkZSA8YXNtL2lvLmg+CkBAIC00MzUzLDcgKzQzNTQsNyBAQCBzdGF0aWMgdm1f
ZmF1bHRfdCBfX2hhbmRsZV9tbV9mYXVsdChzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwKICAq
IHJldHVybiB2YWx1ZS4gIFNlZSBmaWxlbWFwX2ZhdWx0KCkgYW5kIF9fbG9ja19wYWdlX29yX3Jl
dHJ5KCkuCiAgKi8KIHZtX2ZhdWx0X3QgaGFuZGxlX21tX2ZhdWx0KHN0cnVjdCB2bV9hcmVhX3N0
cnVjdCAqdm1hLCB1bnNpZ25lZCBsb25nIGFkZHJlc3MsCi0JCXVuc2lnbmVkIGludCBmbGFncykK
KwkJdW5zaWduZWQgaW50IGZsYWdzLCBzdHJ1Y3QgcHRfcmVncyAqcmVncykKIHsKIAl2bV9mYXVs
dF90IHJldDsKIApAQCAtNDM5NCw2ICs0Mzk1LDQ5IEBAIHZtX2ZhdWx0X3QgaGFuZGxlX21tX2Zh
dWx0KHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCB1bnNpZ25lZCBsb25nIGFkZHJlc3MsCiAJ
CQltZW1fY2dyb3VwX29vbV9zeW5jaHJvbml6ZShmYWxzZSk7CiAJfQogCisJaWYgKHJldCAmIFZN
X0ZBVUxUX1JFVFJZKQorCQlyZXR1cm4gcmV0OworCisJLyoKKwkgKiBEbyBhY2NvdW50aW5nIGlu
IHRoZSBjb21tb24gY29kZSwgdG8gYXZvaWQgdW5uZWNlc3NhcnkKKwkgKiBhcmNoaXRlY3R1cmUg
ZGlmZmVyZW5jZXMgb3IgZHVwbGljYXRlZCBjb2RlLgorCSAqCisJICogV2UgYXJiaXRyYXJpbHkg
bWFrZSB0aGUgcnVsZXMgYmU6CisJICoKKwkgKiAgLSBmYXVsdHMgdGhhdCBuZXZlciBldmVuIGdv
dCBoZXJlIChiZWNhdXNlIHRoZSBhZGRyZXNzCisJICogICAgd2Fzbid0IHZhbGlkKS4gVGhhdCBp
bmNsdWRlcyBhcmNoX3ZtYV9hY2Nlc3NfcGVybWl0dGVkKCkKKwkgKiAgICBmYWlsaW5nIGFib3Zl
LgorCSAqCisJICogICAgU28gdGhpcyBpcyBleHByZXNzbHkgbm90IGEgInRoaXMgbWFueSBoYXJk
d2FyZSBwYWdlCisJICogICAgZmF1bHRzIiBjb3VudGVyLiBVc2UgdGhlIGh3IHByb2ZpbGluZyBm
b3IgdGhhdC4KKwkgKgorCSAqICAtIGluY29tcGxldGUgZmF1bHRzIChpZSBSRVRSWSkgZG8gbm90
IGNvdW50IChzZWUgYWJvdmUpLgorCSAqICAgIFRoZXkgd2lsbCBvbmx5IGNvdW50IG9uY2UgY29t
cGxldGVkLgorCSAqCisJICogIC0gdGhlIGZhdWx0IGNvdW50cyBhcyBhICJtYWpvciIgZmF1bHQg
d2hlbiB0aGUgZmluYWwKKwkgKiAgICBzdWNjZXNzZnVsIGZhdWx0IGlzIFZNX0ZBVUxUX01BSk9S
LCBvciBpZiBpdCB3YXMgYQorCSAqICAgIHJldHJ5ICh3aGljaCBpbXBsaWVzIHRoYXQgd2UgY291
bGRuJ3QgaGFuZGxlIGl0CisJICogICAgaW1tZWRpYXRlbHkgcHJldmlvdXNseSkuCisJICoKKwkg
KiAgLSBpZiB0aGUgZmF1bHQgaXMgZG9uZSBmb3IgR1VQLCByZWdzIHdpbCBiZSBOVUxMIGFuZAor
CSAqICAgIG5vIGFjY291bnRpbmcgd2lsbCBiZSBkb25lIChidXQgeW91IF9jb3VsZF8gcGFzcyBp
bgorCSAqICAgIHlvdXIgb3duIHJlZ3MgYW5kIGl0IHdvdWxkIGJlIGFjY291bnRlZCB0byB0aGUg
dGhyZWFkCisJICogICAgZG9pbmcgdGhlIGZhdWx0LCBub3QgdG8gdGhlIHRhcmdldCEpCisJICov
CisKKwlpZiAoIXJlZ3MpCisJCXJldHVybiByZXQ7CisKKwlwZXJmX3N3X2V2ZW50KFBFUkZfQ09V
TlRfU1dfUEFHRV9GQVVMVFMsIDEsIHJlZ3MsIGFkZHJlc3MpOworCisJaWYgKChyZXQgJiBWTV9G
QVVMVF9NQUpPUikgfHwgKGZsYWdzICYgRkFVTFRfRkxBR19UUklFRCkpIHsKKwkJY3VycmVudC0+
bWFqX2ZsdCsrOworCQlwZXJmX3N3X2V2ZW50KFBFUkZfQ09VTlRfU1dfUEFHRV9GQVVMVFNfTUFK
LCAxLCByZWdzLCBhZGRyZXNzKTsKKwl9IGVsc2UgeworCQljdXJyZW50LT5taW5fZmx0Kys7CisJ
CXBlcmZfc3dfZXZlbnQoUEVSRl9DT1VOVF9TV19QQUdFX0ZBVUxUU19NSU4sIDEsIHJlZ3MsIGFk
ZHJlc3MpOworCX0KKwogCXJldHVybiByZXQ7CiB9CiBFWFBPUlRfU1lNQk9MX0dQTChoYW5kbGVf
bW1fZmF1bHQpOwo=
--00000000000093703c05a8381612--
