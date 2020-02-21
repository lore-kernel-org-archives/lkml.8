Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D4DC35669
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E522073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WZSM4lJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbgBUXKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 18:10:51 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40835 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgBUXKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 18:10:50 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so1507102plp.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 15:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LVNnD4mUAdAkyJjOTsa1ZEjSZqvjcpylFGomo2SJ8Q8=;
        b=WZSM4lJwA22ZFHhTTy5GBbpkJnPWbEbLldb8K5bOHKQ7C1fYm8kHen+nbR9LYq4qOp
         ggEkrr/6UGOS085bU3bOmZQI90Tm2j442C+tdt1bZUqhyKgERYMh/jbS44WrqGOSvo4e
         V2HZIS1GP04YYCdM8QZQ+2fJTyO91h6B+DQAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LVNnD4mUAdAkyJjOTsa1ZEjSZqvjcpylFGomo2SJ8Q8=;
        b=rkgY2Dww3a7c2DnKduEv87CV5eN8D7kVOB9c1YybBfkmLCy5xoiml/WeWHhj3qZQq4
         kJNdlmICybgYDk9zbO20dqOf9uI3fCRMurA6RlPdvmRScupptTnLzRn3aLRILDZ4I+bp
         ycktSgzCygtMES3IQ3T2RZPRXOpLHTZEcpVtNWvEQCazt3LIddZfP94/YvCxvz0sfFTp
         tnUA+OcMPnDB1fTltO4ku45fLE2EpfP3/KVjPapVTUlWgppwU/2SGr+VvUBFFa0oGd0F
         JRozrFqgVmiufzknfeI7wAoFZrAJCXbJNziLujaB/3Mni/wvjvB4UpbvBwz16rjKoP6c
         BCbA==
X-Gm-Message-State: APjAAAWdvt31s9w6Qg91ChT30yfZJUJFi5rg0S2QvUHUZ7hCfxJPWo1R
        6Wh9afb/cY7roInRSEA5CO3hlw==
X-Google-Smtp-Source: APXvYqy7dg7pn+UTdScRyo2SEvfwN+zzzBsnzKbPvRj/AiZEh7xD6hljNarxHCPGCI+bSwm1Z6juaA==
X-Received: by 2002:a17:902:d688:: with SMTP id v8mr39723084ply.238.1582326650137;
        Fri, 21 Feb 2020 15:10:50 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ci5sm3635120pjb.5.2020.02.21.15.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 15:10:49 -0800 (PST)
Date:   Fri, 21 Feb 2020 15:10:48 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Jann Horn <jannh@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] mm/tlb: Fix use_mm() vs TLB invalidate
Message-ID: <202002211506.2151CA26@keescook>
References: <CAHk-=wi4uO+Djqr4Jc1TnCofwxUTuXHtgkgwnVX86q06UGV6DA@mail.gmail.com>
 <6A09F721-0AD9-4B86-AB3E-563A1CF5ABDE@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6A09F721-0AD9-4B86-AB3E-563A1CF5ABDE@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 11:22:16AM -0800, Andy Lutomirski wrote:
> 
> 
> > On Feb 21, 2020, at 11:19 AM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > 
> > ﻿On Fri, Feb 21, 2020 at 3:11 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >> 
> >> +       BUG_ON(!(tsk->flags & PF_KTHREAD));
> >> +       BUG_ON(tsk->mm != NULL);
> > 
> > Stop this craziness.
> > 
> > There is absolutely ZERO excuse for this kind of garbage.
> > 
> > Making this a BUG_ON() will just cause all the possible debugging info
> > to be thrown away and lost, and you often have a dead machine.
> > 
> > For absolutely no good reason.
> > 
> > Make it a WARN_ON_ONCE(). If it triggers, everything works the way it
> > always did, but we get notified.
> > 
> > Stop with the stupid crazy BUG_ON() crap already. It is actively _bad_
> > for debugging.
> > 
> >  
> 
> In this particular case, if we actually flub this, we are very likely to cause data corruption — we’re about to do user access with the wrong mm.
> 
> So I suppose we could switch to init_mm and carry on. *Something* will crash, but it probably won’t corrupt data or take down the machine.

Why not just fail after the WARN -- I wrote the patch for the (very few)
callers to handle the errors, clean up, and carry on.

-- 
Kees Cook
