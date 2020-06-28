Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B37C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 05:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B172D20781
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 05:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593322786;
	bh=OXPOu1gv4CnAYVJmS2DAzG5EdhUqqWuVRnXKzBC0OrA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=riE77urnOHjsD2SmLXRNwhpK95d5yvPQwL6FYAgvlJ3ntgetHEoJ9sVXgzYn4mQKd
	 HH1Nrxov389nQBziI+AxWlB6RurIJ6CrZZa8azTX+s0///TLvm4UbOiEmZKMfxQfMo
	 yxEMyTTnwGYu+0A7F9g7KVqxD30snVZ28CYBCc7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgF1Fjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 01:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgF1Fjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 01:39:41 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF749C061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 22:39:40 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f8so2124015ljc.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 22:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=inE3u4cg6+imK66ZPvNSj9Fuv2BnBlozA/PMIbRxcAM=;
        b=gtcx4A66qYOb6lD86Up5ZCj5jKivxtVdrhv5H4jK8vcBsgl+kOsvt3ln9Abdx11k8h
         n2E4d7XSY2R/8BzNCoh9ScMV2JeKISIAzWxP7eLMhJ1jNe6ngq7GquCTaaONZK0qVcUk
         6E6xVLsLJhsT4CfLGDEVdZ9N1WFRbm/JQiAUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=inE3u4cg6+imK66ZPvNSj9Fuv2BnBlozA/PMIbRxcAM=;
        b=PuIIYfQVNab93cK22GkERGbTudTe4WhrQ3ODcxOKvtb2Dx3xGQ3smp2cMuT6Wg3a7M
         DcfIBH3tijZPaI4uRYFYVoT2w9QwR+wdxcWJQYsc2D1r071ebMfvetO+U/RevjXB9pXk
         QqkhBlQtZwd1KUEey0eRkJlcht/xNfivxAC2I950LPayoIQil3UDItDkkceCK0npa5F6
         p+dzPAainELGqX2pQhcmX0/c+Ot7iJLjAOb0fceFtEKk/u9dMRSAjossX8ouOuKokB5n
         gA/XKAnZSYAawTR1jdAoTfjezL/QpWrcG86OJ6ste65KtWTVNGdsd4b2x1V+H0FpAVLT
         WUlg==
X-Gm-Message-State: AOAM531ir2SA5yOuhPKQnvjndPF0Znde7tCPe6qkyNykvPUNMVVt+rNO
        Rh4KYmxcocbixzvMY62Lbepj7ZB2/mY=
X-Google-Smtp-Source: ABdhPJyyB/B4RXszDMQYWWgYcThTRY7qLXWMt4IMIhmdPOt/7IaOkKtpQ9kwMiqJyFQtDW5Rt2Korg==
X-Received: by 2002:a2e:8896:: with SMTP id k22mr4898017lji.331.1593322778680;
        Sat, 27 Jun 2020 22:39:38 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id z5sm1758068ljz.117.2020.06.27.22.39.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2020 22:39:37 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id f8so2123981ljc.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 22:39:36 -0700 (PDT)
X-Received: by 2002:a2e:5c02:: with SMTP id q2mr5595086ljb.285.1593322776425;
 Sat, 27 Jun 2020 22:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200624161142.GA12184@redhat.com> <20200624162042.GA12238@redhat.com>
 <CAHk-=wjJA2Z3kUFb-5s=6+n0qbTs8ELqKFt9B3pH85a8fGD73w@mail.gmail.com> <20200626154313.GI4817@hirez.programming.kicks-ass.net>
In-Reply-To: <20200626154313.GI4817@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 27 Jun 2020 22:39:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=whvVWNXPJq1k566zn4SfXAifXtiA7T+7JFweR3rQ0nc9A@mail.gmail.com>
Message-ID: <CAHk-=whvVWNXPJq1k566zn4SfXAifXtiA7T+7JFweR3rQ0nc9A@mail.gmail.com>
Subject: Re: wait_on_page_bit_common(TASK_KILLABLE, EXCLUSIVE) can miss wakeup?
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Nick Piggin <npiggin@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>, Davidlohr Bueso <dave@stgolabs.net>,
        Andi Kleen <ak@linux.intel.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000001a1e6205a91e5ec2"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001a1e6205a91e5ec2
Content-Type: text/plain; charset="UTF-8"

On Fri, Jun 26, 2020 at 8:43 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> I ended up with something like the below.. but it is too warm to think
> properly.
>
> I don't particularly like WQ_FLAG_PAGEWAITERS, but I liked open-coding
> all that even less.

Ugh.

I think I have a much simpler approach, actually.

So the *problem* is purely around that

                if (behavior == EXCLUSIVE) {
                        if (!test_and_set_bit_lock(bit_nr, &page->flags))
                                break;
                } else ..

and in particular it is purely *after* that test_and_set_bit_lock()
case. We have two cases:

 (a) *If* we get the lock there, we're good, and all done, and we have
the lock. We don't care about any other wakeups, because they'll be
stale anyway (the thing that released the lock that we just took) and
because we got the lock, no other exclusive waiters should be woken up
anyway (and we will in turn wake up any waiters when we release it)

 (b) we did *not* get the lock, because somebody else got it and is
about to immediately unlock again. And that _future_ wakeup that they
send might get lost because it might end up targeting us (but we might
just exit and not care).

Agreed?

So the only case that really matters is that we didn't get the lock,
but we must *not* be woken up afterwards.

So how about the attached trivial two-liner? We solve the problem by
simply marking ourselves TASK_RUNNING, which means that we won't be
counted as an exclusive wakeup.

Ok, so the "one" line to do that is that is actually two lines:

        __set_current_state(TASK_RUNNING);
        smp_mb__before_atomic();

and there's four lines of comments to go with it, but it really is
very simple: if we do that before we do the test_and_set_bit_lock(),
no wakeups will be lost, because we won't be sleeping for that wakeup.

I'm not entirely happy about that "smp_mb__before_atomic()". I think
it's right in practice that test_and_set_bit_lock() (when it actually
does a write) has at LEAST atomic seqmantics, so I think it's good.
But it's not pretty.

But I don't want to use a heavy

        set_current_state(TASK_RUNNING);
        if (!test_and_set_bit_lock(bit_nr, &page->flags)) ..

sequence, because at least on x86, that test_and_set_bit_lock()
already has a memory barrier in it, so the extra memory barrier from
set_current_state() is all kinds of pointless.

Hmm?

                    Linus

--0000000000001a1e6205a91e5ec2
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kbymwscv0>
X-Attachment-Id: f_kbymwscv0

IG1tL2ZpbGVtYXAuYyB8IDYgKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvbW0vZmlsZW1hcC5jIGIvbW0vZmlsZW1hcC5jCmluZGV4IGYwYWU5YTYz
MDhjYi4uZWU3M2QzMzQ2NWI2IDEwMDY0NAotLS0gYS9tbS9maWxlbWFwLmMKKysrIGIvbW0vZmls
ZW1hcC5jCkBAIC0xMTUwLDYgKzExNTAsMTIgQEAgc3RhdGljIGlubGluZSBpbnQgd2FpdF9vbl9w
YWdlX2JpdF9jb21tb24od2FpdF9xdWV1ZV9oZWFkX3QgKnEsCiAJCQlpb19zY2hlZHVsZSgpOwog
CiAJCWlmIChiZWhhdmlvciA9PSBFWENMVVNJVkUpIHsKKwkJCS8qCisJCQkgKiBNYWtlIHN1cmUg
d2UgZG9uJ3QgZ2V0IGFueSBleGNsdXNpdmUgd2FrZXVwcworCQkJICogYWZ0ZXIgdGhpcyBwb2lu
dCEKKwkJCSAqLworCQkJX19zZXRfY3VycmVudF9zdGF0ZShUQVNLX1JVTk5JTkcpOworCQkJc21w
X21iX19iZWZvcmVfYXRvbWljKCk7CiAJCQlpZiAoIXRlc3RfYW5kX3NldF9iaXRfbG9jayhiaXRf
bnIsICZwYWdlLT5mbGFncykpCiAJCQkJYnJlYWs7CiAJCX0gZWxzZSBpZiAoYmVoYXZpb3IgPT0g
U0hBUkVEKSB7Cg==
--0000000000001a1e6205a91e5ec2--
