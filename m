Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2A6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 13:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCBEA2068D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 13:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="GnCtndUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgEZNim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 09:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731434AbgEZNie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 09:38:34 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243DEC03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 06:38:34 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id m67so8281105oif.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 06:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O/mpBidl5KzS3rb4PN7X5hauHHU7Bj8b6nZgC1/NWhk=;
        b=GnCtndUVy9LXPImyl75neJ+jKPenDwGSBzI5wi9Oupoa71QJYg66ApHZlHdNhNqlgy
         73fUpZKffs4nxyLXWo4AcoQ7TaKyZfB3C1YRnqj23bBTLf4ZIjr9IAoEZaVOhefzcw5V
         4Nr1gfDuDReGGRjR2a4ug8DRBr82VyLb6aBLMegD2COiYcLyJrzPxVENMC1icbLN2gnF
         Yyk7GFG5TOmV1hv6DdJtjdn0cgKHCEYGGfgNkhTcQ5ILYtzXfPvauig/hRpTL+x8Gn72
         rzYvRjHYasBDGYGGMgrsXf7GxZDjm02lD21vi35teUx/hom9swlx7xtb/R5F1dRF1CnM
         tyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O/mpBidl5KzS3rb4PN7X5hauHHU7Bj8b6nZgC1/NWhk=;
        b=pJAJvRN/LfeDw23ZKtPNIQKHFXSEEeYJ6ZUEDTs6gwLeBB7imqLM4Ho5YaFO603PzY
         zGyWAquoDZIE6OGO+mXSLV7J6hpxDsQTCcbuNBcKv3k30pnBGJ3+ewZ81Orx4oouaaJP
         J8xjrJVPhXs1YS+4K3cJvLW2B8z/wUCYlHGlJVOamSxdoV2pJHMvXxJoKCOtxvoQHRj5
         eKvise0YDUJVdcaYG5ny5UcanJD9fTtQvDPjsQvqqxsv1JEUCdO89Yv9KN3GcP9UVAaS
         NiPjY4HtBVvvoOqr9vP+VWXrLAKS+xrJBFc3JDCjuGzOHDGI4EFtkJKy81zCfKmnAqge
         Epnw==
X-Gm-Message-State: AOAM5304fewVvwkr/7kjPcut25QLRTKKeCNdQbxcWi4TDXi8FZF3TVOt
        yZpK9aSbbbAmszxxiM6Cc5/zmw==
X-Google-Smtp-Source: ABdhPJzM4bXY4Fn1US8uCCmfKrf9dXlosFeANunbNktVL8MAc+7u6vkcJU24xkN0MejT4xOOpe0qwA==
X-Received: by 2002:aca:4f4b:: with SMTP id d72mr14274781oib.68.1590500313445;
        Tue, 26 May 2020 06:38:33 -0700 (PDT)
Received: from cisco ([2601:282:b02:8120:e9d7:5ec6:88ea:b4a1])
        by smtp.gmail.com with ESMTPSA id g13sm3306oop.31.2020.05.26.06.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 06:38:32 -0700 (PDT)
Date:   Tue, 26 May 2020 07:38:30 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Guo Ren <guoren@kernel.org>
Cc:     keescook@chromium.org, palmerdabbelt@google.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: Remove unnecessary path for syscall_trace
Message-ID: <20200526133830.GO2605652@cisco>
References: <1590416306-66453-1-git-send-email-guoren@kernel.org>
 <20200525143648.GM2605652@cisco>
 <CAJF2gTS4gM39KWuksRRT9ONPhbhYuN9r1oOP_qRT8KvDga4vyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTS4gM39KWuksRRT9ONPhbhYuN9r1oOP_qRT8KvDga4vyA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 08:29:45AM +0800, Guo Ren wrote:
> Hi Tycho,
> 
> On Mon, May 25, 2020 at 10:36 PM Tycho Andersen <tycho@tycho.ws> wrote:
> >
> > On Mon, May 25, 2020 at 02:18:26PM +0000, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > Obviously, there is no need to recover a0-a7 in reject path.
> > >
> > > Previous modification is from commit af33d243 by Tycho, to
> > > fixup seccomp reject syscall code path.
> >
> > Doesn't this suffer from the same problem, though? a7 is clobbered, so
> > the -ERESTARTSYS behavior won't work?
> 
> Look, the patch only affects the path of ret_from_syscall_rejected,
> and there are two possible paths:
> 1. ret_from_syscall_rejected->handle_syscall_trace_exit->ret_from_exception
> 2. ret_from_syscall_rejected->ret_from_exception
> 
> All the above skip the check_syscall_nr and ignore the current a7, in
> the C function they use the pt_regs in the stack to get proper reg's
> value.
> 
> For the -ERESTARTSYS, we only process it in:
> ret_from_exception->resume_userspace->work_notifysig->do_notify_resume:
> do_signal & handle_signal:
> 
>                 switch (regs->a0) {
>                 case -ERESTARTNOHAND:
>                 case -ERESTARTSYS:
>                 case -ERESTARTNOINTR:
>                         regs->a0 = regs->orig_a0;
>                         regs->epc -= 0x4;
>                         break;
> 
> All above are done in pt_regs and when returning to userspace, a7 will
> be recovered by restore_all in entry.S.

Yes, thanks for that explanation.

Reviewed-by: Tycho Andersen <tycho@tycho.ws>
