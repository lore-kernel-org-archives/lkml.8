Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468D2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C3DB20792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595547811;
	bh=syj7w1tMq7GxefHZVmf6T0YjQVyq7HOBsl+kZLrCvh8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Y0zFupZhRyO89WR/fUn4EEFjv2GQkDee++PNJWGbSR4jw3NlwA8gg2PZ3PJvrT9bQ
	 fikUTf98EvvY3Zwd5rH+3ijnCpuw+02duOB6UnSvqa6QX3vTU5Yv/zGDSVaNx/0uyb
	 QMbYtUP5pvyTcF8HoBGF6ChhxFsbhAuAoO0XOGu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgGWXn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 19:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgGWXn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 19:43:29 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD722C0619D3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 16:43:28 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 140so4238838lfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 16:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7V/kDihgL5kEC4lQSCSY3jEHwZPrFwJNpyNc4Cr/ySQ=;
        b=aRSf+xLIu4Y/vCn7qDLq71u/ubEYET8Rf4RKodJV13afaOPSHdMUSqkPmn9t0HVwrD
         b4wqq0HG80AjQARZNArZLDzkQpxmeI2nVK1+/b/fc5R8U2JxvxJDLdt4W49tv/+3UpZw
         fpPPhpjyMb262XAMeCKI2kb7aMfTCpQiOhQs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7V/kDihgL5kEC4lQSCSY3jEHwZPrFwJNpyNc4Cr/ySQ=;
        b=GyHDyeuM9AZFAqxYxA6Y7hi8YEQPaxiYcX7Q5UqWm5RTUa1GIlnvKCFjg5Pcl4rUBy
         3fCsz9sGCP/lBRCoFPnBLWmg5cMAvO5U0e3D6CnBOmcLfSkZfqcAUB7b3JBgueUTxXw4
         FxrbWdz7l7CaZSzCypO6yq4SSXeYB7baKhlGR2j4c3owVPeBroqTwK7bVnfR4Kqck/Sh
         AXG2emgDyBcTzF9K9nbrBxwycUhsL+3q/IlJBD01s50MZjQe76zRUsAD/d6KtMZTHi3k
         K7WNiOyFQdI+ajDRDgTV/QWKuyht1bAFL7wfe4kaPC8hV6VenNQN5/6QJSSMlf9Nex/1
         ugKw==
X-Gm-Message-State: AOAM532wisHUbQfQjSaj2jHvBDwCETVtrGFw6eIChrFLEtqDQ4YfjdTi
        XRIiG+I810jjQDRPeSssx7gr6+2fuMo=
X-Google-Smtp-Source: ABdhPJzRo4wFmrc3MOHaZB1HFAiXg4ro4w3iEmvsUo1cm2rEnn4P2Xr/ZcyL2ym6WBxSVU4BcEhwkg==
X-Received: by 2002:a19:e009:: with SMTP id x9mr3551861lfg.11.1595547806944;
        Thu, 23 Jul 2020 16:43:26 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id u5sm3526671lfm.81.2020.07.23.16.43.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2020 16:43:25 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id h19so8141439ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 16:43:25 -0700 (PDT)
X-Received: by 2002:a2e:999a:: with SMTP id w26mr2920466lji.371.1595547805242;
 Thu, 23 Jul 2020 16:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200721063258.17140-1-mhocko@kernel.org> <CAHk-=whewL14RgwLZTXcNAnrDPt0H+sRJS6iDq0oGb6zwaBMxg@mail.gmail.com>
 <CAHk-=whb0=rjc1WR+F_r_syw5Ld4=ebuNJmmpaPEzfjZRD5Y-w@mail.gmail.com>
 <alpine.LSU.2.11.2007221359450.1017@eggly.anvils> <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com>
 <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com>
 <20200723124749.GA7428@redhat.com> <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com>
 <CAHk-=whQK3OGwExTzCrwwvuuVaQAgs8KsR-Yv8m1BmXoNZZ=jQ@mail.gmail.com> <alpine.LSU.2.11.2007231549540.1016@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2007231549540.1016@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Jul 2020 16:43:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgvGOnMF0ePU4xS236bOsP8jouj3rps+ysCaGXvCjh2Dg@mail.gmail.com>
Message-ID: <CAHk-=wgvGOnMF0ePU4xS236bOsP8jouj3rps+ysCaGXvCjh2Dg@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
To:     Hugh Dickins <hughd@google.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: multipart/mixed; boundary="00000000000027ca3205ab246ca4"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000027ca3205ab246ca4
Content-Type: text/plain; charset="UTF-8"

On Thu, Jul 23, 2020 at 4:11 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Thu, 23 Jul 2020, Linus Torvalds wrote:
> >
> > I'll send a new version after I actually test it.
>
> I'll give it a try when you're happy with it.

Ok, what I described is what I've been running for a while now. But I
don't put much stress on my system with my normal workload, so..

> I did try yesterday's
> with my swapping loads on home machines (3 of 4 survived 16 hours),
> and with some google stresstests on work machines (0 of 10 survived).
>
> I've not spent long analyzing the crashes, all of them in or below
> __wake_up_common() called from __wake_up_locked_key_bookmark():
> sometimes gets to run the curr->func() and crashes on something
> inside there (often list_del's lib/list_debug.c:53!), sometimes
> cannot get that far. Looks like the wait queue entries on the list
> were not entirely safe with that patch.

Hmm. The bug Oleg pointed out should be pretty theoretical. But I
think the new approach with WQ_FLAG_WOKEN was much better anyway,
despite me missing that one spot in the first version of the patch.

So here's two patches - the first one does that wake_page_function()
conversion, and the second one just does the memory ordering cleanup I
mentioned.

I don't think the second one shouldn't matter on x86, but who knows.

I don't enable list debugging, but I find list corruption surprising.
All of _that_ should be inside the page waiqueue lock, the only
unlocked part was the "list_empty_careful()" part.

But I'll walk over my patch mentally one more time. Here's the current
version, anyway.

                Linus

--00000000000027ca3205ab246ca4
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-mm-rewrite-wait_on_page_bit_common-logic.patch"
Content-Disposition: attachment; 
	filename="0001-mm-rewrite-wait_on_page_bit_common-logic.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kczftiv60>
X-Attachment-Id: f_kczftiv60

RnJvbSBjZjZkYjBiODU1NDcyM2YwMzA4ZmQ5Mjk5ZTY0Mjg5OGUzNmM5YzhjIE1vbiBTZXAgMTcg
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
IDxtaG9ja29Ac3VzZS5jb20+ClNpZ25lZC1vZmYtYnk6IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxk
c0BsaW51eC1mb3VuZGF0aW9uLm9yZz4KLS0tCiBtbS9maWxlbWFwLmMgfCAxMjEgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgNzMgaW5zZXJ0aW9ucygrKSwgNDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbW0vZmls
ZW1hcC5jIGIvbW0vZmlsZW1hcC5jCmluZGV4IDM4NTc1OWM0Y2U0Yi4uMTE0M2MwNjUyZDgxIDEw
MDY0NAotLS0gYS9tbS9maWxlbWFwLmMKKysrIGIvbW0vZmlsZW1hcC5jCkBAIC0xMDAyLDYgKzEw
MDIsNyBAQCBzdHJ1Y3Qgd2FpdF9wYWdlX3F1ZXVlIHsKIAogc3RhdGljIGludCB3YWtlX3BhZ2Vf
ZnVuY3Rpb24od2FpdF9xdWV1ZV9lbnRyeV90ICp3YWl0LCB1bnNpZ25lZCBtb2RlLCBpbnQgc3lu
Yywgdm9pZCAqYXJnKQogeworCWludCByZXQ7CiAJc3RydWN0IHdhaXRfcGFnZV9rZXkgKmtleSA9
IGFyZzsKIAlzdHJ1Y3Qgd2FpdF9wYWdlX3F1ZXVlICp3YWl0X3BhZ2UKIAkJPSBjb250YWluZXJf
b2Yod2FpdCwgc3RydWN0IHdhaXRfcGFnZV9xdWV1ZSwgd2FpdCk7CkBAIC0xMDEzLDE4ICsxMDE0
LDQwIEBAIHN0YXRpYyBpbnQgd2FrZV9wYWdlX2Z1bmN0aW9uKHdhaXRfcXVldWVfZW50cnlfdCAq
d2FpdCwgdW5zaWduZWQgbW9kZSwgaW50IHN5bmMsCiAJaWYgKHdhaXRfcGFnZS0+Yml0X25yICE9
IGtleS0+Yml0X25yKQogCQlyZXR1cm4gMDsKIAorCS8qIFN0b3Agd2Fsa2luZyBpZiBpdCdzIGxv
Y2tlZCAqLworCWlmICh3YWl0LT5mbGFncyAmIFdRX0ZMQUdfRVhDTFVTSVZFKSB7CisJCWlmICh0
ZXN0X2FuZF9zZXRfYml0KGtleS0+Yml0X25yLCAma2V5LT5wYWdlLT5mbGFncykpCisJCQlyZXR1
cm4gLTE7CisJfSBlbHNlIHsKKwkJaWYgKHRlc3RfYml0KGtleS0+Yml0X25yLCAma2V5LT5wYWdl
LT5mbGFncykpCisJCQlyZXR1cm4gLTE7CisJfQorCiAJLyoKLQkgKiBTdG9wIHdhbGtpbmcgaWYg
aXQncyBsb2NrZWQuCi0JICogSXMgdGhpcyBzYWZlIGlmIHB1dF9hbmRfd2FpdF9vbl9wYWdlX2xv
Y2tlZCgpIGlzIGluIHVzZT8KLQkgKiBZZXM6IHRoZSB3YWtlciBtdXN0IGhvbGQgYSByZWZlcmVu
Y2UgdG8gdGhpcyBwYWdlLCBhbmQgaWYgUEdfbG9ja2VkCi0JICogaGFzIG5vdyBhbHJlYWR5IGJl
ZW4gc2V0IGJ5IGFub3RoZXIgdGFzaywgdGhhdCB0YXNrIG11c3QgYWxzbyBob2xkCi0JICogYSBy
ZWZlcmVuY2UgdG8gdGhlICpzYW1lIHVzYWdlKiBvZiB0aGlzIHBhZ2U7IHNvIHRoZXJlIGlzIG5v
IG5lZWQKLQkgKiB0byB3YWxrIG9uIHRvIHdha2UgZXZlbiB0aGUgcHV0X2FuZF93YWl0X29uX3Bh
Z2VfbG9ja2VkKCkgY2FsbGVycy4KKwkgKiBMZXQgdGhlIHdhaXRlciBrbm93IHdlIGhhdmUgZG9u
ZSB0aGUgcGFnZSBmbGFnCisJICogaGFuZGxpbmcgZm9yIGl0IChhbmQgdGhlIHJldHVybiB2YWx1
ZSBsZXRzIHRoZQorCSAqIHdha2V1cCBsb2dpYyBjb3VudCBleGNsdXNpdmUgd2FrZXVwIGV2ZW50
cykuCiAJICovCi0JaWYgKHRlc3RfYml0KGtleS0+Yml0X25yLCAma2V5LT5wYWdlLT5mbGFncykp
Ci0JCXJldHVybiAtMTsKKwlyZXQgPSAod2FpdC0+ZmxhZ3MgJiBXUV9GTEFHX0VYQ0xVU0lWRSkg
IT0gMDsKKwl3YWl0LT5mbGFncyB8PSBXUV9GTEFHX1dPS0VOOworCXdha2VfdXBfc3RhdGUod2Fp
dC0+cHJpdmF0ZSwgbW9kZSk7CiAKLQlyZXR1cm4gYXV0b3JlbW92ZV93YWtlX2Z1bmN0aW9uKHdh
aXQsIG1vZGUsIHN5bmMsIGtleSk7CisJLyoKKwkgKiBPaywgd2UgaGF2ZSBzdWNjZXNzZnVsbHkg
ZG9uZSB3aGF0IHdlJ3JlIHdhaXRpbmcgZm9yLAorCSAqIGFuZCB3ZSBjYW4gdW5jb25kaXRpb25h
bGx5IHJlbW92ZSB0aGUgd2FpdCBlbnRyeS4KKwkgKgorCSAqIE5vdGUgdGhhdCB0aGlzIGhhcyB0
byBiZSB0aGUgYWJzb2x1dGUgbGFzdCB0aGluZyB3ZSBkbywKKwkgKiBzaW5jZSBhZnRlciBsaXN0
X2RlbF9pbml0KCZ3YWl0LT5lbnRyeSkgdGhlIHdhaXQgZW50cnkKKwkgKiBtaWdodCBiZSBkZS1h
bGxvY2F0ZWQgYW5kIHRoZSBwcm9jZXNzIG1pZ2h0IGV2ZW4gaGF2ZQorCSAqIGV4aXRlZC4KKwkg
KgorCSAqIFdlIF9yZWFsbHlfIHNob3VsZCBoYXZlIGEgImxpc3RfZGVsX2luaXRfY2FyZWZ1bCgp
IiB0bworCSAqIHByb3Blcmx5IHBhaXIgd2l0aCB0aGUgdW5sb2NrZWQgImxpc3RfZW1wdHlfY2Fy
ZWZ1bCgpIgorCSAqIGluIGZpbmlzaF93YWl0KCkuCisJICovCisJc21wX21iKCk7CisJbGlzdF9k
ZWxfaW5pdCgmd2FpdC0+ZW50cnkpOworCXJldHVybiByZXQ7CiB9CiAKIHN0YXRpYyB2b2lkIHdh
a2VfdXBfcGFnZV9iaXQoc3RydWN0IHBhZ2UgKnBhZ2UsIGludCBiaXRfbnIpCkBAIC0xMTAzLDE2
ICsxMTI2LDIyIEBAIGVudW0gYmVoYXZpb3IgewogCQkJICovCiB9OwogCitzdGF0aWMgaW5saW5l
IGludCB0cnlsb2NrX3BhZ2VfYml0X2NvbW1vbihzdHJ1Y3QgcGFnZSAqcGFnZSwgaW50IGJpdF9u
ciwKKwllbnVtIGJlaGF2aW9yIGJlaGF2aW9yKQoreworCXJldHVybiBiZWhhdmlvciA9PSBFWENM
VVNJVkUgPworCQkhdGVzdF9hbmRfc2V0X2JpdChiaXRfbnIsICZwYWdlLT5mbGFncykgOgorCQkh
dGVzdF9iaXQoYml0X25yLCAmcGFnZS0+ZmxhZ3MpOworfQorCiBzdGF0aWMgaW5saW5lIGludCB3
YWl0X29uX3BhZ2VfYml0X2NvbW1vbih3YWl0X3F1ZXVlX2hlYWRfdCAqcSwKIAlzdHJ1Y3QgcGFn
ZSAqcGFnZSwgaW50IGJpdF9uciwgaW50IHN0YXRlLCBlbnVtIGJlaGF2aW9yIGJlaGF2aW9yKQog
ewogCXN0cnVjdCB3YWl0X3BhZ2VfcXVldWUgd2FpdF9wYWdlOwogCXdhaXRfcXVldWVfZW50cnlf
dCAqd2FpdCA9ICZ3YWl0X3BhZ2Uud2FpdDsKLQlib29sIGJpdF9pc19zZXQ7CiAJYm9vbCB0aHJh
c2hpbmcgPSBmYWxzZTsKIAlib29sIGRlbGF5YWNjdCA9IGZhbHNlOwogCXVuc2lnbmVkIGxvbmcg
cGZsYWdzOwotCWludCByZXQgPSAwOwogCiAJaWYgKGJpdF9uciA9PSBQR19sb2NrZWQgJiYKIAkg
ICAgIVBhZ2VVcHRvZGF0ZShwYWdlKSAmJiBQYWdlV29ya2luZ3NldChwYWdlKSkgewpAQCAtMTEz
MCw0OCArMTE1OSw0NCBAQCBzdGF0aWMgaW5saW5lIGludCB3YWl0X29uX3BhZ2VfYml0X2NvbW1v
bih3YWl0X3F1ZXVlX2hlYWRfdCAqcSwKIAl3YWl0X3BhZ2UucGFnZSA9IHBhZ2U7CiAJd2FpdF9w
YWdlLmJpdF9uciA9IGJpdF9ucjsKIAorCS8qCisJICogQWRkIG91cnNlbHZlcyB0byB0aGUgd2Fp
dCBxdWV1ZS4KKwkgKgorCSAqIE5PVEUhIFRoaXMgaXMgd2hlcmUgd2UgYWxzbyBjaGVjayB0aGUg
cGFnZQorCSAqIHN0YXRlIHN5bmNocm9ub3VzbHkgdGhlIGxhc3QgdGltZSB0byBzZWUgdGhhdAor
CSAqIHNvbWVib2R5IGRpZG4ndCBqdXN0IGNsZWFyIHRoZSBiaXQuIERvIHRoZQorCSAqIFNldFBh
Z2VXYWl0ZXJzKCkgYmVmb3JlIHRoYXQgdG8gbGV0IGFueWJvZHkKKwkgKiB3ZSBqdXN0IG1pc3Mg
a25vdyB0aGV5IG5lZWQgdG8gd2FrZSB1cyB1cC4KKwkgKi8KKwlzcGluX2xvY2tfaXJxKCZxLT5s
b2NrKTsKKwlTZXRQYWdlV2FpdGVycyhwYWdlKTsKKwlpZiAoIXRyeWxvY2tfcGFnZV9iaXRfY29t
bW9uKHBhZ2UsIGJpdF9uciwgYmVoYXZpb3IpKQorCQlfX2FkZF93YWl0X3F1ZXVlX2VudHJ5X3Rh
aWwocSwgd2FpdCk7CisJZWxzZQorCQl3YWl0LT5mbGFncyB8PSBXUV9GTEFHX1dPS0VOOworCXNw
aW5fdW5sb2NrX2lycSgmcS0+bG9jayk7CisKKwkvKgorCSAqIEZyb20gbm93IG9uLCBhbGwgdGhl
IGxvZ2ljIHdpbGwgYmUgYmFzZWQgb24KKwkgKiB3aGV0aGVyIHRoZSB3YWl0IGVudHJ5IGlzIG9u
IHRoZSBxdWV1ZSBvciBub3QsCisJICogYW5kIHRoZSBwYWdlIGJpdCB0ZXN0aW5nIChhbmQgc2V0
dGluZykgd2lsbCBiZQorCSAqIGRvbmUgYnkgdGhlIHdha2UgZnVuY3Rpb24sIG5vdCB1cy4KKwkg
KgorCSAqIFdlIGNhbiBkcm9wIG91ciByZWZlcmVuY2UgdG8gdGhlIHBhZ2UuCisJICovCisJaWYg
KGJlaGF2aW9yID09IERST1ApCisJCXB1dF9wYWdlKHBhZ2UpOworCiAJZm9yICg7OykgewotCQlz
cGluX2xvY2tfaXJxKCZxLT5sb2NrKTsKLQotCQlpZiAobGlrZWx5KGxpc3RfZW1wdHkoJndhaXQt
PmVudHJ5KSkpIHsKLQkJCV9fYWRkX3dhaXRfcXVldWVfZW50cnlfdGFpbChxLCB3YWl0KTsKLQkJ
CVNldFBhZ2VXYWl0ZXJzKHBhZ2UpOwotCQl9Ci0KIAkJc2V0X2N1cnJlbnRfc3RhdGUoc3RhdGUp
OwogCi0JCXNwaW5fdW5sb2NrX2lycSgmcS0+bG9jayk7Ci0KLQkJYml0X2lzX3NldCA9IHRlc3Rf
Yml0KGJpdF9uciwgJnBhZ2UtPmZsYWdzKTsKLQkJaWYgKGJlaGF2aW9yID09IERST1ApCi0JCQlw
dXRfcGFnZShwYWdlKTsKLQotCQlpZiAobGlrZWx5KGJpdF9pc19zZXQpKQotCQkJaW9fc2NoZWR1
bGUoKTsKLQotCQlpZiAoYmVoYXZpb3IgPT0gRVhDTFVTSVZFKSB7Ci0JCQlpZiAoIXRlc3RfYW5k
X3NldF9iaXRfbG9jayhiaXRfbnIsICZwYWdlLT5mbGFncykpCi0JCQkJYnJlYWs7Ci0JCX0gZWxz
ZSBpZiAoYmVoYXZpb3IgPT0gU0hBUkVEKSB7Ci0JCQlpZiAoIXRlc3RfYml0KGJpdF9uciwgJnBh
Z2UtPmZsYWdzKSkKLQkJCQlicmVhazsKLQkJfQotCi0JCWlmIChzaWduYWxfcGVuZGluZ19zdGF0
ZShzdGF0ZSwgY3VycmVudCkpIHsKLQkJCXJldCA9IC1FSU5UUjsKKwkJaWYgKHNpZ25hbF9wZW5k
aW5nX3N0YXRlKHN0YXRlLCBjdXJyZW50KSkKIAkJCWJyZWFrOwotCQl9CiAKLQkJaWYgKGJlaGF2
aW9yID09IERST1ApIHsKLQkJCS8qCi0JCQkgKiBXZSBjYW4gbm8gbG9uZ2VyIHNhZmVseSBhY2Nl
c3MgcGFnZS0+ZmxhZ3M6Ci0JCQkgKiBldmVuIGlmIENPTkZJR19NRU1PUllfSE9UUkVNT1ZFIGlz
IG5vdCBlbmFibGVkLAotCQkJICogdGhlcmUgaXMgYSByaXNrIG9mIHdhaXRpbmcgZm9yZXZlciBv
biBhIHBhZ2UgcmV1c2VkCi0JCQkgKiBmb3Igc29tZXRoaW5nIHRoYXQga2VlcHMgaXQgbG9ja2Vk
IGluZGVmaW5pdGVseS4KLQkJCSAqIEJ1dCBiZXN0IGNoZWNrIGZvciAtRUlOVFIgYWJvdmUgYmVm
b3JlIGJyZWFraW5nLgotCQkJICovCisJCWlmICh3YWl0LT5mbGFncyAmIFdRX0ZMQUdfV09LRU4p
CiAJCQlicmVhazsKLQkJfQorCisJCWlvX3NjaGVkdWxlKCk7CiAJfQogCiAJZmluaXNoX3dhaXQo
cSwgd2FpdCk7CkBAIC0xMTkwLDcgKzEyMTUsNyBAQCBzdGF0aWMgaW5saW5lIGludCB3YWl0X29u
X3BhZ2VfYml0X2NvbW1vbih3YWl0X3F1ZXVlX2hlYWRfdCAqcSwKIAkgKiBib3RoZXIgd2l0aCBz
aWduYWxzIGVpdGhlci4KIAkgKi8KIAotCXJldHVybiByZXQ7CisJcmV0dXJuIHdhaXQtPmZsYWdz
ICYgV1FfRkxBR19XT0tFTiA/IDAgOiAtRUlOVFI7CiB9CiAKIHZvaWQgd2FpdF9vbl9wYWdlX2Jp
dChzdHJ1Y3QgcGFnZSAqcGFnZSwgaW50IGJpdF9ucikKLS0gCjIuMjguMC5yYzAuMy5nMWUyNWQz
YTYyZgoK
--00000000000027ca3205ab246ca4
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-list-add-list_del_init_careful-to-go-with-list_empty.patch"
Content-Disposition: attachment; 
	filename="0002-list-add-list_del_init_careful-to-go-with-list_empty.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kczftmke1>
X-Attachment-Id: f_kczftmke1

RnJvbSBkZGMwMGFhZjhlMDIwYmFiNjMwZWM2NDFiMzc1NjQ2MzQ0NTQ2MzRjIE1vbiBTZXAgMTcg
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
bGVtYXAuYyBiL21tL2ZpbGVtYXAuYwppbmRleCAxMTQzYzA2NTJkODEuLjIzOWQxNTZhMzhlYSAx
MDA2NDQKLS0tIGEvbW0vZmlsZW1hcC5jCisrKyBiL21tL2ZpbGVtYXAuYwpAQCAtMTA0MCwxMyAr
MTA0MCw4IEBAIHN0YXRpYyBpbnQgd2FrZV9wYWdlX2Z1bmN0aW9uKHdhaXRfcXVldWVfZW50cnlf
dCAqd2FpdCwgdW5zaWduZWQgbW9kZSwgaW50IHN5bmMsCiAJICogc2luY2UgYWZ0ZXIgbGlzdF9k
ZWxfaW5pdCgmd2FpdC0+ZW50cnkpIHRoZSB3YWl0IGVudHJ5CiAJICogbWlnaHQgYmUgZGUtYWxs
b2NhdGVkIGFuZCB0aGUgcHJvY2VzcyBtaWdodCBldmVuIGhhdmUKIAkgKiBleGl0ZWQuCi0JICoK
LQkgKiBXZSBfcmVhbGx5XyBzaG91bGQgaGF2ZSBhICJsaXN0X2RlbF9pbml0X2NhcmVmdWwoKSIg
dG8KLQkgKiBwcm9wZXJseSBwYWlyIHdpdGggdGhlIHVubG9ja2VkICJsaXN0X2VtcHR5X2NhcmVm
dWwoKSIKLQkgKiBpbiBmaW5pc2hfd2FpdCgpLgogCSAqLwotCXNtcF9tYigpOwotCWxpc3RfZGVs
X2luaXQoJndhaXQtPmVudHJ5KTsKKwlsaXN0X2RlbF9pbml0X2NhcmVmdWwoJndhaXQtPmVudHJ5
KTsKIAlyZXR1cm4gcmV0OwogfQogCi0tIAoyLjI4LjAucmMwLjMuZzFlMjVkM2E2MmYKCg==
--00000000000027ca3205ab246ca4--
