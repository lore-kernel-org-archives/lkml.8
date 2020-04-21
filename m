Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4121C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A81502068F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZjX3j8sm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgDUQAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725990AbgDUQAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:00:34 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC773C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:00:33 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id s30so12010518qth.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AZagKMhvqegGN0RLQLAf+rG+Y2ig252qO17Y9qpx3hU=;
        b=ZjX3j8smlRYUPfWug6JsDukSJL4cH/rHBmw/aXTkcYDzEywbZB97G58qYiynYOmHH3
         NXCAAPr0m9geM13tNbSvXVVVbgHcmcxSQbpwcE8XKEgnPhzwdyVaaYSdpVHyshK9aec3
         /KtvlyLXSc1srOoPVDxnKI6zmjLB1LzmaAWTyUjEGMp+Yc0X/wlcT9dSCtiVeK1Le+cE
         jVIHFHDfL6IAPx81oosA27TxmjGkrLxTdWF9+yHWm4OZ/SFnXQWqhs85FbKicKhf/Mb/
         O8sO5Hda6ol8f4MiMqsXmJeAAnYyfI9r0D0E1mLg0APXIaC8wo51bDnVg0l2AxLwaDnz
         NJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AZagKMhvqegGN0RLQLAf+rG+Y2ig252qO17Y9qpx3hU=;
        b=ZlX6bXufalXllgTxZmvMgJHW96sbae4jK7eKmL7vPJ74aE/Q9b7B0N+1Sa5bl7gJaI
         O6fuct0++aJCWnE+NDAJ00vE22ohHFXB9wK8x3A1l813bKBSb8/J+DY4ErbmKko1v1s9
         S7egIOdcfuP6KJG0jCMntFEeXJAu9KF2IhO+2lbC4g+ASdFd8zUreObIxMURCMyYcMNi
         YkHfUBOuql1ItdVBXkyB6kWjCc/8FUWk0EPRToHeHxBXYDC4SjMPfX6NVyEmIBw+pin8
         cxs0eTZK9dOw3X3QQUEq005rjDZ13XbvOHOXtKdlI375opWU4mwLCgYqSqMq0EMM6bfh
         piaA==
X-Gm-Message-State: AGi0PuZs7A0t9e2KfsBKM2ib8hJOaDwDqEZXwAeSsWQxQcoZBpq8+E3X
        mg7mUaqp5fLQpn3+Sz6DV2mjP1J5JtOKwlxZoN72mA==
X-Google-Smtp-Source: APiQypKHiE5Az9zHr0fOal+Vb2bnaZ/p4R80ljrDZQIZ9tskxL/Vyxr7vURNVeRJ8Wf2gb6jf1b0/3zhYawYInvV+sU=
X-Received: by 2002:ac8:1b6a:: with SMTP id p39mr21601887qtk.158.1587484832634;
 Tue, 21 Apr 2020 09:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200421131951.4948-1-penguin-kernel@I-love.SAKURA.ne.jp> <20200421131951.4948-3-penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20200421131951.4948-3-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 21 Apr 2020 18:00:21 +0200
Message-ID: <CACT4Y+a_k+AzPmUzU7a7atim5h-hrXzTdKTtqE9y2nGErt42zQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] twist: Add option for selecting twist options for
 syzkaller's testing
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 3:22 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> When a kernel developer adds a kernel config option, they will not go
> and update configs on all external testing systems. This problem is also
> common for "enable all boot tests that can run on this kernel", or
> "configure a 'standard' debug build". Currently doing these things
> require all of expertise, sacred knowledge, checking all configs
> one-by-one as well as checking every new kernel patch and that needs to
> be done by everybody doing any kernel testing.
>
> In order to reduce the burden of maintaining kernel config options, this
> patch introduces a kernel config option which will select twist options
> when building kernels for syzkaller's testing.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> ---
>  lib/Kconfig.twist | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/lib/Kconfig.twist b/lib/Kconfig.twist
> index a1d038bcc2a5..95020a56bbfc 100644
> --- a/lib/Kconfig.twist
> +++ b/lib/Kconfig.twist
> @@ -10,6 +10,12 @@ menuconfig TWIST_KERNEL_BEHAVIOR
>
>  if TWIST_KERNEL_BEHAVIOR
>
> +config TWIST_FOR_SYZKALLER_TESTING


One nice side effect of this is that this can replace
CONFIG_DEBUG_AID_FOR_SYZBOT, which we need to manually bolt and
carefully carry:
https://github.com/google/syzkaller/blob/master/dashboard/config/upstream-kasan.config#L12-L14
Since it's not defined in most kernel trees, any olddefconfig will wipe it out.
Having a config that we can enable that is "officially" in the kernel
will make it much less problematic. Then any custom debugging patches
can use TWIST_FOR_SYZKALLER_TESTING.





> +       bool "Select all twist options suitable for syzkaller testing"
> +       select TWIST_DISABLE_KBD_K_SPEC_HANDLER
> +       help
> +        Say N unless you are building kernels for syzkaller's testing.
> +
>  config TWIST_DISABLE_KBD_K_SPEC_HANDLER
>         bool "Disable k_spec() function in drivers/tty/vt/keyboard.c"
>         help
> --
> 2.18.2
>
