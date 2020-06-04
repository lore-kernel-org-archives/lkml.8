Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB55C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1822C206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591258775;
	bh=lzQl7RRJm588oTR+5nO8YmtqrlAPwIsfr4jAwky0wvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B8lS46Kqwxl4UQh18EwuRuLARQDn8STvc/ff3VSqqsDqt8YUQDjbeyj+gztVXy9jV
	 v+RGpzZt42apVEnpFjXFLF+AQQfXJugDp7ioj9zplJWT78euOZABySjlaFzDPFaNp3
	 00M+B3muu9dgAbcmpX7c5Gc5dPcOJjo33hXgK9IM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgFDITe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgFDITc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:19:32 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4689CC05BD1E
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 01:19:32 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f5so4644735wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 01:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+G6Fj4r62dPNa6jIQAvpkv4FjZwXr8hSt6RlMGt33v0=;
        b=ZQrP+oX2/9AJzQZVd5ameopoeQDPT3aqahfC4OKeujJk161YBzFzy+mRW8wQZypF9r
         S6jU0/PTAj1bL13PfUI3vb0pDsXpN0sfSbEZQPTFlDmuBiilKVB5zP7eXWgAeCX4bFEZ
         WgQTc8dwXP2cVtFhlWZbhF75X3hG7bL/fnDGHt1cAo9OAcxV2m8OcjlbkvyUCQRpRZ4v
         jTIyFW+Quv4WSgwFUNz587F4adeLApWFVhhsQ3nQYiRXShKpDcZyVKgoF/WuTENw/Otk
         0VWIyXxUJFYyVYf4YCThQeBS34J5Nz/ZdmcO/ERuZBbNBf7wyhFSNTZoIU4FLiE6CyIX
         p/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=+G6Fj4r62dPNa6jIQAvpkv4FjZwXr8hSt6RlMGt33v0=;
        b=LvshL/RrwenGG4yui+wOIaJkzN2oEv93jgfh5v29fHQDaWiyxDTXZ0oYg2l05NuRNy
         CI9Oht5bMysmUjUgEPDEzNNJNXXuvwPoDzJQ092RCeay0U0/DhWImgjBY/Y6Gv0DwCYT
         SXWnYEh79I9r6ceBzElhwLhtrdITlENNIR328SQhbEE49Ng2t5Oq/bZ4Cz512nwWG96J
         Jn8jX16KHj6t7w4rEFksO9Y5I1Jma4udl7c1HfkIh2CuSKngbYmqZBSqhp1dgCcdj76e
         FFBDC4KWnugX136uhPPE7hZ05AEZ6iRXwz0JYMovnFBg2jGc1b+ItePeKPbXjvJTYHKb
         VHzA==
X-Gm-Message-State: AOAM532PKLL39098CYnxEaPnEYz5E5F+kOb2JocxrpPNPbUZ5MMTBDWJ
        jpx10lIkWLK+/pdlFfDpn4Q=
X-Google-Smtp-Source: ABdhPJywW5tNYNLZVmJ3gt0XH2rrRQwVQi6cCPMTY8x1sZyzNrI9totXREgtbmrTZhIDvT1eVfOPpQ==
X-Received: by 2002:a1c:4b18:: with SMTP id y24mr3021412wma.102.1591258770929;
        Thu, 04 Jun 2020 01:19:30 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id g18sm6191036wme.17.2020.06.04.01.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 01:19:30 -0700 (PDT)
Date:   Thu, 4 Jun 2020 10:19:28 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] compiler.h: Move instrumentation_begin()/end() into new
 <linux/instrumentation.h> header
Message-ID: <20200604081928.GA570386@gmail.com>
References: <20200601130806.GA746506@gmail.com>
 <CAHk-=wgmXOFyiu6jZ8Dj8OAU7c0T0q-6RLygKC2tMiNfL7MQjQ@mail.gmail.com>
 <20200604071921.GA1361070@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604071921.GA1361070@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Mon, Jun 1, 2020 at 6:08 AM Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > >  include/linux/compiler.h            | 53 +++++++++++++++++++++++
> > 
> > I have pulled this, but do we really want to add this to a header file
> > that is _so_ core that it gets included for basically every single
> > file built?
> > 
> > I don't even see those instrumentation_begin/end() things used
> > anywhere right now.
> > 
> > It seems excessive. That 53 lines is maybe not a lot, but it pushed
> > that header file to over 12kB, and while it's mostly comments, it's
> > extra IO and parsing basically for _every_ single file compiled in the
> > kernel.
> > 
> > For what appears to be absolutely zero upside right now, and I really
> > don't see why this should be in such a core header file!
> > 
> > I don't even see this as having anything at all to do with
> > "compiler.h" in the first place.
> > 
> > I really think we should think twice about making core header files
> > bigger like this. No, we're nowhere the disaster that C++ project
> > headers are, but tokenization and parsing is actually a pretty big
> > part of the build costs (which may surprise some people who think it's
> > all the fancy optimizations that cost a lot of CPU time).
> 
> Fully agreed - and I made the attached patch to address this.
> 
> The code got cleaner and better structured, but it didn't help much in 
> terms of inclusion count:
> 
>    2616  total .o files
> 
>    2447  <linux/types.h>
>    2436  <linux/compiler.h>
>    2404  <linux/bug.h>
> 
> The reason is that <linux/bug.h> is included almost everywhere as 
> well, and the instrumentation_begin()/end() annotations affect the 
> BUG*() and WARN*() primitives as well.
> 
> At least non-x86 would have less instrumentation related noise, for 
> now at least.

>  arch/x86/include/asm/bug.h       |  1 +
>  include/linux/compiler.h         | 53 -------------------------------------
>  include/linux/context_tracking.h |  2 ++
>  include/linux/instrumentation.h  | 57 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 60 insertions(+), 53 deletions(-)

The tested v2 version of the patch also needed the include in 
asm-generic/bug.h (see the fix attached below), because for 
completeness the generic version was annotated as well - even though 
only x86 has objtool support for now.

The readability improvement is real though.

Thanks,

	Ingo


diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 384b5c835ced..c43b5906e0dc 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -3,6 +3,7 @@
 #define _ASM_GENERIC_BUG_H
 
 #include <linux/compiler.h>
+#include <linux/instrumentation.h>
 
 #define CUT_HERE		"------------[ cut here ]------------\n"
 

