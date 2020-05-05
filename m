Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A98C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 512032084D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rdomWIn1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbgEEORt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730381AbgEEORq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:17:46 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0324C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:17:45 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id j4so1720485otr.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oozv1CurdVXPxFbon25FvYaSVZOel7H+M9qpgBithxw=;
        b=rdomWIn1lx0/14x1MrCZ44PAia88FO1u5WiBJV0lCL873DmYOIw1RkG7EOjGN3DOcI
         BKnHqtLr5kIvTVt+46Qu6hkXUOFnxvrhJa4EE0BzJtBnyA6Li55vvUoguCqcceZsJErm
         391RDdGHZfcGrEiWCMc3cskTgI8jYOjW5gIgD1G+/tWjpRsya6AqsC+cCYxYQ7SsdB56
         tKXvgfRvmAXc3U64n7QaJ5BfrnxR2AVH0SulUJFFUX2ihfgEL0QS1jGLwMkTXtvdqcRs
         Ah5dfdU1SE40c+empSqBBAv6y4lhwPzQj8IfW4meGF3R74kI5zSC7IWGBB1/41Z+QkB5
         zb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oozv1CurdVXPxFbon25FvYaSVZOel7H+M9qpgBithxw=;
        b=DxpkA6FPdJN2pWlHhYN6A9bH7goEfnNQI3ouBI2iheu8JPYv+cVtUqmzUXstmis6Cs
         FYrlJZkNzRZrTKsQjvkEI/njoJUsYKcb93QIdtR1a94Je1WsOmuQUm5nOpLtuo5sIgLf
         NbOIvcZY+Nn3Pe3j5AzGqzMWHaK/Qk+RCqJ2gImABU+uTMFwXFXjg5UIDY4WYJDCJDMm
         auR1nKg2V/ReqjYpAV2XDzfHWvpys6YvNwLOVK7PcabVP8Ww0YO4CMn/ADETO3fErtqG
         QD6OiTkCbM4ZCCBfN4NkbweGMkFbFruF7fl2//VWLaym/EflOCVsb/djNSckIAETklGR
         JT8w==
X-Gm-Message-State: AGi0PuaBxzetkQj2dHOTMJFvcwCojvKBFhgmhkzmTgive/N4lIEXIGKx
        9Ih204TCoKXFSxsM2yfDZWQl/h3xtdevfsWxMsaMsw==
X-Google-Smtp-Source: APiQypKP35cQMElCXBeZ5zJhY0UyGhdCjBVmM/UfrXTaWR6qP6RM1rUh4lKu6tJwIpg3MUPBoQtobiEDYF6hoC0mYGs=
X-Received: by 2002:a9d:7589:: with SMTP id s9mr2210194otk.251.1588688264613;
 Tue, 05 May 2020 07:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200505141137.665940-1-arnd@arndb.de>
In-Reply-To: <20200505141137.665940-1-arnd@arndb.de>
From:   Marco Elver <elver@google.com>
Date:   Tue, 5 May 2020 16:17:33 +0200
Message-ID: <CANpmjNNwgkVR6kjFudrR4ga--PigU5Mx69HZ1mhCAQ0GCLqQGg@mail.gmail.com>
Subject: Re: [PATCH] kcsan: fix section mismatch for __write_once_size/blacklisted_initcalls
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alexander Potapenko <glider@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 May 2020 at 16:11, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Moving __write_once_size out of line causes a section mismatch warning
> with clang in one instance:
>
> WARNING: modpost: vmlinux.o(.text+0x8dc): Section mismatch in reference from the function __write_once_size() to the variable .init.data:blacklisted_initcalls
> The function __write_once_size() references
> the variable __initdata blacklisted_initcalls.
> This is often because __write_once_size lacks a __initdata
> annotation or the annotation of blacklisted_initcalls is wrong.
>
> Remove the __init_or_module annotation from the variable as a workaround.
>
> Fixes: dfd402a4c4ba ("kcsan: Add Kernel Concurrency Sanitizer infrastructure")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> So far, my randconfig checks found two such instances, one for read_once
> and one for write_once. There are probably a couple more in random
> configurations, but I guess they are rare enough that we can just work
> around them like this.

[+Cc Will]

Thanks for testing and fixing this. Note that this may no longer be
necessary once Will's patches land. Also noted here:
https://lkml.kernel.org/r/CANpmjNNw6M9Gqj6WGTHH4Cegu8roTVu5x6Vqs_tCBxX3gPwL4A@mail.gmail.com

For reference, Will's series:
https://lore.kernel.org/lkml/20200421151537.19241-1-will@kernel.org/

Thanks,
-- Marco


> ---
>  init/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/init/main.c b/init/main.c
> index 8f78399697e3..441c384a73cd 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1020,7 +1020,7 @@ struct blacklist_entry {
>         char *buf;
>  };
>
> -static __initdata_or_module LIST_HEAD(blacklisted_initcalls);
> +static LIST_HEAD(blacklisted_initcalls);
>
>  static int __init initcall_blacklist(char *str)
>  {
> --
> 2.26.0
>
