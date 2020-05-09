Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D786C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 19:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23D1620722
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 19:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589051910;
	bh=NHH4y//VKaDr/rrlB9l7Pq3HdVIH7OjborNmD9OkkPU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sF5KpbErRVYgsgC3Lwpu1/Ds0TH+Qdp0n6OlT+OeKwJ1cXOeOj3JzlZmZDK0XIvVZ
	 HHtkFw3vqIYQ/rWjUZvRMomBkHUqD3KkO7VpvwBnhHftks6aZOPYQYi4JEdqQVs6Pu
	 ZAR9Qu4WdLIeJAgNfUiBIv7+WhqXNVQ5/rrG4yTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgEITS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 15:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727938AbgEITS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 15:18:28 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B8CC061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 12:18:28 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id j3so5188553ljg.8
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 12:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MTaQjuSq7+Uk0mjz5XhiS0By4Z0ZIBHeP5OQxoY0AXY=;
        b=bb8lv33/xdxQCjzNvqgBwiUcCYj652YvhdbqcvSHcY1rj9neVWryv4l1j6MmeGq4jo
         AEH6Z8NxA7GKp1r/srByCIJnplyXBSDQ62DfynP6rinchtYP4IYYLHytr7y6o8ZD6J1K
         ZVP3pi5JLSulmR+djlIuZSg8uAVtxAHd0IwZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MTaQjuSq7+Uk0mjz5XhiS0By4Z0ZIBHeP5OQxoY0AXY=;
        b=RK2JwdIny9thhrOENM6DucFDF08JHpENIF7LxtJr7N3E0FIyN8zElG82AcjkUkOWbr
         AUi3UWGJ3NwQp562F4xHegi4OkO0gHKIjGhST+RV641bN31je2iatsgpacwlbiQoQRqU
         QIWlTSicz4oaXSejXMqbxjiD0bSgaRFw3OWO1eEMNPULdlFCiK4SZXbEjs8+yLuqCAzQ
         WCoYfsOKTAqaZ7ohQaLkez2xRrVzYWuI5p2E31sUncUibIH/Tk/tdtsO7qdFFiuGg/e/
         akm+dH+s6lxiKu3/VGTFZ+gE9CoQPy33JW8J8nYEknXSgz2akOOh7j8V2lxmNxikuetA
         nZCQ==
X-Gm-Message-State: AOAM532pNd2yo1tkEi2GbYrr5w06T8mLzPLmbQjKXn2SbnmRG6bGGfZB
        N93doKj8WGSeI15cHQidd+VzzautNpc=
X-Google-Smtp-Source: ABdhPJxzi+q0bscUQoeXoxqypFexSKhKEiKNtm2YtF5Lp+LODCaoES0lMkV744XhL/gMT0xY+H6p+Q==
X-Received: by 2002:a2e:8018:: with SMTP id j24mr5568784ljg.246.1589051905347;
        Sat, 09 May 2020 12:18:25 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id m132sm4894291lfa.94.2020.05.09.12.18.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 12:18:23 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id a4so4098331lfh.12
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 12:18:23 -0700 (PDT)
X-Received: by 2002:ac2:418b:: with SMTP id z11mr5854254lfh.30.1589051902927;
 Sat, 09 May 2020 12:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <87h7wujhmz.fsf@x220.int.ebiederm.org> <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87blmy6zay.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87blmy6zay.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 May 2020 12:18:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wguq6FwYb8_WZ_ZOxpHtwyc0xpz+PitNuf4pVxjWFmjFQ@mail.gmail.com>
Message-ID: <CAHk-=wguq6FwYb8_WZ_ZOxpHtwyc0xpz+PitNuf4pVxjWFmjFQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] exec: Stop open coding mutex_lock_killable of cred_guard_mutex
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 11:48 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>
> Oleg modified the code that did
> "mutex_lock_interruptible(&current->cred_guard_mutex)" to return
> -ERESTARTNOINTR instead of -EINTR, so that userspace will never see a
> failure to grab the mutex.
>
> Slightly earlier Liam R. Howlett defined mutex_lock_killable for
> exactly the same situation but it does it a little more cleanly.

What what what?

None of this makes sense. Your commit message is completely wrong, and
the patch is utter shite.

mutex_lock_interruptible() and mutex_lock_killable() are completely
different operations, and the difference has absolutely nothing to do
with  -ERESTARTNOINTR or -EINTR.

mutex_lock_interruptible() is interrupted by any signal.

mutex_lock_killable() is - surprise surprise - only interrupted by
SIGKILL (in theory any fatal signal, but we never actually implemented
that logic, so it's only interruptible by the known-to-always-be-fatal
SIGKILL).

> Switch the code to mutex_lock_killable so that it is clearer what the
> code is doing.

This nonsensical patch makes me worry about all your other patches.
The explanation is wrong, the patch is wrong, and it changes things to
be fundamentally broken.

Before this, ^C would break out of a blocked execve()/ptrace()
situation. After this patch, you need special tools to do so.

This patch is completely wrong.

And Kees, what the heck is that "Reviewed-by" for? Worthless review too.

                Linus
