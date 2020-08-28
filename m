Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056A8C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 12:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E5E2078A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 12:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598618099;
	bh=+ZC7vfEqt3vatoNYBNCOkUx0FbTQCSqA61BSY3oIaYI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oT8hEqGDxsW+z/tqtncsbfep8g3xeQpem/7glMyTNJwbSEzCaXdfLFSvMMmufAaqx
	 AJoRh8AE/g10uJ8WHLMY+W76ZxS1pN2+v0v3SUpzgfunci9RHgaV5Oyt/M7BA0qLl+
	 CMWgtg9td8StJTUuiPPhQXwLJTD9//QVOrZPZjjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbgH1Me4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:34:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729123AbgH1Meg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 08:34:36 -0400
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B44FD21556;
        Fri, 28 Aug 2020 12:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598618076;
        bh=+ZC7vfEqt3vatoNYBNCOkUx0FbTQCSqA61BSY3oIaYI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MP54G526OTSuUO0SMqEa41is5mB4meDtVm4ATTrscGCJ/0z90lrJGLApoqnNqFmKp
         affosG+UNDAWfRzc9IGvtCNGIk6ijYdHFlKs6YfP8A3GA2h9obQAWHUWKHARzyi/rM
         HQuYy4+FDdst0V8uP5kkQfFbeRySb3sLvgPHcRlU=
Received: by mail-lf1-f51.google.com with SMTP id y17so620765lfa.8;
        Fri, 28 Aug 2020 05:34:35 -0700 (PDT)
X-Gm-Message-State: AOAM532NWYPg0s483yyxWZJsTiX0q0+ffmr4yKOlY1GFrUktAFs0d6rg
        RYMc1xJvo/prbxaAlkmZghwOYHXB7r+Dy9Z0rBM=
X-Google-Smtp-Source: ABdhPJwPtXOMRGNu43110Ft0LpuiT1efN8BBGxHEgNOP5buSs9W1RComAIOA+C5bZ6vYzpGzogRfDZyoAT9knSKwSgY=
X-Received: by 2002:ac2:4ecc:: with SMTP id p12mr713259lfr.212.1598618073917;
 Fri, 28 Aug 2020 05:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <159854631442.736475.5062989489155389472.stgit@devnote2> <159854636764.736475.9112286781925119117.stgit@devnote2>
In-Reply-To: <159854636764.736475.9112286781925119117.stgit@devnote2>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 28 Aug 2020 20:34:22 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR5z87fb4ieOcrnMNT6GxSAhj99cf7draGVaHnk7G-pCQ@mail.gmail.com>
Message-ID: <CAJF2gTR5z87fb4ieOcrnMNT6GxSAhj99cf7draGVaHnk7G-pCQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/16] csky: kprobes: Use generic kretprobe trampoline handler
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Eddy Wu <Eddy_Wu@trendmicro.com>, x86@kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks more clear.

Acked-by: Guo Ren <guoren@kernel.org>

On Fri, Aug 28, 2020 at 12:39 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/csky/kernel/probes/kprobes.c |   78 +------------------------------------
>  1 file changed, 3 insertions(+), 75 deletions(-)
>
> diff --git a/arch/csky/kernel/probes/kprobes.c b/arch/csky/kernel/probes/kprobes.c
> index f0f733b7ac5a..a891fb422e76 100644
> --- a/arch/csky/kernel/probes/kprobes.c
> +++ b/arch/csky/kernel/probes/kprobes.c
> @@ -404,87 +404,15 @@ int __init arch_populate_kprobe_blacklist(void)
>
>  void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
>  {
> -       struct kretprobe_instance *ri = NULL;
> -       struct hlist_head *head, empty_rp;
> -       struct hlist_node *tmp;
> -       unsigned long flags, orig_ret_address = 0;
> -       unsigned long trampoline_address =
> -               (unsigned long)&kretprobe_trampoline;
> -       kprobe_opcode_t *correct_ret_addr = NULL;
> -
> -       INIT_HLIST_HEAD(&empty_rp);
> -       kretprobe_hash_lock(current, &head, &flags);
> -
> -       /*
> -        * It is possible to have multiple instances associated with a given
> -        * task either because multiple functions in the call path have
> -        * return probes installed on them, and/or more than one
> -        * return probe was registered for a target function.
> -        *
> -        * We can handle this because:
> -        *     - instances are always pushed into the head of the list
> -        *     - when multiple return probes are registered for the same
> -        *       function, the (chronologically) first instance's ret_addr
> -        *       will be the real return address, and all the rest will
> -        *       point to kretprobe_trampoline.
> -        */
> -       hlist_for_each_entry_safe(ri, tmp, head, hlist) {
> -               if (ri->task != current)
> -                       /* another task is sharing our hash bucket */
> -                       continue;
> -
> -               orig_ret_address = (unsigned long)ri->ret_addr;
> -
> -               if (orig_ret_address != trampoline_address)
> -                       /*
> -                        * This is the real return address. Any other
> -                        * instances associated with this task are for
> -                        * other calls deeper on the call stack
> -                        */
> -                       break;
> -       }
> -
> -       kretprobe_assert(ri, orig_ret_address, trampoline_address);
> -
> -       correct_ret_addr = ri->ret_addr;
> -       hlist_for_each_entry_safe(ri, tmp, head, hlist) {
> -               if (ri->task != current)
> -                       /* another task is sharing our hash bucket */
> -                       continue;
> -
> -               orig_ret_address = (unsigned long)ri->ret_addr;
> -               if (ri->rp && ri->rp->handler) {
> -                       __this_cpu_write(current_kprobe, &ri->rp->kp);
> -                       get_kprobe_ctlblk()->kprobe_status = KPROBE_HIT_ACTIVE;
> -                       ri->ret_addr = correct_ret_addr;
> -                       ri->rp->handler(ri, regs);
> -                       __this_cpu_write(current_kprobe, NULL);
> -               }
> -
> -               recycle_rp_inst(ri, &empty_rp);
> -
> -               if (orig_ret_address != trampoline_address)
> -                       /*
> -                        * This is the real return address. Any other
> -                        * instances associated with this task are for
> -                        * other calls deeper on the call stack
> -                        */
> -                       break;
> -       }
> -
> -       kretprobe_hash_unlock(current, &flags);
> -
> -       hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
> -               hlist_del(&ri->hlist);
> -               kfree(ri);
> -       }
> -       return (void *)orig_ret_address;
> +       return (void *)kretprobe_trampoline_handler(regs,
> +                       (unsigned long)&kretprobe_trampoline, NULL);
>  }
>
>  void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
>                                       struct pt_regs *regs)
>  {
>         ri->ret_addr = (kprobe_opcode_t *)regs->lr;
> +       ri->fp = NULL;
>         regs->lr = (unsigned long) &kretprobe_trampoline;
>  }
>
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
