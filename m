Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB2CC3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E013321569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZIpMsy4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgBLQzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 11:55:05 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45156 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgBLQzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 11:55:04 -0500
Received: by mail-oi1-f195.google.com with SMTP id v19so2637716oic.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 08:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lSkRhzJ0OgAeMcDZYCLOFCEGGgp2p5lC13LHYR1YgYQ=;
        b=ZIpMsy4qygjUeFX9wzK5ylo+se7CXBlKbUF6E5DO6YfLBLlgk0xfU1y+ioblr27Fxm
         XXRkd7e0QiBiV3hPCDz1YqWTFDcJe3Fgsk02FoO5u8ihRaB10mRZXKe8Oa75+g8N+t0U
         K2bfRy9ApAwR8kpZAdYe4JPB9Avx2l9v3UY6hANBGxx+DYJ7mGPe4pdbAGWsaRnnzFHv
         /ZDZS0IJQnbJhvBdCj487AMRSPTjkz5QPGPxaXmAGDK5fRgSdwZyklkRNsdY71SOBCR1
         EfooY1HX6JZQoaOc0VzGQeu5nEloIPJ9sE1dd0j/Z+YSPcbV1Ks5oKZpCCV/4ZuABw3B
         oZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lSkRhzJ0OgAeMcDZYCLOFCEGGgp2p5lC13LHYR1YgYQ=;
        b=Y3W9fvaGvTe9d3zdIGUuNvD/75Nal0XWC4rlV7zqUBVh7uYJuxYDwGujt4zC+lu+2k
         GmmfQzJuNaFM1xS2Ch4SdwBd8TjA7B+d9X6b2znF5RK2WN5wSyqSEks2twrN+tPR1d8E
         +0ex5ozhLffRTir6kMnF8bxMZjPJ7Zid8AW98RHZn7GIj5ERRPsjY2znppTuzn1KP7xz
         uNRKqOQVLw6wYxKXCzYb6y4b4mQXl76XOQnxrlpKkprU/TOp6eKnO4vSc8qN6fzARdJE
         FqRwezj1h5erBXZktSq1dG3iU6YgTXp3fvn+4H2D9YI5dN5jFcUduqBk2KjHCWWumZ82
         yNWg==
X-Gm-Message-State: APjAAAWurZXwSbf4FVrX8aMo/2VKQTFT4Ah1NCEIgeTZSwCiS0t+A1re
        po+h9JahH9H/E5MMFnPmKn5mnbCJr+0A+S1pgMTtZA==
X-Google-Smtp-Source: APXvYqzoTbEk701bRg/VO9uviBn9wmpzEP3oEimUqZD0CHfaNloke8F7mwUkUM+o+ZiLPAwclceH3ziLpTr9nY7+ZCI=
X-Received: by 2002:aca:1913:: with SMTP id l19mr6487887oii.47.1581526503068;
 Wed, 12 Feb 2020 08:55:03 -0800 (PST)
MIME-Version: 1.0
References: <20200211225547.235083-1-dancol@google.com> <202002112332.BE71455@keescook>
In-Reply-To: <202002112332.BE71455@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 12 Feb 2020 17:54:35 +0100
Message-ID: <CAG48ez0ogRxvCK1aCnviN+nBqp6gmbUD7NjaMKvA7bF=esAc1A@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Harden userfaultfd
To:     Kees Cook <keescook@chromium.org>
Cc:     Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Nick Kralevich <nnk@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Xu <peterx@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 8:51 AM Kees Cook <keescook@chromium.org> wrote:
> On Tue, Feb 11, 2020 at 02:55:41PM -0800, Daniel Colascione wrote:
> >   Let userfaultfd opt out of handling kernel-mode faults
> >   Add a new sysctl for limiting userfaultfd to user mode faults
>
> Now this I'm very interested in. Can you go into more detail about two
> things:
[...]
> - Why is this needed in addition to the existing vm.unprivileged_userfaultfd
>   sysctl? (And should this maybe just be another setting for that
>   sysctl, like "2"?)
>
> As to the mechanics of the change, I'm not sure I like the idea of adding
> a UAPI flag for this. Why not just retain the permission check done at
> open() and if kernelmode faults aren't allowed, ignore them? This would
> require no changes to existing programs and gains the desired defense.
> (And, I think, the sysctl value could be bumped to "2" as that's a
> better default state -- does qemu actually need kernelmode traps?)

I think this might be necessary for I/O emulation? As in, if before
getting migrated, the guest writes some data into a buffer, then the
guest gets migrated, and then while the postcopy migration stuff is
still running, the guest tells QEMU to write that data from
guest-physical memory to disk or whatever; I think in that case, QEMU
will do something like a pwrite() syscall where the userspace pointer
points into the memory area containing guest-physical memory, which
would return -EFAULT if userfaultfd was restricted to userspace
accesses.

This was described in this old presentation about why userfaultfd is
better than a SIGSEGV handler:
https://drive.google.com/file/d/0BzyAwvVlQckeSzlCSDFmRHVybzQ/view
(slide 6) (recording at https://youtu.be/pC8cWWRVSPw?t=463)
