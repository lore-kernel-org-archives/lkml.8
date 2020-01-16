Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A306C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 20:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC9420730
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 20:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dryW2bgx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388024AbgAPUgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:36:15 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:39068 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729637AbgAPUgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 15:36:15 -0500
Received: by mail-vk1-f193.google.com with SMTP id t129so6054447vkg.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 12:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RV6fXTo3b3qoT7vSlLu9LZXPKWnKYVEBYLBa7aJ3coE=;
        b=dryW2bgxQT3TcmKHyF7k3/UkFi2E2Qunh6WctF3kjeRnNJDiSxf7obYQetkLkkmU/f
         rsRO4G1R9NHiQfiB7IbS/g3e201MDYpYRfm3I3lKZQuJ6YOovOwoFVhI0kbjkNwOxZtP
         m0dEx+VXLI9Cl6w4dCABDOZNZ3pChr94FxH3Dz3EX4sWv6ulIjkhtRpxwc+9VzwfxebA
         cjQgmaLfTXvQy+lU5KMD7jPpMrGjZ09Pd0UPfHvYS5HSHD7Naska9ofDRIcdvtGMBkNE
         kQkpg/ELqolO16Xjr3izfosdUsgTcuHhXOL5clFLaqYqXnnDVzR4Q0VRcIwAYcdwoE7u
         IvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RV6fXTo3b3qoT7vSlLu9LZXPKWnKYVEBYLBa7aJ3coE=;
        b=tNhX/dPUUOBon9FKfbtIFtGUGlHEjTVW+FdifQsZP7xVTXI954paflMC3VdfdjVSwP
         XcSveyEkbRwuyx51NYJpHIg/CiblBVu/c/l/d2ZAxUgk2+64IiOSsEbqSh6n7OyuVT3E
         8BSbvOLaNC8dnuCoW7A9LczhGgrIWQSuMQWwwyydqU1FblAmrnrQ5BgPGGFkDC3S31H2
         4bUwYjMmd2Ofs7jf6oV0g8HMTBw4vD17CLmhmfyR1jeb9he9lL7iruD9g+AwnNsmfpUr
         JacUl2UUXVpnZLWPkDkHW/nbR4v6UOQXvJpGMDT1BQVWs32spOHQ4/PJ38XdtuvR45Hf
         ebfg==
X-Gm-Message-State: APjAAAVaewlAN0Krk01V+Mq7J71Ik6L//YSzYpgL1VPXNXXsEOOV5d+1
        r3wCth48K4LKwJHlRzBjAQ5A49Z3TGNgCwYHQkk12w==
X-Google-Smtp-Source: APXvYqy3hookrrU/Buxl44KY5o3vqIMbrfDIWbbyEY39r9m+d/9XpIDAayToTJcBMK5GJtdqCaMmmDL594aQGbaPCAk=
X-Received: by 2002:a1f:2910:: with SMTP id p16mr18939592vkp.71.1579206972944;
 Thu, 16 Jan 2020 12:36:12 -0800 (PST)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191206221351.38241-1-samitolvanen@google.com> <20191206221351.38241-12-samitolvanen@google.com>
 <20200116174450.GD21396@willie-the-truck>
In-Reply-To: <20200116174450.GD21396@willie-the-truck>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 16 Jan 2020 12:36:01 -0800
Message-ID: <CABCJKudsTFd22NzB9JdzrAo2UFzsfNVtB_zvdRiAEBXAC9t3=g@mail.gmail.com>
Subject: Re: [PATCH v6 11/15] arm64: efi: restore x18 if it was corrupted
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 9:45 AM Will Deacon <will@kernel.org> wrote:
>
> On Fri, Dec 06, 2019 at 02:13:47PM -0800, Sami Tolvanen wrote:
> > -0:   b       efi_handle_corrupted_x18        // tail call
> > +0:
> > +#ifdef CONFIG_SHADOW_CALL_STACK
> > +     /*
> > +      * Restore x18 before returning to instrumented code. This is
> > +      * safe because the wrapper is called with preemption disabled and
> > +      * a separate shadow stack is used for interrupts.
> > +      */
> > +     mov     x18, x2
> > +#endif
>
> Why not restore it regardless of CONFIG_SHADOW_CALL_STACK?

The ifdefs are here only because restoring the register without SCS
isn't actually necessary, but I'm fine with dropping them (and editing
the comment) in the next version if you prefer.

Sami
