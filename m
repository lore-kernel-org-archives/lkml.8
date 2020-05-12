Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA5AC2D0FB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 23:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FF9520747
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 23:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SrKIZ8AE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731717AbgELXvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 19:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729646AbgELXvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 19:51:32 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC70C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 16:51:32 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id e6so10164157pjt.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 16:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7+F4liAaMr4vgR2fMURd01YkZSvvte2W6gqbbzWKG5c=;
        b=SrKIZ8AEXY1eEqueHNpwaWV+9SfeA1ktJrITPsb+4ODj2OLx3HeoWSVg4b1yiBK0kk
         6MROIbFjB6t0AOStv7l25VgYcJLvH4J1cFT3bMK+Hb/sttDC/HHYMSJ6wqV0ytmucRxo
         Vv6Ki9QiL8gnNgKQeoJ6ivZeumPVZXIHJ2kXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7+F4liAaMr4vgR2fMURd01YkZSvvte2W6gqbbzWKG5c=;
        b=qR8ecEJYu8+GNYohpkowGur4Poav1jODz6jwVU8NtDb6AMCtKmjpiJIxLSwZe2IHDC
         hhOkenkkPhSBv8+1Rkr8HuniqLAJn0SVeM3zVjr/eIcNY38D6DGWf3vfI9VjqlZPYvjo
         nnNH+HptVWTdEwlhYsJjPR0xUQ7yG7qNgxNpT2MnmtIWTq1RH2pQwN4OzD+YxX6J2Ytq
         xrCxeC649HUpDY5pr8C+kf1pxVAMO28kwKdOShFIvKT7EL0HgZAvZZADjFfYZEwatzcX
         YEPWAjY1VNNdn6il8fAkl9B2+d3uFOsd9lV1Yh6Jj28cx1h7QbTWwljrL1BuBADa5bhR
         1x1w==
X-Gm-Message-State: AGi0PuYc8J6pNYRYKKsxxemHqDFbTHEydpXzwT6jWS4EhW63NSUgNSP2
        VyajyyPCrA6m8Lgw2Wy03CoUKA==
X-Google-Smtp-Source: APiQypIsjXL5Mme58Z3NS8DKdjPSdKDukPTRuwRTh1n5ysNxcgUm6R8R0NcxFEIPIOiwow+wowUAow==
X-Received: by 2002:a17:902:ec04:: with SMTP id l4mr22412099pld.6.1589327491660;
        Tue, 12 May 2020 16:51:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o11sm2521576pfd.195.2020.05.12.16.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 16:51:30 -0700 (PDT)
Date:   Tue, 12 May 2020 16:51:29 -0700
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
Message-ID: <202005121649.4ED677068@keescook>
References: <87eerszyim.fsf_-_@x220.int.ebiederm.org>
 <ee83587b-8a1c-3c4f-cc0f-7bc98afabae1@I-love.SAKURA.ne.jp>
 <CAHk-=wgQ2ovXMW=5ZHCpowkE1PwPQSL7oV4YXzBxd6eqNRXxnQ@mail.gmail.com>
 <87sgg6v8we.fsf@x220.int.ebiederm.org>
 <202005111428.B094E3B76A@keescook>
 <874kslq9jm.fsf@x220.int.ebiederm.org>
 <202005121218.ED0B728DA@keescook>
 <87lflwq4hu.fsf@x220.int.ebiederm.org>
 <202005121606.5575978B@keescook>
 <202005121625.20B35A3@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005121625.20B35A3@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 04:47:14PM -0700, Kees Cook wrote:
> And now I wonder if qemu actually uses the resulting AT_EXECFD ...

It does, though I'm not sure if this is to support crossing mount points,
dropping privileges, or something else, since it does fall back to just
trying to open the file.

    execfd = qemu_getauxval(AT_EXECFD);
    if (execfd == 0) {
        execfd = open(filename, O_RDONLY);
        if (execfd < 0) {
            printf("Error while loading %s: %s\n", filename, strerror(errno));
            _exit(EXIT_FAILURE);
        }
    }


-- 
Kees Cook
