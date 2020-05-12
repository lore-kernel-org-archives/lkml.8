Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6422CC2D0FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 23:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4351120753
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 23:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xd5AlNqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731679AbgELXrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 19:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELXrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 19:47:18 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B99C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 16:47:16 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b190so1402893pfg.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 16:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N1bVDPVoG6ytQwUsDy8H27cU1uUByM6L4oJDmg1UcHY=;
        b=Xd5AlNqUyqa5uevb82kFVRNWgJc4lnvPLl2on8kfIv/uv+g8vxQ9dGBJFLbWtLIDRP
         JSQcp54jIaNJhB0NVPwzNjFlX6LcqAX9z8zSDwNohzAWR4gXbprlhPjWN1YyuRl4Bzfw
         pPSz+ZEIBEy1PBgcBn9P5S0RJobVsxwgU1JAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N1bVDPVoG6ytQwUsDy8H27cU1uUByM6L4oJDmg1UcHY=;
        b=qUagdON6DhEdeM6nA4/EeOj1MSREjeftASECyyG2O0B/twJCqr1cWGAU/KJWS9G25x
         iguu/1hhJKdVP/lZ8lfJR8zHbIJGRVJ9pPkTDVUYUHBZ5WIuy/hjkoKG1+q9QIgZNl0d
         Xt6MO+H3hcEuaWypR/1FIkXqqahBTnZ3E7c3k6ix3xS5qRVwPzd1Ndqo4zJmbmQemnrW
         L8Xk1GHH7xKqXo97xJmFRelHrngaG1I1fMdCw4Ol70wvcLM4jKTfVhhjgKDh52jLmk7V
         DG/SA9ZXZoKICVXZQfYWCTb0QEQIDMK//wlGjRQ0skfAncQOSr4hVfc2aoxJy/q6BItM
         gx+A==
X-Gm-Message-State: AGi0PuaDmrHtpKg5S55uKd6gUiXWQIgq7wlDHZ87TfF3KvdSNUStUZXV
        rKVozLNZbj/RVbE7uJE4IEdReA==
X-Google-Smtp-Source: APiQypLwHnNOyZgGCIToGkDBHxSScBz+H/qybjJmf7uN9nNY8ZiE4xAZfpg+M67XRGGVV7oYCqqYRQ==
X-Received: by 2002:a63:c80e:: with SMTP id z14mr21445995pgg.170.1589327236437;
        Tue, 12 May 2020 16:47:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h15sm13078255pfr.161.2020.05.12.16.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 16:47:15 -0700 (PDT)
Date:   Tue, 12 May 2020 16:47:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 3/5] exec: Remove recursion from search_binary_handler
Message-ID: <202005121625.20B35A3@keescook>
References: <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <87eerszyim.fsf_-_@x220.int.ebiederm.org>
 <ee83587b-8a1c-3c4f-cc0f-7bc98afabae1@I-love.SAKURA.ne.jp>
 <CAHk-=wgQ2ovXMW=5ZHCpowkE1PwPQSL7oV4YXzBxd6eqNRXxnQ@mail.gmail.com>
 <87sgg6v8we.fsf@x220.int.ebiederm.org>
 <202005111428.B094E3B76A@keescook>
 <874kslq9jm.fsf@x220.int.ebiederm.org>
 <202005121218.ED0B728DA@keescook>
 <87lflwq4hu.fsf@x220.int.ebiederm.org>
 <202005121606.5575978B@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005121606.5575978B@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 04:08:56PM -0700, Kees Cook wrote:
> I'm nearly certain the answer is "yes", but I wonder if we should stop
> for a moment and ask "does anything still use MISC_FMT_OPEN_BINARY ? It
> looks like either "O" or "C" binfmt_misc registration flag. My installed
> binfmts on Ubuntu don't use them...
> 
> I'm currently pulling a list of all the packages in Debian than depend
> on the binfmt-support package and checking their flags.

So, binfmt-support in Debian doesn't in _support_ MISC_FMT_OPEN_BINARY
("O"):


        credentials =
                (binfmt->credentials && !strcmp (binfmt->credentials, "yes"))
                ? "C" : "";
        preserve = (binfmt->preserve && !strcmp (binfmt->preserve, "yes"))
                ? "P" : "";
        fix_binary =
                (binfmt->fix_binary && !strcmp (binfmt->fix_binary, "yes"))
                ? "F" : "";
...
        regstring = xasprintf (":%s:%c:%s:%s:%s:%s:%s%s%s\n",
                               name, type, binfmt->offset, binfmt->magic,
                               binfmt->mask, interpreter,
                               credentials, preserve, fix_binary);

However, "credentials" ("C") does imply MISC_FMT_OPEN_BINARY.


I looked at every Debian package using binfmt-support, and "only" qemu
uses "credential".

And now I wonder if qemu actually uses the resulting AT_EXECFD ...

-- 
Kees Cook
