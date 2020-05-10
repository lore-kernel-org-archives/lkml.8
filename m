Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF12C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 19:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3FA820801
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 19:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589139980;
	bh=zWd4cAEpL4YcnjKHepZKvaA1uFfEzxHy65/iMOgTYm8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uxK0rLFsPsB1J7F+G6k1Rt2g7+3c2QDBTKi4UN42kSd8eaMKeBX59CVHApnu36G7Z
	 CnAryzA+KNVE9zjWwo+DMYMXRiR7a1sl3syWmK+t7LOM324ykENx8QhY6E8UhY8eyT
	 JHj8YrcYCwWvxQ8dwToWA/T8ZRDLzYkksnSJSdgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbgEJTqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 15:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728756AbgEJTqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 15:46:19 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212DFC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 12:46:19 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e2so6063931eje.13
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 12:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GOt0HOaqZfjjxJE5mAqOm47sbC7ffDpQA2P+1UtM4RE=;
        b=MvdUhg89yXtJF0t/lWJcuLrr+bpGqVPlxoPK/Zhq2QqXYyp7vcGmiSrZl+n0GURWqw
         V64Z4RvbsMsrTzRFhphZJ44YD55cIcu0w/FHaiF/arWpo9zjG6+ztNZG5zl1l+5WIhmf
         vjboKU8xNCyk7pZgwioS1lDPWOU6mzJy+CNac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GOt0HOaqZfjjxJE5mAqOm47sbC7ffDpQA2P+1UtM4RE=;
        b=sEUHgf2LW7sYBafwl7nFbaNTd1CoIA5hd8w5nN+rBxbZ0sR0PMBI+ohqmsK2WV6IO1
         l8vU8BUNK9zzJuAkhcZEXXSK+tIV06egEYpZmEJLYypTpUkO1FSYJ/gdiwxcztKY8C8t
         ZReBshevu8Trf47EJpIFP9CadWFhl54BBgryQGedijkQkSPzGm+tXRr7iUqCs1Z3aZdS
         RJp9Snsg3Gv/izkks+nQaetUErg99KC9Qs0wdq3v0y8jWWUigJBYO2Z279OcOr67y4eD
         F0KyiGFbopvPZDMKDGYY2J26etp4dsf9+txjKi7pa+/IuguSPZOTpzJ9WYWWG0i0yP9s
         zGoA==
X-Gm-Message-State: AGi0PuY4CncPQXUULsafwKHl/NH4Jmhontkm9gaJWfqN2EoDkVKLQgFf
        vHMJzFhtFtRE0yd5S+LxtmMjqNM/rSE=
X-Google-Smtp-Source: APiQypJxsqeCbVRUGm8zFI+6/sCQeo05M840nmdEjrFB8q5PZbz0y6NifYRQiQf501UeiSm5OxwqGw==
X-Received: by 2002:a17:906:af6f:: with SMTP id os15mr10797412ejb.78.1589139977073;
        Sun, 10 May 2020 12:46:17 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id d22sm636144edj.62.2020.05.10.12.46.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2020 12:46:16 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id b91so1882274edf.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 12:46:16 -0700 (PDT)
X-Received: by 2002:a2e:87d9:: with SMTP id v25mr7886930ljj.241.1589139516386;
 Sun, 10 May 2020 12:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <87eerszyim.fsf_-_@x220.int.ebiederm.org>
 <ee83587b-8a1c-3c4f-cc0f-7bc98afabae1@I-love.SAKURA.ne.jp>
In-Reply-To: <ee83587b-8a1c-3c4f-cc0f-7bc98afabae1@I-love.SAKURA.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 May 2020 12:38:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQ2ovXMW=5ZHCpowkE1PwPQSL7oV4YXzBxd6eqNRXxnQ@mail.gmail.com>
Message-ID: <CAHk-=wgQ2ovXMW=5ZHCpowkE1PwPQSL7oV4YXzBxd6eqNRXxnQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] exec: Remove recursion from search_binary_handler
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 9, 2020 at 9:30 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Wouldn't this change cause
>
>         if (fd_binary > 0)
>                 ksys_close(fd_binary);
>         bprm->interp_flags = 0;
>         bprm->interp_data = 0;
>
> not to be called when "Search for the interpreter" failed?

Good catch. We seem to have some subtle magic wrt the fd_binary file
descriptor, which depends on the recursive behavior.

I'm not seeing how to fix it cleanly with the "turn it into a loop".
Basically, that binfmt_misc use-case isn't really a tail-call.

Eric, ideas?

                 Linus
