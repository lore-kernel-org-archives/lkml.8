Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7167BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 06:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C5EC207ED
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 06:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="vnwXky2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgFEGGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 02:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgFEGGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 02:06:47 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D59C08C5C2
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 23:06:47 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id x93so6484927ede.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 23:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I0e6wuwvfc4O/N1ElVRQyamkuRzorrjrFf6chH6dVdA=;
        b=vnwXky2nNWr8II/vtU4PUoe2WZ/P3/k0fZi7aBpDk2Jb+pHsdmlXaCnQfm7NMC3yic
         8VQNaneB52KzN4+Bq4v9EWyFtkOCzfPrRqwJ9asTZD820tGbr24FEruYzUTTeICrPgLH
         OZl4YP6/atwTjmDIRs1p108dwWRN9f5kEkGYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I0e6wuwvfc4O/N1ElVRQyamkuRzorrjrFf6chH6dVdA=;
        b=JCj1gYl+sch0uNmwFTR9t9NBpOB3x+Wn/Bw+I6rZHjvhSPFmzvHjTvLGTN660wwCvH
         jNhJz0a1RZIIw3ujKwpMj/JQ9dC6TdvXvsfeT69a/9Fjgv23o4ryvTTLDaDeQXWmGKMY
         yASr+4liPs1/J7yHCd3ZBN/h4/CqYueXnIj5QrgRJlQlQtHrUeUfB0Mz9scRXjpQ9UD9
         CfwMXjY/hnoqYVOTj/vQXGctZDBV9iz6xu8o/YkJFdAwIasH5z8MQKj072DvfJeFfNLy
         D3VsWHJJgu0v214pkLAwz7pET1vkOSBBgkjmS/ur9MMWblIMz9T7fYuY4/71vG8PPHr3
         vjow==
X-Gm-Message-State: AOAM531rl4DkZQ9W6MLW6jMPN/kzZztBLJcpDNpewcEA9q+2Zura6LDQ
        bjPTQkSF5M6zQVM6uCyfKMLhzePkwDc/zoSulQqgLA==
X-Google-Smtp-Source: ABdhPJxMC1d+LqzxSwRL/ssVtqfJGiWPpfH3U2HfyrhUbz080LI+O9WCidUCNyhHUPeYJdIc/2u+DmlTlbZGQPQrYpE=
X-Received: by 2002:a05:6402:b37:: with SMTP id bo23mr7937529edb.24.1591337205697;
 Thu, 04 Jun 2020 23:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200530055953.817666-1-krisman@collabora.com>
In-Reply-To: <20200530055953.817666-1-krisman@collabora.com>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Thu, 4 Jun 2020 23:06:09 -0700
Message-ID: <CAMp4zn--RbHeViLOmRi4USE7hwTNhVqASJJJeXjCkOah5R4-0A@mail.gmail.com>
Subject: Re: [PATCH RFC] seccomp: Implement syscall isolation based on memory areas
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        kernel@collabora.com, Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Gofman <gofmanp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 11:01 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Modern Windows applications are executing system call instructions
> directly from the application's code without going through the WinAPI.
> This breaks Wine emulation, because it doesn't have a chance to
> intercept and emulate these syscalls before they are submitted to Linux.
>
> In addition, we cannot simply trap every system call of the application
> to userspace using PTRACE_SYSEMU, because performance would suffer,
> since our main use case is to run Windows games over Linux.  Therefore,
> we need some in-kernel filtering to decide whether the syscall was
> issued by the wine code or by the windows application.
>
> The filtering cannot really be done based solely on the syscall number,
> because those could collide with existing Linux syscalls.  Instead, our
> proposed solution is to trap syscalls based on the userspace memory
> region that triggered the syscall, as wine is responsible for the
> Windows code allocations and it can apply correct memory protections to
> those areas.
>
> Therefore, this patch reuses the seccomp infrastructure to trap
> system calls, but introduces a new mode to trap based on a vma attribute
> that describes whether the userspace memory region is allowed to execute
> syscalls or not.  The protection is defined at mmap/mprotect time with a
> new protection flag PROT_NOSYSCALL.  This setting only takes effect if
> the new SECCOMP_MODE_MEMMAP is enabled through seccomp().
>
> It goes without saying that this is in no way a security mechanism
> despite being built on top of seccomp, since an evil application can
> always jump to a whitelisted memory region and run the syscall.  This
> is not a concern for Wine games.  Nevertheless, we reuse seccomp as a
> way to avoid adding a new mechanism to essentially do the same job of
> filtering system calls.
>
> * Why not SECCOMP_MODE_FILTER?
>
> We experimented with dynamically generating BPF filters for whitelisted
> memory regions and using SECCOMP_MODE_FILTER, but there are a few
> reasons why it isn't enough nor a good idea for our use case:
>
> 1. We cannot set the filters at program initialization time and forget
> about it, since there is no way of knowing which modules will be loaded,
> whether native and windows.  Filter would need a way to be updated
> frequently during game execution.
>
> 2. We cannot predict which Linux libraries will issue syscalls directly.
> Most of the time, whitelisting libc and a few other libraries is enough,
> but there are no guarantees other Linux libraries won't issue syscalls
> directly and break the execution.  Adding every linux library that is
> loaded also has a large performance cost due to the large resulting
> filter.
>
> 3. As I mentioned before, performance is critical.  In our testing with
> just a single memory segment blacklisted/whitelisted, the minimum size
> of a bpf filter would be 4 instructions.  In that scenario,
> SECCOMP_MODE_FILTER added an average overhead of 10% to the execution
> time of sysinfo(2) in comparison to seccomp disabled, while the impact
> of SECCOMP_MODE_MEMMAP was averaged around 1.5%.
>
> Indeed, points 1 and 2 could be worked around with some userspace work
> and improved SECCOMP_MODE_FILTER support, but at a high performance and
> some stability cost, to obtain the semantics we want.  Still, the
> performance would suffer, and SECCOMP_MODE_MEMMAP is non intrusive
> enough that I believe it should be considered as an upstream solution.
>
> Sending as an RFC for now to get the discussion started.  In particular:
I have a totally different question. I am experimenting with a
patchset which is designed
to help with the "extended syscall" case (as Kees calls it).
Effectively syscalls like openat2,
where the syscall arguments are passed as a (potentially mixed size)
structure need to be
able to be inspected through user notif. `We can kind-of deal with
this with other syscalls
with mechanisms like pidfd_getfd, addfd, and potentially being able to
(re)set the registers
prior to actual invocation of the syscall. Unfortunately, you cannot
do the same trick with
user memory, because it opens you up to a time-of-check, time-of-use
attack, since the
kernel copies the syscall arguments from the invoking program again.

One of the things I've been experimenting with is using tricks like
userfaultfd / mprotect to
try to deal with this. I think that I might have to add some
capability to the kernel to actually
deal with this. In general, the approach is:
1. Syscall is invoked, and wakes up the manager
2. The manager gets the arguments, and a handle (either the ID, or an
FD). It then uses this
ID to read memory. Either something like process_vm_readv, an ioctl, or read.
3. When the kernel reads these arguments, it splits the VMA for the
address the pointer
lies in, and sets up access() with a special mapping that checks if
the page has been
tampered with by userspace in the read ranges between the manager read
and the writes.
We can either SIGBUS or stall writes to the range if we want to make
things "simple",
or we can mess with uaccess bits and EPERM if the kernel tries to read
that memory.
4. When the syscall returns, or the kernel writes to that area, we
reset the mapping.

I'm wondering if you're dynamically generating these special mappings
with protection,
and how many of them you're generating. How often are you generating them? What
kind of performance cost do you see in normal programs?
