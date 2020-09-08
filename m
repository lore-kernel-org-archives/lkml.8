Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37342C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E23652080A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhGN0zBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731886AbgIHSkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgIHSkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:40:07 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50ADC061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 11:40:06 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 16so72002qkf.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 11:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TQ1kE8zjkXsEOKgpDnRJ81WMBnwwGE+DuFfJR40oSM0=;
        b=bhGN0zBcrt+gY4WhwAYlKbNe6tCr4xWwY834aSV6x/szEYoQAY2wkX1Kmcarwrsbox
         VhiPpze+0fXPoctJ9RfCtojWm91ejXN+5kmBHEElPQ7FHwcqYU5si8dGh7Av5XN2WxRn
         W1Ex1oiSgFRWDGg6BW80oGpueWsz3AS2yD6cMsXN9Ejn9kMjJQcHOIKJ2EGpVHs2zSBU
         Lp67or52EMsd4GXQqvAlDnuRUP2BFPXgIIRpA3OaJ6XTBnmmlGIghsPldqOOngVNfdJx
         Mf9BqBpIVWso3ngDStmV/SwT2WA5ITIJdvPKKxTb0P0DC0Abq9syvi9JwueWMvrAkiPq
         XfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TQ1kE8zjkXsEOKgpDnRJ81WMBnwwGE+DuFfJR40oSM0=;
        b=WsgqkU2F6oJs4n2Hz77/yxNnzcNqVuQt9qM1MzLzwxygunXyVbxYZbIblO3GzcfFvy
         oN4gee4p9oTre+1Uj58Cx4YMSWu5+UxX7ualWdSjspqqh4eTLjq2fL9fUKBiM5mkwg55
         gKTlqUBjt8o2O58BhuHLv/4aWVa1FQ87Q3OReXirb+ofZJbXmQK8pADM201PKU3siW97
         Lx/z+ReGIfj1Zq0rC+90ImNDlxtdDzgVXla7hMc/yZbVHxY4otIZu9xarDXO2mRmFgyv
         QUSC4Ob7o3ZKB6VfFVW7OuaQI65lahTkAmKRo71MQR2oKsLCM0wvEUmzimXxdTKIWGgG
         TGcg==
X-Gm-Message-State: AOAM530g6KdLo3JPZBFt4CbO+7vJmFuCP2kbTSzffPnhSLxcaxdnDECj
        RdWBbwZr672RkiYsWWnT05EKvOi2qo4=
X-Google-Smtp-Source: ABdhPJw9hZ68TKspDaznWaiE8D8rNtb1pS0+MfxRiAwVeiuYnWi8sLqhkmCW4VMGFP2IT9vOagYuIw==
X-Received: by 2002:a37:d41:: with SMTP id 62mr1323744qkn.444.1599590405983;
        Tue, 08 Sep 2020 11:40:05 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k72sm45511qke.121.2020.09.08.11.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:40:05 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 8 Sep 2020 14:40:03 -0400
To:     Kees Cook <keescook@chromium.org>
Cc:     Marco Elver <elver@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        the arch/x86 maintainers <x86@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [RFC PATCH 1/2] lib/string: Disable instrumentation
Message-ID: <20200908184003.GA4164124@rani.riverdale.lan>
References: <20200905222323.1408968-1-nivedita@alum.mit.edu>
 <20200905222323.1408968-2-nivedita@alum.mit.edu>
 <CANpmjNMnU03M0UJiLaHPkRipDuOZht0c9S3d40ZupQVNZLR+RA@mail.gmail.com>
 <202009081021.8E5957A1F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202009081021.8E5957A1F@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 10:21:32AM -0700, Kees Cook wrote:
> On Tue, Sep 08, 2020 at 11:39:11AM +0200, Marco Elver wrote:
> > On Sun, 6 Sep 2020 at 00:23, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > String functions can be useful in early boot, but using instrumented
> > > versions can be problematic: eg on x86, some of the early boot code is
> > > executing out of an identity mapping rather than the kernel virtual
> > > addresses. Accessing any global variables at this point will lead to a
> > > crash.
> > >
> > 
> > Ouch.
> > 
> > We have found manifestations of bugs in lib/string.c functions, e.g.:
> >   https://groups.google.com/forum/#!msg/syzkaller-bugs/atbKWcFqE9s/x7AtoVoBAgAJ
> >   https://groups.google.com/forum/#!msg/syzkaller-bugs/iGBUm-FDhkM/chl05uEgBAAJ
> > 
> > Is there any way this can be avoided?
> 
> Agreed: I would like to keep this instrumentation; it's a common place
> to find bugs, security issues, etc.
> 
> -- 
> Kees Cook

Ok, understood. I'll revise to open-code the strscpy instead.

Is instrumentation supported on x86-32? load_ucode_bsp() on 32-bit is
called before paging is enabled, and load_ucode_bsp() itself, along with
eg lib/earlycpio and lib/string that it uses, don't have anything to
disable instrumentation. kcov, kasan, kcsan are unsupported already on
32-bit, but the others like gcov and PROFILE_ALL_BRANCHES look like they
would just cause a crash if microcode loading is enabled.
