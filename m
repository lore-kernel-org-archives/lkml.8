Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E6BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 03:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60E2520678
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 03:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyO6SeGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbgEUDaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 23:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgEUDaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 23:30:35 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1216BC061A0E;
        Wed, 20 May 2020 20:30:35 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cx22so2296078pjb.1;
        Wed, 20 May 2020 20:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uDIiEcjy80gA4ps38HoROvYan2sQOUFT82jQPB/2UNw=;
        b=AyO6SeGGAm0QIBIThN81SGP22D8KEcinoULbuJpMuGLPj+TBB6w56rPuJ9bZMI6GrB
         hVb1JWW98n8iq9Sqt2fp50aL/UE0K1AOInfCQixIRLFkRuApEB38udFtXFHd1Xhg7/yu
         l/jjyWMByv7QV5YKUQuKuZQRdMAh55VjbXu0SLBUUpaXGb6niSP4D7Np6gWczQKTHsZZ
         EPdpvwyjYf89fiVm+Wj+KR7VLdi1ltKrNHrWCKXy7rjC3n9hFL8G4T7fSOKXswi2fNe5
         omGddWl1GckaZextAfUHv8dw0In36MAiMUO066IOHAbov9lR2L+pzStSVIdQFeMFmrSE
         PDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uDIiEcjy80gA4ps38HoROvYan2sQOUFT82jQPB/2UNw=;
        b=GaVHztKhiHHwLFsiVtr9P8BF2AuEkJwZzDg9ukhmJKjBS4ZYZ6TWOeqie6CGzQpjFn
         9zVvfrdRdvhQDOEXlmWldaOKEzEd5TNIXuv7dvl6N0mjcSq+Acea+vFu+LEjpqoqPJHT
         ZWf8y6toJuvTIJJSKQSBoDj8mwfmCFKAJfInEcqewHSoT2PeNpliQp2CY2lhn2HQMh4k
         GV2aZaJDoHFa3yPbyUlErhUTTdqpbqF791yF+xlfj1cDVrlF2a9mD0ZR2KQxrGiSlsRL
         UXtn1IokbHr7MwVg/URtLdiS5x0/P9x0kx7zSumTEVyuItXzFlZTKXODKEm91weFp/ok
         VpPA==
X-Gm-Message-State: AOAM531uQJXN0AuOCmKacFqe7Lf95Ry/JxsvX6FoPrtTZmzem6lgjyku
        tOCeHJSWYPmNcmMkgtsAiQ3NlwQe
X-Google-Smtp-Source: ABdhPJxt68R1ahsIg4uKpfQccsG8TdtMaNTHJ8jB2pvqkrfcdE9mBwAkuBCixiCN0HO4yEW90bMc3Q==
X-Received: by 2002:a17:90b:8d1:: with SMTP id ds17mr8432440pjb.76.1590031834534;
        Wed, 20 May 2020 20:30:34 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id w21sm3479771pfu.47.2020.05.20.20.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 20:30:33 -0700 (PDT)
Date:   Wed, 20 May 2020 20:30:31 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Marco Elver <elver@google.com>, x86 <x86@kernel.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [tip: locking/kcsan] READ_ONCE: Use data_race() to avoid KCSAN
 instrumentation
Message-ID: <20200521033031.GA3590594@ubuntu-s3-xlarge-x86>
References: <20200511204150.27858-18-will@kernel.org>
 <158929421358.390.2138794300247844367.tip-bot2@tip-bot2>
 <20200520221712.GA21166@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520221712.GA21166@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 12:17:12AM +0200, Borislav Petkov wrote:
> Hi,
> 
> On Tue, May 12, 2020 at 02:36:53PM -0000, tip-bot2 for Will Deacon wrote:
> > The following commit has been merged into the locking/kcsan branch of tip:
> > 
> > Commit-ID:     cdd28ad2d8110099e43527e96d059c5639809680
> > Gitweb:        https://git.kernel.org/tip/cdd28ad2d8110099e43527e96d059c5639809680
> > Author:        Will Deacon <will@kernel.org>
> > AuthorDate:    Mon, 11 May 2020 21:41:49 +01:00
> > Committer:     Thomas Gleixner <tglx@linutronix.de>
> > CommitterDate: Tue, 12 May 2020 11:04:17 +02:00
> > 
> > READ_ONCE: Use data_race() to avoid KCSAN instrumentation
> > 
> > Rather then open-code the disabling/enabling of KCSAN across the guts of
> > {READ,WRITE}_ONCE(), defer to the data_race() macro instead.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc: Marco Elver <elver@google.com>
> > Link: https://lkml.kernel.org/r/20200511204150.27858-18-will@kernel.org
> 
> so this commit causes a kernel build slowdown depending on the .config
> of between 50% and over 100%. I just bisected locking/kcsan and got
> 
> NOT_OK:	cdd28ad2d811 READ_ONCE: Use data_race() to avoid KCSAN instrumentation
> OK:	88f1be32068d kcsan: Rework data_race() so that it can be used by READ_ONCE()
> 
> with a simple:
> 
> $ git clean -dqfx && mk defconfig
> $ time make -j<NUM_CORES+1>
> 
> I'm not even booting the kernels - simply checking out the above commits
> and building the target kernels. I.e., something in that commit is
> making gcc go nuts in the compilation phases.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

For what it's worth, I also noticed the same thing with clang. I only
verified the issue in one of my first build targets, an arm defconfig
build, which regressed from 2.5 minutes to 10+ minutes.

More details available on our issue tracker (Nick did some more
profiling on other configs with both clang and gcc):

https://github.com/ClangBuiltLinux/linux/issues/1032

More than happy to do further triage as time permits. I do note Marco's
message about the upcoming series to eliminate this but it would be nice
if this did not regress in the meantime.

Cheers,
Nathan
