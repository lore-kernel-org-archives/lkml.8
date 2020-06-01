Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18828C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF621206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyfftR8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgFAJXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgFAJXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:23:35 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE24EC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 02:23:34 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id y18so6180715iow.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 02:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Ma2feR+AOUh5xE+ib2Z3PKlkaj20ICx4TIEHRefbEws=;
        b=HyfftR8BXmm+yTUSV+fA+XiBhYg28LDT/sn4r2/jCBDA7pq2Tdk7bs3mi5sAZQe79f
         ARnMCI0HF1dt8OQYqh7o9MgJ6ydhdwgxoWcwuUcf2evEAYAcmXqszkBVdSr2H3WJDsVu
         quB6jO3Jq9+UUH7xKZNNHplnX7hzWBACLZZFNBo+n2Rkku+ftCylBb/gT/0hgvqKfWFx
         sBQWA2dK2LLybI9owaE/S2Fr2K96qmDcQjx+TqHJNzNiWshHr16k8AdBFjkKUZBMA2xM
         OhYeodoZXNCcuu4f5GYwQa7/QddY6OKIippJTFcCaMnG07BCzwWfZsRvlrPIhD1H7cpw
         urPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Ma2feR+AOUh5xE+ib2Z3PKlkaj20ICx4TIEHRefbEws=;
        b=T0MDVcroSvyzHUvcInc0aKvn1KtdOzeazFAlQB1h4CY3vSMMlw+LbSFtYGJhH+XDCN
         E42AKolwyQKlDbJBvsjXiUeWFOlzkjWIxe8So7KBY7OEaUwQRolsWF/CRDyeP6D9AnAR
         1hS8A/VBrU6JrXedQVVehp4iIh52XJDzuSoA492i4QwZVxw2P5pmH9xSM3GkdXRuhkuU
         K7FVm0yHeR4iFcHOUl6TPR6Wa/x99kSjwfwI/mfdJTmt31Z7XxUBZRQvBLG4EQ0gPElT
         ZuMng1akX1mq5T6R/Oy56yoUM53B8je0VVjOiEx2gAVWI/nyTYlzwjoiyiYsXSBZdAKL
         wlIQ==
X-Gm-Message-State: AOAM532PIhWtHFdL67uwuEoHCEbxWYf8JO5SrW6t7mOu6hHZ75K/oY1q
        Z9Jx6pC4/RfZO6qvaNCDWrtmuLJQG1eSO7VCiUGUvRAqfOA=
X-Google-Smtp-Source: ABdhPJzFaXxb2niVurpOjlQPS0/LNU74ahpB1bbR9UCt0JKoEIQgU8DSYCgPUJG9gFitymutJHMUxH9STBAvSysOfzo=
X-Received: by 2002:a02:84c6:: with SMTP id f64mr8046757jai.25.1591003414074;
 Mon, 01 Jun 2020 02:23:34 -0700 (PDT)
MIME-Version: 1.0
From:   Billy Laws <blaws05@gmail.com>
Date:   Mon, 1 Jun 2020 10:23:23 +0100
Message-ID: <CAFUUQHO57YpWJv6oGmxXsOBxCzRG1ti_Q1QBDw8FU+4vBOPgBw@mail.gmail.com>
Subject: Re: [PATCH RFC] seccomp: Implement syscall isolation based on memory areas
To:     krisman@collabora.com
Cc:     gofmanp@gmail.com, hpa@zytor.com, keescook@chromium.org,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, luto@amacapital.net, tglx@linutronix.de,
        wad@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On May 30, 2020, at 5:26 PM, Gabriel Krisman Bertazi <krisman@collabora.c=
om> wrote:
>
> =EF=BB=BFAndy Lutomirski <luto@amacapital.net> writes:
>
>>>> On May 29, 2020, at 11:00 PM, Gabriel Krisman Bertazi <krisman@collabo=
ra.com> wrote:
>>>
>>> =EF=BB=BFModern Windows applications are executing system call instruct=
ions
>>> directly from the application's code without going through the WinAPI.
>>> This breaks Wine emulation, because it doesn't have a chance to
>>> intercept and emulate these syscalls before they are submitted to Linux=
.
>>>
>>> In addition, we cannot simply trap every system call of the application
>>> to userspace using PTRACE_SYSEMU, because performance would suffer,
>>> since our main use case is to run Windows games over Linux.  Therefore,
>>> we need some in-kernel filtering to decide whether the syscall was
>>> issued by the wine code or by the windows application.
>>
>> Do you really need in-kernel filtering?  What if you could have
>> efficient userspace filtering instead?  That is, set something up so
>> that all syscalls, except those from a special address, are translated
>> to CALL thunk where the thunk is configured per task.  Then the thunk
>> can do whatever emulation is needed.
>
> Hi,
>
> I suggested something similar to my customer, by using
> libsyscall-intercept.  The idea would be overwritting the syscall
> instruction with a call to the entry point.  I'm not a specialist on the
> specifics of Windows games, (cc'ed Paul Gofman, who can provide more
> details on that side), but as far as I understand, the reason why that
> is not feasible is that the anti-cheat protection in games will abort
> execution if the binary region was modified either on-disk or in-memory.
>
> Is there some mechanism to do that without modiyfing the application?

Hi,

I work on an emulator for the Nintendo Switch that uses a similar technique=
,
in our testing it works very well and is much more performant than even
PTRACE_SYSEMU.

To work around DRM reading the memory contents I think mprotect could
be used, after patching the syscall a copy of the original code could be
kept somewhere in memory and the patched region mapped --X.
With this, any time the DRM attempts to read to the patched region and
perform integrity checks it will cause a segfault and a branch to the
signal handler. This handler can then return the contents of the original,
unpatched region to satisfy them checks.

Are memory contents checked by DRM solutions too often for this to be
performant?
--
Billy Laws
>
>> Getting the details and especially the interaction with any seccomp
>> filters that may be installed right could be tricky, but the performance
>> should be decent, at least on non-PTI systems.
>>
>> (If we go this route, I suspect that the correct interaction with
>> seccomp is that this type of redirection takes precedence over seccomp
>> and seccomp filters are not invoked for redirected syscalls. After all,
>> a redirected syscall is, functionally, not a syscall at all.)
>>
>
>
> --
> Gabriel Krisman Bertazi
