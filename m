Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7B8C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 071032084D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587410529;
	bh=NDoKL94HNFPZ8UiQCQdxSAVEyXDS53wbYWDOGKs5FrM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=f+hm5yh9CX1pPyKgNmln1SV3jgYgX6r4SHcMBIQQFHEl6d0p/wRFQP7ShPT6a+KT6
	 YtFYr1U/pYCncdD+J7xnUW3EJffZd+ViUWyAF537DwXk5Rcq56IpbWD6Vt9R/J50jS
	 Rg76pzdpviJmcPfFHyQz31HFQJITktzPjwhF8ZLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgDTTWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726181AbgDTTWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 15:22:07 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6C4C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 12:22:05 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id g4so3216371ljl.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 12:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C1HzF2sOztrpcTRfVFdugi5Ct8XpBV9p5oRnE61v5SA=;
        b=azUDQqKvtBu1FS8xYE2w20wgDfMJnOZlpfw5ZFTGGkuOgGqcBMAcNEUripeNwoyvqT
         6SBn/TsaOp2zXMTuDV1JuIJLDWlFYyiJ9FSLx/AO68UT30t7SKyCzL8+yQFSwvKJL3N1
         +sWY3AS3P3R48RAsJpWVmyLCAXTK6HUd156JY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C1HzF2sOztrpcTRfVFdugi5Ct8XpBV9p5oRnE61v5SA=;
        b=ddugta0WqJjax2oKFbXh61CdfWJVT3+nugh+YJGFhP/9hOrK2tGIURMmDYLzkd+PIm
         mKUOBR2PN5ZnJfpfGcUcD/jbcsyBY70qnWjdudocoMQc9L8SALZja1AP7WH/v5Do005f
         Y6qs85LFSxB+F7pzdcWq/yAsmWttUdS/NEnH56fR/e9Tw14ao5zvdu4CQZ+8D/iUyxor
         45uWfC+iKbrGPkvYSOyOuF2z9rO+a7S8gtjiYBAdTaa/Vgm1YDFuxk+L9A80PVVN32Rb
         wNprH4x98ZjLq5SDkDsfHjWTLukCGsrf/Tdx9Wy/CgEgrmuGyNB+1hvCGNcO+sYtRKGP
         nuTQ==
X-Gm-Message-State: AGi0PuZ2/30q/0ZIyvceZB/pk5nLDUQEIBPRQDp16bDWs8LYmPvn3V7K
        qpq7JowMuGbrL9yPq2OdMD73VnazmwE=
X-Google-Smtp-Source: APiQypKtz27c2NVBS4Wbyci6Tb0gzKqq+qmrWyIXPOZcV1mVwKjFyCeGeUN9KyzhhasS9CX8LvoZBg==
X-Received: by 2002:a2e:7301:: with SMTP id o1mr5550988ljc.264.1587410523350;
        Mon, 20 Apr 2020 12:22:03 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id q26sm270946ljg.47.2020.04.20.12.22.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 12:22:02 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id j3so11298384ljg.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 12:22:02 -0700 (PDT)
X-Received: by 2002:a2e:1418:: with SMTP id u24mr11441148ljd.265.1587410521788;
 Mon, 20 Apr 2020 12:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <158730459860.31269.9496277256253823777.tglx@nanos.tec.linutronix.de>
 <158730460101.31269.5005570498545135614.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjUS9b-B1n=OCBdqq3mdVTNGz0zqhGnrtMijoB5qT+96g@mail.gmail.com>
 <20200419200758.3xry3vn2a5caxapx@treble> <20200420074845.GA72554@gmail.com>
 <CAHk-=wiG=Bz57AUmbTyZYMKU6C+nZpS8P2=vFf5xAAhBzrPuTQ@mail.gmail.com>
 <20200420174031.GM20730@hirez.programming.kicks-ass.net> <20200420181730.4bmggezf2zhu4ffb@treble>
In-Reply-To: <20200420181730.4bmggezf2zhu4ffb@treble>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Apr 2020 12:21:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6QqiaLqk19nLLAjLFNf8eY7d1m2-Qigg9w3H6iGu+EQ@mail.gmail.com>
Message-ID: <CAHk-=wg6QqiaLqk19nLLAjLFNf8eY7d1m2-Qigg9w3H6iGu+EQ@mail.gmail.com>
Subject: Re: [GIT pull] perf/urgent for 5.7-rc2
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 11:17 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> If you added something bad to a file, and just rebuilt that file, you
> wouldn't see the objtool warning until later when you build the entire
> kernel.

Yes, that's not optimal, but I think I'd personally still prefer that
behavior. Especially since I seldom build single files, and in fact
rather seldom build without some "make -j32" or similar: so build
errors don't happen linearly in the first place.

> (Of course the same complaint would apply to vmlinux.o
> validation.)  But the warning shows the .o file, which could be
> confusing.

The warning should show the proper loe-level *.o file, so I don't see
what's confusing about that.

Yes, the error would happen while trying to link (say)
kernel/built-in.a, and 'make' would report that creating that archive
had failed, but 'objtool' itself would report the particular object
file it was working on that had issues.

So the errors should be pretty obvious. But like PeterZ, the makefile
magic escapes me.

            Linus
