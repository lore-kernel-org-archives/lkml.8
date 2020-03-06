Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87E9C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD372072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zb4P5gXN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgCFROF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:14:05 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33691 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgCFROF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:14:05 -0500
Received: by mail-pg1-f195.google.com with SMTP id m5so1375562pgg.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 09:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CP2OVDyYeUQjbh/1nuCSOfSMlH1Bz55vOGR9t8SUcqE=;
        b=Zb4P5gXN1prnzjloUS4DQ0HPDzgguVvdcRh6yUnpOzJOW+wzrPOhKnrgRklnPijjw/
         JI5yCY/BPUJ19qLbdl6We5Ie1/LM7tzqYETNQBJ43u1V4agoe/KFDcH2iG+m0zs9Zj4u
         zbSqAZxm7S6EEmFyeiUYQN1p5gpmHeznZAm2GOY5GAuTPnroLeJZ/upW4tWlo2zlTzPm
         qCnn9KW8HsxxSnBJMae375C3geAcjDjtWed9KgChpsInFgUKkCEDeTnloKACEhAfYIqK
         uY3NJTF0XQRLnJh4f04qH6FuDU0ErRUds6Ht/qEI5x92Er1Vors/WhGz10v4LNodOscs
         DmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CP2OVDyYeUQjbh/1nuCSOfSMlH1Bz55vOGR9t8SUcqE=;
        b=Et1yxDfb+l0MGyf4DFpgJXmbBCFEqHHUK9aKPj2PJ5iXRLVoZDzc0YYCrw+ehHjpTR
         GH1ZaOiqf5DfaOg5rjDpiadlthiGscn6Wasey45yeK1kLgKnGeOS7rD0DSCmjM5r+dKM
         8K6sBwvbCTAmOtywcGaw1d3YgnyderRDxjN8sg9GivzwD+YH/VBqjggei4Y/BcgkQi2j
         dHGlZuEi3d7FcBw3YZLDddEzSwsuK/3i4pdK2ylPLwX/qnnZq/sYX0dv/3+DNBFMdxqp
         molfIDnEWPX8jy2pKkr3eaQFFIT59UZXrTFAilrb6exDfMj1/UJialfKmjFVoLz0QhyB
         ZKCQ==
X-Gm-Message-State: ANhLgQ35U1/59ynQwpvTf7lmgy0Yp6cnak/6Q/ppxfPJROD5Kv1Ucskj
        5vxenjiqci5tE6x/n11hlyISAQ/8Av/jE03xdryQDw==
X-Google-Smtp-Source: ADFU+vt62026JzE4XMp3FS9wR6W6QHP3YSjOcABDx4ZWbxeZtSzHZZhOjL5ePcLzk1jNyOXjg6CE+i1OweQB5j7kxCw=
X-Received: by 2002:a63:4d6:: with SMTP id 205mr4207108pge.10.1583514843107;
 Fri, 06 Mar 2020 09:14:03 -0800 (PST)
MIME-Version: 1.0
References: <1583509304-28508-1-git-send-email-cai@lca.pw>
In-Reply-To: <1583509304-28508-1-git-send-email-cai@lca.pw>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 6 Mar 2020 09:13:52 -0800
Message-ID: <CAKwvOd=V44ksbiffN5UYw-oVfTK_wdeP59ipWANkOUS_zavxew@mail.gmail.com>
Subject: Re: [PATCH] sched/cputime: silence a -Wunused-function warning
To:     Qian Cai <cai@lca.pw>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        bsegall@google.com, mgorman@suse.de,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 7:42 AM Qian Cai <cai@lca.pw> wrote:
>
> account_other_time() is only used when CONFIG_IRQ_TIME_ACCOUNTING=y (in
> irqtime_account_process_tick()) or CONFIG_VIRT_CPU_ACCOUNTING_GEN=y (in
> get_vtime_delta()). When both are off, it will generate a compilation
> warning from Clang,
>
> kernel/sched/cputime.c:255:19: warning: unused function
> 'account_other_time' [-Wunused-function]
> static inline u64 account_other_time(u64 max)
>
> Rather than wrapping around this function with a macro expression,
>
>  if defined(CONFIG_IRQ_TIME_ACCOUNTING) || \
>     defined(CONFIG_VIRT_CPU_ACCOUNTING_GEN)
>
> just use __maybe_unused for this small function which seems like a good
> trade-off.
>
> Signed-off-by: Qian Cai <cai@lca.pw>

Hi Qian, thanks for the patch!

Generally, I'm not a fan of __maybe_unused.  It is a tool in the
toolbox for solving this issue, but it's my least favorite.  Should
the call sites be eliminated, this may mask an unused and entirely
dead function from being removed.  Preprocessor guards based on config
give more context into *why* a particular function may be unused.

So let's take a look at the call sites of account_other_time().  Looks
like irqtime_account_process_tick() (guarded by
CONFIG_IRQ_TIME_ACCOUNTING) and get_vtime_delta() (guarded by
CONFIG_VIRT_CPU_ACCOUNTING_GEN).  If it were one config guard, then I
would prefer to move the definition to be within the same guard, just
before the function definition that calls it, but we have a more
complicated case here.

The next thing I'd check to see is if there's a dependency between
configs.  In this case, both CONFIG_IRQ_TIME_ACCOUNTING and
CONFIG_VIRT_CPU_ACCOUNTING_GEN are defined in init/Kconfig.  In this
case there's also no dependency between configs, so specifying one
doesn't imply the other; so guarding on one of the two configs is also
not an option.

So, as much as I'm not a fan of __maybe_unused, it is indeed the
simplest option.  Though, I'd still prefer the ifdef you describe
instead, maybe the maintainers can provide guidance/preference?
Otherwise,

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  kernel/sched/cputime.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index cff3e656566d..85da4d6dee24 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -252,7 +252,7 @@ static __always_inline u64 steal_account_process_time(u64 maxtime)
>  /*
>   * Account how much elapsed time was spent in steal, irq, or softirq time.
>   */
> -static inline u64 account_other_time(u64 max)
> +static inline __maybe_unused u64 account_other_time(u64 max)
>  {
>         u64 accounted;
>
> --

-- 
Thanks,
~Nick Desaulniers
