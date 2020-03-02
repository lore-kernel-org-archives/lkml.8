Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90F8C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 05:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBF520866
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 05:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaJHEa7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCBFKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 00:10:45 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38538 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCBFKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 00:10:45 -0500
Received: by mail-ot1-f68.google.com with SMTP id i14so1365706otp.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 21:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T8fgcUH96BtI1H4QvYoKauEYCCbRMy2bktXV5r5B2T4=;
        b=QaJHEa7WwsDkL2etKS7IPadbk8f4FqA3kbit3B9bY33vjeh3eAINHg2MLv0amQTmC9
         xZMiFgmf+p7o+uUto9g6K+OSRsc/7oP1M4F+rXmwPOdtSkRDN9S4axCsPlQj4Z7s9agA
         yHKHpjQLitl/Z/WzHOOSS5pDeNKwmhVerixSYChL3mbb3eyotwjtK54Js0830rFMwegq
         D5EyfQY3LN+SvtuChAlP3cSkynBduh6tC+5seRLyqm4UGx0F7G/Pt0862RC3KYPsL27G
         B3UnTjPus9iARdZS3jKqnvcc1M1Ia1CEVMYCJJCOB6/aruyf+RFO9z5gk9IEnPQ+3IhJ
         wBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T8fgcUH96BtI1H4QvYoKauEYCCbRMy2bktXV5r5B2T4=;
        b=O25UQCmcBwmgJOoiUTzhJgGE1OSZccQV1J21Ce4lGjJs/jkObP1CV9hwldsn3zIyrt
         Y4pt/vlb7Arw+xE488a/33zBKZm3+njTbQyutqQ54Pnt78Nfq4b+ejLb8u+OAMvZUhes
         qEJAN9Fvm648G3ovrWnXKo5MDJLWaQE4mTL6s0jxN/GpcEwkPAhxKLbitTCtHP2V2PBS
         f8J8RS2/uGuNEnAaSeGsP+ePNqklDvxg/LYWki29pU6b0k/2GWzgbmwz5zOb2ve6JnEV
         n/Rm1cOD2KsSpp44kVF9QJk9Lg4xlKVrGMSS/mo5AAEfY8xOE1zs9b73VONw5G0wk43P
         uRtA==
X-Gm-Message-State: APjAAAV95kblwjaM/zvxinmc4XnLtFJH7VsTNt2G7rjFLRzy3QeC8tdl
        +f5lSdcqhuMYt1w4SS0loKQXLOG6
X-Google-Smtp-Source: APXvYqw2j9Luo/Ga8ZCam3NqsJfwhFS/VC3jxlVOrydK3IGH45IENGS6hFBNqmCX0nWEMBcD2AIF3A==
X-Received: by 2002:a9d:34c:: with SMTP id 70mr11221277otv.174.1583125844002;
        Sun, 01 Mar 2020 21:10:44 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id d17sm443969otf.77.2020.03.01.21.10.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Mar 2020 21:10:43 -0800 (PST)
Date:   Sun, 1 Mar 2020 22:10:41 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [GIT PULL] Second batch of KVM changes for Linux 5.6-rc4 (or rc5)
Message-ID: <20200302051041.GA2698@ubuntu-m2-xlarge-x86>
References: <1583089390-36084-1-git-send-email-pbonzini@redhat.com>
 <CAHk-=wiin_LkqP2Cm5iPc5snUXYqZVoMFawZ-rjhZnawven8SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiin_LkqP2Cm5iPc5snUXYqZVoMFawZ-rjhZnawven8SA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ CBL mailing list, my two cents below.

On Sun, Mar 01, 2020 at 03:33:48PM -0600, Linus Torvalds wrote:
> On Sun, Mar 1, 2020 at 1:03 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > Paolo Bonzini (4):
> >       KVM: allow disabling -Werror
> 
> Honestly, this is just badly done.
> 
> You've basically made it enable -Werror only for very random
> configurations - and apparently the one you test.
> 
> Doing things like COMPILE_TEST disables it, but so does not having
> EXPERT enabled.
> 
> So it looks entirely ad-hoc and makes very little sense. At least the
> "with KASAN, disable this" part makes sense, since that's a known
> source or warnings. But everything else looks very random.
> 
> I've merged this, but I wonder why you couldn't just do what I
> suggested originally?
> 
> Seriously, if you script your build tests, and don't even look at the
> results, then you might as well use
> 
>    make KCFLAGS=-Werror
> 
> instead of having this kind of completely random option that has
> almost no logic to it at all.
> 
> And if you depend entirely on random build infrastructure like the
> 0day bot etc, this likely _is_ going to break when it starts using a
> new gcc version, or when it starts testing using clang, or whatever.
> So then we end up with another odd random situation where now kvm (and
> only kvm) will fail those builds just because they are automated.

Just FYI, 0day clang builds are live now. I have not seen anything from
KVM yet but I do not know how many configurations are being tested and
such:

https://lore.kernel.org/lkml/CAKwvOdn9mpsjpAbVQbS0LC9iPtNrCZU+Pbh2Bt7kSXa4S8KQEg@mail.gmail.com/

> Yes, as I said in that original thread, I'd love to do -Werror in
> general, at which point it wouldn't be some random ad-hoc kvm special
> case for some random option. But the "now it causes problems for
> random compiler versions" is a real issue again - but at least it
> wouldn't be a random kernel subsystem that happens to trigger it, it
> would be a _generic_ issue, and we'd have everybody involved when a
> compiler change introduces a new warning.

Indeed; our CI for clang builds is all done with the master versions of
clang available from apt.llvm.org so we can catch issues as soon as
possible and having -Werror would mean a potentially benign issue (like
one we are currently dealing with where clang's -Wvoid-pointer-to-int-cast
warns when casting to an enum where gcc does not:
https://reviews.llvm.org/D72231#1878528) would cause our CI to go
instantly red across the board and not catch other issues.

I would say a CONFIG_CC_WERROR or something of that nature would not
necessarily be a bad thing since we could just disable it for our CI (or
have it be default disabled) but I think if someone cares about -Werror,
they should just use the KCFLAGS trick at the point, since I would think
that would be easier than maintaining a separate config option.

> I've pulled this for now, but I really think it's a horrible hack, and
> it's just done entirely wrong.
> 
> Adding the powerpc people, since they have more history with their
> somewhat less hacky one. Except that one automatically gets disabled
> by "make allmodconfig" and friends, which is also kind of pointless.
> 
> Michael, what tends to be the triggers for people using
> PPC_DISABLE_WERROR? Do you have reports for it? Could we have a
> _generic_ option that just gets enabled by default, except it gets
> disabled by _known_ issues (like KASAN).
> 
> Being disabled for "make allmodconfig" is kind of against one of the
> _points_ of "the build should be warning-free".
> 
>                Linus

FWIW, our clang powerpc builds were broken for 4 months because of
arch/powerpc using -Werror:

https://github.com/ClangBuiltLinux/linux/issues/625

We have infrastructure in place to carry out of tree patches if
absolutely necessary, which we had to use for a while:

https://github.com/ClangBuiltLinux/continuous-integration/commit/4d1b3c74bcb3ed0090073c9d9e6ae303425d4adc
https://github.com/ClangBuiltLinux/continuous-integration/commit/0c3885049e2a6e28c72be13f5b05fb25ff79904b
https://github.com/ClangBuiltLinux/continuous-integration/commit/533fcec33fdb8526333a6fd91d24534eeb96bed5

Even now, there is a warning in the RDMA subsystem that points to a very
clear bug that has still not been merged into your tree:

https://git.kernel.org/rdma/rdma/c/4ca501d6aaf21de31541deac35128bbea8427aa6

I am not blaming anyone for that, I get that every maintainer has their
own test suite and pull request schedule but I believe that it shows
the general apathy towards warning fixes from maintainers (at least,
from the perspective of someone who sends a large amount of warning
fixes). I would argue this should change before -Werror could even
begin to be considered as a default option.

Cheers,
Nathan
