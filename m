Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C139C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 00:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F22FF207BC
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 00:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbgEaA0Y convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 20:26:24 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53074 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbgEaA0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 20:26:23 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id CA2402A0357
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Gofman <gofmanp@gmail.com>
Subject: Re: [PATCH RFC] seccomp: Implement syscall isolation based on memory areas
Organization: Collabora
References: <20200530055953.817666-1-krisman@collabora.com>
        <AF65147C-15DB-4BA4-A08B-55676B489BA5@amacapital.net>
Date:   Sat, 30 May 2020 20:26:17 -0400
In-Reply-To: <AF65147C-15DB-4BA4-A08B-55676B489BA5@amacapital.net> (Andy
        Lutomirski's message of "Sat, 30 May 2020 15:09:47 -0700")
Message-ID: <85367hkl06.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@amacapital.net> writes:

>> On May 29, 2020, at 11:00 PM, Gabriel Krisman Bertazi <krisman@collabora.com> wrote:
>> 
>> ﻿Modern Windows applications are executing system call instructions
>> directly from the application's code without going through the WinAPI.
>> This breaks Wine emulation, because it doesn't have a chance to
>> intercept and emulate these syscalls before they are submitted to Linux.
>> 
>> In addition, we cannot simply trap every system call of the application
>> to userspace using PTRACE_SYSEMU, because performance would suffer,
>> since our main use case is to run Windows games over Linux.  Therefore,
>> we need some in-kernel filtering to decide whether the syscall was
>> issued by the wine code or by the windows application.
>
> Do you really need in-kernel filtering?  What if you could have
> efficient userspace filtering instead?  That is, set something up so
> that all syscalls, except those from a special address, are translated
> to CALL thunk where the thunk is configured per task.  Then the thunk
> can do whatever emulation is needed.

Hi,

I suggested something similar to my customer, by using
libsyscall-intercept.  The idea would be overwritting the syscall
instruction with a call to the entry point.  I'm not a specialist on the
specifics of Windows games, (cc'ed Paul Gofman, who can provide more
details on that side), but as far as I understand, the reason why that
is not feasible is that the anti-cheat protection in games will abort
execution if the binary region was modified either on-disk or in-memory.

Is there some mechanism to do that without modiyfing the application?

> Getting the details and especially the interaction with any seccomp
> filters that may be installed right could be tricky, but the performance
> should be decent, at least on non-PTI systems.
>
> (If we go this route, I suspect that the correct interaction with
> seccomp is that this type of redirection takes precedence over seccomp
> and seccomp filters are not invoked for redirected syscalls. After all,
> a redirected syscall is, functionally, not a syscall at all.)
>


-- 
Gabriel Krisman Bertazi
