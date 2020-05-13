Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9FCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38617205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589399544;
	bh=yChfl6bW7pHHSbBVahran9Uag3HId9/L3hOJcUfAW9o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kzvPHLNeqGjj5jjonng2SV1i5qm3CVD7DMS9QXSrU7647EZAeg6QGUngJAfZuKQWf
	 jK6eeC//seyLf77otjOoJatXuD6+Ev4HhSiRc9p4W6J/4sC/jck+T4iE/9jMYnYIMr
	 0K5O1y4UDtf+EPT6Gq56Bmn6NmoGUS/nR7ekUhOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403809AbgEMTwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 15:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390158AbgEMTwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 15:52:22 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBCBC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:52:20 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u6so942040ljl.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=imHJ5IQrcOcblMTfzv1B9XBBsSAMPE3kPxQA9myjXSo=;
        b=WQAwRDY0UxVZ0mZJR9kVnssScJrq1sN4tD98t4V9W35y8XGCwm/KxMQqToQil5ltO9
         GFUoMNp/kFEbFvuKrggepy5FbHzhYuRUmjv8amxmBrzK6q3yS0RJcPigPs+hBK67907L
         GVp+95DOu4oDEqAYtYvxlr8n8Tbt3B0dOxjF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=imHJ5IQrcOcblMTfzv1B9XBBsSAMPE3kPxQA9myjXSo=;
        b=m+qctEpjk6pJKwbdsfcWwbHJxy2sq4+3Pil23bf1IXfFnimJyWdkTmLg5sFE2xUJgP
         8dLOa/eKivM76dCmXSkL4Qol3AFgcf6lQboASGpA6FUK+5ArMQSY30M+1nwfMt1b6bFf
         FFxbVUM1I6SZnAQOVsSABhWrdA/eHA/zoTdtgkOUVz7W/9ZSJVMfFkmGaMh8VtJkzCf9
         0phL+t3WFqYwIth9bdDJ6ylNXA1DaEWpQEpqIoTNuJgNo9qUT3QFWrtSMYq6qGjumqK7
         VdIIVpNw7WJqRAL3z/fayFRvG7ugT+n3uq3lR0G5FCoTC2x2WVc/eC9uiSz2qbR07A0s
         Uifg==
X-Gm-Message-State: AOAM530vqgCcaTRNUtPrBuaJ8rZqr20dOfarCe41+VYWU5djzVH2kD/c
        dYIuikMnA8KZdR1j6hR0PDf9sBlFshY=
X-Google-Smtp-Source: ABdhPJwViKcvZfHuai0qxU3Z/vQZr12YmIude6Q4KzKxatqydUjYlq2fRwoStElYOVvX/U32lWFWzw==
X-Received: by 2002:a2e:9f43:: with SMTP id v3mr386019ljk.285.1589399537533;
        Wed, 13 May 2020 12:52:17 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id q27sm326628lfn.58.2020.05.13.12.52.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 12:52:16 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id z22so606911lfd.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:52:15 -0700 (PDT)
X-Received: by 2002:a19:6e4e:: with SMTP id q14mr699711lfk.192.1589399535404;
 Wed, 13 May 2020 12:52:15 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org> <87eerszyim.fsf_-_@x220.int.ebiederm.org>
 <ee83587b-8a1c-3c4f-cc0f-7bc98afabae1@I-love.SAKURA.ne.jp>
 <CAHk-=wgQ2ovXMW=5ZHCpowkE1PwPQSL7oV4YXzBxd6eqNRXxnQ@mail.gmail.com>
 <87sgg6v8we.fsf@x220.int.ebiederm.org> <202005111428.B094E3B76A@keescook>
 <874kslq9jm.fsf@x220.int.ebiederm.org> <CAHk-=wjhmoGLcMgcDB0rT-n6waC+rdnjU3FRKAwSTMSG=gaK9Q@mail.gmail.com>
 <6f282d0a-b448-14e9-cd4f-92cce99cc36f@landley.net>
In-Reply-To: <6f282d0a-b448-14e9-cd4f-92cce99cc36f@landley.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 May 2020 12:51:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgYDMabsEDW_W3iU0jD8RhndQAMhR2HSMkMZ3rTCQbVg@mail.gmail.com>
Message-ID: <CAHk-=wjgYDMabsEDW_W3iU0jD8RhndQAMhR2HSMkMZ3rTCQbVg@mail.gmail.com>
Subject: Re: [PATCH 3/5] exec: Remove recursion from search_binary_handler
To:     Rob Landley <rob@landley.net>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
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

On Tue, May 12, 2020 at 7:32 PM Rob Landley <rob@landley.net> wrote:
>
> On 5/12/20 7:20 PM, Linus Torvalds wrote:
> > Ack. I think the AT_EXECFD thing is a sign that this isn't internal to
> > binfmt_misc, but it also shouldn't be gating this issue. In reality,
> > ELF is the only real binary format that matters - the script/misc
> > binfmts are just indirection entries - and it supports AT_EXECFD, so
> > let's just ignore the theoretical case of "maybe nobody exposes it".
>
> Would this potentially make the re-exec-yourself case easier to do at some
> point? (Which nommu needs to do, and /proc/self/exe isn't always available.)

AT_EXECFD may be an ELF thing, but normal ELF binaries don't do that
"we have a fd". So it only triggers for binfmt_misc (and only when the
flag is set for "I want the fd").

So no, this wouldn't help re-exec-yourself in general.

Although I guess we could add an ELF section note that does that whole
"executable fd" thing for other things too.

Everything is possible in theory..

               Linus
