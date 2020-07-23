Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBA0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D819D2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595531007;
	bh=95Cx8PVQmuMOcXGWQmEyOGXQgeEjIOzao4CDf62dkM0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=f5cxkoyHQjdVILY+YypwgnC+98M3ooJ0TESS6RxSZBY3k2iLfqdJl2SiVXnaJgmvx
	 FOMBkhrmEXpAgRwroO49kQvVkEhmdNBOFT8SOCtDtOpPFA357MS5/PascZq9tgT/hG
	 yvBjEe5l6eCntwr/5GFIEVm3U4rW3Dt30nbBZrC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgGWTD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 15:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgGWTD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 15:03:26 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE40C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 12:03:24 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id j11so7498294ljo.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 12:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fJhkw4LjVZC2fyF4ODxc6PhVc1AqEdr3YS0LDTexCFA=;
        b=Seq9CxBfDQO7Rx1dVy7lFNVwlCIJxvuPh/aneAJa0JWE3qkG9y3x7j0f7VuJIkQbe1
         sFXRqqEUciBv73M58wAONE5hvM8NzHxANSpxsw6CC0Q0sj0HhHVAhZ40gxJak5lu22EX
         /wTgTpiUDuDoZLp7OcgEH56jueRbtXtXG2p44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fJhkw4LjVZC2fyF4ODxc6PhVc1AqEdr3YS0LDTexCFA=;
        b=PsHVD+o8G1UHwsTLHXIEfLK8YF5FEo4KI9Cpz962mBRBINfCscy7+wS6i8KXIFW6bw
         hebO5CUektbQWP70YpQL+MPl8DcBQ6qLe0ZEpui703eqQzJ2GGX6oC3HZZ7Xd8E5f+vG
         yFxBvDnakKY1gTFBcRUuLbHsOBoVHekvn5AvnbzC9qpIhyaTZs2fyOBR9zhrIlqLUAWA
         wPIMGe0qvoNC0/TROSi9z/OB8efP7EWSEg9pO6FRjTqB4LPbwElqsjKBpPlgI5U9YXXr
         l3PlDPH2HDXIZkplacg2g8TPwCYjG3EAsPZS2ZicVHGCL1HEf7NNTL57e1BzxGLkdZXp
         0/BQ==
X-Gm-Message-State: AOAM5336iToz8fdF28XOC4vYBvu9/Qt3uy2RlpDAgJbTjBfb4oKy3TaP
        2y1D8Q2SIOgjI0RLKSk8vXH/meA8k74=
X-Google-Smtp-Source: ABdhPJzPS+zbVX05cHf+B+kHkd1s5fcvc17OZUuINeF+jVFXmyi/9PdV7HvBlD+ZrLyBWkhkGHyifA==
X-Received: by 2002:a2e:9a82:: with SMTP id p2mr2622410lji.129.1595531002782;
        Thu, 23 Jul 2020 12:03:22 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id j66sm3285388lfd.74.2020.07.23.12.03.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2020 12:03:21 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id l19so1093086lfh.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 12:03:20 -0700 (PDT)
X-Received: by 2002:a05:6512:241:: with SMTP id b1mr2969280lfo.125.1595531000293;
 Thu, 23 Jul 2020 12:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200721063258.17140-1-mhocko@kernel.org> <CAHk-=whewL14RgwLZTXcNAnrDPt0H+sRJS6iDq0oGb6zwaBMxg@mail.gmail.com>
 <CAHk-=whb0=rjc1WR+F_r_syw5Ld4=ebuNJmmpaPEzfjZRD5Y-w@mail.gmail.com>
 <alpine.LSU.2.11.2007221359450.1017@eggly.anvils> <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com>
 <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com>
 <20200723124749.GA7428@redhat.com> <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com>
 <20200723180100.GA21755@redhat.com> <CAHk-=wj9KWfs799xU5eW0J_hkee52C5kvFFmBV-A+vN7qNWnjA@mail.gmail.com>
In-Reply-To: <CAHk-=wj9KWfs799xU5eW0J_hkee52C5kvFFmBV-A+vN7qNWnjA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Jul 2020 12:03:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg=zqJ69JH3S9Ux0XKwZzjKqBP+ruLrmjW6NbNrpMuBNw@mail.gmail.com>
Message-ID: <CAHk-=wg=zqJ69JH3S9Ux0XKwZzjKqBP+ruLrmjW6NbNrpMuBNw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: multipart/mixed; boundary="000000000000805f8005ab208298"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000805f8005ab208298
Content-Type: text/plain; charset="UTF-8"

On Thu, Jul 23, 2020 at 11:22 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I think that is a separate issue, generic to our finish_wait() uses.

IOW, I think we should do something like this (this is on top of my
patch, since it has that wake_page_function() change in it, but notice
how we have the exact same issue in our traditional
autoremove_wake_function() usage).

Comments?

                   Linus

--000000000000805f8005ab208298
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kcz5y2bf0>
X-Attachment-Id: f_kcz5y2bf0

IGluY2x1ZGUvbGludXgvbGlzdC5oIHwgMjAgKysrKysrKysrKysrKysrKysrKy0KIGtlcm5lbC9z
Y2hlZC93YWl0LmMgIHwgIDIgKy0KIG1tL2ZpbGVtYXAuYyAgICAgICAgIHwgIDcgKy0tLS0tLQog
MyBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvbGlzdC5oIGIvaW5jbHVkZS9saW51eC9saXN0LmgKaW5kZXgg
YWZmNDRkMzRmNGU0Li4wZDBkMTdhMTBkMjUgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvbGlz
dC5oCisrKyBiL2luY2x1ZGUvbGludXgvbGlzdC5oCkBAIC0yODIsNiArMjgyLDI0IEBAIHN0YXRp
YyBpbmxpbmUgaW50IGxpc3RfZW1wdHkoY29uc3Qgc3RydWN0IGxpc3RfaGVhZCAqaGVhZCkKIAly
ZXR1cm4gUkVBRF9PTkNFKGhlYWQtPm5leHQpID09IGhlYWQ7CiB9CiAKKy8qKgorICogbGlzdF9k
ZWxfaW5pdF9jYXJlZnVsIC0gZGVsZXRlcyBlbnRyeSBmcm9tIGxpc3QgYW5kIHJlaW5pdGlhbGl6
ZSBpdC4KKyAqIEBlbnRyeTogdGhlIGVsZW1lbnQgdG8gZGVsZXRlIGZyb20gdGhlIGxpc3QuCisg
KgorICogVGhpcyBpcyB0aGUgc2FtZSBhcyBsaXN0X2RlbF9pbml0KCksIGV4Y2VwdCBkZXNpZ25l
ZCB0byBiZSB1c2VkCisgKiB0b2dldGhlciB3aXRoIGxpc3RfZW1wdHlfY2FyZWZ1bCgpIGluIGEg
d2F5IHRvIGd1YXJhbnRlZSBvcmRlcmluZworICogb2Ygb3RoZXIgbWVtb3J5IG9wZXJhdGlvbnMu
CisgKgorICogQW55IG1lbW9yeSBvcGVyYXRpb25zIGRvbmUgYmVmb3JlIGEgbGlzdF9kZWxfaW5p
dF9jYXJlZnVsKCkgYXJlCisgKiBndWFyYW50ZWVkIHRvIGJlIHZpc2libGUgYWZ0ZXIgYSBsaXN0
X2VtcHR5X2NhcmVmdWwoKSB0ZXN0LgorICovCitzdGF0aWMgaW5saW5lIHZvaWQgbGlzdF9kZWxf
aW5pdF9jYXJlZnVsKHN0cnVjdCBsaXN0X2hlYWQgKmVudHJ5KQoreworCV9fbGlzdF9kZWxfZW50
cnkoZW50cnkpOworCWVudHJ5LT5wcmV2ID0gZW50cnk7CisJc21wX3N0b3JlX3JlbGVhc2UoJmVu
dHJ5LT5uZXh0LCBlbnRyeSk7Cit9CisKIC8qKgogICogbGlzdF9lbXB0eV9jYXJlZnVsIC0gdGVz
dHMgd2hldGhlciBhIGxpc3QgaXMgZW1wdHkgYW5kIG5vdCBiZWluZyBtb2RpZmllZAogICogQGhl
YWQ6IHRoZSBsaXN0IHRvIHRlc3QKQEAgLTI5Nyw3ICszMTUsNyBAQCBzdGF0aWMgaW5saW5lIGlu
dCBsaXN0X2VtcHR5KGNvbnN0IHN0cnVjdCBsaXN0X2hlYWQgKmhlYWQpCiAgKi8KIHN0YXRpYyBp
bmxpbmUgaW50IGxpc3RfZW1wdHlfY2FyZWZ1bChjb25zdCBzdHJ1Y3QgbGlzdF9oZWFkICpoZWFk
KQogewotCXN0cnVjdCBsaXN0X2hlYWQgKm5leHQgPSBoZWFkLT5uZXh0OworCXN0cnVjdCBsaXN0
X2hlYWQgKm5leHQgPSBzbXBfbG9hZF9hY3F1aXJlKCZoZWFkLT5uZXh0KTsKIAlyZXR1cm4gKG5l
eHQgPT0gaGVhZCkgJiYgKG5leHQgPT0gaGVhZC0+cHJldik7CiB9CiAKZGlmZiAtLWdpdCBhL2tl
cm5lbC9zY2hlZC93YWl0LmMgYi9rZXJuZWwvc2NoZWQvd2FpdC5jCmluZGV4IGJhMDU5ZmJmYzUz
YS4uMDFmNWQzMDIwNTg5IDEwMDY0NAotLS0gYS9rZXJuZWwvc2NoZWQvd2FpdC5jCisrKyBiL2tl
cm5lbC9zY2hlZC93YWl0LmMKQEAgLTM4OSw3ICszODksNyBAQCBpbnQgYXV0b3JlbW92ZV93YWtl
X2Z1bmN0aW9uKHN0cnVjdCB3YWl0X3F1ZXVlX2VudHJ5ICp3cV9lbnRyeSwgdW5zaWduZWQgbW9k
ZSwgaQogCWludCByZXQgPSBkZWZhdWx0X3dha2VfZnVuY3Rpb24od3FfZW50cnksIG1vZGUsIHN5
bmMsIGtleSk7CiAKIAlpZiAocmV0KQotCQlsaXN0X2RlbF9pbml0KCZ3cV9lbnRyeS0+ZW50cnkp
OworCQlsaXN0X2RlbF9pbml0X2NhcmVmdWwoJndxX2VudHJ5LT5lbnRyeSk7CiAKIAlyZXR1cm4g
cmV0OwogfQpkaWZmIC0tZ2l0IGEvbW0vZmlsZW1hcC5jIGIvbW0vZmlsZW1hcC5jCmluZGV4IDM3
ZjY0MmMwNzEwNi4uZTFiZDVmZTA0MDZkIDEwMDY0NAotLS0gYS9tbS9maWxlbWFwLmMKKysrIGIv
bW0vZmlsZW1hcC5jCkBAIC0xMDQwLDEzICsxMDQwLDggQEAgc3RhdGljIGludCB3YWtlX3BhZ2Vf
ZnVuY3Rpb24od2FpdF9xdWV1ZV9lbnRyeV90ICp3YWl0LCB1bnNpZ25lZCBtb2RlLCBpbnQgc3lu
YywKIAkgKiBzaW5jZSBhZnRlciBsaXN0X2RlbF9pbml0KCZ3YWl0LT5lbnRyeSkgdGhlIHdhaXQg
ZW50cnkKIAkgKiBtaWdodCBiZSBkZS1hbGxvY2F0ZWQgYW5kIHRoZSBwcm9jZXNzIG1pZ2h0IGV2
ZW4gaGF2ZQogCSAqIGV4aXRlZC4KLQkgKgotCSAqIFdlIF9yZWFsbHlfIHNob3VsZCBoYXZlIGEg
Imxpc3RfZGVsX2luaXRfY2FyZWZ1bCgpIiB0bwotCSAqIHByb3Blcmx5IHBhaXIgd2l0aCB0aGUg
dW5sb2NrZWQgImxpc3RfZW1wdHlfY2FyZWZ1bCgpIgotCSAqIGluIGZpbmlzaF93YWl0KCkuCiAJ
ICovCi0Jc21wX21iKCk7Ci0JbGlzdF9kZWxfaW5pdCgmd2FpdC0+ZW50cnkpOworCWxpc3RfZGVs
X2luaXRfY2FyZWZ1bCgmd2FpdC0+ZW50cnkpOwogCXJldHVybiByZXQ7CiB9CiAK
--000000000000805f8005ab208298--
