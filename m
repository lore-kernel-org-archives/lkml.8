Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFE6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E55DB20781
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vAPFLYGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733222AbgFWQqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733145AbgFWQqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:46:08 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5272C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 09:46:07 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d7so12036579lfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 09:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+bSkao1fR/aZzYYv4AgeUsmuwtpx/y/7K+5PiaFCLy8=;
        b=vAPFLYGu1TdA30k3D08MHCeAkwEDvRhNs6PPhjyJjuF+0UYCT9ld58PdBbl9mMkeG5
         OaKeZnn9K3qfJSFl3Ve0o6TUQIlE/4mGqgscomjGr4wm1k1Fb0ha1jI1ct2a9w66B+Ug
         bA8QOC5p/gjEu5cZIisWh4eQcCy5Q//aGLLlRmV9zaRlCGe6sXFl17zFIhblBNTDK/uv
         DB7bSWFWD5Jvk88VgiGJHojELn8qUWBE4Ma00iKPUxVOq6EfaqIxw1tSh4j73A7I+rQM
         Tfoy2Bf6YA09AkGwJuOvDlH18+GzqhmcgeMyYqBJ2At+nmhvQ+uHDDeZ1anVuZyUR6km
         w/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+bSkao1fR/aZzYYv4AgeUsmuwtpx/y/7K+5PiaFCLy8=;
        b=JXaw+D+iOJAWcQgTKCRGR0ZVISxNr7Mwa7LaVkqMoP2PKfTiUCqY+HEN5NCmw2U+fP
         1i8bAyQfXn3pZq5XXaUqL12FPX4gUJgzsInODfhJndvc4oH7EZl610rp3W3RdBppPk/B
         yjEv4+yCxI+VCoY/BudAa1peUjgUprr72xkDsNDz9qmKBPFReSB2jPrp1IQSS93KRxsv
         R21g6YLQIvpDDrgwkJAoOfJDWCWLQ1zkDxQhcVxe1uAS79qwMIIt4IzlE40zoYnCV55d
         IyNhjd3WWVNqps2jf9PdR+6Im8OCOgsD8lY5wPP2TAHx3imqFXhe+1N6rUFWRiMK9ove
         4fKw==
X-Gm-Message-State: AOAM53212PpZkzruND2+HdExnj8PW7AL5yNLHfoGv6FjR2TpfNJUN4eJ
        k4ib5qeX3hPq2NwtoKOFzCKNseC0k3zbbUiIJealWQ==
X-Google-Smtp-Source: ABdhPJyxYp3qmMEokG6vwqfhfNOtgNzGbZsd3cPd5dvqCf6z2xa0umo3bDc03vKMX148XTHkBGPB3IHs3rFkWwFJ66U=
X-Received: by 2002:a19:be4b:: with SMTP id o72mr13004763lff.141.1592930764708;
 Tue, 23 Jun 2020 09:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200623162958.331051-1-dima@arista.com> <20200623162958.331051-3-dima@arista.com>
In-Reply-To: <20200623162958.331051-3-dima@arista.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 23 Jun 2020 18:45:38 +0200
Message-ID: <CAG48ez3v9dHq1+jvPmvQapFRji=4XhA8iNurTGZeC6xoy7Qc1w@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86/dumpstack: Add log_lvl to __show_regs()
To:     Dmitry Safonov <dima@arista.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 6:30 PM Dmitry Safonov <dima@arista.com> wrote:
> show_trace_log_lvl() provides x86 platform-specific way to unwind
> backtrace with a given log level. Unfortunately, registers dump(s) are
> not printed with the same log level - instead, KERN_DEFAULT is always
> used.
>
> Arista's switches uses quite common setup with rsyslog, where only
> urgent messages goes to console (console_log_level=KERN_ERR), everything
> else goes into /var/log/ as the console baud-rate often is indecently
> slow (9600 bps).
>
> Backtrace dumps without registers printed have proven to be as useful as
> morning standups. Furthermore, in order to introduce KERN_UNSUPPRESSED
> (which I believe is still the most elegant way to fix raciness of sysrq[1])
> the log level should be passed down the stack to register dumping
> functions. Besides, I have a potential use-case for printing traces
> with KERN_DEBUG level [2] (where registers dump shouldn't appear with
> higher log level).
>
> Add log_lvl parameter to __show_regs().
> Keep the used log level intact to separate visible change.

This change seems like a good idea to me; just one small nit:

[...]
>  void show_regs(struct pt_regs *regs)
>  {
> +       int print_kernel_regs;
> +
>         show_regs_print_info(KERN_DEFAULT);
>
> -       __show_regs(regs, user_mode(regs) ? SHOW_REGS_USER : SHOW_REGS_ALL);
> +       print_kernel_regs = user_mode(regs) ? SHOW_REGS_USER : SHOW_REGS_ALL;
> +       __show_regs(regs, print_kernel_regs, KERN_DEFAULT);

print_kernel_regs should probably have type "enum show_regs_mode"?
