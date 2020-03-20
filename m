Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C03DC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498202080C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lg6/6huY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgCTSfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 14:35:42 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55769 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbgCTSfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 14:35:40 -0400
Received: by mail-pj1-f68.google.com with SMTP id mj6so2877083pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 11:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C2S9KcZfRO3g4bCqyBJ1x6LnernhbhoQu1YGXwjigeE=;
        b=lg6/6huYLirk1oHz4QX7GSjg9GV6zihardksLMc6FOA8Sy6sc2bqpuFKvzGGtMcCnH
         UDBJCq4y1M+6TbPn0rSkXRtzh80xyvo4xLzvJBirxM15UMl/9ISMoEG/tEeeFcP/jFRl
         ER5vrSby+4tui/fclDJjj+xToNeTJxb7QoID0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C2S9KcZfRO3g4bCqyBJ1x6LnernhbhoQu1YGXwjigeE=;
        b=WgaDs63MiVyTD1Sjh2jNbZmcLN4yRXpYWPEpgKZ2At+vVKYhWw5Do+fv8kt3MEp3LG
         WAwY2UHTKi0l+l2mqBO7n9JSQd33WeR9tEYS9OWufC1dhmNiOZ3oTEgE7W3KJYBpHWBE
         3Y/KYgW343ZwkJedJ1z4JzL7+LzUaKy6+9yWXZe/1vINgn4OAcF48APylC+5tcD4x6pP
         dTlsRj8qQMplZSucxDOAGEMvaGoQumwtpj6BtDezqp1/SBnAAlO/dUj+ixPqSblmn9UO
         BsPTeI9irYR1nxCJRxlZ5F2n6KTIRR0y6uwISeRIAZl+Ehbpgu/fsnVPJuBkrYb6MV48
         e02A==
X-Gm-Message-State: ANhLgQ1SEdNF7vOetzIkb5BlL4I51k5MFEyV2Fo6pWLD053tyReC2w46
        cVRIWOhojDJsBMYudA0t+F6xx4JNutI=
X-Google-Smtp-Source: ADFU+vuo1bX8k5FNn27x7znpbXtPAwDztmbevA4C+IVKqZXlu1aOcJJE/TkXqQM0ofU+D8g2EOXyfw==
X-Received: by 2002:a17:902:9a98:: with SMTP id w24mr9918310plp.40.1584729339384;
        Fri, 20 Mar 2020 11:35:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c11sm6356557pfc.216.2020.03.20.11.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 11:35:38 -0700 (PDT)
Date:   Fri, 20 Mar 2020 11:35:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Mar 18 (objtool)
Message-ID: <202003201131.9B688BC@keescook>
References: <20200318220920.48df2e76@canb.auug.org.au>
 <d7dc5b4a-9a7e-ccf7-e00e-2e7f0e79a9bc@infradead.org>
 <20200318182352.2dgwwl4ugbwndi4x@treble>
 <20200318200542.GK20730@hirez.programming.kicks-ass.net>
 <20200319173101.wufpymi7obhqgoqd@treble>
 <20200319173326.oj4qs24x4ly5lrgt@treble>
 <20200319174028.azzaisoj5gbss7zk@treble>
 <20200319174550.4wpx4j357nw67nzz@treble>
 <20200320082613.GA20696@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320082613.GA20696@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 09:26:13AM +0100, Peter Zijlstra wrote:
> On Thu, Mar 19, 2020 at 12:45:50PM -0500, Josh Poimboeuf wrote:
> > > On Thu, Mar 19, 2020 at 12:33:31PM -0500, Josh Poimboeuf wrote:
> 
> > > > Actually I suspect it's the __builtin_unreachable() annotation which is
> > > > making UBSAN add the __builtin_trap()...  because I don't see any double
> > > > UD2s for WARNs.
> 
> > Actually, removing __builtin_unreachable() *does* make the extra UD2 go
> > away -- I forgot I had some silly debug code.
> 
> LOL, check this:
> 
> "Built-in Function: void __builtin_unreachable (void)
> 
>     If control flow reaches the point of the __builtin_unreachable, the
>     program is undefined. It is useful in situations where the compiler
>     cannot deduce the unreachability of the code. "
> 
> Which, I bet, is what makes UBSAN insert that __builtin_trap().
> 
> What a friggin mess :/

What I'd like is to be able to specify to UBSAN what function to call
for the trap. I'd prefer to specify a well-defined exception handler,
but at present, UBSAN just inserts __builtin_trap().

Can't objtool be told to ignore a ud2 that lacks an execution path to it?

-- 
Kees Cook
