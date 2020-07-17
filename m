Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABC8C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 22:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC81620739
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 22:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YPU/L86u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgGQWkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 18:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgGQWkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 18:40:05 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A727FC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 15:40:05 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id r7so2460019vkf.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 15:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gA3W9/EKaokuj3jFwVb5OEfEmxf6jYHALcP6IdyTw1I=;
        b=YPU/L86uLVmNYa0mhJqzuT1kf9M8daLhh8Cgv07+W9/aDqUK0RQjf82G6ZPWfE7eZY
         YlDbWyF9ww1h7uDiZMrhIJMrIXUWa/cVZVuQdDo9T/omFFCVOX+rt7bXfZ8UhsCB+sMr
         WaYqdsxUpmWmdJ8eWYAjxEivq29Rtr6HjkF3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gA3W9/EKaokuj3jFwVb5OEfEmxf6jYHALcP6IdyTw1I=;
        b=L0xEHybtx8RaLJzugmG/rs0zs6ffy6GWDtyCEof74XU6oGPrZ6zDm1r9g0snf14T4R
         yLSf4zoCQHhKcaUFZ6YBmBLoTbSpUDPLDybs00oTc4UZPPfCPz1Or0mjrcw03AyWHYZT
         9Hyzr16k5NtxDdGrbxU6PUbtqpWojATGqwCVRQifFoB+gCKnWbdoqEmB2Z+vcmtiHsWX
         0lvgoVW54NHPxProf03zT7qPOBu0Ixy/l9cWg4GMp6P2RRVgxoUHYsJm2+iB2sNsE4FN
         gNTAKFErK+x98NbgsxT5V5FhnZWWS4rkSQEChIHDU8km6srrGRSIsq+pwwSNeemkWKYe
         WZKA==
X-Gm-Message-State: AOAM533JXGv6SYBryGvhX5H3LuftUPZajRZ5ql9mJPshWqdQ5tDa+tY9
        uqcEJnsB/Smr6vACX0eq65+9BVIX9Qo=
X-Google-Smtp-Source: ABdhPJyeo+VZ+n/ydvB/4Q3HZ1QfV02QM2GuJXch6KxUX5UWem3Lqjc9U3pJb5NPzDe6V7l9N2nPJA==
X-Received: by 2002:a1f:c946:: with SMTP id z67mr8790914vkf.85.1595025604486;
        Fri, 17 Jul 2020 15:40:04 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id l9sm1225369uaa.6.2020.07.17.15.40.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 15:40:04 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id q85so2454895vke.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 15:40:03 -0700 (PDT)
X-Received: by 2002:a1f:9d57:: with SMTP id g84mr9238455vke.100.1595025603034;
 Fri, 17 Jul 2020 15:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200716151943.2167652-1-daniel.thompson@linaro.org> <20200716151943.2167652-3-daniel.thompson@linaro.org>
In-Reply-To: <20200716151943.2167652-3-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 17 Jul 2020 15:39:51 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UDVjwy5=OiDCrMbn8o9N5GGMiG8JnL0j+9fy3m5Vf4Eg@mail.gmail.com>
Message-ID: <CAD=FV=UDVjwy5=OiDCrMbn8o9N5GGMiG8JnL0j+9fy3m5Vf4Eg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kgdb: Use the kprobe blocklist to limit single stepping
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Will Deacon <will@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 16, 2020 at 8:20 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> If we are running in a part of the kernel that dislikes breakpoint
> debugging then it is very unlikely to be safe to single step. Add
> some safety rails to prevent stepping through anything on the kprobe
> blocklist.
>
> As part of this kdb_ss() will no longer set the DOING_SS flags when it
> requests a step. This is safe because this flag is already redundant,
> returning KDB_CMD_SS is all that is needed to request a step (and this
> saves us from having to unset the flag if the safety check fails).
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  include/linux/kgdb.h        |  1 +
>  kernel/debug/debug_core.c   | 13 +++++++++++++
>  kernel/debug/gdbstub.c      | 10 +++++++++-
>  kernel/debug/kdb/kdb_bp.c   |  8 ++------
>  kernel/debug/kdb/kdb_main.c | 10 ++++++++--
>  5 files changed, 33 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index 7caba4604edc..aefe823998cb 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -214,6 +214,7 @@ extern void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc);
>
>  /* Optional functions. */
>  extern int kgdb_validate_break_address(unsigned long addr);
> +extern int kgdb_validate_single_step_address(unsigned long addr);
>  extern int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt);
>  extern int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt);
>
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 133a361578dc..4b59bcc90c5d 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -208,6 +208,19 @@ int __weak kgdb_validate_break_address(unsigned long addr)
>         return err;
>  }
>
> +int __weak kgdb_validate_single_step_address(unsigned long addr)
> +{
> +       /*
> +        * Disallow stepping when we are executing code that is marked
> +        * as unsuitable for breakpointing... stepping won't be safe
> +        * either!
> +        */
> +       if (kgdb_within_blocklist(addr))
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
>  unsigned long __weak kgdb_arch_pc(int exception, struct pt_regs *regs)
>  {
>         return instruction_pointer(regs);
> diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
> index 61774aec46b4..f1c88007cc2b 100644
> --- a/kernel/debug/gdbstub.c
> +++ b/kernel/debug/gdbstub.c
> @@ -1041,8 +1041,16 @@ int gdb_serial_stub(struct kgdb_state *ks)
>                         if (tmp == 0)
>                                 break;
>                         /* Fall through - on tmp < 0 */
> -               case 'c': /* Continue packet */
>                 case 's': /* Single step packet */
> +                       error = kgdb_validate_single_step_address(
> +                                       kgdb_arch_pc(ks->ex_vector,
> +                                                    ks->linux_regs));

I'm a little confused.  Isn't this like saying "if
(i_am_standing_in_acid) dont_step_into_acid"?

Specifically you're checking the _current_ PC to see if it's in the
blocklist, right?  ...but you've already (effectively) dropped into
the debugger at that location, so if it really was a problem wouldn't
we already be in trouble?

What you really want (I think?) is to know if the instruction that
you're stepping into is in the blocklist, right?  ...but you can't
know that because it requires a full instruction emulator (that's why
CPUs have "single step mode").

I guess you get a marginal benefit if someone manually set their
instruction pointer to be an address in the middle of a blocklisted
function and then trying to step, but I'm not sure that's really
something we need to add code for?

It feels like the right solution is that the architecture-specific
single-step code should simply consider a single-step through a
blocklisted area to be a step through one giant instruction.


> +                       if (error != 0) {
> +                               error_packet(remcom_out_buffer, error);
> +                               break;
> +                       }
> +                       fallthrough;
> +               case 'c': /* Continue packet */
>                         if (kgdb_contthread && kgdb_contthread != current) {
>                                 /* Can't switch threads in kgdb */
>                                 error_packet(remcom_out_buffer, -EINVAL);
> diff --git a/kernel/debug/kdb/kdb_bp.c b/kernel/debug/kdb/kdb_bp.c
> index ec4940146612..4853c413f579 100644
> --- a/kernel/debug/kdb/kdb_bp.c
> +++ b/kernel/debug/kdb/kdb_bp.c
> @@ -507,18 +507,14 @@ static int kdb_bc(int argc, const char **argv)
>   *     None.
>   * Remarks:
>   *
> - *     Set the arch specific option to trigger a debug trap after the next
> - *     instruction.
> + *     KDB_CMD_SS is a command that our caller acts on to effect the step.
>   */
>
>  static int kdb_ss(int argc, const char **argv)
>  {
>         if (argc != 0)
>                 return KDB_ARGCOUNT;
> -       /*
> -        * Set trace flag and go.
> -        */
> -       KDB_STATE_SET(DOING_SS);
> +
>         return KDB_CMD_SS;
>  }
>
> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 5c7949061671..cd40bf780b93 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -1189,7 +1189,7 @@ static int kdb_local(kdb_reason_t reason, int error, struct pt_regs *regs,
>                      kdb_dbtrap_t db_result)
>  {
>         char *cmdbuf;
> -       int diag;
> +       int diag, res;
>         struct task_struct *kdb_current =
>                 kdb_curr_task(raw_smp_processor_id());
>
> @@ -1346,10 +1346,16 @@ static int kdb_local(kdb_reason_t reason, int error, struct pt_regs *regs,
>                 }
>                 if (diag == KDB_CMD_GO
>                  || diag == KDB_CMD_CPU
> -                || diag == KDB_CMD_SS
>                  || diag == KDB_CMD_KGDB)
>                         break;
>
> +               if (diag == KDB_CMD_SS) {
> +                       res = kgdb_validate_single_step_address(instruction_pointer(regs));

Is it legit to use instruction_pointer() directly?  Should you be
calling kgdb_arch_pc()  ...or does that just account for having just
hit a breakpoint?
