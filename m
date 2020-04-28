Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEB3C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2FC1206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WzVLMk3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgD1TLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728799AbgD1TLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:11:52 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B7DC03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 12:11:51 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id c21so8003632plz.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 12:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZuKRJpSBRruZhhwcrKd2xCu4bnC8nzyz0vfg5gKiFZY=;
        b=WzVLMk3JggrSSYQ7Gd5Im5fbe/4s5xLKCKA+WRhAavfyXWUybY4EkWdnH2g5Ok3hKN
         vXa3xt0POwn0CdvyyOP1ZXSy3keOW4Hjar7/eb+yZeyfTbmM1mnEUXrYMG5q+6Zsd4NS
         QDcXgwA8ZROB0n9hu/x8bwL1UYsX1GlEyM2yE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZuKRJpSBRruZhhwcrKd2xCu4bnC8nzyz0vfg5gKiFZY=;
        b=VDZotZp1W9cNSU2dTDZerxGwZEwRAJrSsSqbIFMnrj/3CYvGE1C0PFb915wA7R76Qn
         RvN59rl9oml270aPhNaA08+XDeCVcacBpXInSQ0Dqi00c9wHjWxv+9h4SvRmjZR9HTy1
         vbWgR1PrwOdWls/SHtsGve+d4D6fUXeZ6dlo5BlAGiAi3Ex4jV/7U6R13lG5YWABsHFr
         V7TBVV/S/qqijP84kJoWsOdxKXaLsn5Wd+5BHvxlax34xMJd4u4KB8HqAglhPfd6/XTS
         X1zThuar/rYKl7cn3DFjCqqz1gHbcQvjqT26CkNmUmurZLvr2o/DU3tjEAZ9OKPznlQw
         8A1Q==
X-Gm-Message-State: AGi0PuZt+2TJEPmLHzB0fEWYo7GTkjamjJk1V1RDevUjESdNLBz8tml9
        JxWyb+fYyLBz+9dfkmOPkbDZBw==
X-Google-Smtp-Source: APiQypJ7Ji7eFQc2Ao4XjaljptdOLE2l7w8fbtCnDPIeXUF87f1Nwt1J9vK1yzJ7UVOATTJbbEvjEA==
X-Received: by 2002:a17:902:e989:: with SMTP id f9mr15854905plb.321.1588101110521;
        Tue, 28 Apr 2020 12:11:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q7sm6089339pgs.13.2020.04.28.12.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 12:11:49 -0700 (PDT)
Date:   Tue, 28 Apr 2020 12:11:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
Message-ID: <202004281210.426A29EB8@keescook>
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <20200428161044.caamvx67t2z4t6vd@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428161044.caamvx67t2z4t6vd@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 11:10:44AM -0500, Josh Poimboeuf wrote:
> On Tue, Apr 28, 2020 at 04:49:15PM +0200, Arnd Bergmann wrote:
> > I noticed the number of objtool warnings in randconfig kernels have gone down
> >  recently, maybe it's possible to eliminate the remaining ones?
> > 
> > Here are the ones I ran into recently, using gcc-9.3:
> > 
> > ==> build/x86/0x3D2B5D6D_defconfig/log <==
> > arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_handle_exit_irqoff()+0x24: unreachable instruction
> 
> This is a legit warning caused by CONFIG_UBSAN_TRAP +
> CONFIG_UBSAN_ALIGNMENT, I think Kees is going to do a fix.

Yup, I'm still on the hook for this; just a bit distracted. I'll get it
landed soon.

-- 
Kees Cook
