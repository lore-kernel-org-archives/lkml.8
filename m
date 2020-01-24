Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A25BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFB12081E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579887436;
	bh=L7rQGjq+FVtTIcQGKsojFCI5O4vlfO6GzCcu3IOCXBY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=e/Zn06x2tGDOqICseqPFOiXoCYxBMPhqs0XolcqBGrcb+9B44VaPwsl5+CX2X+4wc
	 s+a8G0hG4oBz/L51F04/NF5PphoiHOaNJkJWtxsKmOUsFnekS57kmeLxBDYKBPWxEh
	 weaPqcerTzrSi7xyjY0Djsnn9R+fxAacJb5QpFX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390079AbgAXRhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 12:37:15 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35688 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387873AbgAXRhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 12:37:14 -0500
Received: by mail-lj1-f194.google.com with SMTP id j1so3404485lja.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 09:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PpUhy8WdhQo7yn2G9tENFyd+BPqi316s2p72a22I/kM=;
        b=E0Lq8FFbgVl9GzkkHHsvD4aAT7s8Kyiy5R3To2otgXvIV4WtGWhmO0VAPKZyplWkpQ
         9fbytk/03qWfDWSy/b4im5LObo51pXVPG+2QYc8xouyIReu0xgLTNMnBqvtURbYmRlXH
         9ggvethS3Fn2LsF1kSh3PipG5fC47A+kEvXS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PpUhy8WdhQo7yn2G9tENFyd+BPqi316s2p72a22I/kM=;
        b=fh+Er/CQLVm8R59yz4HOaFM4TiUtER4mkc8g31DE9DHLmPZsdcOUJcm5OkmouSxYwi
         4j3FpGonERskg/dB3okCQvR3sHVUNv1DcAdpA4+47HKZ1FS+BtCDSVR5lxqvd2o6BJgh
         BDlRHOfHg8cWf+acqna/FJiLaDJmtwI/ctdSxL9ozh8uSgBcvOFQQM0tYE0Y6PAxFTun
         v9fHIamXyhofG0XspiYL5QKqwb9UdG0WDwOWIQY5IzvkJY3tJvYL6OHHXqQwjqoTgHIx
         1gcrQFD2sm8fIc4uY/9a1WsplYrvt6KbayS3vj3bS6rdfxMf9IgXVURrbLQ0pMhwe3wV
         4UVw==
X-Gm-Message-State: APjAAAVO2n7KLDh9S174W6+6rpTCjjSdjo2wWbSEMQJQXKn7piinuZyJ
        i0QT15Rb2mXyTDlHvoWPTQ/YChwDpAc=
X-Google-Smtp-Source: APXvYqzjOMf5wOi2B9tNpYzfTVg/LhigrVmNyLNfe57/p8atfMsnlfEjDWLTS+pZCHr5DGwgfOPqaw==
X-Received: by 2002:a2e:978d:: with SMTP id y13mr2810158lji.103.1579887431906;
        Fri, 24 Jan 2020 09:37:11 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id g15sm3426259ljl.10.2020.01.24.09.37.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 09:37:11 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id m30so1646398lfp.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 09:37:10 -0800 (PST)
X-Received: by 2002:a05:6512:78:: with SMTP id i24mr1931608lfo.10.1579887430457;
 Fri, 24 Jan 2020 09:37:10 -0800 (PST)
MIME-Version: 1.0
References: <20200123153341.19947-1-will@kernel.org> <20200123153341.19947-3-will@kernel.org>
 <CAKwvOdm2snorniFunMF=0nDH8-RFwm7wtjYK_Tcwkd+JZinYPg@mail.gmail.com> <20200124082443.GY14914@hirez.programming.kicks-ass.net>
In-Reply-To: <20200124082443.GY14914@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Jan 2020 09:36:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgbAfG6UZYd3PY3fmh5nCE191gY76Fn_g_D8nO64mdx-A@mail.gmail.com>
Message-ID: <CAHk-=wgbAfG6UZYd3PY3fmh5nCE191gY76Fn_g_D8nO64mdx-A@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] netfilter: Avoid assigning 'const' pointer to
 non-const pointer
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 12:25 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Just for curiosity's sake. What does clang actually do in that case?

This shouldn't necessarily be clang-specific. If the variable itself
is 'const', it might go into a read-only section. So trying to modify
it will quite possibly hit a SIGSEGV in user space (and in kernel
space cause an oops).

Note that that is different from a const pointer to something that
wasn't originally const. That's just a "error out at compile time if
somebody tries to write through it", but the const'ness can be cast
away, because all the 'const' really said was that the object can't be
modified through _that_ pointer, not in general.

(That also means that the compiler can't necessarily even optimize
multiple accesses through a const pointer away, because the object
might be modified through another pointer that aliases the const one -
you'd need to also mark it "restrict" to tell the compiler that no
other pointer will alias).

                 Linus
